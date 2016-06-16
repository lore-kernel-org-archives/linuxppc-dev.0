Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVfb33Y47zDqnP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 20:22:39 +1000 (AEST)
In-Reply-To: <1461826958-3925-2-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, arnd@arndb.de
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [V3,
 2/2] powerpc/drivers: Add driver for operator panel on FSP machines
Message-Id: <3rVfb32ZF6z9t0l@ozlabs.org>
Date: Thu, 16 Jun 2016 20:22:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 07:02:38 UTC, Suraj Jitindar Singh wrote:
> Implement new character device driver to allow access from user space
> to the 2x16 character operator panel display present on IBM Power Systems
> machines with FSPs.

I looked at this previously and somehow convinced myself it depended on skiboot
changes, but it seems it doesn't.

Some comments below ...

> This will allow status information to be presented on the display which
> is visible to a user.
> 
> The driver implements a 32 character buffer which a user can read/write

It looks like "32" is actually just one possible size, it comes from the device
tree no?

> by accessing the device (/dev/oppanel). This buffer is then displayed on

Are we sure "op_panel" wouldn't be better?

> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 0450310..8f9f4ce 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -181,6 +181,7 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_JSM=m
>  CONFIG_VIRTIO_CONSOLE=m
> +CONFIG_IBM_OP_PANEL=m

I think CONFIG_POWERNV_OP_PANEL would be a better name.

> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9d86c66..b33e349 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -178,6 +178,8 @@ int64_t opal_dump_ack(uint32_t dump_id);
>  int64_t opal_dump_resend_notification(void);
>  
>  int64_t opal_get_msg(uint64_t buffer, uint64_t size);
> +int64_t opal_write_oppanel_async(uint64_t token, oppanel_line_t *lines,
> +					uint64_t num_lines);

I realise you're just following the skiboot code which uses oppanel_line_t, but
please don't do that in the kernel. Just use struct oppanel_line directly.

> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index d8a7579..a02c61b 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -60,3 +60,4 @@ js-rtc-y = rtc.o
>  
>  obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
>  obj-$(CONFIG_XILLYBUS)		+= xillybus/
> +obj-$(CONFIG_IBM_OP_PANEL)	+= op-panel-powernv.o

I'd prefer powernv-op-panel.c, but up to you.

> diff --git a/drivers/char/op-panel-powernv.c b/drivers/char/op-panel-powernv.c
> new file mode 100644
> index 0000000..90b74b7
> --- /dev/null
> +++ b/drivers/char/op-panel-powernv.c
> @@ -0,0 +1,247 @@
> +/*
> + * OPAL Operator Panel Display Driver
> + *
> + * (C) Copyright IBM Corp. 2016
> + *
> + * Author: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I'm not a fan of email addresses in C files, they just bit rot.

The preferred format is:

 * Copyright 2016, Suraj Jitindar Singh, IBM Corporation.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

We don't need that paragraph in every file.

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +
> +#include <asm/opal.h>
> +#include <asm/opal-api.h>

opal-api.h is sort of an implementation detail, you should just include opal.h

> +/*
> + * This driver creates a character device (/dev/oppanel) which exposes the
> + * operator panel (2x16 character LCD display) on IBM Power Systems machines
> + * with FSPs.
> + * A 32 character buffer written to the device will be displayed on the
> + * operator panel.
> + */
> +
> +static DEFINE_MUTEX(oppanel_mutex);
> +
> +static oppanel_line_t	*oppanel_lines;
> +static char		*oppanel_data;
> +static u32		line_length, num_lines;

You calculate (num_lines * line_length) a lot, that would probably be worth
storing as eg. "oppanel_size" or something.

> +
> +static loff_t oppanel_llseek(struct file *filp, loff_t offset, int whence)
> +{
> +	return fixed_size_llseek(filp, offset, whence, num_lines *
> +		line_length);

I don't think you need to wrap that line?

> +}
> +
> +static ssize_t oppanel_read(struct file *filp, char __user *userbuf, size_t len,
> +		loff_t *f_pos)

I prefer to align the second line unless the signature is ridiculously wide:

static ssize_t oppanel_read(struct file *filp, char __user *userbuf, size_t len,
			    loff_t *f_pos)

> +{
> +	return simple_read_from_buffer(userbuf, len, f_pos, oppanel_data,
> +		(num_lines * line_length));
> +}
> +
> +static int __op_panel_write(void)

Can you think of a better name for this?

> +{
> +	int rc, token;
> +	struct opal_msg msg;
> +
> +	token = opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		if (token != -ERESTARTSYS)
> +			pr_err("Couldn't get OPAL async token [token=%d]\n",
> +				token);
> +		return token;
> +	}
> +
> +	rc = opal_write_oppanel_async(token, oppanel_lines, (u64) num_lines);

I don't think you need the cast?

