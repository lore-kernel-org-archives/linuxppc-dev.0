Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkzfm5WKxzDqZL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 19:54:24 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H8nCgj004361
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 04:54:20 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297vy3cuye-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 04:54:19 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 17 Mar 2017 14:24:16 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2H8sAuN13238370
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:24:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2H8sAsl025922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:24:12 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 10/11] powerpc/mm/radix: Make max pfn bits a variable
In-Reply-To: <20170316222942.GJ10100@fergus.ozlabs.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489660329-22501-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170316222942.GJ10100@fergus.ozlabs.ibm.com>
Date: Fri, 17 Mar 2017 14:24:08 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1dgffm7.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Thu, Mar 16, 2017 at 04:02:08PM +0530, Aneesh Kumar K.V wrote:
>> This makes max pysical address bits a variable so that hash and radix
>> translation mode can choose what value to use. In this patch we also switch the
>> radix translation mode to use 57 bits. This make it resilient to future changes
>> to max pfn supported by platforms.
>> 
>> This patch is split from the previous one to make the review easier.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Why do we need to do this now?  It seems like this will add overhead
> every time we set a PTE for no current benefit.

I was trying to make sure that radix kernel can run on future version of
hardware where the max pfn bit is different.

-aneesh
