Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EABEA2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 08:39:33 +1000 (EST)
Date: Tue, 2 Jul 2013 17:39:18 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130702032447.GA26391@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Mon Jul  1 22:24:47 2013)
Message-ID: <1372804758.8183.124@snotra>
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

On 07/01/2013 10:24:47 PM, Kevin Hao wrote:
> On Mon, Jul 01, 2013 at 07:30:45PM -0500, Scott Wood wrote:
> > On 06/30/2013 02:33:10 AM, Kevin Hao wrote:
> > >On Thu, Jun 27, 2013 at 08:47:27PM -0500, Scott Wood wrote:
> > >> On 06/27/2013 08:36:37 PM, Kevin Hao wrote:
> > >> >On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> > >> >> On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> > >> >> >This is based on the codes in the head_44x.S. Since we always
> > >> >align to
> > >> >> >256M before mapping the PAGE_OFFSET for a relocatable kernel,
> > >> >we also
> > >> >> >change the init tlb map to 256M size.
> > >> >>
> > >> >> Why 256M?
> > >> >
> > >> >For two reasons:
> > >> >  1. This is the size which both e500v1 and e500v2 support.
> > >> >  2. Since we always use the PAGE_OFFSET as 0xc0000000, the =20
> 256M is
> > >> >     max alignment value we can use for this virtual address.
> > >>
> > >> Is there any reason why 64M won't continue to work here?
> > >
> > >Yes. In general we would map the 0 ~ 256M memory region in the =20
> first
> > >tlb1 entry. If we align to 64M, the relocatable kernel would not =20
> work
> > >if loaded above 64M memory. For example, if we load a relocatable
> > >kernel
> > >at 64M memory, we will relocate it as:
> > >	__pa(PAGE_OFFSET) =3D 0x4000000
> > >
> > >But in map_mem_in_cams function, it will create a memory map as:
> > >	__pa(PAGE_OFFSET) =3D 0x0
> > >
> > >The kernel will definitely not work in this case.
> >
> > That's a problem with map_mem_in_cams(), as discussed in the thread
> > on other patch.  Perhaps fully solving those problems is not
> > worthwhile at this time, but we should at least be able to determine
> > the TLB size automatically based on the alignment of the address
> > you're trying to map.  64M would be used unless (address & (256M -
> > 1)) >=3D 64M.  I hope we can continue to assume the kernel won't cross
> > a 64M boundary.
>=20
> No. The problem is we don't know the physical address of the start of
> lowmem at booting. So we have to align to physical address (phys1) =20
> blindly
> and map the PAGE_OFFSET from there. Then once we get the physical =20
> address
> (phys2) of the start of lowmem from the device tree later, we will =20
> map the
> PAGE_OFFSET to the start of lowmem. If the phys1 is not equal to =20
> phys2,
> we get a problem.

How would you get phys1 !=3D phys2, unless the kernel begins in a =20
256M-aligned region other than the first (which you said is already not =20
supported)?

If (phys1 & (256M - 1)) < 64M, then you'd get the same phys2 regardless =20
of whether you align it to 64M or 256M.
Otherwise, we use a 256M page which is what you're already doing.

> > >And maybe someone still want to use this relocation method.
> >
> > Then you don't get to dismiss claims that you're changing
> > DYNAMIC_MEMSTART alignment requirements by saying that RELOCATABLE
> > is a strict superset. :-)  Given the requirement that the kernel be
> > in the first TLB entry, though, using RELOCATABLE rather than
> > DYNAMIC_MEMSTART doesn't fix the alignment problem.
> >
> > I don't think it makes sense to keep both mechanisms around unless
> > there's some obvious reason to prefer DYNAMIC_MEMSTART.
>=20
> The DYNAMIC_MEMSTART still can be used for such as AMP kernel. It =20
> does have
> a more small footprint than RELOCATABLE and also doesn't have the =20
> overhead
> of the relocation. So I don't want to drop it in a rush.

How much overhead (space and time) is this really?

It will keep the code (and especially the diff) simpler to have this =20
replace DYNAMIC_MEMSTART rather than add to it.

-Scott=
