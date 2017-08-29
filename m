Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh8S42VG7zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:20:52 +1000 (AEST)
Date: Tue, 29 Aug 2017 10:11:10 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] powerpc/64s: idle POWER9 can execute stop without
 a sync sequence
Message-ID: <20170829001110.GD12629@fergus.ozlabs.ibm.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825043036.18236-3-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 25, 2017 at 02:30:34PM +1000, Nicholas Piggin wrote:
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h | 16 ----------------
>  arch/powerpc/kernel/idle_book3s.S  | 26 ++++++++++++++++++++------
>  2 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 8a174cba5567..eb43b5c3a7b5 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -101,20 +101,4 @@ static inline void report_invalid_psscr_val(u64 psscr_val, int err)
>  
>  #endif
>  
> -/* Idle state entry routines */
> -#ifdef	CONFIG_PPC_P7_NAP
> -#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
> -	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
> -	std	r0,0(r1);					\
> -	ptesync;						\
> -	ld	r0,0(r1);					\
> -236:	cmpd	cr0,r0,r0;					\
> -	bne	236b;						\
> -	IDLE_INST;						\
> -
> -#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
> -	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
> -	b	.
> -#endif /* CONFIG_PPC_P7_NAP */
> -
>  #endif
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 4924647d964d..14e97f442167 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -205,6 +205,19 @@ pnv_powersave_common:
>  	mtmsrd	r7,0
>  	bctr
>  
> +/*
> + * This is the sequence required to execute idle instructions, as
> + * specified in ISA v2.07. MSR[IR] and MSR[DR] must be 0.
> + */
> +#define ARCH207_IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)		\

We had to do this sequence on POWER7 also, which is architecture
v2.06.  Thus the comments and the naming (ARCH207_*) are a bit
misleading here.  The actual code change looks OK.

Paul.
