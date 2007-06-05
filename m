Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 20FD3DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 20:12:28 +1000 (EST)
In-Reply-To: <20070604211740.GN17456@chiana.homelinux.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f2590a315e5c6d3ca3d376cf93adb06a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Tue, 5 Jun 2007 12:12:16 +0200
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> pci1: pci@8000 {
>> 	...
>> 	my_pci_device@0 {
>> 		...
>> 		interrupts = <irq#, sense>;
>> 		interrupt-parent = <&ipic>;
>> 	}
>> }
>
> So I don't have to define the GPIO pins in pio-map in "vi) Pin
> configuration nodes" and already set in the U-Boot bootloader?

No, something in the firmware (or bootwrapper, bootloader)
obviously has to set up the GPIO as an external interrupt
source.

> I already tried hardcoding the EXT7 pin as assigned in the ppc arch
> (int 23); this would mean that, in the powerpc arch, the assignments of
> interrupts is different wrt to ppc?

I would hope the kernel isn't messing around with this
at all, and leave such low-level hardware configuration
to the firmware!


Segher
