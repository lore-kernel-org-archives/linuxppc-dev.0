Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 699E4DE6B5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 03:59:58 +1000 (EST)
Message-ID: <48B6E6F2.9020403@freescale.com>
Date: Thu, 28 Aug 2008 12:57:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: skepper@ukf.net
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>	<48AEF220.7080506@freescale.com>	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>	<20080826140324.GB3783@ld0162-tx32.am.freescale.net>	<Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>	<48B43C42.5040407@freescale.com>	<Pine.LNX.4.62.0808271413001.14220@chara.vm.bytemark.co.uk>	<20080827150105.GB16041@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.62.0808281747440.24851@chara.vm.bytemark.co.uk>
In-Reply-To: <Pine.LNX.4.62.0808281747440.24851@chara.vm.bytemark.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chris Skepper wrote:
> Thanks so much for your help so far.  I was able to find out this 
> address from the bootloader and get some output on the early debug 
> console which was very pleasing.  It now gets as far as console_init() 
> called from init/main.c, which completes but then any printk seems to 
> stall it and you get no more output.
> 
> I am using SMC1 and have this in the DTS file for the linux,stdout-path:
> 
> serial@11a80 {
>     device_type = "serial";
>     compatible = "fsl,mpc8247-smc-uart",
>                 "fsl,cpm2-smc-uart";
>     reg = <0x11a80 0x20 0x87fc 2>;
>     interrupts = <4 8>;
>     interrupt-parent = <&PIC>;
>     fsl,cpm-brg = <7>;
>     fsl,cpm-command = <0x1d000000>;
> };
> 
> Any ideas what sorts of things I should check next?

Check the BRG frequency (clock-frequency in the brg node), and the baud 
rate that the driver is trying to set.  As a quick check, you can 
disable calls to cpm2_setbrg() to see if that's the problem.

-Scott
