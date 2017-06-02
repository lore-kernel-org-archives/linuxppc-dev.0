Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfdXn6rHszDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 08:04:25 +1000 (AEST)
Date: Sat, 3 Jun 2017 08:04:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gustavo Romero <gusbromero@gmail.com>
Subject: Re: [PATCH] powerpc/kernel: improve FP and vector registers
 restoration
Message-ID: <20170603080411.59df057d@kryten>
In-Reply-To: <1496439810-11240-1-git-send-email-leitao@debian.org>
References: <1496439810-11240-1-git-send-email-leitao@debian.org>
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

Hi Breno,

> Currently tsk->thread->load_vec and load_fp are not initialized
> during a task creation, which set garbage to these variables
> (non-zero value).

Nice catch! It seems like we should zero load_tm too though?

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> These variables will be checked later at restore_math() to validate
> if the FP and vectors are being utilized. Since these values might be
> non-zero, the restore_math() will continue to save the FP and vectors
> even if they were never utilized before the userspace application.
> load_fp and load_vec counters will then overflow and the FP and
> Altivec will be finally disabled, but before that condition is
> reached (counter overflow) several context switches restored FP and
> vector registers without need, causing a performance degradation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Gustavo Romero <gusbromero@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c index baae104b16c7..a9435397eab8
> 100644 --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1666,6 +1666,7 @@ void start_thread(struct pt_regs *regs,
> unsigned long start, unsigned long sp) #ifdef CONFIG_VSX
>  	current->thread.used_vsr = 0;
>  #endif
> +	current->thread.load_fp = 0;
>  	memset(&current->thread.fp_state, 0,
> sizeof(current->thread.fp_state)); current->thread.fp_save_area =
> NULL; #ifdef CONFIG_ALTIVEC
> @@ -1674,6 +1675,7 @@ void start_thread(struct pt_regs *regs,
> unsigned long start, unsigned long sp) current->thread.vr_save_area =
> NULL; current->thread.vrsave = 0;
>  	current->thread.used_vr = 0;
> +	current->thread.load_vec = 0;
>  #endif /* CONFIG_ALTIVEC */
>  #ifdef CONFIG_SPE
>  	memset(current->thread.evr, 0, sizeof(current->thread.evr));
