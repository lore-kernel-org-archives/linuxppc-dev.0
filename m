Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id E0A6C67D0D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 01:26:39 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 15:25:49 +0100
References: <20061207172259.64168f8c@localhost>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
In-Reply-To: <1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612111525.50044.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 11 December 2006 14:18, Segher Boessenkool wrote:
> > We have to include the IPMI information in a way which can be used
> > for controllers which are accessed via memory mapped or legacy I/O.
>=20
> How to access registers is implicit in the device tree;
> just look at the parent bus, it knows how to do it, given
> the "reg" value in your device.

right, though it's a little different if you need special opcodes,
like DCR on ppc4xx or PIO on i386. Let's not worry about those
for now.

> > (2)
> > name =3D ipmi
> > device_type
>=20
> device_type =3D ipmi-kcs
>=20
> There's no real reason to include the IPMI version number
> in here, if you really need the version it's trivial to
> probe for; it's not a property of the hardware but of the
> software on the controller (unless some day the IPMI spec
> breaks backwards compatibility, of course).

Why not this?

device-type =3D ipmi
compatible =3D ipmi-kcs

I thought the device-type tells you what kind of bindings to
use, and the compatible (and/or model) tells you how to
access it. E.g. all PHBs have device-type=3Dpci and compatible=3Dwhatever,
which tells you how to access the config space registers.

> > regs =3D <addr> <len>
> > reg-spacing =3D <number>
> > reg-size =3D <number>
> > reg-shift =3D <number>
> >
> > The main difference between (1) and (2) is that (2) will represent
> > the whole register region within the reg property.
>=20
> Which is the proper thing to do. =A0The "reg" property should
> describe all of the address space your device listens to.
> Some IPMI-KCS devices listen to just the two registers, some
> listen to an 8-reg block, some to a 16-reg block.

ok

	Arnd <><
