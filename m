Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B34DC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:47:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ADA2087C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ADA2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xJ0t4GW4zF3np
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 23:47:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xHtq5DY1zDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 23:42:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42xHtn347bz9sDC;
 Fri, 16 Nov 2018 23:42:25 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Elvira Khabirova <lineprinter@altlinux.org>, benh@kernel.crashing.org,
 paulus@samba.org
Subject: Re: [PATCH v2] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
In-Reply-To: <20181116121701.14359da0@akathisia>
References: <20181116121701.14359da0@akathisia>
Date: Fri, 16 Nov 2018 23:42:24 +1100
Message-ID: <87ftw12nyn.fsf@concordia.ellerman.id.au>
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
Cc: esyr@redhat.com, linux-kernel@vger.kernel.org, ldv@altlinux.org,
 luto@kernel.org, oleg@redhat.com, leitao@debian.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Elvira Khabirova <lineprinter@altlinux.org> writes:

> Arch code should use tracehook_*() helpers, as documented
> in include/linux/tracehook.h.

Thanks.

It probably also should have a comment explaining why we're ignoring the
return value and why that's OK.

cheers

> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index afb819f4ca68..d79d907f9acc 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3266,7 +3266,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>  	user_exit();
>  
>  	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> -		ptrace_report_syscall(regs);
> +		(void) tracehook_report_syscall_entry(regs);
>  		/*
>  		 * Returning -1 will skip the syscall execution. We want to
>  		 * avoid clobbering any register also, thus, not 'gotoing'
> -- 
> 2.19.1
