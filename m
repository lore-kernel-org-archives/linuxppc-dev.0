Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DA40DDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:32:12 +1000 (EST)
Message-ID: <46F2BC7D.3070908@freescale.com>
Date: Thu, 20 Sep 2007 13:31:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: device tree question
References: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>	
	<46F04BCE.8060007@freescale.com>	
	<bfa0697f0709181521r62c81b55q65cd49d4e4ba3637@mail.gmail.com>	
	<46F052EE.1040004@freescale.com>	
	<bfa0697f0709181604i5758824foad67a86455f45d8e@mail.gmail.com>	
	<46F05BF7.6020906@freescale.com>	
	<bfa0697f0709190638r6894fab6gd31a5672a997e97@mail.gmail.com>	
	<46F16BD4.2000207@freescale.com>	
	<bfa0697f0709191420x5a6aed9dx499fe4a8cf6b1b2d@mail.gmail.com>	
	<46F19326.7050507@freescale.com>
	<bfa0697f0709201053s3643523eid42ea60dae53af84@mail.gmail.com>
In-Reply-To: <bfa0697f0709201053s3643523eid42ea60dae53af84@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
> Ok, making progress on the ep8248 / devtrees, etc...
> 
> But I'm not getting any output on the serial and my log_buf is pretty 
> clean.  Without console; what's the best way to figure out why I'm not 
> getting any output on my SMC1 serial port (using u-boot , not planetcore)?

U-boot locates the SMC1 registers in a different place than planetcore; 
SMC1's reg property should be <11a80 20 0 40>, and the cpm's reg 
property should be <119c0 30 80 1f80>.

>         CS: chipselect {
>                 compatible = "fsl,ep8248e-chipselect",
>                              "fsl,mpc8248-chipselect",
>                              "fsl,pq2-chipselect";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                 fsl,ctrl = <&CSCTRL>;

This has changed, and I haven't yet updated ep8248e.  The above should be:

localbus@f0010100 {
	compatible = "fsl,mpc8248-localbus",
	             "fsl,pq2-localbus";
	#address-cells = <2>;
	#size-cells = <1>;
	reg = <f0010100 40>;

You'll also need to update the bus probe matches in ep8248e.c.

>                 ranges = <0 0 f8000000 07f00000
>                           0 1 fff00000 00080000
>                           0 2 fff80000 00080000

This is wrong; the first cell is the chipselect, and the second cell is 
the offset in bytes.  I rather doubt the second flash begins at byte 1 
and the third at byte 2. :-)

>                           1 0 e4000000 00008000
>                           2 0 d0000000 08000000>;

> /*  F800_0000 -> FFF0_0000  */
>                 flash@0,0 {
>                         compatible = "cfi-flash";
>                         reg = <0 0 7F00000>;
>                         probe-type = "CFI";
>                         bank-width = <4>;
>                 };

This is a mix of the new and old flash bindings (again, I haven't yet 
updated ep8248e).  Look at the other dts files such as mpc8272ads and 
ep88xc for assistance.

> /*  F400_0000  */
>                 bcsr@1,0 {

It says e4000000 in ranges...

>                         #address-cells = <2>;
>                         #size-cells = <1>;
>                         reg = <1 0 10>;
>                         compatible = "fsl,ep8248e-bcsr";
>                         ranges;
> 
>                         mdio {
>                                 device_type = "mdio";
>                                 compatible = "fsl,ep8248e-mdio-bitbang";
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>                                 reg = <1 8 1>;
> 
>                                 PHY0: ethernet-phy@0 {
>                                         interrupt-parent = <&PIC>;
>                                         reg = <0>;
>                                         device_type = "ethernet-phy";
>                                 };
> 
>                                 PHY1: ethernet-phy@1 {
>                                         interrupt-parent = <&PIC>;
>                                         reg = <1>;
>                                         device_type = "ethernet-phy";
>                                 };
>                         };
>                 };
> /*  D000_0000 -> D7FF_FFFF  */
>                 flash@2,0 {
>                         compatible = "cfi-flash";
>                         reg = <0 0 08000000>;

reg should be <2 0, not <0 0.

>         soc@f0000000 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 device_type = "soc";
>                 compatible = "fsl,mpc8248", "fsl,pq2-soc";
>                 ranges = <00000000 f0000000 00053000>;

You need a reg property here until the kernel uses ranges; see the 
mpc8272ads dts in my tree.

>                 CSCTRL: chipselect {
>                         compatible = "fsl,mpc8248-chipselect-ctrl",
>                                      "fsl,pq2-chipselect-ctrl";
>                         reg = <10100 40>;
>                         fsl,bus = <&CS>;
>                 };

This can go away.

-Scott
