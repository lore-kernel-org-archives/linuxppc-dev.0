Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E57C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 22:46:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842BB20659
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 22:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGCfanEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842BB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vq364pQ3zF1Nj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 09:46:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGCfanEY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGCfanEY"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vq0K6Y7zzDsN0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 09:44:17 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id f18-v6so3191479pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=15qMBgA0Tf7BeQ7Plu1O3swu94GZd7L3VoIkZu/MErI=;
 b=hGCfanEYV6x2+IdTpEURncaDiXkelPo4Wb+lKMDYhg35+Km1kTJD1S/2LIGkk0LaHx
 n+dInITIca0y0oore9DBmzl4YBJgEtVbhr+iBCD9Gd0n4reh4+Ge7kZO7B6JNbUteMaM
 LenYm2JNGK+zFYUpiV0C/pESiM8Cxem7pK1bDkUtZ66DHg1IJm4O2ODdGJUckVlXSZjI
 y4PEQmgVy/kRGbh3zFbCB0cFqC2KAjJmkqVm8fhUAbeV25kaFdAfKXdw8MafhlG8A1K7
 wwrARCKmInUcMDlwJuw8yCNykkOt1++NcYFgjSC2tm3gR6+XygGiXRwS5vhN/EYPGDL0
 jwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=15qMBgA0Tf7BeQ7Plu1O3swu94GZd7L3VoIkZu/MErI=;
 b=a8gfw4sPLdnl3k+ReTlohNpTLlz+b8mHrEFborQPt1zlEDLUHigh29wWFKZrzhgkHZ
 QxxlzM1jdT630b3eXLZ3HnxhJosU1v6upJeS7q2E87O968rJcDT+xQIH5wwe050Q9aim
 SfEBKDDm9vL29F04r98RYiz0ybNerPC76qt5rpbvKyHkFUxEFCb23VuFsu4bu0y0F80p
 8OLOL/7GoDS53Xe0opy0fUgqp8uloGk7kr6/I7otmfoCqPkB0CS7N9x1jxxKn3Q4u8tB
 VhWExeQTUwzUiYPRIrSxoDc/gU1QjrpYzRtqyJmLx9xTPK06kZ+9h+kIls9XBbzcXS2o
 hJ4A==
X-Gm-Message-State: ABuFfoh6sP7ISxQ7cHrVShh19l8HaIBsvioxr5SeCrnR32NjoPoSblpO
 tZRSV1oy9Hblcel97GwIV7EotQah
X-Google-Smtp-Source: ACcGV60W9RxtkxSaCdg7QFpz4i/GCwaxxtpoV36iZ0IGH2l1MdaMUytxRC4V0y5lgs0c9m0p1ylDEw==
X-Received: by 2002:a63:69c9:: with SMTP id
 e192-v6mr18509818pgc.143.1539211455478; 
 Wed, 10 Oct 2018 15:44:15 -0700 (PDT)
Received: from localhost.localdomain (110-175-105-191.tpgi.com.au.
 [110.175.105.191])
 by smtp.gmail.com with ESMTPSA id z4-v6sm29526847pgs.50.2018.10.10.15.44.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Oct 2018 15:44:14 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc/pseries: PAPR persistent memory support
Date: Thu, 11 Oct 2018 09:43:54 +1100
Message-Id: <20181010224355.10475-1-oohall@gmail.com>
X-Mailer: git-send-email 2.9.5
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: nfont@linux.vnet.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch implements support for discovering storage class memory
devices at boot and for handling hotplug of new regions via RTAS
hotplug events.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Added missing pmem.c file
---
 arch/powerpc/include/asm/firmware.h       |   3 +-
 arch/powerpc/include/asm/hvcall.h         |  10 +-
 arch/powerpc/include/asm/rtas.h           |   2 +
 arch/powerpc/kernel/rtasd.c               |   2 +
 arch/powerpc/platforms/pseries/Makefile   |   2 +-
 arch/powerpc/platforms/pseries/dlpar.c    |   4 +
 arch/powerpc/platforms/pseries/firmware.c |   1 +
 arch/powerpc/platforms/pseries/pmem.c     | 164 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h  |   5 +
 arch/powerpc/platforms/pseries/ras.c      |   3 +-
 10 files changed, 192 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/pmem.c

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 7a051bd21f87..113c64d5d394 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -52,6 +52,7 @@
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
 #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
 #define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
