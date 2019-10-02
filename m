Return-Path: <SRS0=frIq=X3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B231EC35280
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 08:28:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCA921783
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 08:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCA921783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46jq601y8RzDqXR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 18:28:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46jpxy09GCzDqWk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2019 18:21:26 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 14984B011;
 Wed,  2 Oct 2019 08:21:23 +0000 (UTC)
Date: Wed, 2 Oct 2019 10:21:21 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 23/27] powerpc/64: system call implement the bulk of
 the logic in C
Message-ID: <20190923124751.GC18205@kitsune.suse.cz>
References: <20190915012813.29317-1-npiggin@gmail.com>
 <20190915012813.29317-24-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915012813.29317-24-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Sep 15, 2019 at 11:28:09AM +1000, Nicholas Piggin wrote:
> System call entry and particularly exit code is beyond the limit of what
> is reasonable to implement in asm.
> 
> This conversion moves all conditional branches out of the asm code,
> except for the case that all GPRs should be restored at exit.
> 
> Null syscall test is about 5% faster after this patch, because the exit
> work is handled under local_irq_disable, and the hard mask and pending
> interrupt replay is handled after that, which avoids games with MSR.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> v3:
> - Fix !KUAP build [mpe]
> - Fix BookE build/boot [mpe]
> - Don't trace irqs with MSR[RI]=0
> - Don't allow syscall_exit_prepare to be ftraced, because function
>   graph tracing which traces exits barfs after the IRQ state is
>   prepared for kernel exit.
> - Fix BE syscall table to use normal function descriptors now that they
>   are called from C.
> - Comment syscall_exit_prepare.
...
> -#if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(CONFIG_PPC_SPLPAR)
> -BEGIN_FW_FTR_SECTION
> -	/* see if there are any DTL entries to process */
> -	ld	r10,PACALPPACAPTR(r13)	/* get ptr to VPA */
> -	ld	r11,PACA_DTL_RIDX(r13)	/* get log read index */
> -	addi	r10,r10,LPPACA_DTLIDX
> -	LDX_BE	r10,0,r10		/* get log write index */
> -	cmpd	r11,r10
> -	beq+	33f
> -	bl	accumulate_stolen_time
> -	REST_GPR(0,r1)
> -	REST_4GPRS(3,r1)
> -	REST_2GPRS(7,r1)
> -	addi	r9,r1,STACK_FRAME_OVERHEAD
> -33:
> -END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
> -#endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
...
> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
> new file mode 100644
> index 000000000000..1d2529824588
> --- /dev/null
> +++ b/arch/powerpc/kernel/syscall_64.c
> @@ -0,0 +1,195 @@
> +#include <linux/err.h>
> +#include <asm/book3s/64/kup-radix.h>
> +#include <asm/cputime.h>
> +#include <asm/hw_irq.h>
> +#include <asm/kprobes.h>
> +#include <asm/paca.h>
> +#include <asm/ptrace.h>
> +#include <asm/reg.h>
> +#include <asm/signal.h>
> +#include <asm/switch_to.h>
> +#include <asm/syscall.h>
> +#include <asm/time.h>
> +
> +extern void __noreturn tabort_syscall(void);
> +
> +typedef long (*syscall_fn)(long, long, long, long, long, long);
> +
> +long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8, unsigned long r0, struct pt_regs *regs)
> +{
> +	unsigned long ti_flags;
> +	syscall_fn f;
> +
> +	BUG_ON(!(regs->msr & MSR_PR));
> +
> +	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> +			unlikely(regs->msr & MSR_TS_T))
> +		tabort_syscall();
> +
> +	account_cpu_user_entry();
> +
> +#ifdef CONFIG_PPC_SPLPAR
> +	if (IS_ENABLED(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) &&
> +			firmware_has_feature(FW_FEATURE_SPLPAR)) {
> +		struct lppaca *lp = get_lppaca();
> +
> +		if (unlikely(local_paca->dtl_ridx != lp->dtl_idx))

sparse complains about this, and in time.c this it converted like this:
if (unlikely(local_paca->dtl_ridx != be64_to_cpu(lp->dtl_idx)))
The removed code has a LDX_BE there so there should be some conversion
involved, right?

Thanks

Michal
