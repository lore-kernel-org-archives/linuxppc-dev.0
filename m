Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 325B8DDE47
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 04:58:16 +1000 (EST)
In-Reply-To: <1180720112.14219.62.camel@ld0161-tx32>
References: <1180720112.14219.62.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Fri, 1 Jun 2007 20:58:02 +0200
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		ranges = <00000000 f8000000 00100000
> +			  80000000 80000000 20000000
> +			  e2000000 e2000000 00100000
> +			  a0000000 a0000000 20000000
> +			  e3000000 e3000000 00100000>;
>  		reg = <f8000000 00100000>;	// CCSRBAR 1M


"reg" included in "ranges"?  Something is wrong here.

> +				pci_bridge@0 {

> +					#size-cells = <2>;
> +					#address-cells = <3>;
> +					ranges = <02000000 0 80000000
> +						  02000000 0 80000000
> +						  0 20000000
> +						  01000000 0 00000000
> +						  01000000 0 00000000
> +						  0 00100000>;
> +
> +					isa@1e {
> +						#size-cells = <1>;
> +						#address-cells = <2>;
>
> +						ranges = <1 0 01000000 0 0
> +							  00001000>;

You map the same range (4kB legacy I/O @ 0) for both
bridges here.

> +						i8042@60 {
> +							reg = <1 60 1 1 64 1>;

And this address space is included in both of those.

> +							keyboard@0 {
> +								compatible = "pnpPNP,303";
> +							};
> +
> +							mouse@1 {
> +								compatible = "pnpPNP,f03";
> +							};

These need a "reg" property.

> +						rtc@70 {
> +							compatible =
> +								"pnpPNP,b00";
> +							reg = <1 70 2>;
> +						};
> +
> +						gpio@400 {
> +							reg = <1 400 80>;
> +						};

Inclusive again.

> +						i8259: i8259@4d0 {

Needs "reg".  And 4d0 isn't the primary address
I think?


Segher
