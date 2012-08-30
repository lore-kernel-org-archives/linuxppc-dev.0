Return-Path: <michael@ellerman.id.au>
Message-ID: <1346369432.18688.10.camel@concordia>
Subject: Re: Moving target
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Date: Fri, 31 Aug 2012 09:30:32 +1000
In-Reply-To: <503F7555.5060404@lpsc.in2p3.fr>
References: <503F7555.5060404@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-30 at 16:14 +0200, Guillaume Dargaud wrote:
> Hello all,

Hi Guillaume,


> I don't understand the part about address 0x00000030. Does it mean I'm 
> trying to wrongly access physical/virtual address 0x30 somewhere in my code?

> [   16.666231] Unable to handle kernel paging request for data at address 0x00000030

So yes some code is trying to access address 0x30, that is typically a
symptom of dereferencing a NULL pointer.

The 0x30 can be a clue in that it is probably accessing an element of a
structure that is 0x30 past the base of the struct.


> [   16.673599] Faulting instruction address: 0xc0116fc0

This can be useful if you have the vmlinux around you can look at the
exact instruction that caused the fault.


> [   16.678495] Oops: Kernel access of bad area, sig: 11 [#1]
> [   16.683745] Xilinx Virtex
> [   16.686337] Modules linked in: xad(+)
> [   16.689978] NIP: c0116fc0 LR: c939a0f8 CTR: c0116fa8
> [   16.694912] REGS: c789fd90 TRAP: 0300   Not tainted  (3.0.0-14.1-build3+)
> [   16.701629] MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 42000022  XER: 20000000
> [   16.708199] DEAR: 00000030, ESR: 00000000
> [   16.712185] TASK = c7851420[281] 'insmod' THREAD: c789e000
> [   16.717441] GPR00: c939a0f8 c789fe40 c7851420 c9397b70 000046d7 ffffffff c0110314 00000000
> [   16.725736] GPR08: c0337380 00000000 00004000 c0116fa8 22000024 100b99d4 ffffffff ffffffff
> [   16.734030] GPR16: ffffffff ffffffff 100b5aed bfa54388 100844d8 100844b8 000007a0 00000000
> [   16.742324] GPR24: c0047edc 00000124 0000001c c9390000 c93973da c9397b08 c93971e8 c9397b70

> [   16.750870] NIP [c0116fc0] driver_register+0x18/0x144

That is the exact instruction that faulted. You can see it's not
actually in your code, it's in driver_register().


> ///////////////////////////////////////////////////////////////////////////////
> // There should be something in:
> // ll /sys/devices/plb.0/c9800000.xps-acqui-data
> static const struct of_device_id xad_device_id[] = {
> 	{ .compatible     = "xlnx,xps-acqui-data-4.00.a" },	// Must match the DTS
> 	{}
> };
> 
> MODULE_DEVICE_TABLE(of, xad_device_id);	// Is this necessary ?
> 
> static struct device_driver xad_driver = {
> 	.probe  = xad_driver_probe,
> 	.remove = xad_driver_remove,
> 	.name = "xad-driver",
> 	.of_match_table = xad_device_id,
> };

> static int __init xad_init(void) {
> 	first = MKDEV (my_major, my_minor);
> 	register_chrdev_region(first, count, DEVNAME);
> 	my_cdev = cdev_alloc ();
> 	
> 	cdev_init(my_cdev, &fops);
> 	rc=cdev_add (my_cdev, first, count);
> 	
> 	rc = driver_register(&xad_driver);
> 
> 	printk(KERN_INFO SD "Driver ready!\n" FL);
> 	return 0;
> }

I don't think you should be using driver_register().

I think instead you want this to be a platform_driver, and use
platform_driver_register() ?

If you grep for platform_driver_register() in arch/powerpc you will see
several examples.

cheers
