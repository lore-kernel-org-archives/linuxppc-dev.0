Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 390EBDE1E4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 05:20:46 +1100 (EST)
Message-ID: <47E2AADD.6090101@freescale.com>
Date: Thu, 20 Mar 2008 13:20:13 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: James Black <jblack547@gmail.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>	
	<20080319174001.GF7962@ld0162-tx32.am.freescale.net>	
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
In-Reply-To: <b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
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

James Black wrote:
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Unable to handle kernel paging request for data at address 0xe001a000
> Faulting instruction address: 0xc00e1a6c

What function is 0xc00e1a6c in?

Is it possible that you have an SMC device initialized by your firmware 
that is corrupting parameter RAM?

> muram@0 {
>    #address-cells = <1>;
>    #size-cells = <1>;
>    ranges = <0 0 10000>;
> 
>    data@0 {
>       compatible = "fsl,cpm-muram-data";
>       reg = <0 4000 8000 1000 B000 1000>;

You can't use all of 0x8000-0x8fff; there is device parameter RAM in 
there.  If you can figure out the portions that aren't in use, you can 
use those, but I wouldn't bother unless you really need the extra muram.

-Scott
