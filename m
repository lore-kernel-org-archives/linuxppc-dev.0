Return-Path: <linuxppc-dev+bounces-26210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44C5C61DF0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 04:40:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYGWG335cz2xLf;
	Mon, 31 Aug 2026 14:40:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788151210;
	cv=none; b=oEEzbhGr26iJ1l1LfbEUDX652cdUpCErFpDbUAmNgz8EegeBs1oufwlIi7t8VBnQOndbC5vWJVM6f5lrHbQOVWdAX9I3cr8Vs6RECN7BLaBvetlrVTPu5a6HzKbvNYmlZ+v59/e8ibvDyx2s20+PvTzLL6s9UN1e9Lr1dbgqVvq0UbJv02XmskZHHavBCyQkju/Vt1r5uOn0GIwb49vLWD3WI+A1Y6xObCQF2cDDKyVNg11fsasEygozBweAxDHPmS4MMDNdP78fg5gLISrppGh4YkjQHUTZ52Ex5AdMCk6sJrDdqyretcAJrgnMz+NrKGqdLoVlly57POXTSLJ6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788151210; c=relaxed/relaxed;
	bh=M/97JQpafuwP1byu0J9U78MthGQ+Qt4/D4jfqJ/uUiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIBuUPhchqXuHaoUFgssMz5vF+HhwUpORbQi0ddN5UM9ANsfCMBT30SdMoie9GgwvabS2yY5yyLPMTzYKU0BMm0a2oIApDkH/MDrcXtiUz+y1dZBAWkKb9S092oUEBTmTUls8rdp03eh1uiXnaVlRGMxIxNjh1pKjzT6hN+kcMcpXS0Z05A/qT4kZWSfhnX/8Tz7DjIPn99onI38i5xYbwFV5cXHzbFwXOL5V89hjasnqmkfk2Hoixnp5867iuvxvxgpV3tkYKQxkQW9rEmKYCaQgDI+zUfrfud2JNuxSL8SmZzFYYYM1wymyX2LQi6udyq4F3MNhYlPi1DLO0FD2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jPmuLOoJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jPmuLOoJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYGWF5QJgz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 14:40:09 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso3639990a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 21:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151207; x=1788756007; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/97JQpafuwP1byu0J9U78MthGQ+Qt4/D4jfqJ/uUiM=;
        b=jPmuLOoJBRrsBYWVV/OvHNUb6AnuRmT1z84kw4u5i1MLAjPLCeccu2LbLAE6DXEl6h
         IkdtSyI7DCMVs1ynbV+CW3MKZcXNZ4xah/Ci5QDcvXE9gb/SP3zJ3X3FvVbYR/sE025T
         ndZy6jSnJ/6TJI7/vnC80BjHCpOidav+z3koweecrBSVTz5hehPOD+xlFxNb1Vux3dFv
         u40HXlZnfhXnVIY6K0F/qTPRbOjh38nqVsMIVTVqxmyckQZ6DzwnGH84vIz247TC1gXk
         PO5mU7HJ92I8gFys9lIx3sTMMa2MKn544FIeSAwU1mx0SjLmttteLNLvS+BDvz16IJaY
         X1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151207; x=1788756007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/97JQpafuwP1byu0J9U78MthGQ+Qt4/D4jfqJ/uUiM=;
        b=TXCqK3pBjMWtYk5+okx0ijl/XlRWoJ7hfucAkpHYsQjKuBgmMVEA4ET1LZOgC6vvua
         1X/m9IT+f5d8uSenYtGqXgvAtGjqhJ+gge0mg5wrZha30apJGkdKEfII8GLGFyWLvkxt
         2vdKUj81Xfx+sbrng24BLJe5cMO5I9C9LYX1bhWMzclskXWkvmGkX9B52qJXQlcSAdLz
         mtgJB1upqK91nMRJw1g59Fo3l0RF1oCu72LiemsFBOqvtuINC2B6wET8XnHwW8EyXYXW
         pl1BYcRfu1KAiKvcSYeYhGxxkp0dzEvxXB4urc/T0DBjmD4qTeMsnSQkdvdTLlSmhNZP
         +PJw==
X-Gm-Message-State: AFuF++nZSay6xhjS1lWij1FHFhhnAF+mxV/ZNGsVxXSmwMRMyLC8fBIb
	RXyCWuxXYnr6ezYv0B7t/9lUC2CaAMejz+gpERBYdLWmFjeInT/EWuWd
