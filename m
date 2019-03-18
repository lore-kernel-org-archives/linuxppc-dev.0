Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3131EC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 15:35:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC5020863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 15:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC5020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NKxc2XvZzDqLc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 02:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=oleg@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NKvx1N8vzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 02:33:29 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 988863083391;
 Mon, 18 Mar 2019 15:33:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
 by smtp.corp.redhat.com (Postfix) with SMTP id C77CE5D704;
 Mon, 18 Mar 2019 15:33:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 18 Mar 2019 16:33:26 +0100 (CET)
Date: Mon, 18 Mar 2019 16:33:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190318153321.GA23521@redhat.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-4-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318104925.16600-4-sudeep.holla@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 18 Mar 2019 15:33:27 +0000 (UTC)
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
Cc: Haibo Xu <haibo.xu@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, jdike@addtoit.com, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Bin Lu <bin.lu@arm.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/18, Sudeep Holla wrote:
>
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -70,22 +70,16 @@ static long syscall_trace_enter(struct pt_regs *regs)
>  
>  	struct thread_info *ti = current_thread_info();
>  	unsigned long ret = 0;
> -	bool emulated = false;
>  	u32 work;
>  
>  	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  		BUG_ON(regs != task_pt_regs(current));
>  
> -	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
> -
> -	if (unlikely(work & _TIF_SYSCALL_EMU))
> -		emulated = true;
> -
> -	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
> -	    tracehook_report_syscall_entry(regs))
> +	if (unlikely(ptrace_syscall_enter(regs)))
>  		return -1L;
>  
> -	if (emulated)
> +	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
> +	if ((work & _TIF_SYSCALL_TRACE) && tracehook_report_syscall_entry(regs))
>  		return -1L;

Well, I won't really argue, but to be honest I think this change doesn't make
the code better... With this patch tracehook_report_syscall_entry() has 2 callers,
to me this just adds some confusion.

I agree that the usage of emulated/_TIF_SYSCALL_EMU looks a bit overcomplicated,
I'd suggest a simple cleanup below.

And it seems that _TIF_WORK_SYSCALL_ENTRY needs some cleanups too... We don't need
"& _TIF_WORK_SYSCALL_ENTRY" in syscall_trace_enter, and _TIF_WORK_SYSCALL_ENTRY
should not include _TIF_NOHZ?

Oleg.


--- x/arch/x86/entry/common.c
+++ x/arch/x86/entry/common.c
@@ -70,23 +70,18 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	struct thread_info *ti = current_thread_info();
 	unsigned long ret = 0;
-	bool emulated = false;
 	u32 work;
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 		BUG_ON(regs != task_pt_regs(current));
 
-	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
+	work = READ_ONCE(ti->flags);
 
-	if (unlikely(work & _TIF_SYSCALL_EMU))
-		emulated = true;
-
-	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
-		return -1L;
-
-	if (emulated)
-		return -1L;
+	if (work & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
+		ret = tracehook_report_syscall_entry(regs);
+		if (ret || (work & _TIF_SYSCALL_EMU))
+			return -1L;
+	}
 
 #ifdef CONFIG_SECCOMP
 	/*

