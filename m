Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id CEFF5B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 00:15:18 +1000 (EST)
Message-ID: <1335276900.3383.23.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Tue, 24 Apr 2012 16:15:00 +0200
In-Reply-To: <20120423164504.235670@gmx.net>
References: <20120420111527.190290@gmx.net>
 <1334927896.5989.463.camel@thor.local> <20120420161407.190300@gmx.net>
 <1335174966.5989.529.camel@thor.local> <20120423164504.235670@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-23 at 18:45 +0200, Gerhard Pircher wrote:
> > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > On Fre, 2012-04-20 at 18:14 +0200, Gerhard Pircher wrote:=20
> > > > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > > > On Fre, 2012-04-20 at 13:15 +0200, Gerhard Pircher wrote:=20
> > > > >=20
> > > > > What I didn't understand yet is how this uncacheable memory is
> > > > > allocated (well, I never took the time to look at this again). Th=
e
> > > > > functions in ttm_page_alloc.c seem to allocate normal cacheable
> > > > > memory and try to set the page flags with set_pages_array_uc(),
> > > > > which is more or less a no-op on powerpc. ttm_page_alloc_dma.c on
> > > > > the other side is only used with SWIOTLB!?
> > > > [...]=20
> > > > > Could it be that the memory is finally mapped uncacheable by
> > > > radeon_bo_kmap()/
> > > > > ttm_bo_kmap()/..some other TTM functions../vmap()?
> > > >=20
> > > > Yeah, AFAICT, basically ttm_io_prot() defines the mapping
> > > > attributes, and vmap() is used to enforce them for kernel mappings.
> > > Okay, that sounds like the approach used by arch/powerpc/mm/dma-
> > > noncoherent.c in my ("green") ears. What about the PCIGART mode?
> > > Is the driver free to use cached memory in this mode?
> >=20
> > Yes, it assumes PCI(e) GART to be CPU cache coherent.
> Okay. I guess it should be possible to modify it so that it makes use
> of uncacheable memory - just for testing!?

Sure. Just set man->available_caching and man->default_caching as in the
AGP case in radeon_init_mem_type().=20

> PCIGART was working "somehow" on my platform up to the ~2.6.39 kernel,
> i.e. I could login to GNOME and open a program until the machine
> locked-up. :-)

But it's worse with newer kernels?


> BTW: I see that the uninorth driver defines needs_scratch_page. What
> is this actually good for?

It causes the code in drivers/char/agp/backend.c to allocate a scratch
page (bridge->scratch_page) which the driver can use for unused GART
entries.=20


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
