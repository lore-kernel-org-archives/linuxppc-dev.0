Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDDC8B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Dec 2010 21:18:23 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB8AIEbC014529
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Dec 2010 11:18:14 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Wed, 8 Dec 2010 11:18:13 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012061544.40124.dargaud@lpsc.in2p3.fr>
	<1291770234.2041.102.camel@concordia>
In-Reply-To: <1291770234.2041.102.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012081118.13977.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks again for your detailed answer,
I'm learning, but not as fast as my colleagues with a deadline want me to !

> The platform code does that. That function create devices on the
> platform bus by examining the device tree. It looks for nodes that are
> compatible with the compatible strings you give it, and treats them as
> busses, ie. creates devices for all child nodes of those nodes.

Is there a way to enable some debug output from it, to see what's going on ?

> > ...hmm I had to "git pull" in order for this to compile your snippet.
> > That's really recent! Unfortunately i need to reflash my device with the
> > new kernel before i can begin testing my module.
> 
> It shouldn't be that recent, what kernel version were you using?

I had to go from 2.6.34 to 2.6.35, xilinx git tree.

> Yes sorry, that's a cut & paste bug, between the old and new style code.

No worries, I knew it was some uncompiled example.

> platform_device_register() creates a device on the platform bus. You
> then write a driver for that device, and register it with
> platform_driver_register(), your driver then attaches to the device.
> 
> In this case though you don't need to call platform_device_register()
> because the device has already been created, using the device tree (by
> of_platform_bus_probe()).

OK, I'll have to remove it from my sample code below.

> In general on powerpc we don't use platform_device_register() much,
> instead things are described in the device tree and devices are created
> for them.
> 
> platform_device_register() tends to be for cases where you can't
> discover or probe a device, but you "know" that it exists.

When you see something in /sys/devices/plb.0/, it means that you don't need 
platform_device_register, right ?

> Yes, "make tags", then use vim :)

Great, that works.


OK, here's the relevant part of my code, ripped directly from your sample, 
with a few additions and different variable names. Why do you think 
xad_driver_probe() is not being called ?


#include <linux/kernel.h>
#include <linux/init.h>
#include <asm/device.h>
#include <linux/platform_device.h>
#include <linux/cdev.h>         // char device
#include <linux/fs.h>
#include <linux/of.h>
#include <linux/interrupt.h>

#define DEVNAME "xps-acqui-data"
#define NAME "xad"              // This is only used for printk

#define SD "{%s %d} "
#define FL , __func__, __LINE__

static dev_t first;
static unsigned int count = 1;
static int my_major = 241, my_minor = 0;
// You must run "mknod /dev/xad c 241 0" in a shell at least once

struct cdev *my_cdev=NULL;
struct platform_device *pdev=NULL;

typedef struct XadDevice {
  struct resource *hw_region;
  struct device *dev;
  int irq;
} tXadDevice;
tXadDevice Xad;

// There should be something in:
// ll /sys/devices/plb.0/c9800000.xps-acqui-data
static const struct of_device_id xad_device_id[] = {                       
        { .compatible     = "xlnx,xps-acqui-data-3.00.a" },     // Must match 
the DTS
        {}
};

  
static irqreturn_t XadIsr(int irq, void *dev_id) {
  printk(KERN_INFO SD "IRQ:%d\n" FL, irq);
  return IRQ_HANDLED;
}

///////////////////////////////////////////////////////////////////////////////
// Platform Bus Support
///////////////////////////////////////////////////////////////////////////////

static int  xad_driver_probe(struct platform_device *device /*,
                            const struct of_device_id *device_id*/ ) {
  struct device_node *dn = device->dev.of_node;
  int rc;

  pr_devel("Probing %s\n", dn->full_name);
  
  Xad.irq = irq_of_parse_and_map(dn, 0);
  rc=request_irq(Xad.irq, XadIsr, IRQF_TRIGGER_RISING  | IRQF_DISABLED, 
"XadIsr", &Xad);
  if (rc) printk(KERN_INFO SD "Failled IRQ request: %d\n" FL, rc);
  
  return 0;
}

static int __devexit xad_driver_remove(struct platform_device *device) {
  printk(KERN_INFO SD "Removing...\n" FL);
  return 0;
}

static struct platform_driver xad_driver = {
  .probe  = xad_driver_probe,
  .remove = xad_driver_remove,
  .driver = {
    .owner = THIS_MODULE,
    .name = "xad-driver",
        .of_match_table = xad_device_id,
  },
};


///////////////////////////////////////////////////////////////////////////////
// This section deals with the /dev/xad device
///////////////////////////////////////////////////////////////////////////////
static int xad_open(struct inode *node, struct file *filep) {
  printk (KERN_INFO SD "OPENING device: %s\n" FL, NAME);
  return 0;
}

static int xad_release(struct inode *node, struct file *filep) {
  printk (KERN_INFO SD "RELEASING device: %s\n" FL, NAME);
  return 0;
}

