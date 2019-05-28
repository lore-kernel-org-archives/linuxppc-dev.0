Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A90C04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 09:52:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8282053B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 09:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8282053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Cpzm0q2RzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 19:52:36 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CpxV5l66zDqPv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 19:50:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45CpxV1vzJz9s4V;
 Tue, 28 May 2019 19:50:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] perf ioctl: Add check for the sample_period value
In-Reply-To: <d2d34084-999d-9be2-511e-82625b80aa40@linux.ibm.com>
References: <20190511024217.4013-1-ravi.bangoria@linux.ibm.com>
 <20190513074213.GH2623@hirez.programming.kicks-ass.net>
 <20190513085620.GN2650@hirez.programming.kicks-ass.net>
 <d2d34084-999d-9be2-511e-82625b80aa40@linux.ibm.com>
Date: Tue, 28 May 2019 19:50:37 +1000
Message-ID: <87h89eq55e.fsf@concordia.ellerman.id.au>
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, maddy@linux.vnet.ibm.com,
 jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> On 5/13/19 2:26 PM, Peter Zijlstra wrote:
>> On Mon, May 13, 2019 at 09:42:13AM +0200, Peter Zijlstra wrote:
>>> On Sat, May 11, 2019 at 08:12:16AM +0530, Ravi Bangoria wrote:
>>>> Add a check for sample_period value sent from userspace. Negative
>>>> value does not make sense. And in powerpc arch code this could cause
>>>> a recursive PMI leading to a hang (reported when running perf-fuzzer).
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> ---
>>>>  kernel/events/core.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index abbd4b3b96c2..e44c90378940 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>>>>  	if (perf_event_check_period(event, value))
>>>>  		return -EINVAL;
>>>>  
>>>> +	if (!event->attr.freq && (value & (1ULL << 63)))
>>>> +		return -EINVAL;
>>>
>>> Well, perf_event_attr::sample_period is __u64. Would not be the site
>>> using it as signed be the one in error?
>> 
>> You forgot to mention commit: 0819b2e30ccb9, so I guess this just makes
>> it consistent and is fine.
>> 
>
> Yeah, I was about to reply :)

I've taken patch 2. You should probably do a v2 of patch 1 with an
updated change log that explains things fully?

cheers
