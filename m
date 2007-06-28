Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2E502DDD06
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 00:49:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 3/5 v2] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Thu, 28 Jun 2007 16:47:55 +0200
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<200706272256.16418.arnd@arndb.de>
	<46B96294322F7D458F9648B60E15112C6F31B2@zch01exm26.fsl.freescale.net>
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F31B2@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706281647.57408.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 28 June 2007, Zhang Wei-r63237 wrote:
> > > +static __init int mpc86xx_of_device_init(void)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0return of_platform_bus_probe(NULL, mpc86xx_of_i=
ds, NULL);
> > > +}
> >=20
> > This will add any devices below the "fsl,rapidio-delta" device
> > as an of_device. Is that what you actually want? I would guess that
> > you want to add the bridge itself, not the devices below it.
> >=20
> > Is the rapidio device at the root of the device tree, and if so, why
> > not under the soc bus?
> >=20
>=20
> RapidIO is rather a bus that a device although these is no other nodes de=
fined in its sector now.
>=20

That's exactly my point. The meaning of of_platform_bus_probe() is 'add all
direct children of these nodes', not 'add these nodes', although it
happens to do that in the process.

Of course, looking at the device tree, rapidio is a device, not a bus,
because it does not have a device_type and it does not have any children
of its own.

	Arnd <><
