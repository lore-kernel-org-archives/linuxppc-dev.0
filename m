Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpNmR2D4gzDqxQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 10:55:19 +1000 (AEST)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rpNmQ4XDVz9sDk
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2016 10:55:18 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hh10so65857pac.1
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2016 17:55:18 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: arnd@arndb.de,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 5/5] powerpc/sparse: Make ppc_md.{halt, restart} __noreturn
Date: Tue, 12 Jul 2016 10:54:52 +1000
Message-Id: <1468284892-27765-5-git-send-email-dja@axtens.net>
In-Reply-To: <1468284892-27765-1-git-send-email-dja@axtens.net>
References: <1468284892-27765-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerNV marks it's halt and restart calls as __noreturn. However,
ppc_md does not have this annotation. Add the annotation to ppc_md,
and then to every halt/restart function that is missing it.

Additionally, I have verified that all of these functions do not
return. Occasionally I have added a spin loop to be sure.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v2: fix build errors:
 - add a while (1) loop to convince gcc that the powermac ones
   terminate.
 - add annotations to ppc476.c
Thanks to 0day build bot and mpe's kisskb.
---
 arch/powerpc/include/asm/machdep.h                |  4 ++--
 arch/powerpc/include/asm/mpc52xx.h                |  2 +-
 arch/powerpc/include/asm/ppc4xx.h                 |  2 +-
 arch/powerpc/include/asm/rtas.h                   |  4 ++--
 arch/powerpc/kernel/rtas.c                        |  4 ++--
 arch/powerpc/platforms/44x/ppc476.c               |  4 ++--
 arch/powerpc/platforms/512x/mpc512x.h             |  2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c      |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c      |  3 +--
 arch/powerpc/platforms/82xx/pq2.c                 |  2 +-
 arch/powerpc/platforms/82xx/pq2.h                 |  2 +-
 arch/powerpc/platforms/83xx/misc.c                |  2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h             |  2 +-
 arch/powerpc/platforms/85xx/ksi8560.c             |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |  2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c           |  2 +-
 arch/powerpc/platforms/8xx/mpc8xx.h               |  2 +-
 arch/powerpc/platforms/amigaone/setup.c           |  2 +-
 arch/powerpc/platforms/chrp/setup.c               |  2 +-
 arch/powerpc/platforms/embedded6xx/c2k.c          |  2 +-
 arch/powerpc/platforms/embedded6xx/gamecube.c     |  6 +++---
 arch/powerpc/platforms/embedded6xx/holly.c        |  2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c  |  6 +++---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |  2 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c     |  2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c   |  2 +-
 arch/powerpc/platforms/embedded6xx/wii.c          |  6 +++---
 arch/powerpc/platforms/maple/setup.c              |  8 +++++---
 arch/powerpc/platforms/pasemi/setup.c             |  2 +-
 arch/powerpc/platforms/powermac/setup.c           | 12 +++++++-----
 arch/powerpc/platforms/ps3/setup.c                |  4 ++--
 arch/powerpc/sysdev/fsl_soc.c                     |  8 +++++---
 arch/powerpc/sysdev/fsl_soc.h                     |  6 +++---
 33 files changed, 60 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 6bdcd0da9e21..a9af1bd6a51e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -111,8 +111,8 @@ struct machdep_calls {
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
 
-	void		(*restart)(char *cmd);
-	void		(*halt)(void);
+	void __noreturn	(*restart)(char *cmd);
+	void __noreturn (*halt)(void);
 	void		(*panic)(char *str);
 	void		(*cpu_die)(void);
 
diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 0acc7c7c28d1..e94cede14522 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -275,7 +275,7 @@ extern int mpc5200_psc_ac97_gpio_reset(int psc_number);
 extern void mpc52xx_map_common_devices(void);
 extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
 extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
-extern void mpc52xx_restart(char *cmd);
+extern void __noreturn mpc52xx_restart(char *cmd);
 
 /* mpc52xx_gpt.c */
 struct mpc52xx_gpt_priv;
diff --git a/arch/powerpc/include/asm/ppc4xx.h b/arch/powerpc/include/asm/ppc4xx.h
index 033039a80c42..610a5119ad8c 100644
--- a/arch/powerpc/include/asm/ppc4xx.h
+++ b/arch/powerpc/include/asm/ppc4xx.h
@@ -13,6 +13,6 @@
 #ifndef __ASM_POWERPC_PPC4xx_H__
 #define __ASM_POWERPC_PPC4xx_H__
 
-extern void ppc4xx_reset_system(char *cmd);
+extern void __noreturn ppc4xx_reset_system(char *cmd);
 
 #endif /* __ASM_POWERPC_PPC4xx_H__ */
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 51400baa8d48..fa3e3c4367bd 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -339,9 +339,9 @@ extern int rtas_service_present(const char *service);
 extern int rtas_call(int token, int, int, int *, ...);
 void rtas_call_unlocked(struct rtas_args *args, int token, int nargs,
 			int nret, ...);
-extern void rtas_restart(char *cmd);
+extern void __noreturn rtas_restart(char *cmd);
 extern void rtas_power_off(void);
-extern void rtas_halt(void);
+extern void __noreturn rtas_halt(void);
 extern void rtas_os_term(char *str);
 extern int rtas_get_sensor(int sensor, int index, int *state);
 extern int rtas_get_sensor_fast(int sensor, int index, int *state);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 28736ff27fea..3cb6fae4a13c 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -685,7 +685,7 @@ int rtas_set_indicator_fast(int indicator, int index, int new_value)
 	return rc;
 }
 
