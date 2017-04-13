Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3rZH3VY5zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 05:33:59 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DJXoqh072624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:33:50 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t6qvt1wt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:33:50 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 14 Apr 2017 01:03:43 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3DJWJlO6488152
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 01:02:19 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3DJXebC003852
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 01:03:41 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: ricklind@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: Rick Lindsley <ricklind@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc/mm/slice: Cleanup leftover use of task_size
In-Reply-To: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
References: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
Date: Fri, 14 Apr 2017 01:03:40 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgr4p0ff.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ricklind@linux.vnet.ibm.com writes:

> From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
>

> However, the non-radix path falls through to the old, hashed slice code
> (slice_get_unmapped_area, etc.) and these code paths still inspect
> task_size.  The same attention to addr_limit made in (for example)
> radix__arch_get_unmapped_area() should also be applied to (correspondingly)
> slice_get_unmapped_area().

I missed this part earlier. I guess that should be fixed in radix code.
This came in via fbfef9027c2a7ad9277755509fdb849dbccfe8c1 (powerpc/mm:
Switch some TASK_SIZE checks to use mm_context addr_limit). That patch
needs update. When we switched from mm->task_size to
mm->context.addr_limit in latest version of the patch, we missed
updating the above correctly. I have now send a version  which should
update this correctly.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/156781.html

With this we use addr_limit only for slice mask optimization and addr
serach limit. All the boundary check is now based on mm->task_size.

We will later consolidate TASK_SIZE/mm->task_size/mm->context.addr_limit

-aneesh
