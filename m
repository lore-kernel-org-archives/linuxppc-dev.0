Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5DPp0HpTzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:30:21 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id w143so16068504wmw.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 06:30:21 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-mips@linux-mips.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, a.seppala@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Thu, 12 May 2016 15:30:15 +0200
Message-ID: <2856271.3aAGK3LarU@debian64>
In-Reply-To: <2924514.Pic5Z1NUsc@wuerfel>
References: <4231696.iL6nGs74X8@debian64> <7745292.ZB3149zIk7@debian64>
 <2924514.Pic5Z1NUsc@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> > > > > Detecting the endianess of the
> > > > > device is probably the best future-proof solution, but it's also
> > > > > considerably more work to do in the driver, and comes with a
> > > > > tiny runtime overhead.
> > > > 
> > > > The runtime overhead is probably non-measurable compared with the cost
> > > > of the actual MMIOs.
> > > 
> > > Right. The code size increase is probably measurable (but still small),
> > > the runtime overhead is not.
> > 
> > Ok, so no rebuts or complains have been posted.
> > 
> > I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> > and it works: 
> > 
> > Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> > 
> > So, how do we go from here? There is are two small issues with the
> > original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> > #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> > 
> > Arnd, can you please respin and post it (cc'd stable as well)?
> > So this is can be picked up? Or what's your plan?
> 
> (I just realized my reply was stuck in my outbox, so the patch
> went out first)
> 
> If I recall correctly, the rough consensus was to go with your longer
> patch in the future (fixed up for the comments that BenH and
> I sent), and I'd suggest basing it on top of a fixed version of
> my patch.
Well, but it comes with the "overhead"! So this was just as I said:
"Let's look at it and see if it's any good"... And I think it isn't
since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
archs etc...
 
> Felipe just had another idea, to change the endianess of the dwc2
> block by setting a registers (if that exists). That would indeed
> be preferable, then we can just revert the broken change that
> went into 4.4 and backport that fix instead.
Just a quick reply. I have the docs for the thing. There's something
like that in GAHBCFG at Bit 24... BUT it only switches the endiannes
for the DMA descriptors (which is not always used, there are devices
with PIO only)! It doesn't deal with the MMIO access at all. 

The pin that would select which endian the device uses is probably
connected to a DCR or GPIO but I don't know which or where so this
is more or less useless. (Or the selectable endianness was dropped
during synth).

Regards,
Christian
