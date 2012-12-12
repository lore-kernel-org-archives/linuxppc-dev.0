Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id EFF992C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 01:36:20 +1100 (EST)
Message-ID: <1355322973.3224.203.camel@bling.home>
Subject: Re: [PATCH] vfio powerpc: implemented IOMMU driver for VFIO
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 12 Dec 2012 07:36:13 -0700
In-Reply-To: <50C82B3C.1060006@ozlabs.ru>
References: <1354557206.1809.377.camel@bling.home>
 <1354865693-8060-1-git-send-email-aik@ozlabs.ru>
 <1354899707.3224.86.camel@bling.home> <50C82B3C.1060006@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Wed, 2012-12-12 at 17:59 +1100, Alexey Kardashevskiy wrote:
> On 08/12/12 04:01, Alex Williamson wrote:
> >> +	case VFIO_IOMMU_MAP_DMA: {
> >> +		vfio_iommu_spapr_tce_dma_map param;
> >> +		struct iommu_table *tbl = container->tbl;
> >> +		enum dma_data_direction direction;
> >> +		unsigned long locked, lock_limit;
> >> +
> >> +		if (WARN_ON(!tbl))
> >> +			return -ENXIO;
> >> +
> >> +		minsz = offsetofend(vfio_iommu_spapr_tce_dma_map, size);
> >> +
> >> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> >> +			return -EFAULT;
> >> +
> >> +		if (param.argsz < minsz)
> >> +			return -EINVAL;
> >> +
> >> +		if ((param.flags & VFIO_DMA_MAP_FLAG_READ) &&
> >> +				(param.flags & VFIO_DMA_MAP_FLAG_WRITE))
> >> +			direction = DMA_BIDIRECTIONAL;
> >> +		else if (param.flags & VFIO_DMA_MAP_FLAG_READ)
> >> +			direction = DMA_TO_DEVICE;
> >> +		else if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> >> +			direction = DMA_FROM_DEVICE;
> >> +		else
> >> +			return -EINVAL;
> >
> > flags needs to be sanitized too.  Return EINVAL if any unknown bit is
> > set or else sloppy users may make it very difficult to make use of those
> > flag bits later.
> 
> 
> It already returns -EINVAL on any bit set except READ/WRITE, no?

No.  I could pass flags ~0 through there to get a read/write mapping and
cause you problems if you later want to define another bit.  Thanks,

Alex
