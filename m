Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id CA1BB100800
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Jun 2010 07:55:09 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2 v3] sound/soc: mpc5200_psc_ac97: Use gpio pins for cold
	reset
Date: Mon, 14 Jun 2010 17:55:18 -0400
Message-ID: <1276552518-11441-3-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1276552518-11441-2-git-send-email-emillbrandt@dekaresearch.com>
References: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
	<1276552518-11441-2-git-send-email-emillbrandt@dekaresearch.com>
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

Call the gpio reset platform function instead of using the flawed
ac97 functionality of the MPC5200(b)

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

 sound/soc/fsl/mpc5200_psc_ac97.c |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_a=
c97.c
index e2ee220..380a127 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -20,6 +20,7 @@

 #include <asm/time.h>
 #include <asm/delay.h>
+#include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>

 #include "mpc5200_dma.h"
@@ -100,19 +101,43 @@ static void psc_ac97_warm_reset(struct snd_ac97 *ac97=
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

+#define  MPC52xx_PSC_SICR_ACRB (0x8 << 24)
 static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
        struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;

-       /* Do a cold reset */
-       out_8(&regs->op1, MPC52xx_PSC_OP_RES);
-       udelay(10);
-       out_8(&regs->op0, MPC52xx_PSC_OP_RES);
+       mutex_lock(&psc_dma->mutex);
+
+       switch (psc_dma->id) {
+       case 0:
+       case 1:
+               mpc5200_psc_ac97_gpio_reset(psc_dma->id);
+               dev_info(psc_dma->dev, "cold reset\n");
+
+               /* Notify the PSC that a reset has occurred */
+               out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_ACRB=
);
+
+               /* Re-enable RX and TX */
+               out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_R=
X_ENABLE);
+
+               break;
+       default:
+               dev_err(psc_dma->dev,
+                       "Unable to determine PSC, no cold-reset will be "
+                       "performed\n");
+       }
+
+       mutex_unlock(&psc_dma->mutex);
+
        msleep(1);
        psc_ac97_warm_reset(ac97);
 }
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
