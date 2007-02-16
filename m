Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 353F3DDDCF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 20:23:09 +1100 (EST)
In-Reply-To: <1171572229.5644.13.camel@localhost.localdomain>
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
	<be63e9b080539aa34a9e44aa8efaa60e@kernel.crashing.org>
	<1171572229.5644.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a7473577f846bd7bcb2d696decef7efd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Fri, 16 Feb 2007 10:23:02 +0100
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

>> Of course, I know that.  What I'm saying is that devices
>> where the *only* connection to the system is the DCR ring,
>> should use normal "reg" properties instead of "dcr-reg"
>> properties (and normal parent instead of "dcr-parent") to
>> describe the DCR registers, so that they get a valid unit
>> address.
>
> So you say that we shold have 2 different ways to encode a DCR mapping 
> ?
> Nah ....

If you don't, and you have two identical devices sitting
on the same DCR bus (but not on an MMIO bus), you have
no way to distinguish them.  Oops.  You might not like it
but that's the DCR's fault, not mine :-)


Segher
