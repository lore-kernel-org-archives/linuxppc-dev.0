Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 0521EDDF00
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 14:27:47 +1000 (EST)
Received: by qyk29 with SMTP id 29so5427248qyk.17
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 21:27:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904262108i75acde81s829fa20ffcbdcad1@mail.gmail.com>
References: <20090426195215.4648.62017.stgit@terra>
	<20090426195307.4648.53704.stgit@terra>
	<fa686aa40904262108i75acde81s829fa20ffcbdcad1@mail.gmail.com>
Date: Mon, 27 Apr 2009 00:27:40 -0400
Message-ID: <9e4733910904262127k27db6ed1l5540e66ed65872a0@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] Rename exports in mpc5200_dma.c
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
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

On Mon, Apr 27, 2009 at 12:08 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Sun, Apr 26, 2009 at 1:53 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Rename the public DMA exports into the global name space so that the DMA=
 code can be built as a module.
>>
>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Nack. =A0mpc5200_dma is too generic for the global namespace... (in
> fact, I should also relook at the previous patch; I might need to nack
> my ack). =A0Some variant of 'mpc5200_psc_snd_dma' would be more
> appropriate. =A0Even mpc5200_psc_dma is too generic because other
> non-sound PSC modes can use DMA also.

I'll change it to mpc5200_audio_dma and resend this to the series to
the alsa list.

Does your stuff still work with these patches? I want to get these
mechanical changes in so we can focus on the real changes in my later
patches.

