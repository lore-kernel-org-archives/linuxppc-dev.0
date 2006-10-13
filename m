Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3E11667C3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 01:49:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9DFnXV5015937 for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 08:49:33 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9DFnVuo005653
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 10:49:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problems with DMA from user space on MPC834x (Cache coherency?)
Date: Fri, 13 Oct 2006 23:49:30 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26351C2A4E@zch01exm21.fsl.freescale.net>
In-Reply-To: <CDCE6FAC-2DA9-4D94-8BB6-C26622DF6685@kernel.crashing.org>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Lauri Ehrenpreis" <lauri.ehrenpreis@liewenthal.ee>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You can make use of the hardware cache coherency. Setup the DMA
attribute as global.
If you use the hardware way, you don't need these flushing operation.

-Dave

> > I added following before starting DMA:
> >
> > kaddr =3D (unsigned long)kmap(pages[i]);=20
> flush_dcache_range(kaddr, kaddr=20
> > + PAGE_SIZE); kunmap(pages[i]);
> >
> > ...and everything works now. As I understand this now,=20
> dma_map_page is=20
> > not flushing caches on MPS834x because the processor should=20
> snoop the=20
> > memory transactions and flush cache automatically if needed=20
> > (__dma_sync_page is defined as do { } while (0) in kernel).=20
> But there=20
> > exists an errata
> > (PCI5) which states that there may be some problems with this=20
> > automatic flushing. So the caches must be flushed with=20
> > flush_dcache_range.
>=20
> What silicon version are you using.  PCI5 should be fixed in=20
> rev1.1 and newer.  You can be taking a big perf hit having to=20
> flush all the time.
>=20
> - k
