Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D1211A0165
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:42:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B9D2F14012B
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2014 17:42:04 +1000 (EST)
Message-ID: <1412149289.4285.204.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Date: Wed, 01 Oct 2014 17:41:29 +1000
In-Reply-To: <s5htx3o44tv.wl-tiwai@suse.de>
References: <1412129393.4285.195.camel@pasglop> <s5htx3o44tv.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
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

On Wed, 2014-10-01 at 09:38 +0200, Takashi Iwai wrote:

> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 3e6d22d..2b679d5 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -297,7 +297,7 @@ enum {
> >  /* quirks for ATI/AMD HDMI */
> >  #define AZX_DCAPS_PRESET_ATI_HDMI \
> >  	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
> > -	 AZX_DCAPS_NO_MSI64)
> > +	 AZX_DCAPS_NO_MSI64 | AZX_DCAPS_NO_64BIT)
> 
> The only concern is that this will disable 64bit DMA also on x86 where
> it has been working fine.  Can we add an ifdef CONFIG_PPC for this?

I don't like that approach because technically the chip doesn't do
64-bit DMA ... it does something like 40 or 48 (might actually depend on
the chip version) and for all I know it will break on future x86 with
more memory or other platforms with similar address encodings as
powerpc...

The right thing might be to get the exact number of bits and do the
appropriate dma_set_mask() like the graphics driver does, but that's a
bit tricky unless we add a DMA mask field in that big array of chips in
there...

Cheers,
Ben.
