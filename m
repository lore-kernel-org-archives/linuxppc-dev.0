Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B894DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 17:42:10 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1J6g2aC019249
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 23:42:02 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n1J6g0Zo019117
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 00:42:01 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Date: Thu, 19 Feb 2009 14:41:58 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED246F38@zch01exm26.fsl.freescale.net>
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054A@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054A@mailsvr>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Dushara Jayasinghe" <DusharaJ@optiscan.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Dushara Jayasinghe [mailto:DusharaJ@optiscan.com]=20
> Sent: Thursday, February 19, 2009 2:33 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Li Yang-R58472
> Subject: RE: Newby trying to get Ethernet going on MPC83xx=20
> series device.
>=20
> Thanks for the swift response.
>=20
> > > I also found that both gfar_init (in gianfar.c) and=20
> gfar_mdio_init=20
> > > (in gianfar_mii.c) are called but the probe handlers of either of=20
> > > these devices are not executed.
> > > =20
> > > What am I missing?
>=20
> > Don't find any obvious problem.  I suggest you to debug=20
> gfar_of_init()=20
> > in arch/powerpc/sysdev/fsl_soc.c to see if it works correctly.
>=20
> That fn doesn't exist in the dev tree I'm using (commit=20
> 103f194f3ccf46842548eb52e607167b6d4951ef)
>=20
> The driver is now initialised through of_device. I can't=20
> figure out how the probe handler is invoked.

Well, I was looking at an older tree.  If you are using of_device for
TSEC, the most likely cause of this problem is that
of_platform_bus_probe() didn't probe your ethernet nodes.

Refer to the following code in
arch/powerpc/platforms/83xx/mpc834x_itx.c.  Make sure it creates
of_platform_device for TSEC.

static struct of_device_id __initdata mpc834x_itx_ids[] =3D {
        { .compatible =3D "fsl,pq2pro-localbus", },
        { .compatible =3D "simple-bus", },
        {},
};

static int __init mpc834x_itx_declare_of_platform_devices(void)
{
        return of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
}
machine_device_initcall(mpc834x_itx,
mpc834x_itx_declare_of_platform_devices);
