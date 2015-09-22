Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 3EF1D1A06E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:51:06 +1000 (AEST)
Message-Id: <0ab6c6e9052e562175828be2ef98b8089d1785b9.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 17/25] powerpc/8xx: remove special handling of CPU6 errata
 in set_dec()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:51:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPU6 ERRATA is now handled directly in mtspr(), so we can use the
standard set_dec() fonction in all cases.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 arch/powerpc/include/asm/time.h |  6 +-----
 arch/powerpc/kernel/head_8xx.S  | 18 ------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 10fc784..e18c203 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -32,8 +32,6 @@ extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
 
-extern void set_dec_cpu6(unsigned int val);
-
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
 #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
@@ -167,14 +165,12 @@ static inline void set_dec(int val)
 {
 #if defined(CONFIG_40x)
 	mtspr(SPRN_PIT, val);
-#elif defined(CONFIG_8xx_CPU6)
-	set_dec_cpu6(val - 1);
 #else
 #ifndef CONFIG_BOOKE
 	--val;
 #endif
 	mtspr(SPRN_DEC, val);
-#endif /* not 40x or 8xx_CPU6 */
+#endif /* not 40x */
 }
 
 static inline unsigned long tb_ticks_since(unsigned long tstamp)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6c991e9..c89d55b 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -955,24 +955,6 @@ _GLOBAL(set_context)
 	SYNC
 	blr
 
-#ifdef CONFIG_8xx_CPU6
-/* It's here because it is unique to the 8xx.
- * It is important we get called with interrupts disabled.  I used to
- * do that, but it appears that all code that calls this already had
- * interrupt disabled.
- */
-	.globl	set_dec_cpu6
-set_dec_cpu6:
-	lis	r7, cpu6_errata_word@h
-	ori	r7, r7, cpu6_errata_word@l
-	li	r4, 0x2c00
-	stw	r4, 8(r7)
-	lwz	r4, 8(r7)
-        mtspr   22, r3		/* Update Decrementer */
-	SYNC
-	blr
-#endif
-
 /*
  * We put a few things here that have to be page-aligned.
  * This stuff goes at the beginning of the data segment,
-- 
2.1.0
