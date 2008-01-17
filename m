Return-Path: <biggerbadderben@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id 2D5E3DDF82
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 02:01:14 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so385606wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 07:01:13 -0800 (PST)
Message-ID: <478F6DB6.8050907@gmail.com>
Date: Thu, 17 Jan 2008 10:01:10 -0500
From: Ben Warren <biggerbadderben@gmail.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Endian problem when accessing internel regs on 8347
References: <OF03A8BF8B.4AC46CCD-ON882573D3.00216F5B-882573D3.00236B8D@selinc.com>
In-Reply-To: <OF03A8BF8B.4AC46CCD-ON882573D3.00216F5B-882573D3.00236B8D@selinc.com>
Content-Type: multipart/mixed; boundary="------------000508060304000004060208"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000508060304000004060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bruce,

Bruce_Leonard@selinc.com wrote:
> Hi,
>
> I've got an MPC8347 running the 2.6.24-rc5 kernel and I'm trying to access 
> the GPIO registers.  I already have a driver that's doing related work 
> (tho across PCI) and I just want to remap the internal CPU address to a 
> kernal address and be able to read/write the register using an IOCTL call 
> from user space.  My problem is, every accessor I try does an endian 
> conversion before giving me my data.  So here's some code snipits of what 
> I'm doing:
>
> request_mem_region(0xe0000c00, 24, "my driver");  // 0xe0000c00 is the 
> memory mapped location of the GPIO regs
> data_ptr2 = ioremap(0xe0000c00, 24);
>
> Then in the IOCTL function I try to read from the register.  First I 
> tried:
>
> ioread32(data_ptr2);
>
> I know that the mapping is working okay because I got the data from the 
> GPIO direction register, but it's been byte swapped.  The contents of the 
> register are 0xFFFFFFE7, but what my user space app gets back is 
> 0xE7FFFFFF.  I've tried all the varients I can find, readl(), inl(), 
> in_be32(), in_le32(), even __raw_readl().  They all give me back byte 
> swapped data.  I'm very confused.  Especially since I've looked at 
> in_be32() and in_le32(), they're both inline assembly, and they use 
> different instructions.  They can't be giving me the same results.  I'm 
> sure I'm not the first person to want to access PowerPC internal registers 
> through a driver.  Can anyone give me a hint what I'm doing wrong?
>
> As an additional question related to PowerPC inline assembly, can anyone 
> tell me what "%U1%X1" means in the following:
>
> __asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" : "=r" (ret) : 
> "m" (*addr));
>
> Thanks.
>
> See 'ya!
>
> Bruce
> _______________________________________________
>   
I've attached a poorly-written-yet-functional GPIO driver that I wrote a 
while ago for the MPC8349 (same as what you have for all intents and 
purposes). It uses in_be32() and out_be32().

Let me know if you have any questions.

regards,
Ben

--------------000508060304000004060208
Content-Type: text/x-csrc;
 name="mpc83xx_gpio.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc83xx_gpio.c"

/******************************************************************************
 * 
 * gpio_driver.c 
 * Copyright Qstreams Networks 2006
 *
 * This file contains a simple Linux device driver for accessing GPIO ports
 * It is originally targeted for the MPC8349 PowerQUICC II Pro processor, 
 * although with simple modifications it should work with lots of CPUs.  Note
 * that all CPU accesses are big-endian.
 *
 * History:
 * 04/11/2006	BAW		Initial Creation
 *
 *****************************************************************************/

#include <linux/init.h>
#include <linux/module.h>
#include <linux/ioport.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include "gpio.h"

struct gpio_dev {
	struct gpio_reg *regs;
	struct cdev cdev;
};

MODULE_AUTHOR("Ben Warren");
MODULE_LICENSE("GPL");

static int gpio_major_num;
static struct gpio_dev *gpio_devices;

static spinlock_t gpioLock[GPIO_NUM_BANKS];
extern phys_addr_t get_immrbase(void);

static u32 readGpioReg(u8 bank, u32 * addr)
{
	u32 value;

	spin_lock(&gpioLock[bank]);
	value = in_be32(addr);
	spin_unlock(&gpioLock[bank]);
	return value;
}

static void writeGpioReg(u8 bank, u32 * addr, u32 val, u32 mask)
{

	spin_lock(&gpioLock[bank]);
	out_be32(addr, (in_be32(addr) & ~mask) | val);
	spin_unlock(&gpioLock[bank]);
}

