Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHpmz5GpqzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:53:55 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M9mVGS015403
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:53:53 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y4q6a921-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:53:53 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 10:53:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3327917D8024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 10:55:33 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7M9rmTO5439800
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 09:53:48 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7M9rlAf029886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 03:53:47 -0600
Subject: Re: [PATCH] ppc64: allow ptrace to set TM bits
To: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
References: <1469785882-9892-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20160802054351.GA16975@simonLocalRHEL7.x64>
 <1471827666.758.3.camel@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 22 Aug 2016 11:53:46 +0200
MIME-Version: 1.0
In-Reply-To: <1471827666.758.3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <410ae489-935d-322c-8568-a4ab3f518594@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/08/2016 03:01, Cyril Bur wrote:
> On Tue, 2016-08-02 at 13:43 +0800, Simon Guo wrote:
>> Hi Laurent,
>> On Fri, Jul 29, 2016 at 11:51:22AM +0200, Laurent Dufour wrote:
>>>
>>>  static int set_user_msr(struct task_struct *task, unsigned long
>>> msr)
>>>  {
>>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>> +	if (!(task->thread.regs->msr & MSR_TM)) {
>>> +		/* If TM is not available, discard TM bits changes
>>> */
>>> +		msr &= ~(MSR_TM | MSR_TS_MASK);
>>> +	}
>>> +#endif
>>
>> I am not sure whether following is an issue:
>> Per PowerISA, any exception/interrupt will disable MSR[TM] bit 
>> automatically and mark MSR_TS to be suspended when it is 
>> transactional. It is possible that MSR[TM] = 0 and MSR[MSR_TS] != 0
>> (suspended). 
>>
>> Will set_user_msr() be able to escape from the above?
>>  For example, one user space application encountered 
>> page fault during transaction, its task->thread.regs->msr & MSR_TM ==
>> 0
>> and MSR[MSR_TS] == suspended.  Then it is being traced and 
>> set_user_msr() is invoked on it. I think it will be incorrect to 
>> clear its  MSR_TS_MASK bits.....
>>
>> (suspended).ible that MSRTM] = 0 and MSR[MSR_TS] != 0> (suspended).
> 
>> Please correct me if I am wrong.
> 
> I'm not very familiar with ptracing and exactly what can happen but I
> agree with Simon. Trying to change an MSR with that possible condition
> stated ("It is possible that MSR[TM] = 0 and MSR[MSR_TS] !=
> 0> (suspended)") to MSR_TS and MSR_TS_MASK bits all 0 will cause a Bad
> Thing.

I don't think this may happen since from the user space point of view,
we can't have MSR[TM]=0 & MSR[MSR_TS]=1, because MSR[TM] will be set
once the transaction is initiated.

Anyway, this patch is no more required since the recent patch
http://patchwork.ozlabs.org/patch/661358/ is now dropping the TM state
form the signal return path, which is enough fof CRIU to work fine.

Cheers,
Laurent.
