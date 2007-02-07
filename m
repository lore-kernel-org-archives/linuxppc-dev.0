Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id DE90ADDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 21:44:39 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 11:44:29 +0100
References: <989B956029373F45A0B8AF02970818900D4339@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF02970818900D4339@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702071144.29548.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 February 2007 11:10, Li Yang-r58472 wrote:
> How about a non-PCI ehci driver for all architectures (such as arm, m68k)?
> Then, platform_bus is a more generic interface than of_platform. 

Yes, that's right. The main difference is that if you scan all of devices
at boot time, you already have a node for the USB controller and you
shouldn't need to create another node that does not reflect the actual
hierarchy in the linux device tree.

A platform_device is really meant to be 'something that can't be probed
but we know it is there', like the interrupt controller on a PC.
With the of device tree, we can probe anything, so ideally, we should
not need to create any platform devices at all.

	Arnd <><
