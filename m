Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
 by ozlabs.org (Postfix) with SMTP id AF871B7021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 21:15:32 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Fri, 20 Apr 2012 13:15:27 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20120420111527.190290@gmx.net>
MIME-Version: 1.0
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
> Datum: Thu, 19 Apr 2012 14:41:16 +0200
> Von: "Michel Dänzer" <michel@daenzer.net>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@lists.ozlabs.org, schwab@linux-m68k.org, ojordan12345@hotmail.co.uk
> Betreff: Re: PowerPC radeon KMS - is it possible?

> On Don, 2012-04-19 at 13:48 +0200, Gerhard Pircher wrote: 
> > > Von: "Michel Dänzer" <michel@daenzer.net>
> > > On Mit, 2012-04-18 at 18:23 +0200, Gerhard Pircher wrote: 
> > > > > Von: "Michel Dänzer" <michel@daenzer.net>
> > > > > On Mit, 2012-04-18 at 17:49 +0200, Gerhard Pircher wrote: 
> > > > > > 
> > > > > > That may be a stupid question, but is it allowed (for a DRM
> > > > > > client or whatever does the mapping) to change the content of
> > > > > > a page mapped into the AGP GART or is it necessary to
> > > > > > explicitly unmap the page, change its content and map it again?
> > > > > 
> > > > > The former.
> > > > I know that the uninorth AGPGART driver does a cache flushing for
> > > > newly mapped pages, but is there any code in the driver that
> > > > handles the former case (or isn't this necessary on PPC Macs)?
> > > 
> > > If by 'former case' you mean userspace modifying memory mapped into
> > > the AGP GART, then no, this generally doesn't require special
> > > treatment on PowerMacs. (Ignoring the potential issue mentioned by
> > > Ben in this thread)
> > I guess you refer to the ordering issue here.
> 
> Yeah.
> 
> > The "former case" is an explanation, why I see data corruption with my
> > AGPGART driver (more or less a copy of the uninorth driver) on my
> > non-coherent platform. There are no cache flushes done for writes to
> > already mapped pages.
> 
> As I said, the radeon driver always maps AGP memory uncacheable for the
> CPU, so no such CPU cache flushes should be necessary.
I know. We also discussed this topic over two years ago. :-)

What I didn't understand yet is how this uncacheable memory is allocated
(well, I never took the time to look at this again). The functions in
ttm_page_alloc.c seem to allocate normal cacheable memory and try to set
the page flags with set_pages_array_uc(), which is more or less a no-op
on powerpc. ttm_page_alloc_dma.c on the other side is only used with
SWIOTLB!?

> > I tested this with radeon.test=1, but I'm not even sure if this code
> > changes already mapped pages [...]
> 
> It does. radeon_bo_pin(..., RADEON_GEM_DOMAIN_GTT, ...) binds the buffer
> memory into the AGP GART, and the test only maps it to the CPU after
> that.
Could it be that the memory is finally mapped uncacheable by radeon_bo_kmap()/
ttm_bo_kmap()/..some other TTM functions../vmap()?

> I take it the test fails for you? How exactly?
I didn't work on the driver for a long time. It looks like I did the last
tests with a 2.6.39 kernel, where I changed the radeon test routine to not
stop on a failed copy. This way I could check for a pattern in the failed
copies.

Here is an excerpt of the 2.6.39 kernel log. IIRC the testing code changed
in the meantime so I guess it would make sense to repeat it with a newer
kernel version.

