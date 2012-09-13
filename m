Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 8780B2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 08:35:08 +1000 (EST)
Message-ID: <1347575699.24938.344.camel@ul30vt.home>
Subject: Re: [PATCH] vfio: enabled and supported on power (v7)
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 13 Sep 2012 16:34:59 -0600
In-Reply-To: <504EF638.3090507@ozlabs.ru>
References: <20120821113534.GS29724@truffula.fritz.box>
 <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1347292924.24938.45.camel@ul30vt.home> <504EF638.3090507@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-11 at 18:28 +1000, Alexey Kardashevskiy wrote:
> On 11/09/12 02:02, Alex Williamson wrote:
> > On Tue, 2012-09-04 at 17:33 +1000, Alexey Kardashevskiy wrote:
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: Paul Mackerras <paulus@samba.org>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >
> > Please at least cc kvm@vger as well since we list that as the devel list
> > for vfio.
> >
> >>   arch/powerpc/include/asm/iommu.h    |    3 +
> >
> > I'll need an ack from Ben or Paul for this change.
> >
> >>   drivers/iommu/Kconfig               |    8 +
> >>   drivers/vfio/Kconfig                |    6 +
> >>   drivers/vfio/Makefile               |    1 +
> >>   drivers/vfio/vfio_iommu_spapr_tce.c |  440 +++++++++++++++++++++++++++++++++++
> >>   include/linux/vfio.h                |   29 +++
> >>   6 files changed, 487 insertions(+)
> >>   create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c
> >>
> >> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> >> index 957a83f..c64bce7 100644
> >> --- a/arch/powerpc/include/asm/iommu.h
> >> +++ b/arch/powerpc/include/asm/iommu.h
> >> @@ -66,6 +66,9 @@ struct iommu_table {
> >>   	unsigned long  it_halfpoint; /* Breaking point for small/large allocs */
> >>   	spinlock_t     it_lock;      /* Protects it_map */
> >>   	unsigned long *it_map;       /* A simple allocation bitmap for now */
> >> +#ifdef CONFIG_IOMMU_API
> >> +	struct iommu_group *it_group;
> >> +#endif
> >>   };
> >
> > This seems to only be valid when vfio_iommu_spapr_tce is loaded, which
> > is a bit misleading.
> >
> >>
> >>   struct scatterlist;
> >> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >> index 3bd9fff..19cf2d9 100644
> >> --- a/drivers/iommu/Kconfig
> >> +++ b/drivers/iommu/Kconfig
> >> @@ -162,4 +162,12 @@ config TEGRA_IOMMU_SMMU
> >>   	  space through the SMMU (System Memory Management Unit)
> >>   	  hardware included on Tegra SoCs.
> >>
> >> +config SPAPR_TCE_IOMMU
> >> +	bool "sPAPR TCE IOMMU Support"
> >> +	depends on PPC_PSERIES
> >> +	select IOMMU_API
> >> +	help
> >> +	  Enables bits of IOMMU API required by VFIO. The iommu_ops is
> >> +	  still not implemented.
> >> +
> >>   endif # IOMMU_SUPPORT
> >> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> >> index 7cd5dec..b464687 100644
> >> --- a/drivers/vfio/Kconfig
> >> +++ b/drivers/vfio/Kconfig
> >> @@ -3,10 +3,16 @@ config VFIO_IOMMU_TYPE1
> >>   	depends on VFIO
> >>   	default n
> >>
> >> +config VFIO_IOMMU_SPAPR_TCE
> >> +	tristate
> >> +	depends on VFIO && SPAPR_TCE_IOMMU
> >> +	default n
> >> +
> >>   menuconfig VFIO
> >>   	tristate "VFIO Non-Privileged userspace driver framework"
> >>   	depends on IOMMU_API
> >>   	select VFIO_IOMMU_TYPE1 if X86
> >> +	select VFIO_IOMMU_SPAPR_TCE if PPC_POWERNV
> >>   	help
> >>   	  VFIO provides a framework for secure userspace device drivers.
> >>   	  See Documentation/vfio.txt for more details.
> >> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> >> index 2398d4a..72bfabc 100644
> >> --- a/drivers/vfio/Makefile
> >> +++ b/drivers/vfio/Makefile
> >> @@ -1,3 +1,4 @@
> >>   obj-$(CONFIG_VFIO) += vfio.o
> >>   obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >> +obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> >>   obj-$(CONFIG_VFIO_PCI) += pci/
> >> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> >> new file mode 100644
> >> index 0000000..21f1909
> >> --- /dev/null
> >> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >> @@ -0,0 +1,440 @@
> >> +/*
> >> + * VFIO: IOMMU DMA mapping support for TCE on POWER
> >> + *
> >> + * Copyright (C) 2012 IBM Corp.  All rights reserved.
> >> + *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * Derived from original vfio_iommu_x86.c:
> >
> > Should this be _type1?  Only the mail archives are going to remember
> > there was a _x86, so the renamed version is probably a better reference.
> >
> >> + * Copyright (C) 2012 Red Hat, Inc.  All rights reserved.
> >> + *     Author: Alex Williamson <alex.williamson@redhat.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/uaccess.h>
> >> +#include <linux/err.h>
> >> +#include <linux/vfio.h>
> >> +#include <linux/spinlock.h>
> >> +#include <asm/iommu.h>
> >> +
> >> +#define DRIVER_VERSION  "0.1"
> >> +#define DRIVER_AUTHOR   "aik@ozlabs.ru"
> >> +#define DRIVER_DESC     "VFIO IOMMU SPAPR TCE"
> >> +
> >> +
> >> +/*
> >> + * SPAPR TCE API
> >> + */
> >> +static void tce_free(struct iommu_table *tbl, unsigned long entry,
> >> +		unsigned long tce)
> >> +{
> >> +	struct page *page = pfn_to_page(tce >> PAGE_SHIFT);
> >> +
> >> +	WARN_ON(!page);
> >> +	if (page) {
> >> +		if (tce & VFIO_SPAPR_TCE_WRITE)
> >> +			SetPageDirty(page);
> >> +		put_page(page);
> >> +	}
> >> +	ppc_md.tce_free(tbl, entry, 1);
> >> +}
> >> +
> >> +static long tce_put(struct iommu_table *tbl,
> >> +		unsigned long entry, uint64_t tce, uint32_t flags)
> >> +{
> >> +	int ret;
> >> +	unsigned long oldtce, kva, offset;
> >> +	struct page *page = NULL;
> >> +	enum dma_data_direction direction = DMA_NONE;
> >> +
> >> +	switch (flags & VFIO_SPAPR_TCE_PUT_MASK) {
> >> +	case VFIO_SPAPR_TCE_READ:
> >> +		direction = DMA_TO_DEVICE;
> >> +		break;
> >> +	case VFIO_SPAPR_TCE_WRITE:
> >> +		direction = DMA_FROM_DEVICE;
> >> +		break;
> >> +	case VFIO_SPAPR_TCE_BIDIRECTIONAL:
> >> +		direction = DMA_BIDIRECTIONAL;
> >> +		break;
> >> +	}
> >> +
> >> +	oldtce = ppc_md.tce_get(tbl, entry);
> >> +
> >> +	/* Free page if still allocated */
> >> +	if (oldtce & VFIO_SPAPR_TCE_PUT_MASK)
> >> +		tce_free(tbl, entry, oldtce);
> >> +
> >> +	/* Map new TCE */
> >> +	if (direction != DMA_NONE) {
> >> +		offset = (tce & IOMMU_PAGE_MASK) - (tce & PAGE_MASK);
> >> +		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
> >> +				direction != DMA_TO_DEVICE, &page);
> >> +		BUG_ON(ret > 1);
> >
> > Can this happen?
> >
> >> +		if (ret < 1) {
> >> +			printk(KERN_ERR "tce_vfio: get_user_pages_fast failed "
> >> +					"tce=%llx ioba=%lx ret=%d\n",
> >> +					tce, entry << IOMMU_PAGE_SHIFT, ret);
> >> +			if (!ret)
> >> +				ret = -EFAULT;
> >> +			goto unlock_exit;
> >> +		}
> >> +
> >> +		kva = (unsigned long) page_address(page);
> >> +		kva += offset;
> >> +		BUG_ON(!kva);
> >
> > Same here, can it happen?  If so, should it BUG or catch the below
> > EINVAL?
> >
> >> +		if (WARN_ON(kva & ~IOMMU_PAGE_MASK))
> >> +			return -EINVAL;
> >
> > Page leak?  Don't we want to do a put_page(), which means we probably
> > want a goto exit here.
> >
> >> +
> >> +		/* Preserve access bits */
> >> +		kva |= flags & VFIO_SPAPR_TCE_PUT_MASK;
> >> +
> >> +		/* tce_build receives a virtual address */
> >> +		entry += tbl->it_offset;	/* Offset into real TCE table */
> >> +		ret = ppc_md.tce_build(tbl, entry, 1, kva, direction, NULL);
> >> +
> >> +		/* tce_build() only returns non-zero for transient errors */
> >> +		if (unlikely(ret)) {
> >> +			printk(KERN_ERR "tce_vfio: Failed to add TCE\n");
> >> +			ret = -EIO;
> >> +			goto unlock_exit;
> >> +		}
> >> +	}
> >> +	/* Flush/invalidate TLB caches if necessary */
> >> +	if (ppc_md.tce_flush)
> >> +		ppc_md.tce_flush(tbl);
> >> +
> >> +	/* Make sure updates are seen by hardware */
> >> +	mb();
> >> +
> >> +unlock_exit:
> >
> > unlock seems wrong here, I had to go re-read the code looking for the
> > lock.
> >
> >> +	if (ret && page)
> >> +		put_page(page);
> >> +
> >> +	if (ret)
> >> +		printk(KERN_ERR "tce_vfio: tce_put failed on tce=%llx "
> >> +				"ioba=%lx kva=%lx\n", tce,
> >> +				entry << IOMMU_PAGE_SHIFT, kva);
> >> +	return ret;
> >> +}
> >> +
> >> +/*
> >> + * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
> >> + */
> >> +
> >> +/*
> >> + * The container descriptor supports only a single group per container.
> >> + * Required by the API as the container is not supplied with the IOMMU group
> >> + * at the moment of initialization.
> >> + */
> >> +struct tce_container {
> >> +	struct iommu_table *tbl;
> >> +};
> >> +
> >> +static void *tce_iommu_open(unsigned long arg)
> >> +{
> >> +	struct tce_container *container;
> >> +
> >> +	if (arg != VFIO_SPAPR_TCE_IOMMU) {
> >> +		printk(KERN_ERR "tce_vfio: Wrong IOMMU type\n");
> >> +		return ERR_PTR(-EINVAL);
> >> +	}
> >> +
> >> +	container = kzalloc(sizeof(*container), GFP_KERNEL);
> >> +	if (!container)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	return container;
> >> +}
> >> +
> >> +static void tce_iommu_release(void *iommu_data)
> >> +{
> >> +	struct tce_container *container = iommu_data;
> >> +	struct iommu_table *tbl = container->tbl;
> >> +	unsigned long i, tce;
> >> +
> >
> > This will segfault if releasing a container that never had an a device
> > attached.
> >
> >> +	/* Unmap leftovers */
> >> +	spin_lock_irq(&tbl->it_lock);
> >> +	for (i = tbl->it_offset; i < tbl->it_offset + tbl->it_size; ++i) {
> >> +		tce = ppc_md.tce_get(tbl, i);
> >> +		if (tce & VFIO_SPAPR_TCE_PUT_MASK)
> >> +			tce_free(tbl, i, tce);
> >> +	}
> >> +	/* Flush/invalidate TLB caches if necessary */
> >> +	if (ppc_md.tce_flush)
> >> +		ppc_md.tce_flush(tbl);
> >> +
> >> +	/* Make sure updates are seen by hardware */
> >> +	mb();
> >> +
> >> +	spin_unlock_irq(&tbl->it_lock);
> >> +
> >> +	kfree(container);
> >> +}
> >> +
> >> +static long tce_iommu_ioctl(void *iommu_data,
> >> +				 unsigned int cmd, unsigned long arg)
> >> +{
> >> +	struct tce_container *container = iommu_data;
> >> +	unsigned long minsz;
> >> +	long ret;
> >> +
> >> +	switch (cmd) {
> >> +	case VFIO_CHECK_EXTENSION: {
> >> +		return (arg == VFIO_SPAPR_TCE_IOMMU) ? 1 : 0;
> >> +	}
> >> +	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
> >> +		struct vfio_iommu_spapr_tce_info info;
> >> +		struct iommu_table *tbl = container->tbl;
> >> +
> >> +		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
> >> +				dma64_window_size);
> >> +
> >> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> >> +			return -EFAULT;
> >> +
> >> +		if (info.argsz < minsz)
> >> +			return -EINVAL;
> >> +
> >> +		if (!tbl)
> >> +			return -ENXIO;
> >
> > nit: why not check this earlier?
> >
> >> +
> >> +		info.dma32_window_start = tbl->it_offset << IOMMU_PAGE_SHIFT;
> >> +		info.dma32_window_size = tbl->it_size << IOMMU_PAGE_SHIFT;
> >> +		info.dma64_window_start = 0;
> >> +		info.dma64_window_size = 0;
> >> +		info.flags = 0;
> >> +
> >> +		return copy_to_user((void __user *)arg, &info, minsz);
> >> +	}
> >> +	case VFIO_IOMMU_SPAPR_TCE_PUT: {
> >> +		struct vfio_iommu_spapr_tce_put par;
> >> +		struct iommu_table *tbl = container->tbl;
> >> +
> >> +		minsz = offsetofend(struct vfio_iommu_spapr_tce_put, tce);
> >> +
> >> +		if (copy_from_user(&par, (void __user *)arg, minsz))
> >> +			return -EFAULT;
> >> +
> >> +		if (par.argsz < minsz)
> >> +			return -EINVAL;
> >> +
> >> +		if (!tbl) {
> >> +			return -ENXIO;
> >> +		}
> >
> > Same, plus drop the braces.
> >
> >> +
> >> +		spin_lock_irq(&tbl->it_lock);
> >> +		ret = tce_put(tbl, par.ioba >> IOMMU_PAGE_SHIFT,
> >> +				par.tce, par.flags);
> >> +		spin_unlock_irq(&tbl->it_lock);
> >> +
> >> +		return ret;
> >> +	}
> >
> > Is "PUT" really the name we want for this?
> 
> 
> Yes, it is a single H_PUT_TCE hypercall from POWER architecture spec.

