Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSqSg5S0fzDrpk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 11:56:03 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ez1so10110511pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 18:56:03 -0700 (PDT)
Subject: Re: [RESEND][v2][PATCH] KVM: PPC: Book3S HV: Migrate pinned pages out
 of CMA
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
References: <20160714042536.GG18277@balbir.ozlabs.ibm.com>
 <3ba0fa6c-bfe6-a395-9c32-db8d6261559d@ozlabs.ru>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <cf34d62d-164c-bc7b-5538-ebd3c22657a5@gmail.com>
Date: Tue, 6 Sep 2016 11:55:54 +1000
MIME-Version: 1.0
In-Reply-To: <3ba0fa6c-bfe6-a395-9c32-db8d6261559d@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31/08/16 14:14, Alexey Kardashevskiy wrote:
> On 14/07/16 14:25, Balbir Singh wrote:
>>
>> From: Balbir Singh <bsingharora@gmail.com>
>> Subject: [RESEND][v2][PATCH] KVM: PPC: Book3S HV: Migrate pinned pages out of CMA
>>
>> When PCI Device pass-through is enabled via VFIO, KVM-PPC will
>> pin pages using get_user_pages_fast(). One of the downsides of
>> the pinning is that the page could be in CMA region. The CMA
>> region is used for other allocations like the hash page table.
>> Ideally we want the pinned pages to be from non CMA region.
>>
>> This patch (currently only for KVM PPC with VFIO) forcefully
>> migrates the pages out (huge pages are omitted for the moment).
>> There are more efficient ways of doing this, but that might
>> be elaborate and might impact a larger audience beyond just
>> the kvm ppc implementation.
>>
>> The magic is in new_iommu_non_cma_page() which allocates the
>> new page from a non CMA region.
>>
>> I've tested the patches lightly at my end, but there might be bugs
>> For example if after lru_add_drain(), the page is not isolated
>> is this a BUG?
>>
>> Previous discussion was at
>> http://permalink.gmane.org/gmane.linux.kernel.mm/136738
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@ozlabs.org>
>> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> 
> 
> 
> Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 

Thanks! I tested this patch against latest mainline and here are the test results


System RAM - 64GB

VM instance 1 - size 55GB

Before patch - nr_free_cma after launch 8900
After patch - nr_free_cma after launch 39500

Balbir Singh.
