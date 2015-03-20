Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E7271A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:57:06 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/mpic: remove unused functions
Date: Fri, 20 Mar 2015 10:56:29 +0700
Message-Id: <1426823789-949-5-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
Cc: Jia Hongtao <hongtao.jia@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Arseny Solokha <asolokha@kb.kras.ru>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop unused mpic_set_clk_ratio() and mpic_set_serial_int().

Both functions are almost nine years old[1] but still have no chance
to be called even from out-of-tree modules because they both are __init
and of course aren't exported.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-June/023867.html

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
Cc: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/include/asm/mpic.h | 11 -----------
 arch/powerpc/sysdev/mpic.c      | 25 -------------------------
 2 files changed, 36 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 754f93d..3b39c28 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -33,11 +33,6 @@
 #define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
 #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
 #define		MPIC_GREG_GCONF_MCK			0x08000000
-#define MPIC_GREG_GLOBAL_CONF_1		0x00030
-#define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000
-#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
-#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(r)	\
-			(((r) << 28) & MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK)
 #define MPIC_GREG_VENDOR_0		0x00040
 #define MPIC_GREG_VENDOR_1		0x00050
 #define MPIC_GREG_VENDOR_2		0x00060
@@ -496,11 +491,5 @@ extern unsigned int mpic_get_coreint_irq(void);
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
index bbfbbf2..2c817a7 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1676,31 +1676,6 @@ void __init mpic_init(struct mpic *mpic)
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
2.3.3
