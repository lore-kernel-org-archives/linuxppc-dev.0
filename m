Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87260DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 14:09:21 +1100 (EST)
In-Reply-To: <20070215015316.GL16279@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
	<20070215015316.GL16279@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 04:09:15 +0100
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

>> Yes.  UIC1 is not addressed via UIC0, and as such should
>> not be a child of it; it should be a direct child of its DCR
>> controller, just like UIC0.
>
> No, the DCR tree, like the interrupt tree in most cases, is
> independent of the main tree structure.

Yes true; you can hang the UICs from somewhere under the
"soc" node or whatever you want.  You need some way to
distinguish separate identical devices though; you can't
do it by device unit since your devices don't have any
(they don't have a "reg" but only a "dcr-reg").  If you
would hang them in a DCR tree, you could use the plain
"reg" property instead of the "dcr-reg" property and
all would be fine (if the DCR binding allows this -- and
it better should, it is the standard OF addressing algorithm).

However, my main point remains: the two interrupt controllers
should be siblings in the device tree, since they are that on
the hardware.


Segher
