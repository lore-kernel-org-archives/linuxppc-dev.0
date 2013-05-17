Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E79272C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 16:59:22 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/pci: remove the unused variables in
 pci_process_bridge_OF_ranges
Date: Fri, 17 May 2013 14:58:42 +0800
Message-ID: <1368773922-19754-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368773922-19754-1-git-send-email-haokexin@gmail.com>
References: <1368773922-19754-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The codes which ever used these two variables have gone. Throw away
them too.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/pci-common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8245d51..50fabab 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -671,10 +671,9 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	int rlen;
 	int pna = of_n_addr_cells(dev);
 	int np = pna + 5;
-	int memno = 0, isa_hole = -1;
+	int memno = 0;
 	u32 pci_space;
 	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
-	unsigned long long isa_mb = 0;
 	struct resource *res;
 
 	printk(KERN_INFO "PCI host bridge %s %s ranges:\n",
@@ -768,8 +767,6 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			}
 			/* Handles ISA memory hole space here */
 			if (pci_addr == 0) {
-				isa_mb = cpu_addr;
-				isa_hole = memno;
 				if (primary || isa_mem_base == 0)
 					isa_mem_base = cpu_addr;
 				hose->isa_mem_phys = cpu_addr;
-- 
1.8.1.4
