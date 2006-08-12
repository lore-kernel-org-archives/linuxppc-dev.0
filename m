Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B34767B62
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 11:53:57 +1000 (EST)
Subject: Re: [RFC] Adding MTD to device tree
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200608112310.41110.arnd@arndb.de>
References: <20060614213643.137680b8@vitb.ru.mvista.com>
	<20060709001435.7a94294e@localhost.localdomain>
	<44DCA2BF.1030002@ru.mvista.com>  <200608112310.41110.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 20:53:21 -0500
Message-Id: <1155347601.3108.7.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-11 at 23:10 +0200, Arnd Bergmann wrote:
> On Friday 11 August 2006 17:31, Sergei Shtylyov wrote:
> > +   h) MTD nodes
> > +
> > +   Memory Technology Devices are flash, ROM, and similar chips, often used
> > +   for solid state file systems on embedded devices.
> > +
> > +   Required properties:
> > +
> > +    - device_type : has to be "mtd"
> > +    - compatible : Should be the name of the MTD driver. Currently, this is
> > +      most likely to be "physmap".
> > +    - reg : Offset and length of the register set for the device.
> 
> I would prefer to call them something different in the device tree.
> The name 'mtd' is very specific to Linux, but the device tree
> is a more generic concept.

Agreed here.

> 
> I understand that the booting-without-of.txt file is by definition
> Linux specific as well, but we should be prepared for making parts
> of it a OS independent binding at the point where we put the same
> device nodes into actual OF implementations that able to boot
> different operating systems.
> 
> I would prefer a naming that has 
> 
>    Required properties:
>     - device_type : one of "nand-flash", "nor-flash", or "rom".

There are more than just those kinds of MTDs.  There's dataflash,
AG-AND, NVRAM, ioremappable DRAM, etc.  I'd prefer it to just be called
"flash".  See more below.

>     - model : an identifier for the actual controller chip used.

Meaning what exactly?  Lots of NOR flash doesn't have a "controller".

>     - compatible : Should be the name of the MTD driver. For
>       type "rom", this is most likely "physmap".

This I agree with, but Sergei already had this.  And since you're
specifying the name of the MTD driver, that typically already knows what
type of chip it's talking to.

For example, physmap will probe for CFI, JEDEC, and ROM devices already.
It can't do NAND flash, so you'd have to specify the name of a NAND
driver, such as ndfc.c and that only deals with NAND flash.

josh
