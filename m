Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 1B09CB7D48
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 02:15:45 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2 v2] sound/soc: mpc5200_psc_ac97: Use gpio pins for cold
	reset.
Date: Wed, 9 Jun 2010 11:54:32 -0400
Message-ID: <1276098872-6663-1-git-send-email-emillbrandt@dekaresearch.com>
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

The implementation of the ac97 "cold" reset is flawed.  If the sync and
output lines are high when reset is asserted the attached ac97 device
may go into test mode.  Avoid this by reconfiguring the psc to gpio mode
and generating the reset manually.

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

 arch/powerpc/boot/dts/lite5200.dts  |    3 +
 arch/powerpc/boot/dts/lite5200b.dts |    3 +
 arch/powerpc/boot/dts/pcm030.dts    |    3 +
 arch/powerpc/boot/dts/pcm032.dts    |    3 +
 sound/soc/fsl/mpc5200_dma.h         |    5 ++
 sound/soc/fsl/mpc5200_psc_ac97.c    |   98 +++++++++++++++++++++++++++++++=
++--
 6 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lit=
e5200.dts
index 82ff2b1..cb4e49b 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -180,6 +180,9 @@
                //      compatible =3D "fsl,mpc5200-psc-ac97";
                //      cell-index =3D <1>;
                //      reg =3D <0x2200 0x100>;
+               //      gpios =3D <&gpio 7 0              /* AC97_1_RES */
+               //               &gpio_simple 29 0      /* AC97_1_SYNC */
+               //               &gpio_simple 31 0>;    /* AC97_1_SDATA_OUT=
 */
                //      interrupts =3D <2 2 0>;
                //};

diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/li=
te5200b.dts
index e45a63b..1fb0ac7 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -184,6 +184,9 @@
                //      compatible =3D "fsl,mpc5200b-psc-ac97","fsl,mpc5200=
-psc-ac97";
                //      cell-index =3D <1>;
                //      reg =3D <0x2200 0x100>;
+               //      gpios =3D <&gpio 7 0              /* AC97_1_RES */
+               //               &gpio_simple 29 0      /* AC97_1_SYNC */
+               //               &gpio_simple 31 0>;    /* AC97_1_SDATA_OUT=
 */
                //      interrupts =3D <2 2 0>;
                //};

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm03=
0.dts
index 8a4ec30..0085e0f 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -189,6 +189,9 @@
                        compatible =3D "mpc5200b-psc-ac97","fsl,mpc5200b-ps=
c-ac97";
                        cell-index =3D <0>;
                        reg =3D <0x2000 0x100>;
+                       gpios =3D <&gpio 7 0              /* AC97_1_RES */
+                                &gpio_simple 29 0      /* AC97_1_SYNC */
+                                &gpio_simple 31 0>;    /* AC97_1_SDATA_OUT=
 */
                        interrupts =3D <2 1 0>;
                };

diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm03=
2.dts
index 85d857a..76f86d3 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -189,6 +189,9 @@
                        compatible =3D "fsl,mpc5200b-psc-ac97","fsl,mpc5200=
-psc-ac97";
                        cell-index =3D <0>;
                        reg =3D <0x2000 0x100>;
+                       gpios =3D <&gpio 7 0              /* AC97_1_RES */
+                                &gpio_simple 29 0      /* AC97_1_SYNC */
+                                &gpio_simple 31 0>;    /* AC97_1_SDATA_OUT=
 */
                        interrupts =3D <2 1 0>;
                };

diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index 22208b3..9fb0248 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -61,6 +61,11 @@ struct psc_dma {
        int id;
        unsigned int slots;

+       /* gpio pins locations for cold reset */
+       int reset_gpio;
+       int sync_gpio;
+       int out_gpio;
+
        /* per-stream data */
        struct psc_dma_stream playback;
        struct psc_dma_stream capture;
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_a=
c97.c
index e2ee220..08cd51f 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -9,8 +9,10 @@
  * published by the Free Software Foundation.
  */

+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>

@@ -20,12 +22,17 @@

 #include <asm/time.h>
 #include <asm/delay.h>
+#include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>

 #include "mpc5200_dma.h"
 #include "mpc5200_psc_ac97.h"

 #define DRV_NAME "mpc5200-psc-ac97"
+#define MPC52xx_GPIO_PSC1_MASK 0x7
+#define MPC52xx_GPIO_PSC2_MASK (0x7<<4)
+#define MPC52xx_AC97_PSC1 0x2
+#define MPC52xx_AC97_PSC2 (0x2<<4)

 /* ALSA only supports a single AC97 device so static is recommend here */
 static struct psc_dma *psc_dma;
@@ -100,19 +107,84 @@ static void psc_ac97_warm_reset(struct snd_ac97 *ac97=
)
 {
        struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;

+       mutex_lock(&psc_dma->mutex);
+
        out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
        udelay(3);
        out_be32(&regs->sicr, psc_dma->sicr);
+
+       mutex_unlock(&psc_dma->mutex);
 }

 static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
        struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
+       u32 gpio_mux;
+
+       mutex_lock(&psc_dma->mutex);
+
+       if ((psc_dma->reset_gpio < 0) ||
+           (psc_dma->sync_gpio < 0) ||
+           (psc_dma->out_gpio < 0)) {
+               /* Use the psc function to do a cold reset */
+               out_8(&regs->op1, MPC52xx_PSC_OP_RES);
+               udelay(10);
+               out_8(&regs->op0, MPC52xx_PSC_OP_RES);
+               goto warm;
+       }
+
+       /* Reconfigure pin-muxing to gpio */
+       switch (psc_dma->id) {
+       case 0:
+               gpio_mux =3D MPC52xx_GPIO_PSC1_MASK;
+               break;
+       case 1:
+               gpio_mux =3D MPC52xx_GPIO_PSC2_MASK;
+               break;
+       default:
+               dev_err(psc_dma->dev,
+                       "Unable to determine PSC, no cold-reset will be "
+                       "performed\n");
+               goto warm;
+       }
+
+       dev_info(psc_dma->dev, "cold reset\n");
+       mpc52xx_write_port_config(~gpio_mux, 1);
+
+       /* Assert cold reset */
+       gpio_direction_output(psc_dma->sync_gpio, 0);
+       gpio_direction_output(psc_dma->out_gpio, 0);
+       gpio_direction_output(psc_dma->reset_gpio, 0);
+
+       /* Notify the PSC that a cold reset is occurring */
+       out_be32(&regs->sicr, 0);
+       udelay(2);
+
+       /* Deassert reset */
+       gpio_direction_output(psc_dma->reset_gpio, 1);
+       msleep(1);
+
+       /* Restore pin-muxing */
+       switch (psc_dma->id) {
+       case 0:
+               gpio_mux =3D MPC52xx_AC97_PSC1;
+               break;
+       case 1:
+               gpio_mux =3D MPC52xx_AC97_PSC2;
+               break;
+       default:
+               goto warm;
+       }
+
+       mpc52xx_write_port_config(gpio_mux, 0);
+
+       /* Restore the serial interface mode to AC97 */
+       out_be32(&regs->sicr, psc_dma->sicr);
+       out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE=
);
+
+warm:
+       mutex_unlock(&psc_dma->mutex);

-       /* Do a cold reset */
-       out_8(&regs->op1, MPC52xx_PSC_OP_RES);
-       udelay(10);
-       out_8(&regs->op0, MPC52xx_PSC_OP_RES);
        msleep(1);
        psc_ac97_warm_reset(ac97);
 }
@@ -287,6 +359,24 @@ static int __devinit psc_ac97_of_probe(struct of_devic=
e *op,
        regs =3D psc_dma->psc_regs;
        ac97.private_data =3D psc_dma;

+       psc_dma->reset_gpio =3D of_get_gpio_flags(op->dev.of_node, 0, NULL)=
;
+       psc_dma->sync_gpio =3D of_get_gpio_flags(op->dev.of_node, 1, NULL);
+       psc_dma->out_gpio =3D of_get_gpio_flags(op->dev.of_node, 2, NULL);
+       if ((psc_dma->reset_gpio < 0) ||
+           (psc_dma->sync_gpio < 0) ||
+           (psc_dma->out_gpio < 0)) {
+               dev_err(&op->dev, "error: cannot get GPIO pins; "
+                       "reset=3D%i sync=3D%i out=3D%i, defaulting to norma=
l ac97 "
+                       "reset\n",
+                       psc_dma->reset_gpio,
+                       psc_dma->sync_gpio,
+                       psc_dma->out_gpio);
+       } else {
+               gpio_request(psc_dma->reset_gpio, "psc_dma-reset");
+               gpio_request(psc_dma->sync_gpio, "psc_dma-sync");
+               gpio_request(psc_dma->out_gpio, "psc_dma-out");
+       }
+
        for (i =3D 0; i < ARRAY_SIZE(psc_ac97_dai); i++)
                psc_ac97_dai[i].private_data =3D psc_dma;

--
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
