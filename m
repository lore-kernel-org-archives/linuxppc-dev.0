Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 6FE9D1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 04:22:33 +1000 (EST)
Received: by gyd10 with SMTP id 10so4357846gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 11:22:31 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <57F24E98919C4D22A784127E6CF1C9DA@kos>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Jun 2010 12:22:11 -0600
Message-ID: <AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
To: Chris Alfred <c.alfred@internode.on.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 4:19 PM, Chris Alfred <c.alfred@internode.on.net> w=
rote:
> I am trying to port a DSA (Distributed Switch Architecture) driver for
> the Micrel KS8995M managed switch connected to a MPC5200. There is an
> SPI interface and MII interface managed by the DSA driver.
>
> I can't understand how probe gets called when the flatted device tree
> (FDT) system is used, and how to bind such a driver using the FDT (if
> you have to at all).
>
> The DSA driver is initialised via:
>
> =A0 =A0// net/dsa/dsa.c
>
> =A0 =A0static struct platform_driver dsa_driver =3D {
> =A0 =A0 .probe =A0=3D dsa_probe,
> =A0 =A0 .remove =A0=3D dsa_remove,
> =A0 =A0 .shutdown =3D dsa_shutdown,
> =A0 =A0 .driver =3D {
> =A0 =A0 =A0.name =3D "dsa",
> =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 },
> =A0 =A0};
>
> =A0 =A0static int __init dsa_init_module(void)
> =A0 =A0{
> =A0 =A0 return platform_driver_register(&dsa_driver);
> =A0 =A0}
>
> dsa_init_module is being called; but how do I get the system to call
> .probe?

You need a platform device registered for the driver to bind against.
On a lot of systems, the machine setup code just registers a
statically allocated platform_device.  You can still do this on
powerpc if you create a new machine specific board file in
arch/powerpc/platforms/ (discouraged, but only mildly so for things
that are very board specific).

The "preferred" approach on device tree systems is to add device tree
hooks to the driver you want to use.  However, I'm not going to ask
you to do that since the current approach for doing so is in the
process of being removed (The current approach is to add a new
of_platform_driver registration for the device driver; but I've got
changes in my tree that will make regular old platform_drivers able to
bind against devices described in the device tree).

To avoid writing new machine-specific code in arch/powerpc/platforms,
then I recommend that you add a node to your .dts file to describe the
DSA complex and write a very simple of_platform_driver that binds
against it.  Then use the probe hook to extract data out of the device
tree node (if needed) and register the appropriate platform_device
(don't forget to make the of_device the parent of the
platform_device).  This can be considered a temporary solution, but it
will not break when I make the infrastructure changes, and then you
can migrate over to the new method at your leisure.

Cheers,
g.
