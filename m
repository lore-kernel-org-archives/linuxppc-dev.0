Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3AC13DDF34
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 03:39:26 +1000 (EST)
Message-ID: <464DE4C7.7030906@freescale.com>
Date: Fri, 18 May 2007 12:39:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com>	<20070518005641.GA27350@localhost.localdomain>	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
In-Reply-To: <464DE2D3.3090805@smiths-aerospace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

>> I'd like to point out that what I originally proposed was much simpler
>> than this; 

Actually, we're talking about the same thing, but I guess my over-simplification back-fired.

> Aye, that looks useful and reasonable to me.  In one of my previous 
> spiels I talked about merging fragments of fdt blobs.  That was a 
> half-baked thought, the above dts (blob) would have all the fragments in 
> it and the u-boot board-specific logic would be copying/moving the 
> selected nodes.  That has a lot of benefits...

The idea stemmed from a desire to have a single DTS file for a given board, even in 
situations where jumpers changed what hardware was enabled.

> * The above should result in reasonable board-specific code.
>   * We may want to invent a libfdt move/copy subtree function (I don't
>       recall one being in there).  Board specific code would want to
>       move selected subtrees out of /u-boot,hwoptions into the
>       appropriate final node.  All the pieces are in libfdt, just would
>       need to be hooked together in a utility subroutine.

Just being able to delete a given node/property would be enough.  By default, the nodes 
with conditionals would be present in the device tree.  The boot loader would then also 
strip out all conditionals from the device tree before passing it to the kernel.  The 
kernel would then receive a standard device tree like it does today.

> * With the above, nothing in the infrastructure (dtc, libfdt) needs to
>     change.
> 
> On a related note, would it be better to name the node 
> "/u-boot/hwoptions" (two levels deep)?  It seems very desirable to me to 

It's not a u-boot-specific concept.  The idea of representing jumpers (and other hardware 
options) in the device tree is not something that's unique to u-boot or any boot loader. 
The conditionals, however, are a bootloader-specific concept.  We don't want Linux to see 
them.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
