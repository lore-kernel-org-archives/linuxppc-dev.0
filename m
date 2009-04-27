Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id D4493DDEF7
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 14:34:11 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1063090ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 21:34:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904262104s3482faf5o78d1ed33a944b5c4@mail.gmail.com>
References: <20090426195215.4648.62017.stgit@terra>
	<20090426195305.4648.15210.stgit@terra>
	<fa686aa40904262104s3482faf5o78d1ed33a944b5c4@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 26 Apr 2009 22:33:55 -0600
Message-ID: <fa686aa40904262133w46964dc3i458d943f76d8fab8@mail.gmail.com>
Subject: Re: [PATCH V1 2/3] Rename the PSC functions to DMA
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

On Sun, Apr 26, 2009 at 10:04 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Sun, Apr 26, 2009 at 1:53 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Rename the functions in the mpc5200 DMA file from i2s to dma to reflect =
the file they are in.
>>
>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Okay, I've taken a second look now (as per my comment on 3/3), and
yes, I'm still okay with the name changes because the header file
scope is restricted.  If this header was in include/linux/, then I'd
say the prefix should be more specific.

g.

>
>
>> ---
>> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 | =A0194 ++++++++++++++++++++----=
---------------
>> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 | =A0 26 +++--
>> =A0sound/soc/fsl/mpc5200_psc_i2s.c | =A0160 ++++++++++++++++------------=
----
>> =A03 files changed, 190 insertions(+), 190 deletions(-)
>>
>> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
>> index cccaff4..c82ef75 100644
>> --- a/sound/soc/fsl/mpc5200_dma.c
>> +++ b/sound/soc/fsl/mpc5200_dma.c
>> @@ -34,21 +34,21 @@ MODULE_LICENSE("GPL");
>> =A0/*
>> =A0* Interrupt handlers
>> =A0*/
>> -static irqreturn_t psc_i2s_status_irq(int irq, void *_psc_i2s)
>> +static irqreturn_t psc_dma_status_irq(int irq, void *_psc_dma)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D _psc_i2s;
>> - =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_i2s->psc_regs;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D _psc_dma;
>> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
>> =A0 =A0 =A0 =A0u16 isr;
>>
>> =A0 =A0 =A0 =A0isr =3D in_be16(&regs->mpc52xx_psc_isr);
>>
>> =A0 =A0 =A0 =A0/* Playback underrun error */
>> - =A0 =A0 =A0 if (psc_i2s->playback.active && (isr & MPC52xx_PSC_IMR_TXE=
MP))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->stats.underrun_count++;
>> + =A0 =A0 =A0 if (psc_dma->playback.active && (isr & MPC52xx_PSC_IMR_TXE=
MP))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma->stats.underrun_count++;
>>
>> =A0 =A0 =A0 =A0/* Capture overrun error */
>> - =A0 =A0 =A0 if (psc_i2s->capture.active && (isr & MPC52xx_PSC_IMR_ORER=
R))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->stats.overrun_count++;
>> + =A0 =A0 =A0 if (psc_dma->capture.active && (isr & MPC52xx_PSC_IMR_ORER=
R))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma->stats.overrun_count++;
>>
>> =A0 =A0 =A0 =A0out_8(&regs->command, 4 << 4); =A0/* reset the error stat=
us */
>>
>> @@ -56,7 +56,7 @@ static irqreturn_t psc_i2s_status_irq(int irq, void *_=
psc_i2s)
>> =A0}
>>
>> =A0/**
>> - * psc_i2s_bcom_enqueue_next_buffer - Enqueue another audio buffer
>> + * psc_dma_bcom_enqueue_next_buffer - Enqueue another audio buffer
>> =A0* @s: pointer to stream private data structure
>> =A0*
>> =A0* Enqueues another audio period buffer into the bestcomm queue.
>> @@ -65,7 +65,7 @@ static irqreturn_t psc_i2s_status_irq(int irq, void *_=
psc_i2s)
>> =A0* the queue. =A0Otherwise the enqueue will fail and the audio ring bu=
ffer
>> =A0* will get out of sync
>> =A0*/
>> -static void psc_i2s_bcom_enqueue_next_buffer(struct psc_i2s_stream *s)
>> +static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
>> =A0{
>> =A0 =A0 =A0 =A0struct bcom_bd *bd;
>>
>> @@ -82,9 +82,9 @@ static void psc_i2s_bcom_enqueue_next_buffer(struct ps=
c_i2s_stream *s)
>> =A0}
>>
>> =A0/* Bestcomm DMA irq handler */
>> -static irqreturn_t psc_i2s_bcom_irq(int irq, void *_psc_i2s_stream)
>> +static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s_stream *s =3D _psc_i2s_stream;
>> + =A0 =A0 =A0 struct psc_dma_stream *s =3D _psc_dma_stream;
>>
>> =A0 =A0 =A0 =A0/* For each finished period, dequeue the completed period=
 buffer
>> =A0 =A0 =A0 =A0 * and enqueue a new one in it's place. */
>> @@ -93,7 +93,7 @@ static irqreturn_t psc_i2s_bcom_irq(int irq, void *_ps=
c_i2s_stream)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current_pt +=3D s->period_bytes=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (s->period_current_pt >=3D s->period_e=
nd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->period_current_pt =3D =
s->period_start;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s_bcom_enqueue_next_buffer(s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_buffer(s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_enable(s->bcom_task);
>> =A0 =A0 =A0 =A0}
>>
>> @@ -106,39 +106,39 @@ static irqreturn_t psc_i2s_bcom_irq(int irq, void =
*_psc_i2s_stream)
>> =A0}
>>
>> =A0/**
>> - * psc_i2s_startup: create a new substream
>> + * psc_dma_startup: create a new substream
>> =A0*
>> =A0* This is the first function called when a stream is opened.
>> =A0*
>> =A0* If this is the first stream open, then grab the IRQ and program mos=
t of
>> =A0* the PSC registers.
>> =A0*/
>> -int psc_i2s_startup(struct snd_pcm_substream *substream,
>> +int psc_dma_startup(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>> =A0 =A0 =A0 =A0int rc;
>>
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_startup(substream=3D%p)\n",=
 substream);
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_startup(substream=3D%p)\n",=
 substream);
>>
>> - =A0 =A0 =A0 if (!psc_i2s->playback.active &&
>> - =A0 =A0 =A0 =A0 =A0 !psc_i2s->capture.active) {
>> + =A0 =A0 =A0 if (!psc_dma->playback.active &&
>> + =A0 =A0 =A0 =A0 =A0 !psc_dma->capture.active) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Setup the IRQs */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(psc_i2s->irq, &psc_i2s_=
status_irq, IRQF_SHARED,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"psc-i2=
s-status", psc_i2s);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_i2s->capture.irq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_i=
2s_bcom_irq, IRQF_SHARED,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-i=
2s-capture", &psc_i2s->capture);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_i2s->playback.irq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_i=
2s_bcom_irq, IRQF_SHARED,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-i=
2s-playback", &psc_i2s->playback);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D request_irq(psc_dma->irq, &psc_dma_=
status_irq, IRQF_SHARED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"psc-dm=
a-status", psc_dma);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_dma->capture.irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_d=
ma_bcom_irq, IRQF_SHARED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-d=
ma-capture", &psc_dma->capture);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(psc_dma->playback.irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psc_d=
ma_bcom_irq, IRQF_SHARED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psc-d=
ma-playback", &psc_dma->playback);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rc) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->irq, psc=
_i2s);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->capture.=
irq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_i2=
s->capture);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->playback=
.irq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_i2=
s->playback);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->irq, psc=
_dma);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->capture.=
irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_dm=
a->capture);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->playback=
.irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&psc_dm=
a->playback);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>> @@ -146,7 +146,7 @@ int psc_i2s_startup(struct snd_pcm_substream *substr=
eam,
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -int psc_i2s_hw_free(struct snd_pcm_substream *substream,
>> +int psc_dma_hw_free(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai)
>> =A0{
>> =A0 =A0 =A0 =A0snd_pcm_set_runtime_buffer(substream, NULL);
>> @@ -154,29 +154,29 @@ int psc_i2s_hw_free(struct snd_pcm_substream *subs=
tream,
>> =A0}
>>
>> =A0/**
>> - * psc_i2s_trigger: start and stop the DMA transfer.
>> + * psc_dma_trigger: start and stop the DMA transfer.
>> =A0*
>> =A0* This function is called by ALSA to start, stop, pause, and resume t=
he DMA
>> =A0* transfer of data.
>> =A0*/
>> -int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>> +int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>> =A0 =A0 =A0 =A0struct snd_pcm_runtime *runtime =3D substream->runtime;
>> - =A0 =A0 =A0 struct psc_i2s_stream *s;
>> - =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_i2s->psc_regs;
>> + =A0 =A0 =A0 struct psc_dma_stream *s;
>> + =A0 =A0 =A0 struct mpc52xx_psc __iomem *regs =3D psc_dma->psc_regs;
>> =A0 =A0 =A0 =A0u16 imr;
>> =A0 =A0 =A0 =A0u8 psc_cmd;
>> =A0 =A0 =A0 =A0unsigned long flags;
>>
>> =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTU=
RE)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->capture;
>> =A0 =A0 =A0 =A0else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->playback;
>>
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_trigger(substream=3D%p, cmd=
=3D%i)"
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_trigger(substream=3D%p, cmd=
=3D%i)"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" stream_id=3D%i\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0substream, cmd, substream->pstr->stream);
>>
>> @@ -207,14 +207,14 @@ int psc_i2s_trigger(struct snd_pcm_substream *subs=
tream, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_gen_bd_tx_reset(s->b=
com_task);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!bcom_queue_full(s->bcom_task))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s_bcom_enqueue_next_=
buffer(s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_=
buffer(s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_enable(s->bcom_task);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Due to errata in the i2s mode; need to =
line up enabling
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Due to errata in the dma mode; need to =
line up enabling
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the transmitter with a transition on t=
he frame sync
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * line */
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&psc_i2s->lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&psc_dma->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* first make sure it is low */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((in_8(&regs->ipcr_acr.ipcr) & 0x80=
) !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;
>> @@ -228,7 +228,7 @@ int psc_i2s_trigger(struct snd_pcm_substream *substr=
eam, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_=
PCM_STREAM_PLAYBACK)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psc_cmd |=3D MPC52xx_PSC_=
TX_ENABLE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&regs->command, psc_cmd);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&psc_i2s->lock, fla=
gs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&psc_dma->lock, fla=
gs);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> @@ -236,7 +236,7 @@ int psc_i2s_trigger(struct snd_pcm_substream *substr=
eam, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Turn off the PSC */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->active =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_=
PCM_STREAM_CAPTURE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_i2s->playback.act=
ive) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_dma->playback.act=
ive) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&re=
gs->command, 2 << 4); =A0/* reset rx */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&re=
gs->command, 3 << 4); =A0/* reset tx */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&re=
gs->command, 4 << 4); =A0/* reset err */
>> @@ -244,7 +244,7 @@ int psc_i2s_trigger(struct snd_pcm_substream *substr=
eam, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&regs->command, 3 <=
< 4); =A0/* reset tx */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&regs->command, 4 <=
< 4); =A0/* reset err */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_i2s->capture.acti=
ve)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc_dma->capture.acti=
ve)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_8(&re=
gs->command, 2 << 4); =A0/* reset rx */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> @@ -255,15 +255,15 @@ int psc_i2s_trigger(struct snd_pcm_substream *subs=
tream, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> =A0 =A0 =A0 =A0default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "invalid command\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(psc_dma->dev, "invalid command\n")=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* Update interrupt enable settings */
>> =A0 =A0 =A0 =A0imr =3D 0;
>> - =A0 =A0 =A0 if (psc_i2s->playback.active)
>> + =A0 =A0 =A0 if (psc_dma->playback.active)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imr |=3D MPC52xx_PSC_IMR_TXEMP;
>> - =A0 =A0 =A0 if (psc_i2s->capture.active)
>> + =A0 =A0 =A0 if (psc_dma->capture.active)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imr |=3D MPC52xx_PSC_IMR_ORERR;
>> =A0 =A0 =A0 =A0out_be16(&regs->isr_imr.imr, imr);
>>
>> @@ -271,36 +271,36 @@ int psc_i2s_trigger(struct snd_pcm_substream *subs=
tream, int cmd,
>> =A0}
>>
>> =A0/**
>> - * psc_i2s_shutdown: shutdown the data transfer on a stream
>> + * psc_dma_shutdown: shutdown the data transfer on a stream
>> =A0*
>> =A0* Shutdown the PSC if there are no other substreams open.
>> =A0*/
>> -void psc_i2s_shutdown(struct snd_pcm_substream *substream,
>> +void psc_dma_shutdown(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_d=
ai *dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>>
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_shutdown(substream=3D%p)\n"=
, substream);
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_shutdown(substream=3D%p)\n"=
, substream);
>>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * If this is the last active substream, disable the PSC =
and release
>> =A0 =A0 =A0 =A0 * the IRQ.
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 if (!psc_i2s->playback.active &&
>> - =A0 =A0 =A0 =A0 =A0 !psc_i2s->capture.active) {
>> + =A0 =A0 =A0 if (!psc_dma->playback.active &&
>> + =A0 =A0 =A0 =A0 =A0 !psc_dma->capture.active) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Disable all interrupts and reset the P=
SC */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(&psc_i2s->psc_regs->isr_imr.imr, =
0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 3 << 4)=
; /* reset tx */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 2 << 4)=
; /* reset rx */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 1 << 4)=
; /* reset mode */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 4 << 4)=
; /* reset error */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be16(&psc_dma->psc_regs->isr_imr.imr, =
0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 3 << 4)=
; /* reset tx */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 2 << 4)=
; /* reset rx */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 1 << 4)=
; /* reset mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 4 << 4)=
; /* reset error */
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Release irqs */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->irq, psc_i2s);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->capture.irq, &psc_i2s->c=
apture);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_i2s->playback.irq, &psc_i2s->=
playback);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->irq, psc_dma);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->capture.irq, &psc_dma->c=
apture);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(psc_dma->playback.irq, &psc_dma->=
playback);
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> @@ -312,7 +312,7 @@ void psc_i2s_shutdown(struct snd_pcm_substream *subs=
tream,
>> =A0* interaction with the attached codec
>> =A0*/
>>
>> -static const struct snd_pcm_hardware psc_i2s_pcm_hardware =3D {
>> +static const struct snd_pcm_hardware psc_dma_pcm_hardware =3D {
>> =A0 =A0 =A0 =A0.info =3D SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID=
 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_IN=
FO_BLOCK_TRANSFER,
>> =A0 =A0 =A0 =A0.formats =3D SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_B=
E |
>> @@ -329,80 +329,80 @@ static const struct snd_pcm_hardware psc_i2s_pcm_h=
ardware =3D {
>> =A0 =A0 =A0 =A0.fifo_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0,
>> =A0};
>>
>> -static int psc_i2s_pcm_open(struct snd_pcm_substream *substream)
>> +static int psc_dma_pcm_open(struct snd_pcm_substream *substream)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> - =A0 =A0 =A0 struct psc_i2s_stream *s;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma_stream *s;
>>
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_pcm_open(substream=3D%p)\n"=
, substream);
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_pcm_open(substream=3D%p)\n"=
, substream);
>>
>> =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTU=
RE)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->capture;
>> =A0 =A0 =A0 =A0else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->playback;
>>
>> - =A0 =A0 =A0 snd_soc_set_runtime_hwparams(substream, &psc_i2s_pcm_hardw=
are);
>> + =A0 =A0 =A0 snd_soc_set_runtime_hwparams(substream, &psc_dma_pcm_hardw=
are);
>>
>> =A0 =A0 =A0 =A0s->stream =3D substream;
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static int psc_i2s_pcm_close(struct snd_pcm_substream *substream)
>> +static int psc_dma_pcm_close(struct snd_pcm_substream *substream)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> - =A0 =A0 =A0 struct psc_i2s_stream *s;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma_stream *s;
>>
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_pcm_close(substream=3D%p)\n=
", substream);
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_dma_pcm_close(substream=3D%p)\n=
", substream);
>>
>> =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTU=
RE)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->capture;
>> =A0 =A0 =A0 =A0else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->playback;
>>
>> =A0 =A0 =A0 =A0s->stream =3D NULL;
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> =A0static snd_pcm_uframes_t
>> -psc_i2s_pcm_pointer(struct snd_pcm_substream *substream)
>> +psc_dma_pcm_pointer(struct snd_pcm_substream *substream)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> - =A0 =A0 =A0 struct psc_i2s_stream *s;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma_stream *s;
>> =A0 =A0 =A0 =A0dma_addr_t count;
>>
>> =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTU=
RE)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->capture;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->capture;
>> =A0 =A0 =A0 =A0else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_i2s->playback;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D &psc_dma->playback;
>>
>> =A0 =A0 =A0 =A0count =3D s->period_current_pt - s->period_start;
>>
>> =A0 =A0 =A0 =A0return bytes_to_frames(substream->runtime, count);
>> =A0}
>>
>> -static struct snd_pcm_ops psc_i2s_pcm_ops =3D {
>> - =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D psc_i2s_pcm_open,
>> - =A0 =A0 =A0 .close =A0 =A0 =A0 =A0 =A0=3D psc_i2s_pcm_close,
>> +static struct snd_pcm_ops psc_dma_pcm_ops =3D {
>> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D psc_dma_pcm_open,
>> + =A0 =A0 =A0 .close =A0 =A0 =A0 =A0 =A0=3D psc_dma_pcm_close,
>> =A0 =A0 =A0 =A0.ioctl =A0 =A0 =A0 =A0 =A0=3D snd_pcm_lib_ioctl,
>> - =A0 =A0 =A0 .pointer =A0 =A0 =A0 =A0=3D psc_i2s_pcm_pointer,
>> + =A0 =A0 =A0 .pointer =A0 =A0 =A0 =A0=3D psc_dma_pcm_pointer,
>> =A0};
>>
>> -static u64 psc_i2s_pcm_dmamask =3D 0xffffffff;
>> -static int psc_i2s_pcm_new(struct snd_card *card, struct snd_soc_dai *d=
ai,
>> +static u64 psc_dma_pcm_dmamask =3D 0xffffffff;
>> +static int psc_dma_pcm_new(struct snd_card *card, struct snd_soc_dai *d=
ai,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_pcm *pcm)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D pcm->private_data;
>> - =A0 =A0 =A0 size_t size =3D psc_i2s_pcm_hardware.buffer_bytes_max;
>> + =A0 =A0 =A0 size_t size =3D psc_dma_pcm_hardware.buffer_bytes_max;
>> =A0 =A0 =A0 =A0int rc =3D 0;
>>
>> - =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_i2s_pcm_new(card=3D%p, dai=
=3D%p, pcm=3D%p)\n",
>> + =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_dma_pcm_new(card=3D%p, dai=
=3D%p, pcm=3D%p)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card, dai, pcm);
>>
>> =A0 =A0 =A0 =A0if (!card->dev->dma_mask)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->dev->dma_mask =3D &psc_i2s_pcm_dmama=
sk;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->dev->dma_mask =3D &psc_dma_pcm_dmama=
sk;
>> =A0 =A0 =A0 =A0if (!card->dev->coherent_dma_mask)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->dev->coherent_dma_mask =3D 0xffffff=
ff;
>>
>> @@ -430,13 +430,13 @@ static int psc_i2s_pcm_new(struct snd_card *card, =
struct snd_soc_dai *dai,
>> =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0}
>>
>> -static void psc_i2s_pcm_free(struct snd_pcm *pcm)
>> +static void psc_dma_pcm_free(struct snd_pcm *pcm)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D pcm->private_data;
>> =A0 =A0 =A0 =A0struct snd_pcm_substream *substream;
>> =A0 =A0 =A0 =A0int stream;
>>
>> - =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_i2s_pcm_free(pcm=3D%p)\n", =
pcm);
>> + =A0 =A0 =A0 dev_dbg(rtd->socdev->dev, "psc_dma_pcm_free(pcm=3D%p)\n", =
pcm);
>>
>> =A0 =A0 =A0 =A0for (stream =3D 0; stream < 2; stream++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0substream =3D pcm->streams[stream].substr=
eam;
>> @@ -448,10 +448,10 @@ static void psc_i2s_pcm_free(struct snd_pcm *pcm)
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> -struct snd_soc_platform psc_i2s_pcm_soc_platform =3D {
>> +struct snd_soc_platform psc_dma_pcm_soc_platform =3D {
>> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mpc5200-psc-audio",
>> - =A0 =A0 =A0 .pcm_ops =A0 =A0 =A0 =A0=3D &psc_i2s_pcm_ops,
>> - =A0 =A0 =A0 .pcm_new =A0 =A0 =A0 =A0=3D &psc_i2s_pcm_new,
>> - =A0 =A0 =A0 .pcm_free =A0 =A0 =A0 =3D &psc_i2s_pcm_free,
>> + =A0 =A0 =A0 .pcm_ops =A0 =A0 =A0 =A0=3D &psc_dma_pcm_ops,
>> + =A0 =A0 =A0 .pcm_new =A0 =A0 =A0 =A0=3D &psc_dma_pcm_new,
>> + =A0 =A0 =A0 .pcm_free =A0 =A0 =A0 =3D &psc_dma_pcm_free,
>> =A0};
>>
>> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
>> index 9a19e8a..a33232c 100644
>> --- a/sound/soc/fsl/mpc5200_dma.h
>> +++ b/sound/soc/fsl/mpc5200_dma.h
>> @@ -6,9 +6,9 @@
>> =A0#define __SOUND_SOC_FSL_MPC5200_DMA_H__
>>
>> =A0/**
>> - * psc_i2s_stream - Data specific to a single stream (playback or captu=
re)
>> + * psc_dma_stream - Data specific to a single stream (playback or captu=
re)
>> =A0* @active: =A0 =A0 =A0 =A0 =A0 =A0flag indicating if the stream is ac=
tive
>> - * @psc_i2s: =A0 =A0 =A0 =A0 =A0 pointer back to parent psc_i2s data st=
ructure
>> + * @psc_dma: =A0 =A0 =A0 =A0 =A0 pointer back to parent psc_dma data st=
ructure
>> =A0* @bcom_task: =A0 =A0 =A0 =A0 bestcomm task structure
>> =A0* @irq: =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq number for bestcomm task
>> =A0* @period_start: =A0 =A0 =A0physical address of start of DMA region
>> @@ -16,9 +16,9 @@
>> =A0* @period_next_pt: =A0 =A0physical address of next DMA buffer to enqu=
eue
>> =A0* @period_bytes: =A0 =A0 =A0size of DMA period in bytes
>> =A0*/
>> -struct psc_i2s_stream {
>> +struct psc_dma_stream {
>> =A0 =A0 =A0 =A0int active;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma;
>> =A0 =A0 =A0 =A0struct bcom_task *bcom_task;
>> =A0 =A0 =A0 =A0int irq;
>> =A0 =A0 =A0 =A0struct snd_pcm_substream *stream;
>> @@ -30,7 +30,7 @@ struct psc_i2s_stream {
>> =A0};
>>
>> =A0/**
>> - * psc_i2s - Private driver data
>> + * psc_dma - Private driver data
>> =A0* @name: short name for this device ("PSC0", "PSC1", etc)
>> =A0* @psc_regs: pointer to the PSC's registers
>> =A0* @fifo_regs: pointer to the PSC's FIFO registers
>> @@ -42,7 +42,7 @@ struct psc_i2s_stream {
>> =A0* @playback: Playback stream context data
>> =A0* @capture: Capture stream context data
>> =A0*/
>> -struct psc_i2s {
>> +struct psc_dma {
>> =A0 =A0 =A0 =A0char name[32];
>> =A0 =A0 =A0 =A0struct mpc52xx_psc __iomem *psc_regs;
>> =A0 =A0 =A0 =A0struct mpc52xx_psc_fifo __iomem *fifo_regs;
>> @@ -53,8 +53,8 @@ struct psc_i2s {
>> =A0 =A0 =A0 =A0u32 sicr;
>>
>> =A0 =A0 =A0 =A0/* per-stream data */
>> - =A0 =A0 =A0 struct psc_i2s_stream playback;
>> - =A0 =A0 =A0 struct psc_i2s_stream capture;
>> + =A0 =A0 =A0 struct psc_dma_stream playback;
>> + =A0 =A0 =A0 struct psc_dma_stream capture;
>>
>> =A0 =A0 =A0 =A0/* Statistics */
>> =A0 =A0 =A0 =A0struct {
>> @@ -64,18 +64,18 @@ struct psc_i2s {
>> =A0};
>>
>>
>> -int psc_i2s_startup(struct snd_pcm_substream *substream,
>> +int psc_dma_startup(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai);
>>
>> -int psc_i2s_hw_free(struct snd_pcm_substream *substream,
>> +int psc_dma_hw_free(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai);
>>
>> -void psc_i2s_shutdown(struct snd_pcm_substream *substream,
>> +void psc_dma_shutdown(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_d=
ai *dai);
>>
>> -int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>> +int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai);
>>
>> -extern struct snd_soc_platform psc_i2s_pcm_soc_platform;
>> +extern struct snd_soc_platform psc_dma_pcm_soc_platform;
>>
>> =A0#endif /* __SOUND_SOC_FSL_MPC5200_DMA_H__ */
>> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc=
_i2s.c
>> index 8974b53..12a7917 100644
>> --- a/sound/soc/fsl/mpc5200_psc_i2s.c
>> +++ b/sound/soc/fsl/mpc5200_psc_i2s.c
>> @@ -54,10 +54,10 @@ static int psc_i2s_hw_params(struct snd_pcm_substrea=
m *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct s=
nd_soc_dai *dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D rtd->dai->cpu_dai->private_dat=
a;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
>> =A0 =A0 =A0 =A0u32 mode;
>>
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "%s(substream=3D%p) p_size=3D%i p_by=
tes=3D%i"
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "%s(substream=3D%p) p_size=3D%i p_by=
tes=3D%i"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" periods=3D%i buffer_size=3D%i =A0buffer=
_bytes=3D%i\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, substream, params_period_size(p=
arams),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0params_period_bytes(params), params_perio=
ds(params),
>> @@ -77,10 +77,10 @@ static int psc_i2s_hw_params(struct snd_pcm_substrea=
m *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode =3D MPC52xx_PSC_SICR_SIM_CODEC_32;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "invalid format\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(psc_dma->dev, "invalid format\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 out_be32(&psc_i2s->psc_regs->sicr, psc_i2s->sicr | mode);
>> + =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->sicr, psc_dma->sicr | mode);
>>
>> =A0 =A0 =A0 =A0snd_pcm_set_runtime_buffer(substream, &substream->dma_buf=
fer);
>>
>> @@ -104,8 +104,8 @@ static int psc_i2s_hw_params(struct snd_pcm_substrea=
m *substream,
>> =A0static int psc_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int clk_id, u=
nsigned int freq, int dir)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D cpu_dai->private_data;
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_set_sysclk(cpu_dai=3D%p, di=
r=3D%i)\n",
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D cpu_dai->private_data;
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(cpu_dai=3D%p, di=
r=3D%i)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_dai, =
dir);
>> =A0 =A0 =A0 =A0return (dir =3D=3D SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
>> =A0}
>> @@ -123,8 +123,8 @@ static int psc_i2s_set_sysclk(struct snd_soc_dai *cp=
u_dai,
>> =A0*/
>> =A0static int psc_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int =
format)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D cpu_dai->private_data;
>> - =A0 =A0 =A0 dev_dbg(psc_i2s->dev, "psc_i2s_set_fmt(cpu_dai=3D%p, forma=
t=3D%i)\n",
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D cpu_dai->private_data;
>> + =A0 =A0 =A0 dev_dbg(psc_dma->dev, "psc_i2s_set_fmt(cpu_dai=3D%p, forma=
t=3D%i)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_dai, =
format);
>> =A0 =A0 =A0 =A0return (format =3D=3D SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
>> =A0}
>> @@ -140,11 +140,11 @@ static int psc_i2s_set_fmt(struct snd_soc_dai *cpu=
_dai, unsigned int format)
>> =A0* psc_i2s_dai_template: template CPU Digital Audio Interface
>> =A0*/
>> =A0static struct snd_soc_dai_ops psc_i2s_dai_ops =3D {
>> - =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D psc_i2s_startup,
>> + =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D psc_dma_startup,
>> =A0 =A0 =A0 =A0.hw_params =A0 =A0 =A0=3D psc_i2s_hw_params,
>> - =A0 =A0 =A0 .hw_free =A0 =A0 =A0 =A0=3D psc_i2s_hw_free,
>> - =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D psc_i2s_shutdown,
>> - =A0 =A0 =A0 .trigger =A0 =A0 =A0 =A0=3D psc_i2s_trigger,
>> + =A0 =A0 =A0 .hw_free =A0 =A0 =A0 =A0=3D psc_dma_hw_free,
>> + =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D psc_dma_shutdown,
>> + =A0 =A0 =A0 .trigger =A0 =A0 =A0 =A0=3D psc_dma_trigger,
>> =A0 =A0 =A0 =A0.set_sysclk =A0 =A0 =3D psc_i2s_set_sysclk,
>> =A0 =A0 =A0 =A0.set_fmt =A0 =A0 =A0 =A0=3D psc_i2s_set_fmt,
>> =A0};
>> @@ -172,24 +172,24 @@ static struct snd_soc_dai psc_i2s_dai_template =3D=
 {
>> =A0static ssize_t psc_i2s_status_show(struct device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attrib=
ute *attr, char *buf)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D dev_get_drvdata(dev);
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D dev_get_drvdata(dev);
>>
>> =A0 =A0 =A0 =A0return sprintf(buf, "status=3D%.4x sicr=3D%.8x rfnum=3D%i=
 rfstat=3D0x%.4x "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"tfnum=3D%i tfstat=3D0x%.=
4x\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_i2s->psc_regs=
->sr_csr.status),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be32(&psc_i2s->psc_regs=
->sicr),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_i2s->fifo_reg=
s->rfnum) & 0x1ff,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_i2s->fifo_reg=
s->rfstat),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_i2s->fifo_reg=
s->tfnum) & 0x1ff,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_i2s->fifo_reg=
s->tfstat));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_dma->psc_regs=
->sr_csr.status),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be32(&psc_dma->psc_regs=
->sicr),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_dma->fifo_reg=
s->rfnum) & 0x1ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_dma->fifo_reg=
s->rfstat),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_dma->fifo_reg=
s->tfnum) & 0x1ff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be16(&psc_dma->fifo_reg=
s->tfstat));
>> =A0}
>>
>> -static int *psc_i2s_get_stat_attr(struct psc_i2s *psc_i2s, const char *=
name)
>> +static int *psc_i2s_get_stat_attr(struct psc_dma *psc_dma, const char *=
name)
>> =A0{
>> =A0 =A0 =A0 =A0if (strcmp(name, "playback_underrun") =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &psc_i2s->stats.underrun_count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &psc_dma->stats.underrun_count;
>> =A0 =A0 =A0 =A0if (strcmp(name, "capture_overrun") =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &psc_i2s->stats.overrun_count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &psc_dma->stats.overrun_count;
>>
>> =A0 =A0 =A0 =A0return NULL;
>> =A0}
>> @@ -197,10 +197,10 @@ static int *psc_i2s_get_stat_attr(struct psc_i2s *=
psc_i2s, const char *name)
>> =A0static ssize_t psc_i2s_stat_show(struct device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct d=
evice_attribute *attr, char *buf)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D dev_get_drvdata(dev);
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D dev_get_drvdata(dev);
>> =A0 =A0 =A0 =A0int *attrib;
>>
>> - =A0 =A0 =A0 attrib =3D psc_i2s_get_stat_attr(psc_i2s, attr->attr.name)=
;
>> + =A0 =A0 =A0 attrib =3D psc_i2s_get_stat_attr(psc_dma, attr->attr.name)=
;
>> =A0 =A0 =A0 =A0if (!attrib)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>>
>> @@ -212,10 +212,10 @@ static ssize_t psc_i2s_stat_store(struct device *d=
ev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const=
 char *buf,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_=
t count)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D dev_get_drvdata(dev);
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D dev_get_drvdata(dev);
>> =A0 =A0 =A0 =A0int *attrib;
>>
>> - =A0 =A0 =A0 attrib =3D psc_i2s_get_stat_attr(psc_i2s, attr->attr.name)=
;
>> + =A0 =A0 =A0 attrib =3D psc_i2s_get_stat_attr(psc_dma, attr->attr.name)=
;
>> =A0 =A0 =A0 =A0if (!attrib)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>>
>> @@ -238,7 +238,7 @@ static int __devinit psc_i2s_of_probe(struct of_devi=
ce *op,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0const struct of_device_id *match)
>> =A0{
>> =A0 =A0 =A0 =A0phys_addr_t fifo;
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s;
>> + =A0 =A0 =A0 struct psc_dma *psc_dma;
>> =A0 =A0 =A0 =A0struct resource res;
>> =A0 =A0 =A0 =A0int size, psc_id, irq, rc;
>> =A0 =A0 =A0 =A0const __be32 *prop;
>> @@ -265,56 +265,56 @@ static int __devinit psc_i2s_of_probe(struct of_de=
vice *op,
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* Allocate and initialize the driver private data */
>> - =A0 =A0 =A0 psc_i2s =3D kzalloc(sizeof *psc_i2s, GFP_KERNEL);
>> - =A0 =A0 =A0 if (!psc_i2s) {
>> + =A0 =A0 =A0 psc_dma =3D kzalloc(sizeof *psc_dma, GFP_KERNEL);
>> + =A0 =A0 =A0 if (!psc_dma) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(regs);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 spin_lock_init(&psc_i2s->lock);
>> - =A0 =A0 =A0 psc_i2s->irq =3D irq;
>> - =A0 =A0 =A0 psc_i2s->psc_regs =3D regs;
>> - =A0 =A0 =A0 psc_i2s->fifo_regs =3D regs + sizeof *psc_i2s->psc_regs;
>> - =A0 =A0 =A0 psc_i2s->dev =3D &op->dev;
>> - =A0 =A0 =A0 psc_i2s->playback.psc_i2s =3D psc_i2s;
>> - =A0 =A0 =A0 psc_i2s->capture.psc_i2s =3D psc_i2s;
>> - =A0 =A0 =A0 snprintf(psc_i2s->name, sizeof psc_i2s->name, "PSC%u", psc=
_id+1);
>> + =A0 =A0 =A0 spin_lock_init(&psc_dma->lock);
>> + =A0 =A0 =A0 psc_dma->irq =3D irq;
>> + =A0 =A0 =A0 psc_dma->psc_regs =3D regs;
>> + =A0 =A0 =A0 psc_dma->fifo_regs =3D regs + sizeof *psc_dma->psc_regs;
>> + =A0 =A0 =A0 psc_dma->dev =3D &op->dev;
>> + =A0 =A0 =A0 psc_dma->playback.psc_dma =3D psc_dma;
>> + =A0 =A0 =A0 psc_dma->capture.psc_dma =3D psc_dma;
>> + =A0 =A0 =A0 snprintf(psc_dma->name, sizeof psc_dma->name, "PSC%u", psc=
_id+1);
>>
>> =A0 =A0 =A0 =A0/* Fill out the CPU DAI structure */
>> - =A0 =A0 =A0 memcpy(&psc_i2s->dai, &psc_i2s_dai_template, sizeof psc_i2=
s->dai);
>> - =A0 =A0 =A0 psc_i2s->dai.private_data =3D psc_i2s;
>> - =A0 =A0 =A0 psc_i2s->dai.name =3D psc_i2s->name;
>> - =A0 =A0 =A0 psc_i2s->dai.id =3D psc_id;
>> + =A0 =A0 =A0 memcpy(&psc_dma->dai, &psc_i2s_dai_template, sizeof psc_dm=
a->dai);
>> + =A0 =A0 =A0 psc_dma->dai.private_data =3D psc_dma;
>> + =A0 =A0 =A0 psc_dma->dai.name =3D psc_dma->name;
>> + =A0 =A0 =A0 psc_dma->dai.id =3D psc_id;
>>
>> =A0 =A0 =A0 =A0/* Find the address of the fifo data registers and setup =
the
>> =A0 =A0 =A0 =A0 * DMA tasks */
>> =A0 =A0 =A0 =A0fifo =3D res.start + offsetof(struct mpc52xx_psc, buffer.=
buffer_32);
>> - =A0 =A0 =A0 psc_i2s->capture.bcom_task =3D
>> + =A0 =A0 =A0 psc_dma->capture.bcom_task =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_psc_gen_bd_rx_init(psc_id, 10, fifo,=
 512);
>> - =A0 =A0 =A0 psc_i2s->playback.bcom_task =3D
>> + =A0 =A0 =A0 psc_dma->playback.bcom_task =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_psc_gen_bd_tx_init(psc_id, 10, fifo)=
;
>> - =A0 =A0 =A0 if (!psc_i2s->capture.bcom_task ||
>> - =A0 =A0 =A0 =A0 =A0 !psc_i2s->playback.bcom_task) {
>> + =A0 =A0 =A0 if (!psc_dma->capture.bcom_task ||
>> + =A0 =A0 =A0 =A0 =A0 !psc_dma->playback.bcom_task) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&op->dev, "Could not allocate bes=
tcomm tasks\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(regs);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(psc_i2s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(psc_dma);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* Disable all interrupts and reset the PSC */
>> - =A0 =A0 =A0 out_be16(&psc_i2s->psc_regs->isr_imr.imr, 0);
>> - =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 3 << 4); /* reset trans=
mitter */
>> - =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 2 << 4); /* reset recei=
ver */
>> - =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 1 << 4); /* reset mode =
*/
>> - =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->command, 4 << 4); /* reset error=
 */
>> + =A0 =A0 =A0 out_be16(&psc_dma->psc_regs->isr_imr.imr, 0);
>> + =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 3 << 4); /* reset trans=
mitter */
>> + =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 2 << 4); /* reset recei=
ver */
>> + =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 1 << 4); /* reset mode =
*/
>> + =A0 =A0 =A0 out_8(&psc_dma->psc_regs->command, 4 << 4); /* reset error=
 */
