Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452CBC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C0C20811
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NaDYdUln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C0C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vy2T56G7zDqPG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:02:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="NaDYdUln"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vy044GqWzDqSR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:00:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Vxzz1Cjcz9v1NL;
 Fri, 29 Mar 2019 10:59:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=NaDYdUln; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id wUdlIpq_5NY1; Fri, 29 Mar 2019 10:59:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Vxzz04dVz9v1N5;
 Fri, 29 Mar 2019 10:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553853599; bh=NXXksJTeSw7yDHOQiGDfLIwm9PEhAi+42zzbvqUbe1k=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=NaDYdUlnnp0GC+dkGYgKIWCURGWwyrRoLDzDoDI8omHIuhJBjLHv/buhHN2Fklvzs
 3Wh9lrmVWgckZFJc3zICrIdDuEshDfzb90YeRWERRxIIfb1t+IzFPQ1GqWD+grrLBJ
 4hY28UKD81cs/yA8vipt9WF9f1RA3DSQRW4zSEE4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 156078B88A;
 Fri, 29 Mar 2019 11:00:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id W62mc2pvMELg; Fri, 29 Mar 2019 10:59:59 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D53A88B889;
 Fri, 29 Mar 2019 10:59:59 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id CA4996FC95; Fri, 29 Mar 2019 09:59:59 +0000 (UTC)
Message-Id: <1c8eb7526ed327c3317053d57ac34e8c652b5449.1553853405.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553853405.git.christophe.leroy@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 1/4] powerpc/mm: change #include "mmu_decl.h" to
 <mm/mmu_decl.h>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 09:59:59 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch make inclusion of mmu_decl.h independant of the location
of the file including it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/40x_mmu.c            | 2 +-
 arch/powerpc/mm/44x_mmu.c            | 2 +-
 arch/powerpc/mm/8xx_mmu.c            | 2 +-
 arch/powerpc/mm/dma-noncoherent.c    | 2 +-
 arch/powerpc/mm/fsl_booke_mmu.c      | 2 +-
 arch/powerpc/mm/init_32.c            | 2 +-
 arch/powerpc/mm/init_64.c            | 2 +-
 arch/powerpc/mm/mem.c                | 2 +-
 arch/powerpc/mm/mmu_context_nohash.c | 2 +-
 arch/powerpc/mm/pgtable-book3e.c     | 2 +-
 arch/powerpc/mm/pgtable-book3s64.c   | 2 +-
 arch/powerpc/mm/pgtable-hash64.c     | 2 +-
 arch/powerpc/mm/pgtable_32.c         | 2 +-
 arch/powerpc/mm/pgtable_64.c         | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c         | 2 +-
 arch/powerpc/mm/tlb_hash32.c         | 2 +-
 arch/powerpc/mm/tlb_nohash.c         | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index b9cf6f8764b0..460459b6f53e 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -49,7 +49,7 @@
 #include <asm/machdep.h>
 #include <asm/setup.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 extern int __map_without_ltlbs;
 /*
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index aad127acdbaa..c07983ebc02e 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -31,7 +31,7 @@
 #include <asm/cacheflush.h>
 #include <asm/code-patching.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 /* Used by the 44x TLB replacement exception handler.
  * Just needed it declared someplace.
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index fe1f6443d57f..a10f6578c58b 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -17,7 +17,7 @@
 #include <asm/fixmap.h>
 #include <asm/code-patching.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 #define IMMR_SIZE (FIX_IMMR_SIZE << PAGE_SHIFT)
 
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index b5d2658c26af..2f6154b76328 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -36,7 +36,7 @@
 #include <asm/tlbflush.h>
 #include <asm/dma.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 /*
  * This address range defaults to a value that is safe for all
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 210cbc1faf63..71a1a36751dd 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -54,7 +54,7 @@
 #include <asm/setup.h>
 #include <asm/paca.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 unsigned int tlbcam_index;
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 41a3513cadc9..28b2c5fc772f 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -46,7 +46,7 @@
 #include <asm/sections.h>
 #include <asm/hugetlb.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 #if defined(CONFIG_KERNEL_START_BOOL) || defined(CONFIG_LOWMEM_SIZE_BOOL)
 /* The amount of lowmem must be within 0xF0000000 - KERNELBASE. */
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a4c155af1597..45b02fa11cd8 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -66,7 +66,7 @@
 #include <asm/iommu.h>
 #include <asm/vdso.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 phys_addr_t memstart_addr = ~0;
 EXPORT_SYMBOL_GPL(memstart_addr);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f6787f90e158..0f1bd9312d9a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -54,7 +54,7 @@
 #include <asm/swiotlb.h>
 #include <asm/rtas.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 #ifndef CPU_FTR_COHERENT_ICACHE
 #define CPU_FTR_COHERENT_ICACHE	0	/* XXX for now */
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 1945c5f19f5e..ae4505d5b4b8 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -52,7 +52,7 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 /*
  * The MPC8xx has only 16 contexts. We rotate through them on each task switch.
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index 1032ef7aaf62..062e4463622e 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -15,7 +15,7 @@
 #include <asm/tlb.h>
 #include <asm/dma.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index a4341aba0af4..16bda049187a 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -17,7 +17,7 @@
 #include <asm/trace.h>
 #include <asm/powernv.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 #include <trace/events/thp.h>
 
 unsigned long __pmd_frag_nr;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index c08d49046a96..9c6b09c09d50 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -19,7 +19,7 @@
 #include <asm/mmu.h>
 #include <asm/tlb.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6e56a6240bfa..c9cdbb84d31f 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -36,7 +36,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index fb1375c07e8c..e1086611deca 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -52,7 +52,7 @@
 #include <asm/firmware.h>
 #include <asm/dma.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f29d2f118b44..1a5c9fa0e6d8 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -34,7 +34,7 @@
 #include <asm/code-patching.h>
 #include <asm/sections.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 struct hash_pte *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index cf8472cf3d59..8d56f0417f87 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -32,7 +32,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 /*
  * Called when unmapping pages to flush entries from the TLB/hash table.
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index ac23dc1c6535..adf894d8405f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -46,7 +46,7 @@
 #include <asm/hugetlb.h>
 #include <asm/paca.h>
 
-#include "mmu_decl.h"
+#include <mm/mmu_decl.h>
 
 /*
  * This struct lists the sw-supported page sizes.  The hardawre MMU may support
-- 
2.13.3

