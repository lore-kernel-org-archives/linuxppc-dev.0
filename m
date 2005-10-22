Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 6B56268601
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 07:28:48 +1000 (EST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id CF9C342AFB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 23:28:39 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 85CEC353418
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 23:28:39 +0200 (MEST)
To: linuxppc-dev@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sat, 22 Oct 2005 23:28:39 +0200
Sender: wd@denx.de
Message-Id: <20051022212839.85CEC353418@atlas.denx.de>
Subject: [PATCH] Cleanup mpc83xx_restart() code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current Linux 2.6 mpc83xx_restart() routine which is supposed to
be common for all MPC83xx boards actually performs mpc834x_sys board
specific operations. This code was moved to
arch/ppc/platforms/83xx/mpc834x_sys.c, and mpc83xx_restart() was
replaced with generic MPC83xx reset code. Now mpc834x_sys uses it's
platform specific restart code and we can use common MPC83xx reset
code in other MPC83xx boards


---
ppc83xx common code cleanup, MPC834x_SYS platform specific code moved to
arch/ppc/platform/83xx/mpc834x_sys.c

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>

---
commit 8176ad2d83c41be9697b475c8c0b975908cb7843
tree 16a5246f615529cf423b63231990723ab8a6bd13
parent 80387b45146a9e397c1fec1138f3eb3884c42ed8
author Marian Balakowicz <m8@semihalf.com> Tue, 18 Oct 2005 18:35:07 +0200
committer Marian Balakowicz <m8@semihalf.com> Tue, 18 Oct 2005 18:35:07 +0200

 arch/ppc/platforms/83xx/mpc834x_sys.c |   36 ++++++++++++++++++++++++
 arch/ppc/syslib/ppc83xx_setup.c       |   49 +++++++++++----------------------
 include/asm-ppc/mpc83xx.h             |   13 +++++++++
 3 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -245,6 +245,40 @@ mpc834x_sys_set_bat(void)
 	mb();
 }
 
+void
+mpc83xx_sys_restart(char *cmd)
+{
+	volatile unsigned char __iomem *reg;
+	unsigned char tmp;
+
+	reg = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+
+	local_irq_disable();
+
+	/*
+	 * Unlock the BCSR bits so a PRST will update the contents.
+	 * Otherwise the reset asserts but doesn't clear.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG3_OFF);
+	tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
+	out_8(reg + BCSR_MISC_REG3_OFF, tmp);
+
+	/*
+	 * Trigger a reset via a low->high transition of the
+	 * PORESET bit.
+	 */
+	tmp = in_8(reg + BCSR_MISC_REG2_OFF);
+	tmp &= ~BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
+	udelay(1);
+
+	tmp |= BCSR_MISC_REG2_PORESET;
+	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+
+	for(;;);
+}
+
 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
@@ -313,7 +347,7 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.init_IRQ = mpc834x_sys_init_IRQ;
 	ppc_md.get_irq = ipic_get_irq;
 
-	ppc_md.restart = mpc83xx_restart;
+	ppc_md.restart = mpc83xx_sys_restart;
 	ppc_md.power_off = mpc83xx_power_off;
 	ppc_md.halt = mpc83xx_halt;
 
diff --git a/arch/ppc/syslib/ppc83xx_setup.c b/arch/ppc/syslib/ppc83xx_setup.c
--- a/arch/ppc/syslib/ppc83xx_setup.c
+++ b/arch/ppc/syslib/ppc83xx_setup.c
@@ -63,13 +63,10 @@ mpc83xx_find_end_of_memory(void)
 long __init
 mpc83xx_time_init(void)
 {
-#define SPCR_OFFS   0x00000110
-#define SPCR_TBEN   0x00400000
-
 	bd_t *binfo = (bd_t *)__res;
-	u32 *spcr = ioremap(binfo->bi_immr_base + SPCR_OFFS, 4);
+	u32 *spcr = ioremap(binfo->bi_immr_base + MPC83xx_SPCR, 4);
 
-	*spcr |= SPCR_TBEN;
+	*spcr |= MPC83xx_SPCR_TBEN;
 
 	iounmap(spcr);
 
@@ -132,35 +129,23 @@ mpc83xx_early_serial_map(void)
 void
 mpc83xx_restart(char *cmd)
 {
-	volatile unsigned char __iomem *reg;
-	unsigned char tmp;
-
-	reg = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
-
-	local_irq_disable();
-
-	/*
-	 * Unlock the BCSR bits so a PRST will update the contents.
-	 * Otherwise the reset asserts but doesn't clear.
-	 */
-	tmp = in_8(reg + BCSR_MISC_REG3_OFF);
-	tmp |= BCSR_MISC_REG3_CNFLOCK; /* low true, high false */
-	out_8(reg + BCSR_MISC_REG3_OFF, tmp);
-
-	/*
-	 * Trigger a reset via a low->high transition of the
-	 * PORESET bit.
-	 */
-	tmp = in_8(reg + BCSR_MISC_REG2_OFF);
-	tmp &= ~BCSR_MISC_REG2_PORESET;
-	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
-
-	udelay(1);
+	bd_t *binfo = (bd_t *)__res;
 
-	tmp |= BCSR_MISC_REG2_PORESET;
-	out_8(reg + BCSR_MISC_REG2_OFF, tmp);
+	u32 *rcr = ioremap(binfo->bi_immr_base + MPC83xx_RCR, 4);
+	u32 *rpr = ioremap(binfo->bi_immr_base + MPC83xx_RPR, 4);
 
-	for(;;);
+	/* apply reset protect unlock command to
+	 * reset control protection  register */
+	*rpr = MPC83xx_RPR_RSTE;
+
+	/* apply software hard reset to
+	 * reset control register*/
+	*rcr = MPC83xx_RCR_SWHR;
+
+	/* not reached, but... */
+	iounmap(rcr);
+	iounmap(rpr);
+	for (;;) ;
 }
 
 void
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -95,6 +95,19 @@ extern unsigned char __res[];
 
 #define MPC83xx_CCSRBAR_SIZE	(1024*1024)
 
+/* system priority and configuration register */
+#define MPC83xx_SPCR            0x00000110
+#define MPC83xx_SPCR_TBEN       0x00400000
+
+/* reset protection register */
+#define MPC83xx_RPR		0x00000918
+#define MPC83xx_RPR_RSTE	0x52535445      /* "RSTE" in ASCII */
+
+/* reset control register*/
+#define MPC83xx_RCR		0x0000091c
+#define MPC83xx_RCR_SWHR	0x00000002      /* sw hard reset */
+#define MPC83xx_RCR_SWSR	0x00000001      /* sw soft reset */
+
 /* Let modules/drivers get at immrbar (physical) */
 extern phys_addr_t immrbar;
 



!-------------------------------------------------------------flip-




Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You can observe a lot just by watching.                  - Yogi Berra
