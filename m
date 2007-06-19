Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B4ACADDF8A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 00:45:38 +1000 (EST)
Date: Tue, 19 Jun 2007 09:53:56 -0500
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
Message-ID: <20070619145356.GA20382@lixom.net>
References: <20070619063557.GK9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070619063557.GK9768@bakeyournoodle.com>
From: olof@lixom.net (Olof Johansson)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Jun 19, 2007 at 04:35:57PM +1000, Tony Breeds wrote:
> When booting a current kernel with CONFIG_PRINTK_TIME enabled you'll
> see messages like:
> 
> [    0.000000] time_init: decrementer frequency = 188.044000 MHz
> [    0.000000] time_init: processor frequency   = 1504.352000 MHz
> [3712914.436297] Console: colour dummy device 80x25
> 
> This patch modifies sched_clock() to report the offset since the machine booted
> so the same printk's now look like:
> 
> [    0.000000] time_init: decrementer frequency = 188.044000 MHz
> [    0.000000] time_init: processor frequency   = 1504.352000 MHz
> [    0.000135] Console: colour dummy device 80x25
> 
> Effectivly including the uptime in printk()s.

Nice!

> Index: working/arch/powerpc/kernel/time.c
> ===================================================================
> --- working.orig/arch/powerpc/kernel/time.c
> +++ working/arch/powerpc/kernel/time.c
> @@ -115,6 +115,7 @@ EXPORT_SYMBOL_GPL(rtc_lock);
>  
>  u64 tb_to_ns_scale;
>  unsigned tb_to_ns_shift;
> +unsigned long boot_tb;

It only seems to be used in this file, so it can be static, right?


-Olof
