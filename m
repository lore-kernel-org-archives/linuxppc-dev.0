Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AC1F72C032C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 10:05:20 +1000 (EST)
Message-ID: <1347235505.2385.134.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc: Move branch instruction from
 ACCOUNT_CPU_USER_ENTRY to caller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 10:05:05 +1000
In-Reply-To: <1347190604.3418.11.camel@hbabu-laptop>
References: <1347190604.3418.11.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-09-09 at 04:36 -0700, Haren Myneni wrote:
> The first instruction in ACCOUNT_CPU_USER_ENTRY is 'beq' which checkes for
> exceptions coming from kernel mode. PPR value will be saved immediately after
> ACCOUNT_CPU_USER_ENTRY and is also for user level exceptions. So moved this
> branch instruction in the caller code.

grep fail ? ACCOUNT_CPU_USER_ENTRY is used in exception-64e.S as well,
so that needs to be updated too.

Cheers,
Ben.

> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> 
> ---
>  arch/powerpc/include/asm/exception-64s.h |    3 ++-
>  arch/powerpc/include/asm/ppc_asm.h       |    2 --
>  arch/powerpc/kernel/entry_64.S           |    3 ++-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index a43c147..45702e0 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -176,8 +176,9 @@ do_kvm_##n:								\
>  	std	r10,0(r1);		/* make stack chain pointer	*/ \
>  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
>  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
> +	beq	4f;			/* if from kernel mode		*/ \
>  	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
> -	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
> +4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
>  	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
>  	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
>  	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index ea2a86e..376e36d 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -30,7 +30,6 @@
>  #define ACCOUNT_STOLEN_TIME
>  #else
>  #define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
> -	beq	2f;			/* if from kernel mode */	\
>  	MFTB(ra);			/* get timebase */		\
>  	ld	rb,PACA_STARTTIME_USER(r13);				\
>  	std	ra,PACA_STARTTIME(r13);					\
> @@ -38,7 +37,6 @@
>  	ld	ra,PACA_USER_TIME(r13);					\
>  	add	ra,ra,rb;		/* add on to user time */	\
>  	std	ra,PACA_USER_TIME(r13);					\
> -2:
>  
>  #define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
>  	MFTB(ra);			/* get timebase */		\
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index b40e0b4..8d21cc4 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -62,8 +62,9 @@ system_call_common:
>  	std	r12,_MSR(r1)
>  	std	r0,GPR0(r1)
>  	std	r10,GPR1(r1)
> +	beq	2f			/* if from kernel mode */
>  	ACCOUNT_CPU_USER_ENTRY(r10, r11)
> -	std	r2,GPR2(r1)
> +2:	std	r2,GPR2(r1)
>  	std	r3,GPR3(r1)
>  	mfcr	r2
>  	std	r4,GPR4(r1)
