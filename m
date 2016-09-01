Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPp3v4ZqtzDrn1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 13:42:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u813XGdd094052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:42:33 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256aranet0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:42:33 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 09:12:30 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 42F7CE0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 09:11:30 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u813gQUg30671080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 09:12:26 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u813gNa4008569
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 09:12:26 +0530
Subject: Re: [PATCH 04/13] perf/core: Extend perf_output_sample_regs() to
 include perf_arch_regs
To: Nilay Vaish <nilayvaish@gmail.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472418058-28659-5-git-send-email-maddy@linux.vnet.ibm.com>
 <CACbG308C-mCLxQbZ2ZmXFiC4FdV=e-k6gKMgHeyUZ9E53epu8g@mail.gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 1 Sep 2016 09:12:22 +0530
MIME-Version: 1.0
In-Reply-To: <CACbG308C-mCLxQbZ2ZmXFiC4FdV=e-k6gKMgHeyUZ9E53epu8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2e315e8f-bb95-b083-cc6c-c7aafd3d0efb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 30 August 2016 09:41 PM, Nilay Vaish wrote:
> On 28 August 2016 at 16:00, Madhavan Srinivasan
> <maddy@linux.vnet.ibm.com> wrote:
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 274288819829..e16bf4d057d1 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5371,16 +5371,24 @@ u64 __attribute__((weak)) perf_arch_reg_value(struct perf_arch_regs *regs,
>>
>>   static void
>>   perf_output_sample_regs(struct perf_output_handle *handle,
>> -                       struct pt_regs *regs, u64 mask)
>> +                               struct perf_regs *regs, u64 mask)
>>   {
>>          int bit;
>>          DECLARE_BITMAP(_mask, 64);
>> +       u64 arch_regs_mask = regs->arch_regs_mask;
>>
>>          bitmap_from_u64(_mask, mask);
>>          for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
>>                  u64 val;
>>
>> -               val = perf_reg_value(regs, bit);
>> +               val = perf_reg_value(regs->regs, bit);
>> +               perf_output_put(handle, val);
>> +       }
>> +
>> +       bitmap_from_u64(_mask, arch_regs_mask);
>> +       for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
>> +               u64 val;
>> +               val = perf_arch_reg_value(regs->arch_regs, bit);
>>                  perf_output_put(handle, val);
>>          }
>>   }
>> @@ -5792,7 +5800,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>>                  if (abi) {
>>                          u64 mask = event->attr.sample_regs_user;
>>                          perf_output_sample_regs(handle,
>> -                                               data->regs_user.regs,
>> +                                               &data->regs_user,
>>                                                  mask);
>>                  }
>>          }
>> @@ -5827,7 +5835,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>>                          u64 mask = event->attr.sample_regs_intr;
>>
>>                          perf_output_sample_regs(handle,
>> -                                               data->regs_intr.regs,
>> +                                               &data->regs_intr,
>>                                                  mask);
>>                  }
>>          }
>> --
>> 2.7.4
>>
> I would like to suggest a slightly different version.  Would it make
> more sense to have something like following:

I agree we are outputting two different structures, but since we use the
INTR_REG infrastructure to dump the arch pmu registers, I preferred to
extend perf_output_sample_regs. But I guess I can break it up.

Maddy

>
> @@ -5792,7 +5800,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>                   if (abi) {
>                          u64 mask = event->attr.sample_regs_user;
>                          perf_output_sample_regs(handle,
>                                                  data->regs_user.regs,
>                                                  mask);
>                  }
> +
> +              if (arch_regs_mask) {
> +                   perf_output_pmu_regs(handle,
> data->regs_users.arch_regs, arch_regs_mask);
> +              }
>          }
>
>
> Somehow I don't like outputting the two sets of registers through the
> same function call.
>
> --
> Nilay
>
