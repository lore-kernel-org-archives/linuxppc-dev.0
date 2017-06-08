Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjpbn6mtVzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 12:03:01 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id u26so3332754pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 19:03:01 -0700 (PDT)
Message-ID: <1496887374.11054.1.camel@gmail.com>
Subject: Re: [RFC 2/2] powerpc/powernv : Add support for OPAL-OCC
 command/response interface
From: Cyril Bur <cyrilbur@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org
Date: Thu, 08 Jun 2017 12:02:54 +1000
In-Reply-To: <1496643233-14658-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1496643233-14658-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1496643233-14658-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

On Mon, 2017-06-05 at 11:43 +0530, Shilpasri G Bhat wrote:
> In P9, OCC (On-Chip-Controller) supports shared memory based
> commad-response interface. Within the shared memory there is an OPAL
> command buffer and OCC response buffer that can be used to send
> inband commands to OCC. This patch adds a platform driver to support
> the command/response interface between OCC and the host.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Hi Shilpasri,

Is there somewhere interface (for userspace) is defined? My main
concern is: who is doing the endian swapping - I assume once the data
leaves Linux and goes into skiboot everything will be in big endian.
I've looked through your userspace tool in your skiboot patches and I
don't see anywhere where it deals with endian. Linux does some dealing
here but since userspace passes an arbitrary buffer, Linux can't
convert that.

Also I notice that you'll block and wait for the response from skiboot
in the write() call from userspace. Just as a fairly easy optimisation
I would have though it would make more sense to send the async command
to skiboot in the write() but actually block on
opal_async_wait_response() when userspace does the read() to get the
response data. This provides the advantage that skiboot and the occ
might be able to process the request while userspace gets around the
calling read() as opposed to forcing userspace to wait in the write()
call. Having said that, I don't think this path is particularly
performance critical, so this doesn't seem to be a big problem.

A few more questions below.

Cyril

