Return-Path: <ricklind@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3f7s2w7RzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:43:53 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DBhgTR053423
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:43:43 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t699q1ty-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:43:42 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ricklind@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 05:43:40 -0600
Subject: Re: [PATCH] arch/powerpc/mm/slice: Cleanup leftover use of task_size
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
 <87poggpo9l.fsf@skywalker.in.ibm.com>
From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 04:43:35 -0700
MIME-Version: 1.0
In-Reply-To: <87poggpo9l.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a079dfea-2894-08d9-a229-738649b49b6c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2017 03:58 AM, Aneesh Kumar K.V wrote:

> I would suggest we don't do this change now. But rather we audit the
> usage of TASK_SIZE(), mm->task_size and move them correctly to
> mm->task_size and mm->context.addr_limit. The context.addr_limit is
> added as an optimization for slice_mask copy and we need to closely
> audit to make sure we can use that as a boundary condition for error
> checking in case of mmap.

I do agree that extending the address space could affect other
code because of the use of TASK_SIZE. and we need to examine
"the big picture" to resolve the usage of addr_limit, task_size,
and TASK_SIZE. But without this small change now, I don't see how
the extended address space is made available at all in the non-radix
case. Are we acknowledging that 512TB address space is only available
when radix is enabled?

Rick
