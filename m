Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B29F1A0751
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 12:30:57 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so45966580pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:30:55 -0700 (PDT)
Message-ID: <554193D9.5010209@ozlabs.ru>
Date: Thu, 30 Apr 2015 12:30:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 12/32] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-13-git-send-email-aik@ozlabs.ru>
 <20150429024959.GI32589@voom.redhat.com>
In-Reply-To: <20150429024959.GI32589@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2015 12:49 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:36PM +1000, Alexey Kardashevskiy wrote:
>> Modern IBM POWERPC systems support multiple (currently two) TCE tables
>> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
>> for TCE tables. Right now just one table is supported.
>>
>> For P5IOC2 and IODA, iommu_table_group is embedded into PE struct
>> (pnv_ioda_pe and pnv_phb) and does not require iommu_free_table(), only .
>> iommu_reset_table().
>>
>> For pSeries, this replaces multiple calls of kzalloc_node() with a new
>> iommu_pseries_group_alloc() helper and stores the table group struct
>> pointer into the pci_dn struct. For release, a iommu_table_group_free()
>> helper is added.
>>
>> This should cause no behavioural change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>
> I'm not particularly fond of the "table_group" name, but I can't
> really think of a better name for now.  So,


I asked Ben again. iommu_state is not much better either. I'd stick to 
iommu_table_group.


> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>





-- 
Alexey
