Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 9639FDDEE7
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 14:04:17 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1058388ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 21:04:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090426195302.4648.99742.stgit@terra>
References: <20090426195215.4648.62017.stgit@terra>
	<20090426195302.4648.99742.stgit@terra>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 26 Apr 2009 22:04:00 -0600
Message-ID: <fa686aa40904262104j5b5026c9t782e51fc1d94f434@mail.gmail.com>
Subject: Re: [PATCH V1 1/3] Basic split of mpc5200 DMA code out from
	mpc5200_psc_i2s
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 26, 2009 at 1:53 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Basic split of mpc5200 DMA code out from i2s into a standalone file.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

But you should really also send this to the ALSA list.  I cannot merge
this patch.

g.

> ---
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A04
> =A0sound/soc/fsl/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 | =A0457 +++++++++++++++++++++++++=
++++++++++++
> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 | =A0 81 +++++++
> =A0sound/soc/fsl/mpc5200_psc_i2s.c | =A0484 -----------------------------=
----------
> =A05 files changed, 546 insertions(+), 482 deletions(-)
> =A0create mode 100644 sound/soc/fsl/mpc5200_dma.c
> =A0create mode 100644 sound/soc/fsl/mpc5200_dma.h
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 9fc9082..dc79bdf 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -1,5 +1,8 @@
> =A0config SND_SOC_OF_SIMPLE
> =A0 =A0 =A0 =A0tristate
> +
> +config SND_MPC52xx_DMA
> + =A0 =A0 =A0 tristate
>
> =A0# ASoC platform support for the Freescale MPC8610 SOC. =A0This compile=
s drivers
> =A0# for the SSI and the Elo DMA controller. =A0You will still need to se=
lect
> @@ -23,6 +26,7 @@ config SND_SOC_MPC5200_I2S
> =A0 =A0 =A0 =A0tristate "Freescale MPC5200 PSC in I2S mode driver"
> =A0 =A0 =A0 =A0depends on PPC_MPC52xx && PPC_BESTCOMM
> =A0 =A0 =A0 =A0select SND_SOC_OF_SIMPLE
> + =A0 =A0 =A0 select SND_MPC52xx_DMA
> =A0 =A0 =A0 =A0select PPC_BESTCOMM_GEN_BD
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here to support the MPC5200 PSCs in I2S mode.
> diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> index f85134c..7731ef2 100644
> --- a/sound/soc/fsl/Makefile
> +++ b/sound/soc/fsl/Makefile
> @@ -10,5 +10,7 @@ snd-soc-fsl-ssi-objs :=3D fsl_ssi.o
> =A0snd-soc-fsl-dma-objs :=3D fsl_dma.o
> =A0obj-$(CONFIG_SND_SOC_MPC8610) +=3D snd-soc-fsl-ssi.o snd-soc-fsl-dma.o
>
> +# MPC5200 Platform Support
> +obj-$(CONFIG_SND_MPC52xx_DMA) +=3D mpc5200_dma.o
> =A0obj-$(CONFIG_SND_SOC_MPC5200_I2S) +=3D mpc5200_psc_i2s.o
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> new file mode 100644
> index 0000000..cccaff4
> --- /dev/null
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -0,0 +1,457 @@
> +/*
> + * Freescale MPC5200 PSC DMA
> + * ALSA SoC Platform driver
> + *
> + * Copyright (C) 2008 Secret Lab Technologies Ltd.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <sound/soc-of-simple.h>
> +
> +#include <sysdev/bestcomm/bestcomm.h>
> +#include <sysdev/bestcomm/gen_bd.h>
> +#include <asm/mpc52xx_psc.h>
> +
> +#include "mpc5200_dma.h"
> +
> +MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
> +MODULE_DESCRIPTION("Freescale MPC5200 PSC in DMA mode ASoC Driver");
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * Interrupt handlers
> + */
> +static irqreturn_t psc_i2s_status_irq(int irq, void *_psc_i2s)
> +{
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D _psc_i2s;
> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_i2s->psc_regs;
> + =A0 =A0 =A0 u16 isr;
> +
> + =A0 =A0 =A0 isr =3D in_be16(&regs->mpc52xx_psc_isr);
> +
> + =A0 =A0 =A0 /* Playback underrun error */
> + =A0 =A0 =A0 if (psc_i2s->playback.active && (isr & MPC52xx_PSC_IMR_TXEM=
P))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->stats.underrun_count++;
> +
> + =A0 =A0 =A0 /* Capture overrun error */
> + =A0 =A0 =A0 if (psc_i2s->capture.active && (isr & MPC52xx_PSC_IMR_ORERR=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->stats.overrun_count++;
> +
> + =A0 =A0 =A0 out_8(&regs->command, 4 << 4); =A0/* reset the error status=
 */
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/**
> + * psc_i2s_bcom_enqueue_next_buffer - Enqueue another audio buffer
> + * @s: pointer to stream private data structure
> + *
> + * Enqueues another audio period buffer into the bestcomm queue.
> + *
> + * Note: The routine must only be called when there is space available i=
n
> + * the queue. =A0Otherwise the enqueue will fail and the audio ring buff=
er
> + * will get out of sync
> + */
> +static void psc_i2s_bcom_enqueue_next_buffer(struct psc_i2s_stream *s)
> +{
> + =A0 =A0 =A0 struct bcom_bd *bd;
> +
> + =A0 =A0 =A0 /* Prepare and enqueue the next buffer descriptor */
> + =A0 =A0 =A0 bd =3D bcom_prepare_next_buffer(s->bcom_task);
> + =A0 =A0 =A0 bd->status =3D s->period_bytes;
> + =A0 =A0 =A0 bd->data[0] =3D s->period_next_pt;
> + =A0 =A0 =A0 bcom_submit_next_buffer(s->bcom_task, NULL);
> +
> + =A0 =A0 =A0 /* Update for next period */
> + =A0 =A0 =A0 s->period_next_pt +=3D s->period_bytes;
> + =A0 =A0 =A0 if (s->period_next_pt >=3D s->period_end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_next_pt =3D s->period_start;
> +}
> +
> +/* Bestcomm DMA irq handler */
> +static irqreturn_t psc_i2s_bcom_irq(int irq, void *_psc_i2s_stream)
> +{
> + =A0 =A0 =A0 struct psc_i2s_stream *s =3D _psc_i2s_stream;
> +
> + =A0 =A0 =A0 /* For each finished period, dequeue the completed period b=
uffer
> + =A0 =A0 =A0 =A0* and enqueue a new one in it's place. */
> + =A0 =A0 =A0 while (bcom_buffer_done(s->bcom_task)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(s->bcom_task, NULL, NU=
LL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt +=3D s->period_bytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->period_current_pt >=3D s->period_end=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s-=
>period_start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s_bcom_enqueue_next_buffer(s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_enable(s->bcom_task);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If the stream is active, then also inform the PCM middle=
 layer
> + =A0 =A0 =A0 =A0* of the period finished event. */
> + =A0 =A0 =A0 if (s->active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_period_elapsed(s->stream);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/**
> + * psc_i2s_startup: create a new substream
> + *
> + * This is the first function called when a stream is opened.
> + *
> + * If this is the first stream open, then grab the IRQ and program most =
of
> + * the PSC registers.
> + */
> +int psc_i2s_startup(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_startup(substream=3D%p)\n", =
substream);
> +
> + =A0 =A0 =A0 if (!psc_i2s->playback.active &&
> + =A0 =A0 =A0 =A0 =A0 !psc_i2s->capture.active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the IRQs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(psc_i2s->irq, &psc_i2s_s=
tatus_irq, IRQF_SHARED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"psc-i2s=
-status", psc_i2s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_i2s->capture.irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_i2=
s_bcom_irq, IRQF_SHARED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-i2=
s-capture", &psc_i2s->capture);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_i2s->playback.irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_i2=
s_bcom_irq, IRQF_SHARED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-i2=
s-playback", &psc_i2s->playback);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->irq, psc_=
i2s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->capture.i=
rq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_i2s=
->capture);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->playback.=
irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_i2s=
->playback);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int psc_i2s_hw_free(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> +{
> + =A0 =A0 =A0 snd_pcm_set_runtime_buffer(substream, NULL);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * psc_i2s_trigger: start and stop the DMA transfer.
> + *
> + * This function is called by ALSA to start, stop, pause, and resume the=
 DMA
> + * transfer of data.
> + */
> +int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> + =A0 =A0 =A0 struct snd_pcm_runtime *runtime =3D substream->runtime;
> + =A0 =A0 =A0 struct psc_i2s_stream *s;
> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_i2s->psc_regs;
> + =A0 =A0 =A0 u16 imr;
> + =A0 =A0 =A0 u8 psc_cmd;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> +
> + =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_trigger(substream=3D%p, cmd=
=3D%i)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " stream_id=3D%i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream, cmd, substream->pstr->stream);
> +
> + =A0 =A0 =A0 switch (cmd) {
> + =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_START:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_bytes =3D frames_to_bytes(runtime=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 runtime->period_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_start =3D virt_to_phys(runtime->d=
ma_area);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_end =3D s->period_start +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (s->period_=
bytes * runtime->periods);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_next_pt =3D s->period_start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s->period_start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->active =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First; reset everything */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_RX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_ERR_STAT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_TX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_ERR_STAT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Next, fill up the bestcomm bd queue and =
enable DMA.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This will begin filling the PSC's fifo=
. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_rx_reset(s->bco=
m_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_tx_reset(s->bco=
m_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!bcom_queue_full(s->bcom_task))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s_bcom_enqueue_next_b=
uffer(s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_enable(s->bcom_task);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Due to errata in the i2s mode; need to l=
ine up enabling
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the transmitter with a transition on t=
he frame sync
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* line */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&psc_i2s->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* first make sure it is low */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) =
!=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* then wait for the transition to high */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) =
=3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Finally, enable the PSC.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Receiver must always be enabled; even =
when we only want
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transmit. =A0(see 15.3.2.3 of MPC5200B=
 User's Guide) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_cmd =3D MPC52xx_PSC_RX_ENABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_PLAYBACK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_cmd |=3D MPC52xx_PSC_TX=
_ENABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, psc_cmd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&psc_i2s->lock, flag=
s);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_STOP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Turn off the PSC */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->active =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_i2s->playback.acti=
ve) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 2 << 4); =A0/* reset rx */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 3 << 4); =A0/* reset tx */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 4 << 4); =A0/* reset err */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, 3 << =
4); =A0/* reset tx */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, 4 << =
4); =A0/* reset err */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_i2s->capture.activ=
e)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 2 << 4); =A0/* reset rx */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_disable(s->bcom_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!bcom_queue_empty(s->bcom_task))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(s->bco=
m_task, NULL, NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "invalid command\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Update interrupt enable settings */
> + =A0 =A0 =A0 imr =3D 0;
> + =A0 =A0 =A0 if (psc_i2s->playback.active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imr |=3D MPC52xx_PSC_IMR_TXEMP;
> + =A0 =A0 =A0 if (psc_i2s->capture.active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 imr |=3D MPC52xx_PSC_IMR_ORERR;
> + =A0 =A0 =A0 out_be16(&regs->isr_imr.imr, imr);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * psc_i2s_shutdown: shutdown the data transfer on a stream
> + *
> + * Shutdown the PSC if there are no other substreams open.
> + */
> +void psc_i2s_shutdown(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_d=
ai *dai)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> +
> + =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_shutdown(substream=3D%p)\n",=
 substream);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If this is the last active substream, disable the PSC =
and release
> + =A0 =A0 =A0 =A0* the IRQ.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!psc_i2s->playback.active &&
> + =A0 =A0 =A0 =A0 =A0 !psc_i2s->capture.active) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable all interrupts and reset the PSC=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(&psc_i2s->psc_regs->isr_imr.imr, 0=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 3 << 4);=
 /* reset tx */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 2 << 4);=
 /* reset rx */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 1 << 4);=
 /* reset mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 4 << 4);=
 /* reset error */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Release irqs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->irq, psc_i2s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->capture.irq, &psc_i2s->ca=
pture);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->playback.irq, &psc_i2s->p=
layback);
> + =A0 =A0 =A0 }
> +}
> +
> +/* ---------------------------------------------------------------------
> + * The PSC DMA 'ASoC platform' driver
> + *
> + * Can be referenced by an 'ASoC machine' driver
> + * This driver only deals with the audio bus; it doesn't have any
> + * interaction with the attached codec
> + */
> +
> +static const struct snd_pcm_hardware psc_i2s_pcm_hardware =3D {
> + =A0 =A0 =A0 .info =3D SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO=
_BLOCK_TRANSFER,
> + =A0 =A0 =A0 .formats =3D SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE =
|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_=
FMTBIT_S32_BE,
> + =A0 =A0 =A0 .rate_min =3D 8000,
> + =A0 =A0 =A0 .rate_max =3D 48000,
> + =A0 =A0 =A0 .channels_min =3D 2,
> + =A0 =A0 =A0 .channels_max =3D 2,
> + =A0 =A0 =A0 .period_bytes_max =A0 =A0 =A0 =3D 1024 * 1024,
> + =A0 =A0 =A0 .period_bytes_min =A0 =A0 =A0 =3D 32,
> + =A0 =A0 =A0 .periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 .periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 256,
> + =A0 =A0 =A0 .buffer_bytes_max =A0 =A0 =A0 =3D 2 * 1024 * 1024,
> + =A0 =A0 =A0 .fifo_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
> +};
> +
> +static int psc_i2s_pcm_open(struct snd_pcm_substream *substream)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s_stream *s;
> +
> + =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_pcm_open(substream=3D%p)\n",=
 substream);
