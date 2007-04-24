Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5CB9EDDEC5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 08:01:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Wed, 25 Apr 2007 00:01:17 +0200
References: <20070417210745.GA3567@aepfle.de>
	<20070424112530.GA11489@aepfle.de>
	<20070424185402.GA16077@aepfle.de>
In-Reply-To: <20070424185402.GA16077@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704250001.18162.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 April 2007, Olaf Hering wrote:
> 
> > Do you think a device_type fdc, i8042 or ipmi will appear outside an isa
> > node?
> 
> Does anyone know where those ipmi devices appear in the device-tree?

There are actually _no_ ipmi devices that we expect to appear here.
the reason why the check is in the ipmi driver is in order not to crash
on powerpc machines that load the ipmi driver but have no ipmi nodes
in the device tree.

The init function of the ipmi module will scan all buses (PCI, ACPI, OF,
 ...) until it finds any devices using regular probes. If it doesn't,
it will poke at "well-known" io-ports that are used by convention on
legacy i386 machines.

I don't think there are any powerpc machines where it can find something
there, but we decided to leave the code architecture independent in
case there ever are, and just to add the check_legacy_ioport call in there.

	Arnd <><