Ok, if it makes sense on your arch, I won't complain (too much) about
it.

> >> +	default:
> >> +		printk(KERN_WARNING "tce_vfio: unexpected cmd %x\n", cmd);
> >> +	}
> >> +
> >> +	return -ENOTTY;
> >> +}
> >> +
> >> +static int tce_iommu_attach_group(void *iommu_data,
> >> +		struct iommu_group *iommu_group)
> >> +{
> >> +	struct tce_container *container = iommu_data;
> >> +	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
> >> +
> >> +	printk(KERN_DEBUG "tce_vfio: Attaching group #%u to iommu %p\n",
> >> +			iommu_group_id(iommu_group), iommu_group);
> >
> > Let's use pr_debug() and friends throughout.
> >
> >> +	if (container->tbl) {
> >> +		printk(KERN_WARNING "tce_vfio: Only one group per IOMMU "
> >> +				"container is allowed, "
> >> +				"existing id=%d, attaching id=%d\n",
> >> +				iommu_group_id(container->tbl->it_group),
> >> +				iommu_group_id(iommu_group));
> >> +		return -EBUSY;
> >> +	}
> >> +
> >
> > _type1 has a lock to avoid races here, I think you might need one too.
> >
> >> +	container->tbl = tbl;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void tce_iommu_detach_group(void *iommu_data,
> >> +		struct iommu_group *iommu_group)
> >> +{
> >> +	struct tce_container *container = iommu_data;
> >> +	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
> >> +
> >> +	BUG_ON(!tbl);
> >
> > Needed?  If so, why is there no check on attach?
> 
> Added to attach() :)
> 
> 
> >
> >> +	if (tbl != container->tbl) {
> >> +		printk(KERN_WARNING "tce_vfio: detaching group #%u, expected "
> >> +				"group is #%u\n", iommu_group_id(iommu_group),
> >> +				iommu_group_id(tbl->it_group));
> >> +		return;
> >> +	}
> >> +	printk(KERN_DEBUG "tce_vfio: detaching group #%u from iommu %p\n",
> >> +			iommu_group_id(iommu_group), iommu_group);
> >
> > container->tbl = NULL?
> 
> 
> Then I won't be able to release pages in tce_iommu_release().
> Releasing pages in tce_iommu_detach_group() caused some other problems, 
> cannot recall now which ones.

What happens if you hot unplug a group from one VM and add it to
another?  ie. we've detached it from one container and add it to another
in a different instance.  Does it cause problems here?

> >> +}
> >> +
> >> +const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
> >> +	.name		= "iommu-vfio-powerpc",
> >> +	.owner		= THIS_MODULE,
> >> +	.open		= tce_iommu_open,
> >> +	.release	= tce_iommu_release,
> >> +	.ioctl		= tce_iommu_ioctl,
> >> +	.attach_group	= tce_iommu_attach_group,
> >> +	.detach_group	= tce_iommu_detach_group,
> >> +};
> >> +
> >> +/*
> >> + * Add/delete devices support (hotplug, module_init, module_exit)
> >> + */
> >> +static int add_device(struct device *dev)
> >> +{
> >> +	struct iommu_table *tbl;
> >> +	int ret = 0;
> >> +
> >> +	if (dev->iommu_group) {
> >> +		printk(KERN_WARNING "tce_vfio: device %s is already in iommu "
> >> +				"group %d, skipping\n", dev->kobj.name,
> >
> > Watch line wrapping on strings.
> 
> Pardon?

Just suggesting that you try to wrap lines so that strings are
searchable.  For instance, can I search cscope for "is already in iommu
group".  It's generally accepted that printks can break 80 cols for
this.

> >> +				iommu_group_id(dev->iommu_group));
> >> +		return -EBUSY;
> >> +	}
> >> +
> >> +	tbl = get_iommu_table_base(dev);
> >> +	if (!tbl) {
> >> +		printk(KERN_DEBUG "tce_vfio: skipping device %s with no tbl\n",
> >> +				dev->kobj.name);
> >> +		return 0;
> >> +	}
> >> +
> >> +	printk(KERN_DEBUG "tce_vfio: adding %s to iommu group %d\n",
> >> +			dev->kobj.name, iommu_group_id(tbl->it_group));
> >> +
> >> +	ret = iommu_group_add_device(tbl->it_group, dev);
> >> +	if (ret < 0)
> >> +		printk(KERN_ERR "tce_vfio: %s has not been added, ret=%d\n",
> >> +				dev->kobj.name, ret);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void del_device(struct device *dev)
> >> +{
> >> +	iommu_group_remove_device(dev);
> >> +}
> >> +
> >> +static int iommu_bus_notifier(struct notifier_block *nb,
> >> +			      unsigned long action, void *data)
> >> +{
> >> +	struct device *dev = data;
> >> +
> >> +	switch (action) {
> >> +	case BUS_NOTIFY_ADD_DEVICE:
> >> +		return add_device(dev);
> >> +	case BUS_NOTIFY_DEL_DEVICE:
> >> +		del_device(dev);
> >> +		return 0;
> >> +	default:
> >> +		return 0;
> >> +	}
> >> +}
> >> +
> >> +static struct notifier_block tce_iommu_bus_nb = {
> >> +	.notifier_call = iommu_bus_notifier,
> >> +};
> >> +
> >> +void group_release(void *iommu_data)
> >> +{
> >> +	struct iommu_table *tbl = iommu_data;
> >> +	tbl->it_group = NULL;
> >> +}
> >> +
> >> +static int __init tce_iommu_init(void)
> >> +{
> >> +	struct pci_dev *pdev = NULL;
> >> +	struct iommu_table *tbl;
> >> +	struct iommu_group *grp;
> >> +
> >> +	/* If the current platform does not support tce_get
> >> +	   we are unable to clean TCE table properly and
> >> +	   therefore it is better not to touch it at all */
> >> +	if (!ppc_md.tce_get) {
> >> +		printk(KERN_ERR "tce_vfio: ppc_md.tce_get isn't implemented\n");
> >> +		return -EOPNOTSUPP;
> >> +	}
> >> +
> >> +	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> >> +
> >> +	/* Allocate and initialize VFIO groups */
> >
> > s/VFIO groups/IOMMU groups/
> >
> >> +	for_each_pci_dev(pdev) {
> >> +		tbl = get_iommu_table_base(&pdev->dev);
> >> +		if (!tbl)
> >> +			continue;
> >> +
> >> +		/* Skip already initialized */
> >> +		if (tbl->it_group)
> >> +			continue;
> >> +
> >> +		grp = iommu_group_alloc();
> >> +		if (IS_ERR(grp)) {
> >> +			printk(KERN_INFO "tce_vfio: cannot create "
> >> +					"new IOMMU group, ret=%ld\n",
> >> +					PTR_ERR(grp));
> >> +			return -EFAULT;
> >> +		}
> >> +		tbl->it_group = grp;
> >> +		iommu_group_set_iommudata(grp, tbl, group_release);
> >> +	}
> >> +
> >> +	/* Add PCI devices to VFIO groups */
> >> +	for_each_pci_dev(pdev)
> >> +		add_device(&pdev->dev);
> >> +
> >> +	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
> >> +}
> >> +
> >> +static void __exit tce_iommu_cleanup(void)
> >> +{
> >> +	struct pci_dev *pdev = NULL;
> >> +	struct iommu_table *tbl;
> >> +	struct iommu_group *grp = NULL;
> >> +
> >> +	bus_unregister_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> >> +
> >> +	/* Delete PCI devices from VFIO groups */
> >> +	for_each_pci_dev(pdev)
> >> +		del_device(&pdev->dev);
> >> +
> >> +	/* Release VFIO groups */
> >> +	for_each_pci_dev(pdev) {
> >> +		tbl = get_iommu_table_base(&pdev->dev);
> >> +		if (!tbl)
> >> +			continue;
> >> +		grp = tbl->it_group;
> >> +
> >> +		/* Skip (already) uninitialized */
> >> +		if (!grp)
> >> +			continue;
> >> +
> >> +		/* Do actual release, group_release() is expected to work */
> >> +		iommu_group_put(grp);
> >> +		BUG_ON(tbl->it_group);
> >> +	}
> >> +
> >
> >
> > It troubles me a bit that you're using the vfio driver to initialize and
> > tear down IOMMU groups on your platform.
> 
> 
> I am not following you here. Could you please explain a bit?

IOMMU groups are theoretically not just for VFIO.  They expose DMA
dependencies between devices for anyone who cares to know about it.
VFIO happens to care very much about that, but is hopefully not the only
consumer.  So it's a little bit like writing a driver for a device on a
new bus and incorporating the bus topology handling code into the device
driver.  IOMMU groups should be created and managed independent of VFIO.

> > VFIO makes use of IOMMU groups
> > and is the only user so far, but they're hopefully useful beyond this.
> > In fact, VFIO used to manage assembling all groups from data provided by
> > the IOMMU but David wanted to see IOMMU groups be a more universally
> > available feature, so it's odd to see POWER implementing it this way.
> 
> 
> David, help! :)
> 
> 
> >> +	vfio_unregister_iommu_driver(&tce_iommu_driver_ops);
> >> +}
> >> +
> >> +module_init(tce_iommu_init);
> >> +module_exit(tce_iommu_cleanup);
> >> +
> >> +MODULE_VERSION(DRIVER_VERSION);
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_AUTHOR(DRIVER_AUTHOR);
> >> +MODULE_DESCRIPTION(DRIVER_DESC);
> >> +
> >> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> >> index 0a4f180..2c0a927 100644
> >> --- a/include/linux/vfio.h
> >> +++ b/include/linux/vfio.h
> >> @@ -99,6 +99,7 @@ extern void vfio_unregister_iommu_driver(
> >>   /* Extensions */
> >>
> >>   #define VFIO_TYPE1_IOMMU		1
> >> +#define VFIO_SPAPR_TCE_IOMMU		2
> >>
> >>   /*
> >>    * The IOCTL interface is designed for extensibility by embedding the
> >> @@ -442,4 +443,32 @@ struct vfio_iommu_type1_dma_unmap {
> >>
> >>   #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
> >>
> >> +/* -------- API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >> +
> >> +struct vfio_iommu_spapr_tce_info {
> >> +	__u32 argsz;
> >> +	__u32 flags;
> >> +	__u32 dma32_window_start;
> >> +	__u32 dma32_window_size;
> >> +	__u64 dma64_window_start;
> >> +	__u64 dma64_window_size;
> >> +};
> >> +
> >> +#define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
> >> +
> >> +struct vfio_iommu_spapr_tce_put {
> >> +	__u32 argsz;
> >> +	__u32 flags;
> >> +#define VFIO_SPAPR_TCE_READ		1
> >> +#define VFIO_SPAPR_TCE_WRITE		2
> >> +#define VFIO_SPAPR_TCE_BIDIRECTIONAL	(VFIO_SPAPR_TCE_READ|VFIO_SPAPR_TCE_WRITE)
> >> +#define VFIO_SPAPR_TCE_PUT_MASK		VFIO_SPAPR_TCE_BIDIRECTIONAL
> >> +	__u64 ioba;
> >> +	__u64 tce;
> >> +};
> >
> > Ok, so if READ & WRITE are both clear and ioba is set, that's an
> > "unmap"?  This is exactly why _type1 has a MAP and UNMAP, to make it
> > clear which fields are necessary for which call.  I think we should
> > probably do the same here.  Besides, _put makes me think there should be
> > a _get; do these have some unique meaning in POWER?
> 
> 
> It is a single H_PUT_TCE for putting a record into TCE table. The guest 
> calls H_PUT_TCE, QEMU replaces the address and simply forwards the call to 
> the host. Calling them map/unmap makes it less clear for powerpc people :)

In the unmap case we take an ioba and lookup a tce to clear, in the map
case we take an ioba and tce and insert them into the table.  It's valid
to document this and use a single ioctl, but I've opted on x86 to have
separate ioctls because the documentation falls out cleaner when there
aren't fields that are only used in certain conditions.  Do you really
want any userspace driver making use of this to know about powerpc
H_PUT_TCE or would it make more sense to have a MAP and UNMAP call?  I
think it would be better for the VFIO API if we had some consistency in
the mapping ioctls where possible.

> >
> >> +
> >> +#define VFIO_IOMMU_SPAPR_TCE_PUT	_IO(VFIO_TYPE, VFIO_BASE + 13)
> >> +
> >
> > Please document what all of the above means.  Thanks,
> 
> 
> Something like this?
> /*
>   * The VFIO_IOMMU_SPAPR_TCE_PUT is implemented as the H_PUT_TCE hypercall.
>   * ioba - I/O Bus Address for indexing into TCE table
>   * tce - logical address of storage
>   *
>   * The non-zero flags means adding new page into the table.
>   * The zero flags means releasing the existing page and clearing the
>   * TCE table entry.
>   */

Do you only want VFIO drivers to work on POWER if they're written by
POWER people?  Ideally there are a few simple concepts: a) devices have
an I/O virtual address space.  On x86 we call this the iova and it's
effectively a zero-based, 64bit (not really, but close enough) address
space.  You seem to have two smaller windows, one in 32bit space,
another in 64bit space (maybe we could name these more consistently).
b) Userspace has a buffer that they want to map and unmap to an iova,
potentially with some access flags.  That's all you need to know to use
the x86 _type1 VFIO IOMMU API.  Why do I need to know about H_PUT_TCE to
use this interface?  Let's assume there might be some VFIO drivers some
day that aren't written by POWER people.  Thanks,

Alex
