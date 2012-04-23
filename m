Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 6FCD0B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 19:56:25 +1000 (EST)
Message-ID: <1335174966.5989.529.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Mon, 23 Apr 2012 11:56:06 +0200
In-Reply-To: <20120420161407.190300@gmx.net>
References: <20120420111527.190290@gmx.net>
 <1334927896.5989.463.camel@thor.local> <20120420161407.190300@gmx.net>
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

On Fre, 2012-04-20 at 18:14 +0200, Gerhard Pircher wrote:=20
> > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > On Fre, 2012-04-20 at 13:15 +0200, Gerhard Pircher wrote:=20
> > > > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > > > On Don, 2012-04-19 at 13:48 +0200, Gerhard Pircher wrote:=20
> > > > >=20
> > > > > The "former case" is an explanation, why I see data corruption
> > > > > with my< AGPGART driver (more or less a copy of the uninorth
> > > > > driver) on my non-coherent platform. There are no cache flushes
> > > > > done for writes to already mapped pages.
> > > >=20
> > > > As I said, the radeon driver always maps AGP memory uncacheable for
> > > > the CPU, so no such CPU cache flushes should be necessary.
> > > I know. We also discussed this topic over two years ago. :-)
> > >=20
> > > What I didn't understand yet is how this uncacheable memory is
> > > allocated (well, I never took the time to look at this again). The
> > > functions in ttm_page_alloc.c seem to allocate normal cacheable
> > > memory and try to set the page flags with set_pages_array_uc(),
> > > which is more or less a no-op on powerpc. ttm_page_alloc_dma.c on
> > > the other side is only used with SWIOTLB!?
> > [...]=20
> > > Could it be that the memory is finally mapped uncacheable by
> > radeon_bo_kmap()/
> > > ttm_bo_kmap()/..some other TTM functions../vmap()?
> >=20
> > Yeah, AFAICT, basically ttm_io_prot() defines the mapping attributes,
> > and vmap() is used to enforce them for kernel mappings.
> Okay, that sounds like the approach used by arch/powerpc/mm/dma-
> noncoherent.c in my ("green") ears. What about the PCIGART mode?
> Is the driver free to use cached memory in this mode?

Yes, it assumes PCI(e) GART to be CPU cache coherent.


> > > [    5.878809] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT co=
py 0: Got 0xf1416ec0, expected 0xf1570ec0 (VRAM map 0xf1480000-0xf1580000)
> > [...]
> > > The VRAM->GTT copy totally puzzles me, as it returns a wrong page
> > > address, but the offset is fine!?
> >=20
> > Maybe it's still the values from the GTT->VRAM test, i.e. either the GP=
U
> > writes didn't make it to the memory mapped into the AGP GART (some AGP
> > bridges are known to have issues with that) or the CPU doesn't see it.
> What is the workaround for such an AGP bridge? If there is one at all...

The only workaround short of not using AGP would be not doing GPU->AGP
transfers, but that's not implemented or even planned at all.


> > BTW, does your driver set cant_use_aperture, or is the linear aperture
> > accessible by the CPU?
> The driver sets cant_use_aperture. I couldn't get it working at all
> without it.

Does the hardware really not allow the CPU to access the linear aperture
though? Because if it does, I wonder if that might be more reliable.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
