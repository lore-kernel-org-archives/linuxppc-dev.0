Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id C5DCCDE09E
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 16:26:52 +1000 (EST)
Received: by gxk20 with SMTP id 20so1543536gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 23:26:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090525013847.3073.55951.stgit@terra>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013847.3073.55951.stgit@terra>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 00:26:27 -0600
Message-ID: <fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] Main rewite of the mpc5200 audio DMA code
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
> Rewrite the mpc5200 audio DMA code to support both I2S and AC97.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A01
> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 | =A0504 +++++++++++++++++++++++++=
+-------------
> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 | =A0 33 +--
> =A0sound/soc/fsl/mpc5200_psc_i2s.c | =A0247 +++----------------
> =A0sound/soc/fsl/mpc5200_psc_i2s.h | =A0 12 +
> =A05 files changed, 408 insertions(+), 389 deletions(-)
> =A0create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index dc79bdf..1918c78 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -25,7 +25,6 @@ config SND_SOC_MPC8610_HPCD
> =A0config SND_SOC_MPC5200_I2S
> =A0 =A0 =A0 =A0tristate "Freescale MPC5200 PSC in I2S mode driver"
> =A0 =A0 =A0 =A0depends on PPC_MPC52xx && PPC_BESTCOMM
> - =A0 =A0 =A0 select SND_SOC_OF_SIMPLE
> =A0 =A0 =A0 =A0select SND_MPC52xx_DMA
> =A0 =A0 =A0 =A0select PPC_BESTCOMM_GEN_BD
> =A0 =A0 =A0 =A0help
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 6850392..4e1f1f8 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -3,23 +3,13 @@
> =A0* ALSA SoC Platform driver
> =A0*
> =A0* Copyright (C) 2008 Secret Lab Technologies Ltd.
> + * Copyright (C) 2009 Jon Smirl, Digispeaker
> =A0*/
>
> -#include <linux/init.h>
> =A0#include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/delay.h>
> =A0#include <linux/of_device.h>
> -#include <linux/of_platform.h>
> -#include <linux/dma-mapping.h>
>
> -#include <sound/core.h>
> -#include <sound/pcm.h>
> -#include <sound/pcm_params.h>
> -#include <sound/initval.h>
> =A0#include <sound/soc.h>
> -#include <sound/soc-of-simple.h>
>
> =A0#include <sysdev/bestcomm/bestcomm.h>
> =A0#include <sysdev/bestcomm/gen_bd.h>
> @@ -27,10 +17,6 @@
>
> =A0#include "mpc5200_dma.h"
>
> -MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
> -MODULE_DESCRIPTION("Freescale MPC5200 PSC in DMA mode ASoC Driver");
> -MODULE_LICENSE("GPL");
> -
> =A0/*
> =A0* Interrupt handlers
> =A0*/
> @@ -50,7 +36,7 @@ static irqreturn_t psc_dma_status_irq(int irq, void *_p=
sc_dma)
> =A0 =A0 =A0 =A0if (psc_dma->capture.active && (isr & MPC52xx_PSC_IMR_ORER=
R))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psc_dma->stats.overrun_count++;
>
> - =A0 =A0 =A0 out_8(&regs->command, 4 << 4); =A0/* reset the error status=
 */
