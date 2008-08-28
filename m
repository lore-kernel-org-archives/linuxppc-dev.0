Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id 7C678DE715
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 03:08:27 +1000 (EST)
Date: Thu, 28 Aug 2008 18:00:32 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
In-Reply-To: <20080827150105.GB16041@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.62.0808281747440.24851@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<48AEF220.7080506@freescale.com>
	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
	<20080826140324.GB3783@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>
	<48B43C42.5040407@freescale.com>
	<Pine.LNX.4.62.0808271413001.14220@chara.vm.bytemark.co.uk>
	<20080827150105.GB16041@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Wed, 27 Aug 2008, Scott Wood wrote:

> On Wed, Aug 27, 2008 at 02:30:47PM +0100, Chris Skepper wrote:
>> I just left CONFIG_PPC_EARLY_DEBUG_CPM_ADDR at the default value for CPM2?
>> Is that likely to be correct for SMC1?  (I tried looking in the MPC8272
>> reference manual, but couldn't find it.)
>
> The value depends on how the port was set up by firmware (or by the
> bootwrapper).  It should be set to wherever the descriptor is, and there
> should only be one descriptor that loops back on itself.

Hi Scott,

Thanks so much for your help so far.  I was able to find out this address 
from the bootloader and get some output on the early debug console which 
was very pleasing.  It now gets as far as console_init() called from 
init/main.c, which completes but then any printk seems to stall it and 
you get no more output.

I am using SMC1 and have this in the DTS file for the linux,stdout-path:

serial@11a80 {
 	device_type = "serial";
 	compatible = "fsl,mpc8247-smc-uart",
 	            "fsl,cpm2-smc-uart";
 	reg = <0x11a80 0x20 0x87fc 2>;
 	interrupts = <4 8>;
 	interrupt-parent = <&PIC>;
 	fsl,cpm-brg = <7>;
 	fsl,cpm-command = <0x1d000000>;
};

Any ideas what sorts of things I should check next?

Cheers,

Chris.
