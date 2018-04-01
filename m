Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DS2G2s0jzF21P
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 17:40:38 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a2so5184674pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Apr 2018 00:40:38 -0700 (PDT)
Date: Sun, 1 Apr 2018 17:40:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Fix DABR write in the case of DAWR disabled
Message-ID: <20180401174019.7c038f0d@roar.ozlabs.ibm.com>
In-Reply-To: <20180401055036.18078-3-npiggin@gmail.com>
References: <20180401055036.18078-1-npiggin@gmail.com>
 <20180401055036.18078-3-npiggin@gmail.com>
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

On Sun,  1 Apr 2018 15:50:36 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> flush_thread will call set_breakpoint via set_debug_reg_defaults,
> and cause POWER8 and above CPUs without the DAWR feature to try
> to write to DAWR.
              ^^^^
              DABR

> 
> Cc: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 24a591b4dbe9..bfcf5437083c 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -718,7 +718,8 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
>  {
>  	thread->hw_brk.address = 0;
>  	thread->hw_brk.type = 0;
> -	set_breakpoint(&thread->hw_brk);
> +	if (ppc_breakpoint_available())
> +		set_breakpoint(&thread->hw_brk);
>  }
>  #endif /* !CONFIG_HAVE_HW_BREAKPOINT */
>  #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
> @@ -814,10 +815,14 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
>  {
>  	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
>  
> -	if (cpu_has_feature(CPU_FTR_DAWR))
> -		set_dawr(brk);
> -	else
> +	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> +		if (cpu_has_feature(CPU_FTR_DAWR))
> +			set_dawr(brk);
> +		else
> +			WARN_ON_ONCE(1);
> +	} else {
>  		set_dabr(brk);
> +	}
>  }
>  
>  void set_breakpoint(struct arch_hw_breakpoint *brk)
