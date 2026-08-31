Return-Path: <linuxppc-dev+bounces-26208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9174CC61DF0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 04:11:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYFtP5Njcz2xyh;
	Mon, 31 Aug 2026 14:11:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788149501;
	cv=none; b=ACzf3wgSTTDUt+KvpW3xaJD8cIFPBBn8tiH9WrhaH9eR/eS16Rf6+niR8g9kuRrsF19Wi2IQCiUzY2iT1OEBGtf+h8rXuVz8cOIRmGPCZDQZBgUupeo1lVLENTIlBJ3N1Hc+G9R3Rgc72/wssksYzFL4EXyD6uDXPe4NN/Q6pMsbkjvE8kR3iuCOwU9VEsJvKiO3XBwO+FBfjPmmgtQsFiCHLXVvP/BrFAVy1IAfce9YYGGp18ElTECbnKHr5CIRMRias/PdHNDvZHCLxW0kmpkCxLmb88KkYYipijyLAcYmDklKXDgUa8Q0xoUzmw3ke1ZrbrCNOCbFCc1s+lmQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788149501; c=relaxed/relaxed;
	bh=aggjwNuWMp1Ff0NjfMnlNn4nOjq+mr9N+RLu6RxZSfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZvS598ct5Kx8ExT0QHBdo2+jC8ukFZZ83UAHBqoxoSLFgri/fsv7F4oqlch6B6tB7Ih6JIoyYwCQ+KoXzd72hwATLQYDVgxXrPFRfGaaQ/4w2MEoOttNzjXIu+fEuCbedPIZnSxBqsWWVNLF7Ttg7Pi45x2rFIIUg9YH0eOqixFgxZ2lGbsqgnvVG7WXKJ1f/ziUQKYPmtqY80UbHo+fmYA7GbjDOgxP0OuIlwbXnFEhpt5R/Cx6k1E7ZYbyGnJziX9kj/BF4RvJq5xnLJ80EFjfBEKGfBfUBHsCEIE4hW0y7FVAipHvrw1gLQrwwDuwTTqU4uqaI2qZTdypaIyGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dzRyVxrj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dzRyVxrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYFtN0PGNz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 14:11:38 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so3233083a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788149496; x=1788754296; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aggjwNuWMp1Ff0NjfMnlNn4nOjq+mr9N+RLu6RxZSfI=;
        b=dzRyVxrjC2OdbcUsDiozCxkc4FiUeNqAQf/kRMyefN5ZMJb5zDVZxyogK3HwQHsdaq
         MO0mS5JfKrf7ZkJjAC8TzsOW2SjzkGAXM74jk0HEeJnrHDVsL0flCgpVcfT/TfskzTFZ
         nHzUKbPQm/9UNF/EPRG+8zSYsMey6IO/xj+7aji+mosREWEDASTatMFH8pgtdFPHRPqQ
         r/6vVgiv5RGkH/SOLV82E52M2o5Ny5bhzvUqqmwDbIKiYFcIOdBoET0ll6MGYxXuc/kI
         8h3PYxUXSnuHF3JuQ6MB/8Zwcg2N2cUOWU0I+hawkP57I58hmVTkmKq/AqbBnICgkOrB
         jk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788149496; x=1788754296;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aggjwNuWMp1Ff0NjfMnlNn4nOjq+mr9N+RLu6RxZSfI=;
        b=HRhCVl74PR5cN/tP9S6poyA7bnTFKhqbYnw1q4T7ZdTeXaxI0ZiU4tG+b/c4cRnzkJ
         XIdaEs6xqO4a4gOgw8hJ9FoiJgXoDSXL32/IK4md/yAg67fXpvZqk2W3apBj/2LmeR3a
         JvvYKfgA0//5aMUL6inhNZyoOCR6azH/6L6Avw0Eek8CfezM3b5URsGO4l1+LoTkJ9pb
         gvrNLgr8B0O/E8qewcp2WZsCJEkp+MlhbWziyaolQgVjAobhmj4BTXQJ8qaXz+VK9fUd
         r8ZaTZPsq1zAHGQklWpKtvLSRepOkLp9+OPxfvnhpKpGxiAEdYJrvVcmxCqy/TzeHfUB
         4XzA==
X-Gm-Message-State: AFuF++ktXbgGHvjS4oK2Lz/D/SuLtnBDrzq77hwgUPp8BkW52w/pGfdf
	1nRJTL1UX+LPsaPnkPJVeLsc7THJkw0AoTJJqAxK3Al0hJvs+cTBFn35
X-Gm-Gg: AYBFou0KD7XHZ7fri5D3ToJOfoU0StmCTZmLCAz+0vP7Vazy3wbx/mYvZBr2hPee10t
	i+gdsWwpEAbI7dv5LZWISHlUDvRBnXAL/3yrOAEdYXezGXF+pKnl7i2x0pvvxsrOP75Impodj1I
	gAcsgFLWfFElHWFBXF+HUBdgPUN05RUg+vYxbUkGFsju/uKm24q1yZRd9m+w9osU0E8+NU7f1F5
	OEZ7o3GdeErdcnIu3d/Lpx0KJXVz7qKS9dE6hrzn8a1NUk2+7li1aG+hQWeAZgQT0ko6FzFcMaY
	bsKyxZHEXepKo+5NuWsS9DPQB2CnOv7dPGMDz6hZlBeu+nqzWigS/WMztbjA+TiJQeyir0GBI7p
	Kw7mY3Oa4lIHO2AWeCXVZc2WL088U7F2uNc5jucHUhvjrd23PWFZf75DIjrm2iASHBgiYJubrB8
	u14Y/e3sB2xGiFmHeNXmwcxgkhrBAyxYcbFpzFUvI+Inr6ymAboYTByqMBrwm/UNQ165a24VNMU
	HJdVhgUitf4jMe3ZNcPtkY0V4e5+XdHlQ==
