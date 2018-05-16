Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mVXx4G1hzDr3y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 09:10:57 +1000 (AEST)
Date: Thu, 17 May 2018 09:10:52 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Shile Zhang <shile.zhang@nokia.com>
Subject: Re: [PATCH] Revert "powerpc/64: Fix checksum folding in csum_add()"
Message-ID: <20180516231052.GA24778@fergus.ozlabs.ibm.com>
References: <20180410063437.217D2653BC@po15720vm.idsi0.si.c-s.fr>
MIME-Version: 1.0
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
> 
> 0000000000000240 <.csum_add>:
>  240:	38 00 ff ff 	li      r0,-1
>  244:	7c 84 1a 14 	add     r4,r4,r3
>  248:	78 00 00 20 	clrldi  r0,r0,32
>  24c:	78 89 00 22 	rldicl  r9,r4,32,32
>  250:	7c 80 00 38 	and     r0,r4,r0
>  254:	7c 09 02 14 	add     r0,r9,r0
>  258:	78 09 00 22 	rldicl  r9,r0,32,32
>  25c:	7c 00 4a 14 	add     r0,r0,r9
>  260:	78 03 00 20 	clrldi  r3,r0,32
>  264:	4e 80 00 20 	blr
> 
> In comparison, the generic implementation of csum_add() gives:
> 
> 0000000000000290 <.csum_add>:
>  290:	7c 63 22 14 	add     r3,r3,r4
>  294:	7f 83 20 40 	cmplw   cr7,r3,r4
>  298:	7c 10 10 26 	mfocrf  r0,1
>  29c:	54 00 ef fe 	rlwinm  r0,r0,29,31,31
>  2a0:	7c 60 1a 14 	add     r3,r0,r3
>  2a4:	78 63 00 20 	clrldi  r3,r3,32
>  2a8:	4e 80 00 20 	blr
> 
> And the reverted implementation for PPC64 gives:
> 
> 0000000000000240 <.csum_add>:
>  240:	7c 84 1a 14 	add     r4,r4,r3
>  244:	78 80 00 22 	rldicl  r0,r4,32,32
>  248:	7c 80 22 14 	add     r4,r0,r4
>  24c:	78 83 00 20 	clrldi  r3,r4,32
>  250:	4e 80 00 20 	blr
> 
> Fixes: 6ad966d7303b7 ("powerpc/64: Fix checksum folding in csum_add()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Seems I was right first time... :)

Acked-by: Paul Mackerras <paulus@ozlabs.org>