X-Gm-Gg: AYBFou29h18mZxDuVeu6SB3hFw0Aj6XL4dOPHliiNAnEnGk8qGIlOO4s6snisFR6FY6
	QMjs4b4Dy9DeLmQfHl9CJjMIiAZPHvI/RZHo37kG00GrknCdI27E70wnpYbI8EK+Vs8r0H4oY65
	LV/KzLNew0l16o9wRpIYodtNqzM+vwZLkdJ5OwjOMLGZcynj8W1gsIE56QOhRkodgmCzRoAgkOi
	dGCGaff7hbKhVar4wXdrJLfDEXM31TdRzK8od4pjecaxL/RsDWZMRkv9oSXo/8lVhwkzEoc8Y8A
	e1gALNdn9FaDBNKva56iSubF8QBoB9WPTTXBtwV6uUJyL2ANpqn3nQd9sP8q43F2KjGMSwm06NI
	OqUu+7DCvIxSNvTv4c0KuuvdNKLDtd3cGHKsWKHEH2lUmDcbuqNqqqVMJObuNA6EGwZB2FWWvNN
	a0zCThmN/y/D68MiKnF2GPfHT1H5wyRge6D+upk/S04DtAR1gCiVBlWpKxGKUwFU838Yoj3YMWj
	GJkT5eucw176wBUrMdZe43XqUwML0w7WA==
X-Received: by 2002:a17:90b:17cd:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-398ba961cc0mr15277567a91.8.1788151207419;
        Sun, 30 Aug 2026 21:40:07 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.43.112.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398b18b4074sm10605726a91.12.2026.08.30.21.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:40:07 -0700 (PDT)
Date: Mon, 31 Aug 2026 10:10:02 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
Message-ID: <apUFj2bCtWc6Xees@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
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
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>

On Sat, Aug 29, 2026 at 09:49:00AM +0530, Ritesh Harjani (IBM) wrote:
> So the syscall return sequence is as follows:
> A syscall return to userspace is prepared and then a short asm sequence
> that actually does the RFI. Note that this asm range is restartable i.e.
> EE is still on, so an interrupt (e.g. decrementer or external interrupt)
> can hit while SRR/GPRs are being loaded. This is defined via:
> 
> RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)
> 
> This restart table then sends us to syscall_restart rather than resuming
> in the middle of the RFI. The same stub is also used if irq_happened
> already has a pending bit (soft-masked irq that has not been replayed
> yet (PowerPC special case of local_irq_disable())).
> 
> Here is a bit of a flow of sequence of code to visualize:
>   syscall_exit_prepare
>       decide full-GPR restore (_TIF_RESTOREALL) for signal,
>       rt_sigreturn or syscall trace
>       save that in regs->exit_result and return it in r3
>            |
>            v
>   .Lsyscall_rst_start .. _end     EE still on
>       irq_happened set or interrupt in this range?
>            | no                         | yes
>            v                            v
>       cmpdi r3,0                  syscall_exit_restart
>       restore all / zero            replay irq, try exit again
>       volatiles; RFI                must return flags in r3
>                                     again for the same cmpdi
> 
> Now r3 after prepare is the flags word, not the actual syscall return. A nested
> interrupt clobbers it, so the restart stub reloads RESULT into r3 and the
> C handler (syscall_exit_restart()) should put the flags back (because later asm
> checks whether r3 returned from C has _TIF_RESTOREALL set or not):
> 	cmpdi r3, 0
> 	bne	.Lsyscall_restore_regs
> 
> Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into
> exit_result, but then it only returns the new sample and not the full
> regs->exit_result.
> 
> That sample could be often 0 even when restore-all is still required:
> 
>   - rt_sigreturn / syscall trace set the bit in prepare's local
>     ret and in exit_result. They never set exit_flags, which is
>     what restart samples.
> 
>   - a signal does set exit_flags but restart clears it. A
>     second pass through the stub then returns 0 while
>     exit_result still has the bit.
> 
> The asm as mentioned earlier then treats r3==0 as the fast path and
> zeros r0/r4-r12. That means the userspace that needed the full register
> set could SIGSEGVs, (which could happen often in ld64.so.2 like while
> doing a parallel kernel build as reported by Venkat).
> 
> So we should instead return the accumulated exit_result, like how we do
> in interrupt_exit_user_restart(). Note that prior to this commit
> 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> we were returning regs->exit_result from syscall_exit_restart(), but
> this commit changed that behaviour.
> 
> Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> Sorry about the long commit msg. It took sometime for me to fully understand
> that complex path, so I thought I may as well document that properly.
> 
>  arch/powerpc/kernel/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 5b88bf72786c..55f9c0c9922a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>  	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
>  	regs->exit_result |= ret;
> 
> -	return ret;
> +	return regs->exit_result;
>  }
>  #endif
> 
> --
> 2.39.5
> 
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