> +
> + =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> +
> + =A0 =A0 =A0 snd_soc_set_runtime_hwparams(substream, &psc_i2s_pcm_hardwa=
re);
> +
> + =A0 =A0 =A0 s->stream =3D substream;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int psc_i2s_pcm_close(struct snd_pcm_substream *substream)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s_stream *s;
> +
> + =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_pcm_close(substream=3D%p)\n"=
, substream);
> +
> + =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> +
> + =A0 =A0 =A0 s->stream =3D NULL;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static snd_pcm_uframes_t
> +psc_i2s_pcm_pointer(struct snd_pcm_substream *substream)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> + =A0 =A0 =A0 struct psc_i2s_stream *s;
> + =A0 =A0 =A0 dma_addr_t count;
> +
> + =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> +
> + =A0 =A0 =A0 count =3D s->period_current_pt - s->period_start;
> +
> + =A0 =A0 =A0 return bytes_to_frames(substream->runtime, count);
> +}
> +
> +static struct snd_pcm_ops psc_i2s_pcm_ops =3D {
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D psc_i2s_pcm_open,
> + =A0 =A0 =A0 .close =A0 =A0 =A0 =A0 =A0=3D psc_i2s_pcm_close,
> + =A0 =A0 =A0 .ioctl =A0 =A0 =A0 =A0 =A0=3D snd_pcm_lib_ioctl,
> + =A0 =A0 =A0 .pointer =A0 =A0 =A0 =A0=3D psc_i2s_pcm_pointer,
> +};
> +
> +static u64 psc_i2s_pcm_dmamask =3D 0xffffffff;
> +static int psc_i2s_pcm_new(struct snd_card *card, struct snd_soc_dai *da=
i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_pcm *pcm)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D pcm->private_data;
> + =A0 =A0 =A0 size_t size =3D psc_i2s_pcm_hardware.buffer_bytes_max;
> + =A0 =A0 =A0 int rc =3D 0;
> +
> + =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_i2s_pcm_new(card=3D%p, dai=
=3D%p, pcm=3D%p)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card, dai, pcm);
> +
> + =A0 =A0 =A0 if (!card->dev->dma_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->dev->dma_mask =3D &psc_i2s_pcm_dmamas=
k;
> + =A0 =A0 =A0 if (!card->dev->coherent_dma_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->dev->coherent_dma_mask =3D 0xffffffff=
;
> +
> + =A0 =A0 =A0 if (pcm->streams[0].substream) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_D=
EV, pcm->dev, size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &pcm->streams[0].substream->dma_buffer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto playback_alloc_err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pcm->streams[1].substream) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_D=
EV, pcm->dev, size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &pcm->streams[1].substream->dma_buffer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto capture_alloc_err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> + capture_alloc_err:
> + =A0 =A0 =A0 if (pcm->streams[0].substream)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_dma_free_pages(&pcm->streams[0].substre=
am->dma_buffer);
> + playback_alloc_err:
> + =A0 =A0 =A0 dev_err(card->dev, "Cannot allocate buffer(s)\n");
> + =A0 =A0 =A0 return -ENOMEM;
> +}
> +
> +static void psc_i2s_pcm_free(struct snd_pcm *pcm)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D pcm->private_data;
> + =A0 =A0 =A0 struct snd_pcm_substream *substream;
> + =A0 =A0 =A0 int stream;
> +
> + =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_i2s_pcm_free(pcm=3D%p)\n", p=
cm);
> +
> + =A0 =A0 =A0 for (stream =3D 0; stream < 2; stream++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream =3D pcm->streams[stream].substrea=
m;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_dma_free_pages(&substre=
am->dma_buffer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->dma_buffer.area =
=3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->dma_buffer.addr =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +struct snd_soc_platform psc_i2s_pcm_soc_platform =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpc5200-psc-audio",
> + =A0 =A0 =A0 .pcm_ops =A0 =A0 =A0 =A0=3D &psc_i2s_pcm_ops,
> + =A0 =A0 =A0 .pcm_new =A0 =A0 =A0 =A0=3D &psc_i2s_pcm_new,
> + =A0 =A0 =A0 .pcm_free =A0 =A0 =A0 =3D &psc_i2s_pcm_free,
> +};
> +
> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
> new file mode 100644
> index 0000000..9a19e8a
> --- /dev/null
> +++ b/sound/soc/fsl/mpc5200_dma.h
> @@ -0,0 +1,81 @@
> +/*
> + * Freescale MPC5200 Audio DMA driver
> + */
> +
> +#ifndef __SOUND_SOC_FSL_MPC5200_DMA_H__
> +#define __SOUND_SOC_FSL_MPC5200_DMA_H__
> +
> +/**
> + * psc_i2s_stream - Data specific to a single stream (playback or captur=
e)
> + * @active: =A0 =A0 =A0 =A0 =A0 =A0flag indicating if the stream is acti=
ve
> + * @psc_i2s: =A0 =A0 =A0 =A0 =A0 pointer back to parent psc_i2s data str=
ucture
> + * @bcom_task: =A0 =A0 =A0 =A0 bestcomm task structure
> + * @irq: =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq number for bestcomm task
> + * @period_start: =A0 =A0 =A0physical address of start of DMA region
> + * @period_end: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0physical address of end o=
f DMA region
> + * @period_next_pt: =A0 =A0physical address of next DMA buffer to enqueu=
e
> + * @period_bytes: =A0 =A0 =A0size of DMA period in bytes
> + */
> +struct psc_i2s_stream {
> + =A0 =A0 =A0 int active;
> + =A0 =A0 =A0 struct psc_i2s *psc_i2s;
> + =A0 =A0 =A0 struct bcom_task *bcom_task;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 struct snd_pcm_substream *stream;
> + =A0 =A0 =A0 dma_addr_t period_start;
> + =A0 =A0 =A0 dma_addr_t period_end;
> + =A0 =A0 =A0 dma_addr_t period_next_pt;
> + =A0 =A0 =A0 dma_addr_t period_current_pt;
> + =A0 =A0 =A0 int period_bytes;
> +};
> +
> +/**
> + * psc_i2s - Private driver data
> + * @name: short name for this device ("PSC0", "PSC1", etc)
> + * @psc_regs: pointer to the PSC's registers
> + * @fifo_regs: pointer to the PSC's FIFO registers
> + * @irq: IRQ of this PSC
> + * @dev: struct device pointer
> + * @dai: the CPU DAI for this device
> + * @sicr: Base value used in serial interface control register; mode is =
ORed
> + * =A0 =A0 =A0 =A0with this value.
> + * @playback: Playback stream context data
> + * @capture: Capture stream context data
> + */
> +struct psc_i2s {
> + =A0 =A0 =A0 char name[32];
> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *psc_regs;
> + =A0 =A0 =A0 struct mpc52xx_psc_fifo __iomem *fifo_regs;
> + =A0 =A0 =A0 unsigned int irq;
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct snd_soc_dai dai;
> + =A0 =A0 =A0 spinlock_t lock;
> + =A0 =A0 =A0 u32 sicr;
> +
> + =A0 =A0 =A0 /* per-stream data */
> + =A0 =A0 =A0 struct psc_i2s_stream playback;
> + =A0 =A0 =A0 struct psc_i2s_stream capture;
> +
> + =A0 =A0 =A0 /* Statistics */
> + =A0 =A0 =A0 struct {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int overrun_count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int underrun_count;
> + =A0 =A0 =A0 } stats;
> +};
> +
> +
> +int psc_i2s_startup(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai);
> +
> +int psc_i2s_hw_free(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai);
> +
> +void psc_i2s_shutdown(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_d=
ai *dai);
> +
> +int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai);
> +
> +extern struct snd_soc_platform psc_i2s_pcm_soc_platform;
> +
> +#endif /* __SOUND_SOC_FSL_MPC5200_DMA_H__ */
> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_=
i2s.c
> index 3aa729d..8974b53 100644
> --- a/sound/soc/fsl/mpc5200_psc_i2s.c
> +++ b/sound/soc/fsl/mpc5200_psc_i2s.c
> @@ -25,6 +25,8 @@
> =A0#include <sysdev/bestcomm/gen_bd.h>
> =A0#include <asm/mpc52xx_psc.h>
>
> +#include "mpc5200_dma.h"
> +
> =A0MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
> =A0MODULE_DESCRIPTION("Freescale MPC5200 PSC in I2S mode ASoC Driver");
> =A0MODULE_LICENSE("GPL");
> @@ -47,179 +49,6 @@ MODULE_LICENSE("GPL");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_FMTBIT_S24_BE |=
 SNDRV_PCM_FMTBIT_S24_BE | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_FMTBIT_S32_BE)
