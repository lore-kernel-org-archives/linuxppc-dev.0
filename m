Return-Path: <srs0=nfy5=34=axtens.net=dja@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7x2Y6B00zDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 21:09:09 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w7x2Y5XBMz8t00
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 21:09:09 +1000 (AEST)
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w7x2Y0Mr9z9s7B
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2017 21:09:08 +1000 (AEST)
Received: by mail-yb0-x244.google.com with SMTP id 206so3575659ybe.0
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2017 04:09:08 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/book3s: mce: Move add_taint() later in virtual
 mode.
In-Reply-To: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
References: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
Date: Thu, 20 Apr 2017 21:09:02 +1000
Message-ID: <874lxjbak1.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mahesh,

> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index a1475e6..b23b323 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -221,6 +221,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
>  {
>  	int index;
>  
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> +
This bit makes sense...

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index ff365f9..af97e81 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -741,6 +739,8 @@ void machine_check_exception(struct pt_regs *regs)
>  
>  	__this_cpu_inc(irq_stat.mce_exceptions);
>  
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> +

But this bit I'm not sure about.

Isn't machine_check_exception called from asm in
kernel/exceptions-64s.S? As in, it's called really early/in real mode?

Regards,
Daniel

>  	/* See if any machine dependent calls. In theory, we would want
>  	 * to call the CPU first, and call the ppc_md. one if the CPU
>  	 * one returns a positive number. However there is existing code
