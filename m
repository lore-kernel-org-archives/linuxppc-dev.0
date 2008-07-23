Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 66E91DE15D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 03:13:35 +1000 (EST)
Date: Wed, 23 Jul 2008 13:13:35 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <richw@netcomuk.co.uk>
Subject: Re: DTS configuration of external interrupts on 8347
Message-ID: <20080723131335.00eadc6a@lappy.seanm.ca>
In-Reply-To: <4887471E.6070306@btconnect.com>
References: <4887471E.6070306@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, richard.whitlo@btconnect.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jul 2008 15:58:38 +0100
"Richard Whitlock" <richard.whitlo@btconnect.com> wrote:

> I have a small problem with a port of linux 2.6.26 to a custom board.
> Our board is almost identical to the Analogue & Micro asp 8347 board,
> so I'm using Kumar Gala's excellent fsl tree (thank you Kumar) as it 
> already has a defconfig for the asp.
> Thanks also to Bryan O'Donoghue for pointing us in the direction of
> the asp port in the first place.
> 
> The problem we have is I am unable to request an external interrupt.
> We have an FPGA which has an interrupt line - HW IRQ_0, so thats
> linux IRQ 48. I have added the following to the dts file:
> 
> fpgaKFAF@0xF8000000 {
>                 interrupts = <48 8>;
>                 interrupt-parent = <&ipic>;
> }
> 
> but whenever I call request_irq() it returns -ENOSYS.
> 
> The driver loads fine, and the open function does very little - a
> call to ioremap() - which works, and a call to request_irq() which
> does not. Is there anything else I have to do to configure this
> interrupt?

I don't think you have enough information in the dts. We do the same
thing on the warp (you can look at the warp.dts):

fpga@2,0 {
	compatible = "pika,fpga";
	reg = <0x00000002 0x00000000 0x00001000>;
	interrupts = <0x18 0x8>;
	interrupt-parent = <&UIC0>;
};

You need the compatible, maybe "kfaf,fpga", and I believe the reg entry
although you could try without it.

You then can use:

	of_find_compatible_node
	irq_of_parse_and_map
	request_irq

platforms/44x/warp.c shows an example using the ad7414. Just change the
ad7414 string to your compatible string.

Cheers,
   Sean
