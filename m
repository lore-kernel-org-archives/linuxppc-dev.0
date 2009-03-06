Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC9EDDDF61
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 16:27:46 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n265Rh66002179
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 22:27:43 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n265Reh7029754
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Mar 2009 23:27:41 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
Date: Fri, 6 Mar 2009 13:27:39 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Liu Dave-R63238" <DaveLiu@freescale.com>,
	"Ben Menchaca" <ben.menchaca@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

and what settings  is DMA description bit 3?

> -----Original Message-----
> From: linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org]
>  On Behalf Of Liu Dave-R63238
> Sent: Friday, March 06, 2009 1:22 PM
> To: Ben Menchaca; linuxppc-dev@ozlabs.org
> Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
>=20
> Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and=20
> PEX_RDMA_CTRL[SNOOP]?
>=20
> What is the freq settings? CORE/CSB bus.
>=20
> Thanks, Dave
>=20
> ________________________________
>=20
> 	From: linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org]
>  On Behalf Of Ben Menchaca
> 	Sent: Friday, March 06, 2009 12:33 PM
> 	To: linuxppc-dev@ozlabs.org
> 	Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
> =09
> =09
> 	I am working on a Freescale 8314e design, and the=20
> embedded device is configured as a PCI-e endpoint running a=20
> 2.6.27-5 kernel.  For context, we have written a kernel=20
> module which, among other things, uses the RDMA/WDMA engine=20
> in the PCI-e IP block.  On the host side, these DMAs are=20
> coherent.  However, on the embedded side, things are quite a=20
> bit less rosy; we must manually flush/invalidate cache lines=20
> for WDMA/RDMAs to occur successfully.  After speaking with=20
> (several) FAEs at Freescale, we believe there is a=20
> configuration issue that is the cause, but we have yet to=20
> have anyone successfully point to it. =20
> =09
> 	Disabling the data cache altogether resolves the issue=20
> entirely, but of course, also completely tanks performance. =20
> As a temporary workaround, I would like to simply mark the=20
> pages (obtained currently via dma_alloc_coherent) involved as=20
> cache-inhibited.  I have attempted to do this via some=20
> snippets remaining in fec.c (va_to_pte, uncache_pte to set=20
> _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is=20
> almost certainly braindead; va_to_pte is not a part of the=20
> 83xx source, as far as I can tell; 8xx only.
> =09
> 	A quick pointer in the correct direction for marking=20
> pages as cache-inhibited on a 2.6.27-5 kernel would be=20
> appreciated, or if my approach to a workaround is flawed, a=20
> pointer to the correct way would be great.
> =09
> 	Ben Menchaca
> =09
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
