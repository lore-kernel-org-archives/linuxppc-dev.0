Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsvmS1Y7LzDqkL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 02:23:20 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SFE489113523
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:23:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29fsw9tf01-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:23:08 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 11:23:07 -0400
Subject: Re: [PATCH V5 16/17] mm: Let arch choose the initial value of task
 size
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490153823-29241-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87vaqtabw8.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 28 Mar 2017 20:52:58 +0530
MIME-Version: 1.0
In-Reply-To: <87vaqtabw8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6c8904b5-c4a0-b828-6aad-14220efc5236@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 28 March 2017 04:47 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> As we start supporting larger address space (>128TB), we want to give
>> architecture a control on max task size of an application which is different
>> from the TASK_SIZE. For ex: ppc64 needs to track the base page size of a segment
>> and it is copied from mm_context_t to PACA on each context switch. If we know that
>> application has not used an address range above 128TB we only need to copy
>> details about 128TB range to PACA. This will help in improving context switch
>> performance by avoiding larger copy operation.
>>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: linux-mm@kvack.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  fs/exec.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> I'll need an ACK at least on this from someone in mm land.
>
> I assume there's no way I can merge patch 17 without this?

That is correct.

I didn't add linux-mm to cc for rest of the patches. They are all ppc64 
specific and can be found at

https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-March/155726.html


-aneesh
