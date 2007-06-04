Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A56ADDED5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:35:51 +1000 (EST)
In-Reply-To: <4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e3d0bbbcb90f0936a8d8557e934b7c14@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Mon, 4 Jun 2007 21:35:44 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Probably, I need to enable them in the dts tree (?) but since it's
>> a PCI
>> device that uses a GPIO pin for signalling interrupts, I'm trying to
>> find out where and how to configure this.
>
> Wow.  Hardware designers sure like to make things easy, don't they?
>
> I'm assuming it's a PCI device on the board (and not in a slot).
>
> I believe you're ok if you explicitly define the node, and point it
> at the IPIC for its interrupt.

That's the simplest way to do it, yes (and sometimes
the only way).  I believe for Linux you can get away
with not defining any of the standard PCI properties
in that new PCI node (well you need "reg" and very very
basic stuff like that, of course).

> Something like this:
>
> pci1: pci@8000 {
> 	...
> 	my_pci_device@0 {
> 		...
> 		interrupts = <irq#, sense>;
> 		interrupt-parent = <&ipic>;
> 	}
> }

Exactly.  Please remember that "interrupts" here
is in the ipic domain and not in the PCI domain,
so get the # interrupt cells and the sense value
from the ipic.


Segher
