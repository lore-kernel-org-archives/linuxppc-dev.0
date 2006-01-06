Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-17.bluehost.com (outbound-mail-17.bluehost.com
	[70.98.111.232]) by ozlabs.org (Postfix) with SMTP id 8D977689D7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 10:03:58 +1100 (EST)
Message-ID: <43BEF714.7010403@secretlab.ca>
Date: Fri, 06 Jan 2006 16:02:44 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Brett McNerney <mcnernbm@notes.udayton.edu>
References: <000c01c6101b$2332efe0$0202a8c0@lilmac>
In-Reply-To: <000c01c6101b$2332efe0$0202a8c0@lilmac>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Custom Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

First off, please CC: the mailing list when you email me so others
having the same problem can see the response.

Brett McNerney wrote:
> Yes I can access the register from a no-os program.  There a Xilinx specific
> functions to read and write to the registers and those work just fine.  I
> can run a full test on the register with no problem.  Its just when I go to
> use linux I can not access the register anymore.
> The driver attempted to use is attached along with the sample test program
> to run under linux.  I added the reg_driver to the Xilinx_gpio makefile.
> Got everything to compile and create the kernel but from there the /dev/reg
> that should be there is not.

Unless you're using devfs (not recommended), /dev/* entries are not
created automatically, you need to create them yourself with mknod.

Are you using a 2.4 or a 2.6 kernel?

It looks like your doing the right thing with ioremap.  However, I would
break things up a bit.  Before wiring it up to a char device, see if you
can twiddle the GPIO registers from within the driver itself; then try
to get a user space app to twiddle them.

Also, for the GPIO core, I'd dump the Xilinx headers and libraries.  The
register access is so simple that you can just read/write them directly.
 The xilinx layer just become another layer of abstraction without a
whole lot of benefit.

Cheers,
g.

