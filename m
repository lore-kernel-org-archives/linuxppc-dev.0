Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A357CB703B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 07:50:21 +1100 (EST)
Message-ID: <1332103797.3105.202.camel@pasglop>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 19 Mar 2012 07:49:57 +1100
In-Reply-To: <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
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

On Sun, 2012-03-18 at 18:04 +0400, Dmitry Eremin-Solenikov wrote:
> On Sun, Mar 18, 2012 at 4:46 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Sat, 2012-03-17 at 20:04 +0400, Dmitry Eremin-Solenikov wrote:
> >> Hello,
> >>
> >> I'm trying to make framebuffer to work on PPC460EX board (canyonlands).
> >>
> >> The peculiarity of this platform is the fact that it has
> >> sizeof(unsigned long) = 4,
> >> but physical address on it is 36 bits width. It is a common to various pieces
> >> of the code to expect that unsigned long variable is able to contain physical
> >> address. Most of those places are easy to fix.
> >
> > Yes. In fact, Tony (CC) has some patches to fix a lot of the DRM
> > infrastructure (we have radeon KMS working on a similar platform).
> 
> That is interesting! Are those patches published or otherwise available
> somewhere? We are also very interested in enabling Canyonlands
> with Radeon KMS!

You will run into additional problems with 460 due to the fact that it's
not cache coherent for DMA. Tony patches don't address that part of the
problem (they were used on a 476 based platform).

> > In fact, we could make the new structure such that it doesn't break
> > userspace compatibility with 64-bit architectures at all, ie, the "new"
> > and "compat" ioctl could remain entirely equivalent on 64-bit.
> 
> I remember stuff about compat_ioctl, but I have never used/implemented
> that. Are there any details of requirements for the structures being passed?

In that specific case, I meant something else. IE. The old ioctl could
remain unchanged, and the new ioctl make the same as the old one on
64-bit platforms.

Cheers,
Ben.
