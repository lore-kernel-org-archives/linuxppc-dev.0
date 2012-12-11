Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AF022C0082
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2012 16:48:53 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 11 Dec 2012 15:44:03 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B680F357804F
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2012 16:48:42 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBB5bb3244761150
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2012 16:37:38 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBB5mewj003057
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2012 16:48:41 +1100
Message-ID: <50C6C930.90206@in.ibm.com>
Date: Tue, 11 Dec 2012 11:18:32 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] kprobes/powerpc: Do not disable External interrupts
 during single step
References: <20121203150438.7727.74924.stgit@suzukikp>
 <20121203150720.7727.91582.stgit@suzukikp>
In-Reply-To: <20121203150720.7727.91582.stgit@suzukikp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: srikar@linux.vnet.ibm.com, peterz@infradead.org, bigeasy@linutronix.de,
 oleg@redhat.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, anton@redhat.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/03/2012 08:37 PM, Suzuki K. Poulose wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>
> External/Decrement exceptions have lower priority than the Debug Exception.
> So, we don't have to disable the External interrupts before a single step.
> However, on BookE, Critical Input Exception(CE) has higher priority than a
> Debug Exception. Hence we mask them.
>
> Signed-off-by: 	Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc:		Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc:		Ananth N Mavinakaynahalli <ananth@in.ibm.com>
> Cc:		Kumar Gala <galak@kernel.crashing.org>
> Cc:		linuxppc-dev@ozlabs.org
> ---
>   arch/powerpc/kernel/kprobes.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index e88c643..4901b34 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -104,13 +104,13 @@ void __kprobes arch_remove_kprobe(struct kprobe *p)
>
>   static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
>   {
> -	/* We turn off async exceptions to ensure that the single step will
> -	 * be for the instruction we have the kprobe on, if we dont its
> -	 * possible we'd get the single step reported for an exception handler
> -	 * like Decrementer or External Interrupt */
> -	regs->msr &= ~MSR_EE;
>   	regs->msr |= MSR_SINGLESTEP;
>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> +	/*
> +	 * We turn off Critical Input Exception(CE) to ensure that the single
> +	 * step will be for the instruction we have the probe on; if we don't,
> +	 * it is possible we'd get the single step reported for CE.
> +	 */
>   	regs->msr &= ~MSR_CE;
>   	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
>   #ifdef CONFIG_PPC_47x
>

Ben, Kumar,

Could you please review this patch ?


Thanks
Suzuki
