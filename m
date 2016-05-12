Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5BK55TvszDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:56:09 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-mips@linux-mips.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, a.seppala@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Thu, 12 May 2016 13:55:44 +0200
Message-ID: <2924514.Pic5Z1NUsc@wuerfel>
In-Reply-To: <7745292.ZB3149zIk7@debian64>
References: <4231696.iL6nGs74X8@debian64> <5347627.S9K7mIusOJ@wuerfel>
 <7745292.ZB3149zIk7@debian64>
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

On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> > > > Detecting the endianess of the
> > > > device is probably the best future-proof solution, but it's also
> > > > considerably more work to do in the driver, and comes with a
> > > > tiny runtime overhead.
> > > 
> > > The runtime overhead is probably non-measurable compared with the cost
> > > of the actual MMIOs.
> > 
> > Right. The code size increase is probably measurable (but still small),
> > the runtime overhead is not.
> 
> Ok, so no rebuts or complains have been posted.
> 
> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> and it works: 
> 
> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> 
> So, how do we go from here? There is are two small issues with the
> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> 
> Arnd, can you please respin and post it (cc'd stable as well)?
> So this is can be picked up? Or what's your plan?

(I just realized my reply was stuck in my outbox, so the patch
went out first)

If I recall correctly, the rough consensus was to go with your longer
patch in the future (fixed up for the comments that BenH and
I sent), and I'd suggest basing it on top of a fixed version of
my patch.

Felipe just had another idea, to change the endianess of the dwc2
block by setting a registers (if that exists). That would indeed
be preferable, then we can just revert the broken change that
went into 4.4 and backport that fix instead.

	Arnd
