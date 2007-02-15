Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42099DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 01:47:13 +1100 (EST)
In-Reply-To: <20070215033328.GA17554@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
	<20070215015316.GL16279@localhost.localdomain>
	<889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
	<20070215033328.GA17554@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <1ee5d4de0a640650826224f832374a67@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 15:47:04 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Yes true; you can hang the UICs from somewhere under the
>> "soc" node or whatever you want.  You need some way to
>> distinguish separate identical devices though; you can't
>> do it by device unit since your devices don't have any
>> (they don't have a "reg" but only a "dcr-reg").  If you
>> would hang them in a DCR tree, you could use the plain
>> "reg" property instead of the "dcr-reg" property and
>> all would be fine (if the DCR binding allows this -- and
>> it better should, it is the standard OF addressing algorithm).
>
> No, doesn't work.  The trouble is there are other devices that *do*
> sit on the normal MMIO bus, but also have DCRs (MAL, POB, SDRAM
> controller).  The DCR tree has to cut across the normal bus tree, like
> the interrupt tree.

Yes, and they can use "dcr-reg" properties just fine; compare
to how "interrupt-parent" works: nodes that can use the normal
tree rules don't need it, everything else does.

>> However, my main point remains: the two interrupt controllers
>> should be siblings in the device tree, since they are that on
>> the hardware.
>
> In what way are they "that on the hardware".  They're siblings on the
> DCR tree, they're parent/child on the interrupt tree.  Given that
> they're not on the MMIO tree at all, I see no strong reason to pick
> one representation over another.

It's not about MMIO; it's about addressability.  On many systems
almost none of the I/O subsystems primary address (config space
for PCI!) is on MMIO.

Quoting from OF1275:

> The device tree=92s structure mimics the organization of the system=20
> hardware, viewed as a hierarchy of interconnected buses and their=20
> attached devices.

The interrupt cascade is not a bus.

> I picked the interrupt tree, because
> it seemed to make as much or more logical sense as the other,

Yeah I know.

> and as a
> bonus it makes the probing logic easier.

How so?  There already is completely generic probing
code for interrupt controllers AFAIK.


Segher
