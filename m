Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 0CB711007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Jun 2010 07:55:09 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2 v2] powerpc/5200: add mpc5200_psc_ac97_gpio_reset
Date: Mon, 14 Jun 2010 17:55:17 -0400
Message-ID: <1276552518-11441-2-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
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
- Refactored to manipulate port_config and gpio pins internally instead of
  exporting an API.

 arch/powerpc/include/asm/mpc52xx.h           |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  103 ++++++++++++++++++++++=
++++
 2 files changed, 104 insertions(+), 0 deletions(-)

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
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/pl=
atforms/52xx/mpc52xx_common.c
index a46bad0..a9866fa 100644
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
@@ -37,6 +39,11 @@ static struct of_device_id mpc52xx_bus_ids[] __initdata =
=3D {
        {}
 };

+static struct of_device_id mpc52xx_gpio_simple[] =3D {
+       { .compatible =3D "fsl,mpc5200-gpio", },
+       {}
+};
+
 /*
  * This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_restar=
t().
  * Permanent mapping is required because mpc52xx_restart() can be called
@@ -82,6 +89,13 @@ mpc5200_setup_xlb_arbiter(void)
        iounmap(xlb);
 }

+/*
+ * This variable is mapped in mpc52xx_write_port_config() and
+ * mpc52xx_read_port_config().
+ */
+DEFINE_SPINLOCK(mpc52xx_gpio_lock);
+static u32 __iomem *port_config;
+
 /**
  * mpc52xx_declare_of_platform_devices: register internal devices and chil=
dren
  *                                     of the localplus bus to the of_plat=
form
@@ -117,6 +131,7 @@ void __init
 mpc52xx_map_common_devices(void)
 {
        struct device_node *np;
+       const u32 *regaddr;

        /* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
         * possibly from a interrupt context. wdt is only implement
@@ -135,6 +150,13 @@ mpc52xx_map_common_devices(void)
        np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
        mpc52xx_cdm =3D of_iomap(np, 0);
        of_node_put(np);
+
+       /* port_config register */
+       np =3D of_find_matching_node(NULL, mpc52xx_gpio_simple);
+       regaddr =3D of_get_address(np, 0, NULL, NULL);
+       port_config =3D ioremap((u32) of_translate_address(np, regaddr), 0x=
4);
+
+       of_node_put(np);
 }

 /**
@@ -233,3 +255,84 @@ mpc52xx_restart(char *cmd)

        while (1);
 }
+
+#define PSC1_RESET     254
+#define PSC1_SYNC      244
+#define PSC1_SDATA_OUT 246
+#define PSC2_RESET     253
+#define PSC2_SYNC      240
+#define PSC2_SDATA_OUT 242
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
+       if (!port_config)
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
+       gpio_request(reset, "reset");
+       gpio_request(sync, "sync");
+       gpio_request(out, "out");
+
+       spin_lock_irqsave(&mpc52xx_gpio_lock, flags);
+
+       mux =3D in_be32(port_config);
+
+       /* Reconfiure pin-muxing to gpio */
+       out_be32(port_config, mux & (~gpio));
+
+       /* Assert cold reset */
+       gpio_direction_output(sync, 0);
+       gpio_direction_output(out, 0);
+       gpio_direction_output(reset, 0);
+
+       /* wait at lease 1 us */
+       udelay(2);
+
+       /* Deassert reset */
+       gpio_direction_output(reset, 1);
+
+       /* Restore pin-muxing */
+       out_be32(port_config, mux);
+
+       spin_unlock_irqrestore(&mpc52xx_gpio_lock, flags);
+
+       gpio_free(out);
+       gpio_free(sync);
+       gpio_free(reset);
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