>
> -/**
> - * psc_i2s_stream - Data specific to a single stream (playback or captur=
e)
> - * @active: =A0 =A0 =A0 =A0 =A0 =A0flag indicating if the stream is acti=
ve
> - * @psc_i2s: =A0 =A0 =A0 =A0 =A0 pointer back to parent psc_i2s data str=
ucture
> - * @bcom_task: =A0 =A0 =A0 =A0 bestcomm task structure
> - * @irq: =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq number for bestcomm task
> - * @period_start: =A0 =A0 =A0physical address of start of DMA region
> - * @period_end: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0physical address of end o=
f DMA region
> - * @period_next_pt: =A0 =A0physical address of next DMA buffer to enqueu=
e
> - * @period_bytes: =A0 =A0 =A0size of DMA period in bytes
> - */
> -struct psc_i2s_stream {
> - =A0 =A0 =A0 int active;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s;
> - =A0 =A0 =A0 struct bcom_task *bcom_task;
> - =A0 =A0 =A0 int irq;
> - =A0 =A0 =A0 struct snd_pcm_substream *stream;
> - =A0 =A0 =A0 dma_addr_t period_start;
> - =A0 =A0 =A0 dma_addr_t period_end;
> - =A0 =A0 =A0 dma_addr_t period_next_pt;
> - =A0 =A0 =A0 dma_addr_t period_current_pt;
> - =A0 =A0 =A0 int period_bytes;
> -};
> -
> -/**
> - * psc_i2s - Private driver data
> - * @name: short name for this device ("PSC0", "PSC1", etc)
> - * @psc_regs: pointer to the PSC's registers
> - * @fifo_regs: pointer to the PSC's FIFO registers
> - * @irq: IRQ of this PSC
> - * @dev: struct device pointer
> - * @dai: the CPU DAI for this device
> - * @sicr: Base value used in serial interface control register; mode is =
ORed
> - * =A0 =A0 =A0 =A0with this value.
> - * @playback: Playback stream context data
> - * @capture: Capture stream context data
> - */
> -struct psc_i2s {
> - =A0 =A0 =A0 char name[32];
> - =A0 =A0 =A0 struct mpc52xx_psc __iomem *psc_regs;
> - =A0 =A0 =A0 struct mpc52xx_psc_fifo __iomem *fifo_regs;
> - =A0 =A0 =A0 unsigned int irq;
> - =A0 =A0 =A0 struct device *dev;
> - =A0 =A0 =A0 struct snd_soc_dai dai;
> - =A0 =A0 =A0 spinlock_t lock;
> - =A0 =A0 =A0 u32 sicr;
> -
> - =A0 =A0 =A0 /* per-stream data */
> - =A0 =A0 =A0 struct psc_i2s_stream playback;
> - =A0 =A0 =A0 struct psc_i2s_stream capture;
> -
> - =A0 =A0 =A0 /* Statistics */
> - =A0 =A0 =A0 struct {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int overrun_count;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int underrun_count;
> - =A0 =A0 =A0 } stats;
> -};
> -
> -/*
> - * Interrupt handlers
> - */
> -static irqreturn_t psc_i2s_status_irq(int irq, void *_psc_i2s)
> -{
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D _psc_i2s;
> - =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_i2s->psc_regs;
> - =A0 =A0 =A0 u16 isr;
> -
> - =A0 =A0 =A0 isr =3D in_be16(&regs->mpc52xx_psc_isr);
> -
> - =A0 =A0 =A0 /* Playback underrun error */
> - =A0 =A0 =A0 if (psc_i2s->playback.active && (isr & MPC52xx_PSC_IMR_TXEM=
P))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->stats.underrun_count++;
> -
> - =A0 =A0 =A0 /* Capture overrun error */
> - =A0 =A0 =A0 if (psc_i2s->capture.active && (isr & MPC52xx_PSC_IMR_ORERR=
))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->stats.overrun_count++;
> -
> - =A0 =A0 =A0 out_8(&regs->command, 4 << 4); =A0/* reset the error status=
 */
> -
> - =A0 =A0 =A0 return IRQ_HANDLED;
> -}
> -
> -/**
> - * psc_i2s_bcom_enqueue_next_buffer - Enqueue another audio buffer
> - * @s: pointer to stream private data structure
> - *
> - * Enqueues another audio period buffer into the bestcomm queue.
> - *
> - * Note: The routine must only be called when there is space available i=
n
> - * the queue. =A0Otherwise the enqueue will fail and the audio ring buff=
er
> - * will get out of sync
> - */
> -static void psc_i2s_bcom_enqueue_next_buffer(struct psc_i2s_stream *s)
> -{
> - =A0 =A0 =A0 struct bcom_bd *bd;
> -
> - =A0 =A0 =A0 /* Prepare and enqueue the next buffer descriptor */
> - =A0 =A0 =A0 bd =3D bcom_prepare_next_buffer(s->bcom_task);
> - =A0 =A0 =A0 bd->status =3D s->period_bytes;
> - =A0 =A0 =A0 bd->data[0] =3D s->period_next_pt;
> - =A0 =A0 =A0 bcom_submit_next_buffer(s->bcom_task, NULL);
> -
> - =A0 =A0 =A0 /* Update for next period */
> - =A0 =A0 =A0 s->period_next_pt +=3D s->period_bytes;
> - =A0 =A0 =A0 if (s->period_next_pt >=3D s->period_end)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_next_pt =3D s->period_start;
> -}
> -
> -/* Bestcomm DMA irq handler */
> -static irqreturn_t psc_i2s_bcom_irq(int irq, void *_psc_i2s_stream)
> -{
> - =A0 =A0 =A0 struct psc_i2s_stream *s =3D _psc_i2s_stream;
> -
> - =A0 =A0 =A0 /* For each finished period, dequeue the completed period b=
uffer
> - =A0 =A0 =A0 =A0* and enqueue a new one in it's place. */
> - =A0 =A0 =A0 while (bcom_buffer_done(s->bcom_task)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(s->bcom_task, NULL, NU=
LL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt +=3D s->period_bytes;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->period_current_pt >=3D s->period_end=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s-=
>period_start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s_bcom_enqueue_next_buffer(s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_enable(s->bcom_task);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* If the stream is active, then also inform the PCM middle=
 layer
> - =A0 =A0 =A0 =A0* of the period finished event. */
> - =A0 =A0 =A0 if (s->active)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_period_elapsed(s->stream);
> -
> - =A0 =A0 =A0 return IRQ_HANDLED;
> -}
> -
> -/**
> - * psc_i2s_startup: create a new substream
> - *
> - * This is the first function called when a stream is opened.
> - *
> - * If this is the first stream open, then grab the IRQ and program most =
of
> - * the PSC registers.
> - */
> -static int psc_i2s_startup(struct snd_pcm_substream *substream,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> - =A0 =A0 =A0 int rc;
> -
> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_startup(substream=3D%p)\n", =
substream);
> -
> - =A0 =A0 =A0 if (!psc_i2s->playback.active &&
> - =A0 =A0 =A0 =A0 =A0 !psc_i2s->capture.active) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the IRQs */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(psc_i2s->irq, &psc_i2s_s=
tatus_irq, IRQF_SHARED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"psc-i2s=
-status", psc_i2s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_i2s->capture.irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_i2=
s_bcom_irq, IRQF_SHARED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-i2=
s-capture", &psc_i2s->capture);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_i2s->playback.irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_i2=
s_bcom_irq, IRQF_SHARED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-i2=
s-playback", &psc_i2s->playback);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->irq, psc_=
i2s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->capture.i=
rq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_i2s=
->capture);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->playback.=
irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_i2s=
->playback);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> =A0static int psc_i2s_hw_params(struct snd_pcm_substream *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sn=
d_pcm_hw_params *params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sn=
d_soc_dai *dai)
> @@ -258,164 +87,6 @@ static int psc_i2s_hw_params(struct snd_pcm_substrea=
m *substream,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int psc_i2s_hw_free(struct snd_pcm_substream *substream,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> -{
> - =A0 =A0 =A0 snd_pcm_set_runtime_buffer(substream, NULL);
> - =A0 =A0 =A0 return 0;
> -}
> -
> -/**
> - * psc_i2s_trigger: start and stop the DMA transfer.
> - *
> - * This function is called by ALSA to start, stop, pause, and resume the=
 DMA
> - * transfer of data.
> - */
> -static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> - =A0 =A0 =A0 struct snd_pcm_runtime *runtime =3D substream->runtime;
> - =A0 =A0 =A0 struct psc_i2s_stream *s;
> - =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_i2s->psc_regs;
> - =A0 =A0 =A0 u16 imr;
> - =A0 =A0 =A0 u8 psc_cmd;
> - =A0 =A0 =A0 unsigned long flags;
> -
> - =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> -
> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_trigger(substream=3D%p, cmd=
=3D%i)"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 " stream_id=3D%i\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream, cmd, substream->pstr->stream);
> -
> - =A0 =A0 =A0 switch (cmd) {
> - =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_START:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_bytes =3D frames_to_bytes(runtime=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 runtime->period_size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_start =3D virt_to_phys(runtime->d=
ma_area);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_end =3D s->period_start +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (s->period_=
bytes * runtime->periods);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_next_pt =3D s->period_start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s->period_start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->active =3D 1;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First; reset everything */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_ERR_STAT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_TX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_ERR_STAT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Next, fill up the bestcomm bd queue and =
enable DMA.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This will begin filling the PSC's fifo=
. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_rx_reset(s->bco=
m_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_tx_reset(s->bco=
m_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!bcom_queue_full(s->bcom_task))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s_bcom_enqueue_next_b=
uffer(s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_enable(s->bcom_task);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Due to errata in the i2s mode; need to l=
ine up enabling
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the transmitter with a transition on t=
he frame sync
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* line */
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&psc_i2s->lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* first make sure it is low */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) =
!=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* then wait for the transition to high */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) =
=3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Finally, enable the PSC.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Receiver must always be enabled; even =
when we only want
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transmit. =A0(see 15.3.2.3 of MPC5200B=
 User's Guide) */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_cmd =3D MPC52xx_PSC_RX_ENABLE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_PLAYBACK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_cmd |=3D MPC52xx_PSC_TX=
_ENABLE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, psc_cmd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&psc_i2s->lock, flag=
s);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 case SNDRV_PCM_TRIGGER_STOP:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Turn off the PSC */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->active =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_i2s->playback.acti=
ve) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 2 << 4); =A0/* reset rx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 3 << 4); =A0/* reset tx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 4 << 4); =A0/* reset err */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, 3 << =
4); =A0/* reset tx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, 4 << =
4); =A0/* reset err */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_i2s->capture.activ=
e)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 2 << 4); =A0/* reset rx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_disable(s->bcom_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!bcom_queue_empty(s->bcom_task))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(s->bco=
m_task, NULL, NULL);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "invalid command\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* Update interrupt enable settings */
> - =A0 =A0 =A0 imr =3D 0;
> - =A0 =A0 =A0 if (psc_i2s->playback.active)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 imr |=3D MPC52xx_PSC_IMR_TXEMP;
> - =A0 =A0 =A0 if (psc_i2s->capture.active)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 imr |=3D MPC52xx_PSC_IMR_ORERR;
> - =A0 =A0 =A0 out_be16(&regs->isr_imr.imr, imr);
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -/**
> - * psc_i2s_shutdown: shutdown the data transfer on a stream
> - *
> - * Shutdown the PSC if there are no other substreams open.
> - */
> -static void psc_i2s_shutdown(struct snd_pcm_substream *substream,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_d=
ai *dai)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> -
> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_shutdown(substream=3D%p)\n",=
 substream);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* If this is the last active substream, disable the PSC =
