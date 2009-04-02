Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32673DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 03:12:30 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n32GCAuW003313
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 09:12:21 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n32GC902009169
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 11:12:09 -0500 (CDT)
Date: Thu, 2 Apr 2009 11:12:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Sauce.Cheng" <chmhou@sina.com>
Subject: Re: issue at the beginning of kernel booting
Message-ID: <20090402161209.GA19088@ld0162-tx32.am.freescale.net>
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>
	<22840131.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22840131.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2009 at 08:23:42PM -0700, Sauce.Cheng wrote:
> > I don't see where you set up a BAT that covers 0xf0000000.
> 
> if i have to set up a BAT that cover 0xF0000000. i had a debug with LEDs
> like that in u-boot code. everything is //normal. 0xF00000000 is the value
> of CFG_IMMR(CONFIG_SYS_IMMR) that memory map register, it is the phy address
> and //base //address of all internal regishters, isnt? you mean that if i
> set BATs, i should not get the phy address like in the //front ?

I don't quite follow the above, but what I meant is that you need to
put a mapping in place that covers your LED I/O once you have the MMU on.

Any mappings that U-boot made will be gone at that point.

> i tried 
> CONFIG_PPC_EARLY_DEBUG_CPM=y 
> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xf00000008	
> how can i make sure CPM_ADDR, 0xf0000008 is default value 

Look at the u-boot source, or dump the memory and see if it looks like a
ring buffer.

> 		PowerPC,8272@0 {
> 			device_type = "cpu";
> 			reg = <0>;
> 			d-cache-line-size = <d#32>;
> 			i-cache-line-size = <d#32>;
> 			d-cache-size = <d#16384>;
> 			i-cache-size = <d#16384>;

This is a dts-v0 tree, which implies it's fairly old.

> 			brg@119f0 {
> 				compatible = "fsl,mpc8272-brg",
> 				             "fsl,cpm2-brg",
> 				             "fsl,cpm-brg";
> 				reg = <119f0 10 115f0 10>;
> 			};

Make sure that the clock-frequency property of the brg node is being set
by u-boot.  I should probably send a patch for that while the merge
window's still open...

> 			serial@11a82 {
> 				device_type = "serial";
> 				compatible = "fsl,mpc8272-smc-uart",
> 				             "fsl,cpm2-smc-uart";
> 				reg = <11a82 20 87FC 100>;

regs = <11a80 20 87fc 2>;

> 				interrupts = <28 8>;

interrupts = <4 8>;

> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <1>;
> 				fsl,cpm-command = <00800000>;

You need to update fsl,cpm-command; that is the SCC1 command word.
The SMC1 command is 0x1d000000 (see the ep8248e device tree).

Also make sure that the brg is correct.

-Scott
