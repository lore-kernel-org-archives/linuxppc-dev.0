Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 72A1967C5A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 17:39:14 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7O7pOPP001045
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:51:24 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7O7dAT3023801
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 02:39:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] Adapt ipic driver to new host_ops interface,
	addset_irq_type to set IRQ sense
Date: Thu, 24 Aug 2006 15:39:40 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC344@zch01exm20.fsl.freescale.net>
In-Reply-To: <1156398982.8433.200.camel@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Thursday, August 24, 2006 1:56 PM
> To: Li Yang-r58472
> Cc: Phillips Kim-R1AAHA; linuxppc-dev@ozlabs.org
> Subject: RE: [PATCH 1/3] Adapt ipic driver to new host_ops
> interface,addset_irq_type to set IRQ sense
>=20
>=20
> > But for IRQ with a specified type, set_irq_type() will be called two
> > times continuously.  Why not call the set_irq_type() in any case in
> > irq_create_of_mapping()?
>=20
> well... it would still not be called by irq_create_mapping() (the
non-OF
> one). You need to make sure your stuff is properly initialized in the
> case there it's not called. That is that you have a proper default irq
> type, handler, and HW setup after host_map() returns.
>=20
> It's not terribly harmful to have set_irq_type() called twice. Another
> option is to have host_map re-do what your set_type() does, or move
the
> common code into a low level __set_type() that gets called by both
> set_irq_type() and your host_map ...

Currently, it's difficult to get the irq type in host_map() before it is
set in set_type().  Shall we add flow_type to the host_map() parameters?
