Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB27C1A0704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:18 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:18 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C71D22CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:16 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2F1vm20906136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:15:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dFA7007891
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:16 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/21] powerpc/eeh: Dump PCI config space for all child devices
Date: Tue, 30 Sep 2014 12:39:08 +1000
Message-Id: <1412044750-24460-19-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PEs can be organized as nested. Current implementation doesn't
dump PCI config space for subordinate devices of child PEs. However,
the frozen PE could be caused by those subordinate devices of its
child PEs.

The patch dumps PCI config space for all subordinate devices of the
problematic PE.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 0b31169..519622f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -117,7 +117,7 @@ static DEFINE_MUTEX(eeh_dev_mutex);
  * not dynamically alloced, so that it ends up in RMO where RTAS
  * can access it.
  */
-#define EEH_PCI_REGS_LOG_LEN 4096
+#define EEH_PCI_REGS_LOG_LEN 8192
 static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
 
 /*
@@ -148,16 +148,12 @@ static int __init eeh_setup(char *str)
 }
 __setup("eeh=", eeh_setup);
 
-/**
- * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
- * @edev: device to report data for
- * @buf: point to buffer in which to log
- * @len: amount of room in buffer
- *
- * This routine captures assorted PCI configuration space data,
- * and puts them into a buffer for RTAS error logging.
+/*
+ * This routine captures assorted PCI configuration space data
+ * for the indicated PCI device, and puts them into a buffer
+ * for RTAS error logging.
  */
-static size_t eeh_gather_pci_data(struct eeh_dev *edev, char *buf, size_t len)
+static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 {
 	struct device_node *dn = eeh_dev_to_of_node(edev);
 	u32 cfg;
@@ -255,6 +251,19 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char *buf, size_t len)
 	return n;
 }
 
+static void *eeh_dump_pe_log(void *data, void *flag)
+{
+	struct eeh_pe *pe = data;
+	struct eeh_dev *edev, *tmp;
+	size_t *plen = flag;
+
+	eeh_pe_for_each_dev(pe, edev, tmp)
+		*plen += eeh_dump_dev_log(edev, pci_regs_buf + *plen,
+					  EEH_PCI_REGS_LOG_LEN - *plen);
+
+	return NULL;
+}
+
 /**
  * eeh_slot_error_detail - Generate combined log including driver log and error log
  * @pe: EEH PE
@@ -268,7 +277,6 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char *buf, size_t len)
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 {
 	size_t loglen = 0;
-	struct eeh_dev *edev, *tmp;
 
 	/*
 	 * When the PHB is fenced or dead, it's pointless to collect
@@ -286,10 +294,7 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 		eeh_pe_restore_bars(pe);
 
 		pci_regs_buf[0] = 0;
-		eeh_pe_for_each_dev(pe, edev, tmp) {
-			loglen += eeh_gather_pci_data(edev, pci_regs_buf + loglen,
-						      EEH_PCI_REGS_LOG_LEN - loglen);
-		}
+		eeh_pe_traverse(pe, eeh_dump_pe_log, &loglen);
 	}
 
 	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
-- 
1.8.3.2
