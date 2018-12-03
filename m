Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE0C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:09:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AD720834
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0mZZZ5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AD720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437qgR108NzDqcm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 03:09:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S0mZZZ5+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=daniel.thompson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="S0mZZZ5+"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437qQ612wQzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 02:57:30 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id c126so6209865wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=35SwHc/wTajPXEk/ZNTQ/zNrwbuN3l3GZZC2HvWJrxg=;
 b=S0mZZZ5+MfOGuu/3FzwDHO5aeWNAR/HGOxn+Zt2OUufHFFuasgx41bjzYd2rSmMf98
 6FzB38Xfj3tkJEI+Pw3oiDJ3oek1XEHXy5cmcON3oKUXwO5+smVo2lCKRfLNRbWpPVUA
 sUbJ+6OrayX2kKlWZxqqMvpkEv5/N+oF2gjqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=35SwHc/wTajPXEk/ZNTQ/zNrwbuN3l3GZZC2HvWJrxg=;
 b=ZmPhOSuQN5PQQ927fdvrZsM6HVuIgvsMewYGjHrvhkM6h9xdVEsrM3yofRQoePAYyH
 SQftlUpQIMIsqfMybmlRxYpldBJ+eohSeGczLsCy1RWqX9eNRX8sJNeeSXBvYqHRqD9o
 iX3+veq7JPPAOmKoe9K7PRrewCR6i5JgZf3pdnp8D+2wvKJLZplOO9YoNJduGB0nLG8r
 CLZW67Kav8inYxMVYf5EhHQLgzPPQwd+yKIKNEqxF/1q9+qreev/ncUK63whGPzkzBVF
 nQsAMXSZfjwSMFZSwqgF/wvTKb8D3+wSOk50RJzfdj7SU+ESjyo2hst0LyH3ozWTMPvu
 ECkg==
X-Gm-Message-State: AA+aEWZIyu9Bme/AddV328yOiVAyNfdFstgxwwijiOwVOShsjqLN+gJ7
 UKhcSM2+wFifEOFr65harrvY2g==
X-Google-Smtp-Source: AFSGD/W2xYDzah7+ehvSRllQRT+brTlTuoAeiYgJysvoqEgRtb2o1W8HrWaaYwrMzSL8gr26ilu5ow==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr8320911wmi.57.1543852647539;
 Mon, 03 Dec 2018 07:57:27 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id s202sm7391190wme.40.2018.12.03.07.57.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 07:57:26 -0800 (PST)
Date: Mon, 3 Dec 2018 15:57:24 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181203155724.7g37vp43e4fd4xqk@holly.lan>
References: <20181127173839.34328-1-dianders@chromium.org>
 <20181127173839.34328-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127173839.34328-3-dianders@chromium.org>
User-Agent: NeoMutt/20180716
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, linux-hexagon@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>,
 Jason Wessel <jason.wessel@windriver.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 27, 2018 at 09:38:37AM -0800, Douglas Anderson wrote:
