Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15A45B6FBA
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:34 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 09:22:20 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9X5eG3395774
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:33:05 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cSs5007846
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:28 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/21] Cleanup on function names of EEH aux components
Date: Fri, 24 Feb 2012 17:38:10 +0800
Message-Id: <1330076298-7006-14-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: kernel.crashing.org@shangw, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch does some cleanup on the function names of EEH
aux components. Currently, only couple of function names from
eeh_cache have been adjusted so that:

        * The function name has prefix "eeh_addr_cache".
        * Move around pci_addr_cache_build() in the header file
          to reflect function call sequence.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h         |    4 ++--
 arch/powerpc/platforms/pseries/eeh.c       |    2 +-
 arch/powerpc/platforms/pseries/eeh_cache.c |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index b4b18d8..c02d5a7 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -49,10 +49,10 @@ extern unsigned long pci_probe_only;
 
 #ifdef CONFIG_EEH
 
+void pci_addr_cache_build(void);
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
-void pci_addr_cache_build(void);
-struct pci_dev *pci_get_device_by_addr(unsigned long addr);
+struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 int eeh_pci_enable(struct pci_dn *pdn, int function);
 int eeh_reset_pe(struct pci_dn *);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index bd4ed83..646b520 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -511,7 +511,7 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr = eeh_token_to_phys((unsigned long __force) token);
-	dev = pci_get_device_by_addr(addr);
+	dev = pci_addr_cache_get_device(addr);
 	if (!dev) {
 		no_device++;
 		return val;
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index 850c00c..7c36a9c 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -59,7 +59,7 @@ static struct pci_io_addr_cache {
 	spinlock_t piar_lock;
 } pci_io_addr_cache_root;
 
-static inline struct pci_dev *__pci_get_device_by_addr(unsigned long addr)
+static inline struct pci_dev *__pci_addr_cache_get_device(unsigned long addr)
 {
 	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
 
@@ -83,7 +83,7 @@ static inline struct pci_dev *__pci_get_device_by_addr(unsigned long addr)
 }
 
 /**
- * pci_get_device_by_addr - Get device, given only address
+ * pci_addr_cache_get_device - Get device, given only address
  * @addr: mmio (PIO) phys address or i/o port number
  *
  * Given an mmio phys address, or a port number, find a pci device
@@ -92,13 +92,13 @@ static inline struct pci_dev *__pci_get_device_by_addr(unsigned long addr)
  * from zero (that is, they do *not* have pci_io_addr added in).
  * It is safe to call this function within an interrupt.
  */
-struct pci_dev *pci_get_device_by_addr(unsigned long addr)
+struct pci_dev *pci_addr_cache_get_device(unsigned long addr)
 {
 	struct pci_dev *dev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	dev = __pci_get_device_by_addr(addr);
+	dev = __pci_addr_cache_get_device(addr);
 	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
 	return dev;
 }
-- 
1.7.5.4
