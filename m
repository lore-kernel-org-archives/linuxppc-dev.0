Return-Path: <SRS0=fZjV=DT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB7C433E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 01:47:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ADC20782
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 01:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="G2SILhc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ADC20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C8hPn4BsrzDqsN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 12:47:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8hMl6f75zDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2020 12:45:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=G2SILhc5; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4C8hMf0qsMz9sRK;
 Mon, 12 Oct 2020 12:45:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1602467138;
 bh=QMZkogI/gfDoyPHm/Lw5pjXwd5LTspyIiIIxRsHsUhE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=G2SILhc5zkJv94KDxb2kWB4/qyoGwraRecRHH+4IQoyIvFEaqLhtooHgvfyzzuZFl
 YPzWUvHFRZjWnq1p1acv2p2D2YbjTyAUNMFR4dAEuVcXaxgVmIhpeIb9mzH9gwkLOg
 CHCnaovOIHeORhIoMTGfpSQTRcwjmYcm/3NQPYBgEjT33tl/8LxYGXrDI8kpbjmQMq
 9bQiWKxfSPNGHzMZNRC27yLVwkYbcNr1BZAo8z3LRmRTEZv8wGMlCy18gVmp3TpRwu
 DxUjK2O/IPbDNOvuqm5k2QTF8awhYHFfcM13Ag5PYgQr+XefpUFtjhDs38pcQFyTlR
 sBDe+EGxPLyfg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/smp: Use GFP_ATOMIC while allocating tmp mask
In-Reply-To: <20201008034240.34059-1-srikar@linux.vnet.ibm.com>
References: <20201008034240.34059-1-srikar@linux.vnet.ibm.com>
Date: Mon, 12 Oct 2020 12:45:33 +1100
Message-ID: <874kn01aki.fsf@mpe.ellerman.id.au>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Qian Cai <cai@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> Qian Cai reported a regression where CPU Hotplug fails with the latest
> powerpc/next
>
> BUG: sleeping function called from invalid context at mm/slab.h:494
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/88
> no locks held by swapper/88/0.
> irq event stamp: 18074448
> hardirqs last  enabled at (18074447): [<c0000000001a2a7c>] tick_nohz_idle_enter+0x9c/0x110
> hardirqs last disabled at (18074448): [<c000000000106798>] do_idle+0x138/0x3b0
> do_idle at kernel/sched/idle.c:253 (discriminator 1)
> softirqs last  enabled at (18074440): [<c0000000000bbec4>] irq_enter_rcu+0x94/0xa0
> softirqs last disabled at (18074439): [<c0000000000bbea0>] irq_enter_rcu+0x70/0xa0
> CPU: 88 PID: 0 Comm: swapper/88 Tainted: G        W         5.9.0-rc8-next-20201007 #1
> Call Trace:
> [c00020000a4bfcf0] [c000000000649e98] dump_stack+0xec/0x144 (unreliable)
> [c00020000a4bfd30] [c0000000000f6c34] ___might_sleep+0x2f4/0x310
> [c00020000a4bfdb0] [c000000000354f94] slab_pre_alloc_hook.constprop.82+0x124/0x190
> [c00020000a4bfe00] [c00000000035e9e8] __kmalloc_node+0x88/0x3a0
> slab_alloc_node at mm/slub.c:2817
> (inlined by) __kmalloc_node at mm/slub.c:4013
> [c00020000a4bfe80] [c0000000006494d8] alloc_cpumask_var_node+0x38/0x80
> kmalloc_node at include/linux/slab.h:577
> (inlined by) alloc_cpumask_var_node at lib/cpumask.c:116
> [c00020000a4bfef0] [c00000000003eedc] start_secondary+0x27c/0x800
> update_mask_by_l2 at arch/powerpc/kernel/smp.c:1267
> (inlined by) add_cpu_to_masks at arch/powerpc/kernel/smp.c:1387
> (inlined by) start_secondary at arch/powerpc/kernel/smp.c:1420
> [c00020000a4bff90] [c00000000000c468] start_secondary_resume+0x10/0x14
>
> Allocating a temporary mask while performing a CPU Hotplug operation
> with CONFIG_CPUMASK_OFFSTACK enabled, leads to calling a sleepable
> function from a atomic context. Fix this by allocating the temporary
> mask with GFP_ATOMIC flag.
>
> If there is a failure to allocate a mask, scheduler is going to observe
> that this CPU's topology is broken. Instead of having to speculate why
> the topology is broken, add a WARN_ON_ONCE.
>
> Fixes: 70a94089d7f7 ("powerpc/smp: Optimize update_coregroup_mask")
> Fixes: 3ab33d6dc3e9 ("powerpc/smp: Optimize update_mask_by_l2")
> Reported-by: Qian Cai <cai@redhat.com>
> Suggested-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Qian Cai <cai@redhat.com>
> ---
>  arch/powerpc/kernel/smp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 0dc1b85..1268558 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1264,7 +1264,8 @@ static bool update_mask_by_l2(int cpu)
>  		return false;
>  	}
>  
> -	alloc_cpumask_var_node(&mask, GFP_KERNEL, cpu_to_node(cpu));
> +	/* In CPU-hotplug path, hence use GFP_ATOMIC */
> +	WARN_ON_ONCE(!alloc_cpumask_var_node(&mask, GFP_ATOMIC, cpu_to_node(cpu)));

A failed memory allocation is not something that should trigger a WARN,
a pr_warn() maybe.

But ...

>  	cpumask_and(mask, cpu_online_mask, cpu_cpu_mask(cpu));

If the allocation failed this will oops (mask will be NULL).

cheers
