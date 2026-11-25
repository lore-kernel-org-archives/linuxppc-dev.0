Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFF606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAIg8GUf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHp436kVz2y7r;
	Wed, 25 Nov 2026 22:41:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795585847;
	cv=none; b=FBsDgCvc+9XxhyxeZ1+YCmsjddY8Dawqnysk7OVWJ8L+9ldx5TFmCANZMZWjbN04PJX/ond404k/Iks2Yy0xcgLVkMy2eEkhb82rQU20UVxJAbwK5b25d0ovhCyR5pFD9IcVRym9jTC6wi2WqZEhNqZTS8/tVGcOJ7NeBgJojTb0RguiTxWf0hdwxOsqSaiwJhSY+N98Jgql/xRvhtG7MYRaISjotIeG4voUc3A2jLmlyMQ6TXx0kZL99iV8saDmzJUstyR5e8J1mDdNJ7btolFS7KQCzgxIoiwVrBhaABnUJ1HvHWitiGCzMl7vKqzT9CdYGxlg3x39H9nsFEv/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795585847; c=relaxed/relaxed;
	bh=ROEbaJZgsjUR2jXRu+Oh+vuifiOcyZNOtowCB7+3Vv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWF/NGuaFvzcFkJgvvl0zEeYsO889tnqftS35ID1Sop6d9V/CqnARDJzc3ynS6v6fdC2EB4XEZ8ta1gQ9xmm5JdQWmfBUYrkFm2AMPYwV19gsfZCPPWhMSCLtD48uUkpRwPxoX0DLsrMgxXxJSEGRxVNJ2iwt3Q1yeYVHu6qUgvM7D3o4hUE091yDb4TyjgX9diozn8Nr2lFFEwHuJwo2cbj++M0mt9Erw7LpnrGQ42ZAxw5pdoz9aLqK9beegPVu3br90WfhLACJqnavnTK7VAsUfpNetVWPJbl+iaAYacoPhhl9Z+O8J+1HQjnkIULpy0Ng8bJKoyAzjz1uH5p6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAIg8GUf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAIg8GUf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ8115Kglz2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 16:50:45 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2f02ee04378so42468545ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 21:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795585842; x=1796190642; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROEbaJZgsjUR2jXRu+Oh+vuifiOcyZNOtowCB7+3Vv4=;
        b=GAIg8GUfEmWmM8Qm2jRTzv+U0HIEdCp01b/nlLDVP+viHGohITon67eBf75IOnwIGU
         YwU16ylLlvWWQLROhsAFHFlp7QT3/dsZshQ8JIOkmFzpWHTWCCxbrRYDLVLsUrnFcSNZ
         OJatA5y7fo1ILAvAoejG+aSQ9Ph+tT37IR3d9nYLplpEMNbRBdmLFs6Yx7B5D8ofjIaW
         G219wU+fCG381Dn5Ittl6/ntgSzkq6LwiHgzOJh1o2ep4L+etUGhOUbH0Xw4y+GtTdsg
         OitIZ4qKTnmoa7EsoQLDI2Bpi+JP1g5FbSbELSKoI69qeC7O+/mSIgwyoVs/eMAXZA6I
         2K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585842; x=1796190642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROEbaJZgsjUR2jXRu+Oh+vuifiOcyZNOtowCB7+3Vv4=;
        b=OPfZ7qim7C9OdFOdEIGtXW+AnpLYAVoFTvtNnqNe1Ta6T8eizNgTrBiIhpqIz2WKJs
         cvfUHj9K9nivPfykR4HVvMD5Rgn7Ro9cgA92qKRLFXA2KfjIM8+G3kXhe00bQ2F7dTW9
         UybCrMTrWpeaAlr01MQnHLYXRtbCb17uxP47yVZi9/tPMq3Km0sqoW/NuNknsHTUmftu
         Y8O7dK4WkTYNP+NU7uqXhzVs9gwflr6xbN6BlClUQelI1i3rlv8MuvoVVOV7wjdZ3HK0
         On5wIJpzSsqT+mVBkJYSm8UXcMYn85PBeYOlZ++NuqbmaJNN73aE+sQlIjW7LMPv7jh1
         rWEw==
X-Gm-Message-State: APuU4Z9BdaGmRQ5+0UeBGYfRSwn18RMHVjS+U8xmZJCljeyDS733e+dg
	+ByNMendSzIuxvYy+/yRKBNRpMVDQrBzy20t70rXMdqvVFktcVOjfILl
