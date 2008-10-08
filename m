Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc2-s14.bay0.hotmail.com (bay0-omc2-s14.bay0.hotmail.com
	[65.54.246.150]) by ozlabs.org (Postfix) with ESMTP id 7CD92DDFCC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 09:51:42 +1100 (EST)
Message-ID: <BLU119-DAV1197362B77CCC3F1296F60BB3B0@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.2847.1223488861.3127.linuxppc-embedded@ozlabs.org>
Subject: Failure in re-load module
Date: Wed, 8 Oct 2008 15:51:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Cc: v.selvamuthukumar@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm able to load driver and access HW without any problem
In removing the driver using command "rmmod", I have error relating to 
virtual address from ioremap() for physical adress IMMR_BASE = 0xE0000000

Trying to free nonexistent resource <00000000c98a0000-00000000c98affff>

But the driver appears removed when I check with command "lsmod"
However, I'm NOT able to load the driver again due to error

PPC: can't get I/O port address 0xe0000000
insmod: cannot insert `ppc_drv.ko': No such device (-1): No such device

It appaers to me that the memory region was not lreleased successfully

My questions are
1) What is the right sequence in requesting and releasing memory region ?
2) Are the function request_region() and release_region() obsolete in kernel 
2.6 as I have no such problem with kernel 2.4 ?

I have a driver with basic code segment below
///////////////////////////// Start of code
//////////////////////////////////// Init
init:
 if (! request_region(PPC_BASE, PPC_SIZE, DEVICE_NAME)) {
  printk(KERN_INFO "PPC: can't get I/O port address 0x%lx\n", ppc_base);
  return -ENODEV;
 }

 ppc_base = (unsigned long) ioremap(PPC_BASE, PPC_SIZE);

 result = register_chrdev(major, DEVICE_NAME, &ppc_fops);

//////////////////////////// exit
exit:
 unregister_chrdev(major, DEVICE_NAME);

 iounmap((void __iomem *)ppc_base);
 iounmap((void __iomem *)lbc_base);

 release_region(ppc_base,PPC_SIZE);
 release_region(lbc_base,PPC_SIZE);
////////////////////////////// End of code

Thanks so much for your time and help.

Best Regards,

Duy-Ky 
