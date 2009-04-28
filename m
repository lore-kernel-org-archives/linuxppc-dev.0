Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40863DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:49:03 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3S1n0cd009558
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 18:49:01 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3S1mxH5009493
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 20:48:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] fsldma: use PCI Read Multiple command
Date: Tue, 28 Apr 2009 09:48:58 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928CABC@zch01exm21.fsl.freescale.net>
In-Reply-To: <49F608B7.9080409@ovro.caltech.edu>
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
	<49F608B7.9080409@ovro.caltech.edu>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>,
	"Tabi Timur-B04825" <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Zhang Wei <wei.zhang@freescale.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Here's a few results from DMA tests between two
> MPC8349EA boards housed in a CPCI chassis.
>=20
> 1. DMA mode register (DMAMRn)
>     PCI read command (PRC, bits 11:10)
>=20
>     a) DMAMRn[PRC] =3D 00 =3D PCI Read
>=20
>        The PCI read command is 6h on the PCI bus.
>        For DMA lengths of less than 1 cache line (32-bytes)
>        the DMA controller will generate a PCI 6h command.
>        However, for lengths of 32-bytes and higher, the
>        DMA controller actually generates a PCI Read Line (Eh)
>        command.
>=20
>        Freescale indicated that this 'change of PCI command code'
>        functionality is an undocumented 'feature', there to
>        improve performance for longer read lengths.
>=20
>     b) DMAMRn[PRC] =3D 01 =3D PCI Read Line
>=20
>        Generated the PCI command code for PCI read line (Eh),
>        regardless of DMA length.
>=20
>     c) DMAMRn[PRC] =3D 10 =3D PCI Read Multiple
>=20
>        Generated the PCI command code for PCI Read Multiple (Ch),
>        regardless of DMA length.

Good summary!

For the DMA PCI read/line/multi-line is outbound transaction.
So according to your experiment, the 8349 PCI controller(as master)
attemp to streaming/combining the outbound transaction(treated as
prefetchable
space).=20
IIRC, the early 8349EUM has the bit[2]-SE in the POCMRn
register, and is removed now. Not sure if it does function.
