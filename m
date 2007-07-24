Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9DBEBDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 14:06:38 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6O46WL9004683
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 21:06:32 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6O46VsN014966
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 23:06:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] Add a new member name to structure irq_host
Date: Tue, 24 Jul 2007 12:06:28 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635A69C88@zch01exm21.fsl.freescale.net>
In-Reply-To: <1185233771.5439.153.camel@localhost.localdomain>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<1185233771.5439.153.camel@localhost.localdomain>
From: "Chen Gong-B11801" <G.Chen@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can you give me a DTS example or code segment? I'm ambiguous about
what you said.

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Tuesday, July 24, 2007 7:36 AM
> To: michael@ellerman.id.au
> Cc: Chen Gong-B11801; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
>=20
> On Tue, 2007-07-24 at 09:22 +1000, Michael Ellerman wrote:
> > On Tue, 2007-07-24 at 08:04 +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2007-07-23 at 19:13 +0800, Chen Gong wrote:
> > > > This patch adds a new member 'name' for irq host's name to=20
> > > > structure irq_host and modifies the definition of the function=20
> > > > irq_alloc_host(). The assignment to the irq host's name is also=20
> > > > added to irq_alloc_host().
> > >=20
> > > I would instead prefer adding a irq_name callback to host, which=20
> > > would return a per-irq name. In some cases, they could=20
> return the OF=20
> > > path to the host for example.
> >=20
> > The pity is, for the 75% [1] of irq_hosts that have a device_node,=20
> > they will all have to implement the name callback, because they all=20
> > store the of node differently.
> >=20
> > Which makes me think (again) that we should have an optional=20
> > device_node pointer in irq_host. I know you said you wanted the irq=20
> > stuff to be OF agnostic, but the reality is most of the=20
> > implementations do have an OF node. And all of the newer irq_host=20
> > implementations do, with the exception of PS3 and celleb -=20
> which are special.
>=20
> Won't work well in practice due to things like:
>=20
>  - Cell iic -> one node per core, but one global host
>  - xics -> one node per source controller (lots of them in=20
> the tree) but one global host
>=20
> Ben.
>=20
>=20
>=20
