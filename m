Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F22606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnd/JZOt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZGZF2g5Sz2xjN;
	Wed, 25 Nov 2026 21:46:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795603589;
	cv=none; b=C7AXJlX92AIRFcVaiz1UOzrd+rqIG13czv65F4MwNVRbszd0xYQ7BCX/rYBGiBSViivvki5bwozMLEgVOqPiiQq6nAcinhn8r/XSp6yhYNUxP0IEdym586a9E2S45HrlLHkODqlAvjoesELR5zzc/50xGhPyQWgD/WYdXg8i7QOo4FEXCIumcX6BAPaTBNYvSGhhiWzTVrRoRgvyPuNIs3h3gWbGauVfr8lDkAupsxDpdH4CzGORulyJPL12HHkJABao+fE16wc0UZHYAGt+SZdpKZT8vkTDHnka/bkpjWod16IfOSkDaKQWcH8j+O6hzWHAHfJ4kAJ9HJUK8XAOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795603589; c=relaxed/relaxed;
	bh=75ck5Fj+CO5o/O7K369aVkulZ3SEZBEXUvPGoP4of14=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fmK99+fNAGuUJZAVGhW91UyZvhf1GX3XSR3/NaCzdJXNLIYMmuK8cD2ooFcZBI3m4X+6BriSVivrajAngz8KPxGj3xZuKtzW0htgCFifdVEhEcvQ+9xxI1PeKIXgxFsBXgfkm83CIaKvDitsRf0Y0M5FxZr4H7m5kubtsLktniXUZe0iWRn7lxOC4fplnQgjOgzIHP2EuRg6U7tCZdOoSfQ1Fq8f4cw5Ybrm4TLgzixFU9y4C4fsuGmtVl/6YYSI32a9nJHBeuxdtamN3OgO5O6LTGLY7ugKtD6kE8nIoAdWkhl5TXxC/bdAlzZpCLh2EmREX/PjJi5ZayGvNWyMnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnd/JZOt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnd/JZOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZGZC6nxYz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 21:46:26 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3698630c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795603584; x=1796208384; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=75ck5Fj+CO5o/O7K369aVkulZ3SEZBEXUvPGoP4of14=;
        b=Nnd/JZOtH3gfzbSoUWs03mkEv6tN+5cxvF8Zt2A8uqah2zWQ2asFyw8/qz9OKGqfVl
         X30iu1zk8tv2tkAr6XTCmULCRukXJuvBw8mTKJZ2BZuf3K0CMaSNF+3vf4VJ17fc/0Zz
         kYxWyRzpk3JCOZfp8pO50YfeG1Z1En9XOJFkLERqsNDkjw6ClHc18SPlq9M7oPflYuM/
         Af65chqYSNSQx/gD4KcI+a96bQOT13NbBACTxujUYys/SzPVj7OMo26L1KqdpqXCRwLQ
         e66o9rvkEQooZNGprsotgxEjEjzf8M4+0S3lZiT0X7kNCBSv0380VcOE7Go7/gS+nv2x
         mXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603584; x=1796208384;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75ck5Fj+CO5o/O7K369aVkulZ3SEZBEXUvPGoP4of14=;
        b=BIeHmM0NwzvrzOFAeQo5/TacaGejRm8SkwAWXErYvCZs/jjCDvLAhy1LgdO9zFYaCf
         I74BYjsx5y/jNwtc5lzy9Fv7fiC917GCR1eMUoiJjiXcuyQ/P+iILYqZHOVa7EID+9ab
         UKLghwu5G44yk6QMCbyNhHhi1skfW36tVvxBkrsS9jcMVxHGgTrfk1qB7J/4b9DyZc9+
         R5r5loXhs3yJ/xutiimBRbtBgOHVrPjqUIZIw4cYr2qKVTSbOLxbCSzWZQagP38RsG5p
         oRBizNwBm1HPPaHgdT8UErTrw9ezy7Av3TSsgTLcxdizdW4WMz2yeXcZL/WYNol5e85b
         1Ztg==
X-Gm-Message-State: APuU4Z+NIZBoIFXBl52++MWv3rtzNxWHVCh/2yorkVYAHCyh4YcRUf7I
	uBL2EeeKvzgSRR0Es+6WJyFNnr4EvJUkdYS1is13nK2n6aCmSSNv1Y2t
