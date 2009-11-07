Return-Path: <jonsmirl@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 08C4FB7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 23:51:25 +1100 (EST)
Received: by pwi18 with SMTP id 18so1197872pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 04:51:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091107083358.18908.10635.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
Date: Sat, 7 Nov 2009 07:51:23 -0500
Message-ID: <9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
Subject: Re: [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr tracking
	nonsense
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 7, 2009 at 3:34 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> Sound drivers PCM DMA is supposed to free-run until told to stop
> by the trigger callback. =A0The current code tries to track appl_ptr,
> to avoid stale buffer data getting played out at the end of the
> data stream. =A0Unfortunately it also results in race conditions
> which can cause the audio to stall.

I leave in an hour and I will be off net for a week so I can't look at thes=
e.


The problem at end of stream works like this:

last buffer containing music plays
this buffer has been padded with zero to make a full sample
interrupt occurs at end of buffer
 --- at this point the next chained buffer starts playing, it is full of ju=
nk
 --- this chaining happens in hardware
Alsa processes the callback and sends stop stream
--- oops, too late, buffer full of noise has already played several samples
--- these samples of noise are clearly audible.
--- they are usually a fragment from earlier in the song.

Using aplay with short clips like the action sounds for pidgin, etc
makes these noise bursts obviously visible.

To fix this you need a mechanism to determine where the valid data in
the buffering system ends and noise starts. Once you know the extent
of the valid data we can keep the DMA channel programmed to not play
invalid data. You can play off the end of valid data two ways; under
run when ALSA doesn't supply data fast enough and end of buffer.

ALSA does not provide information on where valid data ends in easily
consumable form so I've been trying to reconstruct it from appl_ptr.
A much cleaner solution would be for ALSA to provide a field that
indicates the last valid address in the ring buffer system. Then in
the driver's buffer complete callback I could get that value and
reprogram the DMA engine not to run off the end of valid data. As each
buffer completes I would reread the value and update the DMA stop
address. You also need the last valid address field when DMA is first
started.


>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0sound/soc/fsl/mpc5200_dma.c | =A0 52 +++++++--------------------------=
----------
> =A0sound/soc/fsl/mpc5200_dma.h | =A0 =A02 --
> =A02 files changed, 8 insertions(+), 46 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 986d3c8..4e47586 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -65,36 +65,6 @@ static void psc_dma_bcom_enqueue_next_buffer(struct ps=
c_dma_stream *s)
> =A0 =A0 =A0 =A0s->period_next =3D (s->period_next + 1) % s->runtime->peri=
ods;
> =A0}
>
> -static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
> -{
> - =A0 =A0 =A0 if (s->appl_ptr > s->runtime->control->appl_ptr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In this case s->runtime->control->appl=
_ptr has wrapped around.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Play the data to the end of the bounda=
ry, then wrap our own
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* appl_ptr back around.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (s->appl_ptr < s->runtime->boundary) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bcom_queue_full(s->bcom=
_task))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr +=3D s->runtime=
->period_size;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_b=
uffer(s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr -=3D s->runtime->boundary;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 while (s->appl_ptr < s->runtime->control->appl_ptr) {
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bcom_queue_full(s->bcom_task))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr +=3D s->runtime->period_size;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> - =A0 =A0 =A0 }
> -}
> -
> =A0/* Bestcomm DMA irq handler */
> =A0static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
> =A0{
> @@ -107,8 +77,9 @@ static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *=
_psc_dma_stream)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_retrieve_buffer(s->bcom_task, NULL, N=
ULL);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current =3D (s->period_current+1=
) % s->runtime->periods;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 psc_dma_bcom_enqueue_tx(s);
> =A0 =A0 =A0 =A0spin_unlock(&s->psc_dma->lock);
>
> =A0 =A0 =A0 =A0/* If the stream is active, then also inform the PCM middl=
e layer
> @@ -182,28 +153,21 @@ static int psc_dma_trigger(struct snd_pcm_substream=
 *substream, int cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_next =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->active =3D 1;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* track appl_ptr so that we have a better =
chance of detecting
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* end of stream and not over running it.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->runtime =3D runtime;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr =3D s->runtime->control->appl_p=
tr -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (runtime->p=
eriod_size * runtime->periods);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fill up the bestcomm bd queue and enabl=
e DMA.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * This will begin filling the PSC's fifo.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&psc_dma->lock, flags);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (substream->pstr->stream =3D=3D SNDRV_PC=
M_STREAM_CAPTURE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_gen_bd_rx_reset(s->bc=
om_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < runtime->=
periods; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bcom_q=
ueue_full(s->bcom_task))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 psc_dma_bcom_enqueue_next_buffer(s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_gen_bd_tx_reset(s->bc=
om_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_tx(s);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < runtime->periods; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bcom_queue_full(s->bco=
m_task))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bco=
m_enqueue_next_buffer(s);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_enable(s->bcom_task);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&psc_dma->lock, fla=
gs);
> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
> index 529f7a0..d9c741b 100644
> --- a/sound/soc/fsl/mpc5200_dma.h
> +++ b/sound/soc/fsl/mpc5200_dma.h
> @@ -19,8 +19,6 @@
> =A0*/
> =A0struct psc_dma_stream {
> =A0 =A0 =A0 =A0struct snd_pcm_runtime *runtime;
> - =A0 =A0 =A0 snd_pcm_uframes_t appl_ptr;
> -
> =A0 =A0 =A0 =A0int active;
> =A0 =A0 =A0 =A0struct psc_dma *psc_dma;
> =A0 =A0 =A0 =A0struct bcom_task *bcom_task;
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
