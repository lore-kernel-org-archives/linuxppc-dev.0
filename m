Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrq0Q4Ry6zDqMP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 21:45:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/9] powerpc/64s: SLB miss already has CTR saved for
 relocatable kernel
In-Reply-To: <20170521131550.25813-4-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
 <20170521131550.25813-4-npiggin@gmail.com>
Date: Mon, 19 Jun 2017 21:45:06 +1000
Message-ID: <877f08urp9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The EXCEPTION_PROLOG_1 used by SLB miss already saves CTR when the
> kernel is built with CONFIG_RELOCATABLE. So it does not have to be
> saved and reloaded when branching to slb_miss_realmode. It can be
> restored from the PACA as usual.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index a4a71bce35d6..486e205cc762 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -519,7 +519,7 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
>  	 * because the distance from here to there depends on where
>  	 * the kernel ends up being put.
>  	 */
> -	mfctr	r11
> +	/* CTR is saved if RELOCATABLE */
>  	LOAD_HANDLER(r10, slb_miss_realmode)
>  	mtctr	r10
>  	bctr

AFAICS these can all use BRANCH_TO_COMMON().

So I'll drop all the comment additions from this and do a follow-up to
switch to BRANCH_TO_COMMON().

cheers