> + =A0 =A0 =A0 out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -81,8 +67,21 @@ static void psc_dma_bcom_enqueue_next_buffer(struct ps=
c_dma_stream *s)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_next_pt =3D s->period_start;
> =A0}
>
> +static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
> +{
> + =A0 =A0 =A0 while (s->appl_ptr < s->runtime->control->appl_ptr) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bcom_queue_full(s->bcom_task))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr +=3D s->period_size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> + =A0 =A0 =A0 }
> +}
> +
> =A0/* Bestcomm DMA irq handler */
> -static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
> +static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
> =A0{
> =A0 =A0 =A0 =A0struct psc_dma_stream *s =3D _psc_dma_stream;
>
> @@ -90,12 +89,12 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_p=
sc_dma_stream)
> =A0 =A0 =A0 =A0 * and enqueue a new one in it's place. */
> =A0 =A0 =A0 =A0while (bcom_buffer_done(s->bcom_task)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_retrieve_buffer(s->bcom_task, NULL, N=
ULL);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current_pt +=3D s->period_bytes;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (s->period_current_pt >=3D s->period_en=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current_pt =3D s=
->period_start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_enable(s->bcom_task);
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 psc_dma_bcom_enqueue_tx(s);
>
> =A0 =A0 =A0 =A0/* If the stream is active, then also inform the PCM middl=
e layer
> =A0 =A0 =A0 =A0 * of the period finished event. */
> @@ -105,49 +104,31 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *=
_psc_dma_stream)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> -/**
> - * psc_dma_startup: create a new substream
> - *
> - * This is the first function called when a stream is opened.
> - *
> - * If this is the first stream open, then grab the IRQ and program most =
of
> - * the PSC registers.
> - */
> -int psc_dma_startup(struct snd_pcm_substream *substream,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> +static irqreturn_t psc_dma_bcom_irq_rx(int irq, void *_psc_dma_stream)
> =A0{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_data=
;
> - =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 struct psc_dma_stream *s =3D _psc_dma_stream;
>
> - =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_startup(substream=3D%p)\n", =
substream);
> + =A0 =A0 =A0 /* For each finished period, dequeue the completed period b=
uffer
> + =A0 =A0 =A0 =A0* and enqueue a new one in it's place. */
> + =A0 =A0 =A0 while (bcom_buffer_done(s->bcom_task)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(s->bcom_task, NULL, NU=
LL);
>
> - =A0 =A0 =A0 if (!psc_dma->playback.active &&
> - =A0 =A0 =A0 =A0 =A0 !psc_dma->capture.active) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the IRQs */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(psc_dma->irq, &psc_dma_s=
tatus_irq, IRQF_SHARED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"psc-dma=
-status", psc_dma);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_dma->capture.irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_dm=
a_bcom_irq, IRQF_SHARED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-dm=
a-capture", &psc_dma->capture);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_dma->playback.irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_dm=
a_bcom_irq, IRQF_SHARED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-dm=
a-playback", &psc_dma->playback);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->irq, psc_=
dma);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->capture.i=
rq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_dma=
->capture);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->playback.=
irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_dma=
->playback);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt +=3D s->period_bytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->period_current_pt >=3D s->period_end=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s-=
>period_start;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 /* If the stream is active, then also inform the PCM middle=
 layer
> + =A0 =A0 =A0 =A0* of the period finished event. */
> + =A0 =A0 =A0 if (s->active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_period_elapsed(s->stream);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> =A0}
>
> -int psc_dma_hw_free(struct snd_pcm_substream *substream,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> +static int psc_dma_hw_free(struct snd_pcm_substream *substream)
> =A0{
> =A0 =A0 =A0 =A0snd_pcm_set_runtime_buffer(substream, NULL);
> =A0 =A0 =A0 =A0return 0;
> @@ -159,8 +140,7 @@ int psc_dma_hw_free(struct snd_pcm_substream *substre=
am,
> =A0* This function is called by ALSA to start, stop, pause, and resume th=
e DMA
> =A0* transfer of data.
> =A0*/
> -int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai)
> +static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
> =A0{
> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_dat=
a;
> =A0 =A0 =A0 =A0struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
> @@ -168,8 +148,8 @@ int psc_dma_trigger(struct snd_pcm_substream *substre=
am, int cmd,
> =A0 =A0 =A0 =A0struct psc_dma_stream *s;
> =A0 =A0 =A0 =A0struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
> =A0 =A0 =A0 =A0u16 imr;
> - =A0 =A0 =A0 u8 psc_cmd;
> =A0 =A0 =A0 =A0unsigned long flags;
> + =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTUR=
E)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s =3D &psc_dma->capture;
> @@ -189,68 +169,45 @@ int psc_dma_trigger(struct snd_pcm_substream *subst=
ream, int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(s->period=
_bytes * runtime->periods);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_next_pt =3D s->period_start;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current_pt =3D s->period_start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_size =3D runtime->period_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->active =3D 1;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First; reset everything */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* track appl_ptr so that we have a better =
chance of detecting
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* end of stream and not over running it.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->runtime =3D runtime;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr =3D s->runtime->control->appl_p=
tr -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (runtime->p=
eriod_size * runtime->periods);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fill up the bestcomm bd queue and enable=
 DMA.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This will begin filling the PSC's fifo=
.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_P=
CM_STREAM_CAPTURE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_ERR_STAT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_rx_reset(s->bco=
m_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < runtime->=
periods; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bcom_q=
ueue_full(s->bcom_task))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_TX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52=
xx_PSC_RST_ERR_STAT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_tx_reset(s->bco=
m_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_tx(s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_b=
uffer(s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_enable(s->bcom_task);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Due to errata in the dma mode; need to l=
ine up enabling
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the transmitter with a transition on t=
he frame sync
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* line */
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&psc_dma->lock, flags);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->command, MPC52xx_PSC_RST_ERR_S=
TAT);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&psc_dma->lock, fla=
gs);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case SNDRV_PCM_TRIGGER_STOP:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Turn off the PSC */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->active =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_dma->playback.acti=
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_dma->capture.activ=
e)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs=
->command, 2 << 4); =A0/* reset rx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_disable(s->bcom_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!bcom_queue_empty(s->bcom_task))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(s->bco=
m_task, NULL, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_rx_reset(s->bco=
m_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_tx_reset(s->bco=
m_task);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -265,44 +222,11 @@ int psc_dma_trigger(struct snd_pcm_substream *subst=
ream, int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imr |=3D MPC52xx_PSC_IMR_TXEMP;
> =A0 =A0 =A0 =A0if (psc_dma->capture.active)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imr |=3D MPC52xx_PSC_IMR_ORERR;
> - =A0 =A0 =A0 out_be16(&regs->isr_imr.imr, imr);
> + =A0 =A0 =A0 out_be16(&regs->isr_imr.imr, psc_dma->imr | imr);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/**
> - * psc_dma_shutdown: shutdown the data transfer on a stream
> - *
> - * Shutdown the PSC if there are no other substreams open.
> - */
> -void psc_dma_shutdown(struct snd_pcm_substream *substream,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_d=
ai *dai)
> -{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data=
;
> - =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_data=
;
> -
> - =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_shutdown(substream=3D%p)\n",=
 substream);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* If this is the last active substream, disable the PSC =
and release
> - =A0 =A0 =A0 =A0* the IRQ.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!psc_dma->playback.active &&
> - =A0 =A0 =A0 =A0 =A0 !psc_dma->capture.active) {
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable all interrupts and reset the PSC=
 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(&psc_dma->psc_regs->isr_imr.imr, 0=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 3 << 4);=
 /* reset tx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 2 << 4);=
 /* reset rx */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 1 << 4);=
 /* reset mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 4 << 4);=
 /* reset error */
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Release irqs */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->irq, psc_dma);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->capture.irq, &psc_dma->ca=
pture);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->playback.irq, &psc_dma->p=
layback);
> - =A0 =A0 =A0 }
> -}
>
> =A0/* -------------------------------------------------------------------=
--
> =A0* The PSC DMA 'ASoC platform' driver
> @@ -312,62 +236,78 @@ void psc_dma_shutdown(struct snd_pcm_substream *sub=
stream,
> =A0* interaction with the attached codec
> =A0*/
>
> -static const struct snd_pcm_hardware psc_dma_pcm_hardware =3D {
> +static const struct snd_pcm_hardware psc_dma_hardware =3D {
> =A0 =A0 =A0 =A0.info =3D SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID =
|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INF=
O_BLOCK_TRANSFER |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_INFO_BATCH,
> =A0 =A0 =A0 =A0.formats =3D SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE=
 |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_=
FMTBIT_S32_BE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_=
S32_BE,

Unrelated whitespace changes?

> +/* ---------------------------------------------------------------------
> + * Sysfs attributes for error monitoring
> + */

All this sysfs stuff should be dropped from this patch.  It is an
abuse of sysfs and I never should have written it this way.  Feel free
to put it in a separate patch so others can use it if they really need
it, but I'd like it to not be kept in mainline.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
