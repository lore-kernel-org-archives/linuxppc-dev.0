Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxTn61pbZzDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 12:06:34 +1000 (AEST)
In-Reply-To: <1498484055-13783-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: viro@zeniv.linux.org.uk, Larry.Finger@lwfinger.net
Subject: Re: powerpc/32: Avoid miscompilation w/GCC 4.6.3 - don't inline
 copy_to/from_user()
Message-Id: <3wxTn60wrzz9s7f@ozlabs.org>
Date: Tue, 27 Jun 2017 12:06:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-06-26 at 13:34:15 UTC, Michael Ellerman wrote:
> Larry Finger reported that his Powerbook G4 was no longer booting with v4.12-rc,
> userspace was up but giving weird errors such as:
> 
>   udevd[64]: starting version 175
>   udevd[64]: Unable to receive ctrl message: Bad address.
>   modprobe: chdir(4.12-rc1): No such file or directory
> 
> He bisected the problem to commit 3448890c32c3 ("powerpc: get rid of zeroing,
> switch to RAW_COPY_USER").
> 
> Al identified that the problem is actually a miscompilation by GCC 4.6.3, which
> is exposed by the above commit.
> 
> Al also pointed out that inlining copy_to/from_user() is probably of little or
> no benefit, which is correct. Using Anton's copy_to_user benchmark, with a
> pathological single byte copy, we see a small increase in performance
> by *removing* inlining:
> 
>   Before (inlined):
>   # time ./copy_to_user -w -l 1 -i 10000000	( x 3 )
>   real	0m22.063s
>   real	0m22.059s
>   real	0m22.076s
> 
>   After:
>   # time ./copy_to_user -w -l 1 -i 10000000	( x 3 )
>   real	0m21.325s
>   real	0m21.299s
>   real	0m21.364s
> 
> So as a small performance improvement and to avoid the miscompilation, drop
> inlining copy_to/from_user() on 32-bit.
> 
> Fixes: 3448890c32c3 ("powerpc: get rid of zeroing, switch to RAW_COPY_USER")
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/d6bd8194e2867e85ac2de63486d3b8

cheers