-void rtas_restart(char *cmd)
+void __noreturn rtas_restart(char *cmd)
 {
 	if (rtas_flash_term_hook)
 		rtas_flash_term_hook(SYS_RESTART);
@@ -704,7 +704,7 @@ void rtas_power_off(void)
 	for (;;);
 }
 
-void rtas_halt(void)
+void __noreturn rtas_halt(void)
 {
 	if (rtas_flash_term_hook)
 		rtas_flash_term_hook(SYS_HALT);
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index c11ce6516c8f..003973f65297 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -68,7 +68,7 @@ DECLARE_PCI_FIXUP_HEADER(0x1033, 0x0035, quirk_ppc_currituck_usb_fixup);
 #define AVR_PWRCTL_RESET (0x02)
 
 static struct i2c_client *avr_i2c_client;
-static void avr_halt_system(int pwrctl_flags)
+static void __noreturn avr_halt_system(int pwrctl_flags)
 {
 	/* Request the AVR to reset the system */
 	i2c_smbus_write_byte_data(avr_i2c_client,
@@ -84,7 +84,7 @@ static void avr_power_off_system(void)
 	avr_halt_system(AVR_PWRCTL_PWROFF);
 }
 
-static void avr_reset_system(char *cmd)
+static void __noreturn avr_reset_system(char *cmd)
 {
 	avr_halt_system(AVR_PWRCTL_RESET);
 }
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index cc97f022d028..14ba49fd7938 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -18,6 +18,6 @@ extern void __init mpc512x_setup_arch(void);
 extern int __init mpc5121_clk_init(void);
 extern const char *mpc512x_select_psc_compat(void);
 extern const char *mpc512x_select_reset_compat(void);
-extern void mpc512x_restart(char *cmd);
+extern void __noreturn mpc512x_restart(char *cmd);
 
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 452da2391153..6b4f4cb7009a 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -47,7 +47,7 @@ static void __init mpc512x_restart_init(void)
 	of_node_put(np);
 }
 
-void mpc512x_restart(char *cmd)
+void __noreturn mpc512x_restart(char *cmd)
 {
 	if (reset_module_base) {
 		/* Enable software reset "RSTE" */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 26993826a797..565e3a83dc9e 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -243,8 +243,7 @@ EXPORT_SYMBOL(mpc52xx_get_xtal_freq);
 /**
  * mpc52xx_restart: ppc_md->restart hook for mpc5200 using the watchdog timer
  */
-void
-mpc52xx_restart(char *cmd)
+void __noreturn mpc52xx_restart(char *cmd)
 {
 	local_irq_disable();
 
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index fc8b2d6a7d8d..c4f7029fc9ae 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -22,7 +22,7 @@
 
 #define RMR_CSRE 0x00000001
 
-void pq2_restart(char *cmd)
+void __noreturn pq2_restart(char *cmd)
 {
 	local_irq_disable();
 	setbits32(&cpm2_immr->im_clkrst.car_rmr, RMR_CSRE);
diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/platforms/82xx/pq2.h
index a41f84ae2325..3080ce3441c1 100644
--- a/arch/powerpc/platforms/82xx/pq2.h
+++ b/arch/powerpc/platforms/82xx/pq2.h
@@ -1,7 +1,7 @@
 #ifndef _PQ2_H
 #define _PQ2_H
 
-void pq2_restart(char *cmd);
+void __noreturn pq2_restart(char *cmd);
 
 #ifdef CONFIG_PCI
 int pq2ads_pci_init_irq(void);
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 7e923cad56cf..8899aa9d11f5 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -35,7 +35,7 @@ static int __init mpc83xx_restart_init(void)
 
 arch_initcall(mpc83xx_restart_init);
 
-void mpc83xx_restart(char *cmd)
+void __noreturn mpc83xx_restart(char *cmd)
 {
 #define RST_OFFSET	0x00000900
 #define RST_PROT_REG	0x00000018
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 0cf74d7ea1c5..ad484199eff7 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -65,7 +65,7 @@
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
  */
 
-extern void mpc83xx_restart(char *cmd);
+extern void __noreturn mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 extern int mpc837x_usb_cfg(void);
 extern int mpc834x_usb_cfg(void);
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 3dc1bda3ddc3..867a1078b488 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -44,7 +44,7 @@
 
 static void __iomem *cpld_base = NULL;
 
-static void machine_restart(char *cmd)
+static void __noreturn machine_restart(char *cmd)
 {
 	if (cpld_base)
 		out_8(cpld_base + KSI8560_CPLD_RCR1, KSI8560_CPLD_RCR1_CPUHR);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index d7e87ff912d7..5e0a0a24d5ce 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -83,7 +83,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 		return PCIBIOS_SUCCESSFUL;
 }
 
-static void mpc85xx_cds_restart(char *cmd)
+static void __noreturn mpc85xx_cds_restart(char *cmd)
 {
 	struct pci_dev *dev;
 	u_char tmp;
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index c289fc77b4ba..b1ab6e96cb31 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -198,7 +198,7 @@ void mpc8xx_get_rtc_time(struct rtc_time *tm)
 	return;
 }
 
-void mpc8xx_restart(char *cmd)
+void __noreturn mpc8xx_restart(char *cmd)
 {
 	car8xx_t __iomem *clk_r = immr_map(im_clkrst);
 
diff --git a/arch/powerpc/platforms/8xx/mpc8xx.h b/arch/powerpc/platforms/8xx/mpc8xx.h
index 239a243a6161..31cc2ecace42 100644
--- a/arch/powerpc/platforms/8xx/mpc8xx.h
+++ b/arch/powerpc/platforms/8xx/mpc8xx.h
@@ -11,7 +11,7 @@
 #ifndef __MPC8xx_H
 #define __MPC8xx_H
 
-extern void mpc8xx_restart(char *cmd);
+extern void __noreturn mpc8xx_restart(char *cmd);
 extern void mpc8xx_calibrate_decr(void);
 extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
 extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
index 2fe12046279e..3e12d8789252 100644
--- a/arch/powerpc/platforms/amigaone/setup.c
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -123,7 +123,7 @@ static int __init request_isa_regions(void)
 }
 machine_device_initcall(amigaone, request_isa_regions);
 
-void amigaone_restart(char *cmd)
+void __noreturn amigaone_restart(char *cmd)
 {
 	local_irq_disable();
 
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 987d1b8d68e3..c55002f01dc1 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -239,7 +239,7 @@ out:
 	of_node_put(np);
 }
 
-static void briq_restart(char *cmd)
+static void __noreturn briq_restart(char *cmd)
 {
 	local_irq_disable();
 	if (briq_SPOR)
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c b/arch/powerpc/platforms/embedded6xx/c2k.c
index ebd3963fdf91..782066245bb5 100644
--- a/arch/powerpc/platforms/embedded6xx/c2k.c
+++ b/arch/powerpc/platforms/embedded6xx/c2k.c
@@ -99,7 +99,7 @@ static void c2k_reset_board(void)
 	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_VALUE_SET, 0x00080004);
 }
 
-static void c2k_restart(char *cmd)
+static void __noreturn c2k_restart(char *cmd)
 {
 	c2k_reset_board();
 	msleep(100);
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index fe0ed6ee285e..b17705c3f7a4 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -29,14 +29,14 @@
 #include "usbgecko_udbg.h"
 
 
-static void gamecube_spin(void)
+static void __noreturn gamecube_spin(void)
 {
 	/* spin until power button pressed */
 	for (;;)
 		cpu_relax();
 }
 
-static void gamecube_restart(char *cmd)
+static void __noreturn gamecube_restart(char *cmd)
 {
 	local_irq_disable();
 	flipper_platform_reset();
@@ -49,7 +49,7 @@ static void gamecube_power_off(void)
 	gamecube_spin();
 }
 
-static void gamecube_halt(void)
+static void __noreturn gamecube_halt(void)
 {
 	gamecube_restart(NULL);
 }
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 8c305c7c8977..8b6e76100895 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -193,7 +193,7 @@ void holly_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
 }
 
-void holly_restart(char *cmd)
+void __noreturn holly_restart(char *cmd)
 {
 	__be32 __iomem *ocn_bar1 = NULL;
 	unsigned long bar;
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 540eeb58d3f0..4c5089f05c7f 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -100,7 +100,7 @@ static void __init linkstation_init_IRQ(void)
 extern void avr_uart_configure(void);
 extern void avr_uart_send(const char);
 
-static void linkstation_restart(char *cmd)
+static void __noreturn linkstation_restart(char *cmd)
 {
 	local_irq_disable();
 
@@ -113,7 +113,7 @@ static void linkstation_restart(char *cmd)
 		avr_uart_send('G');	/* "kick" */
 }
 
-static void linkstation_power_off(void)
+static void __noreturn linkstation_power_off(void)
 {
 	local_irq_disable();
 
@@ -127,7 +127,7 @@ static void linkstation_power_off(void)
 	/* NOTREACHED */
 }
 
-static void linkstation_halt(void)
+static void __noreturn linkstation_halt(void)
 {
 	linkstation_power_off();
 	/* NOTREACHED */
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index df4ad95f183e..3eda5df6281a 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -146,7 +146,7 @@ void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "vendor\t\t: Freescale Semiconductor\n");
 }
 
-void mpc7448_hpc2_restart(char *cmd)
+static void __noreturn mpc7448_hpc2_restart(char *cmd)
 {
 	local_irq_disable();
 
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 8f65aa3747f5..1382e1f27518 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -177,7 +177,7 @@ static void mvme5100_show_cpuinfo(struct seq_file *m)
 	seq_puts(m, "Machine\t\t: MVME5100\n");
 }
 
-static void mvme5100_restart(char *cmd)
+static void __noreturn mvme5100_restart(char *cmd)
 {
 
 	local_irq_disable();
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index d572833ebd00..4596cba8c827 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -96,7 +96,7 @@ static void __init storcenter_init_IRQ(void)
 	mpic_init(mpic);
 }
 
-static void storcenter_restart(char *cmd)
+static void __noreturn storcenter_restart(char *cmd)
 {
 	local_irq_disable();
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 352592d3e44e..ebaecb88df26 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -112,7 +112,7 @@ unsigned long __init wii_mmu_mapin_mem2(unsigned long top)
 	return delta + bl;
 }
 
-static void wii_spin(void)
+static void __noreturn wii_spin(void)
 {
 	local_irq_disable();
 	for (;;)
@@ -160,7 +160,7 @@ static void __init wii_setup_arch(void)
 	}
 }
 
-static void wii_restart(char *cmd)
+static void __noreturn wii_restart(char *cmd)
 {
 	local_irq_disable();
 
@@ -185,7 +185,7 @@ static void wii_power_off(void)
 	wii_spin();
 }
 
-static void wii_halt(void)
+static void __noreturn wii_halt(void)
 {
 	if (ppc_md.restart)
 		ppc_md.restart(NULL);
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index a837188544c8..5f8f6f966608 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -94,7 +94,7 @@ static unsigned long maple_find_nvram_base(void)
 	return result;
 }
 
-static void maple_restart(char *cmd)
+static void __noreturn maple_restart(char *cmd)
 {
 	unsigned int maple_nvram_base;
 	const unsigned int *maple_nvram_offset, *maple_nvram_command;
@@ -119,9 +119,10 @@ static void maple_restart(char *cmd)
 	for (;;) ;
  fail:
 	printk(KERN_EMERG "Maple: Manual Restart Required\n");
+	for (;;) ;
 }
 
-static void maple_power_off(void)
+static void __noreturn maple_power_off(void)
 {
 	unsigned int maple_nvram_base;
 	const unsigned int *maple_nvram_offset, *maple_nvram_command;
@@ -146,9 +147,10 @@ static void maple_power_off(void)
 	for (;;) ;
  fail:
 	printk(KERN_EMERG "Maple: Manual Power-Down Required\n");
+	for (;;) ;
 }
 
-static void maple_halt(void)
+static void __noreturn maple_halt(void)
 {
 	maple_power_off();
 }
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d71b2c7e8403..7349644c9828 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -62,7 +62,7 @@ static int num_mce_regs;
 static int nmi_virq = NO_IRQ;
 
 
-static void pas_restart(char *cmd)
+static void __noreturn pas_restart(char *cmd)
 {
 	/* Need to put others cpu in hold loop so they're not sleeping */
 	smp_send_stop();
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 774c11366a22..4f3cf55a0a3a 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -383,7 +383,7 @@ void __ref note_bootable_part(dev_t dev, int part, int goodness)
 }
 
 #ifdef CONFIG_ADB_CUDA
-static void cuda_restart(void)
+static void __noreturn cuda_restart(void)
 {
 	struct adb_request req;
 
@@ -392,7 +392,7 @@ static void cuda_restart(void)
 		cuda_poll();
 }
 
-static void cuda_shutdown(void)
+static void __noreturn cuda_shutdown(void)
 {
 	struct adb_request req;
 
@@ -416,7 +416,7 @@ static void cuda_shutdown(void)
 #define smu_shutdown()
 #endif
 
-static void pmac_restart(char *cmd)
+static void __noreturn pmac_restart(char *cmd)
 {
 	switch (sys_ctrler) {
 	case SYS_CTRLER_CUDA:
@@ -430,9 +430,10 @@ static void pmac_restart(char *cmd)
 		break;
 	default: ;
 	}
+	while (1) ;
 }
 
-static void pmac_power_off(void)
+static void __noreturn pmac_power_off(void)
 {
 	switch (sys_ctrler) {
 	case SYS_CTRLER_CUDA:
@@ -446,9 +447,10 @@ static void pmac_power_off(void)
 		break;
 	default: ;
 	}
+	while (1) ;
 }
 
-static void
+static void __noreturn
 pmac_halt(void)
 {
 	pmac_power_off();
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 799c8580ab09..486ecd017535 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -80,7 +80,7 @@ static void ps3_power_save(void)
 	lv1_pause(0);
 }
 
-static void ps3_restart(char *cmd)
+static void __noreturn ps3_restart(char *cmd)
 {
 	DBG("%s:%d cmd '%s'\n", __func__, __LINE__, cmd);
 
@@ -96,7 +96,7 @@ static void ps3_power_off(void)
 	ps3_sys_manager_power_off(); /* never returns */
 }
 
-static void ps3_halt(void)
+static void __noreturn ps3_halt(void)
 {
 	DBG("%s:%d\n", __func__, __LINE__);
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 99269c041615..a09ca704de58 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -204,7 +204,7 @@ static int __init setup_rstcr(void)
 
 arch_initcall(setup_rstcr);
 
-void fsl_rstcr_restart(char *cmd)
+void __noreturn fsl_rstcr_restart(char *cmd)
 {
 	local_irq_disable();
 	if (rstcr)
@@ -228,10 +228,11 @@ EXPORT_SYMBOL(diu_ops);
  * to initiate a partition restart when we're running under the Freescale
  * hypervisor.
  */
-void fsl_hv_restart(char *cmd)
+void __noreturn fsl_hv_restart(char *cmd)
 {
 	pr_info("hv restart\n");
 	fh_partition_restart(-1);
+	while (1) ;
 }
 
 /*
@@ -241,9 +242,10 @@ void fsl_hv_restart(char *cmd)
  * function pointers, to shut down the partition when we're running under
  * the Freescale hypervisor.
  */
-void fsl_hv_halt(void)
+void __noreturn fsl_hv_halt(void)
 {
 	pr_info("hv exit\n");
 	fh_partition_stop(-1);
+	while (1) ;
 }
 #endif
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 4c5a19ef4f0b..433566a5ef19 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -19,7 +19,7 @@ extern u32 fsl_get_sys_freq(void);
 struct spi_board_info;
 struct device_node;
 
-extern void fsl_rstcr_restart(char *cmd);
+extern void __noreturn fsl_rstcr_restart(char *cmd);
 
 /* The different ports that the DIU can be connected to */
 enum fsl_diu_monitor_port {
@@ -42,8 +42,8 @@ struct platform_diu_data_ops {
 
 extern struct platform_diu_data_ops diu_ops;
 
-void fsl_hv_restart(char *cmd);
-void fsl_hv_halt(void);
+void __noreturn fsl_hv_restart(char *cmd);
+void __noreturn fsl_hv_halt(void);
 
 #endif
 #endif
-- 
2.1.4
