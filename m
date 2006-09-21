Return-Path: <skaiser.uci@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 3D4A067BE1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 10:09:59 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so208778nzh
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 17:09:58 -0700 (PDT)
From: "Steven Kaiser" <skaiser.uci@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200b kernel module memory mapping
Date: Wed, 20 Sep 2006 17:09:49 -0700
Message-ID: <000001c6dd12$417d7a50$6e4ec880@volt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


In a kernel module, I am trying to iomemory map or ioport map a range of
addresses so later I can talk directly to custom external hardware.  I have
tried to follow the advice of Rubini chapter 8.  I think I am setting it up
correctly, but at the precise moment I try to write anything within my
range, the kernel crashes badly.  My board is a Lite5200b, using a 2.4.25
kernel.

#define MALab_DEVICE_NAME	"MALab"
#define MALab_MM_START		0x60000000U
#define MALab_MM_END		0x6000ffffU
#define MALab_MM_SIZE		0x00010000U

#define MPC5xxx_MM_CS2_START	(MPC5xxx_MBAR + 0x0014)
#define MPC5xxx_MM_CS2_STOP	(MPC5xxx_MBAR + 0x0018)
#define MPC5xxx_MM_IPBI		(MPC5xxx_MBAR + 0x0054)

void *ioaddr = NULL;

// start 'em up
int init_module(void) {

	register_chrdev(...

	// reserve a page of memory for our hardware /proc/iomem
	if ( check_region(MALab_MM_START,MALab_MM_SIZE) ) {
		printk (KERN_ALERT "LED init_module: memory already in
use\n");
		return -EBUSY;
	}
	request_region(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);

	// enable LocalBus Chip Select CS2 to hit on our address range
	*(volatile u32 *)MPC5xxx_MM_IPBI &= ~0x00040000;
	*(volatile u16 *)(MPC5xxx_MM_CS2_START + 2) = MALab_MM_START >> 16;
	*(volatile u16 *)(MPC5xxx_MM_CS2_STOP + 2) = MALab_MM_END >> 16;
	*(volatile u32 *)MPC5xxx_MM_IPBI |= 0x00040000;

	// map our physical address into kernal virtual address space
	// do I need this call?
	ioaddr = ioremap(MALab_MM_START,MALab_MM_SIZE);

return 0;
}

Later (in a ioctrl routine), I will try and write something to the first
location in my address range.  I tried these three ways:

	*(volatile u16 *)MALab_MM_START = 0x5555;
	outw(0x5555,MALab_MM_START);
	outw(0x5555,ioaddr);

Any and all of the these calls crash the kernel so horrendously I have to
reboot.  Sometimes I have to delete and mknod a new /dev entry.

I have tried the io memory map technique instead of the above io port map
technique, using request_mem_region(), with the same crashing results upon
any writew() call or direct variants.  I tried things without the ioremap()
call--  I get a segmentation fault in these cases.

The request_region() or request_mem_region() seems to work ok.  I can cat
/proc/iomem or /proc/ioports and see my range in there.  I am pretty sure I
am setting up the LocalBus chip select registers ok.

Yet obviously I am doing something profoundly stupid.  Is my error obvious?
Can someone enlighten me in my darkness?

Steven Kaiser
Chemistry Electronics Facility
University of California, Irvine
2347 Natural Sciences 2
Irvine, CA  92697-2025
(949)824-7520
