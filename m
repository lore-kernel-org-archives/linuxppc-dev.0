Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9C56E2C036D
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:21:02 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 14:21:01 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 24CDF2BB0053
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAF4KkaH5439962
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAF4KwIn007211
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:20:58 +1100
Subject: [PATCH 2/2] powerpc/powernv: Get FSP memory errors and plumb into
 memory poison infrastructure.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 15 Nov 2013 09:50:57 +0530
Message-ID: <20131115042056.5748.26024.stgit@mars.in.ibm.com>
In-Reply-To: <20131115041952.5748.19640.stgit@mars.in.ibm.com>
References: <20131115041952.5748.19640.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Get the memory errors reported by opal and plumb it into memory poison
infrastructure. This patch uses new messaging channel infrastructure to
pull the fsp memory errors to linux.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                    |   52 +++++++
 arch/powerpc/platforms/powernv/Makefile            |    1 
 .../powerpc/platforms/powernv/opal-memory-errors.c |  146 ++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/opal-memory-errors.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 3de7ac6..5fe041c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -418,6 +418,58 @@ struct opal_machine_check_event {
 	} u;
 };
 
+/* FSP memory errors handling */
+enum OpalMemErr_Version {
+	OpalMemErr_V1 = 1,
+};
+
+enum OpalMemErrType {
+	OPAL_MEM_ERR_TYPE_RESILIENCE	= 0,
+	OPAL_MEM_ERR_TYPE_DYN_DALLOC,
+	OPAL_MEM_ERR_TYPE_SCRUB,
+};
+
+/* Memory Reilience error type */
+enum OpalMemErr_ResilErrType {
+	OPAL_MEM_RESILIENCE_CE		= 0,
+	OPAL_MEM_RESILIENCE_UE,
+	OPAL_MEM_RESILIENCE_UE_SCRUB,
+};
+
+/* Dynamic Memory Deallocation type */
+enum OpalMemErr_DynErrType {
+	OPAL_MEM_DYNAMIC_DEALLOC	= 0,
+};
+
+/* OpalMemoryErrorData->flags */
+#define OPAL_MEM_CORRECTED_ERROR	0x0001
+#define OPAL_MEM_THRESHOLD_EXCEEDED	0x0002
+#define OPAL_MEM_ACK_REQUIRED		0x8000
+
+struct OpalMemoryErrorData {
+	enum OpalMemErr_Version	version:8;	/* 0x00 */
+	enum OpalMemErrType	type:8;		/* 0x01 */
+	uint16_t		flags;		/* 0x02 */
+	uint8_t			reserved_1[4];	/* 0x04 */
+
+	union {
+		/* Memory Resilience corrected/uncorrected error info */
+		struct {
+			enum OpalMemErr_ResilErrType resil_err_type:8;
+			uint8_t		reserved_1[7];
+			uint64_t	physical_address_start;
+			uint64_t	physical_address_end;
+		} resilience;
+		/* Dynamic memory deallocation error info */
+		struct {
+			enum OpalMemErr_DynErrType dyn_err_type:8;
+			uint8_t		reserved_1[7];
+			uint64_t	physical_address_start;
+			uint64_t	physical_address_end;
+		} dyn_dealloc;
+	} u;
+};
+
 enum {
 	OPAL_P7IOC_DIAG_TYPE_NONE	= 0,
 	OPAL_P7IOC_DIAG_TYPE_RGC	= 1,
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 300c437..0a57286 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -4,3 +4,4 @@ obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
new file mode 100644
index 0000000..ec41322
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -0,0 +1,146 @@
+/*
+ * OPAL asynchronus Memory error handling support in PowreNV.
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright 2013 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+#include <asm/cputable.h>
+
+static int opal_mem_err_nb_init;
+static LIST_HEAD(opal_memory_err_list);
+static DEFINE_SPINLOCK(opal_mem_err_lock);
+
+struct OpalMsgNode {
+	struct list_head list;
+	struct opal_msg msg;
+};
+
+static void handle_memory_error_event(struct OpalMemoryErrorData *merr_evt)
+{
+	uint64_t paddr_start, paddr_end;
+
+	pr_debug("%s: Retrived memory error event, type: 0x%x\n",
+		  __func__, merr_evt->type);
+	switch (merr_evt->type) {
+	case OPAL_MEM_ERR_TYPE_RESILIENCE:
+		paddr_start = merr_evt->u.resilience.physical_address_start;
+		paddr_end = merr_evt->u.resilience.physical_address_end;
+		break;
+	case OPAL_MEM_ERR_TYPE_DYN_DALLOC:
+		paddr_start = merr_evt->u.dyn_dealloc.physical_address_start;
+		paddr_end = merr_evt->u.dyn_dealloc.physical_address_end;
+		break;
+	default:
+		return;
+	}
+
+	for (; paddr_start < paddr_end; paddr_start += PAGE_SIZE) {
+		memory_failure(paddr_start >> PAGE_SHIFT, 0, 0);
+	}
+}
+
+static void handle_memory_error(void)
+{
+	unsigned long flags;
+	struct OpalMemoryErrorData *merr_evt;
+	struct OpalMsgNode *msg_node;
+
+	spin_lock_irqsave(&opal_mem_err_lock, flags);
+	while (!list_empty(&opal_memory_err_list)) {
+		 msg_node = list_entry(opal_memory_err_list.next,
+					   struct OpalMsgNode, list);
+		list_del(&msg_node->list);
+		spin_unlock_irqrestore(&opal_mem_err_lock, flags);
+
+		merr_evt = (struct OpalMemoryErrorData *)
+					&msg_node->msg.params[0];
+		handle_memory_error_event(merr_evt);
+		kfree(msg_node);
+		spin_lock_irqsave(&opal_mem_err_lock, flags);
+	}
+	spin_unlock_irqrestore(&opal_mem_err_lock, flags);
+}
+
+static void mem_error_handler(struct work_struct *work)
+{
+	handle_memory_error();
+}
+
+static DECLARE_WORK(mem_error_work, mem_error_handler);
+
+/*
+ * opal_memory_err_event - notifier handler that queues up the opal message
+ * to be preocessed later.
+ */
+static int opal_memory_err_event(struct notifier_block *nb,
+			  unsigned long msg_type, void *msg)
+{
+	unsigned long flags;
+	struct OpalMsgNode *msg_node;
+
+	if (msg_type != OPAL_MSG_MEM_ERR)
+		return 0;
+
+	msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
+	if (!msg_node) {
+		pr_err("MEMORY_ERROR: out of memory, Opal message event not"
+		       "handled\n");
+		return -ENOMEM;
+	}
+	memcpy(&msg_node->msg, msg, sizeof(struct opal_msg));
+
+	spin_lock_irqsave(&opal_mem_err_lock, flags);
+	list_add(&msg_node->list, &opal_memory_err_list);
+	spin_unlock_irqrestore(&opal_mem_err_lock, flags);
+
+	schedule_work(&mem_error_work);
+	return 0;
+}
+
+static struct notifier_block opal_mem_err_nb = {
+	.notifier_call	= opal_memory_err_event,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+static int __init opal_mem_err_init(void)
+{
+	int ret;
+
+	if (!opal_mem_err_nb_init) {
+		ret = opal_message_notifier_register(
+					OPAL_MSG_MEM_ERR, &opal_mem_err_nb);
+		if (ret) {
+			pr_err("%s: Can't register OPAL event notifier (%d)\n",
+			       __func__, ret);
+			return ret;
+		}
+		opal_mem_err_nb_init = 1;
+	}
+	return 0;
+}
+subsys_initcall(opal_mem_err_init);