X-Gm-Gg: AZFdTZdpYvlcHm0g+j5kop4WGkdvpwrXlQ4cedMLyGMIi8tuMpRo5lCiuCWUPcXdsw7
	KX6PeqUZTiyR7u7OH8F9XFHHj1Q/aFDY1H017+gSRBbZ/WTzg2vsbWu2D5zC3APsmbkVA090kX+
	FWvS8/AwZfHS5JicbJ2K8rdpePS5XxKBD1eS5/zargoLtq7TQREn4Sdmyx5OFwjD5Uw8u/4pfUK
	pOqD+ku+cWmd2sSQf9JpWVcQ4l79lqgzmw5usewVDoM41xJjOMTkuMVM3rQZyyHw2KGyl38IJ42
	YMHUJrrokHDCMetnHbylOK32Y0hdca+aEd2cmdJdO36SCojeZTN93DCupU1vLnckCE1IYzZ5pPK
	CRdp+NzlRev60pqXmGhYn03BrnXD/1XaU9kus/MZL/jfnKvtyegHUVxnNgKyBVnCxA3hBdYvKZ3
	RUTl2lRs0gwW1EByKb1Mdl8vJ3YHg7mejVL96kHJc8DFIqYmMvB3x8cFijZUeWYfST0PTggruuB
	7Da9xIlvdLHafSD9qpiEfnF1TuRzUhm2f5v3FwInnmVPwLOafhQngC8AaoSlf/gq2xYnR0+bqBL
	NXUk7M3xEKh8RVd4dfFG8PP2I/c5zvfHB5INduozWzuylfTXEmw24FnMdmekcH9ju+2AOwk7nxl
	n
X-Received: by 2002:a17:902:db11:b0:2ef:eb06:387 with SMTP id d9443c01a7336-2f03f246dc5mr175431075ad.47.1795585842120;
        Tue, 24 Nov 2026 21:50:42 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm79569105ad.56.2026.11.24.21.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:50:41 -0800 (PST)
Date: Wed, 25 Nov 2026 11:20:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in
 arch_touch_nmi_watchdog()
Message-ID: <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
> touch_nmi_watchdog() can be called from preemptible context, e.g.
> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
> smp_processor_id(), so with DEBUG_PREEMPT we get:
> 
>   root@buildroot:/# echo w > /proc/sysrq-trigger
>   sysrq: Show Blocked State
>   BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>   caller is arch_touch_nmi_watchdog+0x3c/0xd4
>   CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>   Call Trace:
>    dump_stack_lvl+0x138/0x150 (unreliable)
>    check_preemption_disabled+0x120/0x158
>    arch_touch_nmi_watchdog+0x3c/0xd4
>    show_state_filter+0xf0/0x338
>    sysrq_handle_showstate_blocked+0x24/0x38
>    __handle_sysrq+0x134/0x3a8
>    write_sysrq_trigger+0x178/0x22c
>    proc_reg_write+0xf4/0x150
>    vfs_write+0xfc/0x71c
>    ksys_write+0x8c/0x150
>    system_call_exception+0x310/0x590
>    system_call_vectored_common+0x15c/0x2ec
>   ---- interrupt: 3000 at 0x7ffd01755b98
> 
> Unlike the generic version, which only sets a flag, we update the CPU's
> timebase stamp and its SMP watchdog pending bit, so a migration in
> between touches the state of a CPU we are no longer on.
> 
> Disable preemption across the update. While at it, let's also mark the
> function as notrace (since we might be within a tracer when this
> function gets called).
Do we need to also mark wd_smp_clear_cpu_pending as notrace?

Regards,
Mukesh
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Cc: stable@vger.kernel.org
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 44f178e07531..32d4e716cb0a 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  	return HRTIMER_RESTART;
>  }
>  
> -void arch_touch_nmi_watchdog(void)
> +notrace void arch_touch_nmi_watchdog(void)
>  {
>  	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
> -	int cpu = smp_processor_id();
> +	int cpu;
>  	u64 tb;
>  
> +	/* Callers may be preemptible. Stay on this CPU for the update. */
> +	guard(preempt_notrace)();
> +	cpu = raw_smp_processor_id();
> +
>  	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>  		return;
>  
> -- 
> 2.39.5
> 

