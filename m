Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBN140K3mzF0R7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 18:32:07 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w037VVet084648
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jan 2018 02:32:06 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f8tc3gygc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jan 2018 02:32:05 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 3 Jan 2018 07:32:02 -0000
Subject: Re: [PATCH 04/13] powerpc/powernv: Add platform-specific services for
 opencapi
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <daaa7e08af012047baed61a79ed5dc62e5738766.1513608243.git.fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 3 Jan 2018 18:31:56 +1100
MIME-Version: 1.0
In-Reply-To: <daaa7e08af012047baed61a79ed5dc62e5738766.1513608243.git.fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8ac007be-bbb5-ed4f-96b1-01f008252a11@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/12/17 02:21, Frederic Barrat wrote:
> Implement a few platform-specific calls which can be used by drivers:
> 
> - provide the Transaction Layer capabilities of the host, so that the
>    driver can find some common ground and configure the device and host
>    appropriately.
> 
> - provide the hw interrupt to be used for translation faults raised by
>    the NPU
> 
> - map/unmap some NPU mmio registers to get the fault context when the
>    NPU raises an address translation fault
> 
> The rest are wrappers around the previously-introduced opal calls.
> 
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/pnv-ocxl.h     |  36 ++++++
>   arch/powerpc/platforms/powernv/Makefile |   1 +
>   arch/powerpc/platforms/powernv/ocxl.c   | 187 ++++++++++++++++++++++++++++++++
>   3 files changed, 224 insertions(+)
>   create mode 100644 arch/powerpc/include/asm/pnv-ocxl.h
>   create mode 100644 arch/powerpc/platforms/powernv/ocxl.c
> 
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> new file mode 100644
> index 000000000000..b9ab3f0a9634
> --- /dev/null
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright 2017 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _ASM_PVN_OCXL_H
> +#define _ASM_PVN_OCXL_H

I assume you meant "PNV" here.

> +
> +#include <linux/pci.h>
> +
> +#define PNV_OCXL_TL_MAX_TEMPLATE        63
> +#define PNV_OCXL_TL_BITS_PER_RATE       4
> +#define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
> +
> +extern int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
> +			char *rate_buf, int rate_buf_size);
> +extern int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
> +			uint64_t rate_buf_phys, int rate_buf_size);
> +
> +extern int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
> +extern void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
> +				void __iomem *tfc, void __iomem *pe_handle);
> +extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
> +				void __iomem **dar, void __iomem **tfc,
> +				void __iomem **pe_handle);
> +
> +extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
> +			void **platform_data);
> +extern void pnv_ocxl_spa_release(void *platform_data);
> +extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
> +
> +#endif /* _ASM_PVN_OCXL_H */

And here

> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 3732118a0482..6c9d5199a7e2 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
>   obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
>   obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
>   obj-$(CONFIG_PPC_FTW)	+= nx-ftw.o
> +obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> new file mode 100644
> index 000000000000..3378b75cf5e5
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> +int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq)
> +{
> +	int rc;
> +
> +	rc = of_property_read_u32(dev->dev.of_node, "ibm,opal-xsl-irq", hwirq);
> +	if (rc) {
> +		dev_err(&dev->dev,
> +			"Can't translation xsl interrupt for device\n");

Can't get?


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
