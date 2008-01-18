Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 56E60DDF06
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 01:30:17 +1100 (EST)
Message-ID: <4790B82B.9060506@scram.de>
Date: Fri, 18 Jan 2008 15:31:07 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/7] [POWERPC] Rename m8xx_pic_init to mpc8xx_pics_init
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
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

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/platforms/8xx/ep88xc.c          |    2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c      |    4 ++--
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 +-
 arch/powerpc/sysdev/commproc.h               |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index c518b6c..c883c31 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -166,7 +166,7 @@ define_machine(ep88xc) {
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
index d2927a4..dea1df1 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -139,7 +139,7 @@ define_machine(mpc86x_ads) {
 	.name			= "MPC86x ADS",
 	.probe			= mpc86xads_probe,
 	.setup_arch		= mpc86xads_setup_arch,
-	.init_IRQ		= m8xx_pic_init,
+	.init_IRQ		= mpc8xx_pics_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 2cf1b6a..8f2aa04 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -275,7 +275,7 @@ define_machine(mpc885_ads) {
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
-- 
1.5.3.8