X-Received: by 2002:a17:90a:e70c:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-398f86c8470mr1156311a91.21.1788149496202;
        Sun, 30 Aug 2026 21:11:36 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.43.112.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc58d51sm14596165a91.15.2026.08.30.21.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:11:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:41:31 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Do not restore KUAP in
 arch_exit_to_user_mode_prepare()
Message-ID: <apT-oVMnqgnQrisN@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>
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
In-Reply-To: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>

On Sun, Aug 30, 2026 at 08:24:30PM +0530, Ritesh Harjani (IBM) wrote:
> KUAP means kernel cannot touch user memory unless it explicitly is
> enabled. In the kernel it should stay AMR_KUAP_BLOCKED. While returning
> to userspace just before RFI, kernel should restore the user AMR value
> back.
> 
> Looks like GENERIC_ENTRY might be treating arch_exit_to_user_mode_prepare()
> as the last architecture step before returning to userspace.
> commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> therefore called kuap_user_restore() from that hook. But on PowerPC that
> is too early. After irqentry_exit() / syscall_exit_to_user_mode() we
> still run platform specific exit routines.
> 
> e.g. code snippets showing both exception handling and system call
> handling as the callers of function arch_exit_to_user_mode_prepare()
> which does kuap_user_restore(). The below path shows that calling
> kuap_user_restore() is too early when called from
> arch_exit_to_user_mode_prepare().
> 
> Exception handling in exceptions-64s.S
> =======================================
> 
> bl	CFUNC(do_page_fault)
> 	  ..DEFINE_INTERRUPT_HANDLER_ASYNC(do_page_fault)
> 	      arch_interrupt_async_enter_prepare(regs);
> 	      state = irqentry_enter(regs);
> 	      instrumentation_begin();
> 	      irq_enter_rcu();
> 	      handler(regs);
> 	      nap_adjust_return(regs);
> 	      irq_exit_rcu();
> 	      instrumentation_end();
> 	      arch_interrupt_async_exit_prepare(regs);
> 	      irqentry_exit(regs, state); 		   <<< too early
> 	        irqentry_exit_to_user_mode()
> 		  __exit_to_user_mode_prepare(regs, EXIT_TO_USER_MODE_WORK_IRQ);
> 		    arch_exit_to_user_mode_prepare(regs, ti_work);  <<< too early
> b	interrupt_return_srr
> 		.. bl	CFUNC(interrupt_exit_user_prepare) <<< already calls kuap_user_restore
> 
> prep_irq_for_enabled_exit() retry can run kernel code with IRQs on. So
> only when that routine is fully finished is when the user KUAP should be
> fully restored which interrupt_exit_user_prepare() already takes care of
> before returning.
> 
> Similarly for system call handling in interrupt_64.S
> ======================================================
> 
> 	bl	CFUNC(system_call_exception)
> 
> .Lsyscall_exit:
> 	addi	r4,r1,STACK_INT_FRAME_REGS
> 	li	r5,0 /* !scv */
> 	bl	CFUNC(syscall_exit_prepare)
> 		  .. kuap_assert_locked();
> 		     syscall_exit_to_user_mode(regs); <<< too early
> 		       syscall_exit_to_user_mode_prepare(regs);  <<< too early
>  		     kuap_user_restore(regs);         <<< already calls
> 
> syscall_exit_prepare(), which can enable IRQs, replay a pending
> interrupt, and only then rfi. Those functions already restore KUAP
> immediately before rfi.
> 
> Note that if we restore the user AMR too early like in the current code
> as shown from the code snippets above, then we get the following warning
> when CONFIG_PPC_KUAP_DEBUG is enabled:
>   WARNING: arch/powerpc/include/asm/book3s/64/kup.h:293 at interrupt_exit_user_prepare+0x1a0/0x1c0
>   Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected)
>   TRAP: 0700
>   LR: c00000000000d8d4 CTR: c0000000021fe500
>   MSR: <SF,EE,ME,IR,DR,RI,LE>  CR: 44000804  XER: 20040000
>   interrupt_exit_user_prepare+0x1a0/0x1c0
>   interrupt_return_srr_user+0x8/0x12c
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Fixes: 02565a782c1ee ("powerpc: Introduce syscall exit arch functions")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/include/asm/entry-common.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..94083516df57 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -515,8 +515,14 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	local_paca->tm_scratch = regs->msr;
>  #endif
> -	/* Restore user access locks last */
> -	kuap_user_restore(regs);
> +	/*
> +	 * Do not restore KUAP here. Generic entry might treat this as the last
> +	 * arch step before userspace but PowerPC still has kernel work after
> +	 * irqentry_exit()/syscall_exit_to_user_mode() i.e. in
> +	 * interrupt_exit_user_prepare() / syscall_exit_prepare() may enable
> +	 * IRQs and retry. Those functions restore KUAP immediately before rfi,
> +	 * which is where it should belong.
> +	 */
>  }
> 
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> --
> 2.39.5
> 
> 
Yeah, KUAP access should be restored last.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

