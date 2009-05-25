Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id A768BDDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 16:17:12 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1440236ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 23:17:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090525013849.3073.96729.stgit@terra>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013849.3073.96729.stgit@terra>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 00:16:51 -0600
Message-ID: <fa686aa40905242316j3e8b46e7mcc71dc34df209003@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> AC97 driver for mpc5200
>
> I've implemented retries for when the AC97 hardware doesn't reset on
> first try. About 10% of the time both the Efika and pcm030 AC97 codecs
> don't reset on first try and need to be poked multiple times. =A0Failure
> is indicated by not having the link clock start ticking. Every once in
> a while even five pokes won't get the link started and I have to power
> cycle.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
> =A0sound/soc/fsl/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01
> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0392 ++++++++++++++++++++++++++++=
++++++++++
> =A0sound/soc/fsl/mpc5200_psc_ac97.h | =A0 15 +
> =A04 files changed, 419 insertions(+), 0 deletions(-)
> =A0create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
> =A0create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 1918c78..3bce952 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -29,3 +29,14 @@ config SND_SOC_MPC5200_I2S
> =A0 =A0 =A0 =A0select PPC_BESTCOMM_GEN_BD
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here to support the MPC5200 PSCs in I2S mode.
> +
> +config SND_SOC_MPC5200_AC97
> + =A0 =A0 =A0 tristate "Freescale MPC5200 PSC in AC97 mode driver"
> + =A0 =A0 =A0 depends on PPC_MPC52xx && PPC_BESTCOMM
> + =A0 =A0 =A0 select AC97_BUS
> + =A0 =A0 =A0 select SND_MPC52xx_DMA
> + =A0 =A0 =A0 select PPC_BESTCOMM_GEN_BD
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here to support the MPC5200 PSCs in AC97 mode.
> +
> +
> diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> index 7731ef2..14631a1 100644
> --- a/sound/soc/fsl/Makefile
> +++ b/sound/soc/fsl/Makefile
> @@ -13,4 +13,5 @@ obj-$(CONFIG_SND_SOC_MPC8610) +=3D snd-soc-fsl-ssi.o sn=
d-soc-fsl-dma.o
> =A0# MPC5200 Platform Support
> =A0obj-$(CONFIG_SND_MPC52xx_DMA) +=3D mpc5200_dma.o
> =A0obj-$(CONFIG_SND_SOC_MPC5200_I2S) +=3D mpc5200_psc_i2s.o
> +obj-$(CONFIG_SND_SOC_MPC5200_AC97) +=3D mpc5200_psc_ac97.o
>
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc=
_ac97.c
> new file mode 100644
> index 0000000..480b677
> --- /dev/null
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -0,0 +1,392 @@
> +/*
> + * linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx =
chip.
> + *
> + * Copyright (C) 2009 Jon Smirl, Digispeaker
> + * Author: Jon Smirl <jonsmirl@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <asm/mpc52xx_psc.h>
> +
> +#include "mpc5200_dma.h"
> +#include "mpc5200_psc_ac97.h"
> +
> +#define DRV_NAME "mpc5200-psc-ac97"
> +
> +/* ALSA only supports a single AC97 device so static is recommend here *=
/
> +static struct psc_dma *psc_dma;
> +
> +static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned shor=
t reg)
> +{
> + =A0 =A0 =A0 int timeout;
> + =A0 =A0 =A0 unsigned int val;
> +
> + =A0 =A0 =A0 spin_lock(&psc_dma->lock);
> +
> + =A0 =A0 =A0 /* Wait for it to be ready */
> + =A0 =A0 =A0 timeout =3D 1000;
> + =A0 =A0 =A0 while ((--timeout) && (in_be16(&psc_dma->psc_regs->sr_csr.s=
tatus) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MPC52xx_PSC_SR_CMDSEND))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);

Holy unbounded latency Batman!  This code waits up to 10ms for a register r=
ead!

I hate spinning, but if it must be done; I'd like to see it small.
What is the worst case latency? 125us for 8000Hz bus speed?  If you
must spin; can a cpu_relax() be used instead of the udelay() while
watch the timebase?  Timur recently posted a patch which makes this
easier.

http://patchwork.ozlabs.org/patch/27414/

They *should* be appearing in Ben's -next branch soon.

> +
> + =A0 =A0 =A0 if (!timeout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("timeout on ac97 bus (rdy)\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0xffff;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Do the read */
> + =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x=
7f) << 24));
> +
> + =A0 =A0 =A0 /* Wait for the answer */
> + =A0 =A0 =A0 timeout =3D 1000;
> + =A0 =A0 =A0 while ((--timeout) && !(in_be16(&psc_dma->psc_regs->sr_csr.=
status) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 MPC52xx_PSC_SR_DATA_VAL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);

ditto.

> +static int psc_ac97_cold_reset_check(struct snd_ac97 *ac97)
> +{
> + =A0 =A0 =A0 int max_reset, timeout;
> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
> +
> + =A0 =A0 =A0 /* AC97 clock is generated by the codec.
> + =A0 =A0 =A0 =A0* Ensure that it starts ticking after codec reset.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (max_reset =3D 0; max_reset < 5; max_reset++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do a cold reset */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->op1, MPC52xx_PSC_OP_RES);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->op0, MPC52xx_PSC_OP_RES);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(50);

:-/  Don't like, but don't know if there is an alternative.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PSC recover from cold reset
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (cfr user manual, not sure if useful)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&regs->sicr, in_be32(&regs->sicr))=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_ac97_warm_reset(ac97);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* first make sure AC97 clock is low */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (timeout =3D 0; ((in_8(&regs->ipcr_acr.=
ipcr) & 0x80) !=3D 0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timeout < =
100); timeout++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 100)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* then wait for the transition to high */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (timeout =3D 0; ((in_8(&regs->ipcr_acr.=
ipcr) & 0x80) =3D=3D 0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (timeout < =
100); timeout++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 100)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;

Using udelay makes this less accurate.  Only possible reason to use a
udelay is if the register cannot be polled at full speed (which is
possibly the case if it adds bus contention; but I don't think it is
an issue here).

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
