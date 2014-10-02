Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6031A0A6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 12:17:00 +1000 (EST)
Received: from mail-qa0-x229.google.com (mail-qa0-x229.google.com
 [IPv6:2607:f8b0:400d:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8140514012A
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 12:16:59 +1000 (EST)
Received: by mail-qa0-f41.google.com with SMTP id n8so1266728qaq.0
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2014 19:16:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412210092.10667.3.camel@pasglop>
References: <1412210092.10667.3.camel@pasglop>
Date: Wed, 1 Oct 2014 22:16:57 -0400
Message-ID: <CADnq5_Pizkne_pHJiT1eUgsrK0SY0F_KvWazvNkg02qS49Shig@mail.gmail.com>
Subject: Re: [PATCH 4/4] ALSA: hda - Limit 40bit DMA for AMD HDMI controllers
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 1, 2014 at 8:34 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> AMD/ATI HDMI controller chip models, we already have a filter to lower
> to 32bit DMA, but the rest are supposed to be working with 64bit
> although the hardware doesn't really work with 63bit but only with 40
> or 48bit DMA.  In this patch, we take 40bit DMA for safety for the
> AMD/ATI controllers as the graphics drivers does.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>
> Tested, works fine. This patch is actually independent of the rest
> of the series
>
>  sound/pci/hda/hda_intel.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index f91ba7f..48d0f30 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1483,6 +1483,7 @@ static int azx_first_init(struct azx *chip)
>         struct snd_card *card = chip->card;
>         int err;
>         unsigned short gcap;
> +       unsigned int dma_bits = 64;
>
>  #if BITS_PER_LONG != 64
>         /* Fix up base address on ULI M5461 */
> @@ -1524,9 +1525,14 @@ static int azx_first_init(struct azx *chip)
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
> @@ -1556,9 +1562,11 @@ static int azx_first_init(struct azx *chip)
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
>
>
>
>
