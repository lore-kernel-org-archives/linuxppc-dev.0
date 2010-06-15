Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id BF2AF1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 07:53:41 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2 v4] powerpc/5200: add mpc5200_psc_ac97_gpio_reset
Date: Tue, 15 Jun 2010 17:53:35 -0400
Message-ID: <1276638815-6834-1-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1276617907-10862-2-git-send-email-emillbrandt@dekaresearch.com>
References: <1276617907-10862-2-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Work around a silicon bug in the ac97 reset functionality of the
mpc5200(b).  The implementation of the ac97 "cold" reset is flawed.
If the sync and output lines are high when reset is asserted the
attached ac97 device may go into test mode.  Avoid this by
reconfiguring the psc to gpio mode and generating the reset manually.

>From MPC5200B User's Manual:
"Some AC97 devices goes to a test mode, if the Sync line is high
during the Res line is low (reset phase). To avoid this behavior the
Sync line must be also forced to zero during the reset phase. To do
that, the pin muxing should switch to GPIO mode and the GPIO control
register should be used to control the output lines."

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---

changes since v1
- Amended with comments from Mark Brown
- Fall back to the original reset implementation if no gpio pins are define=
d
  in the device tree

changes since v2
- Refactored to move the port_config manipulation to platform code.
- Remove the gpio pins from the device-tree

changes since v3
- Remove redundant checks around call to mpc5200_psc_ac97_gpio_reset()

changes since v4
- cleanup inverted logic

 arch/powerpc/include/asm/mpc52xx.h           |    1 +
 arch/powerpc/include/asm/mpc52xx_psc.h       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  111 ++++++++++++++++++++++=
++++
 3 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index b664ce7..1f41382 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -271,6 +271,7 @@ struct mpc52xx_intr {
 /* mpc52xx_common.c */
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
+extern int mpc5200_psc_ac97_gpio_reset(int psc_number);
 extern void mpc52xx_map_common_devices(void);
 extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
 extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/=
asm/mpc52xx_psc.h
index ecc4fc6..2966df6 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -131,6 +131,7 @@
 #define MPC52xx_PSC_SICR_SIM_FIR               (0x6 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_24          (0x7 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_32          (0xf << 24)
+#define MPC52xx_PSC_SICR_ACRB                  (0x8 << 24)
 #define MPC52xx_PSC_SICR_AWR                   (1 << 30)
 #define MPC52xx_PSC_SICR_GENCLK                        (1 << 23)
 #define MPC52xx_PSC_SICR_I2S                   (1 << 22)
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/pl=
atforms/52xx/mpc52xx_common.c
index a46bad0..1887872 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -12,9 +12,11 @@

 #undef DEBUG

+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
@@ -82,6 +84,14 @@ mpc5200_setup_xlb_arbiter(void)
        iounmap(xlb);
 }

+/*
+ * This variable is mapped in mpc52xx_map_common_devices and
+ * used in mpc5200_psc_ac97_gpio_reset().
+ */
+static DEFINE_SPINLOCK(gpio_lock);
+struct mpc52xx_gpio __iomem *simple_gpio;
+struct mpc52xx_gpio_wkup __iomem *wkup_gpio;
+
 /**
  * mpc52xx_declare_of_platform_devices: register internal devices and chil=
dren
  *                                     of the localplus bus to the of_plat=
form
@@ -109,6 +119,19 @@ static struct of_device_id mpc52xx_cdm_ids[] __initdat=
a =3D {
        { .compatible =3D "mpc5200-cdm", }, /* old */
        {}
 };
