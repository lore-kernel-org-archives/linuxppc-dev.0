Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdTYn4ThqzDsfn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 14:00:29 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id vz6so293447pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 21:00:29 -0700 (PDT)
Subject: Re: [PATCH] powerpc/64s: optimise syscall entry for virtual,
 relocatable case
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20160915090321.787-1-npiggin@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f1aba0ad-04e3-9e27-439d-dad4e34c0c2f@gmail.com>
Date: Tue, 20 Sep 2016 14:00:23 +1000
MIME-Version: 1.0
In-Reply-To: <20160915090321.787-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/09/16 19:03, Nicholas Piggin wrote:
> The mflr r10 instruction was left over saving of lr when the code used
> lr to branch to system_call_entry from the exception handler. That was
> changed by 6a404806d to use the count register. The value is never used
> now, so mflr can be removed, and r10 can be used for storage rather than
> spilling to the SPR scratch register.
> 
> The scratch register spill causes a long pipeline stall due to the SPR
> read after write. This change brings getppid syscall cost from 406 to
> 376 cycles on POWER8. getppid for non-relocatable case is 371 cycles.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
>  arch/powerpc/kernel/exceptions-64s.S | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index df6d45e..2cdd64f 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -63,15 +63,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
>  	 * is volatile across system calls.
>  	 */
>  #define SYSCALL_PSERIES_2_DIRECT				\
> -	mflr	r10 ;						\
>  	ld	r12,PACAKBASE(r13) ; 				\
>  	LOAD_HANDLER(r12, system_call_entry) ;			\
>  	mtctr	r12 ;						\
>  	mfspr	r12,SPRN_SRR1 ;					\
> -	/* Re-use of r13... No spare regs to do this */	\
> -	li	r13,MSR_RI ;					\
> -	mtmsrd 	r13,1 ;						\
> -	GET_PACA(r13) ;	/* get r13 back */			\
> +	li	r10,MSR_RI ;					\
> +	mtmsrd 	r10,1 ;						\
>  	bctr ;
>  #else
>  	/* We can branch directly */
> 

The patch makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
