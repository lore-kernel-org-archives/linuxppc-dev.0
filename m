Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789D0606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yk9ziAr5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHmP67VXz2xjN;
	Wed, 25 Nov 2026 22:40:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795583980;
	cv=none; b=DittH2RqmhIgU5wO1FqTRueYTwsT0ForlDIjWGInnxTTv0msAv2G9HZ4W1ytAul0Qd+BmOERTEd5oTvMseAg46yXHT+VHZG0e/OgFIJw8Kuf7NDOMf7D3ap5+TeM+Az9RykijdpsFRqMehXF9rOscH7FJg257kFLDxzL2lTje5pMDnmGWGOoP/R0L1POrMXXg6cNAB4qOu9FEFzt/2aq48mt9gc4hiHDlHh5u1sq9NtFGKySaGOu6t5BrNuTiIZGcSvt4zMXtQ/ZWwNQ+78cR1Zsa9UfJgJ4t7xsIP67fSFjD4vUoYs9/MDgh+7GaAVGCxRarrDdYG5OjePVIKttHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795583980; c=relaxed/relaxed;
	bh=++Apgl37kjRYqQpIi3d+LCDkwVVawhVRcSfP5lZmBu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYoRw/0XP02LUTzkynkNLPSjjjVoBaQ/65Y4xG6FuJ33L9ek3vGbjDamVM5A+aqiHZ82aBEvRmH9tKT18JbrzptJhk5ZSn7AsZMZEkn3rHUkNbv/jNwqhEaPaX2Wxq2sCG1JRq/87hM8j9wq3kqqzsTfh2f1uZ4rLbxkFsiRgaNijUQPcNeTBOs3fW1zvGcEEVd170vr2clr40yR7LoZSHViHIdwi1HcQLW0Gu0VnXmE/2kjcwE1B6pDvc2XTMAb/HHSgSGaTeYEBxb6u5wMYO1zZLFYEr5WoUXrtRQ+h9Y7qdUlBvlAcmTVMpoEWdxRD29d5/rPr2X2m3KGl+wE4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yk9ziAr5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yk9ziAr5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ7K71FJ3z2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 16:19:38 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so2784431a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 21:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795583976; x=1796188776; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++Apgl37kjRYqQpIi3d+LCDkwVVawhVRcSfP5lZmBu4=;
        b=yk9ziAr5VqmVd61njybIWt+HIXT315ruSih5VUakxTReUIQrEUgzaeQjYRKGh7PYkp
         tR0QhVwEIK29vZH70uSTuzCL+VT8A09sdlo8jfM5fxfifJ2IvkHDu+9a8/d+jD/nHvsF
         ebb73JwmhZB9fgZYSIIoDbis5zGaqy8YrGgx2vylEu8EDC1lyJG4mqQeHQctIrAXdDLa
         WTh1zmWayUXNB5dxLUmj2vDuR4O4JLI0irdVGYwMINvZzFMzM7qZ4HhxNHwk/lGnHPiH
         +8Lp2ykFOASDUhzM019mT4tu+IY/McAwKJ9a8QC9NTTYdXTGHUcs90VdbKgfWgwAxjNR
         Pthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795583976; x=1796188776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++Apgl37kjRYqQpIi3d+LCDkwVVawhVRcSfP5lZmBu4=;
        b=VxAuT2I1++VycK9Pzaa3D+scnIrYvtx+oyRrRR+XQrJfgFUnH8XfOL/40EtKJtGX7l
         /i2RJKSJPJ9h2ITh5PgXtWFdDJxFXyITmEA8Nj6+5SQaivElVaJP+uHsd9Y5zyVz3aOB
         b2aCqKE1BrKF6hbVVqHwyjnR8ItgMzplLo+Gdt9LqIVv7kAowuGmb0tynypY6oxsCuoW
         fp2PmOkhVr7nuviEHR+dtkZXUYTD1TIl3pWrk0o+5YLye8qDu7eAg86vVj9WWRUQqi2m
         UyYKNW+j0rcr/lSbvPUGn4IYSdrqiE5SJUYwYydHx0xDovRvGf7z16nT9hF7qO+1Gzbv
         AW4Q==
X-Gm-Message-State: APuU4Z9VePL+JyCDCGIzL2k/2ccNk1HLkQ4wPjaLfQbU6JBy6ObbCn16
	xbXvrrlf5fauRX183s2ERBNxzEB4oSXgT7VmMvwkwnFIKCGPWjdhVBuy
X-Gm-Gg: AZFdTZdYVgfPHRD+8vnFqlvaO+3tt9343zahWY/Mv/wmA0gk89L5A9W3DCfzAwJupPA
	D0XXsshRKgzSoO/cRCnUCvsOLCFdvNUp6nphvaZ8fIFV8nSl0eSrNOp11LTTlBeZh3Oubb2/FXi
	VZi8Y47/WgX4v6xvhiMLWiVSnvr90Hx8mWiJufDdIDBRSv+evjX5Me+rAI1HyWWfe2EY1ZJ7owm
	AX5QjL2ZqN/cTBwCyfvtMbVWyeTAouWew6EKNoHntGGoc5HoWz2HkMGcGht865mSizlVUkWIAhZ
	f6jCaJyK03SGPYiZxtxPPnq0SeSfTxhK0sjCNniaR3NG4TFsfAz2zwRVD04q6varaDeVVilSzFP
	cbeoqkewo/TmltYrDjDRIBsWIRLqvfHEauxP9haJOLtfGlTi0Z0rY9ICDk+mxPYgXeUO6cv6YEX
	SvAQ9z9Z3tXIAodit2HN9ufa15I8Th5axKbsv9slUaZCHYuM6017vq4Rje9EPIqp12gNSM7o/pL
	s4bNIjuO423RZIW3m0hyE6Dqg2sRA8zP6oExinu5NIGwadGW5eJdd37DM2wTOwohIp6WJIRDM0A
	IFlo2PCyHVKwYiE7uFsiWbOW50wPryv9C99E80LhEQ1/NVqNIaw78pjagNPpQBOjA3i0uANhu8U
	t
