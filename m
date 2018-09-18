Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F4Fq4GzQzDrCp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:53:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8IDdnh6013295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 09:53:17 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mk1234ux0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 09:53:16 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 18 Sep 2018 07:53:16 -0600
Subject: Re: [RFC PATCH 3/3] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
To: David Gibson <david@gibson.dropbear.id.au>
Cc: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
References: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
 <20180903163733.27965-4-aneesh.kumar@linux.ibm.com>
 <20180918035116.GA30868@umbus.fritz.box>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 18 Sep 2018 19:23:05 +0530
MIME-Version: 1.0
In-Reply-To: <20180918035116.GA30868@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ff666ec0-9dc1-304d-387d-19e1a90e17e0@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/18/18 9:21 AM, David Gibson wrote:
> On Mon, Sep 03, 2018 at 10:07:33PM +0530, Aneesh Kumar K.V wrote:
>> Current code doesn't do page migration if the page allocated is a compound page.
>> With HugeTLB migration support, we can end up allocating hugetlb pages from
>> CMA region. Also THP pages can be allocated from CMA region. This patch updates
>> the code to handle compound pages correctly.
>>
>> This add a new helper get_user_pages_cma_migrate. It does one get_user_pages
>> with right count, instead of doing one get_user_pages per page. That avoids
>> reading page table multiple times. The helper could possibly used by other
>> subystem if we have more users.
>>
>> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
>> We use the same storage location to store pointers to struct page. We cannot
>> update alll the code path use struct page *, because we access hpas in real mode
>> and we can't do that struct page * to pfn conversion in real mode.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> This approach doesn't seem quite right to me.  It's specific to pages
> mapped into the IOMMU.  It's true that will address the obvious case
> we have, of vfio-using guests fragmenting the CMA for other guests.
> 
> But AFAICT, fragmenting the CMA coud happen with *any* locked memory,
> not just things that are IOMMU mapped for VFIO.  So, for example a
> guest not using vfio, but using -realtime mlock=on, or an unrelated
> program using locked memory (e.g. gpg or something else that locks
> memory for security reasons).
> 
> AFAICT this approach won't fix the problem for that case.
> 

yes and we should be migrate away pages that we allocated out of CMA 
region before we pin/mlock them. This handle the long term pin w.r.t 
vfio. For mlock too we should do that.

-aneesh
