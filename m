Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71B9CDDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:12:33 +1000 (EST)
Subject: Re: [PATCH] generic check_legacy_ioport
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200704250001.18162.arnd@arndb.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070424112530.GA11489@aepfle.de> <20070424185402.GA16077@aepfle.de>
	<200704250001.18162.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 10:12:20 +1000
Message-Id: <1177459940.14873.171.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-25 at 00:01 +0200, Arnd Bergmann wrote:
> On Tuesday 24 April 2007, Olaf Hering wrote:
> > 
> > > Do you think a device_type fdc, i8042 or ipmi will appear outside an isa
> > > node?
> > 
> > Does anyone know where those ipmi devices appear in the device-tree?
> 
> There are actually _no_ ipmi devices that we expect to appear here.
> the reason why the check is in the ipmi driver is in order not to crash
> on powerpc machines that load the ipmi driver but have no ipmi nodes
> in the device tree.

To be totally correct, there might well be, but we shouldn't care.

That is, if a device XXX (let's say XXX is ipmi but it could be i8042 or
whatever else) exist in the device-tree outside of the ISA bus, then it
needs it's own platform or of_platform device to be probed and shouldn't
make the check_legacy_io_port() go true.

There are various cases (especially in embedded world) where "standard"
components have been puts in ASICs but at funky/different addresses, and
they shouldn't be hit by the legacy probe.

Thus, the default implementation of check_legacy_ioport() should only
match things that are under an "isa" bus. Anything else needs to be
handled either by a platform specific check_legacy_ioport() override via
ppc_md (if it's really some legacy stuff and under a fucked up
device-tree) or via driver specific alternate probing method (like an
of_platform_device).

Ben.
