Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67D5D1A0720
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 03:58:17 +1000 (EST)
Received: from mail-qa0-x235.google.com (mail-qa0-x235.google.com
 [IPv6:2607:f8b0:400d:c00::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E8F314012A
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 03:58:16 +1000 (EST)
Received: by mail-qa0-f53.google.com with SMTP id v10so631666qac.12
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2014 10:58:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <s5hoatw42f6.wl-tiwai@suse.de>
References: <1412129393.4285.195.camel@pasglop> <s5htx3o44tv.wl-tiwai@suse.de>
 <1412149289.4285.204.camel@pasglop> <s5hr3ys43ev.wl-tiwai@suse.de>
 <s5hoatw42f6.wl-tiwai@suse.de>
Date: Wed, 1 Oct 2014 13:58:13 -0400
Message-ID: <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Alex Deucher <alexdeucher@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Brian King <brking@linux.vnet.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 Yijing Wang <wangyijing@huawei.com>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 1, 2014 at 4:30 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 01 Oct 2014 10:09:28 +0200,
> Takashi Iwai wrote:
>>
>> At Wed, 01 Oct 2014 17:41:29 +1000,
>> Benjamin Herrenschmidt wrote:
>> >
>> > On Wed, 2014-10-01 at 09:38 +0200, Takashi Iwai wrote:
>> >
>> > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> > > > index 3e6d22d..2b679d5 100644
>> > > > --- a/sound/pci/hda/hda_intel.c
>> > > > +++ b/sound/pci/hda/hda_intel.c
>> > > > @@ -297,7 +297,7 @@ enum {
>> > > >  /* quirks for ATI/AMD HDMI */
>> > > >  #define AZX_DCAPS_PRESET_ATI_HDMI \
>> > > >         (AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
>> > > > -        AZX_DCAPS_NO_MSI64)
>> > > > +        AZX_DCAPS_NO_MSI64 | AZX_DCAPS_NO_64BIT)
>> > >
>> > > The only concern is that this will disable 64bit DMA also on x86 where
>> > > it has been working fine.  Can we add an ifdef CONFIG_PPC for this?
>> >
>> > I don't like that approach because technically the chip doesn't do
>> > 64-bit DMA ... it does something like 40 or 48 (might actually depend on
>> > the chip version) and for all I know it will break on future x86 with
>> > more memory or other platforms with similar address encodings as
>> > powerpc...
>> >
>> > The right thing might be to get the exact number of bits and do the
>> > appropriate dma_set_mask() like the graphics driver does, but that's a
>> > bit tricky unless we add a DMA mask field in that big array of chips in
>> > there...
>>
>> I think setting the dma mask explicitly would be a better approach
>> although it results in a bit bigger change.  At least, it would impact
>> less than forcing 32bit DMA, as most desktop machines have less than
>> 40bit address.  How about a patch like below?

Patch looks good.  Audio DMAs are limited to 40 bits, same as the GPU
side.  I'm still waiting to hear back on the MSIs for audio, but they
probably follow the GPU side, so I expect they should be fixed on Sea
Islands as well.

Alex


>
> Oops, it obviously doesn't work with AMD ID...  Fixed in below.
>
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: hda - Limit 40bit DMA for AMD HDMI controllers
>
> AMD/ATI HDMI controller chip models, we already have a filter to lower
> to 32bit DMA, but the rest are supposed to be working with 64bit
> although the hardware doesn't really work with 63bit but only with 40
> or 48bit DMA.  In this patch, we take 40bit DMA for safety for the
> AMD/ATI controllers as the graphics drivers does.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index aa302fb03fc5..99b367bd9b1b 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1482,6 +1482,7 @@ static int azx_first_init(struct azx *chip)
>         struct snd_card *card = chip->card;
>         int err;
>         unsigned short gcap;
> +       unsigned int dma_bits = 64;
>
>  #if BITS_PER_LONG != 64
>         /* Fix up base address on ULI M5461 */
> @@ -1518,9 +1519,14 @@ static int azx_first_init(struct azx *chip)
>         gcap = azx_readw(chip, GCAP);
>         dev_dbg(card->dev, "chipset global capabilities = 0x%x\n", gcap);
>
> +       /* AMD devices support 40 or 48bit DMA, take the safe one */
> +       if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
> +               dma_bits = 40;
> +
>         /* disable SB600 64bit support for safety */
>         if (chip->pci->vendor == PCI_VENDOR_ID_ATI) {
>                 struct pci_dev *p_smbus;
> +               dma_bits = 40;
>                 p_smbus = pci_get_device(PCI_VENDOR_ID_ATI,
>                                          PCI_DEVICE_ID_ATI_SBX00_SMBUS,
>                                          NULL);
> @@ -1550,9 +1556,11 @@ static int azx_first_init(struct azx *chip)
>         }
>
>         /* allow 64bit DMA address if supported by H/W */
> -       if ((gcap & AZX_GCAP_64OK) && !pci_set_dma_mask(pci, DMA_BIT_MASK(64)))
> -               pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(64));
> -       else {
> +       if (!(gcap & AZX_GCAP_64OK))
> +               dma_bits = 32;
> +       if (!pci_set_dma_mask(pci, DMA_BIT_MASK(dma_bits))) {
> +               pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(dma_bits));
> +       } else {
>                 pci_set_dma_mask(pci, DMA_BIT_MASK(32));
>                 pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32));
>         }
> --
> 2.1.0
>
