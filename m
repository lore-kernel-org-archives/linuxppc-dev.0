Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDsNT2NQ8zDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 00:40:57 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7HEZ5Y3135014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 10:40:55 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24v75yw33n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 10:40:55 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 15:40:52 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B3F381B08023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:42:23 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7HEeleI23724264
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 14:40:47 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7HEej3g018173
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 08:40:46 -0600
Subject: Re: [PATCH] ppc64: allow ptrace to set TM bits
To: Simon Guo <wei.guo.simon@gmail.com>
References: <1469785882-9892-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20160802054351.GA16975@simonLocalRHEL7.x64>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 17 Aug 2016 16:40:45 +0200
MIME-Version: 1.0
In-Reply-To: <20160802054351.GA16975@simonLocalRHEL7.x64>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4c63e67b-3d9d-67ee-24a9-9e35631c68ff@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/08/2016 07:43, Simon Guo wrote:
> Hi Laurent,
> On Fri, Jul 29, 2016 at 11:51:22AM +0200, Laurent Dufour wrote:
>>  static int set_user_msr(struct task_struct *task, unsigned long msr)
>>  {
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +	if (!(task->thread.regs->msr & MSR_TM)) {
>> +		/* If TM is not available, discard TM bits changes */
>> +		msr &= ~(MSR_TM | MSR_TS_MASK);
>> +	}
>> +#endif
> 
> I am not sure whether following is an issue:
> Per PowerISA, any exception/interrupt will disable MSR[TM] bit 
> automatically and mark MSR_TS to be suspended when it is 
> transactional. It is possible that MSR[TM] = 0 and MSR[MSR_TS] != 0
> (suspended). 
> 
> Will set_user_msr() be able to escape from the above?
>  For example, one user space application encountered 
> page fault during transaction, its task->thread.regs->msr & MSR_TM == 0
> and MSR[MSR_TS] == suspended.  Then it is being traced and 
> set_user_msr() is invoked on it. I think it will be incorrect to 
> clear its  MSR_TS_MASK bits.....

You raised a good point, but I'm not sure this case is valid.
The interrupt case you described is happening in the kernel, not in user
space, and set_user_msr() is dealing with the user space register's
state, not the kernel's one.
So it can't apply and I can't see how in user space MSR[TM]=0 and
MSR[TS]=1 could happen.

Am I missing something here ?

Thanks,
Laurent.
