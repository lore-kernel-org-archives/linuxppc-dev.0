Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D8A1B7500
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:25 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 11/13] 8xx: start using dcbX instructions in various copy
	routines
Date: Mon, 10 Jan 2011 22:37:57 +0100
Message-Id: <1294695479-344-12-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
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
 arch/ppc/kernel/misc.S |   18 ------------------
 arch/ppc/lib/string.S  |   17 -----------------
 2 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index c1c3178..6f57957 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -662,15 +662,7 @@ _GLOBAL(__flush_dcache_icache)
 _GLOBAL(clear_page)
 	li	r0,4096/L1_CACHE_LINE_SIZE
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
 	addi	r3,r3,L1_CACHE_LINE_SIZE
 	bdnz	1b
 	blr
@@ -695,15 +687,6 @@ _GLOBAL(copy_page)
 	addi	r3,r3,-4
 	addi	r4,r4,-4
 
-#ifdef CONFIG_8xx
-	/* don't use prefetch on 8xx */
-    	li	r0,4096/L1_CACHE_LINE_SIZE
-	mtctr	r0
-1:	COPY_16_BYTES
-	bdnz	1b
-	blr
-
-#else	/* not 8xx, we can prefetch */
 	li	r5,4
 
 #if MAX_COPY_PREFETCH > 1
@@ -744,7 +727,6 @@ _GLOBAL(copy_page)
 	li	r0,MAX_COPY_PREFETCH
 	li	r11,4
 	b	2b
-#endif	/* CONFIG_8xx */
 
 /*
  * Atomic [test&set] exchange
diff --git a/arch/ppc/lib/string.S b/arch/ppc/lib/string.S
index 6ca54b4..b6ea44b 100644
--- a/arch/ppc/lib/string.S
+++ b/arch/ppc/lib/string.S
@@ -159,14 +159,7 @@ _GLOBAL(cacheable_memzero)
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
-#endif
 	addi	r6,r6,CACHELINE_BYTES
 	bdnz	10b
 	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
@@ -261,9 +254,7 @@ _GLOBAL(cacheable_memcpy)
 	mtctr	r0
 	beq	63f
 53:
-#if !defined(CONFIG_8xx)
 	dcbz	r11,r6
-#endif
 	COPY_16_BYTES
 #if L1_CACHE_LINE_SIZE >= 32
 	COPY_16_BYTES
@@ -443,13 +434,6 @@ _GLOBAL(__copy_tofrom_user)
 	li	r11,4
 	beq	63f
 
-#ifdef CONFIG_8xx
-	/* Don't use prefetch on 8xx */
-	mtctr	r0
-53:	COPY_16_BYTES_WITHEX(0)
-	bdnz	53b
-
-#else /* not CONFIG_8xx */
 	/* Here we decide how far ahead to prefetch the source */
 	li	r3,4
 	cmpwi	r0,1
@@ -502,7 +486,6 @@ _GLOBAL(__copy_tofrom_user)
 	li	r3,4
 	li	r7,0
 	bne	114b
-#endif /* CONFIG_8xx */	
 
 63:	srwi.	r0,r5,2
 	mtctr	r0
-- 
1.7.3.4
