Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB0C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:50:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D753F21726
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D753F21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bN5Q6jm4zDqGJ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 01:50:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44bMyv1GqvzDqW7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 01:44:22 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544B816A3;
 Fri,  5 Apr 2019 07:44:21 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 363853F68F;
 Fri,  5 Apr 2019 07:44:17 -0700 (PDT)
Date: Fri, 5 Apr 2019 15:44:14 +0100
From: Will Deacon <will.deacon@arm.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH RFC 5/5] arm64/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405144414.GB7662@fuggles.cambridge.arm.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Josh,

On Thu, Apr 04, 2019 at 11:44:15AM -0500, Josh Poimboeuf wrote:
> Configure arm64 runtime CPU speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown and Speculative Store Bypass.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  arch/arm64/kernel/cpu_errata.c                  | 4 ++++
>  arch/arm64/kernel/cpufeature.c                  | 6 ++++++
>  3 files changed, 12 insertions(+)

Just wanted to make you aware that this is probably going to conflict badly
with some patches we have pending to hook up the sysfs entries:

http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640326.html

That patch series isn't quite there yet, so I'm expecting a v7, but I think
it will change the shape of this patch quite a lot.

Will
