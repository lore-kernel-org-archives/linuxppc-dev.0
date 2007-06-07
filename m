Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 47A2CDDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 20:07:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: a question on "iowrite32()"
Date: Thu, 7 Jun 2007 12:01:46 +0200
References: <BAY138-F6B2DA6BEF021C7026E522B2270@phx.gbl>
	<20070607062054.GD23294@moe.telargo.com>
In-Reply-To: <20070607062054.GD23294@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706071201.46637.arnd@arndb.de>
Cc: linuxppc@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007, Domen Puncer wrote:
> out_be32?
> I recall something about iowrite32 being PCI stuff and therefore little
> endian, but don't count on this being right.

You're completely right, out_be32 is the correct one. The primitives
we have for writing 32 bit I/O space are:

writel(): PCI memory space from ioremap
outl(): PCI I/O space from a struct resource
iowrite32(): PCI memory or I/O space from pci_iomap
iowrite32be(): defined but not useful anywhere currently
out_be32(): big-endian memory address from of_address_to_resource or of_iomap
out_le32(): like out_be32(), but little-endian
__raw_writel(): always broken, don't use

Since of_iomap() is rather new and hardly used by any drivers, we
could still redefine it so that you would use iowrite32{,be}() instead
of out_{be,le}32, but currently that doesn't work.

I also thought about changing of_iomap() to use the devres functions,
which basically attach information about the mapping to the device
structure, and automatically unmap those when the of_platform_driver
gets unregistered.

	Arnd <><
