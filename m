Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 4A11DDE72B
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 04:45:54 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1231601482-28123-1-git-send-email-adrian@lisas.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c613a7e0a88e249894bafe6d2183fbf2@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Add support to access the flash on SLOF based
	systems
Date: Sat, 10 Jan 2009 11:52:56 -0600
To: Adrian Reber <adrian@lisas.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun Jan 11 at 02:31:22 EST in 2009, Adrian Reber wrote:
> This adds support for a simple character device to access the
> flash for SLOF based systems like the PowerStation, QS2x and
> PXCAB. In the SLOF git there is a user space program with
> which the content of the flash for SLOF based systems can
> be displayed and modified. This can be used to add a Linux
> image to the flash and then directly boot the kernel from the
> flash.
>
> Signed-off-by: Adrian Reber <adrian at lisas.de>
> ---
>
> This is based on the mmio NVRAM driver. I am not sure how useful this
> is for anybody else but I am posting it anyway, hoping to get some
> feedback. Also hoping it can be included at one point.


Normally such drivers are written and mtd drivers.

If slof were not an of implementation I would just say put the right 
properties on the node in the device tree, but the kernel should adapt 
to real OF.  It should be easy to write a driver to hook up a mtd 
platform device if this is a direct mapped flash.


> +
> +static void __iomem *slof_flash_start;
> +static long slof_flash_len;
> +static DEFINE_SPINLOCK(slof_flash_lock);
> +
> +
> +static ssize_t slof_flash_read(struct file *file, char __user *buf,
> +                              size_t count, loff_t *ppos)
> +{
> +       unsigned long flags;
> +       char *tmp;
> +       int rc;
> +
> +       spin_lock_irqsave(&slof_flash_lock, flags);
> +
> +       memcpy_fromio(tmp, slof_flash_start + *ppos, count);
> +
> +       spin_unlock_irqrestore(&slof_flash_lock, flags);
> +

Why do you need a spinlock?  Why does it need to be irq safe?

This decision is also driving the malloc of the temporary buffer, and
you are intentionally returning a short read to userspace.


> +
> +const struct file_operations slof_flash_fops = {
> +       .owner = THIS_MODULE,
> +       .llseek = slof_flash_llseek,
> +       .read = slof_flash_read,
> +};
> +

You mentioned userspace reflashing the image, but this driver seems to
be read only access.

> +static struct miscdevice slof_flash_dev = {
> +       SLOF_FLASH_MINOR,
> +       "slof_flash",
> +       &slof_flash_fops
> +};
> +
> +
> +static int __init slof_flash_init(void)
> +{
> +       struct device_node *slof_flash;
> +       struct device_node *compatible;
> +       struct resource r;
> +       int rc;
> +       unsigned long slof_flash_addr;
> +       /* SLOF is known to run on systems with following values
> +        * for the compatible property: */
> +       char *compstrs[] = {"IBM,Bimini", "IBM,JS21", "IBM,JS20", 
> "IBM,CBEA" };
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(compstrs); i++) {
> +               compatible = of_find_compatible_node(NULL, NULL, 
> compstrs[i]);
> +
> +               if (compatible)
> +                       break;
> +       }


Can you identify slof from the information in the /openprom node?  I 
don't think all js20 and 21 use slof, although the IBM provided 
firmware may also work with this driver.


> +
> +       /* not a system with a SLOF flash */
> +       if (!compatible)
> +               return -ENODEV;
> +
> +       of_node_put(compatible);
> +
> +       slof_flash = of_find_node_by_type(NULL, "flash");
> +       if (!slof_flash) {
> +               printk(KERN_WARNING "SLOF FLASH: "
> +                      "no flash node found in device-tree\n");
> +               return -ENODEV;
> +       }
> +       rc = of_address_to_resource(slof_flash, 0, &r);
> +       if (rc) {
> +               printk(KERN_WARNING "SLOF FLASH: "
> +                      "failed to get address (err %d)\n", rc);
> +               goto out;
> +       }
> +
> +       slof_flash_addr =  r.start;
> +       slof_flash_len = r.end - r.start + 1;
> +
> +       if ((slof_flash_len <= 0) || (!slof_flash_addr)) {
> +               printk(KERN_WARNING "SLOF FLASH: address or length is 
> 0\n");
> +               rc = -EIO;
> +               goto out;
> +       }

Why are these warnings?   again, debug is more approprate

> +
> +       slof_flash_start = ioremap(slof_flash_addr, slof_flash_len);
> +       if (!slof_flash_start) {
> +               printk(KERN_WARNING "SLOF FLASH: failed to ioremap\n");
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +
> +       printk(KERN_INFO "SLOF FLASH: %luk at 0x%lx mapped to %p\n",
> +              slof_flash_len >> 10, slof_flash_addr, 
> slof_flash_start);

This looks to be a debug message at most.

> +
> +       rc = misc_register(&slof_flash_dev);

And as I said, this should be a mtd driver.

Thanks,
milton
