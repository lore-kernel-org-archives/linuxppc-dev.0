Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416B11A056F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:55:52 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 11 Dec 2015 18:55:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BAEFD2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:55:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBB8tJCC36569332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:55:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB8tCiq016733
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:55:13 +1100
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/3] powerpc/pci: Enforce all MMIO BARs to be page aligned
Date: Fri, 11 Dec 2015 16:53:12 +0800
Message-Id: <1449823994-3356-2-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAGE_SIZE is 64KB by default on PPC64 platform. When vfio
passthrough a pci device of which MMIO BARs are smaller than
64KB(PAGE_SIZE), guest would not handle the mmio accesses
to the BARs which leads to mmio emulations in host.

This is because vfio would not allow to passthrough one
BAR's mmio page which may be shared with other BARs.

To solve this performance issue, this patch enforces the
alignment of all MMIO BARs allocations to be at least PAGE_SIZE
on PPC64 platform because we have enough address space, so
that one BAR's mmio page would not be shared with other BARs.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..6989e0f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1074,6 +1074,11 @@ static int skip_isa_ioresource_align(struct pci_dev *dev)
  * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
+ *
+ * And for PPC64, we enforce the alignment of all MMIO BARs
+ * allocations to be at least PAGE_SIZE(64KB). This would be
+ * helpful to improve performance when we passthrough
+ * a PCI device of which BARs are smaller than PAGE_SIZE
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
@@ -1087,7 +1092,10 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	}
-
+#ifdef CONFIG_PPC64
+	if (res->flags & IORESOURCE_MEM)
+		start = PAGE_ALIGN(start);
+#endif
 	return start;
 }
 EXPORT_SYMBOL(pcibios_align_resource);
-- 
1.7.9.5
