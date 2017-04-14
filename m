Return-Path: <ricklind@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w45rW27fBzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 15:32:10 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3E5Sbam126347
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 01:32:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29tp4auwf8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 01:32:03 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ricklind@linux.vnet.ibm.com>;
 Fri, 14 Apr 2017 01:32:02 -0400
Subject: Re: [PATCH] arch/powerpc/mm/slice: Cleanup leftover use of task_size
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
 <87lgr4p0ff.fsf@skywalker.in.ibm.com>
From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 22:31:58 -0700
MIME-Version: 1.0
In-Reply-To: <87lgr4p0ff.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e9d2ec20-5067-9bd8-c709-0acf1ca9e86e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2017 12:33 PM, Aneesh Kumar K.V wrote:

> I missed this part earlier. I guess that should be fixed in radix code.
> This came in via fbfef9027c2a7ad9277755509fdb849dbccfe8c1 (powerpc/mm:
> Switch some TASK_SIZE checks to use mm_context addr_limit). That patch
> needs update. When we switched from mm->task_size to
> mm->context.addr_limit in latest version of the patch, we missed
> updating the above correctly. I have now send a version  which should
> update this correctly.

Ok - so the intent then is that you may extend your address space, but
you still may not allocate anything larger than task_size (which will
never be larger than 128TB)?  The section we are talking about is checking
the length of the request against task_size, so that means we may not
allocate a single vm area larger than 128TB even though it would be okay
to (say) allocate 3 of those within 512TB of address space?

Rick