+#define FW_FEATURE_PAPR_SCM 	ASM_CONST(0x0000001000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -69,7 +70,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
 		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
-		FW_FEATURE_DRC_INFO,
+		FW_FEATURE_DRC_INFO | FW_FEATURE_PAPR_SCM,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a0b17f9f1ea4..0e81ef83b35a 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -295,7 +295,15 @@
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
-#define MAX_HCALL_OPCODE	H_INT_RESET
+#define H_SCM_READ_METADATA     0x3E4
+#define H_SCM_WRITE_METADATA    0x3E8
+#define H_SCM_BIND_MEM          0x3EC
+#define H_SCM_UNBIND_MEM        0x3F0
+#define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
+#define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
+#define H_SCM_MEM_QUERY	        0x3FC
+#define H_SCM_BLOCK_CLEAR       0x400
+#define MAX_HCALL_OPCODE	H_SCM_BLOCK_CLEAR
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 71e393c46a49..1e81f3d55457 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -125,6 +125,7 @@ struct rtas_suspend_me_data {
 #define RTAS_TYPE_INFO			0xE2
 #define RTAS_TYPE_DEALLOC		0xE3
 #define RTAS_TYPE_DUMP			0xE4
+#define RTAS_TYPE_HOTPLUG		0xE5
 /* I don't add PowerMGM events right now, this is a different topic */ 
 #define RTAS_TYPE_PMGM_POWER_SW_ON	0x60
 #define RTAS_TYPE_PMGM_POWER_SW_OFF	0x61
@@ -316,6 +317,7 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_RESOURCE_MEM	2
 #define PSERIES_HP_ELOG_RESOURCE_SLOT	3
 #define PSERIES_HP_ELOG_RESOURCE_PHB	4
+#define PSERIES_HP_ELOG_RESOURCE_PMEM   6
 
 #define PSERIES_HP_ELOG_ACTION_ADD	1
 #define PSERIES_HP_ELOG_ACTION_REMOVE	2
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 6fafc82c04b0..fad0baddfcba 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -91,6 +91,8 @@ static char *rtas_event_type(int type)
 			return "Dump Notification Event";
 		case RTAS_TYPE_PRRN:
 			return "Platform Resource Reassignment Event";
+		case RTAS_TYPE_HOTPLUG:
+			return "Hotplug Event";
 	}
 
 	return rtas_type[0];
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 7e89d5c47068..892b27ced973 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
-obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
+obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o pmem.o
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..795996fefdb9 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -357,6 +357,10 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_RESOURCE_CPU:
 		rc = dlpar_cpu(hp_elog);
 		break;
+	case PSERIES_HP_ELOG_RESOURCE_PMEM:
+		rc = dlpar_hp_pmem(hp_elog);
+		break;
+
 	default:
 		pr_warn_ratelimited("Invalid resource (%d) specified\n",
 				    hp_elog->resource);
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index a3bbeb43689e..4927de57d8ee 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
 	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
 	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
 	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
