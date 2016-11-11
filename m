Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFMyj4ZvkzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:39:09 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAB1d7ug069193
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:39:07 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mwc71dpf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:39:07 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 18:39:01 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] hugetlb: Change the function prototype to take
 vma_area_struct as arg
In-Reply-To: <1478806599.7430.139.camel@kernel.crashing.org>
References: <20161110092918.21139-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161110092918.21139-3-aneesh.kumar@linux.vnet.ibm.com>
 <1478806599.7430.139.camel@kernel.crashing.org>
Date: Fri, 11 Nov 2016 07:08:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760nu23th.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2016-11-10 at 14:59 +0530, Aneesh Kumar K.V wrote:
>> This help us to find the hugetlb page size which we need ot use on some
>> archs like ppc64 for tlbflush. This also make the interface consistent
>> with other hugetlb functions
>
> What about my requested simpler approach ?

Still working on the changes.

>
> For normal (non-huge) pages, we already know the size.
>
> For huge pages, can't we encode in the top SW bits of the PTE the
> page size that we obtain from set_pte_at ?
>
> That would be a lot less churn and avoid touching all these archs...
> especially since the current DD1 workaround is horrible and I want
> the fix to be backported, so something simpler and contained in
> arch/powerpc feels more suitable.
>

My take as of now is even though the modification lines will be less, it
is going to be much more difficult to follow and backport. I will try to
do a patch to show the complexity and we can decide which approach is
simpler.

-aneesh
