Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D1ECADDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 07:57:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: publishing OF platform devices
Date: Thu, 29 Mar 2007 23:57:04 +0200
References: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
	<460C2F0F.3050808@246tNt.com>
In-Reply-To: <460C2F0F.3050808@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703292357.05205.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 29 March 2007, Sylvain Munaut wrote:
> John Rigby wrote:
> > I have a question about the "right" way to publish platform
> > devices via of_platform_bus_probe.
> >
> > On 5200 platforms it gets called from
> > mpc52xx_declare_of_platform_devices which is registered as the
> > machdep_calls init routine.
> > =A0=20
> It's called by machdep calls so that it's only called if the platform is
> detected ...
> > On other platforms it is called via a device_initcall
> > =A0=20
> That will always be called which is bad.
>=20
> Because if you have a kernel will multiple platform support built in, it
> will
> be called everytime, even if it's not running on the good platform.

The ppc_md->init() function is currently only present on 32 bit,
if we decide that this is the way to go, we should make it common
to both 32 and 64 bit platforms.

> > Also I noticed that some 83xx platforms don't call
> > of_platform_bus_probe at all. =A0Thats ok because most of those devices
> > are register various routines in fsl_soc.c. =A0The one I have not
> > figured out yet is spi, I don't see anyone registering mpc83xx_spi?
> >
> On theses I have no idea ...

They should be converted to use of_platform_bus_probe in the future. As soon
as we have of_platform_drivers for the devices probed in fsl_soc.c, we can
get rid of that file.

	Arnd <><
