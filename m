Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2418FB7C8D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 04:15:42 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0JHFdWx017458
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 10:15:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o0JHFgms007811
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 11:15:43 -0600 (CST)
Message-ID: <4B55E82C.3060406@freescale.com>
Date: Tue, 19 Jan 2010 11:13:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: fsl upm NAND Flash issue without GPIO chip handler
References: <20100119124014.22519.qmail@f5mail-237-237.rediffmail.com>
In-Reply-To: <20100119124014.22519.qmail@f5mail-237-237.rediffmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

nanda wrote:
> 
> We had merged the 2.6.24 

That's pretty old...

> with the FSL based NAND driver,

Which one?  Which chip are you using, and how is NAND attached to it?

> we observed that gpio library is mandatory to be included. We have not included the 
> gpios configured in the dts file as the we don’t have the separate GPIO 
> chip(arch/powepc/boot/dts/board.dts).

What separate GPIO chip?  Which "board.dts" are you looking at?

> After executing the image in the board, we observed the below
> 1) The device ID and manufacture Id was printed as "c0" and "c0" and the 
> error message "No NAND device found!!!". Does it mean it is not 
> accessing the NAND flash and the values read are junk one?
> 2) Processor of the board doesn’t connect the Ready/Busy of the NAND 
> flash through the separate GPIO chip. I mean it is directly connected 
> from GPIO Port C of PIN 15 to the Ready/Busy PIN of the NAND flash. 
> Hence is it necessary to port the gpio specific functions like 
> gpio_request/gpio_free(specified in fsl_upm.c file), instead should we 
> need to configure the PIN par_io_config_pin() for configuration of the 
> PORT C with 15th PIN and set the data value using par_io_data_set() 
> (specified arch/powerpc/sysdev/qe_lib/qe_io.c)

Have you tried pointing the "gpios" property at pin 15 of port C?  The 
whole point of this abstraction is that these connections are described 
in the data, not in the code.

-Scott
