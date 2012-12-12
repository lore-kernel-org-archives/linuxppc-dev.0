Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15B682C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 17:14:16 +1100 (EST)
Received: by mail-pa0-f46.google.com with SMTP id bh2so277265pad.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 22:14:14 -0800 (PST)
Message-ID: <50C820AF.8050804@ozlabs.ru>
Date: Wed, 12 Dec 2012 17:14:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio powerpc: enabled on powernv platform
References: <1354636299.1809.431.camel@bling.home>
 <1354865750-8104-1-git-send-email-aik@ozlabs.ru>
 <1354901926.3224.96.camel@bling.home>
In-Reply-To: <1354901926.3224.96.camel@bling.home>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On 08/12/12 04:38, Alex Williamson wrote:
>> +static int __init tce_iommu_init(void)
>> +{
>> +	struct pci_dev *pdev = NULL;
>> +	struct iommu_table *tbl;
>> +	struct iommu_group *grp;
>> +
>> +	/* Allocate and initialize IOMMU groups */
>> +	for_each_pci_dev(pdev) {
>> +		tbl = get_iommu_table_base(&pdev->dev);
>> +		if (!tbl)
>> +			continue;
>> +
>> +		/* Skip already initialized */
>> +		if (tbl->it_group)
>> +			continue;
>> +
>> +		grp = iommu_group_alloc();
>> +		if (IS_ERR(grp)) {
>> +			pr_info("tce_vfio: cannot create new IOMMU group, ret=%ld\n",
>> +					PTR_ERR(grp));
>> +			return PTR_ERR(grp);
>> +		}
>> +		tbl->it_group = grp;
>> +		iommu_group_set_iommudata(grp, tbl, group_release);
>
> BTW, groups have a name property that shows up in sysfs that can be set
> with iommu_group_set_name().  IIRC, this was a feature David requested
> for PEs.  It'd be nice if it was used for PEs...  Thanks,



But what would I put there?... IOMMU ID is more than enough at the moment 
and struct iommu_table does not have anything what would have made sense to 
show in the sysfs...


-- 
Alexey
