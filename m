Return-Path: <sonny@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BADB4DDF5A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 17:36:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5I7aat9004912
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 03:36:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5I7aak3174668
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:36:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5I7aaTs005755
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:36:36 -0600
Received: from us.ibm.com (zoidberg.austin.ibm.com [9.41.41.81])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5I7aZg6005752
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:36:36 -0600
Resent-Message-ID: <20080618073635.GF29409@localhost.localdomain>
Date: Tue, 17 Jun 2008 17:44:43 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Power5,Power6 BSR driver
Message-ID: <20080617224443.GD7552@localhost.localdomain>
References: <20080616185344.GB16192@gamma> <20080617223952.GA9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080617223952.GA9594@localdomain>
Cc: sonnyrao@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 05:39:52PM -0500, Nathan Lynch wrote:
> Hi, mainly a couple of coding style things, but one minor bug (I
> think).
> 
> jschopp@austin.ibm.com wrote:
> > From: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> > 
> > +static int bsr_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	unsigned long size   = vma->vm_end - vma->vm_start;
> > +	struct bsr_dev *dev = filp->private_data;
> > +
> > +	if (size > dev->bsr_len || (size & (PAGE_SIZE-1)))
> > +		return -EINVAL;
> > +
> > +	vma->vm_flags |= (VM_IO | VM_DONTEXPAND);
> > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +
> > +	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
> > +			       size, vma->vm_page_prot))
> > +	    return -EAGAIN;
> 
> Indentation is wrong.

Yeah I noticed that too.

> > +static void bsr_cleanup_devs(void)
> > +{
> > +	int i;
> > +	for (i=0 ; i < num_bsr_devs; i++) {
> 
>              i = 0
> 
> > +		struct bsr_dev *cur = bsr_devs + i;
> > +		if (cur->bsr_device) {
> > +			cdev_del(&cur->bsr_cdev);
> > +			device_del(cur->bsr_device);
> > +		}
> > +	}
> > +
> > +	kfree(bsr_devs);
> > +}
> > +
> > +static int bsr_create_devs(struct device_node *bn)
> > +{
> > +	int reg_len, bsr_stride_len, bsr_bytes_len;
> > +	const u64 *reg;
> > +	const u32 *bsr_stride;
> > +	const u32 *bsr_bytes;
> > +	unsigned i;
> > +
> > +	reg        = of_get_property(bn, "reg", &reg_len);
> > +	bsr_stride = of_get_property(bn, "ibm,lock-stride", &bsr_stride_len);
> > +	bsr_bytes  = of_get_property(bn, "ibm,#lock-bytes", &bsr_bytes_len);
> > +
> > +	if (!reg || !bsr_stride || !bsr_bytes ||
> > +	    (bsr_stride_len != bsr_bytes_len) ||
> > +	    (bsr_stride_len/4 != reg_len/16)) {
> 
>              bsr_stride_len / 4 != reg_len / 16
> 
> 
> > +		printk(KERN_ERR "bsr of-node has missing/incorrect property\n");
> > +		return -ENODEV;
> > +	}
> 
> ...
> 
> > +static int __init bsr_init(void)
> > +{
> > +	struct device_node *np;
> > +	dev_t bsr_dev = MKDEV(bsr_major, 0);
> > +	int ret = -ENODEV;
> > +	int result;
> > +
> > +	np = of_find_compatible_node(NULL, "ibm,bsr", "ibm,bsr");
> > +	if (!np)
> > +		goto out_err;
> > +
> > +	bsr_class = class_create(THIS_MODULE, "bsr");
> > +	if (IS_ERR(bsr_class)) {
> > +		printk(KERN_ERR "class_create() failed for bsr_class\n");
> > +		goto out_err;
> 
> At this point I think you can leak a reference to np.

Yeah, you're right.

> 
> > +	}
> > +	bsr_class->dev_attrs = bsr_dev_attrs;
> > +
> > +	result = alloc_chrdev_region(&bsr_dev, 0, BSR_MAX_DEVS, "bsr");
> > +	bsr_major = MAJOR(bsr_dev);
> > +	if (result < 0) {
> > +		printk(KERN_ERR "alloc_chrdev_region() failed for bsr\n");
> > +		goto out_err_1;
> > +	}
> > +
> > +	if ((ret = bsr_create_devs(np)) < 0)
> > +		goto out_err_2;
> > +
> > +	of_node_put(np);
> > +
> > +	return 0;
> > +
> > + out_err_2:
> > +	unregister_chrdev_region(bsr_dev, BSR_MAX_DEVS);
> > +
> > + out_err_1:
> > +	class_destroy(bsr_class);
> > +	of_node_put(np);
> > +
> > + out_err:
> > +
> > +	return ret;
> > +}

Ok Will fix and send out again

-- 
Sonny Rao, LTC Ozlabs
