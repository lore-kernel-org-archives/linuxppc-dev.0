Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 59F80DDE4A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 17:49:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Wed, 25 Apr 2007 09:49:17 +0200
References: <20070417210745.GA3567@aepfle.de>
	<200704250001.18162.arnd@arndb.de>
	<0e76c9675bd1bcf4b7ed6bf83da8c3d7@kernel.crashing.org>
In-Reply-To: <0e76c9675bd1bcf4b7ed6bf83da8c3d7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704250949.17795.arnd@arndb.de>
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
> > I don't think there are any powerpc machines where it can find=20
> > something
> > there, but we decided to leave the code architecture independent in
> > case there ever are, and just to add the check_legacy_ioport call in=20
> > there.
>=20
> SLOF/JS21 (at least some versions of it) have an "ipmi"
> node on the "isa" bus. =A0And the kernel ipmi driver actually
> works on it, too (no idea about the currently proposed
> scanning though -- but the principle is correct at least).

It won'd be found by the of_platform_driver part of ipmi,
since devices on the ISA bus do not get added to the linux
device tree.

If the ipmi node on the ISA bus is located at the standardized
legacy I/O port range, it should get found by the later probing,
if check_legacy_ioport allows it.

We might still want to have the driver use a proper of_device,
which would require the maple platform code to add this device
during probing.

	Arnd <><
