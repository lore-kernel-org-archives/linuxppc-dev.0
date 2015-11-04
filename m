Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0FEF1A0CC4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 14:31:25 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 13:31:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7A38B2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 14:31:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA43VDjs63570118
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 14:31:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA43Umek009863
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 14:30:49 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V12 4/9] powerpc/eeh: Cache only BARs, not windows or IOV BARs
Date: Wed,  4 Nov 2015 11:28:47 +0800
Message-Id: <1446607732-4166-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This restricts the EEH address cache to use only the first 7 BARs. This
makes __eeh_addr_cache_insert_dev() ignore PCI bridge window and IOV BARs.
As the result of this change, eeh_addr_cache_get_dev() will return VFs from
VF's resource addresses instead of parent PFs.

This removes extra check for a PCI bridge as we limit
__eeh_addr_cache_insert_dev() to 7 BARs and this effectively excludes PCI
bridges from being cached.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index a1e86e1..ddbcfab 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -195,8 +195,11 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 		return;
 	}
 
-	/* Walk resources on this device, poke them into the tree */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+	/*
+	 * Walk resources on this device, poke the first 7 (6 normal BAR and 1
+	 * ROM BAR) into the tree.
+	 */
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		resource_size_t start = pci_resource_start(dev,i);
 		resource_size_t end = pci_resource_end(dev,i);
 		unsigned long flags = pci_resource_flags(dev,i);
@@ -222,10 +225,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
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