> 
> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca] 
> Sent: Monday, January 02, 2006 10:59 PM
> To: Brett McNerney
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Custom Driver
> 
> Brett McNerney wrote:
> 
>>I am need to create a driver to interface to custom hardware on a ml403
>>board.  I am first trying to just create a ipif register bank and access
>>the registers from linux but am not having any luck of yet.  Has anyone
>>successfully done this and if so explain how or supply a driver to do
>>this and how to build it into the kernel?  I am new at this and am
>>having great difficutly right now. 
>>
>>Thanks for any help anyone can supply
> 
> Can you access your device from a debugger, or a no-os program (like a
> bootloader)?  Did you call ioremap() to map the physical register
> address into virtual memory?  Can you give more detail?
> 
> g.
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> /* my driver header file, defines some consts, structs, etc. */
> /* modeled after/simplified from Xilinx's xgpio */
> /* Author:  Joey Rios <rios@soe.ucsc.edu> */
> 
> #ifndef __IMPROVED_DRIVER_H
> #define __IMPROVED_DRIVER_H
> 
> #define REG_IOCTL_BASE 'r'
> 
> #define REG_MINOR 23
> 
> struct reg_ioctl_data
> {
> 	int data;
> };
> 
> #define REG_IN	_IOWR(REG_IOCTL_BASE, 0, struct reg_ioctl_data)
> #define REG_OUT	_IOW (REG_IOCTL_BASE, 1, struct reg_ioctl_data)
> 
> #endif
> 
> 
> 
> ------------------------------------------------------------------------
> 
> /* test_gpio.c
>  * This program will test our driver (based on xgpio)
>  * Author: Joseph Rios <rios@soe.ucsc.edu>
>  * Date:   08/04/05
>  * 
> */
> 
> #include <stdio.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <linux/ioctl.h>
> /* Somehow you need to make sure the program can find this: */
> #include "reg_driver.h"
> 
> 
> int main()
> {
> 	int rtn, i;
> 	int gpio_fd = -1;
> 	struct reg_ioctl_data it;
> 	/* Actual value is not important */
> 	it.data = 812;
> 
> 	/* Opening */
> 	gpio_fd = open("/dev/modular_reg", O_RDWR);
> 	if(gpio_fd == -1){
> 		perror("Couldn't open /dev/reg");
> 		return 1;
> 	}
> 	printf("Got through opening /dev/reg\n");
> 	printf("Will write value of it.data (%i) to reg.\n", it.data);
> 
> 	/* ioctl test */
> 	
> 	
> 	rtn = ioctl(gpio_fd, REG_OUT, &it);
>  	   /* rtn = 0 means success */
> 	if(!rtn) printf("Woo hoo!  ioctl(REG_OUT) worked!\n");
> 	else perror("Dang, ioctl(REG_OUT) didn't work");
> 	
> 	   /* Again, value isn't important, as long as chagned */
> 	it.data = 100;
> 	printf("Now changed it.data to %i.\n", it.data);
> 	printf("Will read reg into it.data to see 'it' change.\n");
> 
> 	printf("it.data = %i before ioctl(REG_IN)\n", it.data);
> 	rtn = ioctl(gpio_fd, REG_IN, &it);
> 
> 	if(!rtn) printf("Woo hoo!  ioctl(REG_IN) worked!\n");
> 	else perror("Dang, ioctl(REG_IN) didn't work");
> 
> 	printf("it.data = %i after ioctl(REG_IN)\n", it.data);
> 	
> 	/* Closing */
> 	if(close(gpio_fd)) perror("Couldn't close /dev/reg");
> 	else printf("Closed /dev/reg\n");
> 
> 	return 0;
> }
> 
> 
> 
> ------------------------------------------------------------------------
> 
> /* This is a driver for our register IP */
> /* Completely modeled after the xilinx_gpio driver.  This
>  * driver currently doesn't work as a loadable module for
>  * unknown reasons.  I think the ioremap does something
>  * goofy to it if called at runtime.
> */
> 
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> 
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/miscdevice.h>
> #include <linux/kernel.h>	/* printk() */
> #include <linux/init.h>		/* module_{init, cleanup}() */
> #include <linux/slab.h>
> #include <asm/system.h>		/* maybe don't need? */
> #include <xparameters_ml300.h>
> #include <asm/io.h>
> #include <asm/uaccess.h>
> #include <asm/irq.h>
> 
> #include <xio.h>
> #include <xbasic_types.h>
> #include "reg_driver.h"
> 
> /* A redefinition to cutdown on some typing later */
> #define REG_BASE XPAR_REGISTER_0_BASEADDR
> #define REG_HIGH XPAR_REGISTER_0_HIGHADDR
> 
> /* Some module documentation */
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Joey Rios <rios@soe.ucsc.edu>");
> MODULE_DESCRIPTION("Driver for a register device");
> MODULE_SUPPORTED_DEVICE("plb_register");
> 
> 
> /* Global variables needed across methods */	
> static u32 reg_remapped_address;
> const static long remap_size = REG_HIGH - REG_BASE + 1;
> 
> /* open/close do nothing special.  inc/dec use count */
> int reg_open (struct inode *inode, struct file *filp)
> {
> 	MOD_INC_USE_COUNT;
> 	return 0;
> }
> 
> int reg_release (struct inode *inode, struct file *filp)
> {
> 	MOD_DEC_USE_COUNT;
> 	return 0;
> }
> 
> /* here is where all the i/o happens.  arg is assumed to be a pointer
> *  to the data.  currently, that data is a struct reg_ioctl_data.  
> *  this is probably too complicated at the moment and will 
> *  eventually be just an int, but not sure.  filp and inode are not
> *  used here.
> */
> static int
> reg_ioctl(struct inode* inode, struct file* filp, unsigned int cmd, 
> 		unsigned long arg)
> {
> 	int temp;
> 	struct reg_ioctl_data reg_data;
> 
> 	if(copy_from_user(&reg_data, (void*) arg, sizeof(reg_data)))
> 		return -EFAULT;
> 
> 	switch(cmd){
> 	case REG_IN:
> 		reg_data.data = XIo_In32(reg_remapped_address);
> 		if(copy_to_user((struct reg_ioctl_data*)arg, &reg_data,
> 			sizeof(reg_data)))
> 			return -EFAULT;
> 		break;
> 	case REG_OUT:
> 		temp = reg_data.data;
> 		XIo_Out32(reg_remapped_address, (u32) temp);
> 		break;
> 	default:
> 		return -ENOIOCTLCMD;
> 	}
> 	return 0;
> }
> 
> /* The operations to be registered with this driver */
> struct file_operations reg_fops = {
> 	ioctl:	reg_ioctl,
> 	open:	reg_open,
> 	release:reg_release,
> 	owner:	THIS_MODULE,
> };
> 
> /* For registering a misc device */
> static struct miscdevice miscdev={
> 	minor:REG_MINOR,
> 	name:"reg",
> 	fops:&reg_fops,
> };
> 
> /* init will remap the physical address and save the result
> *  in reg_remapped_address (global to the driver) then will
> *  register the device as a misc device
> */
> static int reg_init_module(void)
> {
> 	int rtn;
> 
> 	reg_remapped_address = (u32) ioremap(REG_BASE, remap_size);
> 	printk(KERN_INFO "%s at 0x%08X mapped to 0x%08X\n", miscdev.name, 
> 		REG_BASE, reg_remapped_address);
> 
> 	rtn = misc_register(&miscdev);
> 	if(rtn)
> 	{
> 		printk(KERN_ERR "%s: Could not register driver. \n",
> 			miscdev.name);
> 		return rtn;
> 	}
> 	return 0;
> }
> 
> /* cleanup simply unmaps the address and deregisters the driver */
> static void reg_cleanup_module(void)
> {
> 	iounmap(reg_remapped_address);
> 	misc_deregister(&miscdev);
> }
> 	
> EXPORT_NO_SYMBOLS;
> module_init(reg_init_module);
> module_exit(reg_cleanup_module);
> 


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
