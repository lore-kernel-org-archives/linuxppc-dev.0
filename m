Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF73F1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 16:32:49 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so41421904pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:32:48 -0700 (PDT)
Message-ID: <5552F00A.5080004@ozlabs.ru>
Date: Wed, 13 May 2015 16:32:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 06/34] vfio: powerpc/spapr: Move page pinning
 from arch code to VFIO IOMMU driver
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-7-git-send-email-aik@ozlabs.ru>
 <20150513055809.GA3622@gwshan>
In-Reply-To: <20150513055809.GA3622@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2015 03:58 PM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:38:55AM +1000, Alexey Kardashevskiy wrote:
>> This moves page pinning (get_user_pages_fast()/put_page()) code out of
>> the platform IOMMU code and puts it to VFIO IOMMU driver where it belongs
>> to as the platform code does not deal with page pinning.
>>
>> This makes iommu_take_ownership()/iommu_release_ownership() deal with
>> the IOMMU table bitmap only.
>>
>> This removes page unpinning from iommu_take_ownership() as the actual
>> TCE table might contain garbage and doing put_page() on it is undefined
>> behaviour.
>>
>> Besides the last part, the rest of the patch is mechanical.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> Changes:
>> v9:
>> * added missing tce_iommu_clear call after iommu_release_ownership()
>> * brought @offset (a local variable) back to make patch even more
>> mechanical
>>
>> v4:
>> * s/iommu_tce_build(tbl, entry + 1/iommu_tce_build(tbl, entry + i/
>> ---
>> arch/powerpc/include/asm/iommu.h    |  4 --
>> arch/powerpc/kernel/iommu.c         | 55 -------------------------
>> drivers/vfio/vfio_iommu_spapr_tce.c | 80 +++++++++++++++++++++++++++++++------
>> 3 files changed, 67 insertions(+), 72 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index 8353c86..e94a5e3 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -194,10 +194,6 @@ extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
>> 		unsigned long hwaddr, enum dma_data_direction direction);
>> extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
>> 		unsigned long entry);
>> -extern int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
>> -		unsigned long entry, unsigned long pages);
>> -extern int iommu_put_tce_user_mode(struct iommu_table *tbl,
>> -		unsigned long entry, unsigned long tce);
>>
>> extern void iommu_flush_tce(struct iommu_table *tbl);
>> extern int iommu_take_ownership(struct iommu_table *tbl);
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 2c02d4c..8673c94 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -983,30 +983,6 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
>> }
>> EXPORT_SYMBOL_GPL(iommu_clear_tce);
>>
>> -int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
>> -		unsigned long entry, unsigned long pages)
>> -{
>> -	unsigned long oldtce;
>> -	struct page *page;
>> -
>> -	for ( ; pages; --pages, ++entry) {
>> -		oldtce = iommu_clear_tce(tbl, entry);
>> -		if (!oldtce)
>> -			continue;
>> -
>> -		page = pfn_to_page(oldtce >> PAGE_SHIFT);
>> -		WARN_ON(!page);
>> -		if (page) {
>> -			if (oldtce & TCE_PCI_WRITE)
>> -				SetPageDirty(page);
>> -			put_page(page);
>> -		}
>> -	}
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL_GPL(iommu_clear_tces_and_put_pages);
>> -
>> /*
>>   * hwaddr is a kernel virtual address here (0xc... bazillion),
>>   * tce_build converts it to a physical address.
>> @@ -1036,35 +1012,6 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
>> }
>> EXPORT_SYMBOL_GPL(iommu_tce_build);
>>
>> -int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
>> -		unsigned long tce)
>> -{
>> -	int ret;
>> -	struct page *page = NULL;
>> -	unsigned long hwaddr, offset = tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
>> -	enum dma_data_direction direction = iommu_tce_direction(tce);
>> -
>> -	ret = get_user_pages_fast(tce & PAGE_MASK, 1,
>> -			direction != DMA_TO_DEVICE, &page);
>> -	if (unlikely(ret != 1)) {
>> -		/* pr_err("iommu_tce: get_user_pages_fast failed tce=%lx ioba=%lx ret=%d\n",
>> -				tce, entry << tbl->it_page_shift, ret); */
>> -		return -EFAULT;
>> -	}
>> -	hwaddr = (unsigned long) page_address(page) + offset;
>> -
>> -	ret = iommu_tce_build(tbl, entry, hwaddr, direction);
>> -	if (ret)
>> -		put_page(page);
>> -
>> -	if (ret < 0)
>> -		pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
>> -			__func__, entry << tbl->it_page_shift, tce, ret);
>> -
>> -	return ret;
>> -}
>> -EXPORT_SYMBOL_GPL(iommu_put_tce_user_mode);
>> -
>> int iommu_take_ownership(struct iommu_table *tbl)
>> {
>> 	unsigned long sz = (tbl->it_size + 7) >> 3;
>> @@ -1078,7 +1025,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
>> 	}
>>
>> 	memset(tbl->it_map, 0xff, sz);
>> -	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
>>
>> 	/*
>> 	 * Disable iommu bypass, otherwise the user can DMA to all of
>> @@ -1096,7 +1042,6 @@ void iommu_release_ownership(struct iommu_table *tbl)
>> {
>> 	unsigned long sz = (tbl->it_size + 7) >> 3;
>>
>> -	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
>> 	memset(tbl->it_map, 0, sz);
>>
>> 	/* Restore bit#0 set by iommu_init_table() */
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 730b4ef..b95fa2b 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -147,6 +147,67 @@ static void tce_iommu_release(void *iommu_data)
>> 	kfree(container);
>> }
>>
>> +static int tce_iommu_clear(struct tce_container *container,
>> +		struct iommu_table *tbl,
>> +		unsigned long entry, unsigned long pages)
>> +{
>> +	unsigned long oldtce;
>> +	struct page *page;
>> +
>> +	for ( ; pages; --pages, ++entry) {
>> +		oldtce = iommu_clear_tce(tbl, entry);
>
> It might be nice to rename iommu_clear_tce() to iommu_tce_free() with another
> separate patch for two reasons as I can see: iommu_tce_{build, free} is one
> pair of functions doing opposite things. iommu_tce_free() is implemented based
> on ppc_md.tce_free() as iommu_tce_build() depends on ppc_md.tce_build().


Later in this patchset (in "[PATCH kernel v10 23/34] powerpc/iommu/powernv: 
Release replaced TCE") I am removing iommu_clear_tce() and 
iommu_tce_build() (there will be iommu_tce_xchg() only) so no point in 
renaming those.


-- 
Alexey
