Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0456FDDE48
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 21:02:38 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 11:02:21 +0100
References: <989B956029373F45A0B8AF02970818900D432B@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF02970818900D432B@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702071102.22010.arnd@arndb.de>
Cc: Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 February 2007 10:16, Li Yang-r58472 wrote:
> Do you mean to create an of_plarform_driver here just to do the platform
> initialization? =A0The true USB driver can only takes platform_device as
> it is used by multiple architectures.
> btw: We don't access the mmio address of the device here. =A0We just need
> to read some property from the device tree.

The usb host controllers already come with an abstraction layer, e.g. there
is ehci-fsl.c, ehci-au1xxx.c and some more. All powerpc bases systems that
have the host controller on a local bus instead of PCI should use a common
driver for that, I believe one has already been posted some time ago,
but I'm not entirely sure about that.

As mentioned by Kumar Gala, we should eventually migrate over the users
of ehci-fsl to a new ehci-of, but getting rid of ehci-fsl means removing
all its users in arch/ppc first.

	Arnd <><
