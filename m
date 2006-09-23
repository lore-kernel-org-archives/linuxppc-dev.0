Return-Path: <skaiser.uci@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id 59CA867BCE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 06:55:14 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t14so1298579wxc
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Sep 2006 13:55:13 -0700 (PDT)
From: "Steven Kaiser" <skaiser.uci@gmail.com>
To: =?iso-8859-1?Q?'Markus_Klotzb=FCcher'?= <mk@creamnet.de>
Subject: RE: MPC5200b kernel module memory mapping
Date: Sat, 23 Sep 2006 13:55:08 -0700
Message-ID: <000701c6df52$8ea7c5f0$6e4ec880@volt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <87slilxf92.fsf@creamnet.de>
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

Markus:

> > sure I am setting up the LocalBus chip select registers ok.
> 
> I would guess this is not the case. What kind of device is this?

You are correct.  I was so concerned about the linux driver stuff (
request_region(), ioremap(), etc ), that I was locked into endless studies
on that and see now I clearly overlooked some simple chip setting up.  Doh!
Thanks for reorienting my focus--

My chip is a Freescale MPC5200b:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5200B

So here's what I've doing that seems to work, as verified by an
oscilloscope:

// 64k I/O Port Space: 0x60000000 - 0x60001000 -> 0x60000000 - 0x60001000 
#define MPC5xxx_MM_CS2_START	(MPC5xxx_MBAR + 0x0014)
#define MPC5xxx_MM_CS2_STOP	(MPC5xxx_MBAR + 0x0018)
#define MPC5xxx_MM_IPBI		(MPC5xxx_MBAR + 0x0054)

#define MALab_MM_START		0x60000000U
#define MALab_MM_END		0x6000ffffU
#define MALab_MM_SIZE		0x00010000U

void *ioaddr = NULL;

int init_module(void) { ...

	// reserve a page of memory for our hardware /proc/iomem
	if ( check_region(MALab_MM_START,MALab_MM_SIZE) ) {
		printk (KERN_ALERT "LED init_module: memory already in
use\n");
		return -EBUSY;
	}
	request_region(MALab_MM_START,MALab_MM_SIZE,LED_DEVICE_NAME);

	// enable LocalBus chip select CS2 to hit on our address range
	*(volatile u32 *)MPC5xxx_MM_IPBI &= ~0x00040000;
	*(volatile u16 *)(MPC5xxx_MM_CS2_START + 2) = MALab_MM_START >> 16;
	*(volatile u16 *)(MPC5xxx_MM_CS2_STOP + 2) = MALab_MM_END >> 16;
	*(volatile u32 *)MPC5xxx_MM_IPBI |= 0x00040000;

	// LocalBus Chip Select 2 Configuration Register
	*(volatile u32 *)(MPC5xxx_MBAR + 0x0308) = 0x03031110;
	// LocalBus Chip Select Control Register
	*(volatile u32 *)(MPC5xxx_MBAR + 0x0318) |= 0x01000000;

	// map our physical address into kernal virtual address space
	ioaddr = ioremap(MALab_MM_START,MALab_MM_SIZE);
	printk(KERN_ALERT "ioaddr: 0x%08x\n", (u32)ioaddr);


then later, any of these calls work (even in interrupt routines it appears):

u32	buf[10];

	*(volatile u16 *)ioaddr = 0x5555;
	outw(0x5555,ioaddr);
	outsw(ioaddr,buf,10);

I guess this is simple stuff for most everybody here.

Steve