+static const struct of_device_id mpc52xx_gpio_simple[] =3D {
+       {
+               .compatible =3D "fsl,mpc5200-gpio",
+       },
+       {}
+};
+static const struct of_device_id mpc52xx_gpio_wkup[] =3D {
+       {
+               .compatible =3D "fsl,mpc5200-gpio-wkup",
+       },
+       {}
+};
+

 /**
  * mpc52xx_map_common_devices: iomap devices required by common code
@@ -135,6 +158,16 @@ mpc52xx_map_common_devices(void)
        np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
        mpc52xx_cdm =3D of_iomap(np, 0);
        of_node_put(np);
+
+       /* simple_gpio registers */
+       np =3D of_find_matching_node(NULL, mpc52xx_gpio_simple);
+       simple_gpio =3D of_iomap(np, 0);
+       of_node_put(np);
+
+       /* wkup_gpio registers */
+       np =3D of_find_matching_node(NULL, mpc52xx_gpio_wkup);
+       wkup_gpio =3D of_iomap(np, 0);
+       of_node_put(np);
 }

 /**
@@ -233,3 +266,81 @@ mpc52xx_restart(char *cmd)

        while (1);
 }
+
+#define PSC1_RESET     0x1
+#define PSC1_SYNC      0x4
+#define PSC1_SDATA_OUT 0x1
+#define PSC2_RESET     0x2
+#define PSC2_SYNC      (0x4<<4)
+#define PSC2_SDATA_OUT (0x1<<4)
+#define MPC52xx_GPIO_PSC1_MASK 0x7
+#define MPC52xx_GPIO_PSC2_MASK (0x7<<4)
+
+/**
+ * mpc5200_psc_ac97_gpio_reset: Use gpio pins to reset the ac97 bus
+ *
+ * @psc: psc number to reset (only psc 1 and 2 support ac97)
+ */
+int mpc5200_psc_ac97_gpio_reset(int psc_number)
+{
+       unsigned long flags;
+       u32 gpio;
+       u32 mux;
+       int out;
+       int reset;
+       int sync;
+
+       if ((!simple_gpio) || (!wkup_gpio))
+               return -ENODEV;
+
+       switch (psc_number) {
+       case 0:
+               reset   =3D PSC1_RESET;           /* AC97_1_RES */
+               sync    =3D PSC1_SYNC;            /* AC97_1_SYNC */
+               out     =3D PSC1_SDATA_OUT;       /* AC97_1_SDATA_OUT */
+               gpio    =3D MPC52xx_GPIO_PSC1_MASK;
+               break;
+       case 1:
+               reset   =3D PSC2_RESET;           /* AC97_2_RES */
+               sync    =3D PSC2_SYNC;            /* AC97_2_SYNC */
+               out     =3D PSC2_SDATA_OUT;       /* AC97_2_SDATA_OUT */
+               gpio    =3D MPC52xx_GPIO_PSC2_MASK;
+               break;
+       default:
+               printk(KERN_ERR __FILE__ ": "
+                     "Unable to determine PSC, no ac97 cold-reset will be =
"
+                     "performed\n");
+               return -ENODEV;
+       }
+
+       spin_lock_irqsave(&gpio_lock, flags);
+
+       /* Reconfiure pin-muxing to gpio */
+       mux =3D in_be32(&simple_gpio->port_config);
+       out_be32(&simple_gpio->port_config, mux & (~gpio));
+
+       /* enable gpio pins for output */
+       setbits8(&wkup_gpio->wkup_gpioe, reset);
+       setbits32(&simple_gpio->simple_gpioe, sync | out);
+
+       setbits8(&wkup_gpio->wkup_ddr, reset);
+       setbits32(&simple_gpio->simple_ddr, sync | out);
+
+       /* Assert cold reset */
+       clrbits32(&simple_gpio->simple_dvo, sync | out);
+       clrbits8(&wkup_gpio->wkup_dvo, reset);
+
+       /* wait at lease 1 us */
+       udelay(2);
+
+       /* Deassert reset */
+       setbits8(&wkup_gpio->wkup_dvo, reset);
+
+       /* Restore pin-muxing */
+       out_be32(&simple_gpio->port_config, mux);
+
+       spin_unlock_irqrestore(&gpio_lock, flags);
+
+       return 0;
+}
+EXPORT_SYMBOL(mpc5200_psc_ac97_gpio_reset);
--
-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

1.6.3.1


This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
