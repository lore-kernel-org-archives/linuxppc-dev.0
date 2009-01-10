Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E51F7DDF8A
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 06:58:13 +1100 (EST)
Date: Sat, 10 Jan 2009 20:50:40 +0100
From: Adrian Reber <adrian@lisas.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Add support to access the flash on SLOF based
	systems
Message-ID: <20090110195040.GA19945@lisas.de>
References: <1231601482-28123-1-git-send-email-adrian@lisas.de>
	<c613a7e0a88e249894bafe6d2183fbf2@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c613a7e0a88e249894bafe6d2183fbf2@bga.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 10, 2009 at 11:52:56AM -0600, Milton Miller wrote:
> On Sun Jan 11 at 02:31:22 EST in 2009, Adrian Reber wrote:
>> This adds support for a simple character device to access the
>> flash for SLOF based systems like the PowerStation, QS2x and
>> PXCAB. In the SLOF git there is a user space program with
>> which the content of the flash for SLOF based systems can
>> be displayed and modified. This can be used to add a Linux
>> image to the flash and then directly boot the kernel from the
>> flash.
>>
>> Signed-off-by: Adrian Reber <adrian at lisas.de>
>> ---
>>
>> This is based on the mmio NVRAM driver. I am not sure how useful this
>> is for anybody else but I am posting it anyway, hoping to get some
>> feedback. Also hoping it can be included at one point.
>
>
> Normally such drivers are written and mtd drivers.
>
> If slof were not an of implementation I would just say put the right  
> properties on the node in the device tree, but the kernel should adapt  
> to real OF.  It should be easy to write a driver to hook up a mtd  
> platform device if this is a direct mapped flash.

The reason why I did not use mtd is that part of the flash is used by
the firmware image and I do not know if that works with mtd, if only a
part of the flash can be used. SLOF does also a "CRC" check over the
firmware image, so that image must have valid SLOF "CRC". The flash is
a direct mapped flash, but the size of the firmware can vary.

>> +
>> +static void __iomem *slof_flash_start;
>> +static long slof_flash_len;
>> +static DEFINE_SPINLOCK(slof_flash_lock);
>> +
>> +
>> +static ssize_t slof_flash_read(struct file *file, char __user *buf,
>> +                              size_t count, loff_t *ppos)
>> +{
>> +       unsigned long flags;
>> +       char *tmp;
>> +       int rc;
>> +
>> +       spin_lock_irqsave(&slof_flash_lock, flags);
>> +
>> +       memcpy_fromio(tmp, slof_flash_start + *ppos, count);
>> +
>> +       spin_unlock_irqrestore(&slof_flash_lock, flags);
>> +
>
> Why do you need a spinlock?  Why does it need to be irq safe?

I must confess I copied that code from the nvram driver and I do not
know if it is necessary.

> This decision is also driving the malloc of the temporary buffer, and
> you are intentionally returning a short read to userspace.
>
>> +
>> +const struct file_operations slof_flash_fops = {
>> +       .owner = THIS_MODULE,
>> +       .llseek = slof_flash_llseek,
>> +       .read = slof_flash_read,
>> +};
>> +
>
> You mentioned userspace reflashing the image, but this driver seems to
> be read only access.

This driver is read only. I am writing the new flash image using the
RTAS functionality to update the firmware flash. Using this device I can
use a userspace tool to add a file to the flash. The tool puts the
result on the local filesystem. Then using the normal RTAS flash update
it can be rewritten. That way I can add a kernel (with a ramdisk) to the
flash and then let SLOF boot that kernel. This is especially interesting
for the PXCAB Cell based PCI Express card.

>> +static struct miscdevice slof_flash_dev = {
>> +       SLOF_FLASH_MINOR,
>> +       "slof_flash",
>> +       &slof_flash_fops
>> +};
>> +
>> +
>> +static int __init slof_flash_init(void)
>> +{
>> +       struct device_node *slof_flash;
>> +       struct device_node *compatible;
>> +       struct resource r;
>> +       int rc;
>> +       unsigned long slof_flash_addr;
>> +       /* SLOF is known to run on systems with following values
>> +        * for the compatible property: */
>> +       char *compstrs[] = {"IBM,Bimini", "IBM,JS21", "IBM,JS20",  
>> "IBM,CBEA" };
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(compstrs); i++) {
>> +               compatible = of_find_compatible_node(NULL, NULL,  
>> compstrs[i]);
>> +
>> +               if (compatible)
>> +                       break;
>> +       }
>
>
> Can you identify slof from the information in the /openprom node?  I  

Yes I can identify SLOF from the model property in the /openprom node. I
did not do it because there is almost no code accessing the /openprom
node and therefore I did not read it.

> don't think all js20 and 21 use slof, although the IBM provided firmware 
> may also work with this driver.

There are probably only very few js20/js21 which are using SLOF. I do
not think the original IBM product firmware for those blades mentions
anything about js20/js21 in the compatible node. I do not have access to
such a system but the compatible node usually has some product number,
if I remember it correctly.

I am pretty sure that the original js20/js21 firmware does not have the
flash in the device tree, because RTAS is supposed to be the only valid
way to access the flash.

>> +
>> +       /* not a system with a SLOF flash */
>> +       if (!compatible)
>> +               return -ENODEV;
>> +
>> +       of_node_put(compatible);
>> +
>> +       slof_flash = of_find_node_by_type(NULL, "flash");
>> +       if (!slof_flash) {
>> +               printk(KERN_WARNING "SLOF FLASH: "
>> +                      "no flash node found in device-tree\n");
>> +               return -ENODEV;
>> +       }
>> +       rc = of_address_to_resource(slof_flash, 0, &r);
>> +       if (rc) {
>> +               printk(KERN_WARNING "SLOF FLASH: "
>> +                      "failed to get address (err %d)\n", rc);
>> +               goto out;
>> +       }
>> +
>> +       slof_flash_addr =  r.start;
>> +       slof_flash_len = r.end - r.start + 1;
>> +
>> +       if ((slof_flash_len <= 0) || (!slof_flash_addr)) {
>> +               printk(KERN_WARNING "SLOF FLASH: address or length is  
>> 0\n");
>> +               rc = -EIO;
>> +               goto out;
>> +       }
>
> Why are these warnings?   again, debug is more approprate

Copied from the NVRAM driver. Will change it to debug.

>> +
>> +       slof_flash_start = ioremap(slof_flash_addr, slof_flash_len);
>> +       if (!slof_flash_start) {
>> +               printk(KERN_WARNING "SLOF FLASH: failed to ioremap\n");
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       printk(KERN_INFO "SLOF FLASH: %luk at 0x%lx mapped to %p\n",
>> +              slof_flash_len >> 10, slof_flash_addr,  
>> slof_flash_start);
>
> This looks to be a debug message at most.

Also copied from the mmio NVRAM driver. I can also change that.

>> +
>> +       rc = misc_register(&slof_flash_dev);
>
> And as I said, this should be a mtd driver.

Thanks for the review. Should it also be a mtd driver with the firmware
at the beginning of the flash with an unknown size?

I would also prefer to continue to use the RTAS flash update
functionality to write the flash instead of reimplementing it in the
operating system.

My main motivation for this code was to have a way to access the
firmware image. The firmware image is using some kind of simple
filesystem. I want to be able to modify that filesystem and flash it
again. The advantage if I put something in SLOF's filesystem is that I
can access that file (in my case boot it) with existing functionality
provided by SLOF.

		Adrian
