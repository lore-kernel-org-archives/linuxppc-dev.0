Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id B188CB7D7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Jun 2010 09:09:37 +1000 (EST)
Received: by ywh11 with SMTP id 11so3276780ywh.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Jun 2010 16:09:35 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276552518-11441-3-git-send-email-emillbrandt@dekaresearch.com>
References: <1276552518-11441-1-git-send-email-emillbrandt@dekaresearch.com>
	<1276552518-11441-2-git-send-email-emillbrandt@dekaresearch.com>
	<1276552518-11441-3-git-send-email-emillbrandt@dekaresearch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Jun 2010 17:09:15 -0600
Message-ID: <AANLkTikdzQ2i5QWDTG9sfpS_TChu44NbZWft936nCNFi@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] sound/soc: mpc5200_psc_ac97: Use gpio pins for
	cold reset
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 14, 2010 at 3:55 PM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> Call the gpio reset platform function instead of using the flawed
> ac97 functionality of the MPC5200(b)
>
> From MPC5200B User's Manual:
> "Some AC97 devices goes to a test mode, if the Sync line is high
> during the Res line is low (reset phase). To avoid this behavior the
> Sync line must be also forced to zero during the reset phase. To do
> that, the pin muxing should switch to GPIO mode and the GPIO control
> register should be used to control the output lines."
>
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
>
> changes since v1
> - Amended with comments from Mark Brown
> - Fall back to the original reset implementation if no gpio pins are defi=
ned
> =A0in the device tree
>
> changes since v2
> - Refactored to move the port_config manipulation to platform code.
> - Remove the gpio pins from the device-tree
>
> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0 33 ++++++++++++++++++++++++++++=
+----
> =A01 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc=
_ac97.c
> index e2ee220..380a127 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -20,6 +20,7 @@
>
> =A0#include <asm/time.h>
> =A0#include <asm/delay.h>
> +#include <asm/mpc52xx.h>
> =A0#include <asm/mpc52xx_psc.h>
>
> =A0#include "mpc5200_dma.h"
> @@ -100,19 +101,43 @@ static void psc_ac97_warm_reset(struct snd_ac97 *ac=
97)
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
>
> + =A0 =A0 =A0 mutex_lock(&psc_dma->mutex);
> +
> =A0 =A0 =A0 =A0out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR=
);
> =A0 =A0 =A0 =A0udelay(3);
> =A0 =A0 =A0 =A0out_be32(&regs->sicr, psc_dma->sicr);
> +
> + =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
> =A0}
>
> +#define =A0MPC52xx_PSC_SICR_ACRB (0x8 << 24)

Put this #define with the rest of the MPC52xx_PSC_SICR_* #defines.

> =A0static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
>
> - =A0 =A0 =A0 /* Do a cold reset */
> - =A0 =A0 =A0 out_8(&regs->op1, MPC52xx_PSC_OP_RES);
> - =A0 =A0 =A0 udelay(10);
> - =A0 =A0 =A0 out_8(&regs->op0, MPC52xx_PSC_OP_RES);
> + =A0 =A0 =A0 mutex_lock(&psc_dma->mutex);
> +
> + =A0 =A0 =A0 switch (psc_dma->id) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5200_psc_ac97_gpio_reset(psc_dma->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(psc_dma->dev, "cold reset\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Notify the PSC that a reset has occurred=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&regs->sicr, psc_dma->sicr | MPC52=
xx_PSC_SICR_ACRB);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re-enable RX and TX */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52xx_PSC_TX_ENABLE=
 | MPC52xx_PSC_RX_ENABLE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(psc_dma->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to determine PSC, n=
o cold-reset will be "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "performed\n");
> + =A0 =A0 =A0 }

You can drop the switch block and the error message.  You do exactly
the same thing in the common code.  Just call
mpc5200_psc_ac97_gpio_reset() unconditionally.

Otherwise, this version looks pretty good.  After you've respun both
patches (I've got comments to make on the other too), and if it's okay
by Mark, then I can merge both patches through my tree.

Cheers,
g.
