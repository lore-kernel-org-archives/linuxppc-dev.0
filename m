Return-Path: <srs0=gza9=3z=axtens.net=dja@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w64XG4W05zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:39:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w64XG3QvRz8tBY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:39:58 +1000 (AEST)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w64XF27Gkz9s2P
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 20:39:56 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 63so13280709pgh.0
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 03:39:56 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/book3s: mce: Use add_taint_no_warn() in
 machine_check_early().
In-Reply-To: <148765089349.20315.11180051017586952500.stgit@jupiter.in.ibm.com>
References: <148765088309.20315.15300624012053746538.stgit@jupiter.in.ibm.com>
 <148765089349.20315.11180051017586952500.stgit@jupiter.in.ibm.com>
Date: Mon, 17 Apr 2017 20:39:48 +1000
Message-ID: <87o9vvuxl7.fsf@possimpible.ozlabs.ibm.com>
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

> Fixes: 27ea2c420cad powerpc: Set the correct kernel taint on machine check errors.

I notice this Fixes a commit I introduced. Please could you cc me when
you do this? I am likely to miss it otherwise, especially since I have
now left IBM.

Being cced allows me to provide an Ack or a review. And getting feedback
on my changes is very helpful in becoming a better programmer.

In this case, as per Michael's comment, why don't we just move the
add_taint from machine_check_early to
machine_check_process_queued_event - the other side of the work queue.

The work queue system is supposed to provide us with a safe place to do
printing, etc., so it's an appropriate place. Also, we already do
machine_check_print_event_info there, and adding the taint doesn't need
to be done synchronously.

Regards,
Daniel

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> machine_check_early() gets called in real mode. The very first time when
> add_taint() is called, it prints a warning which ends up calling opal
> call (that uses OPAL_CALL wrapper) for writing it to console. If we get a
> very first machine check while we are in opal we are doomed. OPAL_CALL
> overwrites the PACASAVEDMSR in r13 and in this case when we are done with
> MCE handling the original opal call will use this new MSR on it's way
> back to opal_return. This usually leads unexpected behaviour or kernel
> to panic. Instead use the add_taint_no_warn() that does not call printk.
>
> This is broken with current FW level. We got lucky so far for not getting
> very first MCE hit while in OPAL. But easily reproducible on Mambo.
> This should go to stable as well alongwith patch 1/2.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 62b587f..4a048dc 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -306,7 +306,7 @@ long machine_check_early(struct pt_regs *regs)
>  
>  	__this_cpu_inc(irq_stat.mce_exceptions);
>  
> -	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> +	add_taint_no_warn(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>  
>  	/*
>  	 * See if platform is capable of handling machine check. (e.g. PowerNV
