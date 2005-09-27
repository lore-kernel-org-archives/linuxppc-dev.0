Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8294F683E3
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Oct 2005 04:48:13 +1000 (EST)
In-Reply-To: <96e9df75a769d22905026438cb4c5131@penguinppc.org>
References: <Pine.LNX.4.61.0509250043410.19178@scrub.home>
	<96e9df75a769d22905026438cb4c5131@penguinppc.org>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <622be433ce70c3eb43d3dca513c1462e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 27 Sep 2005 20:22:16 +0200
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/8] ppc: use correct asm ops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't see where this is explained in the GCC docs,

It is documented in gcc/gcc/config/rs6000/rs6000.c,
function print_operand() ;-)

> but as I understand it those %U %X things are allowing somebody to use 
> the "update" and "index" variants of the instruction.

Indeed.

> Why doesn't this work for you?

The code works fine.  The U and X have no effect at all,
though; they require a memory operand to do anything,
and __do_in_asm() c.q. __do_out_asm() take a register
input.  It would be better if __do_in_asm() would say

	"m" (*(port + ___IO_BASE))

where it now says

	"r" (port + ___IO_BASE)

and keep the %U %X stuff (and similarly for __do_out_asm()
of course).


Segher
