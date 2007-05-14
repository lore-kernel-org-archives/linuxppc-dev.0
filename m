Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8007CDDECC
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 18:04:11 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070514075415.7999BDDEC8@ozlabs.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 18:03:58 +1000
Message-Id: <1179129838.32247.84.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 17:53 +1000, Benjamin Herrenschmidt wrote:

>  - Handle allocation constraints of PIO for all bridges including
>    hot plugged ones within the 2GB space reserved for IO ports,
>    so that devices on hotplugged busses will now work with drivers
>    that assume IO ports fit in an int. 

Olof, Arnd, that should fix your problem but it's not 2.6.22 material.
I'll post a separate patch for 2.6.22 that does a temporary band aid,
basically calling pci_setup_phb_io() + remap_bus_range() rather than
pci_setup_phb_io_dynamic() from the of_device/PCI code and add a
spinlock to reserve_phb_iospace().

I found also a couple of other nits for which I'll do patches for
2.6.22. For example, we don't mask out the "tokens" at the top of IO
addresses in iounmap() which means it probably doesn't work on cell.
Ouch.

There's a number of other issues that my bigger patch fixes for which I
won't bother with a 2.6.22 backport though.

Cheers,
Ben.
