Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E55DC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 02:40:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A4861059
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 02:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A4861059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9nTh1ngrz3bs8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 13:40:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=DqclO1Od;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=DqclO1Od; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9nT75Ls6z2yZL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 13:39:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F9nT03JYsz9sWw;
 Thu,  1 Apr 2021 13:39:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1617244778;
 bh=jF35UQXWV9ftup/kWbiFuhxrt8LNtzRK24u+5NfY62w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DqclO1OdkHC0HIyU55+U/3XcCUj81LZgSGICQJPeG655bzU+Kfn7sgMhOXVk588kr
 /RNXh7SMzPQg9w+ycpvXiJYPzSMsUPXgTNaq+lLam/2Hi6NoAhKyAipl8Pn9qoSLDk
 qA1j7sQL6q1sSnRcCQHQ2ml1w+YPDpUP8KsQC4MqrTP+xBcHnSr+VneuRaWCJ/c9sO
 JQS2YPJNnuIJ8CvhMpXwLplqRqcTByd40L476kgI5KDf/q3Z+7uScinxejVBJ++xxD
 l//mTD2CWZARwb1Z+kVGSfooQ/uFVb7Rj8QtZPUxt6A7Q+e87O+Jl8WQ1e29ewe7TA
 0AjEBrKse/ySA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/traps: Enhance readability for trap types
In-Reply-To: <20210331212550.GD13863@gate.crashing.org>
References: <20210330150425.10145-1-sxwjean@me.com>
 <875z17y79i.fsf@mpe.ellerman.id.au>
 <20210331212550.GD13863@gate.crashing.org>
Date: Thu, 01 Apr 2021 13:39:28 +1100
Message-ID: <87im5620f3.fsf@mpe.ellerman.id.au>
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
Cc: pmladek@suse.com, peterz@infradead.org, peterx@redhat.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, kan.liang@linux.intel.com,
 leobras.c@gmail.com, mikey@neuling.org, maddy@linux.ibm.com,
 aneesh.kumar@linux.ibm.com, haren@linux.ibm.com, aik@ozlabs.ru,
 kjain@linux.ibm.com, msuchanek@suse.de, ravi.bangoria@linux.ibm.com,
 john.ogness@linutronix.de, alistair@popple.id.au, npiggin@gmail.com,
 kvm-ppc@vger.kernel.org, jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
 Xiongwei Song <sxwjean@me.com>, Xiongwei Song <sxwjean@gmail.com>,
 oleg@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 rppt@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Wed, Mar 31, 2021 at 08:58:17PM +1100, Michael Ellerman wrote:
>> So perhaps:
>> 
>>   EXC_SYSTEM_RESET
>>   EXC_MACHINE_CHECK
>>   EXC_DATA_STORAGE
>>   EXC_DATA_SEGMENT
>>   EXC_INST_STORAGE
>>   EXC_INST_SEGMENT
>>   EXC_EXTERNAL_INTERRUPT
>>   EXC_ALIGNMENT
>>   EXC_PROGRAM_CHECK
>>   EXC_FP_UNAVAILABLE
>>   EXC_DECREMENTER
>>   EXC_HV_DECREMENTER
>>   EXC_SYSTEM_CALL
>>   EXC_HV_DATA_STORAGE
>>   EXC_PERF_MONITOR
>
> These are interrupt (vectors), not exceptions.  It doesn't matter all
> that much, but confusing things more isn't useful either!  There can be
> multiple exceptions that all can trigger the same interrupt.

Yeah I know, but I think that ship has already sailed as far as the
naming we have in the kernel.

We have over 250 uses of "exc", and several files called "exception"
something.

Using "interrupt" can also be confusing because Linux uses that to mean
"external interrupt".

But I dunno, maybe INT or VEC is clearer? .. or TRAP :)

cheers
