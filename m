Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BB851A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 02:29:31 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so97431648pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 09:29:29 -0700 (PDT)
Message-ID: <552FE363.2060604@ozlabs.ru>
Date: Fri, 17 Apr 2015 02:29:23 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v8 21/31] powerpc/iommu: Split iommu_free_table
 into 2 helpers
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-22-git-send-email-aik@ozlabs.ru>
 <20150416064637.GL3632@voom.redhat.com>
In-Reply-To: <20150416064637.GL3632@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2015 04:46 PM, David Gibson wrote:
> On Fri, Apr 10, 2015 at 04:31:03PM +1000, Alexey Kardashevskiy wrote:
>> The iommu_free_table helper release memory it is using (the TCE table and
>> @it_map) and release the iommu_table struct as well. We might not want
>> the very last step as we store iommu_table in parent structures.
>
> Yeah, as I commented on the earlier patch, freeing the surrounding
> group from a function taking just the individual table is wrong.


This is iommu tables created by the old code which stores these iommu_table 
struct pointers in device nodes. I believe there is a plan to get rid of 
iommu tables there and when this is done, this workaround will be gone.


>
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/include/asm/iommu.h |  1 +
>>   arch/powerpc/kernel/iommu.c      | 57 ++++++++++++++++++++++++----------------
>>   2 files changed, 35 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index bde7ee7..8ed4648 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -127,6 +127,7 @@ static inline void *get_iommu_table_base(struct device *dev)
>>
>>   extern struct iommu_table *iommu_table_alloc(int node);
>>   /* Frees table for an individual device node */
>> +extern void iommu_reset_table(struct iommu_table *tbl, const char *node_name);
>>   extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
>>
>>   /* Initializes an iommu_table based in values set in the passed-in
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 501e8ee..0bcd988 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -721,24 +721,46 @@ struct iommu_table *iommu_table_alloc(int node)
>>   	return &table_group->tables[0];
>>   }
>>
>> +void iommu_reset_table(struct iommu_table *tbl, const char *node_name)
>> +{
>> +	if (!tbl)
>> +		return;
>> +
>> +	if (tbl->it_map) {
>> +		unsigned long bitmap_sz;
>> +		unsigned int order;
>> +
>> +		/*
>> +		 * In case we have reserved the first bit, we should not emit
>> +		 * the warning below.
>> +		 */
>> +		if (tbl->it_offset == 0)
>> +			clear_bit(0, tbl->it_map);
>> +
>> +		/* verify that table contains no entries */
>> +		if (!bitmap_empty(tbl->it_map, tbl->it_size))
>> +			pr_warn("%s: Unexpected TCEs for %s\n", __func__,
>> +					node_name);
>> +
>> +		/* calculate bitmap size in bytes */
>> +		bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
>> +
>> +		/* free bitmap */
>> +		order = get_order(bitmap_sz);
>> +		free_pages((unsigned long) tbl->it_map, order);
>> +	}
>> +
>> +	memset(tbl, 0, sizeof(*tbl));
>> +}
>> +
>>   void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>>   {
>> -	unsigned long bitmap_sz;
>> -	unsigned int order;
>>   	struct iommu_table_group *table_group = tbl->it_group;
>>
>> -	if (!tbl || !tbl->it_map) {
>> -		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
>> -				node_name);
>> +	if (!tbl)
>>   		return;
>> -	}
>>
>> -	/*
>> -	 * In case we have reserved the first bit, we should not emit
>> -	 * the warning below.
>> -	 */
>> -	if (tbl->it_offset == 0)
>> -		clear_bit(0, tbl->it_map);
>> +	iommu_reset_table(tbl, node_name);
>>
>>   #ifdef CONFIG_IOMMU_API
>>   	if (table_group->group) {
>> @@ -747,17 +769,6 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>>   	}
>>   #endif
>>
>> -	/* verify that table contains no entries */
>> -	if (!bitmap_empty(tbl->it_map, tbl->it_size))
>> -		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
>> -
>> -	/* calculate bitmap size in bytes */
>> -	bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
>> -
>> -	/* free bitmap */
>> -	order = get_order(bitmap_sz);
>> -	free_pages((unsigned long) tbl->it_map, order);
>> -
>>   	/* free table */
>>   	kfree(table_group);
>>   }
>


-- 
Alexey
