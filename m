Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C833ADDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:06:45 +1000 (EST)
Message-ID: <46F04BCE.8060007@freescale.com>
Date: Tue, 18 Sep 2007 17:06:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <alan@akb.net>
Subject: Re: device tree question
References: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>
In-Reply-To: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>
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
> I want to make the mpc8272ads.dts tree work for my board.
> 
> I have an mpc8248
>   128MB Flash@ f800_0000  (Spansion S29GL512N)
>   128MB Flash@ D000_0000  (Spansion S29GL512N)
>   BCSR@e400_0000
>   2nd CSR@e410_0000
>   RAM@e420_0000
>   128MB SDRAM@[0x0..0800_0000]

What chip selects are all of these things on, and what are the 
base/length of each chip select?

> 
> Is it ok to have 0 in these:
> 	cpus {
> 		PowerPC,8272@0 {
>          . . .
> 			timebase-frequency = <0>;
> 			bus-frequency = <0>;
> 			clock-frequency = <0>;
>         . . .

Yes, the bootwrapper will fill in the proper values.

> How do I modify the following lines to match my hardware?
> 
> 	localbus@f0010100 {
>       . . .
> 		ranges = <0 0 fe000000 02000000
> 		          1 0 f4500000 00008000
> 		          3 0 f8200000 00008000>;

Put your chip select mappings here.

> 		flash@0,0 {
> 			compatible = "jedec-flash";
> 			reg = <0 0 2000000>;
> 			bank-width = <4>;
> 			device-width = <1>;
> 		};
> 
> 		board-control@1,0 {
> 			reg = <1 0 20>;
> 			compatible = "fsl,mpc8272ads-bcsr";
> 		};

Put your chip select devices here.

-Scott
