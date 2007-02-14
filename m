Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACCBDDDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 04:59:06 +1100 (EST)
In-Reply-To: <1171470754.4003.101.camel@zod.rchland.ibm.com>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6206de08b7f12175bebe669291c66334@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 18:58:04 +0100
To: Josh Boyer <jwboyer@jdub.homelinux.org>
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

>> Did you mean to have UIC1 nested under UIC0 or should
>> they be at the same level?
>
> No, they are cascaded in hardware.  I think having UIC1 under UCI0 is a
> correct representation.

Only the interrupt routing is cascaded AFAICS, and
there is a separate interrupt tree to express that.

>> Hmm.  There are two "soc" devices here, one nested under the
>> first??
>>
>> I'm assuming these are two levels of busses the opb bus is attached
>> to the plb bus.  Is the "soc" device_type the right way to
>> do this?
>
> Right, OPB hangs off of PLB in this case.  I dunno if "soc" is the 
> right
> device type for them though.

I would use device_type "plb" (or "plb4") and "opb" I think.
Similar to how PCI and ISA etc. busses are represented.


Segher
