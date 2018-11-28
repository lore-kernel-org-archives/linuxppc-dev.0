Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43940C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:17:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78B420645
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78B420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434w4C63rlzDqSc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 09:16:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434w0w3TgwzDqWN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 09:14:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 434w0v4CW3z9s3l;
 Thu, 29 Nov 2018 09:14:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RESEND] powerpc/perf: Update perf_regs structure to
 include SIER
In-Reply-To: <7e8d41eb-9f8d-4d9b-2aeb-1670d582f529@linux.vnet.ibm.com>
References: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20181126193821.GD18491@kernel.org> <878t1dho3x.fsf@concordia.ellerman.id.au>
 <7e8d41eb-9f8d-4d9b-2aeb-1670d582f529@linux.vnet.ibm.com>
Date: Thu, 29 Nov 2018 09:14:06 +1100
Message-ID: <8736rk4zpt.fsf@concordia.ellerman.id.au>
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, Thomas Richter <tmricht@linux.vnet.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> On 28/11/18 9:04 AM, Michael Ellerman wrote:
>> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>>
>>> Em Mon, Nov 26, 2018 at 11:34:08PM +0530, Madhavan Srinivasan escreveu:
>>>> On each sample, Sample Instruction Event Register (SIER) content
>>>> is saved in pt_regs. SIER does not have a entry as-is in the pt_regs
>>>> but instead, SIER content is saved in the "dar" register of pt_regs.
>>>>
>>>> Patch adds another entry to the perf_regs structure to include the "SIER"
>>>> printing which internally maps to the "dar" of pt_regs.
>>> I think the patch is ok, when we talked in Vancouver I thought I saw
>>> something like this before, i.e. adding more registers to a perf_regs.h
>>> file, this was the cset:
>>>
>>>    commit 0da0017f72554c005c1a04c3adc5da9eb64fa7e5
>>>    Author: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>>>    Date:   Wed Nov 8 07:30:15 2017 +0100
>>>
>>>        s390/perf: extend perf_regs support to include floating-point registers
>>>
>>> That I came across because it broke the perf build, making me add this
>>> cset:
>>>
>>>    commit 10b9baa701d5023897f70a4acb3bf0235da3dc4f
>>>    Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>    Date:   Tue Nov 28 11:08:41 2017 -0300
>>>
>>>      tools arch s390: Do not include header files from the kernel sources
>>>
>>> :-)
>>>
>>> Michael? What about the ppc specific details?
>> The only possible objection is that not all CPUs have an SIER register,
>> so on CPUs without it you'll get the content of the DAR register rather
>> than the SIER (because we (ab)use the DAR slot of pt_regs for the SIER).
>>
>> Perhaps we should make sure that we return 0 on CPUs that don't have the
>> register?
>
>
> Yes this make sense. We should make it zero instead of having the DAR
> value. I will respin the patch with that change.

Thanks.

There's three cases we need to cover.

The first is when we're not using core-book3s.c at all, ie. when we're
using the Freescale PMU code. You can probably handle that at build time
using CONFIG_FSL_EMB_PERF_EVENT?

Then there's the 32-bit case in core-book3s.c, currently that version of
perf_read_regs() never sets a value in dar.

And then there's the 64-bit case but PPMU_HAS_SIER is not set.

cheers
