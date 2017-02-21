Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS4fk3RQ2zDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 13:47:42 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS4fj5Kjyz9s7s
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 13:47:41 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 1so8389256pgz.2
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 18:47:41 -0800 (PST)
Date: Tue, 21 Feb 2017 12:47:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 5/7] powerpc/book3s: Don't turn on the MSR[ME] bit
 until opal processes the reason.
Message-ID: <20170221124728.675af9f9@roar.ozlabs.ibm.com>
In-Reply-To: <148764197591.19289.17096730042146758117.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
 <148764197591.19289.17096730042146758117.stgit@jupiter.in.ibm.com>
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

On Tue, 21 Feb 2017 07:22:56 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Delay it until we are done with machine_check_early() call. Turn on MSR[ME]
> once opal is done with processing MCE.

Why? This seems like quite a regression -- the MCE handler today
has about 60 instructions and 30 l/st with ME clear.


> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index d39d611..fa768a7 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -238,6 +238,12 @@ BEGIN_FTR_SECTION
>  	std	r9,_CCR(r1)		/* Save CR in stackframe */
>  	/* Save r9 through r13 from EXMC save area to stack frame. */
>  	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
> +	std	r0,GPR0(r1)	/* Save r0 */
> +	EXCEPTION_PROLOG_COMMON_3(0x200)
> +	bl	save_nvgprs
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	machine_check_early
> +	std	r3,RESULT(r1)	/* Save result */
>  	mfmsr	r11			/* get MSR value */
>  	ori	r11,r11,MSR_ME		/* turn on ME bit */
>  	ori	r11,r11,MSR_RI		/* turn on RI bit */
> @@ -345,12 +351,6 @@ EXC_COMMON_BEGIN(machine_check_common)
>  	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
>  	 */
>  EXC_COMMON_BEGIN(machine_check_handle_early)
> -	std	r0,GPR0(r1)	/* Save r0 */
> -	EXCEPTION_PROLOG_COMMON_3(0x200)
> -	bl	save_nvgprs
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	bl	machine_check_early
> -	std	r3,RESULT(r1)	/* Save result */
>  	ld	r12,_MSR(r1)
>  #ifdef	CONFIG_PPC_P7_NAP
>  	/*
> 