/***** 
 * 		Kernel-mode GPIO access functions. 
 *		DO NOT CALL FROM USERSPACE
 *****/

int kgpio_set_dir(u8 bank, u8 bit, u8 isOutput)
{
	u32 value = GPIO_BIT(bit);
	if ((bank >= GPIO_NUM_BANKS) || !gpio_devices) {
		return -ENODEV;
	}
	writeGpioReg(bank, &gpio_devices[bank].regs->gpxdir,
		     isOutput ? value : 0, value);
	return 0;
}

EXPORT_SYMBOL(kgpio_set_dir);

int kgpio_get_dir(u8 bank, u8 bit)
{
	u32 value;
	if ((bank >= GPIO_NUM_BANKS) || !gpio_devices) {
		return -ENODEV;
	}
	value = readGpioReg(bank, &gpio_devices[bank].regs->gpxdir);
	return (value & GPIO_BIT(bit) ? 1 : 0);
}

EXPORT_SYMBOL(kgpio_get_dir);

int kgpio_set_data(u8 bank, u8 bit, u8 isHigh)
{
	u32 value = GPIO_BIT(bit);
	if ((bank >= GPIO_NUM_BANKS) || !gpio_devices) {
		return -ENODEV;
	}
	writeGpioReg(bank, &gpio_devices[bank].regs->gpxdat,
		     isHigh ? value : 0, value);
	return 0;
}

EXPORT_SYMBOL(kgpio_set_data);

int kgpio_get_data(u8 bank, u8 bit)
{
	u32 value;
	if ((bank >= GPIO_NUM_BANKS) || !gpio_devices) {
		return -ENODEV;
	}
	value = readGpioReg(bank, &gpio_devices[bank].regs->gpxdat);
	return (value & GPIO_BIT(bit) ? 1 : 0);
}

EXPORT_SYMBOL(kgpio_get_data);

int gpio_open(struct inode *inode, struct file *filp)
{
	struct gpio_dev *dev;

	/* Set things up so other methods can access private data */
	dev = container_of(inode->i_cdev, struct gpio_dev, cdev);
	filp->private_data = dev;
	return 0;
}

int gpio_ioctl(struct inode *inode, struct file *filp,
	       unsigned int cmd, unsigned long arg)
{
	int rc = 0;
	gpioDataAccess gpioData = { 0, 0 };
	struct gpio_dev *dev;
	u8 bank;

	/* Check that the caller really wanted GPIO */
	if (_IOC_TYPE(cmd) != GPIO_IOC_MAGIC)
		return -ENOTTY;
	if (_IOC_NR(cmd) > GPIO_IOC_MAXNR)
		return -ENOTTY;

	/* Check access controls */
	if (_IOC_DIR(cmd) & _IOC_READ)
		rc = !access_ok(VERIFY_WRITE, (void __user *)arg,
				_IOC_SIZE(cmd));
	else if (_IOC_DIR(cmd) & _IOC_WRITE)
		rc = !access_ok(VERIFY_READ, (void __user *)arg,
				_IOC_SIZE(cmd));
	if (rc)
		return -EFAULT;

	bank = (u8) iminor(inode);
	dev = filp->private_data;

	switch (cmd) {
		/* Direction Register access */
	case GPIO_IOC_GET_DIR:
		return readGpioReg(bank, &dev->regs->gpxdir);
	case GPIO_IOC_SET_DIR:
		if (copy_from_user(&gpioData,
				   (const void __user *)arg,
				   sizeof(gpioDataAccess))) {
			printk(KERN_ERR "copy_from_user failed\n");
			return -EFAULT;
		}
		writeGpioReg(bank, &dev->regs->gpxdir,
			     gpioData.value, gpioData.mask);
		break;
		/* Data Register access */
	case GPIO_IOC_GET_DATA:
		return readGpioReg(bank, &dev->regs->gpxdat);
	case GPIO_IOC_SET_DATA:
		if (copy_from_user(&gpioData,
				   (const void __user *)arg,
				   sizeof(gpioDataAccess))) {
			printk(KERN_ERR "copy_from_user failed\n");
			return -EFAULT;
		}
		writeGpioReg(bank, &dev->regs->gpxdat,
			     gpioData.value, gpioData.mask);
		break;
	default:
		return -ENOTTY;
	}
	return rc;
}

