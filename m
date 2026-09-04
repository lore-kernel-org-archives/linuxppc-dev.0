Return-Path: <linuxppc-dev+bounces-26584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D2AC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:06:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNBy2NNPz2y22;
	Sat, 05 Sep 2026 16:06:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788513102;
	cv=none; b=di6KKpFwovp8UN0htgRWjOzKLXM93Fhs4wJV7TDTOj9UsdbtDsh1/BYqcoAyNSVk2kkxYFKXHgkPw+714b6XFwoyLe+jtz6XW4xrB4M4lhkQrFwZN+5TNkg+goDKUDg5CGnAIZTPYSSgSv75PjY95CcklLGEspRnXUKy+rMtiEYNccVTQdnZyGmhZ415NhSSIF5Snxmyd5sBwSiyecNSG2bHMKXfgqCs4BsNSm2gkTTg0ntwY7scH6r7qcqsdIBBNUYo/YVLHEZynwF2CDF3U0Ed8JNIEwH9TcVZW0LXOKtYPI94FJqu5VZzytRVjL2jUlG3bAukOVyzmOPiR52HKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788513102; c=relaxed/relaxed;
	bh=bpLVtcxeLSgcfCU3L42j1VklWUvMTxW7/92G4rpbZfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLdqQr6tzpih8Qy2uN82SbT4eRtEU4pJGEXKiRaVvch9EMOeEZjsqZWzMZIZ8fNC6JUtQ1ZHi3in0+Dbn5SIZDUk/X66pY1QnKNbwgb6na+s+DyUKOA7fxAMMEjpgP8sdTiSLC4Dzj5oX+oOthkFBtibSYK5qoK7f/QR6YId/+qg/8yPjCnWcrYmBhYhglVS5wGQUfktuWtCMJJ5owO1iwRaXwPLJgFMZdXyDCxTEISoD2QCHuR+W17noK30k3ylnF3Npumjfw0wkDt/6aP1k2hjiiGCptMiKKM5hXaQTnaQLTJtUXFXfMbGgCV80fB8UWrAum/UuvsYpf2DasACiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cg9bJGWw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cg9bJGWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrLj3n2mz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:11:41 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso729730b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788513099; x=1789117899; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bpLVtcxeLSgcfCU3L42j1VklWUvMTxW7/92G4rpbZfI=;
        b=cg9bJGWwV0KHSEOBHpXz+w0TC20qrH42obXO77qeuYs6TObb8WFQUmHo5dTX5HA+dR
         3ZirUPzDsOb92/5ErJLQuCXopw/h6kLni5fDL0zZwHphF1fkjy4WJRzc4qIZ9VyCLfGQ
         88t28t5plNUKiqZmn1jGKUOipR2UwFIHjEswjWpdrPGrXK/AS+z5gL57qy1C1iKd7rSm
         aW0Q60lw39fOJC7OVaxc8m6lKYl2dxeGpZQ3A2RsXSagIqY4oCgVSmSjyWQvThaElpHm
         ty74tVrc23X2nlZaUaqtZccNdQCc/FAh8hLgQQKGahqCWJEniR1NqGiF2gMc1l1KajQi
         k94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513099; x=1789117899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpLVtcxeLSgcfCU3L42j1VklWUvMTxW7/92G4rpbZfI=;
        b=rvzad5J2jUM9Fm+d7lISatD+CGXHy0UcXW50jg+JQAF6x2HDiPneuUsAUlYO01n+bo
         /C5U422dGxycko7YvlyjKmDPX05FWvbbEB394LvDoL6F5fFjG4U3EvgqolOgNDuh8ZG8
         tFWDKCNBYlhBKBIGI0uXzm8yPPtALOeXIYLP6yBjOuwh/OhPfVx1S/nKXExA5vbYFP4G
         dx9OESNDpP972GBro0sw//9luns93uOIDLSm4UVO6R7fIyhMbs3vznSXM60IIrpc4EUN
         KGZQDKkMVSElewK0BW6VOFEE0i/FL4u9+y0VrRyB+gVz0I6satlQomI6zlbpatVeEbcp
         HPzw==
X-Forwarded-Encrypted: i=1; AKwUvBwpAKBo973IZWkWuLJU+HkV8UlFosrxWIdxRsDbe40eZYXWSlHBh+M1roTM+OPCQwGGIdXErvQfIM9yJhc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nto35l3+6mtzj3vh8mjtuZ3cWb7ZW7aTVcavIGELC4XKnnOYRJ
	D1x7dxXCPFXI+kY621jgg5TX5LGN5HQu1PuqTUCEwQYapJTnutel23YA
X-Gm-Gg: AYBFou2ekUoG375m6RLJm706tKlwpMDZLo6mmhm1loJUNs35QAcevefzbkpuJ4ukVyo
	5lVJHhOCbYJ0W9tLMi7VhJRC2/q7k2lfrHvYLF2ahjzOPM0KhhdHMA3+fcBgAyF2QQGTG0zVexQ
	QJ8s4jUZabO+oqLg+q+G6MSZ1EFtnGjM4k9HVhnj+QhvgHGyrykuwTB55ZfvOOdpYgGeU4sWrar
	Vw25UB2MxfXTcd1JseSwJTIw7YTnUfb3Jj2QfuSbMlbs8I5bEOvmGX3yS1hTFb3ZM3OEgJvJ46B
	omPwdQuxvJloilq6i7QdUm/X+/HHYZvrB/MHgJNIHuqXxlAAvQNFaufvp5cYhzU0lI/Kg2/kIKB
	I+JQAIslu3aARFCfFdqSCMIimCnQVar0+lTciIQq10zMoWA0Vcll4yMQVavfjqXyBqii02ZlJ/4
	wAqnJ1rQJQEQUN1LjcaVhQGxj0Z2w6Gj1J5Gu1B31DFaznUeUsHxX2dWVd+SiOqLSNP3rUZlRq+
	G+dpf7FpfrKm7vLOsS/Dd5Qbf4bkQfRGLOnDJaF5Y1FnFA=