+	{FW_FEATURE_PAPR_SCM,		"hcall-scm"},
 };
 
 /* Build up the firmware features bitmask using the contents of
diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
new file mode 100644
index 000000000000..a27f40eb57b1
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Handles hot and cold plug of persistent memory regions on pseries.
+ */
+
+#define pr_fmt(fmt)     "pseries-pmem: " fmt
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/sched.h>	/* for idle_task_exit */
+#include <linux/sched/hotplug.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/firmware.h>
+#include <asm/machdep.h>
+#include <asm/vdso_datapage.h>
+#include <asm/plpar_wrappers.h>
+#include <asm/topology.h>
+
+#include "pseries.h"
+#include "offline_states.h"
+
+static struct device_node *pmem_node;
+
+static ssize_t pmem_drc_add_node(u32 drc_index)
+{
+	struct device_node *dn;
+	int rc;
+
+	pr_debug("Attempting to add pmem node, drc index: %x\n", drc_index);
+
+	rc = dlpar_acquire_drc(drc_index);
+	if (rc) {
+		pr_err("Failed to acquire DRC, rc: %d, drc index: %x\n",
+			rc, drc_index);
+		return -EINVAL;
+	}
+
+	dn = dlpar_configure_connector(cpu_to_be32(drc_index), pmem_node);
+	if (!dn) {
+		pr_err("configure-connector failed for drc %x\n", drc_index);
+		dlpar_release_drc(drc_index);
+		return -EINVAL;
+	}
+
+	/* NB: The of reconfig notifier creates platform device from the node */
+	rc = dlpar_attach_node(dn, pmem_node);
+	if (rc) {
+		pr_err("Failed to attach node %s, rc: %d, drc index: %x\n",
+			dn->name, rc, drc_index);
+
+		if (dlpar_release_drc(drc_index))
+			dlpar_free_cc_nodes(dn);
+
+		return rc;
+	}
+
+	pr_info("Successfully added %pOF, drc index: %x\n", dn, drc_index);
+
+	return 0;
+}
+
+static ssize_t pmem_drc_remove_node(u32 drc_index)
+{
+	struct device_node *dn;
+	uint32_t index;
+	int rc;
+
+	for_each_child_of_node(pmem_node, dn) {
+		if (of_property_read_u32(dn, "ibm,my-drc-index", &index))
+			continue;
+		if (index == drc_index)
+			break;
+	}
+
+	if (!dn) {
+		pr_err("Attempting to remove unused DRC index %x\n", drc_index);
+		return -ENODEV;
+	}
+
+	pr_debug("Attempting to remove %pOF, drc index: %x\n", dn, drc_index);
+
+	/* * NB: tears down the ibm,pmemory device as a side-effect */
+	rc = dlpar_detach_node(dn);
+	if (rc)
+		return rc;
+
+	rc = dlpar_release_drc(drc_index);
+	if (rc) {
+		pr_err("Failed to release drc (%x) for CPU %s, rc: %d\n",
+			drc_index, dn->name, rc);
+		dlpar_attach_node(dn, pmem_node);
+		return rc;
+	}
+
+	pr_info("Successfully removed PMEM with drc index: %x\n", drc_index);
+
+	return 0;
+}
+
+int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
+{
+	u32 count, drc_index;
+	int rc;
+
+	/* slim chance, but we might get a hotplug event while booting */
+	if (!pmem_node)
+		pmem_node = of_find_node_by_type(NULL, "ibm,persistent-memory");
+	if (!pmem_node) {
+		pr_err("Hotplug event for a pmem device, but none exists\n");
+		return -ENODEV;
+	}
+
+	if (hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_INDEX) {
+		pr_err("Unsupported hotplug event type %d\n",
+				hp_elog->id_type);
+		return -EINVAL;
+	}
+
+	count = hp_elog->_drc_u.drc_count;
+	drc_index = hp_elog->_drc_u.drc_index;
+
+	lock_device_hotplug();
+
+	if (hp_elog->action == PSERIES_HP_ELOG_ACTION_ADD) {
+		rc = pmem_drc_add_node(drc_index);
+	} else if (hp_elog->action == PSERIES_HP_ELOG_ACTION_REMOVE) {
+		rc = pmem_drc_remove_node(drc_index);
+	} else {
+		pr_err("Unsupported hotplug action (%d)\n", hp_elog->action);
+		rc = -EINVAL;
+	}
+
+	unlock_device_hotplug();
+	return rc;
+}
+
+const struct of_device_id drc_pmem_match[] = {
+	{ .type = "ibm,persistent-memory", },
+	{}
+};
+
+static int pseries_pmem_init(void)
+{
+	pmem_node = of_find_node_by_type(NULL, "ibm,persistent-memory");
+	if (!pmem_node)
+		return 0;
+
+	/*
+	 * The generic OF bus probe/populate handles creating platform devices
+	 * from the child (ibm,pmemory) nodes. The generic code registers an of
+	 * reconfig notifier to handle the hot-add/remove cases too.
+	 */
+	of_platform_bus_probe(pmem_node, drc_pmem_match, NULL);
+
+	return 0;
+}
+machine_arch_initcall(pseries, pseries_pmem_init);
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee511fb..d0829677c896 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -63,11 +63,16 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 			 struct completion *hotplug_done, int *rc);
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
+int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog);
 #else
 static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+};
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 851ce326874a..ae22fc007276 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -237,7 +237,8 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
 	 * hotplug events on the ras_log_buf to be handled by rtas_errd.
 	 */
 	if (hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_MEM ||
-	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU)
+	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU ||
+	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_PMEM)
 		queue_hotplug_event(hp_elog, NULL, NULL);
 	else
 		log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
-- 
2.9.5

