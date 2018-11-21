Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F06C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 21:19:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F099206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 21:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F099206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430b794hp4zF1nv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 08:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430b4l65byzF3Mt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 08:17:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 430b4l0dG7z9s29;
 Thu, 22 Nov 2018 08:17:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Dmitry V. Levin" <ldv@altlinux.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
In-Reply-To: <20181119210139.GA8360@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
Date: Thu, 22 Nov 2018 08:17:25 +1100
Message-ID: <87efbe166y.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Andy Lutomirski <luto@kernel.org>,
 Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dmitry,

Thanks for the patch.

"Dmitry V. Levin" <ldv@altlinux.org> writes:
> From: Elvira Khabirova <lineprinter@altlinux.org>
>
> Arch code should use tracehook_*() helpers as documented
> in include/linux/tracehook.h,
> ptrace_report_syscall() is not expected to be used outside that file.
>
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> v3: add a descriptive comment
> v2: explicitly ignore tracehook_report_syscall_entry() return code
>
>  arch/powerpc/kernel/ptrace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index afb819f4ca68..e84220d91bbd 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3266,7 +3266,12 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>  	user_exit();
>  
>  	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> -		ptrace_report_syscall(regs);
> +		/*
> +		 * A nonzero return code from tracehook_report_syscall_entry()
> +		 * tells us to prevent the syscall execution, but we are not
> +		 * going to execute it anyway.
> +		 */
> +		(void) tracehook_report_syscall_entry(regs);

Unfortunately the (void) cast doesn't work to suppress the must check
warning.

  arch/powerpc/kernel/ptrace.c:3274:3: error: ignoring return value of 'tracehook_report_syscall_entry', declared with attribute warn_unused_result [-Werror=unused-result]

AFAIK we don't have a way to suppress that.

I guess we should rewrite it to only call
tracehook_report_syscall_entry() once, like x86 does.

I'll try and get a patch for that done & tested.

cheers
