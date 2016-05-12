Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5PxF61FDzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 06:39:44 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id e201so17992388wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 13:39:44 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: John Youn <John.Youn@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Thu, 12 May 2016 22:39:36 +0200
Message-ID: <50455529.fZie4vOnRh@debian64>
In-Reply-To: <5734CE1C.8070208@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2856271.3aAGK3LarU@debian64>
 <5734CE1C.8070208@synopsys.com>
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

On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
> On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> > On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> >> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> >>>>>> Detecting the endianess of the
> >>>>>> device is probably the best future-proof solution, but it's also
> >>>>>> considerably more work to do in the driver, and comes with a
> >>>>>> tiny runtime overhead.
> >>>>>
> >>>>> The runtime overhead is probably non-measurable compared with the cost
> >>>>> of the actual MMIOs.
> >>>>
> >>>> Right. The code size increase is probably measurable (but still small),
> >>>> the runtime overhead is not.
> >>>
> >>> Ok, so no rebuts or complains have been posted.
> >>>
> >>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> >>> and it works: 
> >>>
> >>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> >>>
> >>> So, how do we go from here? There is are two small issues with the
> >>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> >>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> >>>
> >>> Arnd, can you please respin and post it (cc'd stable as well)?
> >>> So this is can be picked up? Or what's your plan?
> >>
> >> (I just realized my reply was stuck in my outbox, so the patch
> >> went out first)
> >>
> >> If I recall correctly, the rough consensus was to go with your longer
> >> patch in the future (fixed up for the comments that BenH and
> >> I sent), and I'd suggest basing it on top of a fixed version of
> >> my patch.
> > Well, but it comes with the "overhead"! So this was just as I said:
> > "Let's look at it and see if it's any good"... And I think it isn't
> > since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> > archs etc...
> 
> I slightly prefer the more general patch for future kernel versions.
> The overhead will probably be negligible, but we can perform some
> testing to make sure.
> 
> Can you resubmit with all gathered feedback?
Yes I think I can do that. But I would really like to get the
regression out of the way. So for that: I back Arnd's patch.
It explains the problem much better and doesn't kill MIPS 
like the revert I was doing in my initial post to the MLs.
Also, another bonus: his patch is suited to port to stable.

The auto-detection approach is not that easy to get right,
given all the stuff that's going on with BE8, LE4, ... So
can we have your "blessing" for Arnd's patch for now? since
that way, I can base my patch on top of his work about the
issues of endiannes? (Just say: ACK :) )

Arnd: do you have a version with the #ifdef lower/uppercase
fix? Or should I give it a try (and fail in a different way ;) )
 
> >> Felipe just had another idea, to change the endianess of the dwc2
> >> block by setting a registers (if that exists). That would indeed
> >> be preferable, then we can just revert the broken change that
> >> went into 4.4 and backport that fix instead.
> > Just a quick reply. I have the docs for the thing. There's something
> > like that in GAHBCFG at Bit 24... BUT it only switches the endiannes
> > for the DMA descriptors (which is not always used, there are devices
> > with PIO only)! It doesn't deal with the MMIO access at all. 
> 
> That's correct. It only affects descriptor endianness for DMA
> descriptor mode of operation.

Ok. The funny thing is that for the MyBook Live Duo this setting might
be important since the PLB_DMA engine is not part of the DWC library...
Instead it's from IBM and operates in: Big Endian :-D.

Regards,
Christian
