Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7922DE580
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 05:04:31 +1000 (EST)
Message-ID: <48692E18.9050500@freescale.com>
Date: Mon, 30 Jun 2008 14:03:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: =?UTF-8?B?QW5kcsOpIFNjaHdhcno=?= <andre.schwarz@matrix-vision.de>
Subject: Re: MPC83xx ipic problem
References: <4868FCE9.1060103@matrix-vision.de>
In-Reply-To: <4868FCE9.1060103@matrix-vision.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

André Schwarz wrote:
> There are two external PCI devices connected (FPGA + miniPCI socket).
> The FPGA is working fine and uses IRQ0 for its PCI_INTA line.
> 
> As soon there's a miniPCI module present and the driver loaded (actually 
> an ath5k WiFi module) the system complains after a while :
> 
> irq 48: nobody cared
> handlers: .... location of the FPGA irq handler
> Disabling IRQ #48
> 
> -> This is weird since the FPGA isn't working at all and IRQ0 is *not* 
> asserted !

Are you *sure* that IRQ0 isn't asserted?  The IPIC seems to think it is.

> Of course the miniPCI irq is routed to a different pin on the CPU 
> (IRQ1).

Perhaps the board wiring is incorrect?

> interrupt-map = <0x5800 0 0 1 &ipic 0x30 0x8      -> FPGA @ IRQ0
>                  0x6000 0 0 1 &ipic 0x11 0x8      -> miniPCI INTA @ IRQ1
>                  0x6000 0 0 2 &ipic 0x11 0x8>;    -> miniPCI INTB @ IRQ1
> 
> Is it legal to use a single irq pin twice ?

Yes.

-Scott
