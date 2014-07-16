Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 731ED1A01AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:26 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 15:50:24 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3D4912CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6G5RdCj9241034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:27:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6G5oLKv028997
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 15:50:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/eeh: Reduce lines of log dump
Date: Wed, 16 Jul 2014 15:50:16 +1000
Message-Id: <1405489819-26211-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch prints 4 PCIE or AER config registers each line, which
is part of the EEH log so that it looks a bit more compact.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index aa33656..123c151 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -157,12 +157,13 @@ __setup("eeh=", eeh_setup);
  * This routine captures assorted PCI configuration space data,
  * and puts them into a buffer for RTAS error logging.
  */
-static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
+static size_t eeh_gather_pci_data(struct eeh_dev *edev, char *buf, size_t len)
 {
 	struct device_node *dn = eeh_dev_to_of_node(edev);
 	u32 cfg;
-	int cap, i;
+	int cap, i, j;
 	int n = 0;
+	char buffer[128];
 
 	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
 	pr_warn("EEH: of node=%s\n", dn->full_name);
@@ -204,10 +205,22 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
 		pr_warn("EEH: PCI-E capabilities and status follow:\n");
 
-		for (i=0; i<=8; i++) {
+		for (i=0, j=0; i<=8; i++) {
 			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-			pr_warn("EEH: PCI-E %02x: %08x\n", i, cfg);
+
+			if ((i % 4) == 0) {
+				memset(buffer, 0, sizeof(buffer));
+				j = scnprintf(buffer, sizeof(buffer),
+					      "EEH: PCI-E %02x: %08x ",
+					      4*i, cfg);
+			} else {
+				j += scnprintf(buffer+j, sizeof(buffer)-j,
+					       "%08x ", cfg);
+			}
+
+			if ((i % 4) == 3 || i >= 8)
+				pr_warn("%s\n", buffer);
 		}
 	}
 
@@ -217,10 +230,22 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 		n += scnprintf(buf+n, len-n, "pci-e AER:\n");
 		pr_warn("EEH: PCI-E AER capability register set follows:\n");
 
-		for (i=0; i<14; i++) {
+		for (i=0, j=0; i<=13; i++) {
 			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
-			pr_warn("EEH: PCI-E AER %02x: %08x\n", i, cfg);
+
+			if ((i % 4) == 0) {
+				memset(buffer, 0, sizeof(buffer));
+				j = scnprintf(buffer, sizeof(buffer),
+					      "EEH: PCI-E AER %02x: %08x ",
+					      4*i, cfg);
+			} else {
+				j += scnprintf(buffer+j, sizeof(buffer)-j,
+					       "%08x ", cfg);
+			}
+
+			if ((i % 4) == 3 || i >= 13)
+				pr_warn("%s\n", buffer);
 		}
 	}
 
-- 
1.8.3.2
