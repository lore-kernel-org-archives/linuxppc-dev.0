Return-Path: <hughd@google.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 037E8B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 09:25:35 +1100 (EST)
Received: by dady9 with SMTP id y9so1957688dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2012 14:25:33 -0800 (PST)
Date: Thu, 9 Feb 2012 14:25:02 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix WARN_ON in decrementer_check_overflow
In-Reply-To: <1328765653.2903.59.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1202091411170.1263@eggly.anvils>
References: <1328765653.2903.59.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 9 Feb 2012, Benjamin Herrenschmidt wrote:
> We use __get_cpu_var() which triggers a false positive warning
> in smp_processor_id() thinking interrupts are enabled (at this
> point, they are soft-enabled but hard-disabled).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> I was initially planning to fix that with a more in-depth rework
> of how we do lazy irq disabling on powerpc, but that patch is
> becoming too complex for this release so I'll apply this as a
> stop-gap and leave the full rework for -next

Okay, thanks for the update, that's equivalent to the get_cpu_var
plus put_cpu_var patch I had generally been running with successfully.

(I was not at all confident that it was a sufficient fix, and have
to say "generally" above because one time I got something that looked
like recursive calls overflowing the stack, and IIRC something "irq"
did appear in each frame of the trace.  But probably no connection,
never seen again, and I don't recall even which -rc or -next it was.)

Hugh

>  
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 701d4ac..01e2877 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -118,10 +118,14 @@ static inline notrace void set_soft_enabled(unsigned long enable)
>  static inline notrace void decrementer_check_overflow(void)
>  {
>  	u64 now = get_tb_or_rtc();
> -	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
> +	u64 *next_tb;
> +
> +	preempt_disable();
> +	next_tb = &__get_cpu_var(decrementers_next_tb);
>  
>  	if (now >= *next_tb)
>  		set_dec(1);
> +	preempt_enable();
>  }
>  
>  notrace void arch_local_irq_restore(unsigned long en)
