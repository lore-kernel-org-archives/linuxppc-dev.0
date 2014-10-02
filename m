Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3E6F1A0A5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 22:10:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA5A81400D6
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 22:10:17 +1000 (EST)
Message-ID: <1412251787.28143.14.camel@pasglop>
Subject: Re: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to
 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Date: Thu, 02 Oct 2014 22:09:47 +1000
In-Reply-To: <s5hlhoy52c3.wl-tiwai@suse.de>
References: <1412210082.10667.2.camel@pasglop>
 <CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
 <s5hlhoy52c3.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Brian King <brking@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yijing Wang <wangyijing@huawei.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 09:59 +0200, Takashi Iwai wrote:

> > The attached updated patch only flags the affected asics.
> 
> Alex's patch looks more comprehensive.  For either patch,
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Absolutely. I'll give it a spin tomorrow to be 100% sure. From there,
it will need the previous patch moving the quirk so I'm thinking of
merging it via Bjorn or my tree unless objection...

Cheers,
Ben.

> 
> thanks,
> 
> Takashi
> 
> > 
> > Alex
> > 
> > > ---
> > >  arch/powerpc/kernel/pci_64.c |  6 ------
> > >  sound/pci/hda/hda_intel.c    | 10 ++++++++--
> > >  sound/pci/hda/hda_priv.h     |  1 +
> > >  3 files changed, 9 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> > > index 5330f6d..b15194e 100644
> > > --- a/arch/powerpc/kernel/pci_64.c
> > > +++ b/arch/powerpc/kernel/pci_64.c
> > > @@ -266,9 +266,3 @@ int pcibus_to_node(struct pci_bus *bus)
> > >  }
> > >  EXPORT_SYMBOL(pcibus_to_node);
> > >  #endif
> > > -
> > > -static void quirk_radeon_32bit_msi(struct pci_dev *dev)
> > > -{
> > > -       dev->no_64bit_msi = true;
> > > -}
> > > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
> > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > index aa302fb..f91ba7f 100644
> > > --- a/sound/pci/hda/hda_intel.c
> > > +++ b/sound/pci/hda/hda_intel.c
> > > @@ -296,7 +296,8 @@ enum {
> > >
> > >  /* quirks for ATI/AMD HDMI */
> > >  #define AZX_DCAPS_PRESET_ATI_HDMI \
> > > -       (AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
> > > +       (AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
> > > +        AZX_DCAPS_NO_MSI64)
> > >
> > >  /* quirks for Nvidia */
> > >  #define AZX_DCAPS_PRESET_NVIDIA \
> > > @@ -1505,9 +1506,14 @@ static int azx_first_init(struct azx *chip)
> > >                 return -ENXIO;
> > >         }
> > >
> > > -       if (chip->msi)
> > > +       if (chip->msi) {
> > > +               if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> > > +                       dev_dbg(card->dev, "Disabling 64bit MSI\n");
> > > +                       pci->no_64bit_msi = true;
> > > +               }
> > >                 if (pci_enable_msi(pci) < 0)
> > >                         chip->msi = 0;
> > > +       }
> > >
> > >         if (azx_acquire_irq(chip, 0) < 0)
> > >                 return -EBUSY;
> > > diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
> > > index 949cd43..5016014 100644
> > > --- a/sound/pci/hda/hda_priv.h
> > > +++ b/sound/pci/hda/hda_priv.h
> > > @@ -171,6 +171,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
> > >  #define AZX_DCAPS_PM_RUNTIME   (1 << 26)       /* runtime PM support */
> > >  #define AZX_DCAPS_I915_POWERWELL (1 << 27)     /* HSW i915 powerwell support */
> > >  #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)  /* CORBRP clears itself after reset */
> > > +#define AZX_DCAPS_NO_MSI64      (1 << 29)      /* Stick to 32-bit MSIs */
> > >
> > >  /* HD Audio class code */
> > >  #define PCI_CLASS_MULTIMEDIA_HD_AUDIO  0x0403
> > >
> > >
> > >
> > >
