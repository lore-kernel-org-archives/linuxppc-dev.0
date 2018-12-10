Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25478C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF222084E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF222084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D3qH0t3XzDqrN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=oleg@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D3mZ6mQJzDqpy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 00:28:14 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8F35811A9;
 Mon, 10 Dec 2018 13:28:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
 by smtp.corp.redhat.com (Postfix) with SMTP id E94F01A7D4;
 Mon, 10 Dec 2018 13:28:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 10 Dec 2018 14:28:12 +0100 (CET)
Date: Mon, 10 Dec 2018 14:28:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v6] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181210132806.GA4177@redhat.com>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207185226.GB31278@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 13:28:13 +0000 (UTC)
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
Cc: Eugene Syromyatnikov <esyr@redhat.com>, linux-kernel@vger.kernel.org,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/07, Dmitry V. Levin wrote:
>
> Please make either v5 or v6 edition of this fix, or any similar fix,
> into v4.20.

IIUC, v5 above means

	[PATCH v5 23/25] powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call

you sent in another series...

>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> +	struct thread_info *ti;
> +	u32 cached_flags;
> +
>  	user_exit();
>  
> -	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> -		ptrace_report_syscall(regs);
> -		/*
> -		 * Returning -1 will skip the syscall execution. We want to
> -		 * avoid clobbering any register also, thus, not 'gotoing'
> -		 * skip label.
> -		 */
> -		return -1;
> -	}
> +	ti = current_thread_info();
> +	cached_flags = READ_ONCE(ti->flags) &
> +		       (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE |
> +			_TIF_SYSCALL_TRACEPOINT);
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
> +	if (cached_flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
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
> @@ -3293,7 +3309,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>  	if (regs->gpr[0] >= NR_syscalls)
>  		goto skip;
>  
> -	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> +	if (unlikely(cached_flags & _TIF_SYSCALL_TRACEPOINT))

I will leave this to maintainers, but to me this change looks good and imo it
also cleanups the code.

However I am not sure cached_flags should include _TIF_SYSCALL_TRACEPOINT. If
nothing else, the caller can sleep in ptrace_stop() unpredictably long and
TIF_SYSCALL_TRACEPOINT can be set/cleared meanwhile.

Oleg.

