Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id A6FB6DDFF1
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 15:23:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Date: Fri, 26 Jan 2007 05:23:02 +0100
References: <20061218163846.337fed65@localhost>
	<20070125104540.65a1f557@localhost> <20070126025431.GC18537@lst.de>
In-Reply-To: <20070126025431.GC18537@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701260523.04229.arnd@arndb.de>
Cc: Christian@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 26 January 2007 03:54, Christoph Hellwig wrote:
> > =A0
> > +#ifdef CONFIG_PPC_OF
> > +#include <asm/of_device.h>
> > +#include <asm/of_platform.h>
> > +#endif
>=20
> Adding this OF-specific code to the generic file doesn't look exactly
> nice. =A0Is it possible to separate the code out to a separate ipmi_of.c
> file?

This file already contains the same code for a number of other bus
layers, it might be possible to split out the of part, but then we
should also have separate files for ACPI, PCI and all the others.

I think that reworking the ipmi layer is outside of the scope of
what we want right now, that can be another patch if there is
a consensus that it would be a good idea.

> > +static int __devexit ipmi_of_remove(struct of_device *dev)
> > +{
> > +=A0=A0=A0=A0=A0/* should call
> > +=A0=A0=A0=A0=A0 * cleanup_one_si(dev->dev.driver_data); */
>=20
> Wo why doesn't it do that currently?=20

This mimics the pci driver that also doesn't do it. The comment
is a hint that when it the ipmi driver gets cleaned up so
that _pci gets it right, _of should do the same. That should
also be a separate patch.

	Arnd <><
