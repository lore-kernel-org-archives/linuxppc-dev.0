Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF6D3DDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 17:27:30 +1000 (EST)
Message-ID: <46B0361C.2060709@genesi-usa.com>
Date: Wed, 01 Aug 2007 08:28:28 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
References: <200707250128.l6P1SWSF1336935@shell01.TheWorld.com>	<3a538bd3f5db759abb55a661e6e94c7a@kernel.crashing.org>
	<46B03561.9090800@genesi-usa.com>
In-Reply-To: <46B03561.9090800@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Alan Curry <pacman@theworld.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Just so you guys have it all in one pretty little package, these will remove
the need for the Pegasos IDE and ISA fixups in the prom_init.c too.

s" /pci@80000000/ide@C,1" find-device
d# 14 encode-int 0 encode-int
d# 15 encode-int 0 encode-int
encode+ encode+ encode+ s" interrupts" property
0x1018a encode-int s" class-code" property
device-end

s" /pci@80000000/isa@C" find-device
0x1 encode-int 0x0 encode-int 0x1006000 encode-int
0x0 encode-int 0x0 encode-int 0x1000 encode-int
encode+ encode+ encode+ encode+ encode+ s" ranges" property
device-end

If anyone wants to test and confirm the 8042 fix and then we can add
it to the end here.. we can unclutter the kernel.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Matt Sealey wrote:
> Yeah please do a fixup for the boot wrapper.
> 
> Or, if you have trouble, go into the firmware and type "nvedit", add
> these lines;
> 
> " /isa/8042" find-device
> " 8042" encode-string device-type
> 
> (then ctrl-c to exit and nvstore to run it on next reboot. Try it without
> the patch first, on the firmware console, just to be sure I got it right,
> because I can't test it here)
> 
> You don't need to patch Linux at all. In fact for silly things like this
> I would recommend against it :)
> 
