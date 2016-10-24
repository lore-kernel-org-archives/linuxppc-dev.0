Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2Qf00nQSzDvWk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 17:01:43 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9O5whEP145835
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 02:01:41 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 268yyurjk2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 02:01:41 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 02:01:39 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Use tlbiel only if we ever ran on the current
 cpu
In-Reply-To: <9b21edc6-061b-ad66-1bbc-07c7d0048e6c@gmail.com>
References: <20161024032043.22455-1-aneesh.kumar@linux.vnet.ibm.com>
 <9b21edc6-061b-ad66-1bbc-07c7d0048e6c@gmail.com>
Date: Mon, 24 Oct 2016 11:31:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87funmb802.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 24/10/16 14:20, Aneesh Kumar K.V wrote:
>> Before this patch, we used tlbiel, if we ever ran only on this core.
>> That was mostly derived from the nohash usage of the same. But the
>> ISA 3.0 clarifies tlbiel such that
>> 
>> "All TLB entries that have all of the following properties are made
>> invalid on the thread executing the tlbiel instruction"
>> 
>> Hence use tlbiel, if we only ever ran on just the current cpu.
>> 
>
> Could you clarify the impact. The impact I see is that it could
> lead to us thinking we invalidated the TLB across the core whereas
> we did it only on the current thread? This could leave others threads
> in the same core with invalid TLB's, if cpumask reported we ran on
> other threads in the same core?

Correct.

-aneesh
