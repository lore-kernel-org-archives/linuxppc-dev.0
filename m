Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9AEC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:29:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB34A20874
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB34A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JJpZ4y1tzDqKS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 22:29:42 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JJm72TdNzDqXN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 22:27:35 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 357F9C0495B4;
 Mon, 17 Dec 2018 11:27:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
 by smtp.corp.redhat.com (Postfix) with SMTP id 2DF1C60F8D;
 Mon, 17 Dec 2018 11:27:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 17 Dec 2018 12:27:32 +0100 (CET)
Date: Mon, 17 Dec 2018 12:27:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] powerpc/ptrace: cleanup do_syscall_trace_enter
Message-ID: <20181217112730.GA25465@redhat.com>
References: <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
 <20181210132806.GA4177@redhat.com>
 <20181210133655.GH11942@altlinux.org>
 <20181216172828.GA25359@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216172828.GA25359@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 11:27:33 +0000 (UTC)
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

On 12/16, Dmitry V. Levin wrote:
>
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> +	u32 cached_flags;
> +
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

Looks good to me,

Oleg.

