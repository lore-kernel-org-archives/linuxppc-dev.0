Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0DE9B7CBB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 05:39:11 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0KId8S0007540
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 11:39:08 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o0KIdBXk004458
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 12:39:11 -0600 (CST)
Message-ID: <4B574DCB.40304@freescale.com>
Date: Wed, 20 Jan 2010 12:39:07 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: fsl upm NAND Flash issue without GPIO chip handler
References: <1263921085.S.3173.3591.f5mail-147-110.rediffmail.com.old.1264011068.46402@webmail.rediffmail.com>
In-Reply-To: <1263921085.S.3173.3591.f5mail-147-110.rediffmail.com.old.1264011068.46402@webmail.rediffmail.com>
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
> my response inlined..
> 
> On Tue, 19 Jan 2010 22:41:25 +0530 wrote
>  >nanda wrote:
>  >
>  > We had merged the 2.6.24
> 
> That's pretty old...
>  >> We were using 2.6.24 as this kernel version this is the references 
> used by us for MPC8321E.
>  > with the FSL based NAND driver,
> 
> Which one? Which chip are you using, and how is NAND attached to it?
>  >> MPC8321E processor connected to STM NAND Flash. Port C PIN 15 of the 
> processor connected to the R/B# ( Ready/Busy PIN) of the STM NAND Flash.

And the other pins are connected to the local bus controller via UPM?

This is supported in the upstream kernel by drivers/mtd/nand/fsl_upm.c, 
if there's nothing else keeping you on the BSP kernel.

>  > we observed that gpio library is mandatory to be included. We have 
> not included the
>  > gpios configured in the dts file as the we don’t have the separate GPIO
>  > chip(arch/powepc/boot/dts/board.dts).
> 
> What separate GPIO chip? Which "board.dts" are you looking at?
>  >> dts file I was refering is mpc832x_rdb.dts file, which we assumed 
> that GPIO controller is not required. ( Correct me if my assumption is 
> correct)

The only gpio controller in that dts file is the SoC's GPIO block (not a 
separate "GPIO chip").  Specifically, it's port D; you'll want to add a 
node for port C.

>  > After executing the image in the board, we observed the below
>  > 1) The device ID and manufacture Id was printed as "c0" and "c0" and the
>  > error message "No NAND device found!!!". Does it mean it is not
>  > accessing the NAND flash and the values read are junk one?
>  > 2) Processor of the board doesn’t connect the Ready/Busy of the NAND
>  > flash through the separate GPIO chip. I mean it is directly connected
>  > from GPIO Port C of PIN 15 to the Ready/Busy PIN of the NAND flash.
>  > Hence is it necessary to port the gpio specific functions like
>  > gpio_request/gpio_free(specified in fsl_upm.c file), instead should we
>  > need to configure the PIN par_io_config_pin() for configuration of the
>  > PORT C with 15th PIN and set the data value using par_io_data_set()
>  > (specified arch/powerpc/sysdev/qe_lib/qe_io.c)
> 
> Have you tried pointing the "gpios" property at pin 15 of port C? The
> whole point of this abstraction is that these connections are described
> in the data, not in the code.
>  >> Iam not sure how to specify the in the mpc832x_rdb.dts for the pin 
> 15 port C of the MPc8321E processor.

It should look like port B/E in the 836x_rdk dts, except you want reg to 
point at the port C registers.

For details, see the following binding documents: 
Documentation/powerpc/dts-bindings/gpio/gpio.txt
Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt
Documentation/powerpc/dts-bindings/fsl/upm-nand.txt

-Scott