> +	switch (rc) {
> +	case OPAL_ASYNC_COMPLETION:
> +		rc = opal_async_wait_response(token, &msg);
> +		if (rc) {
> +			pr_err("Failed to wait for async response [rc=%d]\n",
> +				rc);
> +			goto out_token;
> +		}
> +		rc = be64_to_cpu(msg.params[1]);

Is params[1] documented somewhere? Seems like a helper might be nice.

> +		if (rc != OPAL_SUCCESS) {
> +			pr_err("OPAL async call returned failed [rc=%d]\n", rc);
> +			goto out_token;

You don't need the goto do you? You can just break?

> +		}
> +	case OPAL_SUCCESS:
> +		break;
> +	default:
> +		pr_err("OPAL write op-panel call failed [rc=%d]\n", rc);

This and the other pr_err()s should be ratelimited, or become pr_debug().

> +	}
> +
> +out_token:
> +	opal_async_release_token(token);
> +	return rc;
> +}
> +
> +static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
> +		size_t len, loff_t *f_pos)
> +{
> +	ssize_t ret;
> +	loff_t f_pos_prev = *f_pos;
> +	int rc;
> +
> +	if (*f_pos >= (num_lines * line_length))
> +		return -EFBIG;
> +
> +	ret = simple_write_to_buffer(oppanel_data, (num_lines *
> +			line_length), f_pos, userbuf, len);

AFAICS you never clear the buffer, so if I write "foobar" and then call write
again with "foo", I'll end up with "foobar" on the panel?

Should you clear the buffer when the first write comes in (f_pos == 0) ?

> +	if (ret > 0) {
> +		rc = __op_panel_write();
> +		if (rc != OPAL_SUCCESS) {
> +			pr_err("OPAL call failed to write to op panel display [rc=%d]\n",
> +				rc);
> +			*f_pos = f_pos_prev;
> +			return -EIO;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int oppanel_open(struct inode *inode, struct file *filp)
> +{
> +	if (!mutex_trylock(&oppanel_mutex)) {
> +		pr_debug("Device Busy\n");
> +		return -EBUSY;
> +	}
> +	return 0;
> +}
> +
> +static int oppanel_release(struct inode *inode, struct file *filp)
> +{
> +	mutex_unlock(&oppanel_mutex);
> +	return 0;
> +}
> +
> +static const struct file_operations oppanel_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= oppanel_llseek,
> +	.read		= oppanel_read,
> +	.write		= oppanel_write,
> +	.open		= oppanel_open,
> +	.release	= oppanel_release
> +};
> +
> +static struct miscdevice oppanel_dev = {
> +	.minor		= MISC_DYNAMIC_MINOR,
> +	.name		= "oppanel",
> +	.fops		= &oppanel_fops
> +};
> +
> +static int oppanel_probe(struct platform_device *pdev)
> +{
> +	int rc, i;
> +	struct device_node *dev_node = pdev->dev.of_node;

dev_node should be called np.

> +	const u32 *length_val, *lines_val;

My preference is reverse Christmas tree style:

	const u32 *length_val, *lines_val;
	struct device_node *np;
	int rc, i;

	np = pdev->dev.of_node;

> +
> +	if (strncmp(dev_node->name, "oppanel", 7)) {

You are using a compatible check (via the match table) so you don't need that
check. Only checking the start of the name (7) would also be wrong.

> +		pr_err("Operator panel not found\n");
> +		return -1;
> +	}
> +
> +	length_val = of_get_property(dev_node, "#length", NULL);
> +	if (!length_val) {
> +		pr_err("Operator panel length property not found\n");
> +		return -1;
> +	}
> +	line_length = be32_to_cpu(*length_val);

Please use of_property_read_u32(), you shouldn't need any endian conversions in
this code.

> +	lines_val = of_get_property(dev_node, "#lines", NULL);
> +	if (!lines_val) {
> +		pr_err("Operator panel lines property not found\n");
> +		return -1;
> +	}
> +	num_lines = be32_to_cpu(*lines_val);

Ditto.

> +	pr_debug("Operator panel found with %u lines of length %u\n",
> +			num_lines, line_length);

pr_devel() would probably be even better (compiled out entirely).

> +	oppanel_data = kcalloc((num_lines * line_length), sizeof(char),
> +		GFP_KERNEL);
> +	if (!oppanel_data)
> +		return -ENOMEM;
> +
> +	oppanel_lines = kcalloc(num_lines, sizeof(oppanel_line_t), GFP_KERNEL);
> +	if (!oppanel_lines) {
> +		kfree(oppanel_data);
> +		return -ENOMEM;

That should be:
		rc = -ENOMEM;
		goto free_oppanel;

> +	}
> +
> +	memset(oppanel_data, ' ', (num_lines * line_length));
> +	for (i = 0; i < num_lines; i++) {
> +		oppanel_lines[i].line_len = cpu_to_be64((u64) line_length);
> +		oppanel_lines[i].line = cpu_to_be64((u64) &oppanel_data[i *
> +						line_length]);

We should be giving OPAL the real address of &oppanel_data[i * line_length],
which means you need to wrap it in __pa(). Unless that's happening somewhere
else I missed?

> +	}
> +
> +	mutex_init(&oppanel_mutex);

AFAIK you don't need to do that because you used DEFINE_MUTEX() above?

> +	rc = misc_register(&oppanel_dev);
> +	if (rc) {
> +		pr_err("Failed to register as misc device\n");
> +		goto remove_mutex;
> +	}
> +
> +	pr_info("Device Successfully Initialised\n");

We don't need a pr_info() on success.

> +	return 0;
> +
> +remove_mutex:
> +	mutex_destroy(&oppanel_mutex);
> +	kfree(oppanel_lines);
> +	kfree(oppanel_data);
> +	return rc;
> +}
> +
> +static int oppanel_remove(struct platform_device *pdev)
> +{
> +	misc_deregister(&oppanel_dev);
> +	mutex_destroy(&oppanel_mutex);
> +	kfree(oppanel_lines);
> +	kfree(oppanel_data);
> +	pr_info("Device Successfully Removed\n");

Don't need the pr_info().

cheers
