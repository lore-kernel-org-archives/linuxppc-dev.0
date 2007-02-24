Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id EC105DDD07
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Feb 2007 04:57:26 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9f47411a14abab4a1a53a08d5b8822c0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Harden validate_sp against stack corruption
Date: Sat, 24 Feb 2007 11:57:24 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon Feb 19 11:42:42 EST 2007, Paul Mackerras wrote:

> If something has overflowed or corrupted the stack and causes an oops,
> and we try to print a stack trace, that will call validate_sp, which
> can itself cause an oops if the cpu field of the thread_info struct at
> the bottom of the stack has been corrupted (if CONFIG_IRQSTACKS is
> set).  This makes debugging harder.
>
> To avoid the second oops, this adds a check to make sure that the cpu
> number is reasonable before using it to check whether the stack is on
> the softirq or hardirq stack.
>
> Signed-off-by: Paul Mackerras <paulus at samba.org>
> ---
>
> diff --git a/arch/powerpc/kernel/process.c 
> b/arch/powerpc/kernel/process.c
> index f3d4dd5..3712fd5 100644
>


> +       if (cpu < NR_IRQS && cpu_possible(cpu)) {
>

NR_CPUS ?


(and I looked, its simple test_bit so its needed).

milton
