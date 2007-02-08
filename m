Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E08E9DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 20:21:04 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l189KtwD013870
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 02:20:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l189KrTs001656
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 03:20:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Discussion about iopa()
Date: Thu, 8 Feb 2007 17:22:10 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
In-Reply-To: <82ABE776-0C94-4FAE-BD24-071988842EA9@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >>>>> MURAM is a mmio region so it don't share the characteristic of
> > main
> >>>>> memory that phy_addr =3D virt_addr - PAGE_OFFSET.  While they =
can
> >>>>> both be
> >>>>> mapped through page table using iopa().
> >>>>
> >>>> Right, so when do you know if you'll be using MURAM or normal
> >>>> memory?  Why not just keep around a token that is the physical
> >>>> address at the point you make the decision of MURAM vs normal
> > memory.
> >>>
> >>> Yes, that can be a way.  But as the virt to phy mapping is only
used
> >>> once, it's nothing bad to do it this way.
> >>
> >> The problem as I stated before with using iopa() is that its not
> >> supported across platforms.
> >
> > Yes, it is only for PPC32.  But we don't have another API to do
> > it.  How
> > about make it more generic to add PPC64 version?
>=20
> Why do you need another API to do this, you already have the
> information you want, its just a matter of you keeping track of it.

Do you think we should remove iopa?

The information is often not so obvious.  The most case of using iopa is
that we allocate memory from MURAM using rheap, and then get the
physical address of it.  We can calculate phy_addr by using:  virt_addr
- virt_muram_base + phy_muram_base, but it is not as straightforward as
just using the page table, let alone we need to keep track of
virt_muram_base and phy_muram_base.

- Leo