> When I had lockdep turned on and dropped into kgdb I got a nice splat
> on my system.  Specifically it hit:
>   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> 
> Specifically it looked like this:
>   sysrq: SysRq : DEBUG
>   ------------[ cut here ]------------
>   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>   WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
>   pstate: 604003c9 (nZCv DAIF +PAN -UAO)
>   pc : lockdep_hardirqs_on+0xf0/0x160
>   ...
>   Call trace:
>    lockdep_hardirqs_on+0xf0/0x160
>    trace_hardirqs_on+0x188/0x1ac
>    kgdb_roundup_cpus+0x14/0x3c
>    kgdb_cpu_enter+0x53c/0x5cc
>    kgdb_handle_exception+0x180/0x1d4
>    kgdb_compiled_brk_fn+0x30/0x3c
>    brk_handler+0x134/0x178
>    do_debug_exception+0xfc/0x178
>    el1_dbg+0x18/0x78
>    kgdb_breakpoint+0x34/0x58
>    sysrq_handle_dbg+0x54/0x5c
>    __handle_sysrq+0x114/0x21c
>    handle_sysrq+0x30/0x3c
>    qcom_geni_serial_isr+0x2dc/0x30c
>   ...
>   ...
>   irq event stamp: ...45
>   hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
>   hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
>   softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
>   softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
>   ---[ end trace adf21f830c46e638 ]---
> 
> Looking closely at it, it seems like a really bad idea to be calling
> local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> like it could violate spinlock semantics and cause a deadlock.
> 
> Instead, let's use a private csd alongside
> smp_call_function_single_async() to round up the other CPUs.  Using
> smp_call_function_single_async() doesn't require interrupts to be
> enabled so we can remove the offending bit of code.
> 
> In order to avoid duplicating this across all the architectures that
> use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
> to debug_core.c.
> 
> Looking at all the people who previously had copies of this code,
> there were a few variants.  I've attempted to keep the variants
> working like they used to.  Specifically:
> * For arch/arc we passed NULL to kgdb_nmicallback() instead of
>   get_irq_regs().
> * For arch/mips there was a bit of extra code around
>   kgdb_nmicallback()
> 
> NOTE: In this patch we will still get into trouble if we try to round
> up a CPU that failed to round up before.  We'll try to round it up
> again and potentially hang when we try to grab the csd lock.  That's
> not new behavior but we'll still try to do better in a future patch.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v6:
> - Moved smp_call_function_single_async() error check to patch 3.
> 
> Changes in v5:
> - Add a comment about get_irq_regs().
> - get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
> - for_each_cpu() => for_each_online_cpu()
> - Error check smp_call_function_single_async()
> 
> Changes in v4: None
> Changes in v3:
> - No separate init call.
> - Don't round up the CPU that is doing the rounding up.
> - Add "#ifdef CONFIG_SMP" to match the rest of the file.
> - Updated desc saying we don't solve the "failed to roundup" case.
> - Document the ignored parameter.
> 
> Changes in v2:
> - Removing irq flags separated from fixing lockdep splat.
> - Don't use smp_call_function (Daniel).
> 
>  arch/arc/kernel/kgdb.c     | 10 ++--------
>  arch/arm/kernel/kgdb.c     | 12 -----------
>  arch/arm64/kernel/kgdb.c   | 12 -----------
>  arch/hexagon/kernel/kgdb.c | 27 -------------------------
>  arch/mips/kernel/kgdb.c    |  9 +--------
>  arch/powerpc/kernel/kgdb.c |  4 ++--
>  arch/sh/kernel/kgdb.c      | 12 -----------

Please could you re-send with the arch maintainers for these platforms
included in the Cc: of the patch description rather than just in the
e-mail header.

