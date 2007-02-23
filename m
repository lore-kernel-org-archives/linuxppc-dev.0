Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67A5FDDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 08:31:02 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net><A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org><20070222011811.GA18364@localhost.localdomain><45b623f395654fc4f4920b9553794def@kernel.crashing.org><20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1fb51bd63da9a7de836f3037908be52e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 22:30:54 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I'd rather write it like
>>
>>>       interrupts        = < a 4   b 4   0 4   1 4   2 4 >
>>>       interrupt-parents = <&UIC0 &UIC0 &UIC1 &UIC1 &UIC1>
>>
>
> Segher, with your proposal here of an interrupt-parents property
> is this really keeping with the normal OF way of representing
> property values?
>
> Examples exists where one property tells you how to interpret
> or decode another (e.g. #address-cells), but your proposal we
> have two distinct properties each with values that together
> provide the complete 'value' (interrupt parent + interrupt
> specifier).  Is there any precedent for this approach?

"interrupt-parent" normally is a separate property already.
"My" way, you keep the original definition for "interrupts"
and the bleeding obvious definition for "interrupt-parents".

An example where two arrays with corresponding entries is
already used is "alternate-reg" in the PCI binding.  There
are literally hundreds of examples of non-array properties
that only make sense together, of course.

Both "alternate-reg" and "interrupt-parents" can be seen as
an optional extension to their corresponding array properties
("reg" and "interrupts" respectively) so it all makes perfect
sense (to me, at least ;-) ).


Segher
