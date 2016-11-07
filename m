Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC4056DS9zDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:32:21 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA77Spea025697
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 02:32:19 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26jc1bjeg5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 02:32:19 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 17:32:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 753672CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 18:32:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA77WDZs18022556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:32:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA77WDkg006347
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:32:13 +1100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Use PMSR to verify global and local
 pstate
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20161104064132.GB3414@vireshk-i7>
Cc: linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Mon, 7 Nov 2016 13:02:10 +0530
MIME-Version: 1.0
In-Reply-To: <20161104064132.GB3414@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ce785008-f387-3e3f-243d-5d701fafc572@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Viresh for taking a look at it.

I will make the mentioned changes in the next version of the patch and
will add Shilpa and Gautham to the mail chain.

Regards

Akshay Adiga


On 11/04/2016 12:11 PM, Viresh Kumar wrote:
> On 04-11-16, 10:57, Akshay Adiga wrote:
>> As fast_switch may get called in interrupt disable mode, it does not
> s/in interrupt disable mode/with interrupts disabled
> s/it does/it may
>
>> update the global_pstate_info data structure. Hence the global_pstate_info
>> has stale data whenever pstate is updated through fast_swtich().
> s/has/may have
> s/swtich/switch
>
>> So the gpstate_timer can fire after a fast_switch() call has update
> s/So the/The
> s/a fast_swtich() call has update/the fast_switch() call has updated
>
>> the pstates to a different value. Hence the timer handler cannot rely
>> on the cached values of local and global pstate and needs to read it
>> from the PMSR.
>>
>> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
>>
>> ---
>>   drivers/cpufreq/powernv-cpufreq.c | 32 ++++++++++++++++++++++----------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
> I am not the best guy to judge the code changes here. Can you please include
> Shilpa and Gautham to the mail chain and get there feedback.
>
>
>
