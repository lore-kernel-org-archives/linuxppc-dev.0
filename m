Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405yv80RCWzF1qs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 05:26:59 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LIPSac059829
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:26:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2guvms83ed-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:26:56 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 14:26:55 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [RFC v2 2/4] powerpc/hotplug/drcinfo: Provide common parser for
 ibm,drc-info
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9ed45428-fdad-a945-55df-3d47959204fb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 13:26:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <f97e90d3-d4d8-71ce-ab05-d9171f55a456@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides a common parse function for the ibm,drc-info
property that can be modified by a callback function.  The caller
provides a pointer to the function and a pointer to their unique
data, and the parser provides the current lmb set from the struct.
The callback function may return codes indicating that the parsing
is complete, or should continue, along with an error code that may
be returned to the caller.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmwar
e feature" -- end of patch series applied to powerpc next)
---
Changes in V2:
  -- Update code to account for v4.16 kernel checkins.
---
 arch/powerpc/include/asm/prom.h             |    7 +++
 arch/powerpc/platforms/pseries/Makefile     |    2 -
 arch/powerpc/platforms/pseries/drchelpers.c |   66 +++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/pseries/drchelpers.c

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index b04c5ce..2e947b3 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -94,6 +94,13 @@ struct of_drc_info {
 extern int of_read_drc_info_cell(struct property **prop,
 			const __be32 **curval, struct of_drc_info *data);
 
+extern int drc_info_parser(struct device_node *dn,
+			int (*usercb)(struct of_drc_info *drc,
+					void *data,
+					void *optional_data,
+					int *ret_code),
+			char *opt_drc_type,
+			void *data);
 
 /*
  * There are two methods for telling firmware what our capabilities are.
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 13eede6..38c8547 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_PPC64)			:= $(NO_MINIMAL_TOC)
 ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
-			   of_helpers.o \
+			   of_helpers.o drchelpers.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o \
 			   pci.o pci_dlpar.o eeh_pseries.o msi.o
diff --git a/arch/powerpc/platforms/pseries/drchelpers.c b/arch/powerpc/platforms/pseries/drchelpers.c
new file mode 100644
index 0000000..556e05d
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/drchelpers.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2018 Michael Bringmann <mbringm@us.ibm.com>, IBM
+ *
+ * pSeries specific routines for device-tree properties.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *    
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/prom.h>
+#include "pseries.h"
+
+#define	MAX_DRC_NAME_LEN 64
+
+int drc_info_parser(struct device_node *dn,
+		int (*usercb)(struct of_drc_info *drc,
+				void *data,
+				void *optional_data,
+				int *ret_code),
+		char *opt_drc_type,
+		void *data)
+{
+	struct property *info;
+	unsigned int entries;
+	struct of_drc_info drc;
+	const __be32 *value;
+	int j, done = 0, ret_code = -EINVAL;
+
+	info = of_find_property(dn, "ibm,drc-info", NULL);
+	if (info == NULL)
+		return -EINVAL;
+
+	value = of_prop_next_u32(info, NULL, &entries);
+	if (!value)
+		return -EINVAL;
+	value++;
+
+	for (j = 0, done = 0; (j < entries) && (!done); j++) {
+		of_read_drc_info_cell(&info, &value, &drc);
+
+		if (opt_drc_type && strcmp(opt_drc_type, drc.drc_type))
+			continue;
+
+		done = usercb(&drc, data, NULL, &ret_code);
+	}
+
+	return ret_code;
+}
+EXPORT_SYMBOL(drc_info_parser);
