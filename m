Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgz4H6BldzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 00:16:47 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61EED7h107569
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:16:45 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23w62xxdkv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 10:16:45 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sat, 2 Jul 2016 00:16:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 762962CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 00:16:39 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61EGduZ16318628
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Jul 2016 00:16:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61EGcov030174
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 Jul 2016 00:16:39 +1000
Date: Fri, 01 Jul 2016 19:46:35 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>
CC: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, mpe@ellerman.id.au, bsingharora@gmail.com,
 David.Laight@ACULAB.COM, arnd@arndb.de
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
 <577624A3.2000406@linaro.org>
In-Reply-To: <577624A3.2000406@linaro.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <57767B43.3000802@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/01/2016 01:36 PM, Daniel Lezcano wrote:
> On 06/30/2016 05:37 PM, Nicolas Pitre wrote:
>> On Thu, 30 Jun 2016, Daniel Lezcano wrote:
>>> +    }
>>>> +}
>>>
>>>
>>> What bothers me with this division is the benefit of adding an extra
>>> ultra
>>> optimized division by 1000 in cpuidle.h while we have already
>>> ktime_divns
>>> which is optimized in ktime.h.
>>
>> It is "optimized" but still much heavier than what is presented above as
>> it provides maximum precision.
>>
>> It all depends on how important the performance gain from the original
>> shift by 10 was in the first place.
> 
> Actually the original shift was there because it was convenient as a
> simple ~div1000 operation. But against all odds, the approximation
> introduced a regression on a very specific use case on PowerPC.
> 
> We are not in the hot path and I think we can live with a ktime_divns
> without problem. That would simplify the fix I believe.
> 

I agree too. I'll post next version with this.

Thanks,
Shreyas
