Return-Path: <ananth@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 754C2B6FAF
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 15:55:25 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p6B5tIrl019134
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 11:25:18 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6B5tI004514006
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 11:25:18 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6B5tH76019336
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 15:55:18 +1000
Date: Mon, 11 Jul 2011 11:25:17 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [v2 PATCH 2/2] booke/kprobe: remove unnecessary
	preempt_enable_no_resched
Message-ID: <20110711055516.GA4659@in.ibm.com>
References: <1310351976-24078-1-git-send-email-tiejun.chen@windriver.com>
	<1310351976-24078-2-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310351976-24078-2-git-send-email-tiejun.chen@windriver.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 11, 2011 at 10:39:35AM +0800, Tiejun Chen wrote:
> When enable CONFIG_PREEMPT we will trigger the following call trace:
> 
> BUG: scheduling while atomic: swapper/1/0x10000000
> ...
> 
> krpobe always goes through the following path:
> 
> program_check_exception()
>         |
>         + notify_die(DIE_BPT, "breakpoint",...)
>                 |
>                 + kprobe_handler()
>                         |
>                         + preempt_disable();
>                         + break_handler() <- preempt_enable_no_resched()
>                         + emulate_step()
>                         + preempt_enable_no_resched()
>                         ...
>         exit
> 
> We should remove unnecessary preempt_enable_no_resched() inside of break_handler()
> since looks longjmp_break_handler() always go the above path.

The current code is correct. Reasoning follows...

setjmp_pre_handler() and longjmp_break_handler() are used only for
jprobes. In the case of a jprobe, the code flow would be:

bp hit -> kprobe_handler() -> preempt_disable() -> setjmp_pre_handler()
(not that since this routine returns 1, we skip sstep here) -> jp->entry()
-> jprobe_return() -> bp hit -> kprobe_handler() -> preempt_disable() again
-> longjmp_break_handler() -> preempt_enable() -> sstep -> preempt_enable()
(for the second kprobe_handler() entry).

You could verify this with a preempt_count() printk with a
CONFIG_PREEMPT=y kernel.

> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

Nack, sorry :-)

Ananth
