Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6065BDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:37:09 +1000 (EST)
Message-ID: <46F052EE.1040004@freescale.com>
Date: Tue, 18 Sep 2007 17:36:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <alan@akb.net>
Subject: Re: device tree question
References: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>	
	<46F04BCE.8060007@freescale.com>
	<bfa0697f0709181521r62c81b55q65cd49d4e4ba3637@mail.gmail.com>
In-Reply-To: <bfa0697f0709181521r62c81b55q65cd49d4e4ba3637@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
> I finally saw some light, though not much, and have made several
> changes to a new dts file.
> 
> BTW: I've lost my __log_buf
>   was 02aec04 now it's not there, nor is it Load Address: 0x00400000 +  02aec04

You can't rely on that sort of thing staying at the same address... 
check System.map to see where it is now.

> BRx/ORx=CSx
> 128MB flash: CS0 = F800_0000 f800_0000
> 128MB flash: CS4 = D000_0000 f800_0000
> 128MB SDRAM: CS1 = 0000_0000 f800_0000

Below, you seem to be assuming flash is CS0 and CS3, and that CS1 is BCSR.

> / {
> 	model = "MPC8248";
> 	compatible = "fsl,mpc8248";

Model/compatible should be for the board, not the chip.

> 		board-control@1,0 {
> 			reg = <1 0 20>;
> 			compatible = "fsl,mpc8248-bcsr";
> 		};

BCSR is board-specific, not chip-specific.  The compatible should 
reference the specific board's name (with the board vendor replacing fsl).

> 		flash2@3,0 {

The unit address provides uniqueness; just do "flash@3,0".

> 			compatible = "jedec-flash";

Note that this should be cfi-flash if your flash is CFI-compatible.

> 			reg = <0 0 8000000>;
> 			bank-width = <1>;
> 			device-width = <32>;

These are specified in bytes, not bits or chips.
I'm guessing you should set them both to 4 based on the above.

> 		};
> 		dualportram@1,0 {

Should be dualportram@5,0

> 			reg = <5 0 100000>;
> 			compatible = "fsl,mpc8248-dualportram";
> 		};
> 		dualportcsr@1,0 {

Should be dualportcsr@6,0

> 	soc@f0000000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		device_type = "soc";
> 		compatible = "fsl,mpc8272", "fsl,pq2-soc";

The 8272 references should be 8248, though it doesn't currently matt

> 			serial@11a82 {
> 				device_type = "serial";
> 				compatible = "fsl,mpc8272-smc-uart",
> 				             "fsl,cpm2-smc-uart";
> 				reg = <11a82 20 8300 100>;
> 				interrupts = <2b 8>;
> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <4>;
> 				fsl,cpm-command = <0ce00000>;

This doesn't look right...
You'll need to update reg, interrupts, and fsl,cpm-command for whichever 
SMC port you're using.

This is for SMC1 on the ep8248e:
	serial@11a80 {
		device_type = "serial";
		compatible = "fsl,mpc8248-smc-uart",
		             "fsl,cpm2-smc-uart";
		reg = <11a80 20 1100 40>;
		interrupts = <4 8>;
		interrupt-parent = <&PIC>;
		fsl,cpm-brg = <7>;
		fsl,cpm-command = <1d000000>;
	};

Note that the 1100 in reg should be set to wherever your firmware 
locates the SMC's parameter RAM block, and fsl,cpm-brg should be set to 
whichever BRG your firmware and/or platform code set the SMC port to.

> 			mdio@10d40 {
> 				device_type = "mdio";
> 				compatible = "fsl,mpc8272ads-mdio-bitbang",
> 				             "fsl,mpc8272-mdio-bitbang",
> 				             "fsl,cpm2-mdio-bitbang";
> 				reg = <10d40 14>;
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				fsl,mdio-pin = <12>;
> 				fsl,mdc-pin = <13>;

Does your board do mdio the same way as the mpc8272ads board?  if not, 
you'll have to change this.

-Scott
