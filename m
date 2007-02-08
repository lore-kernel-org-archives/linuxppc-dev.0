Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7DB98DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 16:51:23 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l185pM2A020105
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 22:51:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l185pJsM000162
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 23:51:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Thu, 8 Feb 2007 13:52:37 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D43E9@zch01exm26.fsl.freescale.net>
In-Reply-To: <45CA0646.3060203@freescale.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Tabi Timur-B04825" <timur@freescale.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Timur Tabi [mailto:timur@freescale.com]
> Sent: Thursday, February 08, 2007 1:03 AM
> To: Kumar Gala
> Cc: Li Yang-r58472; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys
to generic
> iopa
>=20
> Kumar Gala wrote:
>=20
> > If its been mapped with ioremap() you know the physical address
already
> > so why do you need iopa().
>=20
> That's what the original function immrbar_virt_to_phys() does.  We're
trying to
> get rid of it, because we thought is redundant with iopa().
>=20
> static inline unsigned long immrbar_virt_to_phys(volatile void *
address)
> {
> 	if ( ((u32)address >=3D (u32)qe_immr) &&
> 			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE))
)
> 		return (unsigned long)(address - (u32)qe_immr +
> 				(u32)get_qe_base());
> 	return (unsigned long)virt_to_phys(address);
> }
>=20
> get_qe_base() does a search of the OF tree the first time it's called.
>=20
> Here's the code that calls immrbar_virt_to_phys():
>=20
> 	out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> 		 (u32) immrbar_virt_to_phys(ugeth->
> 					    p_tx_bd_ring[i]));
>=20
>=20
> Would it be better to replace this code with something like this:
>=20
> out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> 	get_qe_base() + ((void *) ugeth->p_tx_bd_ring[i] - (void *)
qe_immr));

No, we don't know if the BD ring is in MURAM or main memory as it is
configurable.  iopa() is best choice to handle both case, IMHO.

- Leo
