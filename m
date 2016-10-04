Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp3zP05cxzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 14:18:57 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 190so3777188pfv.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 20:18:56 -0700 (PDT)
Date: Tue, 4 Oct 2016 14:18:35 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Remove static branch prediction in atomic{,
 64}_add_unless
Message-ID: <20161004141835.03027e51@roar.ozlabs.ibm.com>
In-Reply-To: <1475474583-3085-1-git-send-email-anton@ozlabs.org>
References: <1475474583-3085-1-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  3 Oct 2016 17:03:03 +1100
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> I see quite a lot of static branch mispredictions on a simple
> web serving workload. The issue is in __atomic_add_unless(), called
> from _atomic_dec_and_lock(). There is no obvious common case, so it
> is better to let the hardware predict the branch.

Seems reasonable. How problematic is an unmatched lwarx for performance?
It seems that it will serialize a subsequent lwarx until it is next to
complete (in the case of atomic_dec_and_lock, the spin_lock will
immediately do another lwarx). Maybe that's not a big problem.

Putting a regular load and test here before the lwarx would be
disappointing because many users have success as the common case.


> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/atomic.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index f08d567..2b90335 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -233,7 +233,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
>  	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	lwarx	%0,0,%1		# __atomic_add_unless\n\
>  	cmpw	0,%0,%3 \n\
> -	beq-	2f \n\
> +	beq	2f \n\
>  	add	%0,%2,%0 \n"
>  	PPC405_ERR77(0,%2)
>  "	stwcx.	%0,0,%1 \n\
> @@ -539,7 +539,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>  	PPC_ATOMIC_ENTRY_BARRIER
>  "1:	ldarx	%0,0,%1		# __atomic_add_unless\n\
>  	cmpd	0,%0,%3 \n\
> -	beq-	2f \n\
> +	beq	2f \n\
>  	add	%0,%2,%0 \n"
>  "	stdcx.	%0,0,%1 \n\
>  	bne-	1b \n"
