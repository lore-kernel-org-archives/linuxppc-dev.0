Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 391C31A0175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 07:47:58 +1000 (EST)
Message-ID: <1403557535.4587.135.camel@pasglop>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2014 07:05:35 +1000
In-Reply-To: <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-23 at 12:14 +1000, Gavin Shan wrote:
> The patch implements one OPAL firmware sysfs file to support PCI error
> injection: "/sys/firmware/opal/errinjct", which will be used like the
> way described as follows.
> 
> According to PAPR spec, there are 3 RTAS calls related to error injection:
> "ibm,open-errinjct": allocate token prior to doing error injection.
> "ibm,close-errinjct": release the token allocated from "ibm,open-errinjct".
> "ibm,errinjct": do error injection.
> 
> Sysfs file /sys/firmware/opal/errinjct accepts strings that have fixed
> format "ei_token ...". For now, we only support 32-bits and 64-bits
> PCI error injection and they should have following strings written to
> /sys/firmware/opal/errinjct as follows. We don't have corresponding
> sysfs files for "ibm,open-errinjct" and "ibm,close-errinjct", which
> means that we rely on userland to maintain the token by itself.

Should we instead look into adding a file in the existing sysfs
directory of the specific PHB ?

Cheers,
Ben.

> 32-bits PCI error: "7:addr:mask:iommu_group_id:function".
> 64-bits PCI error: "8:addr:mask:iommu_group_id:function".
> 
> The above "7" and "8" represent 32-bits and 64-bits PCI error seperately
> and "function" is one of the specific PCI errors (e.g. MMIO access address
> parity error), which are defined by PAPR spec.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal.h                |   1 +
>  arch/powerpc/platforms/powernv/Makefile        |   2 +-
>  arch/powerpc/platforms/powernv/opal-errinjct.c | 184 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c          |   2 +
>  4 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-errinjct.c
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index d982bb8..bf280d9 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -985,6 +985,7 @@ extern int opal_elog_init(void);
>  extern void opal_platform_dump_init(void);
>  extern void opal_sys_param_init(void);
>  extern void opal_msglog_init(void);
> +extern void opal_errinjct_init(void);
>  
>  extern int opal_machine_check(struct pt_regs *regs);
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 63cebb9..4711de8 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,7 +1,7 @@
>  obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
> -obj-y			+= opal-msglog.o
> +obj-y			+= opal-msglog.o opal-errinjct.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
> diff --git a/arch/powerpc/platforms/powernv/opal-errinjct.c b/arch/powerpc/platforms/powernv/opal-errinjct.c
> new file mode 100644
> index 0000000..29c9e83
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-errinjct.c
> @@ -0,0 +1,184 @@
> +/*
> + * The file supports error injection, which works based on OPAL API.
> + * For now, we only support PCI error injection. We need support
> + * injecting other types of errors in future.
> + *
> + * Copyright Gavin Shan, IBM Corporation 2014.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/msi.h>
> +#include <linux/pci.h>
> +#include <linux/iommu.h>
> +#include <linux/random.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/fs.h>
> +#include <linux/fcntl.h>
> +#include <linux/kobject.h>
> +
> +#include <asm/msi_bitmap.h>
> +#include <asm/iommu.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/ppc-pci.h>
> +#include <asm/opal.h>
> +
> +#include "powernv.h"
> +#include "pci.h"
> +
> +static DEFINE_MUTEX(errinjct_mutex);
> +
> +static int errinjct_iommu_group_to_phb_and_pe(uint32_t iommu_grp_id,
> +					      uint64_t *phb_id,
> +					      uint32_t *pe_num)
> +{
> +#ifdef CONFIG_IOMMU_API
> +	struct iommu_group *iommu_grp;
> +	struct iommu_table *tbl;
> +	struct pnv_ioda_pe *pe;
> +
> +	iommu_grp = iommu_group_get_by_id(iommu_grp_id);
> +	if (!iommu_grp)
> +		return -ENODEV;
> +
> +	tbl = iommu_group_get_iommudata(iommu_grp);
> +	if (!tbl)
> +		return -ENODEV;
> +
> +	pe = container_of(tbl, struct pnv_ioda_pe, tce32_table);
> +	if (!pe->phb)
> +		return -ENODEV;
> +
> +	*phb_id = pe->phb->opal_id;
> +	*pe_num = pe->pe_number;
> +
> +	return 0;
> +#endif
> +
> +	return -ENXIO;
> +}
> +
> +static int errinjct_ioa_bus_error(const char *buf, struct OpalErrinjct *ei)
> +{
> +	uint32_t iommu_grp_id;
> +	int ret;
> +
> +	/* Extract parameters */
> +	ret = sscanf(buf, "%x:%x:%x:%x:%x",
> +		     &ei->type, &ei->ioa.addr,
> +		     &ei->ioa.mask, &iommu_grp_id, ei->ioa.function);
> +	if (ret != 5)
> +		return -EINVAL;
> +
> +	/* Invalid function ? */
> +	if (ei->ioa.function < OpalEitIoaLoadMemAddr ||
> +	    ei->ioa.function > OpalEitIoaDmaWriteMemTarget)
> +		return -ERANGE;
> +
> +	/* Retrieve PHB ID and PE number */
> +	ret = errinjct_iommu_group_to_phb_and_pe(iommu_grp_id,
> +						 &ei->ioa.phb_id,
> +						 &ei->ioa.pe);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int errinjct_ioa_bus_error64(const char *buf, struct OpalErrinjct *ei)
> +{
> +	uint32_t iommu_grp_id;
> +	int ret;
> +
> +	/* Extract parameter */
> +	ret = sscanf(buf, "%x:%llx:%llx:%x:%x",
> +		     &ei->type, &ei->ioa64.addr,
> +		     &ei->ioa64.mask, &iommu_grp_id, &ei->ioa64.function);
> +	if (ret != 5)
> +		return -EINVAL;
> +
> +	/* Invalid function ? */
> +	if (ei->ioa64.function < OpalEitIoaLoadMemAddr ||
> +	    ei->ioa64.function > OpalEitIoaDmaWriteMemTarget)
> +		return -ERANGE;
> +
> +	/* Retrieve PHB ID and PE number */
> +	ret = errinjct_iommu_group_to_phb_and_pe(iommu_grp_id,
> +						 &ei->ioa64.phb_id,
> +						 &ei->ioa64.pe);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static ssize_t errinjct_store(struct kobject *kobj,
> +			      struct kobj_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct OpalErrinjct ei;
> +	int ret;
> +	long rc;
> +
> +	/* Extract common parameters */
> +	ret = sscanf(buf, "%x", &ei.type);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	/* Error injection might be in progress */
> +	if (!mutex_trylock(&errinjct_mutex))
> +		return -EAGAIN;
> +
> +	switch (ei.type) {
> +	case OpalErrinjctTypeIoaBusError:
> +		ret = errinjct_ioa_bus_error(buf, &ei);
> +		break;
> +	case OpalErrinjctTypeIoaBusError64:
> +		ret = errinjct_ioa_bus_error64(buf, &ei);
> +		break;
> +	default:
> +		ret = -ERANGE;
> +	}
> +
> +	/* Invalid parameters ? */
> +	if (ret)
> +		goto mutex_unlock_exit;
> +
> +	/* OPAL call */
> +	rc = opal_err_injct(&ei);
> +	if (rc == OPAL_SUCCESS)
> +		ret = count;
> +	else
> +		ret = -EIO;
> +
> +mutex_unlock_exit:
> +	mutex_unlock(&errinjct_mutex);
> +	return ret;
> +}
> +
> +static struct kobj_attribute errinjct_attr =
> +	__ATTR(errinjct, 0600, NULL, errinjct_store);
> +
> +void __init opal_errinjct_init(void)
> +{
> +	int ret;
> +
> +	/* Make sure /sys/firmware/opal directory is created */
> +	if (!opal_kobj) {
> +		pr_warn("%s: opal kobject is not available\n",
> +			__func__);
> +		return;
> +	}
> +
> +	/* Create the sysfs files */
> +	ret = sysfs_create_file(opal_kobj, &errinjct_attr.attr);
> +	if (ret)
> +		pr_warn("%s: Cannot create sysfs file (%d)\n",
> +			__func__, ret);
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 360ad80c..cb29bb5 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -604,6 +604,8 @@ static int __init opal_init(void)
>  		opal_sys_param_init();
>  		/* Setup message log interface. */
>  		opal_msglog_init();
> +		/* Setup error injection interface */
> +		opal_errinjct_init();
>  	}
>  
>  	return 0;
