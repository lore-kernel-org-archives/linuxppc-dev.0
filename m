Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 365C01A0C46
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:18:12 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 08:48:10 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 046F21258059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 08:48:01 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9Q3I6l147382686
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 08:48:06 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9Q3I67g027744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 08:48:06 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V10 05/12] powerpc/eeh: Cache only BARs,
 not windows or IOV BARs
Date: Mon, 26 Oct 2015 11:15:55 +0800
Message-Id: <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EEH address cache, which helps to locate the PCI device according to
the given (physical) MMIO address, didn't cover PCI bridges. Also, it
shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
should be returned.

Also, by doing so, it removes the type check in
eeh_addr_cache_insert_dev(), since bridge's window would not be cached.

The patch restricts the address cache to cover first 7 BARs for the
above purposes.

[gwshan: changelog]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index a1e86e1..e6887f0 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 	}
 
 	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		resource_size_t start = pci_resource_start(dev,i);
 		resource_size_t end = pci_resource_end(dev,i);
 		unsigned long flags = pci_resource_flags(dev,i);
@@ -222,10 +222,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
 {
 	unsigned long flags;
 
-	/* Ignore PCI bridges */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
-		return;
-
 	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
 	__eeh_addr_cache_insert_dev(dev);
 	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-- 
2.5.0
