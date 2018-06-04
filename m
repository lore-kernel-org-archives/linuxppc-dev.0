Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfc6MYJzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:32 +1000 (AEST)
In-Reply-To: <20180410063435.272F8653BC@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/64: optimises from64to32()
Message-Id: <40zxfc4bqmz9s2t@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 06:34:35 UTC, Christophe Leroy wrote:
> The current implementation of from64to32() gives a poor result:
> 
> 0000000000000270 <.from64to32>:
>  270:	38 00 ff ff 	li      r0,-1
>  274:	78 69 00 22 	rldicl  r9,r3,32,32
>  278:	78 00 00 20 	clrldi  r0,r0,32
>  27c:	7c 60 00 38 	and     r0,r3,r0
>  280:	7c 09 02 14 	add     r0,r9,r0
>  284:	78 09 00 22 	rldicl  r9,r0,32,32
>  288:	7c 00 4a 14 	add     r0,r0,r9
>  28c:	78 03 00 20 	clrldi  r3,r0,32
>  290:	4e 80 00 20 	blr
> 
> This patch modifies from64to32() to operate in the same
> spirit as csum_fold()
> 
> It swaps the two 32-bit halves of sum then it adds it with the
> unswapped sum. If there is a carry from adding the two 32-bit halves,
> it will carry from the lower half into the upper half, giving us the
> correct sum in the upper half.
> 
> The resulting code is:
> 
> 0000000000000260 <.from64to32>:
>  260:	78 60 00 02 	rotldi  r0,r3,32
>  264:	7c 60 1a 14 	add     r3,r0,r3
>  268:	78 63 00 22 	rldicl  r3,r3,32,32
>  26c:	4e 80 00 20 	blr
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/55a0edf083022e402042255a0afb03

cheers
