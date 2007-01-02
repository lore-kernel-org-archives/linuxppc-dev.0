Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4516CDDEB6
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 04:16:45 +1100 (EST)
In-Reply-To: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <535725c5c6010b6283b0ed0826dd469d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
Date: Tue, 2 Jan 2007 18:16:01 +0100
To: Simon Vallet <linux-ppc@castalie.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> unknown ADD relocation: 5
>
> which refers to R_PPC_ADDR16_HI relocations. The error message comes
> from apply_relocate_add() in arch/powerpc/kernel/module_32.c, which
> deals with R_PPC_ADDR16_LO and R_PPC_ADDR16_HA relocs, but not
> R_PPC_ADDR16_HI ones.
>
> Is there a reason for this ? Those relocs directly come from the
> mapping of PPC_RELOC_HI16 in the original driver, and i'd rather not
> transpose them into R_PPC_ADDR16_HA.

Well you normally never end up with an add with an @h -- you're
typically adding it to something that is loaded with "li", i.e.,
something that's the sign-extended version of the low 16 bits of
the 32-bit thing you're loading totally.

I'm interested how (and why :-) ) Darwin ends up doing it; could
you send me the (original) file in question?  Or an otool -tvV
of it, or part thereof that shows the problem.


Segher
