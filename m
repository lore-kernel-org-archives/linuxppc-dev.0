Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 3B386DDE00
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 00:39:54 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1109162ywe.39
	for <linuxppc-dev@ozlabs.org>; Sun, 05 Apr 2009 07:39:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090405085243.GA16005@oksana.dev.rtsoft.ru>
References: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
	<fa686aa40904042259h4c69e632x47a9e82393e8faef@mail.gmail.com>
	<20090405085243.GA16005@oksana.dev.rtsoft.ru>
Date: Sun, 5 Apr 2009 08:39:37 -0600
Message-ID: <fa686aa40904050739g219a9143v7bbc8cd673e52f4e@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_dma: Pass the proper device for dma mapping
	routines
From: Grant Likely <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Becky Bruce <Becky.Bruce@freescale.com>, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 5, 2009 at 2:52 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Sat, Apr 04, 2009 at 11:59:39PM -0600, Grant Likely wrote:
>> Becky & Kumar,
>>
>> Considering these fixups, would it be advisable for the dma functions
>> to climb up the dev->parent linkage when dma_ops are NULL?
>
> pcm->dev->parent doesn't point to the proper device, so
> this won't work.

What does it point to then?  IIUC, following the ->parent links should
eventually get to a struct device that represents the platform or
of_platform device for purposes of power management.

BTW, I'm not NAKing your patch.  The patch looks fine to me.

g.

>
>> On Sat, Apr 4, 2009 at 12:33 PM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > The driver should pass a device that specifies internal DMA ops, but
>> > substream->pcm is just a logical device, and thus doesn't have arch-
>> > specific dma callbacks, therefore following bug appears:
>> >
>> > =A0Freescale Synchronous Serial Interface (SSI) ASoC Driver
>> > =A0------------[ cut here ]------------
>> > =A0kernel BUG at arch/powerpc/include/asm/dma-mapping.h:237!
>> > =A0Oops: Exception in kernel mode, sig: 5 [#1]
>> > =A0...
>> > =A0NIP [c02259c4] snd_malloc_dev_pages+0x58/0xac
>> > =A0LR [c0225c74] snd_dma_alloc_pages+0xf8/0x108
>> > =A0Call Trace:
>> > =A0[df02bde0] [df02be2c] 0xdf02be2c (unreliable)
>> > =A0[df02bdf0] [c0225c74] snd_dma_alloc_pages+0xf8/0x108
>> > =A0[df02be10] [c023a100] fsl_dma_new+0x68/0x124
>> > =A0[df02be20] [c02342ac] soc_new_pcm+0x1bc/0x234
>> > =A0[df02bea0] [c02343dc] snd_soc_new_pcms+0xb8/0x148
>> > =A0[df02bed0] [c023824c] cs4270_probe+0x34/0x124
>> > =A0[df02bef0] [c0232fe8] snd_soc_instantiate_card+0x1a4/0x2f4
>> > =A0[df02bf20] [c0233164] snd_soc_instantiate_cards+0x2c/0x68
>> > =A0[df02bf30] [c0234704] snd_soc_register_platform+0x60/0x80
>> > =A0[df02bf50] [c03d5664] fsl_soc_platform_init+0x18/0x28
>> > =A0...
>> >
>> > This patch fixes the issue by using card's device instead.
>> >
>> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> > ---
>> > =A0sound/soc/fsl/fsl_dma.c | =A0 12 ++++++------
>> > =A01 files changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
>> > index b3eb857..835e43c 100644
>> > --- a/sound/soc/fsl/fsl_dma.c
>> > +++ b/sound/soc/fsl/fsl_dma.c
>> > @@ -300,7 +300,7 @@ static int fsl_dma_new(struct snd_card *card, stru=
ct snd_soc_dai *dai,
>> > =A0 =A0 =A0 =A0if (!card->dev->coherent_dma_mask)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->dev->coherent_dma_mask =3D fsl_dm=
a_dmamask;
>> >
>> > - =A0 =A0 =A0 ret =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev=
,
>> > + =A0 =A0 =A0 ret =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->de=
v,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl_dma_hardware.buffer_bytes_max,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&pcm->streams[0].substream->dma_buffer)=
;
>> > =A0 =A0 =A0 =A0if (ret) {
>> > @@ -310,7 +310,7 @@ static int fsl_dma_new(struct snd_card *card, stru=
ct snd_soc_dai *dai,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> > =A0 =A0 =A0 =A0}
>> >
>> > - =A0 =A0 =A0 ret =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev=
,
>> > + =A0 =A0 =A0 ret =3D snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->de=
v,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl_dma_hardware.buffer_bytes_max,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&pcm->streams[1].substream->dma_buffer)=
;
>> > =A0 =A0 =A0 =A0if (ret) {
>> > @@ -418,7 +418,7 @@ static int fsl_dma_open(struct snd_pcm_substream *=
substream)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
>> > =A0 =A0 =A0 =A0}
>> >
>> > - =A0 =A0 =A0 dma_private =3D dma_alloc_coherent(substream->pcm->dev,
>> > + =A0 =A0 =A0 dma_private =3D dma_alloc_coherent(substream->pcm->card-=
>dev,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct fsl_dma_private), &ld_buf=
_phys, GFP_KERNEL);
>> > =A0 =A0 =A0 =A0if (!dma_private) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(substream->pcm->card->dev,
>> > @@ -445,7 +445,7 @@ static int fsl_dma_open(struct snd_pcm_substream *=
substream)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(substream->pcm->card->dev,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"can't register ISR for=
 IRQ %u (ret=3D%i)\n",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_private->irq, ret);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(substream->pcm->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(substream->pcm->card->=
dev,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct fsl_dma_p=
rivate),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_private, dma_privat=
e->ld_buf_phys);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>> > @@ -761,13 +761,13 @@ static int fsl_dma_close(struct snd_pcm_substrea=
m *substream)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dma_private->i=
rq, dma_private);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dma_private->ld_buf_phys) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(substre=
am->pcm->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(substre=
am->pcm->card->dev,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_pri=
vate->ld_buf_phys,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(=
dma_private->link), DMA_TO_DEVICE);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Deallocate the fsl_dma_private struc=
ture */
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(substream->pcm->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(substream->pcm->card->=
dev,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct fsl_dma_p=
rivate),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_private, dma_privat=
e->ld_buf_phys);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0substream->runtime->private_data =3D NU=
LL;
>> > --
>> > 1.5.6.5
>> > _______________________________________________
>> > Linuxppc-dev mailing list
>> > Linuxppc-dev@ozlabs.org
>> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>> >
>>
>>
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
