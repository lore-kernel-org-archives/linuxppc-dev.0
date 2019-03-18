Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A8C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 15:00:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E956720850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 15:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E956720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NK9t5sT5zDqL7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 02:00:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NK6G4J8YzDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:57:25 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6701650;
 Mon, 18 Mar 2019 07:57:24 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E1E3F59C;
 Mon, 18 Mar 2019 07:57:21 -0700 (PDT)
Date: Mon, 18 Mar 2019 14:57:19 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190318145719.GB18196@e107155-lin>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-3-sudeep.holla@arm.com>
 <20190318144115.GC27941@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318144115.GC27941@altlinux.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Bin Lu <bin.lu@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 18, 2019 at 05:41:15PM +0300, Dmitry V. Levin wrote:
> On Mon, Mar 18, 2019 at 10:49:21AM +0000, Sudeep Holla wrote:
> > Currently each architecture handles PTRACE_SYSEMU in very similar way.
> > It's completely arch independent and can be handled in the code helping
> > to consolidate PTRACE_SYSEMU handling.
> > 
> > Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
> > entry code can call.
> 
> Sorry if I'm late for the party, but the new name looks confusing.
> If all it does is related to TIF_SYSCALL_EMU, why does it have a generic
> name 'ptrace_syscall_enter' without any hint of being specific to
> TIF_SYSCALL_EMU?
> 

Not at all late. Infact Haibo Xu pointed that out, I updated but somehow
missed to commit and lost those changes. I will rename as
ptrace_sysemu_syscall_enter

--
Regards,
Sudeep
