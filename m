Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F542DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:25:53 +1000 (EST)
In-Reply-To: <20070604095625.GF17456@chiana.homelinux.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Mon, 4 Jun 2007 14:25:59 -0500
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


On Jun 4, 2007, at 04:56, Marc Leeman wrote:

>
> I am moving my boards from arch/ppc/ to arch/powerpc/ and am trying to
> use the MPC83xx_IRQ_EXT? pins.
>
> The device (hardcoded to use 23 as with the arch/ppc/ config, EXT7)
> does not signal the ints to the CPU.
>
> The only reference I find to this usage in arch/powerpc/ is in
> arch/powerpc/platforms/83xx/mpc834x_itx.h, which is most likely
> something left over while moving from arch/ppc/
>
> Probably, I need to enable them in the dts tree (?) but since it's  
> a PCI
> device that uses a GPIO pin for signalling interrupts, I'm trying to
> find out where and how to configure this.


Wow.  Hardware designers sure like to make things easy, don't they?

I'm assuming it's a PCI device on the board (and not in a slot).

I believe you're ok if you explicitly define the node, and point it  
at the IPIC for its interrupt.  Something like this:

pci1: pci@8000 {
	...
	my_pci_device@0 {
		...
		interrupts = <irq#, sense>;
		interrupt-parent = <&ipic>;
	}
}
