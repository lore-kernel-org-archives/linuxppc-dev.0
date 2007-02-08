Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 8820CDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 18:35:11 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l187Z6ww001310
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 00:35:06 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l187Z1cS000876
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 01:35:05 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Thu, 8 Feb 2007 15:36:18 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D441A@zch01exm26.fsl.freescale.net>
In-Reply-To: <6C343491-B877-4D7D-A46D-B078862160F6@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, Tabi Timur-B04825 <timur@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, February 08, 2007 3:16 PM
> To: Li Yang-r58472
> Cc: Tabi Timur-B04825; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys
to generic
> iopa
>=20
>=20
> On Feb 8, 2007, at 1:06 AM, Li Yang-r58472 wrote:
>=20
> >>> MURAM is a mmio region so it don't share the characteristic of
main
> >>> memory that phy_addr =3D virt_addr - PAGE_OFFSET.  While they can
> >>> both be
> >>> mapped through page table using iopa().
> >>
> >> Right, so when do you know if you'll be using MURAM or normal
> >> memory?  Why not just keep around a token that is the physical
> >> address at the point you make the decision of MURAM vs normal
memory.
> >
> > Yes, that can be a way.  But as the virt to phy mapping is only used
> > once, it's nothing bad to do it this way.
>=20
> The problem as I stated before with using iopa() is that its not
> supported across platforms.

Yes, it is only for PPC32.  But we don't have another API to do it.  How
about make it more generic to add PPC64 version?

- Leo
