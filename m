Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0DA6A2C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 13:05:09 +1000 (EST)
Message-ID: <1341371097.2346.15.camel@pasglop>
Subject: Re: [PATCH][v3] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <stuart.yoder@freescale.com>
Date: Wed, 04 Jul 2012 13:04:57 +1000
In-Reply-To: <1341328312-17102-1-git-send-email-stuart.yoder@freescale.com>
References: <1341328312-17102-1-git-send-email-stuart.yoder@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-03 at 10:11 -0500, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> 
> -v3
>    -moved CURRENT_THREAD_INFO out from under the assembly only
>     #define as per comments on mailing list
>    -reversed logic of 64-bit #ifdef for CURRENT_THREAD_INFO 
>     macro

Almost there :-)

>  #define RUNLATCH_ON				\
>  BEGIN_FTR_SECTION				\
> -	clrrdi	r3,r1,THREAD_SHIFT;		\
> +	CURRENT_THREAD_INFO(r3, r1)		\

Missing semicolon (in a macro you need it)

>  	ld	r4,TI_LOCAL_FLAGS(r3);		\
>  	andi.	r0,r4,_TLF_RUNLATCH;		\
>  	beql	ppc64_runlatch_on_trampoline;	\
> @@ -332,7 +332,7 @@ label##_common:							\
>  #ifdef CONFIG_PPC_970_NAP
>  #define FINISH_NAP				\
>  BEGIN_FTR_SECTION				\
> -	clrrdi	r11,r1,THREAD_SHIFT;		\
> +	CURRENT_THREAD_INFO(r11, r1)		\

Same

> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -222,7 +222,7 @@ exc_##n##_bad_stack:							    \
>   * interrupts happen before the wait instruction.
>   */
>  #define CHECK_NAPPING()							\
> -	clrrdi	r11,r1,THREAD_SHIFT;					\
> +	CURRENT_THREAD_INFO(r11, r1)

Missing both semicolon and backslash

Cheers,
Ben.
