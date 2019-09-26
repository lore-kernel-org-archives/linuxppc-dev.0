Return-Path: <SRS0=Ic/D=XV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F568C4360C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 14:16:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5268621D56
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5268621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46fH6T663vzDqDd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 00:16:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=canonical.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=cascardo@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=canonical.com
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46fGYc0nPNzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2019 23:51:31 +1000 (AEST)
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=calabresa)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <cascardo@canonical.com>)
 id 1iDUB4-0000mS-Ja; Thu, 26 Sep 2019 13:51:27 +0000
Date: Thu, 26 Sep 2019 10:51:22 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/ptrace: Do not return ENOSYS if invalid syscall
Message-ID: <20190926135119.GA12170@calabresa>
References: <20190911010122.28462-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911010122.28462-1-cascardo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 10, 2019 at 10:01:22PM -0300, Thadeu Lima de Souza Cascardo wrote:
> If a tracer sets the syscall number to an invalid one, allow the return
> value set by the tracer to be returned the tracee.
> 
> The test for NR_syscalls is already at entry_64.S, and it's at
> do_syscall_trace_enter only to skip audit and trace.
> 
> After this, seccomp_bpf selftests complete just fine, as the failing test
> was using ptrace to change the syscall to return an error or a fake value,
> but were failing as it was always returning -ENOSYS.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>  arch/powerpc/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 8c92febf5f44..87315335f66a 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3316,7 +3316,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>  
>  	/* Avoid trace and audit when syscall is invalid. */
>  	if (regs->gpr[0] >= NR_syscalls)
> -		goto skip;
> +		return regs->gpr[0];
>  
>  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
>  		trace_sys_enter(regs, regs->gpr[0]);

Ping? Any comments on this?

Thanks.
Cascardo.