and release
> - =A0 =A0 =A0 =A0* the IRQ.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!psc_i2s->playback.active &&
> - =A0 =A0 =A0 =A0 =A0 !psc_i2s->capture.active) {
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable all interrupts and reset the PSC=
 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(&psc_i2s->psc_regs->isr_imr.imr, 0=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 3 << 4);=
 /* reset tx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 2 << 4);=
 /* reset rx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 1 << 4);=
 /* reset mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 4 << 4);=
 /* reset error */
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Release irqs */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->irq, psc_i2s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->capture.irq, &psc_i2s->ca=
pture);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->playback.irq, &psc_i2s->p=
layback);
> - =A0 =A0 =A0 }
> -}
> -
> =A0/**
> =A0* psc_i2s_set_sysclk: set the clock frequency and direction
> =A0*
> @@ -495,157 +166,6 @@ static struct snd_soc_dai psc_i2s_dai_template =3D =
{
> =A0};
>
> =A0/* -------------------------------------------------------------------=
--
> - * The PSC I2S 'ASoC platform' driver
> - *
> - * Can be referenced by an 'ASoC machine' driver
> - * This driver only deals with the audio bus; it doesn't have any
> - * interaction with the attached codec
> - */
> -
> -static const struct snd_pcm_hardware psc_i2s_pcm_hardware =3D {
> - =A0 =A0 =A0 .info =3D SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO=
_BLOCK_TRANSFER,
> - =A0 =A0 =A0 .formats =3D SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE =
|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_=
FMTBIT_S32_BE,
> - =A0 =A0 =A0 .rate_min =3D 8000,
> - =A0 =A0 =A0 .rate_max =3D 48000,
> - =A0 =A0 =A0 .channels_min =3D 2,
> - =A0 =A0 =A0 .channels_max =3D 2,
> - =A0 =A0 =A0 .period_bytes_max =A0 =A0 =A0 =3D 1024 * 1024,
> - =A0 =A0 =A0 .period_bytes_min =A0 =A0 =A0 =3D 32,
> - =A0 =A0 =A0 .periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> - =A0 =A0 =A0 .periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 256,
> - =A0 =A0 =A0 .buffer_bytes_max =A0 =A0 =A0 =3D 2 * 1024 * 1024,
> - =A0 =A0 =A0 .fifo_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
> -};
> -
> -static int psc_i2s_pcm_open(struct snd_pcm_substream *substream)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s_stream *s;
> -
> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_pcm_open(substream=3D%p)\n",=
 substream);
