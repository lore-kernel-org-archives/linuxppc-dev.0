Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
 by ozlabs.org (Postfix) with SMTP id 1A890B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 02:14:11 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Fri, 20 Apr 2012 18:14:07 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1334927896.5989.463.camel@thor.local>
Message-ID: <20120420161407.190300@gmx.net>
MIME-Version: 1.0
References: <20120420111527.190290@gmx.net>
 <1334927896.5989.463.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
To: =?iso-8859-1?Q?=22Michel_D=E4nzer=22?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Fri, 20 Apr 2012 15:18:16 +0200
> Von: "Michel Dänzer" <michel@daenzer.net>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@lists.ozlabs.org
> Betreff: Re: PowerPC radeon KMS - is it possible?

> On Fre, 2012-04-20 at 13:15 +0200, Gerhard Pircher wrote: 
> > > Von: "Michel Dänzer" <michel@daenzer.net>
> > > On Don, 2012-04-19 at 13:48 +0200, Gerhard Pircher wrote: 
> > > > 
> > > > The "former case" is an explanation, why I see data corruption
> > > > with my< AGPGART driver (more or less a copy of the uninorth
> > > > driver) on my non-coherent platform. There are no cache flushes
> > > > done for writes to already mapped pages.
> > > 
> > > As I said, the radeon driver always maps AGP memory uncacheable for
> > > the CPU, so no such CPU cache flushes should be necessary.
> > I know. We also discussed this topic over two years ago. :-)
> > 
> > What I didn't understand yet is how this uncacheable memory is
> > allocated (well, I never took the time to look at this again). The
> > functions in ttm_page_alloc.c seem to allocate normal cacheable
> > memory and try to set the page flags with set_pages_array_uc(),
> > which is more or less a no-op on powerpc. ttm_page_alloc_dma.c on
> > the other side is only used with SWIOTLB!?
> [...] 
> > Could it be that the memory is finally mapped uncacheable by
> radeon_bo_kmap()/
> > ttm_bo_kmap()/..some other TTM functions../vmap()?
> 
> Yeah, AFAICT, basically ttm_io_prot() defines the mapping attributes,
> and vmap() is used to enforce them for kernel mappings.
Okay, that sounds like the approach used by arch/powerpc/mm/dma-
noncoherent.c in my ("green") ears. What about the PCIGART mode?
Is the driver free to use cached memory in this mode?

> > Here is an excerpt of the 2.6.39 kernel log. IIRC the testing code
> > changed in the meantime so I guess it would make sense to repeat it
> > with a newer kernel version.
> 
> I was going to suggest that. :)
As expected. :-)

> > [    5.490569] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326160 (GTT map 0xf1326000-0xf1426000)
> > [    5.503397] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf1326164 (GTT map 0xf1326000-0xf1426000)
> > [    5.516202] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326168 (GTT map 0xf1326000-0xf1426000)
> > [    5.528993] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf132616c (GTT map 0xf1326000-0xf1426000)
> [...] 
> > [    5.878809] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ec0, expected 0xf1570ec0 (VRAM map 0xf1480000-0xf1580000)
> 
> > For the GTT->VRAM copy it looks like the AGPGART driver at least
> > gets the graphics aperture translation table right, as both the
> > returned and expected values are within a page. But the page offset
> > of the returned values (0x8c0, 0x8c4) makes me wonder whether I'm
> > fooled by a hardware bug or a cache coherency problem.
> 
> Hard to say... at least it managed to transfer the first 352 bytes
> correctly. ;)
Better than nothing! :-)

> > The VRAM->GTT copy totally puzzles me, as it returns a wrong page
> > address, but the offset is fine!?
> 
> Maybe it's still the values from the GTT->VRAM test, i.e. either the GPU
> writes didn't make it to the memory mapped into the AGP GART (some AGP
Good point. Maybe I should explicitly clear the gtt_map before the
VRAM->GTT copy test is executed.

> bridges are known to have issues with that) or the CPU doesn't see it.
What is the workaround for such an AGP bridge? If there is one at all...

> BTW, does your driver set cant_use_aperture, or is the linear aperture
> accessible by the CPU?
The driver sets cant_use_aperture. I couldn't get it working at all
without it.

regards,
Gerhard
-- 
Empfehlen Sie GMX DSL Ihren Freunden und Bekannten und wir
belohnen Sie mit bis zu 50,- Euro! https://freundschaftswerbung.gmx.de
