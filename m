Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 115E9B7B76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 08:40:33 +1100 (EST)
Message-ID: <4AD6454C.60705@freescale.com>
Date: Wed, 14 Oct 2009 16:40:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Roberto Guerra <roberto.j.guerra@gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>	
	<20091009170433.GA17372@b07421-ec1.am.freescale.net>	
	<7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>	
	<20091009181617.GA14304@loki.buserror.net>
	<7c4144600910141434y26972dbbnb776c4ef89d15a17@mail.gmail.com>
In-Reply-To: <7c4144600910141434y26972dbbnb776c4ef89d15a17@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roberto Guerra wrote:
> I've been learning how to modify the dts from
> http://www.mjmwired.net/kernel/Documentation/powerpc/dts-bindings/mtd-physmap.txt#49
> The original mpc8272ads.dts represents four 8-bit JEDEC Sharp flash
> chips in 1 SIMM module:
> [snip]        localbus@f0010100 {
>                 compatible = "fsl,mpc8280-localbus",
>                              "fsl,pq2-localbus";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                 reg = <f0010100 60>;
> 
>                 ranges = <0 0 fe000000 00800000
>                           1 0 f4500000 00008000
>                           8 0 f8200000 00008000>;
> 
>                 flash@0,0 {
>                         compatible = "jedec-flash";
>                         reg = <0 0 800000>;
>                         bank-width = <4>;
>                         device-width = <1>;
>                 };
> [snip]
> My board (based on the PQ2FADS, using the MPC8272ADS BSP)

Don't base anything on the BSPs, unless there's something in them that you 
really need that isn't upstream.  There is pq2fads support in current upstream 
kernels.

> uses one
> 16-bit Spansion (AMD) CFI chip at addresses FF800000 through FFFFFFFF.
> It probably needs to be represented this way (I've only made changes
> to the "flash" section.
> [snip]
>                 flash@0,0 {
>                         compatible = "amd, s29jl064h", "cfi-flash";
>                         reg = <0 0 800000>;
>                         bank-width = <2>;
>                         device-width = <2>;
>                 };
> [snip]
> However, I don't know what would be the correct addresses to type
> after "localbus", "flash" and "reg". Is this enough information to
> define my dts?

The flash node looks good, other than that there shouldn't be a space after "amd,".

In the localbus node, change fe000000 to ff800000.  Remove or change the other 
ranges entries if they don't describe your board's chipselects.

If your IMMR is somewhere other than 0xf0000000, update the f0010100 to match.

-Scott
