Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB50D1A0771
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 04:11:51 +1000 (EST)
Received: from mail-qg0-x233.google.com (mail-qg0-x233.google.com
 [IPv6:2607:f8b0:400d:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29827140161
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 04:11:50 +1000 (EST)
Received: by mail-qg0-f51.google.com with SMTP id z107so697511qgd.38
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2014 11:11:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412129383.4285.193.camel@pasglop>
References: <1412129383.4285.193.camel@pasglop>
Date: Wed, 1 Oct 2014 14:11:48 -0400
Message-ID: <CADnq5_Og-hgGhq7+RkeyTn=KVPoubTKWhoTjEhV93sdacdgfbw@mail.gmail.com>
Subject: Re: [PATCH 3/4] sound/hda/radeon: Generalize 64-bit MSI quirks
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

On Tue, Sep 30, 2014 at 10:09 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> A number of radeon cards have a HW limitation causing them to be
> unable to generate the full 64-bit of address bits for MSIs. This
> breaks MSIs on some platforms such as POWER machines.
>
> We used to have a powerpc specific quirk to address that on a
> single card, but this doesn't scale very well, this is better
> put under control of the drivers who know precisely what a given
> HW revision can do.
>
> This moves the setting of the quirk flag to the HDA driver when
> detecting the radeon audio interface.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>

This only applies to pre Sea-Islands asics, same as the GPU side.

Alex

> ---
>  arch/powerpc/kernel/pci_64.c |  6 ------
>  sound/pci/hda/hda_intel.c    | 10 ++++++++--
>  sound/pci/hda/hda_priv.h     |  1 +
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 66e1cd0..b15194e 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -266,9 +266,3 @@ int pcibus_to_node(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pcibus_to_node);
>  #endif
> -
> -static void quirk_radeon_32bit_msi(struct pci_dev *dev)
> -{
> -       dev->force_32bit_msi = true;
> -}
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index aa302fb..3e6d22d 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -296,7 +296,8 @@ enum {
>
>  /* quirks for ATI/AMD HDMI */
>  #define AZX_DCAPS_PRESET_ATI_HDMI \
> -       (AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
> +       (AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
> +        AZX_DCAPS_NO_MSI64)
>
>  /* quirks for Nvidia */
>  #define AZX_DCAPS_PRESET_NVIDIA \
> @@ -1505,9 +1506,14 @@ static int azx_first_init(struct azx *chip)
>                 return -ENXIO;
>         }
>
> -       if (chip->msi)
> +       if (chip->msi) {
> +               if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> +                       dev_dbg(card->dev, "Disabling 64bit MSI\n");
> +                       pci->force_32bit_msi = true;
> +               }
>                 if (pci_enable_msi(pci) < 0)
>                         chip->msi = 0;
> +       }
>
>         if (azx_acquire_irq(chip, 0) < 0)
>                 return -EBUSY;
> diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
> index 949cd43..5016014 100644
> --- a/sound/pci/hda/hda_priv.h
> +++ b/sound/pci/hda/hda_priv.h
> @@ -171,6 +171,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
>  #define AZX_DCAPS_PM_RUNTIME   (1 << 26)       /* runtime PM support */
>  #define AZX_DCAPS_I915_POWERWELL (1 << 27)     /* HSW i915 powerwell support */
>  #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)  /* CORBRP clears itself after reset */
> +#define AZX_DCAPS_NO_MSI64      (1 << 29)      /* Stick to 32-bit MSIs */
>
>  /* HD Audio class code */
>  #define PCI_CLASS_MULTIMEDIA_HD_AUDIO  0x0403
>
>
>