> ---
>  arch/powerpc/include/asm/opal-api.h            |  40 ++-
>  arch/powerpc/include/asm/opal.h                |   3 +
>  arch/powerpc/platforms/powernv/Makefile        |   2 +-
>  arch/powerpc/platforms/powernv/opal-occ.c      | 349 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>  arch/powerpc/platforms/powernv/opal.c          |   8 +
>  6 files changed, 401 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index cb3e624..d75fbb9 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -42,6 +42,10 @@
>  #define OPAL_I2C_STOP_ERR	-24
>  #define OPAL_XIVE_PROVISIONING	-31
>  #define OPAL_XIVE_FREE_ACTIVE	-32
> +#define OPAL_OCC_INVALID_STATE	-33
> +#define OPAL_OCC_BUSY		-34
> +#define OPAL_OCC_CMD_TIMEOUT	-35
> +#define OPAL_OCC_RSP_MISMATCH	-36
>  
>  /* API Tokens (in r0) */
>  #define OPAL_INVALID_CALL		       -1
> @@ -190,7 +194,8 @@
>  #define OPAL_NPU_INIT_CONTEXT			146
>  #define OPAL_NPU_DESTROY_CONTEXT		147
>  #define OPAL_NPU_MAP_LPAR			148
> -#define OPAL_LAST				148
> +#define OPAL_OCC_COMMAND			149
> +#define OPAL_LAST				149
>  
>  /* Device tree flags */
>  
> @@ -829,6 +834,39 @@ struct opal_prd_msg_header {
>  
>  struct opal_prd_msg;
>  
> +enum occ_cmd {
> +	OCC_CMD_AMESTER_PASS_THRU = 0,
> +	OCC_CMD_CLEAR_SENSOR_DATA,
> +	OCC_CMD_SET_POWER_CAP,
> +	OCC_CMD_SET_POWER_SHIFTING_RATIO,
> +	OCC_CMD_LAST
> +};
> +
> +struct opal_occ_cmd_rsp_msg {
> +	u8 *cdata;
> +	u8 *rdata;
> +	__be16 cdata_size;
> +	__be16 rdata_size;
> +	u8 cmd;
> +	u8 request_id;
> +	u8 status;
> +};
> +
> +struct opal_occ_cmd_data {
> +	u16 size;
> +	u8 cmd;
> +	u8 data[];
> +};
> +
> +struct opal_occ_rsp_data {
> +	u16 size;
> +	u8 status;
> +	u8 data[];
> +};
> +
> +#define MAX_OPAL_CMD_DATA_LENGTH        4090
> +#define MAX_OCC_RSP_DATA_LENGTH         8698
> +
>  #define OCC_RESET                       0
>  #define OCC_LOAD                        1
>  #define OCC_THROTTLE                    2
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 03ed493..e55ed79 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -346,6 +346,9 @@ static inline int opal_get_async_rc(struct opal_msg msg)
>  
>  void opal_wake_poller(void);
>  
> +int64_t opal_occ_command(int chip_id, struct opal_occ_cmd_rsp_msg *msg,
> +			 bool retry);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_OPAL_H */
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..f5f0902 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> -obj-y			+= opal-kmsg.o
> +obj-y			+= opal-kmsg.o opal-occ.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> diff --git a/arch/powerpc/platforms/powernv/opal-occ.c b/arch/powerpc/platforms/powernv/opal-occ.c
> new file mode 100644
> index 0000000..bae63f1
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-occ.c
> @@ -0,0 +1,349 @@
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
> +#include <linux/slab.h>
> +#include <asm/opal.h>
> +
> +struct occ {
> +	struct miscdevice dev;
> +	struct opal_occ_rsp_data *rsp;
> +	/*
> +	 * spinlock_t lock:
> +	 * Used while updating cmd_in_progress and session_in_progress
> +	 */

Why are you using a spinlock over a mutex to achieve this? Also, for
flags, perhaps you should consider using atomics so that you can test
and set...

> +	spinlock_t lock;
> +	int id;
> +	u8 last_token;
> +	bool cmd_in_progress;
> +	bool session_in_progress;
> +} *occs;
> +static int nr_occs;
> +
> +static int __send_occ_command(struct opal_occ_cmd_rsp_msg *msg,
> +			      int chip_id, bool retry)
> +{
> +	struct opal_msg async_msg;
> +	int rc;
> +
> +	if (!retry) {
> +		msg->cdata = (uint8_t *)be64_to_cpu(msg->cdata);
> +		msg->cdata_size = be16_to_cpu(msg->cdata_size);
> +		msg->rdata = (uint8_t *)be64_to_cpu(msg->rdata);

Have you tested this? I'm really not sure this is going do what you
want.

You're going to pass msg to skiboot. Which means everything in the
struct is going to have to be in big endian, did you use the wrong
macro? Shouldn't it be cpu_to_be16(msg->cdata_size);

Also, you're passing pointers to kernel address in both msg->cdata and
msg->rdata. Skiboot needs physical addresses so pa(msg->cdata).
Futhurmore, it needs the values in big endian, so cpu_to_be64(pa(msg-
>cdata));

> +	}
> +
> +	rc = opal_occ_command(chip_id, msg, retry);
> +	if (rc == OPAL_ASYNC_COMPLETION) {
> +		rc = opal_async_wait_response(msg->request_id, &async_msg);
> +		if (rc) {
> +			pr_info("Failed to wait for async response %d\n", rc);
> +			return rc;
> +		}
> +	} else if (rc) {
> +		pr_info("Failed to send opal_occ_command %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = opal_get_async_rc(async_msg);
> +	if (rc) {
> +		pr_info("opal_occ_command failed with %d\n", rc);
> +		return rc;
> +	}
> +
> +	msg->rdata_size = be16_to_cpu(msg->rdata_size);

So here it seems you've got the be16_to_cpu correct.

> +	msg->rdata = (uint8_t *)be64_to_cpu(msg->rdata);

Because you had to pass the physical address to skiboot you'll need to
put a va() around it, so va(be64_to_cpu(msg->rdata);

> +	msg->cdata_size = be16_to_cpu(msg->cdata_size);
> +	msg->cdata = (uint8_t *)be64_to_cpu(msg->cdata);
> +
> +	if (msg->rdata_size > MAX_OCC_RSP_DATA_LENGTH) {
> +		pr_info("Opal sent bigger data, clipping to the max response size\n");
> +		msg->rdata_size = MAX_OCC_RSP_DATA_LENGTH;
> +	}
> +
> +	return rc;
> +}
> +
> +static int send_occ_command(struct opal_occ_cmd_rsp_msg *msg, struct occ *occ)
> +{
> +	int token, rc;
> +
> +	token = opal_async_get_unique_token_interruptible(occ->last_token);
> +	if (token < 0) {
> +		pr_info("Failed to get the request_id/token for command %d (%d)\n",
> +			msg->cmd, token);
> +		return token;
> +	}
> +
> +	msg->request_id = token;
> +	rc = __send_occ_command(msg, occ->id, false);
> +
> +	switch (rc) {
> +	case OPAL_OCC_CMD_TIMEOUT:
> +	case OPAL_OCC_RSP_MISMATCH:
> +		occ->last_token = token;
> +		opal_async_release_token(token);
> +		token = opal_async_get_unique_token_interruptible(token);
> +		if (token < 0) {
> +			pr_info("Failed to get the request_id/token for retry command %d (%d)\n",
> +				msg->cmd, token);
> +
> +			return opal_error_code(rc);
> +		}
> +
> +		msg->request_id = token;
> +		rc = __send_occ_command(msg, occ->id, true);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	occ->last_token = token;
> +	opal_async_release_token(token);
> +	return opal_error_code(rc);
> +}
> +
> +static int opal_occ_cmd_prepare(struct opal_occ_cmd_data *cmd, struct occ *occ)
> +{
> +	struct opal_occ_cmd_rsp_msg msg;
> +	int rc;
> +
> +	msg.cmd = cmd->cmd;
> +	msg.cdata_size = cmd->size;
> +	msg.rdata = occ->rsp->data;
> +	msg.cdata = cmd->data;
> +	rc = send_occ_command(&msg, occ);
> +	if (rc)
> +		return rc;
> +
> +	occ->rsp->size = msg.rdata_size;
> +	occ->rsp->status = msg.status;
> +
> +	return rc;
> +}
> +
> +static bool opal_occ_cmd_in_progress(struct occ *occ)
> +{
> +	unsigned long flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&occ->lock, flags);
> +	ret = occ->cmd_in_progress;
> +	spin_unlock_irqrestore(&occ->lock, flags);
> +
> +	return ret;
> +}
> +
> +static ssize_t opal_occ_write(struct file *file, const char __user *buf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct miscdevice *dev = file->private_data;
> +	struct occ *occ = container_of(dev, struct occ, dev);
> +	struct opal_occ_cmd_data *cmd;
> +	unsigned long flags;
> +	int rc;
> +
> +	if (count < sizeof(*cmd))
> +		return -EINVAL;
> +
> +	if (opal_occ_cmd_in_progress(occ))
> +		return -EBUSY;
> +
> +	spin_lock_irqsave(&occ->lock, flags);
> +	occ->cmd_in_progress = true;
> +	spin_unlock_irqrestore(&occ->lock, flags);
> +

So you have a race here:
 
cpu1                             | cpu2
------------------------------------------------------------
opal_occ_write()                  opal_occ_write()
opal_occ_cmd_in_progress()        opal_occ_cmd_in_progress()
spin_lock_irqsave() -> gets lock  spin_lock_irqsave() -> spins
ret = false                       [spin]
spin_unlock_irqrestore()          spin_lock_irqsave() -> gets lock
spin_lock_irqsave() -> spins      ret = false
[spin]                            spin_unlock_irqrestore()

At this point both cpus have observed occ->cmd_in_progess to be false
and neither go out the return -EBUSY.

You have to hold the lock, check it is false and change it to true in
one lock acquisition or use atomic types with a test and set.


> +	cmd = kmalloc(count, GFP_KERNEL);
> +	if (!cmd) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	rc = copy_from_user(cmd, buf, count);
> +	if (rc) {
> +		pr_err("Failed to copy OCC command request message\n");
> +		rc = -EFAULT;
> +		goto free_cmd;
> +	}
> +
> +	if (cmd->size > MAX_OPAL_CMD_DATA_LENGTH) {
> +		rc = -EINVAL;
> +		goto free_cmd;
> +	}
> +
> +	rc = opal_occ_cmd_prepare(cmd, occ);
> +	if (!rc)
> +		rc = count;
> +
> +free_cmd:
> +	kfree(cmd);
> +out:
> +	spin_lock_irqsave(&occ->lock, flags);
> +	occ->cmd_in_progress = false;
> +	spin_unlock_irqrestore(&occ->lock, flags);

If you use an atomic type it will make this look much nicer.

> +	return rc;
> +}
> +
> +static ssize_t opal_occ_read(struct file *file, char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct miscdevice *dev = file->private_data;
> +	struct occ *occ = container_of(dev, struct occ, dev);
> +	int rc;
> +

What happens if userspace hasn't previously written a command?

> +	rc = copy_to_user((void __user *)buf, occ->rsp,
> +			  sizeof(occ->rsp) + occ->rsp->size);
> +	if (rc) {
> +		pr_err("Failed to copy OCC response data to user\n");
> +		return rc;
> +	}
> +
> +	return occ->rsp->size;
> +}
> +
> +static int opal_occ_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *dev = file->private_data;
> +	struct occ *occ = container_of(dev, struct occ, dev);
> +	unsigned long flags;
> +	int rc = 0;
> +
> +	spin_lock_irqsave(&occ->lock, flags);
> +	if (occ->session_in_progress) {
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	occ->session_in_progress = true;
> +out:
> +	spin_unlock_irqrestore(&occ->lock, flags);
> +	return rc;
> +}
> +
> +static int opal_occ_release(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *dev = file->private_data;
> +	struct occ *occ = container_of(dev, struct occ, dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&occ->lock, flags);
> +	if (occ->session_in_progress)
> +		occ->session_in_progress = false;
> +	spin_unlock_irqrestore(&occ->lock, flags);

While this isn't incorrect - I'm not sure how you could come here and
have occ->session_in_progress be false considering you prevent the open
if there is already a session in progress... Perhaps a WARN_ON so as to
highlight any programmer mistake?

> +
> +	return 0;
> +}
> +
> +static const struct file_operations opal_occ_fops = {
> +	.open		= opal_occ_open,
> +	.read		= opal_occ_read,
> +	.write		= opal_occ_write,
> +	.release	= opal_occ_release,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int opal_occ_probe(struct platform_device *pdev)
> +{
> +	unsigned int chip[256];

Hopefully 256 will never be exceeded...

> +	unsigned int cpu;
> +	unsigned int prev_chip_id = UINT_MAX;
> +	int i, rc;
> +
> +	for_each_possible_cpu(cpu) {
> +		unsigned int id = cpu_to_chip_id(cpu);
> +
> +		if (prev_chip_id != id) {
> +			prev_chip_id = id;
> +			chip[nr_occs++] = id;
		
Perhaps it is worth checking here that nr_occs isn't greater than 256,
even if it is impossible today. A WARN_ON() in the event a system ever
exists might be nice...

> +		}
> +	}
> +
> +	occs = kcalloc(nr_occs, sizeof(*occs), GFP_KERNEL);
> +	if (!occs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_occs; i++) {
> +		char name[10];
> +
> +		occs[i].id = chip[i];
> +		occs[i].dev.minor = MISC_DYNAMIC_MINOR;
> +		snprintf(name, 10, "occ%d", chip[i]);
> +		occs[i].dev.name = name;
> +		occs[i].dev.fops = &opal_occ_fops;
> +		occs[i].session_in_progress = false;
> +		occs[i].cmd_in_progress = false;
> +		occs[i].last_token = -1;
> +		spin_lock_init(&occs[i].lock);
> +		occs[i].rsp = kmalloc(sizeof(occs[i].rsp) +
> +				      MAX_OCC_RSP_DATA_LENGTH,
> +				      GFP_KERNEL);

This is a large malloc() for each chip - I understand it is hard to do
better with the interface you have been provided...

> +		if (!occs[i].rsp) {
> +			rc = -ENOMEM;
> +			goto free_occs;
> +		}
> +
> +		rc = misc_register(&occs[i].dev);
> +		if (rc)
> +			goto free_occ_rsp_data;
> +	}
> +
> +	return 0;
> +
> +free_occ_rsp_data:
> +	kfree(occs[i].rsp);
> +free_occs:
> +	while (--i <= 0) {

I think you want "while (--i >= 0) {"


Regards,

Cyril

> +		kfree(occs[i].rsp);
> +		misc_deregister(&occs[i].dev);
> +	}
> +	kfree(occs);
> +
> +	return rc;
> +}
> +
> +static int opal_occ_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_occs; i++) {
> +		kfree(occs[i].rsp);
> +		misc_deregister(&occs[i].dev);
> +	}
> +
> +	kfree(occs);
> +	return 0;
> +}
> +
> +static const struct of_device_id opal_occ_match[] = {
> +	{ .compatible = "ibm,opal-occ-cmd-rsp-interface" },
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
> index f620572..e6bf18d 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -310,3 +310,4 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
>  OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
>  OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
>  OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
> +OPAL_CALL(opal_occ_command,			OPAL_OCC_COMMAND);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 59684b4..d87c61b 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -815,6 +815,9 @@ static int __init opal_init(void)
>  	opal_pdev_init("ibm,opal-flash");
>  	opal_pdev_init("ibm,opal-prd");
>  
> +	/* Initialize platform device: OCC_OPAL command-response interface */
> +	opal_pdev_init("ibm,opal-occ-cmd-rsp-interface");
> +
>  	/* Initialise platform device: oppanel interface */
>  	opal_pdev_init("ibm,opal-oppanel");
>  
> @@ -859,6 +862,7 @@ void opal_shutdown(void)
>  EXPORT_SYMBOL_GPL(opal_flash_write);
>  EXPORT_SYMBOL_GPL(opal_flash_erase);
>  EXPORT_SYMBOL_GPL(opal_prd_msg);
> +EXPORT_SYMBOL_GPL(opal_occ_command);
>  
>  /* Convert a region of vmalloc memory to an opal sg list */
>  struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
> @@ -937,6 +941,10 @@ int opal_error_code(int rc)
>  	case OPAL_UNSUPPORTED:		return -EIO;
>  	case OPAL_HARDWARE:		return -EIO;
>  	case OPAL_INTERNAL_ERROR:	return -EIO;
> +	case OPAL_OCC_BUSY:		return -EBUSY;
> +	case OPAL_OCC_INVALID_STATE:
> +	case OPAL_OCC_CMD_TIMEOUT:
> +	case OPAL_OCC_RSP_MISMATCH:	return -EIO;
>  	default:
>  		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
>  		return -EIO;
