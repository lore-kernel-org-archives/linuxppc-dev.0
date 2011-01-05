Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A46DB712B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Jan 2011 09:44:44 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p05MVVmt015578
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:31:31 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p05Mie5N237106
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:44:40 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p05Mid5j026323
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:44:39 -0700
Subject: [PATCH v2 2/3] powerpc: add IBM specific v6 extended error log support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Jan 2011 16:44:38 -0600
Message-ID: <1294267478.24377.29.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch adds IBM specific v6 extended log definition and utilities.

Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig             |    6 +
 arch/powerpc/platforms/pseries/Makefile            |    1 +
 arch/powerpc/platforms/pseries/pseries_event_log.c |   62 +++++
 arch/powerpc/platforms/pseries/pseries_event_log.h |   50 ++++
 4 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index c667f0f..6f29642 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -37,6 +37,11 @@ config SCANLOG
 	tristate "Scanlog dump interface"
 	depends on RTAS_PROC && PPC_PSERIES
 
+config PSERIES_EVENT_LOG
+	bool
+	depends on PPC_PSERIES && RTAS_ERROR_LOGGING
+	default n
+
 config LPARCFG
 	bool "LPAR Configuration Data"
 	depends on PPC_PSERIES || PPC_ISERIES
@@ -81,3 +86,4 @@ config DTL
 	  which are accessible through a debugfs file.
 
 	  Say N if you are unsure.
+
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 046ace9..1cc20ba 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
 obj-$(CONFIG_PHYP_DUMP)	+= phyp_dump.o
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
+obj-$(CONFIG_PSERIES_EVENT_LOG)	+= pseries_event_log.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/platforms/pseries/pseries_event_log.c b/arch/powerpc/platforms/pseries/pseries_event_log.c
new file mode 100644
index 0000000..c00837d
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_event_log.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2010 Tseng-Hui (Frank) Lin, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * IBM pSerie platform event log specific functions.
+ * All data in this file is in big endian.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/rtas.h>
+
+#include "pseries_event_log.h"
+
+/*
+ * Find the size of data portation in a platform event log section.
+ */
+size_t pseries_elog_sect_data_len(void *sect_data_p)
+{
+	struct pseries_elog_section *p;
+
+	p = container_of(sect_data_p, struct pseries_elog_section, sect_data);
+	return(p->length - offsetof(struct pseries_elog_section, sect_data));
+}
+
+/*
+ * Find data portion of a specific section in extended error/event log.
+ * Return:
+ *	location of section data
+ *	NULL if not found
+ */
+void *pseries_elog_find_section(
+		struct rtas_error_log_v6ext *v6ext, size_t v6ext_len,
+		uint16_t sect_id)
+{
+	struct pseries_elog_section *sect_p;
+	uint8_t *p, *log_end;
+
+	if ((v6ext_len < sizeof(struct rtas_error_log_v6ext)) ||
+	    (v6ext->log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG) ||
+	    (v6ext->company_id != RTAS_V6EXT_COMPANY_ID_IBM))
+		return NULL;
+
+	log_end = (uint8_t *) v6ext + v6ext_len;
+	p = (uint8_t *) v6ext->vendor_log;
+	while (p < log_end) {
+		sect_p = (struct pseries_elog_section *) p;
+		if (sect_p->id == sect_id)
+			return sect_p->sect_data;
+		p += sect_p->length;
+	}
+
+	return NULL;
+}
+
diff --git a/arch/powerpc/platforms/pseries/pseries_event_log.h b/arch/powerpc/platforms/pseries/pseries_event_log.h
new file mode 100644
index 0000000..e7fc452
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_event_log.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2010 Tseng-Hui (Frank) Lin, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _PSERIES_PSERIES_EVENT_LOG_H
+#define _PSERIES_PSERIES_EVENT_LOG_H
+
+#include <linux/types.h>
+
+#include <asm/rtas.h>
+
+/* Two bytes ASCII section IDs */
+#define PSERIES_ELOG_SECT_ID_PRIV_HDR		(('P' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_USER_HDR		(('U' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_PRIMARY_SRC	(('P' << 8) | 'S')
+#define PSERIES_ELOG_SECT_ID_EXTENDED_UH	(('E' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_FAILING_MTMS	(('M' << 8) | 'T')
+#define PSERIES_ELOG_SECT_ID_SECONDARY_SRC	(('S' << 8) | 'S')
+#define PSERIES_ELOG_SECT_ID_DUMP_LOCATOR	(('D' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_FW_ERROR		(('S' << 8) | 'W')
+#define PSERIES_ELOG_SECT_ID_IMPACT_PART_ID	(('L' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_LOGIC_RESOURCE_ID	(('L' << 8) | 'R')
+#define PSERIES_ELOG_SECT_ID_HMC_ID		(('H' << 8) | 'M')
+#define PSERIES_ELOG_SECT_ID_EPOW		(('E' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_IO_EVENT		(('I' << 8) | 'E')
+#define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
+#define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
+
+/* Vendor specific Platform Error/Event Log Format, Version 6, section header */
+
+struct pseries_elog_section {
+	uint16_t id;			/* 0x00 2-byte ASCII section ID	*/
+	uint16_t length;		/* 0x02 Section length in bytes	*/
+	uint8_t version;		/* 0x04 Section version		*/
+	uint8_t subtype;		/* 0x05 Section subtype		*/
+	uint16_t creator_component;	/* 0x06 Creator component ID	*/
+	uint8_t sect_data[1];		/* 0x08 Start of section data	*/
+};
+
+size_t pseries_elog_sect_data_len(void *sect_data);
+void *pseries_elog_find_section(struct rtas_error_log_v6ext *v6ext,
+	size_t v6ext_len, uint16_t sect_id);
+
+#endif /* _PSERIES_PSERIES_EVENT_LOG_H */
