Return-Path: <SRS0=hyM8=TB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D557CC04AA8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 15:59:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2562D21734
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 15:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2562D21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44vNPR3fDLzDqPm
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 01:59:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=oleg@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44vNMD3H8xzDqPB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2019 01:57:21 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86BC8C053B34;
 Wed,  1 May 2019 15:57:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
 by smtp.corp.redhat.com (Postfix) with SMTP id 83E2A1001E95;
 Wed,  1 May 2019 15:57:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Wed,  1 May 2019 17:57:16 +0200 (CEST)
Date: Wed, 1 May 2019 17:57:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190501155711.GB30235@redhat.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-4-sudeep.holla@arm.com>
 <20190318153321.GA23521@redhat.com>
 <20190430164413.GA18913@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430164413.GA18913@e107155-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 01 May 2019 15:57:18 +0000 (UTC)
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

On 04/30, Sudeep Holla wrote:
>
> On Mon, Mar 18, 2019 at 04:33:22PM +0100, Oleg Nesterov wrote:
> >
> > And it seems that _TIF_WORK_SYSCALL_ENTRY needs some cleanups too... We don't need
> > "& _TIF_WORK_SYSCALL_ENTRY" in syscall_trace_enter, and _TIF_WORK_SYSCALL_ENTRY
> > should not include _TIF_NOHZ?
> >
>
> I was about to post the updated version and checked this to make sure I have
> covered everything or not. I had missed the above comment. All architectures
> have _TIF_NOHZ in their mask that they check to do work. And from x86, I read
> "...syscall_trace_enter(). Also includes TIF_NOHZ for enter_from_user_mode()"
> So I don't understand why _TIF_NOHZ needs to be dropped.

I have already forgot this discussion... But after I glanced at this code again
I still think the same, and I don't understand why do you disagree.

> Also if we need to drop, we can address that separately examining all archs.

Sure, and I was only talking about x86. We can keep TIF_NOHZ and even
set_tsk_thread_flag(TIF_NOHZ) in context_tracking_cpu_set() if some arch needs
this but remove TIF_NOHZ from TIF_WORK_SYSCALL_ENTRY in arch/x86/include/asm/thread_info.h,
afaics this shouldn't make any difference.

And I see no reason why x86 needs to use TIF_WORK_SYSCALL_ENTRY in
syscall_trace_enter().

Oleg.

