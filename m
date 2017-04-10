Return-Path: <srs0=+w2q=3s=linux.vnet.ibm.com=maddy@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1btn6QVnzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:55:29 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1btn50XHz8t6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 13:55:29 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1btn1XcJz9s7d
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:55:28 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A3sTFL018958
 for <linuxppc-dev@ozlabs.org>; Sun, 9 Apr 2017 23:55:25 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29qym95x87-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 09 Apr 2017 23:55:24 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 13:55:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A3tCLG49348626
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:55:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A3si7n015169
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 13:54:44 +1000
Subject: Re: kselftest:lost_exception_test failure with 4.11.0-rc5
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
References: <2868072E-9D12-4BE0-94F6-FE9C33A3766F@linux.vnet.ibm.com>
 <87r314gzt1.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 09:24:28 +0530
MIME-Version: 1.0
In-Reply-To: <87r314gzt1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6ffc8fd9-63f9-b1b0-864c-3ab546cb1d5f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 07 April 2017 06:06 PM, Michael Ellerman wrote:
> Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
>
>> I have run into few instances where the lost_exception_test from
>> powerpc kselftest fails with SIGABRT. Following o/p is against
>> 4.11.0-rc5. The failure is intermittent.
> What hardware are you on?
>
> How long does it take to run when it fails? I assume ~2 minutes?

Started a run in power8 host (habanero) and it is more than 24hrs and
havent failed yet. So this should be guest/VM scenario then?

>
>> When the test fails it is killed due to SIGABRT.
>> # ./lost_exception_test
>> test: lost_exception
>> tags: git_version:unknown
>> Binding to cpu 8
>> main test running as pid 9208
>> EBB Handler is at 0x10003dcc
>> !! killing lost_exception
> This is the parent (test harness saying) it's about to kill the child,
> because it took too long.
>
> It sends SIGTERM, but the child catches that, prints all this info, and
> then aborts() - so that's why you're seeing SIGABRT.
>
>> ebb_state):
>>    ebb_count    = 191529
> The test usually runs until it's taken 1,000,000 EBBs, so it looks like
> we got stuck.
>
>>    spurious     = 0
>>    negative     = 0
>>    no_overflow  = 0
>>    pmc[1] count = 0x0
>>    pmc[2] count = 0x0
>>    pmc[3] count = 0x0
>>    pmc[4] count = 0x4c1b707
> We use a varying sample period of between 400 and 600, and from above
> we've taken 191,529 EBBs.
>
> 0x4c1b707 / 191,529 ~= 416
>
> So that looks reasonable.
>
>>    pmc[5] count = 0x0
>>    pmc[6] count = 0x0
>> HW state:
>> MMCR0 0x0000000080000080 FC PMAO
> But this says we're stopped with counters frozen and an event pending.
>
>> MMCR2 0x0000000000000000
>> EBBHR 0x0000000010003dcc
>> BESCR 0x8000000100000000 GE PMAE
> And that says we have global enable set and events enabled.
>
>
> So I think there is a bug here somewhere. I don't really have time to
> dig into it now, neither does Maddy I think. But we should try and get
> to it at some point.
>
> cheers
>
