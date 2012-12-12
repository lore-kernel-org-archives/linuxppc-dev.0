Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45C622C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 17:59:18 +1100 (EST)
Received: by mail-ie0-f170.google.com with SMTP id k10so1041615iea.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 22:59:16 -0800 (PST)
Message-ID: <50C82B3C.1060006@ozlabs.ru>
Date: Wed, 12 Dec 2012 17:59:08 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio powerpc: implemented IOMMU driver for VFIO
References: <1354557206.1809.377.camel@bling.home>
 <1354865693-8060-1-git-send-email-aik@ozlabs.ru>
 <1354899707.3224.86.camel@bling.home>
In-Reply-To: <1354899707.3224.86.camel@bling.home>
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

On 08/12/12 04:01, Alex Williamson wrote:
>> +	case VFIO_IOMMU_MAP_DMA: {
>> +		vfio_iommu_spapr_tce_dma_map param;
>> +		struct iommu_table *tbl = container->tbl;
>> +		enum dma_data_direction direction;
>> +		unsigned long locked, lock_limit;
>> +
>> +		if (WARN_ON(!tbl))
>> +			return -ENXIO;
>> +
>> +		minsz = offsetofend(vfio_iommu_spapr_tce_dma_map, size);
>> +
>> +		if (copy_from_user(&param, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (param.argsz < minsz)
>> +			return -EINVAL;
>> +
>> +		if ((param.flags & VFIO_DMA_MAP_FLAG_READ) &&
>> +				(param.flags & VFIO_DMA_MAP_FLAG_WRITE))
>> +			direction = DMA_BIDIRECTIONAL;
>> +		else if (param.flags & VFIO_DMA_MAP_FLAG_READ)
>> +			direction = DMA_TO_DEVICE;
>> +		else if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
>> +			direction = DMA_FROM_DEVICE;
>> +		else
>> +			return -EINVAL;
>
> flags needs to be sanitized too.  Return EINVAL if any unknown bit is
> set or else sloppy users may make it very difficult to make use of those
> flag bits later.


It already returns -EINVAL on any bit set except READ/WRITE, no?


-- 
Alexey
