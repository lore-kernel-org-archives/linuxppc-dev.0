Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A7C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:15:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A05E20868
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A05E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B8yM0Mt0zDrgq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 22:15:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B8vj4rKbzDrf7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 22:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43B8vj1x8Gz9s0n;
 Fri,  7 Dec 2018 22:12:49 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
In-Reply-To: <20181207011946.GA18558@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org> <20181207011946.GA18558@altlinux.org>
Date: Fri, 07 Dec 2018 22:12:49 +1100
Message-ID: <87y391k2tq.fsf@concordia.ellerman.id.au>
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
Cc: Oleg Nesterov <oleg@redhat.com>, Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On Mon, Dec 03, 2018 at 06:18:23AM +0300, Dmitry V. Levin wrote:
>> From: Elvira Khabirova <lineprinter@altlinux.org>
>> 
>> Arch code should use tracehook_*() helpers, as documented
>> in include/linux/tracehook.h,
>> ptrace_report_syscall() is not expected to be used outside that file.
>> 
>> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
>> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
>> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
>> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>> ---
>> v4: rewritten to call tracehook_report_syscall_entry() once, compile-tested
>> v3: add a descriptive comment
>> v2: explicitly ignore tracehook_report_syscall_entry() return code
>> 
>>  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
>>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> Sorry, this patch does not work, please ignore it.

Hmm OK. Why exactly?

I wrote more or less the same patch, although I used a temporary bool.

> However, the bug blocks PTRACE_GET_SYSCALL_INFO, so please fix it.

Sorry, didn't realise it was blocking you.

> I'm going to use
> 	if (tracehook_report_syscall_entry(regs))
> 		return -1;
> 	return -1;
> in the series until you have a better fix.

Yeah that's fine by me. I could send that to Linus for 4.20 if you want
me to, otherwise I'm fine for you to carry it in your series.

cheers
