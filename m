Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 9A9F11A028E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 03:08:19 +1100 (AEDT)
Message-Id: <45ce022f2198c7a6f1d44618ba4ace0dc60fd274.1455032446.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1455032446.git.christophe.leroy@c-s.fr>
References: <cover.1455032446.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 15/23] powerpc/8xx: remove special handling of CPU6 errata
 in set_dec()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  9 Feb 2016 17:08:16 +0100 (CET)
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
v2: no change
v3: no change
v4: no change
v5: no change
v6: no change
v8: no change

 arch/powerpc/include/asm/time.h |  6 +-----
 arch/powerpc/kernel/head_8xx.S  | 18 ------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 2d7109a..1092fdd 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -31,8 +31,6 @@ extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
 
-extern void set_dec_cpu6(unsigned int val);
-
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
 #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
@@ -166,14 +164,12 @@ static inline void set_dec(int val)
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
index a268cf4..637f8e9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -1011,24 +1011,6 @@ _GLOBAL(set_context)
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
