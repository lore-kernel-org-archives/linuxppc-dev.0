Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id BA781B704F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 23:18:34 +1000 (EST)
Message-ID: <1334927896.5989.463.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Fri, 20 Apr 2012 15:18:16 +0200
In-Reply-To: <20120420111527.190290@gmx.net>
References: <20120420111527.190290@gmx.net>
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

On Fre, 2012-04-20 at 13:15 +0200, Gerhard Pircher wrote:=20
> > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > On Don, 2012-04-19 at 13:48 +0200, Gerhard Pircher wrote:=20
> > >=20
> > > The "former case" is an explanation, why I see data corruption with m=
y
> > > AGPGART driver (more or less a copy of the uninorth driver) on my
> > > non-coherent platform. There are no cache flushes done for writes to
> > > already mapped pages.
> >=20
> > As I said, the radeon driver always maps AGP memory uncacheable for the
> > CPU, so no such CPU cache flushes should be necessary.
> I know. We also discussed this topic over two years ago. :-)
>=20
> What I didn't understand yet is how this uncacheable memory is allocated
> (well, I never took the time to look at this again). The functions in
> ttm_page_alloc.c seem to allocate normal cacheable memory and try to set
> the page flags with set_pages_array_uc(), which is more or less a no-op
> on powerpc.
> ttm_page_alloc_dma.c on the other side is only used with SWIOTLB!?
[...]=20
> Could it be that the memory is finally mapped uncacheable by radeon_bo_km=
ap()/
> ttm_bo_kmap()/..some other TTM functions../vmap()?

Yeah, AFAICT, basically ttm_io_prot() defines the mapping attributes,
and vmap() is used to enforce them for kernel mappings.


> Here is an excerpt of the 2.6.39 kernel log. IIRC the testing code change=
d
> in the meantime so I guess it would make sense to repeat it with a newer
> kernel version.

I was going to suggest that. :)

> [    5.490569] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0=
: Got 0xf13268c0, expected 0xf1326160 (GTT map 0xf1326000-0xf1426000)
> [    5.503397] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0=
: Got 0xf13268c4, expected 0xf1326164 (GTT map 0xf1326000-0xf1426000)
> [    5.516202] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0=
: Got 0xf13268c0, expected 0xf1326168 (GTT map 0xf1326000-0xf1426000)
> [    5.528993] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0=
: Got 0xf13268c4, expected 0xf132616c (GTT map 0xf1326000-0xf1426000)
[...]=20
> [    5.878809] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0=
: Got 0xf1416ec0, expected 0xf1570ec0 (VRAM map 0xf1480000-0xf1580000)

> For the GTT->VRAM copy it looks like the AGPGART driver at least
> gets the graphics aperture translation table right, as both the
> returned and expected values are within a page. But the page offset
> of the returned values (0x8c0, 0x8c4) makes me wonder whether I'm
> fooled by a hardware bug or a cache coherency problem.

Hard to say... at least it managed to transfer the first 352 bytes
correctly. ;)

> The VRAM->GTT copy totally puzzles me, as it returns a wrong page
> address, but the offset is fine!?

Maybe it's still the values from the GTT->VRAM test, i.e. either the GPU
writes didn't make it to the memory mapped into the AGP GART (some AGP
bridges are known to have issues with that) or the CPU doesn't see it.

BTW, does your driver set cant_use_aperture, or is the linear aperture
accessible by the CPU?


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
