Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB6606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVMT68rR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZmf933CJz2yDc;
	Thu, 26 Nov 2026 17:21:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795674097;
	cv=none; b=FAv51DLB4Op3flMnb0D5n+Eo7UnHunGm3Tt2pF2hoy5F7YrqgMfGFAD4pK9/0D7VbsBDfRDav5G5bjNsomISqoHxgN+ldZxuzSrjdmxdIvhgh2EoY+uSSloCxlOW6/GXMFVnzQLNXX2/7Z+HyvwtcgfHlVNmrjOy6bPoAmDsYvwTUM/LzCaDmzLRhpQQrH+2aW2g2n9SxvQ2I+TNxCro/7xgP/guCWUP3EBm9jbvY6Gvn/5I3GaQ5SwcZlN/PDqo2e4lcLeMkMK74KluWbwCugQd7HXdIVl1RDbTruJPXfhkT4ccW7iPFAMoRNlLx4lzmLnw+UGnKxBaxEMoYjV9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795674097; c=relaxed/relaxed;
	bh=Q0z4xv3EWmhQDyAjFR8MKUlXt4SG+L1ZlVS7DWBq2yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDItCr8WeXMopmAXLkzFsZGfu6lf0o/Wgq+xZe+lUJsTTWeeQl0UUnlfocgFkprUla05ZX6xvkstpdDfaSNBsk2FKJHxTnAZAq0vkhFfeEjZINeYw4N7Zajus7GaR5UZEEMOo9xdbV7jAwbdTqG5blt82S1NCFTz3kSIuVQXiGlENMmq4NVw/wGk+sqhFDlT4gJWKEUFth2UPVEer4ndzfQ38zdDS3gUA84SOBir821edMe2VwQJgrK88KOS3rVRiGDebHh5SY7ft7CwRGe+luJf52C+HfKRY1DvmtjPVexmlIor/PeW0HP315vGVsQIQZVlyeB/Yyo0/m+FTDA6yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVMT68rR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVMT68rR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZmf81Y8Xz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 17:21:35 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2f03f3631b2so35899055ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795674092; x=1796278892; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0z4xv3EWmhQDyAjFR8MKUlXt4SG+L1ZlVS7DWBq2yQ=;
        b=WVMT68rR8LA4vM9HTcaKLx8gvApDPZeWwp0syd9x45AYGcEgssP7LFv5ot5HHY2qkf
         yZ14Sdko09arLeqOGXZ3bkGc7ZPxlKMNI3f98dMYkbDuosQtA1Y4GJitPr0RkyrLIHTu
         a3bOcW6M2DfZU0ujtHguzk5yPTD+VIxtHK+nJYGYKE2EphCAbtTyXGXT3f2jgEf0t1F9
         h9wal9yKwnaCPB2w86F2i13N0ZxEbZmVguBnuEvvn6u6Px1ZoTnNqd01RzMXEVw7+Q5i
         8R2/YbPT7jQCDqzd7qqLb/a8YFg20u5vcSfkEmQvxY4brLEpNEnRNdyWTKMrVDjc2uGP
         8aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674092; x=1796278892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0z4xv3EWmhQDyAjFR8MKUlXt4SG+L1ZlVS7DWBq2yQ=;
        b=xp9TE8VEEPXB+4ZxuNF5jajMr8vee/GJwV+Aw50DASB0yiUpbft+R1snxkiKMz6Sm+
         VQSroPcTwP+GZ8YBogbw/qJNXP/SZUFfe2+Wv9+OUchcm6C/td4nYsCQK1GttrxCFs2b
         RHQNcUlGoNljC2SC7Vh9WsrfShqpXtf6RTZFe6+t/IYXfsHzN+dEsAaeHfRN/naqpxrq
         wdjaezXMTZUDTXX/uVnLqFPFZc7jBOd2BeY+vP7OsKP1hOzhre09pO60nSf+9fwLydnF
         u6HnlOhK2fd6KsocyxRiUrcRnsfhF3w//o8Ov8uD+3obHe7E3lHXD4X3HrLLJH58+3fW
         5u7g==
X-Gm-Message-State: APuU4Z8lifIcBHRg9XS+1WR3OKxXUTA5b3Ih7gU5TWGkOSN0oO1726Gc
	OxgXP7uwNm+dC4zgA4tNXJCm/ouC/TpqxmX+ZW5Q5rabgbIwXD5lIKxQ
X-Gm-Gg: AZFdTZc54XKtTFVPmxm8MN8sVidyN98yBm3+VOnLm2I6fkb81naIoDKfIGYn0D7dxCf
	Cergpmu/NY47JadER2gWfd4uRRW+jntQrEcAczga1OWtA19sJpgmr4BUoc7EMMmtAETFFM+MUyg
	HTk0qvWigtwVbf0IAgIyFhp+/XjKTlUXrJYSh0qbjfXC+xfKk2VEcM7W599vb70pNKDiJppCM1T
	jD4t7O3mSDbZ7XYC6gj6EY65cL3Am23TSwzyN5BrkW5mi5zdhbs+3W5IABrUUu22yZRWMrBzY0P
	r6J7Yag17v0n0Fb7dEExLG+D9iZJ+SCIFtE4GP0GD6F5MCosTfF8DkYHFCzMljflCN14nuv8RzI
	HAjAH26ELIo3nNiFzq6qayyzKuflgVXTQdRrMNtusk2i9euO63UGjfcOySGZtSSb4Fdwf2SAt6R
	Anm9JptjONYsVV5Uyv984WiRcI6RVDc/c8Iy+yUN7VVbZTkliyExYSDNZmUuuvMUw++shL4/r/B
	oF41v1Qo5MootM7G3YVyVyA1jk1cZgC60rj7FwvF5itRpqAcqiIHpYUKwr9JtML2fiQg+SJViqY
	b7IuctZYwliGQaU1HsmGjxDCJ+oN/HOu/9POOMvhv/TQ1ksjoqEZeb+jsmdWVJN4hV7zDDvuHHB
	r
X-Received: by 2002:a17:903:230a:b0:2ed:fd0:e736 with SMTP id d9443c01a7336-2f03f0c1ef9mr187752545ad.6.1795674091848;
        Wed, 25 Nov 2026 22:21:31 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.50.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm98712685ad.57.2026.11.25.22.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:21:31 -0800 (PST)
Date: Thu, 26 Nov 2026 11:51:25 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
Message-ID: <awfPsq2b__or0k74@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
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
In-Reply-To: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 04:56:03PM +0530, Ritesh Harjani (IBM) wrote:
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
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/
> Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linutronix.de/
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

Tested this with multiple rand config and fedora distro config. No
splats are seen now.


Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

