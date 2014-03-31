Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/2] powerpc/powernv: Add OPAL message log interface
In-reply-to: <1395964240-8305-2-git-send-email-joel@jms.id.au>
References: <1395964240-8305-1-git-send-email-joel@jms.id.au>
 <1395964240-8305-2-git-send-email-joel@jms.id.au>
Date: Mon, 31 Mar 2014 15:08:55 +1100
Message-ID: <21604.1396238935@ale.ozlabs.ibm.com>
Cc: stewart@linux.vnet.ibm.com, michael@ellerman.id.au,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com, paulus@samba.org,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> wrote:

> OPAL provides an in-memory circular buffer containing a message log
> populated with various runtime messages produced by the firmware.
> 
> Provide a sysfs interface /sys/firmware/opal/messages for userspace to
> view the messages.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/include/asm/opal.h                |  4 ++
>  arch/powerpc/platforms/powernv/Makefile        |  1 +
>  arch/powerpc/platforms/powernv/opal-messages.c | 97 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c          |  4 +-
>  4 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-messages.c
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index ffafab0..6aa757e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -729,6 +729,9 @@ typedef struct oppanel_line {
>  /* /sys/firmware/opal */
>  extern struct kobject *opal_kobj;
>  
> +/* /ibm,opal */
> +extern struct device_node *opal_node;
> +
>  /* API functions */
>  int64_t opal_console_write(int64_t term_number, __be64 *length,
>  			   const uint8_t *buffer);
> @@ -918,6 +921,7 @@ extern void opal_flash_init(void);
>  extern int opal_elog_init(void);
>  extern void opal_platform_dump_init(void);
>  extern void opal_sys_param_init(void);
> +extern void opal_messages_init(void);
>  
>  extern int opal_machine_check(struct pt_regs *regs);
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index f324ea0..e2ba418 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,6 +1,7 @@
>  obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
> +obj-y			+= opal-messages.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
> diff --git a/arch/powerpc/platforms/powernv/opal-messages.c b/arch/powerpc/platforms/powernv/opal-messages.c
> new file mode 100644
> index 0000000..3a863e8
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-messages.c
> @@ -0,0 +1,97 @@
> +/*
> + * PowerNV OPAL in-memory console interface
> + *
> + * Copyright 2014 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/io.h>
> +#include <asm/opal.h>
> +#include <linux/debugfs.h>
> +#include <linux/of.h>
> +#include <linux/types.h>
> +
> +/* OPAL in-memory console. Defined in OPAL source at core/console.c */
> +struct memcons {
> +	__be64 magic;
> +#define MEMCONS_MAGIC	0x6630696567726173L

0x6630696567726173 == f0iegras ... Ben!!! :-P

> +	__be64 obuf_phys;
> +	__be64 ibuf_phys;
> +	__be32 obuf_size;
> +	__be32 ibuf_size;
> +	__be32 out_pos;
> +#define MEMCONS_OUT_POS_WRAP	0x80000000u
> +#define MEMCONS_OUT_POS_MASK	0x00ffffffu
> +	__be32 in_prod;
> +	__be32 in_cons;
> +};
> +
> +static ssize_t opal_messages_read(struct file *file, struct kobject *kobj,
> +	struct bin_attribute *bin_attr, char *to, loff_t pos, size_t count)
> +{
> +	struct memcons *mc = bin_attr->private;
> +	const char *conbuf;
> +	bool wrapped;
> +	size_t num_read;
> +	int out_pos;
> +
> +	if (!mc)
> +		return -ENODEV;
> +
> +	conbuf = phys_to_virt(be64_to_cpu(mc->obuf_phys));
> +	wrapped = be32_to_cpu(mc->out_pos) & MEMCONS_OUT_POS_WRAP;
> +	out_pos = be32_to_cpu(mc->out_pos) & MEMCONS_OUT_POS_MASK;
> +

Are there ordering issues we need to think about here with reading
these?  Can the messages be written on another CPU at the same time as
these are being read?

What happens if in between reading wrapped and out_pos the buffer wraps?
You'd end up getting only a few bytes of console?  Maybe you need to
read wrapped before and after out_pos to make should it's not wrapped in
between.

> +	if (!wrapped) {

Why the negative case first?  Just make it:

   if (wrapped) {
      wrapped case
   } else {
      not wrapped case
   }

Also, no curlies needed for single statement.


> +		num_read = memory_read_from_buffer(to, count, &pos, conbuf,
> +				out_pos);

This is probably not necessary, but do we need to sanity check out_pos <
obuf_size?  I guess we don't generally sanity check numbers from OPAL as
it can screw us in many other ways anyway.

> +	} else {
> +		num_read = memory_read_from_buffer(to, count, &pos,
> +				conbuf + out_pos,
> +				be32_to_cpu(mc->obuf_size) - out_pos);
> +
> +		if (num_read < 0)
> +			goto out;
> +
> +		num_read += memory_read_from_buffer(to + num_read,
> +				count - num_read, &pos, conbuf,
>                out_pos);

What if this second read returns an error?  num_read += -ERRNO?  I think
you need to check this return independently.

Mikey

> +	}
> +out:
> +	return num_read;
> +}
> +
> +static struct bin_attribute messages_attr = {
> +	.attr = {.name = "messages", .mode = 0444},
> +	.read = opal_messages_read
> +};
> +
> +void __init opal_messages_init(void)
> +{
> +	u64 mcaddr;
> +	struct memcons *mc;
> +
> +	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &mcaddr)) {
> +		pr_warn("OPAL: Property ibm,opal-memcons not found, no message log\n");
> +		return;
> +	}
> +
> +	mc = phys_to_virt(mcaddr);
> +	if (!mc) {
> +		pr_warn("OPAL: memory console address is invalid\n");
> +		return;
> +	}
> +
> +	if (be64_to_cpu(mc->magic) != MEMCONS_MAGIC) {
> +		pr_warn("OPAL: memory console version is invalid\n");
> +		return;
> +	}
> +
> +	messages_attr.private = mc;
> +
> +	if (sysfs_create_bin_file(opal_kobj, &messages_attr) != 0)
> +		pr_warn("OPAL: sysfs file creation failed\n");
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index e92f2f6..2bc032a 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -46,7 +46,7 @@ struct mcheck_recoverable_range {
>  static struct mcheck_recoverable_range *mc_recoverable_range;
>  static int mc_recoverable_range_len;
>  
> -static struct device_node *opal_node;
> +struct device_node *opal_node;
>  static DEFINE_SPINLOCK(opal_write_lock);
>  extern u64 opal_mc_secondary_handler[];
>  static unsigned int *opal_irqs;
> @@ -574,6 +574,8 @@ static int __init opal_init(void)
>  		opal_platform_dump_init();
>  		/* Setup system parameters interface */
>  		opal_sys_param_init();
> +		/* Setup message log interface. */
> +		opal_messages_init();
>  	}
>  
>  	return 0;
> -- 
> 1.9.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
