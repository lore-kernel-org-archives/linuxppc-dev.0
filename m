Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9252F1A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:08:01 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so69676861pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 20:08:00 -0700 (PDT)
Message-ID: <55541188.1030201@ozlabs.ru>
Date: Thu, 14 May 2015 13:07:52 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 14/34] powerpc/iommu: Move tce_xxx callbacks
 from ppc_md to iommu_table
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-15-git-send-email-aik@ozlabs.ru>
 <20150514002321.GA16128@gwshan>
In-Reply-To: <20150514002321.GA16128@gwshan>
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

On 05/14/2015 10:23 AM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:39:03AM +1000, Alexey Kardashevskiy wrote:
>> This adds a iommu_table_ops struct and puts pointer to it into
>> the iommu_table struct. This moves tce_build/tce_free/tce_get/tce_flush
>> callbacks from ppc_md to the new struct where they really belong to.
>>
>> This adds the requirement for @it_ops to be initialized before calling
>> iommu_init_table() to make sure that we do not leave any IOMMU table
>> with iommu_table_ops uninitialized. This is not a parameter of
>> iommu_init_table() though as there will be cases when iommu_init_table()
>> will not be called on TCE tables, for example - VFIO.
>>
>> This does s/tce_build/set/, s/tce_free/clear/ and removes "tce_"
>> redundand prefixes.
>>
>
> s/redundand/redundant  I might be wrong because of my bad English.

No, you're right ;)

>
>> This removes tce_xxx_rm handlers from ppc_md but does not add
>> them to iommu_table_ops as this will be done later if we decide to
>> support TCE hypercalls in real mode. This removes _vm callbacks as
>> only virtual mode is supported by now so this also removes @rm parameter.
>>
>> For pSeries, this always uses tce_buildmulti_pSeriesLP/
>> tce_buildmulti_pSeriesLP. This changes multi callback to fall back to
>> tce_build_pSeriesLP/tce_free_pSeriesLP if FW_FEATURE_MULTITCE is not
>> present. The reason for this is we still have to support "multitce=off"
>> boot parameter in disable_multitce() and we do not want to walk through
>> all IOMMU tables in the system and replace "multi" callbacks with single
>> ones.
>>
>> For powernv, this defines _ops per PHB type which are P5IOC2/IODA1/IODA2.
>> This makes the callbacks for them public. Later patches will extend
>> callbacks for IODA1/2.
>>
>> No change in behaviour is expected.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> Changes:
>> v9:
>> * pnv_tce_build/pnv_tce_free/pnv_tce_get have been made public and lost
>> "rm" parameters to make following patches simpler (realmode is not
>> supported here anyway)
>> * got rid of _vm versions of callbacks
>> ---
>> arch/powerpc/include/asm/iommu.h            | 17 +++++++++++
>> arch/powerpc/include/asm/machdep.h          | 25 ---------------
>> arch/powerpc/kernel/iommu.c                 | 46 ++++++++++++++--------------
>> arch/powerpc/kernel/vio.c                   |  5 +++
>> arch/powerpc/platforms/cell/iommu.c         |  8 +++--
>> arch/powerpc/platforms/pasemi/iommu.c       |  7 +++--
>> arch/powerpc/platforms/powernv/pci-ioda.c   | 14 +++++++++
>> arch/powerpc/platforms/powernv/pci-p5ioc2.c |  7 +++++
>> arch/powerpc/platforms/powernv/pci.c        | 47 +++++------------------------
>> arch/powerpc/platforms/powernv/pci.h        |  5 +++
>> arch/powerpc/platforms/pseries/iommu.c      | 34 ++++++++++++---------
>> arch/powerpc/sysdev/dart_iommu.c            | 12 +++++---
>> 12 files changed, 116 insertions(+), 111 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index d91bd69..e2a45c3 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -44,6 +44,22 @@
>> extern int iommu_is_off;
>> extern int iommu_force_on;
>>
>> +struct iommu_table_ops {
>> +	int (*set)(struct iommu_table *tbl,
>> +			long index, long npages,
>> +			unsigned long uaddr,
>> +			enum dma_data_direction direction,
>> +			struct dma_attrs *attrs);
>> +	void (*clear)(struct iommu_table *tbl,
>> +			long index, long npages);
>> +	unsigned long (*get)(struct iommu_table *tbl, long index);
>> +	void (*flush)(struct iommu_table *tbl);
>
> Currently, there isn't flush backend on PowerNV platform. I'm not sure
> if we have to implement it for PowerNV if we really need it. Maybe you
> will have it to support DDW in subsequent patches which I didn't look
> into it, but I will :-)


I am not adding new callbacks here, I am moving them. DART uses flush() so 
it has to be here.


>
>> +};
>> +
>> +/* These are used by VIO */
>> +extern struct iommu_table_ops iommu_table_lpar_multi_ops;
>> +extern struct iommu_table_ops iommu_table_pseries_ops;
>> +
>
> It might be reasonable to add "struct iommu_table_ops *ops" to function
> vio_register_device_node() where the specified "ops" can be hooked to
> the newly created IOMMU table. In that way, the platform (pSeries) specific
> IOMMU table operations doesn't have to be exposed to PowerPC subsystem.

I am not exposing anything new here - I am just replacing references to 
ppc_md with references to iommu_table_ops.

vio_register_device_node() is called from VIO code. So I'll have to have a 
copy of iommu_table_pseries_ops and iommu_table_lpar_multi_ops in VIO code. 
If I do this, I'll have to export 
tce_build_pSeries()/tce_free_pSeries()/tce_get_pseries() to initialize 
those structs. Either way I need to expose some symbols and do deeper 
rework but not in this patchset.



-- 
Alexey