[    5.185619] calling  agp_init+0x0/0x5c @ 1
[    5.189816] Linux agpgart interface v0.103
[    5.193993] initcall agp_init+0x0/0x5c returned 0 after 4076 usecs
[    5.200359] calling  agp_articias_init+0x0/0x58 @ 1
[    5.205411] agpgart-articias 0000:00:00.0: MAI Logic Articia S chipset
[    5.213555] agpgart-articias 0000:00:00.0: configuring for size idx: 6
[    5.220996] agpgart-articias 0000:00:00.0: AGP aperture is 128M @ 0xc0000000
[    5.228557] initcall agp_articias_init+0x0/0x58 returned 0 after 22629 usecs
[    5.235791] calling  drm_core_init+0x0/0x16c @ 1
[    5.240839] [drm] Initialized drm 1.1.0 20060810
[    5.245623] initcall drm_core_init+0x0/0x16c returned 0 after 4937 usecs
[    5.252510] calling  ttm_init+0x0/0x8c @ 1
[    5.256908] initcall ttm_init+0x0/0x8c returned 0 after 197 usecs
[    5.263172] calling  radeon_init+0x0/0x11c @ 1
[    5.267731] [drm] radeon kernel modesetting enabled.
[    5.274683] [drm] initializing kernel modesetting (RV280 0x1002:0x5960).
[    5.281657] [drm] register mmio base: 0x88000000
[    5.286397] [drm] register mmio size: 65536
[    5.327510] [drm] AGP mode requested: 1
[    5.331485] agpgart-articias 0000:00:00.0: AGP 1.0 bridge
[    5.337071] agpgart-articias 0000:00:00.0: putting AGP V2 device into 1x mode
[    5.344440] radeon 0000:01:00.0: putting AGP V2 device into 1x mode
[    5.350865] radeon 0000:01:00.0: GTT: 128M 0xC0000000 - 0xC7FFFFFF
[    5.357197] [drm] Generation 2 PCI interface, using max accessible memory
[    5.364111] radeon 0000:01:00.0: VRAM: 256M 0x0000000080000000 - 0x000000008FFFFFFF (256M used)
[    5.373060] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    5.379815] [drm] Driver supports precise vblank timestamp query.
[    5.386068] [drm] radeon: irq initialized.
[    5.390264] [drm] Detected VRAM RAM=256M, BAR=128M
[    5.395177] [drm] RAM width 128bits DDR
[    5.399322] [TTM] Zone  kernel: Available graphics memory: 380684 kiB.
[    5.406047] [TTM] Zone highmem: Available graphics memory: 773900 kiB.
[    5.412725] [TTM] Initializing pool allocator.
[    5.417395] [drm] radeon: 256M of VRAM memory ready
[    5.422442] [drm] radeon: 128M of GTT memory ready.
[    5.428527] agpgart-articias 0000:00:00.0: TLB flush!
[    5.433785] radeon 0000:01:00.0: WB disabled
[    5.438671] [drm] Loading R200 Microcode
[    5.444292] agpgart-articias 0000:00:00.0: TLB flush!
[    5.449629] [drm] radeon: ring at 0x00000000C0001000
[    5.454761] [drm] ring test succeeded in 0 usecs
[    5.460620] agpgart-articias 0000:00:00.0: TLB flush!
[    5.465889] [drm] radeon: ib pool ready.
[    5.470212] [drm] ib test succeeded in 0 usecs
[    5.475939] agpgart-articias 0000:00:00.0: TLB flush!
[    5.490569] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326160 (GTT map 0xf1326000-0xf1426000)
[    5.503397] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf1326164 (GTT map 0xf1326000-0xf1426000)
[    5.516202] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326168 (GTT map 0xf1326000-0xf1426000)
[    5.528993] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf132616c (GTT map 0xf1326000-0xf1426000)
[    5.541777] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326170 (GTT map 0xf1326000-0xf1426000)
[    5.554535] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf1326174 (GTT map 0xf1326000-0xf1426000)
[    5.567303] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326178 (GTT map 0xf1326000-0xf1426000)
[    5.580049] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf132617c (GTT map 0xf1326000-0xf1426000)
[    5.592843] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326180 (GTT map 0xf1326000-0xf1426000)
[    5.605652] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf1326184 (GTT map 0xf1326000-0xf1426000)
[    5.618392] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326188 (GTT map 0xf1326000-0xf1426000)
[    5.631178] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf132618c (GTT map 0xf1326000-0xf1426000)
[    5.643970] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326190 (GTT map 0xf1326000-0xf1426000)
[    5.656769] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf1326194 (GTT map 0xf1326000-0xf1426000)
[    5.669494] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c0, expected 0xf1326198 (GTT map 0xf1326000-0xf1426000)
[    5.682293] [drm:radeon_test_moves] *ERROR* Incorrect GTT->VRAM copy 0: Got 0xf13268c4, expected 0xf132619c (GTT map 0xf1326000-0xf1426000)
[    5.878809] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ec0, expected 0xf1570ec0 (VRAM map 0xf1480000-0xf1580000)
[    5.891734] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ec4, expected 0xf1570ec4 (VRAM map 0xf1480000-0xf1580000)
[    5.904616] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ec8, expected 0xf1570ec8 (VRAM map 0xf1480000-0xf1580000)
[    5.917460] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ecc, expected 0xf1570ecc (VRAM map 0xf1480000-0xf1580000)
[    5.930286] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ed0, expected 0xf1570ed0 (VRAM map 0xf1480000-0xf1580000)
[    5.943164] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ed4, expected 0xf1570ed4 (VRAM map 0xf1480000-0xf1580000)
[    5.956052] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ed8, expected 0xf1570ed8 (VRAM map 0xf1480000-0xf1580000)
[    5.968898] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416edc, expected 0xf1570edc (VRAM map 0xf1480000-0xf1580000)
[    5.981758] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ee0, expected 0xf1570ee0 (VRAM map 0xf1480000-0xf1580000)
[    5.994593] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ee4, expected 0xf1570ee4 (VRAM map 0xf1480000-0xf1580000)
[    6.007455] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ee8, expected 0xf1570ee8 (VRAM map 0xf1480000-0xf1580000)
[    6.020309] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416eec, expected 0xf1570eec (VRAM map 0xf1480000-0xf1580000)
[    6.033208] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ef0, expected 0xf1570ef0 (VRAM map 0xf1480000-0xf1580000)
[    6.046077] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ef4, expected 0xf1570ef4 (VRAM map 0xf1480000-0xf1580000)
[    6.058964] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416ef8, expected 0xf1570ef8 (VRAM map 0xf1480000-0xf1580000)
[    6.071850] [drm:radeon_test_moves] *ERROR* Incorrect VRAM->GTT copy 0: Got 0xf1416efc, expected 0xf1570efc (VRAM map 0xf1480000-0xf1580000)

For the GTT->VRAM copy it looks like the AGPGART driver at least
gets the graphics aperture translation table right, as both the
returned and expected values are within a page. But the page offset
of the returned values (0x8c0, 0x8c4) makes me wonder whether I'm
fooled by a hardware bug or a cache coherency problem.
The VRAM->GTT copy totally puzzles me, as it returns a wrong page
address, but the offset is fine!?

br,
Gerhard

-- 
Empfehlen Sie GMX DSL Ihren Freunden und Bekannten und wir
belohnen Sie mit bis zu 50,- Euro! https://freundschaftswerbung.gmx.de
