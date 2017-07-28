Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJbj912T8zDrMF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 14:39:25 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 125so9004331pgi.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 21:39:25 -0700 (PDT)
Message-ID: <1501216755.3324.5.camel@gmail.com>
Subject: Re: [PATCH V8 3/3] powernv: Add support to clear sensor groups data
From: Cyril Bur <cyrilbur@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 stewart@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
Date: Fri, 28 Jul 2017 14:39:15 +1000
In-Reply-To: <1501045509-21732-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1501045509-21732-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1501045509-21732-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 10:35 +0530, Shilpasri G Bhat wrote:
> Adds support for clearing different sensor groups. OCC inband sensor
> groups like CSM, Profiler, Job Scheduler can be cleared using this
> driver. The min/max of all sensors belonging to these sensor groups
> will be cleared.
> 

Hi Shilpasri,

I think also some comments from v1 also apply here.

Other comments inline

Thanks,

Cyril

> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from V7:
> - s/send_occ_command/opal_sensor_groups_clear_history
> 
>  arch/powerpc/include/asm/opal-api.h            |   3 +-
>  arch/powerpc/include/asm/opal.h                |   2 +
>  arch/powerpc/include/uapi/asm/opal-occ.h       |  23 ++++++
>  arch/powerpc/platforms/powernv/Makefile        |   2 +-
>  arch/powerpc/platforms/powernv/opal-occ.c      | 109 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>  arch/powerpc/platforms/powernv/opal.c          |   3 +
>  7 files changed, 141 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/include/uapi/asm/opal-occ.h
>  create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 0d37315..342738a 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -195,7 +195,8 @@
>  #define OPAL_SET_POWERCAP			153
>  #define OPAL_GET_PSR				154
>  #define OPAL_SET_PSR				155
> -#define OPAL_LAST				155
> +#define OPAL_SENSOR_GROUPS_CLEAR		156
> +#define OPAL_LAST				156
>  
>  /* Device tree flags */
>  
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 58b30a4..92db6af 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -271,6 +271,7 @@ int64_t opal_xive_set_vp_info(uint64_t vp,
>  int opal_set_powercap(u32 handle, int token, u32 pcap);
>  int opal_get_power_shifting_ratio(u32 handle, int token, u32 *psr);
>  int opal_set_power_shifting_ratio(u32 handle, int token, u32 psr);
> +int opal_sensor_groups_clear(u32 group_hndl, int token);
>  
>  /* Internal functions */
>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
> @@ -351,6 +352,7 @@ static inline int opal_get_async_rc(struct opal_msg msg)
>  
>  void opal_powercap_init(void);
>  void opal_psr_init(void);
> +int opal_sensor_groups_clear_history(u32 handle);
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/include/uapi/asm/opal-occ.h b/arch/powerpc/include/uapi/asm/opal-occ.h
> new file mode 100644
> index 0000000..97c45e2
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/opal-occ.h
> @@ -0,0 +1,23 @@
> +/*
> + * OPAL OCC command interface
> + * Supported on POWERNV platform
> + *
> + * (C) Copyright IBM 2017
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _UAPI_ASM_POWERPC_OPAL_OCC_H_
> +#define _UAPI_ASM_POWERPC_OPAL_OCC_H_
> +
> +#define OPAL_OCC_IOCTL_CLEAR_SENSOR_GROUPS	_IOR('o', 1, u32)
> +
> +#endif /* _UAPI_ASM_POWERPC_OPAL_OCC_H */
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 9ed7d33..f193b33 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> -obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o
> +obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-occ.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-occ.c b/arch/powerpc/platforms/powernv/opal-occ.c
> new file mode 100644
> index 0000000..d1d4b28
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-occ.c
> @@ -0,0 +1,109 @@
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
> +#include <linux/fs.h>
> +#include <asm/opal.h>
> +#include <asm/opal-occ.h>
> +
> +DEFINE_MUTEX(opal_occ_mutex);
> +
> +int opal_sensor_groups_clear_history(u32 handle)
> +{
> +	struct opal_msg async_msg;
> +	int token, rc;
> +
> +	token = opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		pr_devel("Failed to get the token %d\n", token);
> +		return token;
> +	}
> +
> +	mutex_lock(&opal_occ_mutex);
> +	rc = opal_sensor_groups_clear(handle, token);
> +	if (rc == OPAL_ASYNC_COMPLETION) {
> +		rc = opal_async_wait_response(token, &async_msg);
> +		if (rc) {

rc here is an errno, but you're going to pass it through
opal_error_code() before returning

> +			pr_devel("Failed to wait for async response %d\n", rc);
> +			goto out;
> +		}
> +		rc = opal_get_async_rc(async_msg);
> +	}
> +out:
> +	mutex_unlock(&opal_occ_mutex);
> +	opal_async_release_token(token);
> +	return opal_error_code(rc);
> +}
> +EXPORT_SYMBOL_GPL(opal_sensor_groups_clear_history);
> +
> +static long opal_occ_ioctl(struct file *file, unsigned int cmd,
> +			   unsigned long param)
> +{
> +	int rc = -EINVAL;
> +
> +	switch (cmd) {
> +	case OPAL_OCC_IOCTL_CLEAR_SENSOR_GROUPS:
> +		rc = opal_sensor_groups_clear_history(param);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static const struct file_operations opal_occ_fops = {
> +	.unlocked_ioctl = opal_occ_ioctl,

So is there a plan I'm missing to get a file descriptor to be able to
actually call ioctl()?

> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct miscdevice occ_dev = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= "occ",
> +	.fops	= &opal_occ_fops,
> +};
> +
> +static int opal_occ_probe(struct platform_device *pdev)
> +{
> +	return misc_register(&occ_dev);
> +}
> +
> +static int opal_occ_remove(struct platform_device *pdev)
> +{

Is it possible to race the _remove() with the _ioctl()? Presumably not
if theres an open fd... surely its fine.

> +	misc_deregister(&occ_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id opal_occ_match[] = {
> +	{ .compatible = "ibm,opal-occ-sensor-group" },
> +	{ },
> +};
> +
> +static struct platform_driver opal_occ_driver = {
> +	.driver = {
> +		.name           = "opal-occ",
> +		.of_match_table = opal_occ_match,
> +	},
> +	.probe	= opal_occ_probe,
> +	.remove	= opal_occ_remove,
> +};
> +
> +module_platform_driver(opal_occ_driver);
> +
> +MODULE_DESCRIPTION("PowerNV OPAL-OCC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 9867726..c1130e8 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -314,3 +314,4 @@ OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
>  OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
>  OPAL_CALL(opal_get_power_shifting_ratio,	OPAL_GET_PSR);
>  OPAL_CALL(opal_set_power_shifting_ratio,	OPAL_SET_PSR);
> +OPAL_CALL(opal_sensor_groups_clear,		OPAL_SENSOR_GROUPS_CLEAR);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 280a736..097c33c 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -842,6 +842,9 @@ static int __init opal_init(void)
>  	/* Initialise OPAL Power-Shifting-Ratio interface */
>  	opal_psr_init();
>  
> +	/* Initialize platform device: OCC interface */
> +	opal_pdev_init("ibm,opal-occ-sensor-group");
> +
>  	return 0;
>  }
>  machine_subsys_initcall(powernv, opal_init);
