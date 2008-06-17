Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id BA63DDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 08:59:13 +1000 (EST)
Date: Tue, 17 Jun 2008 17:39:52 -0500
From: Nathan Lynch <ntl@pobox.com>
To: jschopp@austin.ibm.com
Subject: Re: [PATCH] Power5,Power6 BSR driver
Message-ID: <20080617223952.GA9594@localdomain>
References: <20080616185344.GB16192@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080616185344.GB16192@gamma>
Cc: sonnyrao@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, mainly a couple of coding style things, but one minor bug (I
think).

jschopp@austin.ibm.com wrote:
> From: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> 
> +static int bsr_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	unsigned long size   = vma->vm_end - vma->vm_start;
> +	struct bsr_dev *dev = filp->private_data;
> +
> +	if (size > dev->bsr_len || (size & (PAGE_SIZE-1)))
> +		return -EINVAL;
> +
> +	vma->vm_flags |= (VM_IO | VM_DONTEXPAND);
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
> +			       size, vma->vm_page_prot))
> +	    return -EAGAIN;

Indentation is wrong.


> +static void bsr_cleanup_devs(void)
> +{
> +	int i;
> +	for (i=0 ; i < num_bsr_devs; i++) {

             i = 0

> +		struct bsr_dev *cur = bsr_devs + i;
> +		if (cur->bsr_device) {
> +			cdev_del(&cur->bsr_cdev);
> +			device_del(cur->bsr_device);
> +		}
> +	}
> +
> +	kfree(bsr_devs);
> +}
> +
> +static int bsr_create_devs(struct device_node *bn)
> +{
> +	int reg_len, bsr_stride_len, bsr_bytes_len;
> +	const u64 *reg;
> +	const u32 *bsr_stride;
> +	const u32 *bsr_bytes;
> +	unsigned i;
> +
> +	reg        = of_get_property(bn, "reg", &reg_len);
> +	bsr_stride = of_get_property(bn, "ibm,lock-stride", &bsr_stride_len);
> +	bsr_bytes  = of_get_property(bn, "ibm,#lock-bytes", &bsr_bytes_len);
> +
> +	if (!reg || !bsr_stride || !bsr_bytes ||
> +	    (bsr_stride_len != bsr_bytes_len) ||
> +	    (bsr_stride_len/4 != reg_len/16)) {

             bsr_stride_len / 4 != reg_len / 16


> +		printk(KERN_ERR "bsr of-node has missing/incorrect property\n");
> +		return -ENODEV;
> +	}

...

> +static int __init bsr_init(void)
> +{
> +	struct device_node *np;
> +	dev_t bsr_dev = MKDEV(bsr_major, 0);
> +	int ret = -ENODEV;
> +	int result;
> +
> +	np = of_find_compatible_node(NULL, "ibm,bsr", "ibm,bsr");
> +	if (!np)
> +		goto out_err;
> +
> +	bsr_class = class_create(THIS_MODULE, "bsr");
> +	if (IS_ERR(bsr_class)) {
> +		printk(KERN_ERR "class_create() failed for bsr_class\n");
> +		goto out_err;

At this point I think you can leak a reference to np.


> +	}
> +	bsr_class->dev_attrs = bsr_dev_attrs;
> +
> +	result = alloc_chrdev_region(&bsr_dev, 0, BSR_MAX_DEVS, "bsr");
> +	bsr_major = MAJOR(bsr_dev);
> +	if (result < 0) {
> +		printk(KERN_ERR "alloc_chrdev_region() failed for bsr\n");
> +		goto out_err_1;
> +	}
> +
> +	if ((ret = bsr_create_devs(np)) < 0)
> +		goto out_err_2;
> +
> +	of_node_put(np);
> +
> +	return 0;
> +
> + out_err_2:
> +	unregister_chrdev_region(bsr_dev, BSR_MAX_DEVS);
> +
> + out_err_1:
> +	class_destroy(bsr_class);
> +	of_node_put(np);
> +
> + out_err:
> +
> +	return ret;
> +}
