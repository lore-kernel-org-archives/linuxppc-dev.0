Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC401B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 16:40:30 +1100 (EST)
Message-ID: <1332222008.2982.13.camel@pasglop>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 20 Mar 2012 16:40:08 +1100
In-Reply-To: <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Tony Breeds <tbreeds@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> >> That is interesting! Are those patches published or otherwise available
> >> somewhere? We are also very interested in enabling Canyonlands
> >> with Radeon KMS!
> >
> > You will run into additional problems with 460 due to the fact that it's
> > not cache coherent for DMA. Tony patches don't address that part of the
> > problem (they were used on a 476 based platform).
> 
> Hmm. Could you please spill a little bit more of details? Also are those patches
> for 476 merged or present somewhere?

Well, DMA on 46x isn't cache coherent. The DRM plays interesting games
with mapping/unmapping pages for DMA by the chip and I don't think we
have the right hooks to do the appropriate cache flushing on these guys,
but Tony might be able to comment, I don't know whether he tried or not.

On the other hand 476 has fully cache coherent DMA so the only problem
there is the >32-bit physical address space.

As for the patches, you'll have to wait for Tony to respond (I'll poke
him locally).

Cheers,
Ben.

> >> > In fact, we could make the new structure such that it doesn't break
> >> > userspace compatibility with 64-bit architectures at all, ie, the "new"
> >> > and "compat" ioctl could remain entirely equivalent on 64-bit.
> >>
> >> I remember stuff about compat_ioctl, but I have never used/implemented
> >> that. Are there any details of requirements for the structures being passed?
> >
> > In that specific case, I meant something else. IE. The old ioctl could
> > remain unchanged, and the new ioctl make the same as the old one on
> > 64-bit platforms.
> 
> I don't think this kind of magic would be good. I'd just stick to the new
> ioctl.
> 
> >
> > Cheers,
> > Ben.
> >
> >
> >
> 
> 
> 
