Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2DB1A084E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 14:18:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 9 Mar 2015 13:18:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3BD422BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 14:18:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t293IWGF40632366
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 14:18:41 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t293I7cP028832
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2015 14:18:07 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH 1/4] powerpc/eeh: fix start/end/flags type in struct
 pci_io_addr_range{}
Date: Mon,  9 Mar 2015 11:17:29 +0800
Message-Id: <1425871052-13118-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1425871052-13118-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

struct pci_io_addr_range{} stores the information of pci resources. It
would be better to keep these related fields have the same type as in
struct resource{}.

This patch fixes the start/end/flags type in struct pci_io_addr_range{} to
have the same type as in struct resource{}.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 07d8a24..a30ed67 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -48,11 +48,11 @@
  */
 struct pci_io_addr_range {
 	struct rb_node rb_node;
-	unsigned long addr_lo;
-	unsigned long addr_hi;
+	resource_size_t addr_lo;
+	resource_size_t addr_hi;
 	struct eeh_dev *edev;
 	struct pci_dev *pcidev;
-	unsigned int flags;
+	unsigned long flags;
 };
 
 static struct pci_io_addr_cache {
@@ -125,8 +125,8 @@ static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
 
 /* Insert address range into the rb tree. */
 static struct pci_io_addr_range *
-eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
-		      unsigned long ahi, unsigned int flags)
+eeh_addr_cache_insert(struct pci_dev *dev, resource_size_t alo,
+		      resource_size_t ahi, unsigned long flags)
 {
 	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -200,9 +200,9 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
 
 	/* Walk resources on this device, poke them into the tree */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long start = pci_resource_start(dev,i);
-		unsigned long end = pci_resource_end(dev,i);
-		unsigned int flags = pci_resource_flags(dev,i);
+		resource_size_t start = pci_resource_start(dev,i);
+		resource_size_t end = pci_resource_end(dev,i);
+		unsigned long flags = pci_resource_flags(dev,i);
 
 		/* We are interested only bus addresses, not dma or other stuff */
 		if (0 == (flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-- 
1.7.9.5
