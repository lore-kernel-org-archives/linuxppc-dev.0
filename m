Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz72W6qHyzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:07:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6Q63PGE032699
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:07:45 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c4rqm1ks-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:07:45 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 16:07:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D76922BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:07:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6Q67csx29229210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:07:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6Q67bTf027380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:07:38 +1000
Subject: Re: [RFC PATCH 5/9] powerpc: reverse the soft_enable logic
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-6-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726153103.26dda0ce@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 11:37:35 +0530
MIME-Version: 1.0
In-Reply-To: <20160726153103.26dda0ce@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <74604978-6d7d-11a9-73f2-d04ca23ea060@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 11:01 AM, Nicholas Piggin wrote:
> On Mon, 25 Jul 2016 20:22:18 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> "paca->soft_enabled" is used as a flag to mask some of interrupts.
>> Currently supported flags values and their details:
>>
>> soft_enabled		MSR[EE]
>>
>> 0			0	Disabled (PMI and HMI not masked)
>> 1			1	Enabled
>>
>> "paca->soft_enabled" is initialed to 1 to make the interripts as
>> enabled. arch_local_irq_disable() will toggle the value when
>> interrupts needs to disbled. At this point, the interrupts are not
>> actually disabled, instead, interrupt vector has code to check for
>> the flag and mask it when it occurs. By "mask it", it updated
>> interrupt paca->irq_happened and return. arch_local_irq_restore() is
>> called to re-enable interrupts, which checks and replays interrupts
>> if any occured.
>>
>> Now, as mentioned, current logic doesnot mask "performance monitoring
>> interrupts" and PMIs are implemented as NMI. But this patchset
>> depends on local_irq_* for a successful local_* update. Meaning, mask
>> all possible interrupts during local_* update and replay them after
>> the update.
>>
>> So the idea here is to reserve the "paca->soft_enabled" logic. New
>> values and details:
>>
>> soft_enabled		MSR[EE]
>>
>> 1			0	Disabled  (PMI and HMI not masked)
>> 0			1	Enabled
>>
>> Reason for the this change is to create foundation for a third flag
>> value "2" for "soft_enabled" to add support to mask PMIs. When
>> arch_irq_disable_* is called with a value "2", PMI interrupts are
>> mask. But when called with a value of "1", PMI are not mask.
>>
>> With new flag value for "soft_enabled", states looks like:
>>
>> soft_enabled		MSR[EE]
>>
>> 2			0	Disbaled PMIs also
>> 1			0	Disabled  (PMI and HMI not masked)
>> 0			1	Enabled
>>
>> And interrupt handler code for checking has been modified to check for
>> for "greater than or equal" to 1 condition instead.
> This bit of the patch seems to have been moved into other part
> of the series. Ideally (unless there is a good reason), it is nice
> to have each individual patch result in a working kernel before
> and after.
Agreed. But I need to reason out the change and hence add
all info here. But will edit the info in the next version.

Maddy


>
> Nice way to avoid adding more branches though.
>
> Thanks,
> Nick
>
