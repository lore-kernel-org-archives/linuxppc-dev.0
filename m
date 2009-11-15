Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C9B0100A77
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 04:10:10 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH 08/10] 8xx: start using dcbX instructions in various copy
	routines
Date: Sun, 15 Nov 2009 18:09:35 +0100
Message-Id: <1258304977-11760-9-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1258304977-11760-8-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258304977-11760-8-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that 8xx can fixup dcbX instructions, start using them
where possible like every other PowerPc arch do.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/misc_32.S |   18 ------------------
 arch/powerpc/lib/copy_32.S    |   24 ------------------------
 2 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index da9c0c4..8649f53 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -502,15 +502,7 @@ _GLOBAL(clear_pages)
 	li	r0,PAGE_SIZE/L1_CACHE_BYTES
 	slw	r0,r0,r4
 	mtctr	r0
-#ifdef CONFIG_8xx
-	li	r4, 0
-1:	stw	r4, 0(r3)
-	stw	r4, 4(r3)
-	stw	r4, 8(r3)
-	stw	r4, 12(r3)
-#else
 1:	dcbz	0,r3
-#endif
 	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	blr
@@ -535,15 +527,6 @@ _GLOBAL(copy_page)
 	addi	r3,r3,-4
 	addi	r4,r4,-4
 
-#ifdef CONFIG_8xx
-	/* don't use prefetch on 8xx */
-    	li	r0,4096/L1_CACHE_BYTES
-	mtctr	r0
-1:	COPY_16_BYTES
-	bdnz	1b
-	blr
-
-#else	/* not 8xx, we can prefetch */
 	li	r5,4
 
 #if MAX_COPY_PREFETCH > 1
@@ -584,7 +567,6 @@ _GLOBAL(copy_page)
 	li	r0,MAX_COPY_PREFETCH
 	li	r11,4
 	b	2b
-#endif	/* CONFIG_8xx */
 
 /*
  * void atomic_clear_mask(atomic_t mask, atomic_t *addr)
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index c657de5..74a7f41 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -98,20 +98,7 @@ _GLOBAL(cacheable_memzero)
 	bdnz	4b
 3:	mtctr	r9
 	li	r7,4
-#if !defined(CONFIG_8xx)
 10:	dcbz	r7,r6
-#else
-10:	stw	r4, 4(r6)
-	stw	r4, 8(r6)
-	stw	r4, 12(r6)
-	stw	r4, 16(r6)
-#if CACHE_LINE_SIZE >= 32
-	stw	r4, 20(r6)
-	stw	r4, 24(r6)
-	stw	r4, 28(r6)
-	stw	r4, 32(r6)
-#endif /* CACHE_LINE_SIZE */
-#endif
 	addi	r6,r6,CACHELINE_BYTES
 	bdnz	10b
 	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
@@ -200,9 +187,7 @@ _GLOBAL(cacheable_memcpy)
 	mtctr	r0
 	beq	63f
 53:
-#if !defined(CONFIG_8xx)
 	dcbz	r11,r6
-#endif
 	COPY_16_BYTES
 #if L1_CACHE_BYTES >= 32
 	COPY_16_BYTES
@@ -356,14 +341,6 @@ _GLOBAL(__copy_tofrom_user)
 	li	r11,4
 	beq	63f
 
-#ifdef CONFIG_8xx
-	/* Don't use prefetch on 8xx */
-	mtctr	r0
-	li	r0,0
-53:	COPY_16_BYTES_WITHEX(0)
-	bdnz	53b
-
-#else /* not CONFIG_8xx */
 	/* Here we decide how far ahead to prefetch the source */
 	li	r3,4
 	cmpwi	r0,1
@@ -416,7 +393,6 @@ _GLOBAL(__copy_tofrom_user)
 	li	r3,4
 	li	r7,0
 	bne	114b
-#endif /* CONFIG_8xx */
 
 63:	srwi.	r0,r5,2
 	mtctr	r0
-- 
1.6.4.4
