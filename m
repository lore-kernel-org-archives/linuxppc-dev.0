Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5DEA92C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 01:16:23 +1000 (EST)
Received: from [134.158.40.174] (lpsc0174x.in2p3.fr [134.158.40.174])
 by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id q7UEEjOe004212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2012 16:14:45 +0200
Message-ID: <503F7555.5060404@lpsc.in2p3.fr>
Date: Thu, 30 Aug 2012 16:14:45 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Moving target
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I had a homebrew driver that compiled and ran well on 2.6.38 and I 
recently upgraded to the latest xilinx kernel and had some trouble 
recompiling without adjustments (of_driver/driver, 
of_platform_driver/platform_driver and some such).

But now, after those adjustments, it crashes on run.

My first generic question is: is there a clean canonical example of how 
to write each part (module init/exit, /dev handling, probing, physical 
memory access, interrupt handling, etc) of a basic driver ? Because each 
upgrade breaks my code and as driver writing is only one of my duties, I 
have a hard time keeping up with the moving target of the 
requirements... To say that books are obsolete is an understatement.

And now to the specifics:

[   16.655868] {xad_init 519} Module xad: loading...
[   16.661122] {xad_init 528} Module xad: Major=241, Minor=0, Count=1
[   16.666231] Unable to handle kernel paging request for data at 
address 0x00000030
[   16.673599] Faulting instruction address: 0xc0116fc0
[   16.678495] Oops: Kernel access of bad area, sig: 11 [#1]
[   16.683745] Xilinx Virtex
[   16.686337] Modules linked in: xad(+)
[   16.689978] NIP: c0116fc0 LR: c939a0f8 CTR: c0116fa8
[   16.694912] REGS: c789fd90 TRAP: 0300   Not tainted  (3.0.0-14.1-build3+)
[   16.701629] MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 42000022  XER: 20000000
[   16.708199] DEAR: 00000030, ESR: 00000000
[   16.712185] TASK = c7851420[281] 'insmod' THREAD: c789e000
[   16.717441] GPR00: c939a0f8 c789fe40 c7851420 c9397b70 000046d7 
ffffffff c0110314 00000000
[   16.725736] GPR08: c0337380 00000000 00004000 c0116fa8 22000024 
100b99d4 ffffffff ffffffff
[   16.734030] GPR16: ffffffff ffffffff 100b5aed bfa54388 100844d8 
100844b8 000007a0 00000000
[   16.742324] GPR24: c0047edc 00000124 0000001c c9390000 c93973da 
c9397b08 c93971e8 c9397b70
[   16.750870] NIP [c0116fc0] driver_register+0x18/0x144
[   16.755901] LR [c939a0f8] xad_init+0xf8/0x1e8 [xad]
[   16.760638] Call Trace:
[   16.763119] [c789fe40] [c93973da] xad_device_id+0x1da/0xfffffef8 
[xad] (unreliable)
[   16.770719] [c789fe60] [c939a0f8] xad_init+0xf8/0x1e8 [xad]
[   16.776230] [c789fe80] [c0002508] do_one_initcall+0xe0/0x1c0
[   16.781871] [c789feb0] [c004a08c] sys_init_module+0x15cc/0x17c0
[   16.787720] [c789ff40] [c000c95c] ret_from_syscall+0x0/0x3c
[   16.793212] Instruction dump:
[   16.796155] 80630034 4bfcd669 80010014 38210010 7c0803a6 4e800020 
9421ffe0 7c0802a6
[   16.803842] bf410008 90010024 7c7f1b78 81230004
[   16.808257]  7c000034 5400d97e 0f000000
[   16.813362] ---[ end trace e40dbcf43f9d5d57 ]---

I don't understand the part about address 0x00000030. Does it mean I'm 
trying to wrongly access physical/virtual address 0x30 somewhere in my code?

Here are the very basics from my code (I've removed all printk, error 
checking and what the driver itself does for clarity). I really need a 
hand with the changes of of_something:

static dev_t first;
static unsigned int count = 1;
static int my_major = 241, my_minor = 0;

struct cdev *my_cdev=NULL;

typedef struct XadDevice {
//	struct platform_device *of_dev;
	struct device *dev;
	int irq;
	resource_size_t hw_phy_base, hw_length;	// Address of the IP resource
	void *hw_virt;							// Virtual of above
#ifdef DEBUG
	void *buffer_virt;						// Virtual address of the above
#endif
	struct resource *hw_region;				// Nothing is done with this
	...
} tXadDevice;
tXadDevice Xad;


static irqreturn_t XadIsr(int irq, void *dev_id) { ... }

static int xad_driver_probe(struct device * dev)
	struct resource res;
	struct device_node *dn = dev->of_node;
	int rc=0;

	printk(KERN_INFO SD "Probing %s\n" FL, dn->full_name);

	rc = of_address_to_resource(dn, 0, &res);

	Xad.irq = irq_of_parse_and_map(dn, 0);
	rc=request_irq(Xad.irq, XadIsr, IRQF_TRIGGER_RISING  /* | 
IRQF_DISABLED*/ | IRQF_SHARED | IRQF_SAMPLE_RANDOM, "XadIsr", &Xad);

	init_waitqueue_head(&Xad.wait);

	Xad.hw_region = request_mem_region((unsigned int)Xad.hw_phy_base, 
(unsigned int)(Xad.hw_length),  "xps-acqui-data");

	Xad.hw_virt= ioremap( (unsigned int)Xad.hw_phy_base, (unsigned 
int)(Xad.hw_length) );

	dev_set_drvdata(Xad.dev, &Xad);
	return 0;
}


///////////////////////////////////////////////////////////////////////////////
// There should be something in:
// ll /sys/devices/plb.0/c9800000.xps-acqui-data
static const struct of_device_id xad_device_id[] = {
	{ .compatible     = "xlnx,xps-acqui-data-4.00.a" },	// Must match the DTS
	{}
};

MODULE_DEVICE_TABLE(of, xad_device_id);	// Is this necessary ?

static struct device_driver xad_driver = {
	.probe  = xad_driver_probe,
	.remove = xad_driver_remove,
	.name = "xad-driver",
	.of_match_table = xad_device_id,
};

...

static struct file_operations fops = {
	.owner   = THIS_MODULE,
	.read    = xad_read,
	.open    = xad_open,
	.release = xad_close,
	.unlocked_ioctl   = xad_ioctl,
};

static int __init xad_init(void) {
	first = MKDEV (my_major, my_minor);
	register_chrdev_region(first, count, DEVNAME);
	my_cdev = cdev_alloc ();
	
	cdev_init(my_cdev, &fops);
	rc=cdev_add (my_cdev, first, count);
	
	rc = driver_register(&xad_driver);

	printk(KERN_INFO SD "Driver ready!\n" FL);
	return 0;
}

module_init(xad_init);


Thanks for reading so far !!!
-- 
Guillaume Dargaud
http://www.gdargaud.net/
