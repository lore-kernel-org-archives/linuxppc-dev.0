Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3fGC1V6wzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:49:22 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DBhhV7138049
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:49:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t2muqwhb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:49:07 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 05:49:06 -0600
Subject: Re: [PATCH] arch/powerpc/mm/slice: Cleanup leftover use of task_size
To: Rick Lindsley <ricklind@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
 <87poggpo9l.fsf@skywalker.in.ibm.com>
 <a079dfea-2894-08d9-a229-738649b49b6c@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 17:18:56 +0530
MIME-Version: 1.0
In-Reply-To: <a079dfea-2894-08d9-a229-738649b49b6c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <69d71c21-38ee-c210-6ed0-a02ac506c86d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 13 April 2017 05:13 PM, Rick Lindsley wrote:
> On 04/13/2017 03:58 AM, Aneesh Kumar K.V wrote:
>
>> I would suggest we don't do this change now. But rather we audit the
>> usage of TASK_SIZE(), mm->task_size and move them correctly to
>> mm->task_size and mm->context.addr_limit. The context.addr_limit is
>> added as an optimization for slice_mask copy and we need to closely
>> audit to make sure we can use that as a boundary condition for error
>> checking in case of mmap.
>
> I do agree that extending the address space could affect other
> code because of the use of TASK_SIZE. and we need to examine
> "the big picture" to resolve the usage of addr_limit, task_size,
> and TASK_SIZE. But without this small change now, I don't see how
> the extended address space is made available at all in the non-radix
> case. Are we acknowledging that 512TB address space is only available
> when radix is enabled?
>

Those code path you modified doesn't control the address allocation. The 
relevant bits are

	/*
	 * This mmap request can allocate upt to 512TB
	 */
	if (addr > DEFAULT_MAP_WINDOW)
		high_limit = mm->context.addr_limit;
	else
		high_limit = DEFAULT_MAP_WINDOW;
	

and for topdown search

	addr = mm->mmap_base;
	/*
	 * If we are trying to allocate above DEFAULT_MAP_WINDOW
	 * Add the different to the mmap_base.
	 * Only for that request for which high_limit is above
	 * DEFAULT_MAP_WINDOW we should apply this.
	 */
	if (high_limit  > DEFAULT_MAP_WINDOW)
		addr += mm->context.addr_limit - DEFAULT_MAP_WINDOW;


and for bottom up search

	addr = TASK_UNMAPPED_BASE;
	/*
	 * Check till the allow max value for this mmap request
	 */
	while (addr < high_limit) {
	

-aneesh
