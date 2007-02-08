Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C2476DDE23
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 17:46:54 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l186koCS003763
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 23:46:50 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l186kmCX015234
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 00:46:49 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Thu, 8 Feb 2007 14:48:04 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D4401@zch01exm26.fsl.freescale.net>
In-Reply-To: <CD216D17-B494-4B86-992D-453D68694A31@kernel.crashing.org>
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
> Sent: Thursday, February 08, 2007 1:58 PM
> To: Li Yang-r58472
> Cc: Tabi Timur-B04825; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys
to generic
> iopa
>=20
>=20
> On Feb 7, 2007, at 11:52 PM, Li Yang-r58472 wrote:
>=20
> >> -----Original Message-----
> >> From: Timur Tabi [mailto:timur@freescale.com]
> >> Sent: Thursday, February 08, 2007 1:03 AM
> >> To: Kumar Gala
> >> Cc: Li Yang-r58472; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH 1/4] ucc_geth: Change private
> >> immrbar_virt_to_phys
> > to generic
> >> iopa
> >>
> >> Kumar Gala wrote:
> >>
> >>> If its been mapped with ioremap() you know the physical address
> > already
> >>> so why do you need iopa().
> >>
> >> That's what the original function immrbar_virt_to_phys() does.
We're
> > trying to
> >> get rid of it, because we thought is redundant with iopa().
> >>
> >> static inline unsigned long immrbar_virt_to_phys(volatile void *
> > address)
> >> {
> >> 	if ( ((u32)address >=3D (u32)qe_immr) &&
> >> 			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE))
> > )
> >> 		return (unsigned long)(address - (u32)qe_immr +
> >> 				(u32)get_qe_base());
> >> 	return (unsigned long)virt_to_phys(address);
> >> }
> >>
> >> get_qe_base() does a search of the OF tree the first time it's
> >> called.
> >>
> >> Here's the code that calls immrbar_virt_to_phys():
> >>
> >> 	out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> >> 		 (u32) immrbar_virt_to_phys(ugeth->
> >> 					    p_tx_bd_ring[i]));
> >>
> >>
> >> Would it be better to replace this code with something like this:
> >>
> >> out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> >> 	get_qe_base() + ((void *) ugeth->p_tx_bd_ring[i] - (void *)
> > qe_immr));
> >
> > No, we don't know if the BD ring is in MURAM or main memory as it is
> > configurable.  iopa() is best choice to handle both case, IMHO.
>=20
> Does MURAM behave differently than normal memory?

MURAM is a mmio region so it don't share the characteristic of main
memory that phy_addr =3D virt_addr - PAGE_OFFSET.  While they can both =
be
mapped through page table using iopa().

- Leo
