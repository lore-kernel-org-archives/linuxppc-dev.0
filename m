Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPnKL0typzDrn1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 13:09:08 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8132WkB037865
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:09:04 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2569u0e4j9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:09:03 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 13:09:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 14D993578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 13:08:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8138wCv27459672
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 13:08:58 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8138vG0014404
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 13:08:57 +1000
Subject: Re: [PATCH 00/13] Add support for perf_arch_regs
To: Nilay Vaish <nilayvaish@gmail.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <CACbG3094rSX9qfngBPSzetG21_=yW1pdxcAeVZOyNj=AJmdL6Q@mail.gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 1 Sep 2016 08:38:56 +0530
MIME-Version: 1.0
In-Reply-To: <CACbG3094rSX9qfngBPSzetG21_=yW1pdxcAeVZOyNj=AJmdL6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dff96585-7f0e-5b81-e318-902f5c03bfb8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 30 August 2016 09:31 PM, Nilay Vaish wrote:
> On 28 August 2016 at 16:00, Madhavan Srinivasan
> <maddy@linux.vnet.ibm.com> wrote:
>> Patchset to extend PERF_SAMPLE_REGS_INTR to include
>> platform specific PMU registers.
>>
>> Patchset applies cleanly on tip:perf/core branch
>>
>> It's a perennial request from hardware folks to be able to
>> see the raw values of the pmu registers. Partly it's so that
>> they can verify perf is doing what they want, and some
>> of it is that they're interested in some of the more obscure
>> info that isn't plumbed out through other perf interfaces.
>>
>> Over the years internally we have used various hack to get
>> the requested data out but this is an attempt to use a
>> somewhat standard mechanism (using PERF_SAMPLE_REGS_INTR).
>>
>> This would also be helpful for those of us working on the perf
>> hardware backends, to be able to verify that we're programming
>> things correctly, without resorting to debug printks etc.
>>
>> Mechanism proposed:
>>
>> 1)perf_regs structure is extended with a perf_arch_regs structure
>> which each arch/ can populate with their specific platform
>> registers to sample on each perf interrupt and an arch_regs_mask
>> variable, which is for perf tool to know about the perf_arch_regs
>> that are supported.
>>
>> 2)perf/core func perf_sample_regs_intr() extended to update
>> the perf_arch_regs structure and the perf_arch_reg_mask. Set of new
>> support functions added perf_get_arch_regs_mask() and
>> perf_get_arch_reg() to aid the updates from arch/ side.
>>
>> 3) perf/core funcs perf_prepare_sample() and perf_output_sample()
>> are extended to support the update for the perf_arch_regs_mask and
>> perf_arch_regs in the sample
>>
>> 4)perf/core func perf_output_sample_regs() extended to dump
>> the arch_regs to the output sample.
>>
>> 5)Finally, perf tool side is updated to include a new element
>> "arch_regs_mask" in the "struct regs_dump", event sample funcs
>> and print functions are updated to support perf_arch_regs.
>>
> I read the patch series and I have one suggestion to make.  I think we
> should not use 'arch regs' to refer to these pmu registers.  I think
Reason is that they are arch specific pmu regs. But I guess we can go with
pmu_regs also. And having a "pregs" as option to list in -I? will be fine?
(patch 13 in the patch series)


Maddy

> architectural registers typically refer to the ones that hold the
> state of the process.  Can we replace arch_regs by pmu_regs, or some
> other choice?
>
> Thanks
> Nilay
>