X-Received: by 2002:a05:6a00:2d0c:b0:857:72ba:ff0d with SMTP id d2e1a72fcca58-8616af5cf97mr6704891b3a.21.1788513099219;
        Fri, 04 Sep 2026 02:11:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.52.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153027951sm913106b3a.40.2026.09.04.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:11:38 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:41:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	ritesh.list@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V3] powerpc/entry: Fix irq_soft_mask corruption on
 replayed interrupt exit
Message-ID: <apqLMmLNnhSQZz0g@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260904090858.128563-1-mkchauras@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904090858.128563-1-mkchauras@gmail.com>

On Fri, Sep 04, 2026 at 02:38:58PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> When __replay_soft_interrupts() replays a pending interrupt (e.g.
> PACA_IRQ_DEC -> timer_interrupt), it calls the handler directly with a
> synthetic pt_regs. The DEFINE_INTERRUPT_HANDLER_ASYNC wrapper around
> each handler calls arch_interrupt_async_exit_prepare() on the way out,
> which calls arch_interrupt_exit_prepare() -> local_irq_disable() ->
> arch_local_irq_disable(), which does:
> 
>     irq_soft_mask_set(IRQS_DISABLED)   /* 0x1 */
> 
> This unconditionally overwrites irq_soft_mask with IRQS_DISABLED (0x1),
> stripping the IRQS_PMI_DISABLED (0x2) bit. The result is that
> irq_soft_mask is 0x1 instead of IRQS_ALL_DISABLED (0x3) when the
> handler returns to __replay_soft_interrupts().
> 
> For a normally-taken interrupt this is harmless: the next interrupt
> always enters through arch_interrupt_enter_prepare() which
> unconditionally sets irq_soft_mask to IRQS_ALL_DISABLED. But during
> replay, next_interrupt() is called directly between replayed handlers
> without going back through arch_interrupt_enter_prepare(), so the
> stripped bit is never restored. next_interrupt() then fires a WARNING:
> 
>     WARNING: arch/powerpc/kernel/irq_64.c:75
>     WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED)
> 
> The warning was observed early in boot on a POWER10 pseries guest
> during kmem_cache_init_late(), where a spinlock release triggers
> interrupt replay that processes a pending timer interrupt.
> 
> Debugger state confirming the bug:
>   Before timer_interrupt(&regs):
>     irq_soft_mask = 0x3 (IRQS_ALL_DISABLED)   correct
>     irq_happened  = 0x41 (HARD_DIS|REPLAYING)  correct
>   After timer_interrupt(&regs) returns:
>     irq_soft_mask = 0x1 (IRQS_DISABLED)        WRONG - PMI bit stripped
>     irq_happened  = 0x41                        unchanged
> 
> The fix is to replace local_irq_disable() with hard_irq_disable().
> 
> hard_irq_disable() is the right primitive here for two reasons:
> 
> 1. On PPC64 (hw_irq.h:301) it calls irq_soft_mask_set_return(IRQS_ALL_DISABLED),
>    setting the soft mask to 0x3 (both IRQS_DISABLED and IRQS_PMI_DISABLED),
>    which preserves the PMI bit and fixes the WARNING. The additional
>    work it does (__hard_irq_disable(), PACA_IRQ_HARD_DIS |=) is
>    redundant but safe since both are already set at this point in the
>    exit path; the trace_hardirqs_off() inside is guarded by
>    if (!arch_irqs_disabled_flags(flags)) so it will not double-fire.
> 
> 2. On PPC32 (hw_irq.h:467) hard_irq_disable() maps to
>    arch_local_irq_disable() -> __hard_irq_disable(), which clears
>    MSR[EE] in hardware. This is exactly correct: PPC32 has no soft-mask
>    PACA mechanism, so the hardware disable is the right way to satisfy
>    irqentry_exit()'s requirement. This also fixes a build error on PPC32
>    where irq_soft_mask_set() is only defined under CONFIG_PPC64:
> 
>        arch/powerpc/include/asm/entry-common.h:273: error: implicit
>        declaration of function 'irq_soft_mask_set'
> 
>    Using hard_irq_disable() requires no #ifdef and is consistent with
>    how the rest of the entry code (e.g. entry-common.h:463) handles the
>    same PPC32/PPC64 split.
> 
> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> Change log:
> V2 -> V3:
> 	- Revert to hard_irq_disable
> 	- Removed some dead code
Ignore this line.

Regards,
Mukesh
> V2: https://lore.kernel.org/all/20260820134718.2176411-1-mkchauras@gmail.com
> V1 -> V2:
> 	- Instead of using hard_irq_disable use irq_soft_mask_set
> V1: https://lore.kernel.org/all/20260812152035.1661781-1-mkchauras@gmail.com
>  arch/powerpc/include/asm/entry-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index 94083516df57..80b07750b531 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>  	}
>  
>  	/* irqentry_exit expects to be called with interrupts disabled */
> -	local_irq_disable();
> +	hard_irq_disable();
>  }
>  
>  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> -- 
> 2.55.0
> 

