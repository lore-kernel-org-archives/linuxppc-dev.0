Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyH1BplzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 40/70] powerpc/mm: Rename mmu_context_hash64.c to
 mmu_context_book3s64.c
Date: Fri, 29 Apr 2016 23:26:03 +1000
Message-Id: <1461936393-10131-40-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This file now contains both hash and radix specific code. Rename it to
indicate this better.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/Makefile                                         | 7 +++----
 arch/powerpc/mm/{mmu_context_hash64.c => mmu_context_book3s64.c} | 0
 2 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/powerpc/mm/{mmu_context_hash64.c => mmu_context_book3s64.c} (100%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index d734934cbb1e..9589236028f4 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -14,11 +14,10 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
-obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y)
+obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o
-obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o \
-				   mmu_context_hash$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
+obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o
 ifeq ($(CONFIG_PPC_STD_MMU_64),y)
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_book3s64.c
similarity index 100%
rename from arch/powerpc/mm/mmu_context_hash64.c
rename to arch/powerpc/mm/mmu_context_book3s64.c
-- 
2.5.0
