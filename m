Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 8F0E5DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 20:56:37 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Undestanding ioread32() / readl() and friends
Date: Wed, 21 Feb 2007 10:56:27 +0100
References: <erh4m0$n83$1@sea.gmane.org>
In-Reply-To: <erh4m0$n83$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702211056.28313.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 21 February 2007 10:50, Florian Boelstler wrote:
> I just came across include/asm-ppc/io.h, which revealed that ioread32() 
> maps to readl(), which in turn maps to in_le32() (when CONFIG_APUS and 
> CONFIG_8260_PCI9 are both not defined).
> in_le32() uses a asm instruction lwbrx to do byte swapping.
> 
> I don't really get why ioread32() effectively returns a little-endian 
> value on a big-endian PPCs.
> 
> Is this a sort of general rule that ioread32() always returns 
> little-endian values on all architectures?

the ioread family of functions is used for PCI devices, which
are little-endian by definition.

If you want to access on-chip devices that are not behind PCI,
you should use the in_be family of functions.

	Arnd <><