I'd like to make sure arch maintainers have a chance to opt out if they
want to (it's a weak symbol so an arch could chose not to use it).

Otherwise I shall start testing shortly!


Daniel.


>  include/linux/kgdb.h       | 15 ++++++++++++--
>  kernel/debug/debug_core.c  | 41 ++++++++++++++++++++++++++++++++++++++
>  9 files changed, 59 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
> index 0932851028e0..68d9fe4b5aa7 100644
> --- a/arch/arc/kernel/kgdb.c
> +++ b/arch/arc/kernel/kgdb.c
> @@ -192,18 +192,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  	instruction_pointer(regs) = ip;
>  }
>  
> -static void kgdb_call_nmi_hook(void *ignored)
> +void kgdb_call_nmi_hook(void *ignored)
>  {
> +	/* Default implementation passes get_irq_regs() but we don't */
>  	kgdb_nmicallback(raw_smp_processor_id(), NULL);
>  }
>  
> -void kgdb_roundup_cpus(void)
> -{
> -	local_irq_enable();
> -	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
> -}
> -
>  struct kgdb_arch arch_kgdb_ops = {
>  	/* breakpoint instruction: TRAP_S 0x3 */
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index f21077b077be..d9a69e941463 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -170,18 +170,6 @@ static struct undef_hook kgdb_compiled_brkpt_hook = {
>  	.fn			= kgdb_compiled_brk_fn
>  };
>  
> -static void kgdb_call_nmi_hook(void *ignored)
> -{
> -       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> -}
> -
> -void kgdb_roundup_cpus(void)
> -{
> -       local_irq_enable();
> -       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -       local_irq_disable();
> -}
> -
>  static int __kgdb_notify(struct die_args *args, unsigned long cmd)
>  {
>  	struct pt_regs *regs = args->regs;
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 12c339ff6e75..da880247c734 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -284,18 +284,6 @@ static struct step_hook kgdb_step_hook = {
>  	.fn		= kgdb_step_brk_fn
>  };
>  
> -static void kgdb_call_nmi_hook(void *ignored)
> -{
> -	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> -}
> -
> -void kgdb_roundup_cpus(void)
> -{
> -	local_irq_enable();
> -	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
> -}
> -
>  static int __kgdb_notify(struct die_args *args, unsigned long cmd)
>  {
>  	struct pt_regs *regs = args->regs;
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> index 012e0e230ac2..b95d12038a4e 100644
> --- a/arch/hexagon/kernel/kgdb.c
> +++ b/arch/hexagon/kernel/kgdb.c
> @@ -115,33 +115,6 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>  	instruction_pointer(regs) = pc;
>  }
>  
> -#ifdef CONFIG_SMP
> -
> -/**
> - * kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - *
> - * On SMP systems, we need to get the attention of the other CPUs
> - * and get them be in a known state.  This should do what is needed
> - * to get the other CPUs to call kgdb_wait(). Note that on some arches,
> - * the NMI approach is not used for rounding up all the CPUs. For example,
> - * in case of MIPS, smp_call_function() is used to roundup CPUs.
> - *
> - * On non-SMP systems, this is not called.
> - */
> -
> -static void hexagon_kgdb_nmi_hook(void *ignored)
> -{
> -	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> -}
> -
> -void kgdb_roundup_cpus(void)
> -{
> -	local_irq_enable();
> -	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
> -	local_irq_disable();
> -}
> -#endif
> -
>  
>  /*  Not yet working  */
>  void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 2b05effc17b4..42f057a6c215 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -207,7 +207,7 @@ void arch_kgdb_breakpoint(void)
>  		".set\treorder");
>  }
>  
> -static void kgdb_call_nmi_hook(void *ignored)
> +void kgdb_call_nmi_hook(void *ignored)
>  {
>  	mm_segment_t old_fs;
>  
> @@ -219,13 +219,6 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	set_fs(old_fs);
>  }
>  
> -void kgdb_roundup_cpus(void)
> -{
> -	local_irq_enable();
> -	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
> -}
> -
>  static int compute_signal(int tt)
>  {
>  	struct hard_trap_info *ht;
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index b0e804844be0..b4ce54d73337 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -117,7 +117,7 @@ int kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return kgdb_isremovedbreak(regs->nip);
>  }
>  
> -static int kgdb_call_nmi_hook(struct pt_regs *regs)
> +static int kgdb_debugger_ipi(struct pt_regs *regs)
>  {
>  	kgdb_nmicallback(raw_smp_processor_id(), regs);
>  	return 0;
> @@ -502,7 +502,7 @@ int kgdb_arch_init(void)
>  	old__debugger_break_match = __debugger_break_match;
>  	old__debugger_fault_handler = __debugger_fault_handler;
>  
> -	__debugger_ipi = kgdb_call_nmi_hook;
> +	__debugger_ipi = kgdb_debugger_ipi;
>  	__debugger = kgdb_debugger;
>  	__debugger_bpt = kgdb_handle_breakpoint;
>  	__debugger_sstep = kgdb_singlestep;
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index cc57630f6bf2..14e012ad7c57 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -314,18 +314,6 @@ BUILD_TRAP_HANDLER(singlestep)
>  	local_irq_restore(flags);
>  }
>  
> -static void kgdb_call_nmi_hook(void *ignored)
> -{
> -	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> -}
> -
> -void kgdb_roundup_cpus(void)
> -{
> -	local_irq_enable();
> -	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
> -}
> -
>  static int __kgdb_notify(struct die_args *args, unsigned long cmd)
>  {
>  	int ret;
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 05e5b2eb0d32..24422865cd18 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -176,14 +176,25 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  			   char *remcom_out_buffer,
>  			   struct pt_regs *regs);
>  
> +/**
> + *	kgdb_call_nmi_hook - Call kgdb_nmicallback() on the current CPU
> + *	@ignored: This parameter is only here to match the prototype.
> + *
> + *	If you're using the default implementation of kgdb_roundup_cpus()
> + *	this function will be called per CPU.  If you don't implement
> + *	kgdb_call_nmi_hook() a default will be used.
> + */
> +
> +extern void kgdb_call_nmi_hook(void *ignored);
> +
>  /**
>   *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them into a known state.  This should do what is needed
>   *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
> - *	the NMI approach is not used for rounding up all the CPUs. For example,
> - *	in case of MIPS, smp_call_function() is used to roundup CPUs.
> + *	the NMI approach is not used for rounding up all the CPUs.  Normally
> + *	those architectures can just not implement this and get the default.
>   *
>   *	On non-SMP systems, this is not called.
>   */
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index f3cadda45f07..10db2833a423 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,46 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SMP
> +
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	/*
> +	 * NOTE: get_irq_regs() is supposed to get the registers from
> +	 * before the IPI interrupt happened and so is supposed to
> +	 * show where the processor was.  In some situations it's
> +	 * possible we might be called without an IPI, so it might be
> +	 * safer to figure out how to make kgdb_breakpoint() work
> +	 * properly here.
> +	 */
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int this_cpu = raw_smp_processor_id();
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		/* No need to roundup ourselves */
> +		if (cpu == this_cpu)
> +			continue;
> +
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +		smp_call_function_single_async(cpu, csd);
> +	}
> +}
> +
> +#endif
> +
>  /*
>   * Some architectures need cache flushes when we set/clear a
>   * breakpoint:
> -- 
> 2.20.0.rc0.387.gc7a69e6b6c-goog
> 
