Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 98A9767B92
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 14:47:49 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k9P4lmE9013518
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 21:47:48 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9P4ljRm025392
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 23:47:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Wed, 25 Oct 2006 12:47:43 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635219A16@zch01exm21.fsl.freescale.net>
In-Reply-To: <1161748274.22582.30.camel@localhost.localdomain>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > Segher Boessenkool wrote:
> > > > If a sync after an MMIO write is enough, then (in almost all
> > > > cases) so is an eieio.
> > >=20
> > > In this case, the spurious interrupts still happen with=20
> eieio, but=20
> > > not with sync.
> >=20
> > eieio on e300 core is just a no-op.
>=20
> It's not sent to the bus on non-cahed storage (like the PCI=20
> bridge ?) That's pretty bad ... there is quite a bit of code=20
> that assumes that eieio's will prevent write combining...

Due to the LSU, the e300 cored doesn't reorder non-cached
stroage, and doesn't implementation of write commbining.
So, actually its behavior likes eieio.

-Dave