>
> g.
>
>> ---
>> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 | =A0 18 ++++++++++++------
>> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 | =A0 10 +++++-----
>> =A0sound/soc/fsl/mpc5200_psc_i2s.c | =A0 14 +++++++-------
>> =A03 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
>> index c82ef75..df73755 100644
>> --- a/sound/soc/fsl/mpc5200_dma.c
>> +++ b/sound/soc/fsl/mpc5200_dma.c
>> @@ -113,7 +113,7 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_=
psc_dma_stream)
>> =A0* If this is the first stream open, then grab the IRQ and program mos=
t of
>> =A0* the PSC registers.
>> =A0*/
>> -int psc_dma_startup(struct snd_pcm_substream *substream,
>> +int mpc5200_dma_startup(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> @@ -145,13 +145,16 @@ int psc_dma_startup(struct snd_pcm_substream *subs=
tream,
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> +EXPORT_SYMBOL_GPL(mpc5200_dma_startup);
>>
>> -int psc_dma_hw_free(struct snd_pcm_substream *substream,
>> +int mpc5200_dma_hw_free(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai)
>> =A0{
>> =A0 =A0 =A0 =A0snd_pcm_set_runtime_buffer(substream, NULL);
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> +EXPORT_SYMBOL_GPL(mpc5200_dma_hw_free);
>> +
>>
>> =A0/**
>> =A0* psc_dma_trigger: start and stop the DMA transfer.
>> @@ -159,7 +162,7 @@ int psc_dma_hw_free(struct snd_pcm_substream *substr=
eam,
>> =A0* This function is called by ALSA to start, stop, pause, and resume t=
he DMA
>> =A0* transfer of data.
>> =A0*/
>> -int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
>> +int mpc5200_dma_trigger(struct snd_pcm_substream *substream, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> @@ -269,13 +272,15 @@ int psc_dma_trigger(struct snd_pcm_substream *subs=
tream, int cmd,
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> +EXPORT_SYMBOL_GPL(mpc5200_dma_trigger);
>> +
>>
>> =A0/**
>> =A0* psc_dma_shutdown: shutdown the data transfer on a stream
>> =A0*
>> =A0* Shutdown the PSC if there are no other substreams open.
>> =A0*/
>> -void psc_dma_shutdown(struct snd_pcm_substream *substream,
>> +void mpc5200_dma_shutdown(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_d=
ai *dai)
>> =A0{
>> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_da=
ta;
>> @@ -303,6 +308,7 @@ void psc_dma_shutdown(struct snd_pcm_substream *subs=
tream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(psc_dma->playback.irq, &psc_dma-=
>playback);
>> =A0 =A0 =A0 =A0}
>> =A0}
>> +EXPORT_SYMBOL_GPL(mpc5200_dma_shutdown);
>>
>> =A0/* ------------------------------------------------------------------=
---
>> =A0* The PSC DMA 'ASoC platform' driver
>> @@ -448,10 +454,10 @@ static void psc_dma_pcm_free(struct snd_pcm *pcm)
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> -struct snd_soc_platform psc_dma_pcm_soc_platform =3D {
>> +struct snd_soc_platform mpc5200_dma_platform =3D {
>> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mpc5200-psc-audio",
>> =A0 =A0 =A0 =A0.pcm_ops =A0 =A0 =A0 =A0=3D &psc_dma_pcm_ops,
>> =A0 =A0 =A0 =A0.pcm_new =A0 =A0 =A0 =A0=3D &psc_dma_pcm_new,
>> =A0 =A0 =A0 =A0.pcm_free =A0 =A0 =A0 =3D &psc_dma_pcm_free,
>> =A0};
>> -
>> +EXPORT_SYMBOL_GPL(mpc5200_dma_platform);
>> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
>> index a33232c..e52b90e 100644
>> --- a/sound/soc/fsl/mpc5200_dma.h
>> +++ b/sound/soc/fsl/mpc5200_dma.h
>> @@ -64,18 +64,18 @@ struct psc_dma {
>> =A0};
>>
>>
>> -int psc_dma_startup(struct snd_pcm_substream *substream,
>> +int mpc5200_dma_startup(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai);
>>
>> -int psc_dma_hw_free(struct snd_pcm_substream *substream,
>> +int mpc5200_dma_hw_free(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai);
>>
>> -void psc_dma_shutdown(struct snd_pcm_substream *substream,
>> +void mpc5200_dma_shutdown(struct snd_pcm_substream *substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_d=
ai *dai);
>>
>> -int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
>> +int mpc5200_dma_trigger(struct snd_pcm_substream *substream, int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *=
dai);
>>
>> -extern struct snd_soc_platform psc_dma_pcm_soc_platform;
>> +extern struct snd_soc_platform mpc5200_dma_platform;
>>
>> =A0#endif /* __SOUND_SOC_FSL_MPC5200_DMA_H__ */
>> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc=
_i2s.c
>> index 12a7917..a4a439c 100644
>> --- a/sound/soc/fsl/mpc5200_psc_i2s.c
>> +++ b/sound/soc/fsl/mpc5200_psc_i2s.c
>> @@ -140,11 +140,11 @@ static int psc_i2s_set_fmt(struct snd_soc_dai *cpu=
_dai, unsigned int format)
>> =A0* psc_i2s_dai_template: template CPU Digital Audio Interface
>> =A0*/
>> =A0static struct snd_soc_dai_ops psc_i2s_dai_ops =3D {
>> - =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D psc_dma_startup,
>> + =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D mpc5200_dma_startup,
>> =A0 =A0 =A0 =A0.hw_params =A0 =A0 =A0=3D psc_i2s_hw_params,
>> - =A0 =A0 =A0 .hw_free =A0 =A0 =A0 =A0=3D psc_dma_hw_free,
>> - =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D psc_dma_shutdown,
>> - =A0 =A0 =A0 .trigger =A0 =A0 =A0 =A0=3D psc_dma_trigger,
>> + =A0 =A0 =A0 .hw_free =A0 =A0 =A0 =A0=3D mpc5200_dma_hw_free,
>> + =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D mpc5200_dma_shutdown,
>> + =A0 =A0 =A0 .trigger =A0 =A0 =A0 =A0=3D mpc5200_dma_trigger,
>> =A0 =A0 =A0 =A0.set_sysclk =A0 =A0 =3D psc_i2s_set_sysclk,
>> =A0 =A0 =A0 =A0.set_fmt =A0 =A0 =A0 =A0=3D psc_i2s_set_fmt,
>> =A0};
>> @@ -350,10 +350,10 @@ static int __devinit psc_i2s_of_probe(struct of_de=
vice *op,
>> =A0 =A0 =A0 =A0if (rc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(psc_dma->dev, "error creating sy=
sfs files\n");
>>
>> - =A0 =A0 =A0 snd_soc_register_platform(&psc_dma_pcm_soc_platform);
>> + =A0 =A0 =A0 snd_soc_register_platform(&mpc5200_dma_platform);
>>
>> =A0 =A0 =A0 =A0/* Tell the ASoC OF helpers about it */
>> - =A0 =A0 =A0 of_snd_soc_register_platform(&psc_dma_pcm_soc_platform, op=
->node,
>> + =A0 =A0 =A0 of_snd_soc_register_platform(&mpc5200_dma_platform, op->no=
de,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
&psc_dma->dai);
>>
>> =A0 =A0 =A0 =A0return 0;
>> @@ -365,7 +365,7 @@ static int __devexit psc_i2s_of_remove(struct of_dev=
ice *op)
>>
>> =A0 =A0 =A0 =A0dev_dbg(&op->dev, "psc_i2s_remove()\n");
>>
>> - =A0 =A0 =A0 snd_soc_unregister_platform(&psc_dma_pcm_soc_platform);
>> + =A0 =A0 =A0 snd_soc_unregister_platform(&mpc5200_dma_platform);
>>
>> =A0 =A0 =A0 =A0bcom_gen_bd_rx_release(psc_dma->capture.bcom_task);
>> =A0 =A0 =A0 =A0bcom_gen_bd_tx_release(psc_dma->playback.bcom_task);
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
Jon Smirl
jonsmirl@gmail.com
