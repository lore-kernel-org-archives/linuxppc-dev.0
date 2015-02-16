Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93BA51A09D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:56:47 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/mpic: remove unused functions
Date: Mon, 16 Feb 2015 17:56:28 +0700
Message-Id: <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop unused fsl_mpic_primary_get_version(), mpic_set_clk_ratio(),
mpic_set_serial_int().

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 arch/powerpc/include/asm/mpic.h | 16 ----------------
 arch/powerpc/sysdev/mpic.c      | 35 -----------------------------------
 2 files changed, 51 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 754f93d..3a2ab60 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -395,16 +395,6 @@ extern struct bus_type mpic_subsys;
 #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original MPIC */
 #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
 
-/* Get the version of primary MPIC */
-#ifdef CONFIG_MPIC
-extern u32 fsl_mpic_primary_get_version(void);
-#else
-static inline u32 fsl_mpic_primary_get_version(void)
-{
-	return 0;
-}
-#endif
-
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
  * actually performed.
@@ -496,11 +486,5 @@ extern unsigned int mpic_get_coreint_irq(void);
 /* Fetch Machine Check interrupt from primary mpic */
 extern unsigned int mpic_get_mcirq(void);
 
-/* Set the EPIC clock ratio */
-void mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio);
-
-/* Enable/Disable EPIC serial interrupt mode */
-void mpic_set_serial_int(struct mpic *mpic, int enable);
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_MPIC_H */
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index bbfbbf2..f72b592 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1219,16 +1219,6 @@ static u32 fsl_mpic_get_version(struct mpic *mpic)
  * Exported functions
  */
 
-u32 fsl_mpic_primary_get_version(void)
-{
-	struct mpic *mpic = mpic_primary;
-
-	if (mpic)
-		return fsl_mpic_get_version(mpic);
-
-	return 0;
-}
-
 struct mpic * __init mpic_alloc(struct device_node *node,
 				phys_addr_t phys_addr,
 				unsigned int flags,
@@ -1676,31 +1666,6 @@ void __init mpic_init(struct mpic *mpic)
 		mpic_err_int_init(mpic, MPIC_FSL_ERR_INT);
 }
 
-void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
-{
-	u32 v;
-
-	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
-	v &= ~MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK;
-	v |= MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(clock_ratio);
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
-}
-
-void __init mpic_set_serial_int(struct mpic *mpic, int enable)
-{
-	unsigned long flags;
-	u32 v;
-
-	raw_spin_lock_irqsave(&mpic_lock, flags);
-	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
-	if (enable)
-		v |= MPIC_GREG_GLOBAL_CONF_1_SIE;
-	else
-		v &= ~MPIC_GREG_GLOBAL_CONF_1_SIE;
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
-	raw_spin_unlock_irqrestore(&mpic_lock, flags);
-}
-
 void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 {
 	struct mpic *mpic = mpic_find(irq);
-- 
2.3.0
