Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5g26n3ZzDqlx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:39:10 +1000 (AEST)
In-Reply-To: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/3] powerpc: Avoid load hit store in __giveup_fpu() and
 __giveup_altivec()
Message-Id: <3rV5g23hWnz9t1f@ozlabs.org>
Date: Wed, 15 Jun 2016 22:39:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-29-05 at 12:03:50 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> In both __giveup_fpu() and __giveup_altivec() we make two modifications
> to tsk->thread.regs->msr. gcc decides to do a read/modify/write of
> each change, so we end up with a load hit store:
> 
>         ld      r9,264(r10)
>         rldicl  r9,r9,50,1
>         rotldi  r9,r9,14
>         std     r9,264(r10)
> ...
>         ld      r9,264(r10)
>         rldicl  r9,r9,40,1
>         rotldi  r9,r9,24
>         std     r9,264(r10)
> 
> Fix this by using a temporary.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8eb9803723a14fd12675641b95

cheers
