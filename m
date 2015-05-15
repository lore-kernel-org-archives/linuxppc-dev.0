Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6F741A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:09:57 +1000 (AEST)
Date: Fri, 15 May 2015 10:09:49 +0200
From: Thomas Huth <thuth@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 23/34] powerpc/iommu/powernv: Release
 replaced TCE
Message-ID: <20150515100949.0433bfbf@thh440s>
In-Reply-To: <55541C55.4060807@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-24-git-send-email-aik@ozlabs.ru>
 <20150513170048.2c6115c6@thh440s> <55541C55.4060807@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
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

On Thu, 14 May 2015 13:53:57 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 05/14/2015 01:00 AM, Thomas Huth wrote:
> > On Tue, 12 May 2015 01:39:12 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
...
> >> -/*
> >> - * hwaddr is a kernel virtual address here (0xc... bazillion),
> >> - * tce_build converts it to a physical address.
> >> - */
> >> -int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
> >> -		unsigned long hwaddr, enum dma_data_direction direction)
> >> -{
> >> -	int ret = -EBUSY;
> >> -	unsigned long oldtce;
> >> -	struct iommu_pool *pool = get_pool(tbl, entry);
> >> -
> >> -	spin_lock(&(pool->lock));
> >> -
> >> -	oldtce = tbl->it_ops->get(tbl, entry);
> >> -	/* Add new entry if it is not busy */
> >> -	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> >> -		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
> >> -
> >> -	spin_unlock(&(pool->lock));
> >> +	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
> >> +			(*direction == DMA_BIDIRECTIONAL)))
> >
> > You could drop some of the parentheses:
> >
> > 	if (!ret && (*direction == DMA_FROM_DEVICE ||
> > 			*direction == DMA_BIDIRECTIONAL))
> 
> I really (really) like braces. Is there any kernel code design rule against it?

I don't think so ... but for me it's rather the other way round: If I
see too many braces, I always wonder whether there is a reason for it in
the sense that I did not understand the statement right at the first
glance. Additionally, this is something that Pascal programmers like to
do, so IMHO this just looks ugly in C.

> >> @@ -405,19 +410,26 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>   			return -EINVAL;
> >>
> >>   		/* iova is checked by the IOMMU API */
> >> -		tce = param.vaddr;
> >>   		if (param.flags & VFIO_DMA_MAP_FLAG_READ)
> >> -			tce |= TCE_PCI_READ;
> >> -		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> >> -			tce |= TCE_PCI_WRITE;
> >> +			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> >> +				direction = DMA_BIDIRECTIONAL;
> >> +			else
> >> +				direction = DMA_TO_DEVICE;
> >> +		else
> >> +			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> >> +				direction = DMA_FROM_DEVICE;
> >> +			else
> >> +				return -EINVAL;
> >
> > IMHO some curly braces for the outer if-statement would be really fine
> > here.
> 
> I believe checkpatch.pl won't like it. There is a check against single 
> lines having braces after "if" statements.

If you write your code like this (I was only talking about the outer
braces!):

	if (param.flags & VFIO_DMA_MAP_FLAG_READ) {
		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
			direction = DMA_BIDIRECTIONAL;
		else
			direction = DMA_TO_DEVICE;
	} else {
		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
			direction = DMA_FROM_DEVICE;
		else
			return -EINVAL;
	}

... then checkpatch should not complain, as far as I know - in this
case, the braces include three lines, don't they?

 Thomas
