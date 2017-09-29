Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3NtD5b3ZzDrFs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 17:46:44 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id o13so617177qtf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 00:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506667651-32301-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1506667651-32301-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Fri, 29 Sep 2017 17:46:41 +1000
Message-ID: <CAOSf1CGsvnc116ZdoG7nu4WsQxVRAA3BbBZw_NL9t+NQVCEa9g@mail.gmail.com>
Subject: Re: [PATCH] powernv: Add OCC driver to mmap sensor area
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2017 at 4:47 PM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> This driver provides interface to mmap the OCC sensor area
> to userspace to parse and read OCC inband sensors.
>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> - The skiboot patch for this is posted here:
> https://lists.ozlabs.org/pipermail/skiboot/2017-September/009209.html
>
>  arch/powerpc/platforms/powernv/Makefile   |  2 +-
>  arch/powerpc/platforms/powernv/opal-occ.c | 88 +++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c     |  3 ++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
>
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 37d60f7..7911295 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -2,7 +2,7 @@ obj-y                   += setup.o opal-wrappers.o opal.o opal-async.o idle.o
>  obj-y                  += opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y                  += rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y                  += opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> -obj-y                  += opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
> +obj-y                  += opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o opal-occ.o
>
>  obj-$(CONFIG_SMP)      += smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)      += pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-occ.c b/arch/powerpc/platforms/powernv/opal-occ.c
> new file mode 100644
> index 0000000..5ca3a41
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-occ.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright IBM Corporation 2017
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) "opal-occ: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/highmem.h>
> +#include <asm/opal.h>
> +
> +static struct miscdevice occ;
> +static u64 sensor_base, sensor_size;
> +
> +static int opal_occ_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       if (vma->vm_flags & VM_WRITE)
> +               return -EINVAL;
> +
> +       return vm_iomap_memory(vma, sensor_base, sensor_size);

Hmm, this concerns me slightly. Is this going to create an IO page
mapping (i.e. cache inhibited) or normal memory mapping?

Another possible issue is that we're limited to mapping 64KB pages so
this will expose whatever follows the sensor block in memory to user
space unless the range is 64KB aligned. It looks like this is probably
safe for P9 due to the layout of the sensor memory, but that might not
be true in the future. At the very least you should have a comment
mentioning the issue.

> +}
> +
> +static const struct file_operations opal_occ_fops = {
> +       .mmap           = opal_occ_mmap,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static int opal_occ_probe(struct platform_device *pdev)
> +{
> +       u64 reg[2];
> +       int rc;
> +
> +       if (!pdev || !pdev->dev.of_node)
> +               return -ENODEV;
> +
> +       if (of_property_read_u64_array(pdev->dev.of_node, "occ-sensors",
> +                                      &reg[0], 2)) {
> +               pr_warn("occ-sensors property not found\n");
> +               return -ENODEV;
> +       }
> +
> +       sensor_base = reg[0];
> +       sensor_size = reg[1];
> +       occ.minor = MISC_DYNAMIC_MINOR;
> +       occ.name = "occ";
> +       occ.fops = &opal_occ_fops;
> +       rc = misc_register(&occ);
> +       if (rc)
> +               pr_warn("Failed to register OCC device\n");
> +
> +       return rc;
> +}
> +
> +static int opal_occ_remove(struct platform_device *pdev)
> +{
> +       misc_deregister(&occ);
> +       return 0;
> +}
> +
> +static const struct of_device_id opal_occ_match[] = {
> +       { .compatible = "ibm,opal-occ-inband-sensors" },
> +       { },
> +};
> +
> +static struct platform_driver opal_occ_driver = {
> +       .driver = {
> +               .name           = "opal_occ",
> +               .of_match_table = opal_occ_match,
> +        },
> +       .probe  = opal_occ_probe,
> +       .remove = opal_occ_remove,
> +};
> +
> +module_platform_driver(opal_occ_driver);
> +
> +MODULE_DESCRIPTION("PowerNV OPAL-OCC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 65c79ec..a4f977f 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -889,6 +889,9 @@ static int __init opal_init(void)
>         /* Initialise OPAL sensor groups */
>         opal_sensor_groups_init();
>
> +       /* Initialise OCC driver */
> +       opal_pdev_init("ibm,opal-occ-inband-sensors");
> +
>         return 0;
>  }
>  machine_subsys_initcall(powernv, opal_init);
> --
> 1.8.3.1

Overall I'm wondering if we really need a separate driver for this. We
added the /ibm,opal/firmware/exports/ node to handle this sort of
thing so it would be good if we could use that. Do you know what is
going to consume this data in userspace?

Thanks,
oliver
