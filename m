Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id BCA6DDE046
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 10:29:35 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 6/7] xenon: add SMC support
Date: Wed, 7 Mar 2007 22:54:51 +0100
References: <20070307180144.812594000@elitedvb.net>
	<20070307180144.812594000@elitedvb.net>>
	<20070307180526.334384000@elitedvb.net>>
In-Reply-To: <20070307180526.334384000@elitedvb.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703072254.51225.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 March 2007 19:01:50 Felix Domke wrote:

> It requires a userspace daemon.

Is that available somewhere? You should probably list a URL
for this in the driver and/or changelog

> +config XENON_SMC
> +	bool "Xenon SMC"
> +	depends on PPC_XENON
> +	help
> +	  SMC controller in the Xbox 360.
> +

Please expand the acronym here. It's not a particularly unique
TLA after all.

> +struct xenon_smc
> +{
> +	void __iomem *base;
> +	unsigned long is_active;
> +	wait_queue_head_t wait;
> +};
> +
> +static struct xenon_smc *first_smc;

Why do you think you need the global instance variable?
Normally, this should be pointed to by the pci device
private data.

> +#define to_smc(pdev) dev_get_drvdata(&pdev->dev)
> +
> +static int get_smc(struct xenon_smc *ctx, u8 *msg);
> +static void send_smc(struct xenon_smc *ctx, void *msg);
> +static irqreturn_t xenon_smc_irq(int irq, void *dev_id);
> +static ssize_t smc_write(struct file *file, const char __user *data,
> +				size_t len, loff_t *ppos);
> +static int smc_ioctl(struct inode *inode, struct file *file,
> +				unsigned int cmd, unsigned long arg);
> +static ssize_t smc_read(struct file *file, char __user *data,
> +				size_t len, loff_t *ppos);
> +static int smc_open(struct inode *inode, struct file *file);
> +static int smc_release(struct inode *inode, struct file *file);
> +static int xenon_smc_init_one (struct pci_dev *pdev, const struct
> pci_device_id *ent); +static void __devexit xenon_smc_remove(struct pci_dev
> *pdev);

Don't do forward declarations of static functions, please instead
reorder them so you don't need these.

> +static struct miscdevice smc_miscdev = {
> +	.minor =  RTC_MINOR,
> +	.name =   "smc",
> +	.fops =	  &smc_fops,
> +};

You can't grab the RTC device number if you don't support the
respective interfaces. Use a dynamic minor number instead!

> +static int get_smc(struct xenon_smc *ctx, u8 *msg)
> +{
> +	if (readl(ctx->base + 0x94) & 4)
> +	{
> +		u32 *message = (u32*)msg;
> +		int i;
> +		writel(4, ctx->base + 0x94);
> +		for (i=0; i<4; ++i)
> +			message[i] = __raw_readl(ctx->base + 0x90);
> +		writel(0, ctx->base + 0x94);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static void send_smc(struct xenon_smc *ctx, void *msg)
> +{
> +	while (!(readl(ctx->base + 0x84) & 4));
> +	writel(4, ctx->base + 0x84);
> +	__raw_writel(*(u32*)(msg+0), ctx->base + 0x80);
> +	__raw_writel(*(u32*)(msg+4), ctx->base + 0x80);
> +	__raw_writel(*(u32*)(msg+8), ctx->base + 0x80);
> +	__raw_writel(*(u32*)(msg+12), ctx->base + 0x80);
> +	writel(0, ctx->base + 0x84);
> +}

This needs to be cleaned up:

- don't use __raw_read/write on pci devices
- in the endless loop, use cpu_relax()
- avoid the casts if you can

> +static ssize_t smc_write(struct file *file, const char __user *data,
> +			     size_t len, loff_t *ppos)
> +{
> +	unsigned char msg[16];
> +	if (len != 16)
> +		return -EINVAL;
> +
> +	if (copy_from_user(msg, data, 16))
> +		return -EFAULT;
> +
> +	send_smc(first_smc, msg);
> +
> +	return 16;
> +}

You can get the pointer to the smc from file->f_dentry->d_inode->i_private
if you put it in there 

> +static int smc_ioctl(struct inode *inode, struct file *file,
> +			  unsigned int cmd, unsigned long arg)
> +{
> +	return -ENODEV;
> +}

please kill this function, it's not needed.

> +static ssize_t smc_read(struct file *file, char __user *data,
> +				size_t len, loff_t *ppos)
> +{
> +	struct xenon_smc *ctx = first_smc;
> +	int ret;
> +	u8 msg[0x10];
> +
> +	if (len != 16)
> +		return -EINVAL;
> +
> +	if (!(readl(ctx->base + 0x94) & 4))
> +	{
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret = wait_event_interruptible(ctx->wait, readl(ctx->base + 0x94) & 4);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (get_smc(ctx, msg) == 0)
> +		return -EAGAIN;
> +
> +	if (copy_to_user(data, msg, 0x10))
> +		return -EFAULT;
> +
> +	return 0x10;
> +}
> +
> +static int smc_open(struct inode *inode, struct file *file)
> +{
> +	if (test_and_set_bit(0, &first_smc->is_active))
> +		return -EBUSY;
> +
> +	return nonseekable_open(inode, file);
> +}

This doesn't guarantee that you have only one fd to the device,
you can still get multiple copies through dup or fork.

> +
> +	rc = misc_register(&smc_miscdev);
> +	if (rc != 0)
> +	{

You should be consistant with the indentation, opening braces here
and in other places (except function bodies) go at the end of the
previous line.

It's also more common to write 'if (!rc)' than comparing return values
against 0 or NULL.

	Arnd <><
