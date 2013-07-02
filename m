Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15B3E2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 10:30:55 +1000 (EST)
Date: Mon, 1 Jul 2013 19:30:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130630073310.GA32268@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Sun Jun 30 02:33:10 2013)
Message-ID: <1372725045.8183.102@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2013 02:33:10 AM, Kevin Hao wrote:
> On Thu, Jun 27, 2013 at 08:47:27PM -0500, Scott Wood wrote:
> > On 06/27/2013 08:36:37 PM, Kevin Hao wrote:
> > >On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> > >> On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> > >> >This is based on the codes in the head_44x.S. Since we always
> > >align to
> > >> >256M before mapping the PAGE_OFFSET for a relocatable kernel,
> > >we also
> > >> >change the init tlb map to 256M size.
> > >>
> > >> Why 256M?
> > >
> > >For two reasons:
> > >  1. This is the size which both e500v1 and e500v2 support.
> > >  2. Since we always use the PAGE_OFFSET as 0xc0000000, the 256M is
> > >     max alignment value we can use for this virtual address.
> >
> > Is there any reason why 64M won't continue to work here?
>=20
> Yes. In general we would map the 0 ~ 256M memory region in the first
> tlb1 entry. If we align to 64M, the relocatable kernel would not work
> if loaded above 64M memory. For example, if we load a relocatable =20
> kernel
> at 64M memory, we will relocate it as:
> 	__pa(PAGE_OFFSET) =3D 0x4000000
>=20
> But in map_mem_in_cams function, it will create a memory map as:
> 	__pa(PAGE_OFFSET) =3D 0x0
>=20
> The kernel will definitely not work in this case.

That's a problem with map_mem_in_cams(), as discussed in the thread on =20
other patch.  Perhaps fully solving those problems is not worthwhile at =20
this time, but we should at least be able to determine the TLB size =20
automatically based on the alignment of the address you're trying to =20
map.  64M would be used unless (address & (256M - 1)) >=3D 64M.  I hope =20
we can continue to assume the kernel won't cross a 64M boundary.

> > >> This tightens the alignment requirement for dynamic memstart.
> > >
> > >Yes. But since RELOCATABLE is a superset of DYNAMIC_MEMSTART, we
> > >can always
> > >use RELOCATABLE instead of DYNAMIC_MEMSTART for fsl booke board in
> > >any cases.
> >
> > The extra flexibility of RELOCATABLE may help some use cases, but
> > you'd still require the entire 256M naturally aligned region
> > containing the kernel to be present and owned by this instance of
> > Linux.
> >
> > >So DYNAMIC_MEMSTART will seem not so useful after we enable this
> > >feature.
> >
> > Then why doesn't this patch remove it?
>=20
> According to the Kconfig it is still used by 44x.

RELOCATABLE appears to be supported on 44x, and is what CRASH_DUMP uses =20
on 44x.

> And maybe someone still want to use this relocation method.

Then you don't get to dismiss claims that you're changing =20
DYNAMIC_MEMSTART alignment requirements by saying that RELOCATABLE is a =20
strict superset. :-)  Given the requirement that the kernel be in the =20
first TLB entry, though, using RELOCATABLE rather than DYNAMIC_MEMSTART =20
doesn't fix the alignment problem.

I don't think it makes sense to keep both mechanisms around unless =20
there's some obvious reason to prefer DYNAMIC_MEMSTART.

> > >>  And
> > >> what about boards with less than 256 MiB of RAM?
> > >
> > >It should be fine. We just create the map in the tlb. The MM still =20
> use
> > >the real size of memory.
> >
> > No, you must not map anything that is not present with a mapping
> > that is executable and/or not guarded, or you could get speculative
> > accesses to who-knows-what.
>=20
> Yes, there may be speculative access in this case.
>=20
> >  Even if RAM is present there but owned
> > by some other entity, you could be creating illegal aliases if that
> > other entity mapped it cache-inhibited or similar.
>=20
> Fair enough. So it seems error prone if we map this 256M memory region
> blindly. But if we don't do this, it seems that we have to do twice =20
> relocation.
> The first time we just align to a predefined value (64M for example), =20
> and
> then parse the device tree and get the real memstart_addr. After that =20
> we
> should relocate the kernel to the real start address. It seems a =20
> little
> complicated. Do you have any better ideas?

This seems like the proper way to address it, assuming we're unwilling =20
to map the kernel image somewhere other than the normal lowmem mapping =20
(and I think we're unwilling, given how tight the address space is on =20
32-bit, and the intrusiveness of the change).  The dynamic =20
determination of 64M versus 256M could be an acceptable alternative =20
though, if we're OK with not supporting arbitrary relocatable =20
scenarios, but just those that are either needed by kdump, or supported =20
by current kernels (with DYNAMIC_MEMSTART, or just starting at zero =20
with less than 256M of RAM).  If we go that route, the limitations =20
should be documented.

-Scott=
