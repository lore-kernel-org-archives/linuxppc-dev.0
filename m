Return-Path: <MichaelGalea@ruggedcom.com>
Received: from rcserver3.ruggedcom.local (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 0B508DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 06:41:02 +1000 (EST)
Message-ID: <485189DC.3030806@ruggedcom.com>
Date: Thu, 12 Jun 2008 16:41:00 -0400
From: Michael Galea <michaelgalea@ruggedcom.com>
MIME-Version: 1.0
To: Mike Timmons <mike_timmons@trimble.com>
Subject: Re: Question on assigning interrupts in a dts
References: <48512EB9.3080307@ruggedcom.com>
	<161B3BAD77161449A144FF054231C3D6022FDF8A@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <161B3BAD77161449A144FF054231C3D6022FDF8A@uss-am-xch-01.am.trimblecorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Mike Timmons wrote:
> Michael,
> I'm familiar with the powerpc 5200 scheme. Under Documents there is a
> mpc52xx-device-tree-bindings.txt. In the section titled, "Interrupt
> mapping" there is a description of the interrupt values in the dts.
> 
> I'm not too familiar with the 8360. The 5200 has different "categories"
> (main, crit, perph, and SDMA) of interupts and then numbers within each
> category. To support this the 52xx DTS uses a triplet to represent
> interrupts in the dts: <L1 L2 L3>.
> 
> Taking a quick look at the MPC8360E PowerQUICC II reference manual (Rev
> 2) I can at least map some of the fields in mpc836x_mds.dts to valuel in
> the datasheet (The IPIC looks a little flat compared to the pic in the
> 5200 so it looks like this is why you don't need the triplet format).
> 
> For example, the i2c on-chip peripherals in the dts (i2c@3000 and
> i2c@3100) specify interrupts=<e 8> and <f 8>, respectively. The 'e' and
> the 'f' agree with the interrupt ID numbers associated with these I2C
> peripherals on page 8-10 of the reference manual.
> 
> The '8' could be some sort of interrupt 'level' spec for the devices
> that rely on the ipic (note that most of the devices that rely on ipic
> as the interrupt-parent specify the '8' after the interrupt ID number).
> 
> So, I think we're close to understanding how to specify interrupts under
> ipic (so long as you figure out what 8 means), but I don't think it
> directly addresses your question. As for your device snippet below,
> those look like devices on the QUICC Engine port. In the Reference
> manual I do see this at ipic interrupt ID 32 and 33 which agrees.
> 
> It looks like the qeic is an interrupt controller beneath the ipic
> controller: below you specify qeic as an interrupt controller and assign
> the ipic interrupt ids to it (again, I see 32 and 33 in the reference
> manual).
> 
> In your dts, do you have devices that specify interrupt-parent=<&qeic>?
> I see a few of them in mpc836x_mds.dts. In turn, these devices indicate
> only a single value for "interrupts" (interrupts=<21>, for example).
> 
> I think this must be the bit position for whatever QUICC interrupt port
> is associated with the device. Look around in section 8.5 of the
> reference manual and see if you can make sense of it.
> 
> I decoded the device tree syntax by finding drivers for devices in the
> tree, refering to the reference manual(s), and identifying how the
> device tree mapped to the chip. Although I'm not well versed on the
> 8360, just the few minutes I spent above got me pretty close to making
> sense of the syntax below. Dig in this direction and it will become
> clear.
> 
> -Mike

Thanks Mike,

I'm beginning to grok it now.
Where the interrupt parent is the IPIC, the interrupt property specifies 
the Interrupt ID (from pg 8-10) and that interrupts level/sense 
information (which matches defines in <linux/irq.h>).
Where the interrupt parent is the QE interrupt controller (i.e. UCCs and 
spi) the number is the QEIC interrupt number (pg 19-21).
And the QE interrupt controller itself is a client of the IPIC that can 
generate both a HIGH (32) and LOW (33) Interrupt_ID to the IPIC.

This is good, as my real question was "what interrupt do I use for UCCs 
5,6 and 7.  And now I know..

And thanks to Scott as well, who pointed out the difference between IPIC 
interrupt IDs and QE interrupt numbers.

> 
> 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+mike_timmons=trimble.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+mike_timmons=trimble.com@ozlabs.org]
> On Behalf Of Michael Galea
> Sent: Thursday, June 12, 2008 9:12 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Question on assigning interrupts in a dts
> 
> Hi All,
>      I'm building a dts for a custom 8360 based board.  I'm looking at 
> the mpc8360_mds and mpc8360_rdk dts files, trying to figure out how the 
> UCCs (and all peripherals in general) got the values of their 
> "interrupts" properties chosen.  And is there any relationship between 
> the choice of interrupts for ucc1 and the qeic controller..  Can anyone 
> point me some docs for this?
> 
>              enet0: ucc@2000 {
>                  device_type = "network";
>                  compatible = "ucc_geth";
>                  cell-index = <1>;
>                  reg = <0x2000 0x200>;
>                  interrupts = <32>;
>          ..
>              };
> 
>               enet1: ucc@3000 {
>                  device_type = "network";
>                  compatible = "ucc_geth";
>                  cell-index = <2>;
>                  reg = <0x3000 0x200>;
>                  interrupts = <33>;
>          ..
>              };
> 
>              qeic: interrupt-controller@80 {
>                  #address-cells = <0>;
>                  #interrupt-cells = <1>;
>                  compatible = "fsl,qe-ic";
>                  interrupt-controller;
>                  reg = <0x80 0x80>;
>                  big-endian;
>                  interrupts = <32 8 33 8>;
>                  interrupt-parent = <&ipic>;
>              };
> 
> Thanks
> 


-- 
Michael Galea
30 Whitmore Road
Woodbridge, Ontario, Canada, L4L 7Z4
Ph: (905) 266-1745
Fx: (905) 856-1995
www.ruggedcom.com

NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged 
information. If you are not the intended recipient, please notify the 
sender immediately by return e-mail and delete this e-mail and any 
copies. Any dissemination or use of this information by a person other 
than the intended recipient is unauthorized and may be illegal.
