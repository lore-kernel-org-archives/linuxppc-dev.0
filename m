Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F3AB1007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 07:29:38 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2EKJcc4019305
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:19:38 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AFD056E8039
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:35 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EKTZ4g2187302
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EKTZdt018964
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 17:29:35 -0300
Subject: [PATCH v3 2/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Mar 2011 15:29:34 -0500
Message-ID: <1300134574.803.15.camel@flin.austin.ibm.com>
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

Change log from V2:
- Change the log name from error log to event log.
- Change function name from pseries_elog_find_section() to
  pseries_elog_find_sect_data().

Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig             |    5 ++
 arch/powerpc/platforms/pseries/Makefile            |    1 +
 arch/powerpc/platforms/pseries/pseries_event_log.c |   61 ++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries_event_log.h |   50 ++++++++++++++++
 4 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5b3da4b..98e5e39 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -47,6 +47,11 @@ config SCANLOG
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
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fc52378..07bbf75 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
 obj-$(CONFIG_PHYP_DUMP)		+= phyp_dump.o
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
+obj-$(CONFIG_PSERIES_EVENT_LOG)	+= pseries_event_log.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/platforms/pseries/pseries_event_log.c b/arch/powerpc/platforms/pseries/pseries_event_log.c
new file mode 100644
index 0000000..36ad8a1
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_event_log.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright 2010, 2011 Tseng-Hui (Frank) Lin, IBM Corporation
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
+ * Find the size of the data portation of a platform event log section.
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
+ * Find data portion of a specific section in RTAS extended event log.
+ * Return:
+ *	pointer to the section data of the specified section
+ *	NULL if not found
+ */
+void *pseries_elog_find_sect_data(struct rtas_ext_event_log_v6 *v6ext,
+				  size_t v6ext_len, uint16_t sect_id)
+{
+	struct pseries_elog_section *sect_p;
+	uint8_t *p, *log_end;
+
+	if ((v6ext_len < sizeof(struct rtas_ext_event_log_v6)) ||
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
index 0000000..879f2ed
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_event_log.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2010, 2011 Tseng-Hui (Frank) Lin, IBM Corporation
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
+/* Vendor specific Platform Event Log Format, Version 6, section header */
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
+size_t pseries_elog_sect_data_len(void *sect_data_p);
+void *pseries_elog_find_sect_data(struct rtas_ext_event_log_v6 *v6ext,
+				  size_t v6ext_len, uint16_t sect_id);
+
+#endif /* _PSERIES_PSERIES_EVENT_LOG_H */
