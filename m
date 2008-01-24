Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 78726DDEBD
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:18:23 +1100 (EST)
Message-ID: <4798AC0C.1060103@scram.de>
Date: Thu, 24 Jan 2008 16:17:32 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCHv3 2/7] [POWERPC] Rename m8xx_pic_init to mpc8xx_pics_init
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

m8xx_pic_init calls both mpc8xx_pic_init and cpm_pic_init. Renaming the
function to use the same name space as the rest of the mpc8xx
specific funtions and to be more meaningful.
m8xx_pic_init is declared in ppc8xx_pic.h but defined nowhere in the ppc
tree. Remove it.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/platforms/8xx/ep88xc.c          |    2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c      |    4 ++--
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 +-
 arch/powerpc/sysdev/commproc.h               |    2 +-
 arch/ppc/syslib/ppc8xx_pic.h                 |    1 -
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index 88afa35..372b1e2 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -165,7 +165,7 @@ define_machine(ep88xc) {
 	.name = "Embedded Planet EP88xC",
 	.probe = ep88xc_probe,
 	.setup_arch = ep88xc_setup_arch,
-	.init_IRQ = m8xx_pic_init,
+	.init_IRQ = mpc8xx_pics_init,
 	.get_irq	= mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
 	.calibrate_decr = mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index ba645c2..1337457 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -237,13 +237,13 @@ static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
 	desc->chip->eoi(irq);
 }
 
-/* Initialize the internal interrupt controller.  The number of
+/* Initialize the internal interrupt controllers.  The number of
  * interrupts supported can vary with the processor type, and the
  * 82xx family can have up to 64.
  * External interrupts can be either edge or level triggered, and
  * need to be initialized by the appropriate driver.
  */
-void __init m8xx_pic_init(void)
+void __init mpc8xx_pics_init(void)
 {
 	int irq;
 
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index d7965f8..2a4a50f 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -138,7 +138,7 @@ define_machine(mpc86x_ads) {
 	.name			= "MPC86x ADS",
 	.probe			= mpc86xads_probe,
 	.setup_arch		= mpc86xads_setup_arch,
-	.init_IRQ		= m8xx_pic_init,
+	.init_IRQ		= mpc8xx_pics_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 6ef8e9e..2931bae 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -274,7 +274,7 @@ define_machine(mpc885_ads) {
 	.name			= "Freescale MPC885 ADS",
 	.probe			= mpc885ads_probe,
 	.setup_arch		= mpc885ads_setup_arch,
-	.init_IRQ		= m8xx_pic_init,
+	.init_IRQ		= mpc8xx_pics_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/sysdev/commproc.h b/arch/powerpc/sysdev/commproc.h
index 9155ba4..f481adf 100644
--- a/arch/powerpc/sysdev/commproc.h
+++ b/arch/powerpc/sysdev/commproc.h
@@ -6,7 +6,7 @@ extern void mpc8xx_restart(char *cmd);
 extern void mpc8xx_calibrate_decr(void);
 extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
 extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
-extern void m8xx_pic_init(void);
+extern void mpc8xx_pics_init(void);
 extern unsigned int mpc8xx_get_irq(void);
 
 #endif
diff --git a/arch/ppc/syslib/ppc8xx_pic.h b/arch/ppc/syslib/ppc8xx_pic.h
index d7d9f65..53bcd97 100644
--- a/arch/ppc/syslib/ppc8xx_pic.h
+++ b/arch/ppc/syslib/ppc8xx_pic.h
@@ -6,7 +6,6 @@
 
 extern struct hw_interrupt_type ppc8xx_pic;
 
-void m8xx_pic_init(void);
 void m8xx_do_IRQ(struct pt_regs *regs,
                  int            cpu);
 int m8xx_get_irq(struct pt_regs *regs);
-- 
1.5.3.8
