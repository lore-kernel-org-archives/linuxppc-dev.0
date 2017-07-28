Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJWjq449QzDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 11:39:43 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id v190so22103586pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 18:39:43 -0700 (PDT)
Message-ID: <1501205974.3324.1.camel@gmail.com>
Subject: Re: [PATCH V8 1/3] powernv: powercap: Add support for powercap
 framework
From: Cyril Bur <cyrilbur@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 stewart@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
Date: Fri, 28 Jul 2017 11:39:34 +1000
In-Reply-To: <1501045509-21732-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1501045509-21732-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1501045509-21732-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
> Adds a generic powercap framework to change the system powercap
> inband through OPAL-OCC command/response interface.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from V7:
> - Replaced sscanf with kstrtoint
> 
>  arch/powerpc/include/asm/opal-api.h            |   5 +-
>  arch/powerpc/include/asm/opal.h                |   4 +
>  arch/powerpc/platforms/powernv/Makefile        |   2 +-
>  arch/powerpc/platforms/powernv/opal-powercap.c | 237 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
>  arch/powerpc/platforms/powernv/opal.c          |   4 +
>  6 files changed, 252 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-powercap.c
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 3130a73..c3e0c4a 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -42,6 +42,7 @@
>  #define OPAL_I2C_STOP_ERR	-24
>  #define OPAL_XIVE_PROVISIONING	-31
>  #define OPAL_XIVE_FREE_ACTIVE	-32
> +#define OPAL_TIMEOUT		-33
>  
>  /* API Tokens (in r0) */
>  #define OPAL_INVALID_CALL		       -1
> @@ -190,7 +191,9 @@
>  #define OPAL_NPU_INIT_CONTEXT			146
>  #define OPAL_NPU_DESTROY_CONTEXT		147
>  #define OPAL_NPU_MAP_LPAR			148
> -#define OPAL_LAST				148
> +#define OPAL_GET_POWERCAP			152
> +#define OPAL_SET_POWERCAP			153
> +#define OPAL_LAST				153
>  
>  /* Device tree flags */
>  
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 588fb1c..ec2087c 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -267,6 +267,8 @@ int64_t opal_xive_set_vp_info(uint64_t vp,
>  int64_t opal_xive_free_irq(uint32_t girq);
>  int64_t opal_xive_sync(uint32_t type, uint32_t id);
>  int64_t opal_xive_dump(uint32_t type, uint32_t id);
> +int opal_get_powercap(u32 handle, int token, u32 *pcap);
> +int opal_set_powercap(u32 handle, int token, u32 pcap);
>  
>  /* Internal functions */
>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
> @@ -345,6 +347,8 @@ static inline int opal_get_async_rc(struct opal_msg msg)
>  
>  void opal_wake_poller(void);
>  
> +void opal_powercap_init(void);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_OPAL_H */
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..e79f806 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> -obj-y			+= opal-kmsg.o
> +obj-y			+= opal-kmsg.o opal-powercap.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
> new file mode 100644
> index 0000000..7c57f4b
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
> @@ -0,0 +1,237 @@
> +/*
> + * PowerNV OPAL Powercap interface
> + *
> + * Copyright 2017 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt)     "opal-powercap: " fmt
> +
> +#include <linux/of.h>
> +#include <linux/kobject.h>
> +#include <linux/slab.h>
> +
> +#include <asm/opal.h>
> +
> +DEFINE_MUTEX(powercap_mutex);
> +
> +static struct kobject *powercap_kobj;
> +
> +struct powercap_attr {
> +	u32 handle;
> +	struct kobj_attribute attr;
> +};
> +
> +static struct attribute_group *pattr_groups;
> +static struct powercap_attr *pcap_attrs;
> +
> +static ssize_t powercap_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	struct powercap_attr *pcap_attr = container_of(attr,
> +						struct powercap_attr, attr);
> +	struct opal_msg msg;
> +	u32 pcap;
> +	int ret, token;
> +
> +	token = opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		pr_devel("Failed to get token\n");
> +		return token;
> +	}
> +
> +	mutex_lock(&powercap_mutex);

If this is purely a userspace interface, shouldn't this be
mutex_lock_interruptible()?

I'm going to say that we should leave this but I am curious as to what
it is protecting.

This is more for MPE and Stewart:
If there is some mutual exclusion that needs to happen, it should be
done in skiboot. We've had problems in the past with double entering
skiboot and hard to interpret errors ending up in userspace, this
solves that but it seems more like a coverup than an actual solution.

> +	ret = opal_get_powercap(pcap_attr->handle, token, &pcap);

Should always pass physical address of pointers to skiboot __pa(&pcap)

> +	switch (ret) {
> +	case OPAL_ASYNC_COMPLETION:
> +		ret = opal_async_wait_response(token, &msg);

This comment has nothing to do with this patch but this code would
benefit quite directly from opal_async_wait_response_interruptible()
that I've been working on.

> +		if (ret) {
> +			pr_devel("Failed to wait for the async response %d\n",
> +				 ret);

I wonder if the ret from opal_async_wait_response() is the best value
to return to userspace here. opal_async_wait_response() will return
-EINVAL if anything goes wrong, that feels confusing, perhaps -EIO.

> +			goto out;
> +		}
> +		ret = opal_error_code(opal_get_async_rc(msg));
> +		if (!ret)
> +			ret = sprintf(buf, "%u\n", be32_to_cpu(pcap));

I expect that for this and the OPAL_SUCCESS case you'll want to check
that ret is not negative, if it is you'll probably also want to return
-EIO or something reasonable.

I have no idea what the values are, what units they're in or anything -
 I assume %u is what makes the most sense since this should just be a
number.

> +		break;
> +	case OPAL_SUCCESS:
> +		ret = sprintf(buf, "%u\n", be32_to_cpu(pcap));
> +		break;
> +	default:
> +		ret = opal_error_code(ret);
> +	}
> +
> +out:
> +	mutex_unlock(&powercap_mutex);
> +	opal_async_release_token(token);
> +	return ret;
> +}
> +
> +static ssize_t powercap_store(struct kobject *kobj,
> +			      struct kobj_attribute *attr, const char *buf,
> +			      size_t count)
> +{
> +	struct powercap_attr *pcap_attr = container_of(attr,
> +						struct powercap_attr, attr);
> +	struct opal_msg msg;
> +	u32 pcap;
> +	int ret, token;
> +
> +	ret = kstrtoint(buf, 0, &pcap);
> +	if (ret)
> +		return ret;
> +
> +	token = opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		pr_devel("Failed to get token\n");
> +		return token;
> +	}
> +
> +	mutex_lock(&powercap_mutex);
> +	ret = opal_set_powercap(pcap_attr->handle, token, pcap);
> +	switch (ret) {
> +	case OPAL_ASYNC_COMPLETION:
> +		ret = opal_async_wait_response(token, &msg);
> +		if (ret) {
> +			pr_devel("Failed to wait for the async response %d\n",
> +				 ret);
> +			goto out;
> +		}
> +		ret = opal_error_code(opal_get_async_rc(msg));
> +		if (!ret)
> +			ret = count;
> +		break;
> +	case OPAL_SUCCESS:
> +		ret = count;
> +		break;
> +	default:
> +		ret = opal_error_code(ret);
> +	}
> +
> +out:
> +	mutex_unlock(&powercap_mutex);
> +	opal_async_release_token(token);
> +
> +	return ret;
> +}
> +
> +static void powercap_add_attr(int handle, const char *name,
> +			      struct powercap_attr *attr)
> +{
> +	attr->handle = handle;
> +	sysfs_attr_init(&attr->attr.attr);
> +	attr->attr.attr.name = name;
> +	attr->attr.attr.mode = 0444;
> +	attr->attr.show = powercap_show;
> +}
> +
> +void __init opal_powercap_init(void)
> +{
> +	struct device_node *powercap, *node;
> +	int pattr_group_count = 0, total_attr_count = 0;
> +	int i, count;
> +
> +	powercap = of_find_node_by_path("/ibm,opal/power-mgt/powercap");
> +	if (!powercap) {
> +		pr_devel("/ibm,opal/power-mgt/powercap node not found\n");
> +		return;
> +	}
> +
> +	for_each_child_of_node(powercap, node)

So I went digging and found this: of_get_child_count() which I think is
what you want (I'm always in favour of using generic helpers), then I
saw this right below it of_get_available_child_count(), do we care?

> +		pattr_group_count++;
> +
> +	pattr_groups = kcalloc(pattr_group_count,
> +			       sizeof(struct attribute_group), GFP_KERNEL);
> +	if (!pattr_groups)
> +		return;
> +
> +	i = 0;
> +	for_each_child_of_node(powercap, node) {
> +		int attr_count = 0;
> +
> +		if (of_find_property(node, "powercap-min", NULL))
> +			attr_count++;
> +		if (of_find_property(node, "powercap-max", NULL))
> +			attr_count++;
> +		if (of_find_property(node, "powercap-cur", NULL))
> +			attr_count++;
> +
> +		total_attr_count += attr_count;
> +		pattr_groups[i].attrs = kcalloc(attr_count + 1,
> +						sizeof(struct attribute *),
> +						GFP_KERNEL);
> +		if (!pattr_groups[i].attrs) {
> +			while (--i >= 0)
> +				kfree(pattr_groups[i].attrs);
> +			goto out_pattr_groups;
> +		}
> +		i++;
> +	}
> +
> +	pcap_attrs = kcalloc(total_attr_count, sizeof(struct powercap_attr),
> +			     GFP_KERNEL);
> +	if (!pcap_attrs)
> +		goto out_pattr_groups_attrs;

Is there any reason that pcap_attrs needs to be contiguous? If not, I
feel like you could eliminate the entire loop below (and the last one
as well maybe) and just do the assignment of pattr_groups[].attrs[] up
there.

In fact do you even need to store pcap_attrs? If you kcalloc them as
you need them (in the loop above), you can always free them again on
error by freeing pattr_groups[].attrs[] right?

I'll admit I've become quite confused as to the layout of the sysfs dir
 that you're creating here - would you mind showing what the expected
layout will be?

I'll take more of a look once thats more clear in my head

Thanks,

Cyril

> +
> +	count = 0;
> +	i = 0;
> +	for_each_child_of_node(powercap, node) {
> +		u32 handle;
> +		int j = 0;
> +
> +		pattr_groups[i].name = node->name;
> +
> +		if (!of_property_read_u32(node, "powercap-min", &handle)) {
> +			powercap_add_attr(handle, "powercap-min",
> +					  &pcap_attrs[count]);
> +			pattr_groups[i].attrs[j++] =
> +				&pcap_attrs[count++].attr.attr;
> +		}
> +
> +		if (!of_property_read_u32(node, "powercap-max", &handle)) {
> +			powercap_add_attr(handle, "powercap-max",
> +					  &pcap_attrs[count]);
> +			pattr_groups[i].attrs[j++] =
> +				&pcap_attrs[count++].attr.attr;
> +		}
> +
> +		if (!of_property_read_u32(node, "powercap-cur", &handle)) {
> +			powercap_add_attr(handle, "powercap-cur",
> +					  &pcap_attrs[count]);
> +			pcap_attrs[count].attr.attr.mode |= 0220;
> +			pcap_attrs[count].attr.store = powercap_store;
> +			pattr_groups[i].attrs[j++] =
> +				&pcap_attrs[count++].attr.attr;
> +		}
> +		i++;
> +	}
> +
> +	powercap_kobj = kobject_create_and_add("powercap", opal_kobj);
> +	if (!powercap_kobj) {
> +		pr_warn("Failed to create powercap kobject\n");
> +		goto out_pcap_attrs;
> +	}
> +
> +	for (i = 0; i < pattr_group_count; i++) {
> +		if (sysfs_create_group(powercap_kobj, &pattr_groups[i])) {
> +			pr_warn("Failed to create powercap attribute group %s\n",
> +				pattr_groups[i].name);
> +			goto out;
> +		}
> +	}
> +
> +	return;
> +out:
> +	kobject_put(powercap_kobj);
> +out_pcap_attrs:
> +	kfree(pcap_attrs);
> +out_pattr_groups_attrs:
> +	while (--pattr_group_count >= 0)
> +		kfree(pattr_groups[i].attrs);
> +out_pattr_groups:
> +	kfree(pattr_groups);
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 4ca6c26..eff5fe7 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -310,3 +310,5 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
>  OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
>  OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
>  OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
> +OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
> +OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index cad6b57..889da97 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -836,6 +836,9 @@ static int __init opal_init(void)
>  	/* Initialise OPAL kmsg dumper for flushing console on panic */
>  	opal_kmsg_init();
>  
> +	/* Initialise OPAL powercap interface */
> +	opal_powercap_init();
> +
>  	return 0;
>  }
>  machine_subsys_initcall(powernv, opal_init);
> @@ -952,6 +955,7 @@ int opal_error_code(int rc)
>  	case OPAL_UNSUPPORTED:		return -EIO;
>  	case OPAL_HARDWARE:		return -EIO;
>  	case OPAL_INTERNAL_ERROR:	return -EIO;
> +	case OPAL_TIMEOUT:		return -ETIMEDOUT;
>  	default:
>  		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
>  		return -EIO;
