Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6ABDA1A0889
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 21:31:16 +1000 (AEST)
In-Reply-To: <1432871759.306324.398125101148.1.gpush@pablo>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3,v3] powerpc/powernv: Add opal-prd channel
Message-Id: <20150604113116.61400140273@ozlabs.org>
Date: Thu,  4 Jun 2015 21:31:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-29-05 at 03:55:59 UTC, Jeremy Kerr wrote:
> This change adds a char device to access the "PRD" (processor runtime
> diagnostics) channel to OPAL firmware.
> 
> Includes contributions from Vaidyanathan Srinivasan, Neelesh Gupta &
> Vishal Kulkarni.
> 
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Sorry, I put this in but then hit the build break, I was going to fix it up but
would rather you did and tested it, so we may as well do another review :)

> diff --git a/arch/powerpc/include/uapi/asm/opal-prd.h b/arch/powerpc/include/uapi/asm/opal-prd.h
> new file mode 100644
> index 0000000..319ff4a
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/opal-prd.h
> @@ -0,0 +1,58 @@
> +/*
> + * OPAL Runtime Diagnostics interface driver
> + * Supported on POWERNV platform
> + *
> + * (C) Copyright IBM 2015

Usual syntax is: "Copyright IBM Corporation 2015"

> + *
> + * Author: Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>
> + * Author: Jeremy Kerr <jk@ozlabs.org>

I'd rather you dropped these, they'll just bit rot, but if you insist I don't
care that much.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.

As pointed out by Daniel, we should probably be using the "version 2" only
language on new files.

> diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
> new file mode 100644
> index 0000000..3004f4a
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-prd.c
> @@ -0,0 +1,451 @@

...

> +/*
> + * opal_prd_mmap - maps firmware-provided ranges into userspace
> + * @file: file structure for the device
> + * @vma: VMA to map the registers into
> + */
> +
> +static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	size_t addr, size;
> +	int rc;
> +
> +	pr_devel("opal_prd_mmap(0x%016lx, 0x%016lx, 0x%lx, 0x%lx)\n",
> +			vma->vm_start, vma->vm_end, vma->vm_pgoff,
> +			vma->vm_flags);
> +
> +	addr = vma->vm_pgoff << PAGE_SHIFT;
> +	size = vma->vm_end - vma->vm_start;
> +
> +	/* ensure we're mapping within one of the allowable ranges */
> +	if (!opal_prd_range_is_valid(addr, size))
> +		return -EINVAL;
> +
> +	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
> +						 size, vma->vm_page_prot)
> +				| _PAGE_SPECIAL;

This doesn't build with CONFIG_STRICT_MM_TYPECHECKS=y:

  arch/powerpc/platforms/powernv/opal-prd.c:131:5: error: invalid operands to binary | (have ‘pgprot_t’ and ‘int’)
  | _PAGE_SPECIAL;


> +static long opal_prd_ioctl(struct file *file, unsigned int cmd,
> +		unsigned long param)
> +{
> +	struct opal_prd_info info;
> +	struct opal_prd_scom scom;
> +	int rc = 0;
> +
> +	switch(cmd) {
              ^
	      space please

> +	case OPAL_PRD_GET_INFO:
> +		memset(&info, 0, sizeof(info));
> +		info.version = OPAL_PRD_KERNEL_VERSION;
> +		rc = copy_to_user((void __user *)param, &info, sizeof(info));
> +		if (rc)
> +			return -EFAULT;
> +		break;
> +
> +	case OPAL_PRD_SCOM_READ:
> +		rc = copy_from_user(&scom, (void __user *)param, sizeof(scom));
> +		if (rc)
> +			return -EFAULT;
> +
> +		scom.rc = opal_xscom_read(scom.chip, scom.addr,
> +				(__be64 *)&scom.data);
> +		scom.data = be64_to_cpu(scom.data);
> +		pr_devel("ioctl SCOM_READ: chip %llx addr %016llx "
> +				"data %016llx rc %lld\n",

Don't split the string please.

> +				scom.chip, scom.addr, scom.data, scom.rc);
> +
> +		rc = copy_to_user((void __user *)param, &scom, sizeof(scom));
> +		if (rc)
> +			return -EFAULT;
> +		break;
> +
> +	case OPAL_PRD_SCOM_WRITE:
> +		rc = copy_from_user(&scom, (void __user *)param, sizeof(scom));
> +		if (rc)
> +			return -EFAULT;
> +
> +		scom.rc = opal_xscom_write(scom.chip, scom.addr, scom.data);
> +		pr_devel("ioctl SCOM_WRITE: chip %llx addr %016llx "
> +				"data %016llx rc %lld\n",

Don't split the string please.

> +				scom.chip, scom.addr, scom.data, scom.rc);
> +
> +		rc = copy_to_user((void __user *)param, &scom, sizeof(scom));
> +		if (rc)
> +			return -EFAULT;
> +		break;
> +
> +	default:
> +		rc = -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +
> +struct file_operations opal_prd_fops = {

This can be static const I think.

> +	.open		= opal_prd_open,
> +	.mmap		= opal_prd_mmap,
> +	.poll		= opal_prd_poll,
> +	.read		= opal_prd_read,
> +	.write		= opal_prd_write,
> +	.unlocked_ioctl	= opal_prd_ioctl,
> +	.release	= opal_prd_release,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct miscdevice opal_prd_dev = {
> +        .minor		= MISC_DYNAMIC_MINOR,
> +        .name		= "opal-prd",
> +        .fops		= &opal_prd_fops,

White space is messed up here, should be leading tabs.

cheers
