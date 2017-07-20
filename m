Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCkRK4lSrzDrCp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 16:25:33 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id q85so1688578pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 23:25:33 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d89sm2711751pfl.7.2017.07.19.23.25.30
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Jul 2017 23:25:31 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/include/asm: Remove unused 64bit cacheflush function
Date: Thu, 20 Jul 2017 16:25:14 +1000
Message-Id: <20170720062514.2069-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The flush_dcache_phys_range function is no longer used in the kernel.
This patch removes and cleans up the function.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/include/asm/cacheflush.h |  1 -
 arch/powerpc/kernel/misc_64.S         | 38 -----------------------------------
 2 files changed, 39 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index b77f036..11843e3 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -99,7 +99,6 @@ static inline void invalidate_dcache_range(unsigned long start,
 #ifdef CONFIG_PPC64
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
 extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
-extern void flush_dcache_phys_range(unsigned long start, unsigned long stop);
 #endif
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index c119044..0ed5c55 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -144,44 +144,6 @@ _GLOBAL_TOC(flush_dcache_range)
 	blr
 EXPORT_SYMBOL(flush_dcache_range)
 
-/*
- * Like above, but works on non-mapped physical addresses.
- * Use only for non-LPAR setups ! It also assumes real mode
- * is cacheable. Used for flushing out the DART before using
- * it as uncacheable memory 
- *
- * flush_dcache_phys_range(unsigned long start, unsigned long stop)
- *
- *    flush all bytes from start to stop-1 inclusive
- */
-_GLOBAL(flush_dcache_phys_range)
- 	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of dcache block size */
-	srw.	r8,r8,r9		/* compute line count */
-	beqlr				/* nothing to do? */
-	mfmsr	r5			/* Disable MMU Data Relocation */
-	ori	r0,r5,MSR_DR
-	xori	r0,r0,MSR_DR
-	sync
-	mtmsr	r0
-	sync
-	isync
-	mtctr	r8
-0:	dcbst	0,r6
-	add	r6,r6,r7
-	bdnz	0b
-	sync
-	isync
-	mtmsr	r5			/* Re-enable MMU Data Relocation */
-	sync
-	isync
-	blr
-
 _GLOBAL(flush_inval_dcache_range)
  	ld	r10,PPC64_CACHES@toc(r2)
 	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
-- 
2.9.3