> -
> - =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> -
> - =A0 =A0 =A0 snd_soc_set_runtime_hwparams(substream, &psc_i2s_pcm_hardwa=
re);
> -
> - =A0 =A0 =A0 s->stream =3D substream;
> - =A0 =A0 =A0 return 0;
> -}
> -
> -static int psc_i2s_pcm_close(struct snd_pcm_substream *substream)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s_stream *s;
> -
> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_pcm_close(substream=3D%p)\n"=
, substream);
> -
> - =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> -
> - =A0 =A0 =A0 s->stream =3D NULL;
> - =A0 =A0 =A0 return 0;
> -}
> -
> -static snd_pcm_uframes_t
> -psc_i2s_pcm_pointer(struct snd_pcm_substream *substream)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_data=
;
> - =A0 =A0 =A0 struct psc_i2s_stream *s;
> - =A0 =A0 =A0 dma_addr_t count;
> -
> - =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
> -
> - =A0 =A0 =A0 count =3D s->period_current_pt - s->period_start;
> -
> - =A0 =A0 =A0 return bytes_to_frames(substream->runtime, count);
> -}
> -
> -static struct snd_pcm_ops psc_i2s_pcm_ops =3D {
> - =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D psc_i2s_pcm_open,
> - =A0 =A0 =A0 .close =A0 =A0 =A0 =A0 =A0=3D psc_i2s_pcm_close,
> - =A0 =A0 =A0 .ioctl =A0 =A0 =A0 =A0 =A0=3D snd_pcm_lib_ioctl,
> - =A0 =A0 =A0 .pointer =A0 =A0 =A0 =A0=3D psc_i2s_pcm_pointer,
> -};
> -
> -static u64 psc_i2s_pcm_dmamask =3D 0xffffffff;
> -static int psc_i2s_pcm_new(struct snd_card *card, struct snd_soc_dai *da=
i,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_pcm *pcm)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D pcm->private_data;
> - =A0 =A0 =A0 size_t size =3D psc_i2s_pcm_hardware.buffer_bytes_max;
> - =A0 =A0 =A0 int rc =3D 0;
> -
> - =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_i2s_pcm_new(card=3D%p, dai=
=3D%p, pcm=3D%p)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card, dai, pcm);
> -
> - =A0 =A0 =A0 if (!card->dev->dma_mask)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->dev->dma_mask =3D &psc_i2s_pcm_dmamas=
k;
> - =A0 =A0 =A0 if (!card->dev->coherent_dma_mask)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->dev->coherent_dma_mask =3D 0xffffffff=
;
> -
> - =A0 =A0 =A0 if (pcm->streams[0].substream) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_D=
EV, pcm->dev, size,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &pcm->streams[0].substream->dma_buffer);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto playback_alloc_err;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (pcm->streams[1].substream) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_D=
EV, pcm->dev, size,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &pcm->streams[1].substream->dma_buffer);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto capture_alloc_err;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return 0;
> -
> - capture_alloc_err:
> - =A0 =A0 =A0 if (pcm->streams[0].substream)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_dma_free_pages(&pcm->streams[0].substre=
am->dma_buffer);
> - playback_alloc_err:
> - =A0 =A0 =A0 dev_err(card->dev, "Cannot allocate buffer(s)\n");
> - =A0 =A0 =A0 return -ENOMEM;
> -}
> -
> -static void psc_i2s_pcm_free(struct snd_pcm *pcm)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D pcm->private_data;
> - =A0 =A0 =A0 struct snd_pcm_substream *substream;
> - =A0 =A0 =A0 int stream;
> -
> - =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_i2s_pcm_free(pcm=3D%p)\n", p=
cm);
> -
> - =A0 =A0 =A0 for (stream =3D 0; stream < 2; stream++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream =3D pcm->streams[stream].substrea=
m;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_dma_free_pages(&substre=
am->dma_buffer);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->dma_buffer.area =
=3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->dma_buffer.addr =
=3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -}
> -
> -struct snd_soc_platform psc_i2s_pcm_soc_platform =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpc5200-psc-audio",
> - =A0 =A0 =A0 .pcm_ops =A0 =A0 =A0 =A0=3D &psc_i2s_pcm_ops,
> - =A0 =A0 =A0 .pcm_new =A0 =A0 =A0 =A0=3D &psc_i2s_pcm_new,
> - =A0 =A0 =A0 .pcm_free =A0 =A0 =A0 =3D &psc_i2s_pcm_free,
> -};
> -
> -/* ---------------------------------------------------------------------
> =A0* Sysfs attributes for debugging
> =A0*/
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
