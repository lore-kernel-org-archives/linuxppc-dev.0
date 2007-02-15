Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2943EDDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 01:52:45 +1100 (EST)
In-Reply-To: <1171536722.5644.6.camel@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
	<20070215015316.GL16279@localhost.localdomain>
	<889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
	<1171536722.5644.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <be63e9b080539aa34a9e44aa8efaa60e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 15:52:38 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> No, the DCR tree, like the interrupt tree in most cases, is
>>> independent of the main tree structure.
>>
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
> It's not as DCRs are orthogonal to the normal bus tree (yeah, it sucks
> but that's how it is, broken by design :-)

Of course, I know that.  What I'm saying is that devices
where the *only* connection to the system is the DCR ring,
should use normal "reg" properties instead of "dcr-reg"
properties (and normal parent instead of "dcr-parent") to
describe the DCR registers, so that they get a valid unit
address.


Segher
