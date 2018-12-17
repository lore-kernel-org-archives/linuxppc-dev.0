Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B7EC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:23:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F272133F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F272133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JJft74zTzDqZH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 22:23:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JJc25XqqzDqWm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 22:20:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JJc235L1z9s4s;
 Mon, 17 Dec 2018 22:20:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Dmitry V. Levin" <ldv@altlinux.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/ptrace: cleanup do_syscall_trace_enter
In-Reply-To: <20181216172828.GA25359@altlinux.org>
References: <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org> <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org> <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org> <20181210132806.GA4177@redhat.com>
 <20181210133655.GH11942@altlinux.org> <20181216172828.GA25359@altlinux.org>
Date: Mon, 17 Dec 2018 22:20:26 +1100
Message-ID: <87y38otn5x.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Dmitry V. Levin" <ldv@altlinux.org> writes:
> Invoke tracehook_report_syscall_entry once.

Thanks.

> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 714c3480c52d..8794d32c2d9e 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3263,32 +3263,40 @@ static inline int do_seccomp(struct pt_regs *regs) { return 0; }
>   */
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> +	u32 cached_flags;
> +

Do you mind if I just call it "flags", I find "cached_flags" a bit
unwieldy for some reason.

I'm happy to fix it up when applying.

cheers

>  	user_exit();
>  
> -	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> -		/*
> -		 * A nonzero return code from tracehook_report_syscall_entry()
> -		 * tells us to prevent the syscall execution, but we are not
> -		 * going to execute it anyway.
> -		 *
> -		 * Returning -1 will skip the syscall execution. We want to
> -		 * avoid clobbering any register also, thus, not 'gotoing'
> -		 * skip label.
> -		 */
> -		if (tracehook_report_syscall_entry(regs))
> -			;
> -		return -1;
> -	}
> +	cached_flags = READ_ONCE(current_thread_info()->flags) &
> +		       (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
>  
> -	/*
> -	 * The tracer may decide to abort the syscall, if so tracehook
> -	 * will return !0. Note that the tracer may also just change
> -	 * regs->gpr[0] to an invalid syscall number, that is handled
> -	 * below on the exit path.
> -	 */
> -	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -	    tracehook_report_syscall_entry(regs))
> -		goto skip;
> +	if (cached_flags) {
> +		int rc = tracehook_report_syscall_entry(regs);
> +
> +		if (unlikely(cached_flags & _TIF_SYSCALL_EMU)) {
> +			/*
> +			 * A nonzero return code from
> +			 * tracehook_report_syscall_entry() tells us
> +			 * to prevent the syscall execution, but
> +			 * we are not going to execute it anyway.
> +			 *
> +			 * Returning -1 will skip the syscall execution.
> +			 * We want to avoid clobbering any register also,
> +			 * thus, not 'gotoing' skip label.
> +			 */
> +			return -1;
> +		}
> +
> +		if (rc) {
> +			/*
> +			 * The tracer decided to abort the syscall.
> +			 * Note that the tracer may also just change
> +			 * regs->gpr[0] to an invalid syscall number,
> +			 * that is handled below on the exit path.
> +			 */
> +			goto skip;
> +		}
> +	}
>  
>  	/* Run seccomp after ptrace; allow it to set gpr[3]. */
>  	if (do_seccomp(regs))
> -- 
> ldv
