Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A09D7DDED2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 03:12:46 +1100 (EST)
In-Reply-To: <200702071144.29548.arnd@arndb.de>
References: <989B956029373F45A0B8AF02970818900D4339@zch01exm26.fsl.freescale.net>
	<200702071144.29548.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5203B83E-B906-40A6-8D17-880BFA7CE542@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 10:10:32 -0600
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2007, at 4:44 AM, Arnd Bergmann wrote:

> On Wednesday 07 February 2007 11:10, Li Yang-r58472 wrote:
>> How about a non-PCI ehci driver for all architectures (such as  
>> arm, m68k)?
>> Then, platform_bus is a more generic interface than of_platform.
>
> Yes, that's right. The main difference is that if you scan all of  
> devices
> at boot time, you already have a node for the USB controller and you
> shouldn't need to create another node that does not reflect the actual
> hierarchy in the linux device tree.
>
> A platform_device is really meant to be 'something that can't be  
> probed
> but we know it is there', like the interrupt controller on a PC.
> With the of device tree, we can probe anything, so ideally, we should
> not need to create any platform devices at all.

I think the concern is how to handle the case on something like ARM w/ 
o the device-tree.  We can support both mechanisms in the driver

However, the bigger issue is getting so we can remove arch/ppc  
consumers.

- k
