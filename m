Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G9kp6N3HzF1pZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 13:03:11 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w342xnLK076660
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 23:03:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4nw9s3ks-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 23:03:08 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 4 Apr 2018 04:03:06 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC 1/2] powerpc/swiotlb: Dont free up allocated SWIOTLB slab on
 POWER
Date: Wed,  4 Apr 2018 08:33:00 +0530
Message-Id: <20180404030301.25019-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even though SWIOTLB slab gets allocated and initialized on powerpc with
swiotlb_init() called during mem_init(), it gets released away again on
POWER platform because 'ppc_swiotlb_enable' never gets set. The function
swiotlb_detect_4g() checks for 4GB memory and then sets the variable
'ppc_swiotlb_enable' which prevents freeing up the SWIOTLB slab. Lets
make POWER platform call swiotlb_detect_4g() during setup_arch() which
will keep the SWIOTLB slab through out the runtime.

A previous commit cf5621032f ("powerpc/64: Limit ZONE_DMA32 to 4GiB in
swiotlb_detect_4g()") enforced 4GB limit on ZONE_DMA32 which is is not
applicable on POWER (CONFIG_PPC_BOOK3S_64) platform. Lets remove this
unnecessary restriction.

After the patch, SWIOTLB slab does not get released.

[0.410992] software IO TLB [mem 0xfbff0000-0xffff0000] (64MB) mapped
at [00000000767f6cb3-000000004a10114f]

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/dma-swiotlb.c  | 2 +-
 arch/powerpc/kernel/setup-common.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 88f3963ca30f..2255c6dc89db 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -110,7 +110,7 @@ void __init swiotlb_detect_4g(void)
 {
 	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
 		ppc_swiotlb_enable = 1;
-#ifdef CONFIG_ZONE_DMA32
+#if defined(CONFIG_ZONE_DMA32) && !defined(CONFIG_PPC_BOOK3S_64)
 		limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
 #endif
 	}
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d73ec518ef80..c4db844e0b0d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -944,6 +944,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize the MMU context management stuff. */
 	mmu_context_init();
 
+	swiotlb_detect_4g();
 #ifdef CONFIG_PPC64
 	/* Interrupt code needs to be 64K-aligned. */
 	if ((unsigned long)_stext & 0xffff)
-- 
2.14.1