X-Gm-Gg: AZFdTZfjexrVZlUjL3uRjP5yGTsMUOQa8KWSVPlSSD8kaZDf45XxLmoGDifquGUntEE
	e3yjA/fjTr48xsZjMZsAspHALpxreg3e6ToeeEhFdrOF1L4gTb4rjfbUFweqgMcPHjJEC9CFsta
	xdpwln8mLNGATCv6i/87REGII2Il4PIcNTOGbsu3gnrdGDRmOEtuu4yp0q2uQIsp/imuut1T60m
	U6HiGXNJY1CEgHS9YSLdvgKFrK01b4dReojq/FaRXc344ct19lYs2F70XXpWaq47POtLBcg7T1z
	IgAoOWMp4M9lUVVrlCf26IAXGsyCaS/OQEPrnyKfLHy6N8EAv8KicyEAhj3HjySLPABjpurm9Qx
	/5M3NOi7A/DbkYPmanyClWbGKo66lKe2NAiDjJdkHn6xLIIZILZ5nqmjykQ8BM3tzl3//WO1BWt
	ryagZfcg03JYk6ZTC7Jdv1UK0A/ifkKsory+4+92TEEZTRlQ1CfIjMP7x58jciJUjoIGGy94XDc
	6NMHk020hlqePvCMmXlsrcNSmfGu5t7ofJ3NiORz3/uytzSVxlQw0b5qLZ++RAw6Uw2hteSNuKE
	z2HR/4wcrAi3CH8Dz7ELbuRyH2k=
X-Received: by 2002:a05:7022:1711:b0:1b3:aee5:20c5 with SMTP id a92af1059eb24-1b5568ac791mr15438030c88.22.1795603584073;
        Wed, 25 Nov 2026 02:46:24 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm40526601c88.15.2026.11.25.02.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:46:23 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
In-Reply-To: <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Date: Wed, 25 Nov 2026 15:28:46 +0530
Message-ID: <o6bdjkq1.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com> <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>

Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:

> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>> 
>>   root@buildroot:/# echo w > /proc/sysrq-trigger
>>   sysrq: Show Blocked State
>>   BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>   caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>   CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>   Call Trace:
>>    dump_stack_lvl+0x138/0x150 (unreliable)
>>    check_preemption_disabled+0x120/0x158
>>    arch_touch_nmi_watchdog+0x3c/0xd4
>>    show_state_filter+0xf0/0x338
>>    sysrq_handle_showstate_blocked+0x24/0x38
>>    __handle_sysrq+0x134/0x3a8
>>    write_sysrq_trigger+0x178/0x22c
>>    proc_reg_write+0xf4/0x150
>>    vfs_write+0xfc/0x71c
>>    ksys_write+0x8c/0x150
>>    system_call_exception+0x310/0x590
>>    system_call_vectored_common+0x15c/0x2ec
>>   ---- interrupt: 3000 at 0x7ffd01755b98
>> 
>> Unlike the generic version, which only sets a flag, we update the CPU's
>> timebase stamp and its SMP watchdog pending bit, so a migration in
>> between touches the state of a CPU we are no longer on.
>> 
>> Disable preemption across the update. While at it, let's also mark the
>> function as notrace (since we might be within a tracer when this
>> function gets called).
> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>

aah yes, I didn't see that there is another function which is not
inlined. Thanks for spotting that. The reason I added "notrace" was
mainly to have consistency with kernel/watchdog.c which is due to this
commit:

cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")


However, after looking more closely now, I don't think we need notrace
here at all. To simply put, on powerpc, we don't use stop_machine() from
within arch_ftrace_update_code() like how arch/arm does and besides, I
think it is even safe for one cpu to be executing the instruction on
powerpc, while another cpu modifying that atomically.

For e.g. see this -

commit ee456bb346e75a9b6d941224b108250e6ee5f79f
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Thu Apr 26 08:31:17 2012 +0000

    powerpc/ftrace: Have PPC skip updating with stop_machine()
    
    PowerPC does not have the synchronization issues that x86 has with
    modifying code on one CPU while another CPU is executing it.
    The other CPU will either see the old or new code without any
    issues, unlike x86 which may issue a GPF.
    
    Instead of calling the heavy stop_machine, just update the code.
 

And as I see it, this problem only exists on ARM with THUMB2
instruction, as can be seen from their implementation of
arch_ftrace_update_code(), which uses stop_machine().


So, let me drop the "notrace" as it is not really needed here and
re-spin a v4 with it being dropped.

-ritesh

>> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  arch/powerpc/kernel/watchdog.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>> index 44f178e07531..32d4e716cb0a 100644
>> --- a/arch/powerpc/kernel/watchdog.c
>> +++ b/arch/powerpc/kernel/watchdog.c
>> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>  	return HRTIMER_RESTART;
>>  }
>>  
>> -void arch_touch_nmi_watchdog(void)
>> +notrace void arch_touch_nmi_watchdog(void)
>>  {
>>  	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
>> -	int cpu = smp_processor_id();
>> +	int cpu;
>>  	u64 tb;
>>  
>> +	/* Callers may be preemptible. Stay on this CPU for the update. */
>> +	guard(preempt_notrace)();
>> +	cpu = raw_smp_processor_id();
>> +
>>  	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>>  		return;
>>  
>> -- 
>> 2.39.5
>> 

