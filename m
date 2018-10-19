Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5187CECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 06:22:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E002083E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 06:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E002083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bwng3qKVzDqfN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 17:22:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bwlW2NqmzF3G2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:20:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42bwlW1jjbz8sfp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:20:55 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42bwlW1Kwcz9sDP; Fri, 19 Oct 2018 17:20:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42bwlV2S7Yz9sCm
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2018 17:20:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bwlQ3m7Kz9ttFT;
 Fri, 19 Oct 2018 08:20:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dENBL3M3rn42; Fri, 19 Oct 2018 08:20:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bwlQ32Pgz9ttFM;
 Fri, 19 Oct 2018 08:20:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 834608B784;
 Fri, 19 Oct 2018 08:20:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id D2Y4Sf4s9gWl; Fri, 19 Oct 2018 08:20:51 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 575778B75B;
 Fri, 19 Oct 2018 08:20:51 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Fix stack protector crashes on CPU hotplug
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20181019055927.20009-1-mpe@ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <b5aaf1d3-79dc-b73a-0143-e19b2d99e0a8@c-s.fr>
Date: Fri, 19 Oct 2018 08:20:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019055927.20009-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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



Le 19/10/2018 à 07:59, Michael Ellerman a écrit :
> Recently in commit 7241d26e8175 ("powerpc/64: properly initialise
> the stackprotector canary on SMP.") we fixed a crash with stack
> protector on SMP by initialising the stack canary in
> cpu_idle_thread_init().
> 
> But this can also causes crashes, when a CPU comes back online after
> being offline:
> 
>    Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pnv_smp_cpu_kill_self+0x2a0/0x2b0
>    CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00168-g4ffe713b7587 #94
>    Call Trace:
>      dump_stack+0xb0/0xf4 (unreliable)
>      panic+0x144/0x328
>      __stack_chk_fail+0x2c/0x30
>      pnv_smp_cpu_kill_self+0x2a0/0x2b0
>      cpu_die+0x48/0x70
>      arch_cpu_idle_dead+0x20/0x40
>      do_idle+0x274/0x390
>      cpu_startup_entry+0x38/0x50
>      start_secondary+0x5e4/0x600
>      start_secondary_prolog+0x10/0x14
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

This shall not be done on arches that uses a global canary, so I think 
it has to be kept arch specific. Indeed I think x86 should move it to 
cpu_bringup_and_idle(). I'll propose them a patch for that.

Christophe

> 
> Fixes: 7241d26e8175 ("powerpc/64: properly initialise the stackprotector canary on SMP.")
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>



> ---
>   arch/powerpc/kernel/smp.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 8e3a5da24d59..951c476faffc 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -61,6 +61,7 @@
>   #include <asm/asm-prototypes.h>
>   #include <asm/cpu_has_feature.h>
>   #include <asm/ftrace.h>
> +#include <asm/stackprotector.h>
>   
>   #ifdef DEBUG
>   #include <asm/udbg.h>
> @@ -1014,16 +1015,9 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
>   {
>   	struct thread_info *ti = task_thread_info(idle);
>   
> -#ifdef CONFIG_STACKPROTECTOR
> -	idle->stack_canary = get_random_canary();
> -#endif
> -
>   #ifdef CONFIG_PPC64
>   	paca_ptrs[cpu]->__current = idle;
>   	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
> -#ifdef CONFIG_STACKPROTECTOR
> -	paca_ptrs[cpu]->canary = idle->stack_canary;
> -#endif
>   #endif
>   	ti->cpu = cpu;
>   	secondary_ti = current_set[cpu] = ti;
> @@ -1316,6 +1310,8 @@ void start_secondary(void *unused)
>   	notify_cpu_starting(cpu);
>   	set_cpu_online(cpu, true);
>   
> +	boot_init_stack_canary();
> +
>   	local_irq_enable();
>   
>   	/* We can enable ftrace for secondary cpus now */
> 
