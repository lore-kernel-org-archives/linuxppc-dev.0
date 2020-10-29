Return-Path: <SRS0=8b8/=EE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED9DC4363A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 00:10:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C915C2072C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 00:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="W64neonP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C915C2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CM5SY5SwYzDqYh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:10:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CM5Qg5XrGzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2020 11:09:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=W64neonP; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CM5Qb3mqVz9sSP;
 Thu, 29 Oct 2020 11:09:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1603930155;
 bh=+IS+oS9wdMYaY7BSv2eRj1FRyLpkX+Kkw+ofCEwFGdM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=W64neonPs5X8EQtVcfwGj7Ov10Oyqi5FxJ9MxFxGHUq5rL/qlyW2uCDK+XbIp9Ece
 UszKhFGAXmtuZCVHUkQ7TKyddpVcKP6Bjtk3EjsWcofBx/GJ2JSFIakN10XChtL5Zk
 k3ytx6LIrwXN8RZow6WNQiOq5E1E2/bdqcGCFsSSXvDF2WjIxBSqkvTyMIzlBHGKXT
 OE6IItGAB0gGTD5jk0oS0UAdq8zgBhNbIcDnUVuEdizVNin4tIrAdFEcxwXhkmqpf6
 yypk4g3by3TQX85yG12+a4MJ+LrvI6bCpysEcvpJ4sLOrCtGtl06FiXewq9yDXeObW
 Sz8kZ7/cJMBog==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qian Cai <cai@redhat.com>, "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
In-Reply-To: <20201028182334.13466-1-cai@redhat.com>
References: <20201028182334.13466-1-cai@redhat.com>
Date: Thu, 29 Oct 2020 11:09:07 +1100
Message-ID: <87lffpx598.fsf@mpe.ellerman.id.au>
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
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Qian Cai <cai@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qian Cai <cai@redhat.com> writes:
> The call to rcu_cpu_starting() in start_secondary() is not early enough
> in the CPU-hotplug onlining process, which results in lockdep splats as
> follows:

Since when?
What kernel version?

I haven't seen this running CPU hotplug tests with PROVE_LOCKING=y on
v5.10-rc1. Am I missing a CONFIG?

cheers


>  WARNING: suspicious RCU usage
>  -----------------------------
>  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
>
>  other info that might help us debug this:
>
>  RCU used illegally from offline CPU!
>  rcu_scheduler_active = 1, debug_locks = 1
>  no locks held by swapper/1/0.
>
>  Call Trace:
>  dump_stack+0xec/0x144 (unreliable)
>  lockdep_rcu_suspicious+0x128/0x14c
>  __lock_acquire+0x1060/0x1c60
>  lock_acquire+0x140/0x5f0
>  _raw_spin_lock_irqsave+0x64/0xb0
>  clockevents_register_device+0x74/0x270
>  register_decrementer_clockevent+0x94/0x110
>  start_secondary+0x134/0x800
>  start_secondary_prolog+0x10/0x14
>
> This is avoided by moving the call to rcu_cpu_starting up near the
> beginning of the start_secondary() function. Note that the
> raw_smp_processor_id() is required in order to avoid calling into
> lockdep before RCU has declared the CPU to be watched for readers.
>
> Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> Signed-off-by: Qian Cai <cai@redhat.com>
> ---
>  arch/powerpc/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3c6b9822f978..8c2857cbd960 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1393,13 +1393,14 @@ static void add_cpu_to_masks(int cpu)
>  /* Activate a secondary processor. */
>  void start_secondary(void *unused)
>  {
> -	unsigned int cpu = smp_processor_id();
> +	unsigned int cpu = raw_smp_processor_id();
>  
>  	mmgrab(&init_mm);
>  	current->active_mm = &init_mm;
>  
>  	smp_store_cpu_info(cpu);
>  	set_dec(tb_ticks_per_jiffy);
> +	rcu_cpu_starting(cpu);
>  	preempt_disable();
>  	cpu_callin_map[cpu] = 1;
>  
> -- 
> 2.28.0
