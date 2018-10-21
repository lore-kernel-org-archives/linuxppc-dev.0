Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3C6ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 08:39:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C927120838
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 08:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C927120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dCkC73RYzF100
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 19:39:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dChH0LXBzF0RK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2018 19:37:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42dChG6sNnz9sCw; Sun, 21 Oct 2018 19:37:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42dChF10gYz9sCQ;
 Sun, 21 Oct 2018 19:37:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix stack protector crashes on CPU hotplug
In-Reply-To: <20181019055927.20009-1-mpe@ellerman.id.au>
References: <20181019055927.20009-1-mpe@ellerman.id.au>
Date: Sun, 21 Oct 2018 19:37:29 +1100
Message-ID: <87o9bng0fq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: abdhalee@linux.vnet.ibm.com, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Recently in commit 7241d26e8175 ("powerpc/64: properly initialise
> the stackprotector canary on SMP.") we fixed a crash with stack
> protector on SMP by initialising the stack canary in
> cpu_idle_thread_init().
>
> But this can also causes crashes, when a CPU comes back online after
> being offline:
>
>   Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pnv_smp_cpu_kill_self+0x2a0/0x2b0
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00168-g4ffe713b7587 #94
>   Call Trace:
>     dump_stack+0xb0/0xf4 (unreliable)
>     panic+0x144/0x328
>     __stack_chk_fail+0x2c/0x30
>     pnv_smp_cpu_kill_self+0x2a0/0x2b0
>     cpu_die+0x48/0x70
>     arch_cpu_idle_dead+0x20/0x40
>     do_idle+0x274/0x390
>     cpu_startup_entry+0x38/0x50
>     start_secondary+0x5e4/0x600
>     start_secondary_prolog+0x10/0x14
>
> Looking at the stack we see that the canary value in the stack frame
> doesn't match the canary in the task/paca. That is because we have
> reinitialised the task/paca value, but then the CPU coming online has
> returned into a function using the old canary value. That causes the
> comparison to fail.
>
> Instead we can call boot_init_stack_canary() from start_secondary()
> which never returns. This is essentially what the generic code does in
> cpu_startup_entry() under #ifdef X86, we should make that non-x86
> specific in a future patch.
>
> Fixes: 7241d26e8175 ("powerpc/64: properly initialise the stackprotector canary on SMP.")
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/smp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 8e3a5da24d59..951c476faffc 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -61,6 +61,7 @@
>  #include <asm/asm-prototypes.h>
>  #include <asm/cpu_has_feature.h>
>  #include <asm/ftrace.h>
> +#include <asm/stackprotector.h>

This needs to be linux/stackprotector.h, else the build breaks with
stackprotector disabled.

cheers
