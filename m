Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A8C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 10:53:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF872086E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 10:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF872086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZBws31tdzF3Wp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 21:53:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZBt656XfzF3Wp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 21:50:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ZBt62KRhz9s55;
 Tue, 16 Oct 2018 21:50:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: Split user/kernel definitions of struct
 pt_regs
In-Reply-To: <14b76e3e-2497-4ac2-c0b5-ce801275ac64@linux.vnet.ibm.com>
References: <20181013105646.5147-1-mpe@ellerman.id.au>
 <458fb5e1-3654-e8db-dfa7-074195decb11@linux.vnet.ibm.com>
 <87sh17zcur.fsf@concordia.ellerman.id.au>
 <14b76e3e-2497-4ac2-c0b5-ce801275ac64@linux.vnet.ibm.com>
Date: Tue, 16 Oct 2018 21:50:37 +1100
Message-ID: <87k1mikvwi.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> On Monday 15 October 2018 04:38 PM, Michael Ellerman wrote:
>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>
>>> On Saturday 13 October 2018 04:26 PM, Michael Ellerman wrote:
...
>>>> At the moment they're still identical, and we check that at build
>>>> time. That's because we have code (in ptrace etc.) that assumes that
>>>> they are the same. We will fix that code in future patches, and then
>>>> we can break the strict symmetry between the two structs.
>>> Nice and awesome. But just trying to understand. What will
>>> *regs will point to in the "struct sigcontext".
>>
>> It should always point to a user_pt_regs.
...
>>
>> I think it's not actually broken at the moment, because it's just a
>> pointer, and we don't do anything based on the sizeof() the type.
>
> yes. This clarifies. But still perf/perf_regs.c needs changes.
> Because perf support dumping user_space regs and interrupt regs.
> Once again, we dont use any sizeof(), but need to handle the
> user_pt_regs changes.
>
> I will have a look at that in the morning.

I did look at that and convinced myself that it was OK, but maybe I'm
wrong :D

My reasoning was that the regs we're using there are always the
in-kernel regs for the process at the point it took the PMU interrupt.
And the regs values aren't exported directly as a struct but rather via
regs_get_register().

But we may still want to change it to make things clearer.

cheers
