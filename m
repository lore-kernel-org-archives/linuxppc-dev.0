Return-Path: <oohall@gmail.com>
From: Oliver O'Halloran <oohall@gmail.com>
To: skiboot@lists.ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [RFC PATCH] powerpc/powernv: report error messages from opal
Date: Wed, 21 Dec 2016 16:52:59 +1100
Message-Id: <1482299579-21599-1-git-send-email-oohall@gmail.com>
In-Reply-To: <1482298544-8418-1-git-send-email-oohall@gmail.com>
References: <1482298544-8418-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent versions of skiboot will raise an OPAL event (read: interrupt)
when firmware writes an error message to its internal console. In
conjunction they provide an OPAL call that the kernel can use to extract
these messages from the OPAL log to allow them to be written into the
kernel's log buffer where someone will (hopefully) look at them.

For the companion skiboot patches see:

	https://lists.ozlabs.org/pipermail/skiboot/2016-December/005861.html

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/opal-api.h            |  5 +++-
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/platforms/powernv/opal-msglog.c   | 41 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57bcab50..cb9c0e6afb33 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_SCRAPE_LOG				128
+#define OPAL_LAST				128
 
 /* Device tree flags */
 
@@ -288,6 +289,7 @@ enum OpalPendingState {
 	OPAL_EVENT_PCI_ERROR	   = 0x200,
 	OPAL_EVENT_DUMP_AVAIL	   = 0x400,
 	OPAL_EVENT_MSG_PENDING	   = 0x800,
+	OPAL_EVENT_LOG_PENDING	   = 0x1000,
 };
 
 enum OpalThreadStatus {
@@ -406,6 +408,7 @@ enum opal_msg_type {
 	OPAL_MSG_DPO		= 5,
 	OPAL_MSG_PRD		= 6,
 	OPAL_MSG_OCC		= 7,
+	OPAL_MSG_LOG		= 8,
 	OPAL_MSG_TYPE_MAX,
 };
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5c7db0f1a708..2b3bd3219fb4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -232,6 +232,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_scrape_log(int64_t *offset, char *buf, int64_t len, int64_t *lvl);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 39d6ff9e5630..78168f66fb24 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
+#include <linux/interrupt.h>
 
 /* OPAL in-memory console. Defined in OPAL source at core/console.c */
 struct memcons {
@@ -102,8 +103,36 @@ static struct bin_attribute opal_msglog_attr = {
 	.read = opal_msglog_read
 };
 
+static char *log_levels[] = { "Emergency", "Alert", "Critical", "Error", "Warning" };
+static int64_t offset = -1;
+
+static irqreturn_t opal_print_log(int irq, void *data)
+{
+	int64_t rc, log_lvl;
+	char buffer[320];
+
+	/*
+	 * only print one message per invokation of the IRQ handler
+	 */
+
+	rc = opal_scrape_log(&offset, buffer, sizeof(buffer), &log_lvl);
+
+	if (rc == OPAL_SUCCESS || rc == OPAL_PARTIAL) {
+		log_lvl = be64_to_cpu(log_lvl);
+		if (log_lvl > 4)
+			log_lvl = 4;
+
+		printk_emit(0, log_lvl, NULL, 0, "OPAL %s: %s%s\r\n",
+			log_levels[log_lvl], buffer,
+			rc == OPAL_PARTIAL ? "<truncated>" : "");
+	}
+
+	return IRQ_HANDLED;
+}
+
 void __init opal_msglog_init(void)
 {
+	int virq, rc = -1;
 	u64 mcaddr;
 	struct memcons *mc;
 
@@ -123,6 +152,18 @@ void __init opal_msglog_init(void)
 		return;
 	}
 
+	virq = opal_event_request(ilog2(OPAL_EVENT_LOG_PENDING));
+	if (virq) {
+		rc = request_irq(virq, opal_print_log,
+			IRQF_TRIGGER_HIGH, "opal memcons", NULL);
+
+		if (rc)
+			irq_dispose_mapping(virq);
+	}
+
+	if (!virq || rc)
+		pr_warn("Unable to register OPAL log event handler\n");
+
 	opal_memcons = mc;
 }
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3aa40f1b20f5..c59d7da3fd1a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -312,3 +312,4 @@ OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_scrape_log,			OPAL_SCRAPE_LOG);
-- 
2.7.4
