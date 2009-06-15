Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75D3FB7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 12:22:26 +1000 (EST)
Subject: Re: [PATCH 26/33] sound/ps3: Fix checkpatch issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hk53kf89j.wl%tiwai@suse.de>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<s5hk53kf89j.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 12:22:08 +1000
Message-Id: <1245032528.19217.20.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	cbe-oss-dev@ozlabs.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 16:55 +0200, Takashi Iwai wrote:
> At Wed, 10 Jun 2009 16:39:01 +0200,
> Geert Uytterhoeven wrote:
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Cc: alsa-devel@alsa-project.org
> > Cc: Takashi Iwai <tiwai@suse.de>
> 
> Thanks, applied these three patches (26,27,28) to sound git tree.

Are you sure they don't depend on the previous patches ? We're already
having fallover from the SCSI tree merging some of them while I haven't
merge the previous ones yet...

Geert, there are several "procedural" issues with your series here: In
addition to the whole thing being submitted too late that is :-)

You don't have the same CC list on all patches. That is fine except that
you also don't provide merge instructions after the signature, such as
"this patch depends on XX from this series" etc...

A bunch of them do have such dependencies. In fact, there's even a patch
that changes something in the block layer (it's not a big deal, just
adding an accessor, but I still -need- an Ack from Jens to merge it) and
so I have to block all patches that depend on this one. But then, we
have indirect dependencies where some patch don't apply because they
touch the same file that was patched by the patch who had the dependency
etc...

I ended up stopping mid-way through the series. I'll push some of the
patches to my -next branch tonight, and the rest once I get the Ack from
Jens.

I recommend all maintainers (scsi, alsa) just drop these patches for now
and instead give me Ack's so I can merge them via the powerpc tree along
with their respective dependencies. James, feel free to do a revert if
you don't want to rebase, that will break bisect on ps3 for a little
while, but that's the price Geert will have to pay for his mistakes :-)

Cheers,
Ben.

> Takashi
> 
> > ---
> >  sound/ppc/snd_ps3.c |   32 +++++++++++++++-----------------
> >  1 files changed, 15 insertions(+), 17 deletions(-)
> > 
> > diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
> > index f361c26..d660b0f 100644
> > --- a/sound/ppc/snd_ps3.c
> > +++ b/sound/ppc/snd_ps3.c
> > @@ -165,8 +165,7 @@ static const struct snd_pcm_hardware snd_ps3_pcm_hw = {
> >  	.fifo_size = PS3_AUDIO_FIFO_SIZE
> >  };
> >  
> > -static struct snd_pcm_ops snd_ps3_pcm_spdif_ops =
> > -{
> > +static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
> >  	.open = snd_ps3_pcm_open,
> >  	.close = snd_ps3_pcm_close,
> >  	.prepare = snd_ps3_pcm_prepare,
> > @@ -183,7 +182,7 @@ static int snd_ps3_verify_dma_stop(struct snd_ps3_card_info *card,
> >  	int dma_ch, done, retries, stop_forced = 0;
> >  	uint32_t status;
> >  
> > -	for (dma_ch = 0; dma_ch < 8; dma_ch ++) {
> > +	for (dma_ch = 0; dma_ch < 8; dma_ch++) {
> >  		retries = count;
> >  		do {
> >  			status = read_reg(PS3_AUDIO_KICK(dma_ch)) &
> > @@ -259,9 +258,7 @@ static void snd_ps3_kick_dma(struct snd_ps3_card_info *card)
> >  /*
> >   * convert virtual addr to ioif bus addr.
> >   */
> > -static dma_addr_t v_to_bus(struct snd_ps3_card_info *card,
> > -			   void * paddr,
> > -			   int ch)
> > +static dma_addr_t v_to_bus(struct snd_ps3_card_info *card, void *paddr, int ch)
> >  {
> >  	return card->dma_start_bus_addr[ch] +
> >  		(paddr - card->dma_start_vaddr[ch]);
> > @@ -321,7 +318,7 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
> >  	spin_lock_irqsave(&card->dma_lock, irqsave);
> >  	for (ch = 0; ch < 2; ch++) {
> >  		start_vaddr = card->dma_next_transfer_vaddr[0];
> > -		for (stage = 0; stage < fill_stages; stage ++) {
> > +		for (stage = 0; stage < fill_stages; stage++) {
> >  			dma_ch = stage * 2 + ch;
> >  			if (silent)
> >  				dma_addr = card->null_buffer_start_dma_addr;
> > @@ -619,7 +616,7 @@ static int snd_ps3_change_avsetting(struct snd_ps3_card_info *card)
> >  			  PS3_AUDIO_AO_3WMCTRL_ASOEN(2) |
> >  			  PS3_AUDIO_AO_3WMCTRL_ASOEN(3)),
> >  			0);
> > -	wmb(); 	/* ensure the hardware sees the change */
> > +	wmb();	/* ensure the hardware sees the change */
> >  	/* wait for actually stopped */
> >  	retries = 1000;
> >  	while ((read_reg(PS3_AUDIO_AO_3WMCTRL) &
> > @@ -798,20 +795,20 @@ static struct snd_kcontrol_new spdif_ctls[] = {
> >  	{
> >  		.access = SNDRV_CTL_ELEM_ACCESS_READ,
> >  		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> > -		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
> > +		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, CON_MASK),
> >  		.info = snd_ps3_spdif_mask_info,
> >  		.get = snd_ps3_spdif_cmask_get,
> >  	},
> >  	{
> >  		.access = SNDRV_CTL_ELEM_ACCESS_READ,
> >  		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> > -		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,PRO_MASK),
> > +		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, PRO_MASK),
> >  		.info = snd_ps3_spdif_mask_info,
> >  		.get = snd_ps3_spdif_pmask_get,
> >  	},
> >  	{
> >  		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> > -		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
> > +		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
> >  		.info = snd_ps3_spdif_mask_info,
> >  		.get = snd_ps3_spdif_default_get,
> >  		.put = snd_ps3_spdif_default_put,
> > @@ -1020,11 +1017,12 @@ static int __init snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
> >  	 * its size should be lager than PS3_AUDIO_FIFO_STAGE_SIZE * 2
> >  	 * PAGE_SIZE is enogh
> >  	 */
> > -	if (!(the_card.null_buffer_start_vaddr =
> > -	      dma_alloc_coherent(&the_card.ps3_dev->core,
> > -				 PAGE_SIZE,
> > -				 &the_card.null_buffer_start_dma_addr,
> > -				 GFP_KERNEL))) {
> > +	the_card.null_buffer_start_vaddr =
> > +		dma_alloc_coherent(&the_card.ps3_dev->core,
> > +				   PAGE_SIZE,
> > +				   &the_card.null_buffer_start_dma_addr,
> > +				   GFP_KERNEL);
> > +	if (!the_card.null_buffer_start_vaddr) {
> >  		pr_info("%s: nullbuffer alloc failed\n", __func__);
> >  		goto clean_preallocate;
> >  	}
> > @@ -1148,7 +1146,7 @@ static irqreturn_t snd_ps3_interrupt(int irq, void *dev_id)
> >  				SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL :
> >  				SND_PS3_DMA_FILLTYPE_SILENT_RUNNING);
> >  			snd_ps3_kick_dma(card);
> > -			card->silent --;
> > +			card->silent--;
> >  		} else {
> >  			snd_ps3_program_dma(card,
> >  				(underflow_occured) ?
> > -- 
> > 1.6.2.4
> > 
