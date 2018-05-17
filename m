Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mv7Z1lW9zF1y4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 00:38:49 +1000 (AEST)
Date: Thu, 17 May 2018 09:38:10 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Shile Zhang <shile.zhang@nokia.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "powerpc/64: Fix checksum folding in csum_add()"
Message-ID: <20180517143810.GV17342@gate.crashing.org>
References: <20180410063437.217D2653BC@po15720vm.idsi0.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410063437.217D2653BC@po15720vm.idsi0.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2018 at 08:34:37AM +0200, Christophe Leroy wrote:
> This reverts commit 6ad966d7303b70165228dba1ee8da1a05c10eefe.
> 
> That commit was pointless, because csum_add() sums two 32 bits
> values, so the sum is 0x1fffffffe at the maximum.
> And then when adding upper part (1) and lower part (0xfffffffe),
> the result is 0xffffffff which doesn't carry.
> Any lower value will not carry either.
> 
> And behind the fact that this commit is useless, it also kills the
> whole purpose of having an arch specific inline csum_add()
> because the resulting code gets even worse than what is obtained
> with the generic implementation of csum_add()

:-)

> And the reverted implementation for PPC64 gives:
> 
> 0000000000000240 <.csum_add>:
>  240:	7c 84 1a 14 	add     r4,r4,r3
>  244:	78 80 00 22 	rldicl  r0,r4,32,32
>  248:	7c 80 22 14 	add     r4,r0,r4
>  24c:	78 83 00 20 	clrldi  r3,r4,32
>  250:	4e 80 00 20 	blr

If you really, really, *really* want to optimise this you could
make it:

	rldimi r3,r3,0,32
	rldimi r4,r4,0,32
	add r3,r3,r4
	srdi r3,r3,32
	blr

which is the same size, but has a shorter critical path length.  Very
analogous to how you fold 64->32.


Segher