/* File operations structure.  Pretty limited on this device */
struct file_operations gpio_fops = {
	.owner = THIS_MODULE,
	.open = gpio_open,
	.ioctl = gpio_ioctl,
};

static void gpio_cleanup(void)
{
	int i;
	u32 addr;
	dev_t devno = MKDEV(gpio_major_num, 0);
	if (gpio_devices) {
		for (i = 0; i < GPIO_NUM_BANKS; i++) {
			cdev_del(&gpio_devices[i].cdev);
		}
		iounmap(gpio_devices);
	}
	addr = get_immrbase() + GPIO1_IO_OFFSET;
	release_mem_region(addr, sizeof(struct gpio_reg));
	addr = get_immrbase() + GPIO2_IO_OFFSET;
	release_mem_region(addr, sizeof(struct gpio_reg));
	unregister_chrdev_region(devno, GPIO_NUM_BANKS);
}

static void gpio_setup_cdev(struct gpio_dev *dev, int index)
{
	int rc, devno = MKDEV(gpio_major_num, index);

	cdev_init(&dev->cdev, &gpio_fops);
	dev->cdev.owner = THIS_MODULE;
	dev->cdev.ops = &gpio_fops;
	if ((rc = cdev_add(&dev->cdev, devno, 1)))
		printk(KERN_CRIT "Error %d adding gpio%d", rc, index);
}

static int gpio_init(void)
{
	int i, rc;
	dev_t dev = 0;
	u32 addr;

	/* Grab a dynamic major number and GPIO_NUM_BANKS minors */
	rc = alloc_chrdev_region(&dev, 0, GPIO_NUM_BANKS, "gpio");
	gpio_major_num = MAJOR(dev);
	if (rc < 0) {
		printk(KERN_CRIT "GPIO: couldn't get major number\n");
		return rc;
	}
	if (!(gpio_devices = kmalloc(GPIO_NUM_BANKS * sizeof(struct gpio_dev),
				     GFP_KERNEL))) {
		gpio_cleanup();
		return -ENOMEM;
	}
	for (i = 0; i < GPIO_NUM_BANKS; i++) {
		spin_lock_init(&gpioLock[i]);
		gpio_setup_cdev(&gpio_devices[i], i);
		addr =
		    get_immrbase() + (i ==
				      0 ? GPIO1_IO_OFFSET : GPIO2_IO_OFFSET);
		if (!request_mem_region(addr,
					sizeof(struct gpio_reg), "gpio")) {
			printk(KERN_CRIT "gpio: I/O memory request failed\n");
			return -ENODEV;
		}
		gpio_devices[i].regs = (struct gpio_reg *)ioremap_nocache(addr,
						  sizeof (struct gpio_reg));
		if (!gpio_devices[i].regs) {
			printk(KERN_CRIT "gpio: can't remap I/O memory\n");
			return -ENODEV;
		}

	}
	return 0;
}

module_init(gpio_init);
module_exit(gpio_cleanup);

--------------000508060304000004060208
Content-Type: text/x-chdr;
 name="gpio.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gpio.h"

#ifndef GPIO_INCLUDE_H
#define GPIO_INCLUDE_H

#include <asm/ioctl.h>

#define GPIO1_IO_OFFSET  0x00000c00
#define GPIO2_IO_OFFSET  0x00000d00

typedef struct _gpioDatAccess
{
	unsigned int value;
	unsigned int mask;
} gpioDataAccess;

#define GPIO_IOC_MAGIC 0xaa

#define GPIO_IOC_GET_DIR	_IO(GPIO_IOC_MAGIC, 1)
#define GPIO_IOC_SET_DIR	_IOW(GPIO_IOC_MAGIC, 2, gpioDataAccess)
#define GPIO_IOC_GET_DATA	_IO(GPIO_IOC_MAGIC, 3)
#define GPIO_IOC_SET_DATA	_IOW(GPIO_IOC_MAGIC, 4, gpioDataAccess)

#define GPIO_IOC_MAXNR	5

#define GPIO_NUM_BANKS	2
struct gpio_reg
{
	unsigned int	gpxdir;
	unsigned int	gpxdr;
	unsigned int	gpxdat;
	unsigned int	gpxier;
	unsigned int	gpximr;
	unsigned int	gpxicr;
}; 

/* On our CPU, bit 0 is the MS bit, so go from the left */

#define GPIO_BIT(x) (0x80000000 >> (x))

#endif  /* GPIO_INCLUDE_H */

--------------000508060304000004060208--