static int  xad_ioctl(struct inode *node, struct file *filep, unsigned int cmd, 
unsigned long arg) {
  printk (KERN_INFO SD "IOCTL on device: %s, cmd:%d, arg:%lu\n" FL, NAME, cmd, 
arg);
  return 0;
}

static struct file_operations fops = {
  .owner   = THIS_MODULE,
  .open    = xad_open,
  .release = xad_release,
  .ioctl   = xad_ioctl,
};


///////////////////////////////////////////////////////////////////////////////
// Called on insmod
static int __init xad_init(void) {
  int rc=0;
  printk(KERN_INFO SD "Module %s: loading...\n" FL, NAME);
  
  // Deal with the device
  first = MKDEV (my_major, my_minor);
  register_chrdev_region(first, count, DEVNAME);
  my_cdev = cdev_alloc ();
  if (NULL==my_cdev) goto Err;
  
  cdev_init(my_cdev, &fops);
  cdev_add (my_cdev, first, count);

  printk(KERN_INFO SD "Module %s: Major=%d, Minor=%d, Count=%d\n" FL, NAME, 
my_major, my_minor, count);

  // Driver
  rc = platform_driver_register(&xad_driver);
//  rc = platform_driver_probe(&xad_driver, xad_driver_probe);
  if (rc) goto err_plat;

  // Device
  pdev=platform_device_register_simple("xps-acqui-data", -1, NULL, 0);
  if (IS_ERR(pdev)) {
          rc = PTR_ERR(pdev);
          platform_driver_unregister(&xad_driver);
          goto err_plat;
  }


  return 0;

err_plat:
  unregister_chrdev_region(first, count);
Err:
  printk(KERN_ERR SD "Module %s: Failed loading rc=%d\n" FL, NAME, rc);
  return rc;
}

///////////////////////////////////////////////////////////////////////////////
// Called on rmmod
static void xad_exit(void) {
  platform_device_unregister(pdev); pdev=NULL;
  platform_driver_unregister(&xad_driver);
  
  cdev_del (my_cdev); my_cdev=NULL;
  unregister_chrdev_region (first, count);
  printk(KERN_INFO SD "Module %s unloaded\n" FL, NAME);
}

module_init(xad_init);
module_exit(xad_exit);

MODULE_AUTHOR("Guillaume Dargaud");
MODULE_LICENSE("GPL");





And here's the result:

# tail -f /var/log/messages &
# insmod xad.ko
Dec  7 14:42:02 gandalf user.info kernel: [15897.152109] {xad_init 162} Module 
xad: loading...
Dec  7 14:42:02 gandalf user.info kernel: [15897.156665] {xad_init 173} Module 
xad: Major=241, Minor=0, Count=1

# ./xad_test	# A simple prog that opens, does an iocl and closes the device
./xad_test Initialisation
./xad_test Ioctl
./xad_test Closing

Dec  7 14:42:16 gandalf user.info kernel: [15911.160343] {xad_open 130} 
OPENING device: xad
Dec  7 14:42:16 gandalf user.info kernel: [15911.164521] {xad_ioctl 142} IOCTL 
on device: xad, cmd:0, arg:0
Dec  7 14:42:16 gandalf user.info kernel: [15911.173035] {xad_release 136} 
RELEASING device: xad

# rmmod xad
Dec  7 14:42:23 gandalf user.info kernel: [15918.753661] {xad_exit 206} Module 
xad unloaded


And in the dts:

/dts-v1/;
/ {
	...
	plb: plb@0 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "xlnx,plb-v46-1.05.a", "xlnx,plb-v46-1.00.a", "simple-
bus";
		ranges ;
		...
		xps_acqui_data_0: xps-acqui-data@c9800000 {
			compatible = "xlnx,xps-acqui-data-3.00.a";
			interrupt-parent = <&xps_intc_0>;
			interrupts = < 0 2 >;
			reg = < 0xc9800000 0x10000 >;
			xlnx,family = "virtex4";
			xlnx,include-dphase-timer = <0x1>;
			xlnx,mplb-awidth = <0x20>;
			xlnx,mplb-clk-period-ps = <0x2710>;
			xlnx,mplb-dwidth = <0x40>;
			xlnx,mplb-native-dwidth = <0x40>;
			xlnx,mplb-p2p = <0x0>;
			xlnx,mplb-smallest-slave = <0x20>;
		} ;
		...
	} ;
	...
}  ;


# ll /sys/devices/plb.0/c9800000.xps-acqui-data/
-r--r--r--    1 root     root        4.0K Dec  7 12:55 devspec
-r--r--r--    1 root     root        4.0K Dec  7 12:55 modalias
-r--r--r--    1 root     root        4.0K Dec  7 12:55 name
lrwxrwxrwx    1 root     root           0 Dec  7 12:55 subsystem -> 
../../../bus/of_platform/
-rw-r--r--    1 root     root        4.0K Dec  7 12:55 uevent

-- 
Guillaume Dargaud
http://www.gdargaud.net/
