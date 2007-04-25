Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3F0B9DDEC5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 08:03:01 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Thu, 26 Apr 2007 00:02:54 +0200
References: <20070417210745.GA3567@aepfle.de>
	<200704250949.17795.arnd@arndb.de>
	<3f8a4cde6b06ee98203d62dc33c1630f@kernel.crashing.org>
In-Reply-To: <3f8a4cde6b06ee98203d62dc33c1630f@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260002.54627.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 April 2007, Segher Boessenkool wrote:

> > It won'd be found by the of_platform_driver part of ipmi,
> > since devices on the ISA bus do not get added to the linux
> > device tree.
>=20
> Drat. =A0Why not?

We have a number of buses on which devices get automatically added
as of_devices into the Linux driver infrastructures. Which buses
are probed depends on the platform, it may include e.g. "soc",
"plb5" and "siliconbackplane", but no platform currently scans
the ISA bus.

> > We might still want to have the driver use a proper of_device,
> > which would require the maple platform code to add this device
> > during probing.
>=20
> That sounds like the only option then. =A0Does
> this have to be done per platform though? =A0It
> sounds perfectly safe to do it in more generic
> code.

I think the right solution would be to add automatic probing
of all ISA devices into the platform independent code. Besides
making IPMI work on JS21, it would result in the legacy serial
ports to show up in the right place in sysfs.

I am however worried about what other side-effects this change
could have on platforms that have a broken ISA device in their
device trees.

	Arnd <><
