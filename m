Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 14DE7DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 20:53:35 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2F9rV9I012864
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 02:53:32 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2F9rUHt018575
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 04:53:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Add irq host and hwirq pair fields to outputwhenshowing
	interrupts.
Date: Thu, 15 Mar 2007 17:53:27 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C1320F5@zch01exm26.fsl.freescale.net>
In-Reply-To: <1173793926.24454.74.camel@localhost.localdomain>
References: <1173755968459-git-send-email-wei.zhang@freescale.com>
	<1173770092.24454.69.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C131E7F@zch01exm26.fsl.freescale.net>
	<1173793926.24454.74.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > Now, regarding the patch itself, printing the hw irq is not=20
> > > that useful
> > > without some indication of which host it belongs to. Best=20
> is to add a
> > > name() or something like that to the host ops.
> > >=20
> >=20
> > Sure, can I use the PIC controller node full name from=20
> of_tree as the
> > host name?
>=20
> There is no 1:1 relationship between an OF node and an irq=20
> host. (There
> is -most- of the time but I left the irq core on purpose more=20
> flexible,
> hence the match() method. On some setups it makes sense to=20
> have multiple
> HW PICs share a single domain number (for example on cell).
>=20
> Thus I'd rather have a way for the host to give you that=20
> name, which in
> turn can be the OF path if there is such a thing, or something else...
>=20
> Best might be 4 columns:
>=20
> <virq> <hwirq> <pic name> <host name>
>=20
> (PIC name is the same as in /proc/interrupts).
> =20
> > Do you prefer debugfs instead of /proc/interrupts?
>=20
> Yes, at least for now. Maybe if we can convince ourselves that nothing
> significant would break of changing /proc/interrupts, then we can add
> stuffs to it, but I'd rather avoid.
>=20

Hi, Ben,=20

How about set the host name when calling irq_alloc_host?
In the mpic, the host name can be the mpic->name, is it ok?

Thanks!
Best Regards,
Zhang Wei