X-Received: by 2002:a17:90b:288e:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3b41c9cf219mr14157411a91.26.1795583976121;
        Tue, 24 Nov 2026 21:19:36 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm10183348a91.10.2026.11.24.21.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:19:35 -0800 (PST)
Date: Wed, 25 Nov 2026 10:49:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
Message-ID: <awZuo3adxt0d77KH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <57a5455331a768ffe7d66409ea228d31e9ec1edd.1795441238.git.ritesh.list@gmail.com>
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
In-Reply-To: <57a5455331a768ffe7d66409ea228d31e9ec1edd.1795441238.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:21:50PM +0530, Ritesh Harjani (IBM) wrote:
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>   DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>   WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
>   NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
>   REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
>   MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
>   NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
>   LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
>   Call Trace:
>     lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
>     trace_hardirqs_on+0x98/0x11c
>     irqentry_exit+0x64c/0x1064
>     timer_interrupt+0x274/0x6bc
>     __replay_soft_interrupts+0x158/0x380
>     arch_local_irq_restore+0x1cc/0x244
>     console_flush_one_record+0x438/0x654
>     console_unlock+0xb8/0x1e0
>     vprintk_emit+0x300/0x56c
>     vprintk+0x20/0x34
>     _printk+0x40/0x54
>     lockdep_init+0xdc/0x104
> 
> The warning is triggered because trace_hardirqs_on() gets called while
> lockdep's hardirq_context still says we are handling an interrupt. To
> fix that, we need to ensure lockdep's hardirq_context and
> hardirqs_enabled state stays consistent with powerpc's soft-masked
> interrupt replay code and the generic entry/exit code.
> 
> With the current change, this is how the new state machine looks like:
>                                        hardirq_context  hardirqs_enabled
>   arch_local_irq_restore()
>     trace_hardirqs_off()                     0             1 -> 0
>     irq_enter()                           0 -> 1           0          (softirqs held off)
>     __replay_soft_interrupts()
>       lockdep_hardirq_exit()              1 -> 0           0          patch: the loop is not a handler
Yeah this makes sense to have it here.
>       timer_interrupt(&regs)
>         irq_enter_rcu()                   0 -> 1           0          handler starts
>         irq_exit_rcu()                    1 -> 0           0          handler done
>         irqentry_exit()
>           trace_hardirqs_on()                0             0 -> 1     legal: context is 0
>       next_interrupt()
>         trace_hardirqs_off()                 0             1 -> 0     still replaying: back to off
>       ...                                 same for each pending interrupt
>       lockdep_hardirq_enter()             0 -> 1           0          patch: restore for the caller
>     irq_exit()                            1 -> 0           0          softirqs may run now
>     trace_hardirqs_on()                      0             0 -> 1     IRQs really enabled
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/irq_64.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> index d5c48d1b0a31..e2f1e5b7a3a7 100644
> --- a/arch/powerpc/kernel/irq_64.c
> +++ b/arch/powerpc/kernel/irq_64.c
> @@ -76,13 +76,11 @@ static inline void next_interrupt(struct pt_regs *regs)
>  	}
> 
>  	/*
> -	 * We are responding to the next interrupt, so interrupt-off
> -	 * latencies should be reset here.
> +	 * We are responding to the next interrupt. The irqentry_exit() of the
> +	 * replayed handler has traced hardirqs on, which also reset the
> +	 * interrupt-off latencies. Trace them off again.
>  	 */
> -	lockdep_hardirq_exit();
> -	trace_hardirqs_on();
>  	trace_hardirqs_off();
> -	lockdep_hardirq_enter();
>  }
> 
>  static inline bool irq_happened_test_and_clear(u8 irq)
> @@ -116,6 +114,15 @@ static __no_kcsan void __replay_soft_interrupts(void)
>  	 */
>  	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
> 
> +	/*
> +	 * The irq_enter() of our callers is there to hold off softirqs. Each
> +	 * replayed handler enters and leaves the hardirq context itself and
> +	 * returns through irqentry_exit(), which again traces hardirqs on.
> +	 * Since lockdep only allows that outside of hardirq context, so leave
> +	 * it for the duration of the replay.
> +	 */
> +	lockdep_hardirq_exit();
> +
>  	ppc_save_regs(&regs);
>  	regs.softe = IRQS_ENABLED;
>  	regs.msr |= MSR_EE;
> @@ -168,6 +175,8 @@ static __no_kcsan void __replay_soft_interrupts(void)
>  		next_interrupt(&regs);
>  	}
> 
> +	lockdep_hardirq_enter();
> +
>  	local_paca->irq_happened &= ~PACA_IRQ_REPLAYING;
>  }
> 
> --
> 2.39.5
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