>>
>> =A0 =A0 =A0 =A0/* Configure the serial interface mode; defaulting to COD=
EC8 mode */
>> - =A0 =A0 =A0 psc_i2s->sicr =3D MPC52xx_PSC_SICR_DTS1 | MPC52xx_PSC_SICR=
_I2S |
>> + =A0 =A0 =A0 psc_dma->sicr =3D MPC52xx_PSC_SICR_DTS1 | MPC52xx_PSC_SICR=
_I2S |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MPC52xx_PSC_SICR_CLKPOL;
>> =A0 =A0 =A0 =A0if (of_get_property(op->node, "fsl,cellslave", NULL))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_i2s->sicr |=3D MPC52xx_PSC_SICR_CELLSL=
AVE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma->sicr |=3D MPC52xx_PSC_SICR_CELLSL=
AVE |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_=
PSC_SICR_GENCLK;
>> - =A0 =A0 =A0 out_be32(&psc_i2s->psc_regs->sicr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psc_i2s->sicr | MPC52xx_PSC_SICR_SIM_CO=
DEC_8);
>> + =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->sicr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psc_dma->sicr | MPC52xx_PSC_SICR_SIM_CO=
DEC_8);
>>
>> =A0 =A0 =A0 =A0/* Check for the codec handle. =A0If it is not present th=
en we
>> =A0 =A0 =A0 =A0 * are done */
>> @@ -325,54 +325,54 @@ static int __devinit psc_i2s_of_probe(struct of_de=
vice *op,
>> =A0 =A0 =A0 =A0 * First write: RxRdy (FIFO Alarm) generates rx FIFO irq
>> =A0 =A0 =A0 =A0 * Second write: register Normal mode for non loopback
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->mode, 0);
>> - =A0 =A0 =A0 out_8(&psc_i2s->psc_regs->mode, 0);
>> + =A0 =A0 =A0 out_8(&psc_dma->psc_regs->mode, 0);
>> + =A0 =A0 =A0 out_8(&psc_dma->psc_regs->mode, 0);
>>
>> =A0 =A0 =A0 =A0/* Set the TX and RX fifo alarm thresholds */
>> - =A0 =A0 =A0 out_be16(&psc_i2s->fifo_regs->rfalarm, 0x100);
>> - =A0 =A0 =A0 out_8(&psc_i2s->fifo_regs->rfcntl, 0x4);
>> - =A0 =A0 =A0 out_be16(&psc_i2s->fifo_regs->tfalarm, 0x100);
>> - =A0 =A0 =A0 out_8(&psc_i2s->fifo_regs->tfcntl, 0x7);
>> + =A0 =A0 =A0 out_be16(&psc_dma->fifo_regs->rfalarm, 0x100);
>> + =A0 =A0 =A0 out_8(&psc_dma->fifo_regs->rfcntl, 0x4);
>> + =A0 =A0 =A0 out_be16(&psc_dma->fifo_regs->tfalarm, 0x100);
>> + =A0 =A0 =A0 out_8(&psc_dma->fifo_regs->tfcntl, 0x7);
>>
>> =A0 =A0 =A0 =A0/* Lookup the IRQ numbers */
>> - =A0 =A0 =A0 psc_i2s->playback.irq =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_get_task_irq(psc_i2s->playback.bcom_t=
ask);
>> - =A0 =A0 =A0 psc_i2s->capture.irq =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_get_task_irq(psc_i2s->capture.bcom_ta=
sk);
>> + =A0 =A0 =A0 psc_dma->playback.irq =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_get_task_irq(psc_dma->playback.bcom_t=
ask);
>> + =A0 =A0 =A0 psc_dma->capture.irq =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_get_task_irq(psc_dma->capture.bcom_ta=
sk);
>>
>> =A0 =A0 =A0 =A0/* Save what we've done so it can be found again later */
>> - =A0 =A0 =A0 dev_set_drvdata(&op->dev, psc_i2s);
>> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, psc_dma);
>>
>> =A0 =A0 =A0 =A0/* Register the SYSFS files */
>> - =A0 =A0 =A0 rc =3D device_create_file(psc_i2s->dev, &dev_attr_status);
>> - =A0 =A0 =A0 rc |=3D device_create_file(psc_i2s->dev, &dev_attr_capture=
_overrun);
>> - =A0 =A0 =A0 rc |=3D device_create_file(psc_i2s->dev, &dev_attr_playbac=
k_underrun);
>> + =A0 =A0 =A0 rc =3D device_create_file(psc_dma->dev, &dev_attr_status);
>> + =A0 =A0 =A0 rc |=3D device_create_file(psc_dma->dev, &dev_attr_capture=
_overrun);
>> + =A0 =A0 =A0 rc |=3D device_create_file(psc_dma->dev, &dev_attr_playbac=
k_underrun);
>> =A0 =A0 =A0 =A0if (rc)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(psc_i2s->dev, "error creating sys=
fs files\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(psc_dma->dev, "error creating sys=
fs files\n");
>>
>> - =A0 =A0 =A0 snd_soc_register_platform(&psc_i2s_pcm_soc_platform);
>> + =A0 =A0 =A0 snd_soc_register_platform(&psc_dma_pcm_soc_platform);
>>
>> =A0 =A0 =A0 =A0/* Tell the ASoC OF helpers about it */
>> - =A0 =A0 =A0 of_snd_soc_register_platform(&psc_i2s_pcm_soc_platform, op=
->node,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0&psc_i2s->dai);
>> + =A0 =A0 =A0 of_snd_soc_register_platform(&psc_dma_pcm_soc_platform, op=
->node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0&psc_dma->dai);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> =A0static int __devexit psc_i2s_of_remove(struct of_device *op)
>> =A0{
>> - =A0 =A0 =A0 struct psc_i2s *psc_i2s =3D dev_get_drvdata(&op->dev);
>> + =A0 =A0 =A0 struct psc_dma *psc_dma =3D dev_get_drvdata(&op->dev);
>>
>> =A0 =A0 =A0 =A0dev_dbg(&op->dev, "psc_i2s_remove()\n");
>>
>> - =A0 =A0 =A0 snd_soc_unregister_platform(&psc_i2s_pcm_soc_platform);
>> + =A0 =A0 =A0 snd_soc_unregister_platform(&psc_dma_pcm_soc_platform);
>>
>> - =A0 =A0 =A0 bcom_gen_bd_rx_release(psc_i2s->capture.bcom_task);
>> - =A0 =A0 =A0 bcom_gen_bd_tx_release(psc_i2s->playback.bcom_task);
>> + =A0 =A0 =A0 bcom_gen_bd_rx_release(psc_dma->capture.bcom_task);
>> + =A0 =A0 =A0 bcom_gen_bd_tx_release(psc_dma->playback.bcom_task);
>>
>> - =A0 =A0 =A0 iounmap(psc_i2s->psc_regs);
>> - =A0 =A0 =A0 iounmap(psc_i2s->fifo_regs);
>> - =A0 =A0 =A0 kfree(psc_i2s);
>> + =A0 =A0 =A0 iounmap(psc_dma->psc_regs);
>> + =A0 =A0 =A0 iounmap(psc_dma->fifo_regs);
>> + =A0 =A0 =A0 kfree(psc_dma);
>> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, NULL);
>>
>> =A0 =A0 =A0 =A0return 0;
>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
