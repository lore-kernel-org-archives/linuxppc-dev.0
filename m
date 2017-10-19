Return-Path: <srs0=6tmr=bs=linux.vnet.ibm.com=tuliom@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHqhF5ZzFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 00:36:13 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yHqhF4zvNz8tBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 00:36:13 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yHqhF1y4zz9t42
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2017 00:36:13 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JDaB88048381
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2017 09:36:11 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpu637j4t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2017 09:36:07 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tuliom@linux.vnet.ibm.com>;
 Thu, 19 Oct 2017 07:34:15 -0600
From: "Tulio Magno Quites Machado Filho" <tuliom@linux.vnet.ibm.com>
To: Florian Weimer <fweimer@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@ozlabs.org, Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
Cc: 
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
In-Reply-To: <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
Date: Thu, 19 Oct 2017 11:34:09 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760bbb6su.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Forwarding some comments from Adhemerval sent to libc-alpha [1]...

Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
>Florian Weimer <fweimer@redhat.com> writes:
>
>> On 10/12/2017 12:17 PM, Michael Ellerman wrote:
>>> +	pr_info("Enabling TM (Transactional Memory) with Suspend Disabled\n");
>>> +	cur_cpu_spec->cpu_features |= CPU_FTR_TM;
>>> +	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NO_SUSPEND;
>>> +	tm_suspend_disabled = true;
>>
>> This doesn't look right because if suspend is not available, you need to 
>> clear the original PPC_FEATURE2_HTM flag because the semantics are not 
>> right, so that applications can use fallback code.  Otherwise, 
>> applications may incorrectly select the HTM code and break if running on 
>> a system which supports HTM, but without the suspend state.
>>
>> The new flag should say that HTM is supported, but without the suspend 
>> state, and it should be always set if PPC_FEATURE2_HTM is set.
>
> Will it also change TEXARS with the abort information?

It should, with a permanent error cause so that old applications entering
suspended state can adopt another technique.
Michael, could you clarify if this is indeed happening, please?

> I completely agree with Florian here, this is as *ABI* change
> and the kernel need to advertise a different TM ABI instead
> of as an extension.

Adhemerval, could you elaborate which problems you're foreseeing, please?

-- 
Tulio Magno

[1] https://sourceware.org/ml/libc-alpha/2017-10/msg00893.html
