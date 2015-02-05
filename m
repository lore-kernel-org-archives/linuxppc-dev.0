Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 281591A0AD3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 15:57:15 +1100 (AEDT)
Received: by mail-pa0-f49.google.com with SMTP id fa1so7452463pad.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 20:57:13 -0800 (PST)
Message-ID: <54D2F820.5020607@ozlabs.ru>
Date: Thu, 05 Feb 2015 15:57:04 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 12/24] powerpc/iommu/powernv: Release replaced TCE
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
 <1422523325-1389-13-git-send-email-aik@ozlabs.ru>
 <20150204060822.GA8644@iris.ozlabs.ibm.com>
In-Reply-To: <20150204060822.GA8644@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=koi8-r
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Gordeev <agordeev@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/04/2015 05:08 PM, Paul Mackerras wrote:
> On Thu, Jan 29, 2015 at 08:21:53PM +1100, Alexey Kardashevskiy wrote:
>> At the moment writing new TCE value to the IOMMU table fails with EBUSY
>> if there is a valid entry already. However PAPR specification allows
>> the guest to write new TCE value without clearing it first.
>>
>> Another problem this patch is addressing is the use of pool locks for
>> external IOMMU users such as VFIO. The pool locks are to protect
>> DMA page allocator rather than entries and since the host kernel does
>> not control what pages are in use, there is no point in pool locks and
>> exchange()+put_page(oldtce) is sufficient to avoid possible races.
>>
>> This adds an exchange() callback to iommu_table_ops which does the same
>> thing as set() plus it returns replaced TCE(s) so the caller can release
>> the pages afterwards.
>>
>> This implements exchange() for IODA2 only. This adds a requirement
>> for a platform to have exchange() implemented so from now on IODA2 is
>> the only supported PHB for VFIO-SPAPR.
>>
>> This replaces iommu_tce_build() and iommu_clear_tce() with
>> a single iommu_tce_xchg().
> 
> [snip]
> 
>> @@ -294,8 +303,9 @@ static long tce_iommu_build(struct tce_container *container,
>>  
>>  		hva = (unsigned long) page_address(page) +
>>  			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
>> +		oldtce = 0;
>>  
>> -		ret = iommu_tce_build(tbl, entry + 1, hva, direction);
>> +		ret = iommu_tce_xchg(tbl, entry + i, hva, &oldtce, direction);
> 
> Is the change from entry + 1 to entry + i here an actual bug fix?
> If so please mention it in the patch description.

This patch added the bug:
[PATCH v3 01/24] vfio: powerpc/spapr: Move page pinning from arch code to
VFIO IOMMU driver

Will fix in the next try.


-- 
Alexey
