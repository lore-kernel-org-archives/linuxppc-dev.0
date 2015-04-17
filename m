Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1EB71A0030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 19:46:34 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so123062978pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 02:46:32 -0700 (PDT)
Message-ID: <5530D66F.3070208@ozlabs.ru>
Date: Fri, 17 Apr 2015 19:46:23 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v8 12/31] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-13-git-send-email-aik@ozlabs.ru>
 <20150416055555.GC3632@voom.redhat.com>
In-Reply-To: <20150416055555.GC3632@voom.redhat.com>
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

On 04/16/2015 03:55 PM, David Gibson wrote:
> On Fri, Apr 10, 2015 at 04:30:54PM +1000, Alexey Kardashevskiy wrote:
>> Modern IBM POWERPC systems support multiple (currently two) TCE tables
>> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
>> for TCE tables. Right now just one table is supported.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/include/asm/iommu.h            |  18 +++--
>>   arch/powerpc/kernel/iommu.c                 |  34 ++++----
>>   arch/powerpc/platforms/powernv/pci-ioda.c   |  38 +++++----
>>   arch/powerpc/platforms/powernv/pci-p5ioc2.c |  17 ++--
>>   arch/powerpc/platforms/powernv/pci.c        |   2 +-
>>   arch/powerpc/platforms/powernv/pci.h        |   4 +-
>>   arch/powerpc/platforms/pseries/iommu.c      |   9 ++-
>>   drivers/vfio/vfio_iommu_spapr_tce.c         | 120 ++++++++++++++++++++--------
>>   8 files changed, 160 insertions(+), 82 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index eb75726..667aa1a 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -90,9 +90,7 @@ struct iommu_table {
>>   	struct iommu_pool pools[IOMMU_NR_POOLS];
>>   	unsigned long *it_map;       /* A simple allocation bitmap for now */
>>   	unsigned long  it_page_shift;/* table iommu page size */
>> -#ifdef CONFIG_IOMMU_API
>> -	struct iommu_group *it_group;
>> -#endif
>> +	struct iommu_table_group *it_group;
>>   	struct iommu_table_ops *it_ops;
>>   	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>>   };
>> @@ -126,14 +124,24 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
>>    */
>>   extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>>   					    int nid);
>> +
>> +#define IOMMU_TABLE_GROUP_MAX_TABLES	1
>> +
>> +struct iommu_table_group {
>>   #ifdef CONFIG_IOMMU_API
>> -extern void iommu_register_group(struct iommu_table *tbl,
>> +	struct iommu_group *group;
>> +#endif
>> +	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>
> There's nothing to indicate which of the tables are in use at the
> current time.  I mean, it doesn't matter now because there's only one,
> but the patch doesn't make a whole lot of sense without that.


Later in the patchset, the code will look at @it_size to know if the table 
is in use.


>
>> +};
>> +
>> +#ifdef CONFIG_IOMMU_API
>> +extern void iommu_register_group(struct iommu_table_group *table_group,
>>   				 int pci_domain_number, unsigned long pe_num);
>>   extern int iommu_add_device(struct device *dev);
>>   extern void iommu_del_device(struct device *dev);
>>   extern int __init tce_iommu_bus_notifier_init(void);
>>   #else
>> -static inline void iommu_register_group(struct iommu_table *tbl,
>> +static inline void iommu_register_group(struct iommu_table_group *table_group,
>>   					int pci_domain_number,
>>   					unsigned long pe_num)
>>   {
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index b39d00a..fd49c8e 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -712,17 +712,20 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>>
>>   struct iommu_table *iommu_table_alloc(int node)
>>   {
>> -	struct iommu_table *tbl;
>> +	struct iommu_table_group *table_group;
>>
>> -	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
>> +	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
>> +			   node);
>> +	table_group->tables[0].it_group = table_group;
>>
>> -	return tbl;
>> +	return &table_group->tables[0];
>>   }
>>
>>   void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>
> Surely the free function should take a table group rather than a table
> as argument.


Please ignore my other response to your reply; I reworked the whole thing 
to store iommu_table_group in the pci device node. Thanks.


-- 
Alexey
