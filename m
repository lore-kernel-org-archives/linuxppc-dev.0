Message-ID: <397C8B10.14D160E2@adc.com>
Date: Mon, 24 Jul 2000 13:29:36 -0500
From: Darin Smith <darin_smith@adc.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI memory-mapping question
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howdy all,

I hope someone here can show me the magic spell I need...

I have a device (Brooktree Bt8230 SAR) that I am trying to port a driver
from 2.0 to 2.2 for.

Under 2.0, cat /proc/pci reports:
  Bus  0, device  19, function  0:
    ATM network controller: Brooktree Bt8230 ATM SAR (rev 3).
      Fast devsel.  Fast back-to-back capable.  IRQ 10.
      Non-prefetchable 32 bit memory at 0x3b000000.

and the memory-mapping in the driver's pci_probe looks like:
/* Get the board I/O address */
pcibios_read_config_dword(pb,
                          PCI_DEVICE,
                          PCI_BASE_ADDRESS_0,
                          &iobase);

/* Map iobase to LINUX virtual address. */
iobase |= 0xC0000000;

(void *)iobase = vremap((unsigned long)0xfb000000,
                                 (unsigned long)256*1024);


.....
why the author hardwired fb000000 instead of passing iobase in vremap, I
don't know.  Apparently, the remapping is done to prevent caching.  The
BAT's are setup thusly:
/* Hardwired MMU segments */

/* Segment 0x8XXXXXXX, 0xCXXXXXXX always mapped (for I/O) */
/* Segment 0x9XXXXXXX mapped during init */

BAT BAT0 =
   {
   	{
   		0x80000000>>17, 	/* bepi */
   		BL_256M,		/* bl */
   		1,			/* vs */
   		0,			/* vp */
   	},
   	{
   		0x80000000>>17,		/* brpn */
   		1,			/* w */
   		1,			/* i (cache disabled) */
   		0,			/* m */
   		1,			/* g */
   		BPP_RW			/* pp */
   	}
   };
BAT BAT1 =
   {
   	{
   		0xC0000000>>17, 	/* bepi */
   		BL_256M,		/* bl */
   		1,			/* vs */
   		0,			/* vp */
   	},
   	{
   		0xC0000000>>17,		/* brpn */
   		1,			/* w */
   		1,			/* i (cache disabled) */
   		0,			/* m */
   		1,			/* g */
   		BPP_RW			/* pp */
   	}
   };
BAT BAT2 =
   {
   	{
   		0x00000000>>17, 	/* bepi */
   		BL_256M,		/* bl */
   		0,			/* vs */
   		0,			/* vp */
   	},
   	{
   		0x00000000>>17,		/* brpn */
   		1,			/* w */
   		1,			/* i (cache disabled) */
   		0,			/* m */
   		0,			/* g */
   		BPP_RW			/* pp */
   	}
   };
BAT BAT3 =
   {
   	{
   		0x00000000>>17, 	/* bepi */
   		BL_256M,		/* bl */
   		0,			/* vs */
   		0,			/* vp */
   	},
   	{
   		0x00000000>>17,		/* brpn */
   		1,			/* w */
   		1,			/* i (cache disabled) */
   		0,			/* m */
   		0,			/* g */
   		BPP_RW			/* pp */
   	}
   };
#ifdef OUR_CUSTOM_HARDWARE
BAT CUSTOM_BAT3 =
   {
   	{
   		0xF0000000>>17, 	/* bepi */
   		BL_256M,		/* bl */
   		1,			/* vs */
   		0,			/* vp */
   	},
   	{
   		0xF0000000>>17,		/* brpn */
   		1,			/* w */
   		1,			/* i (cache disabled) */
   		1,			/* m */
   		0,			/* g */
   		BPP_RW			/* pp */
   	}
   };
#endif
BAT TMP_BAT2 =
   { /* 0x9XXXXXXX -> 0x0XXXXXXX */
   	{
   		0x90000000>>17, 	/* bepi */
   		BL_256M,		/* bl */
   		1,			/* vs */
   		1,			/* vp */
   	},
   	{
   		0x00000000>>17,		/* brpn */
   		0,			/* w */
   		0,			/* i (cache enabled) */
   		0,			/* m */
   		0,			/* g */
   		BPP_RW			/* pp */
   	}
   };

So there is a straight mapping, so far as I can tell.

Now, with 2.2, this is what I have setup:

BATs:
	switch (_machine) {
	case _MACH_prep:
#ifndef OUR_CUSTOM_HARDWARE
		setbat(0, 0x80000000, 0x80000000, 0x10000000, IO_PAGE);
		setbat(1, 0xf0000000, 0xc0000000, 0x08000000, IO_PAGE);
#else
	        setbat(0, 0x80000000, 0x80000000, 0x10000000, IO_PAGE);
	        setbat(1, 0xf0000000, 0xc0000000, 0x08000000, IO_PAGE);
	        setbat(3, 0xF8000000, 0xF8000000, 0x08000000, CUSTOM_RAM_PAGE);
#endif
	        ioremap_base = 0xf8000000;
	        break;

...where CUSTOM_RAM_PAGE is
#define CUSTOM_RAM_PAGE (_PAGE_NO_CACHE | _PAGE_RW | _PAGE_COHERENT)

I didn't want to go messing with the mappings that were already there,
so instead of mapping all 0xF0000000-0xFFFFFFFF straight, I wanted to
map the upper 128M (since 0xc0000000-0xc7FFFFFF is apparently already
mapped to the lower 128M of 0xFxxxxxxx).  Therefore, I tried mapping to
0xf8000000...didn't work...kernel panics with:
Jul 24 17:41:00 lyn120 kernel: SAR:: init_module.
Jul 24 17:41:00 lyn120 kernel: bt8230_insert_device
Jul 24 17:41:00 lyn120 kernel: Initializing SAR driver!
Jul 24 17:41:00 lyn120 kernel: Looking for SAR devices...
Jul 24 17:41:00 lyn120 kernel: SAR device found: sar0
Jul 24 17:41:00 lyn120 kernel: bt8230_probe
Jul 24 17:41:00 lyn120 kernel: bt8230_pci_probe
Jul 24 17:41:00 lyn120 kernel: iobase = 0x1000000
Jul 24 17:41:00 lyn120 kernel: iobase now = 0xf8000000
Jul 24 17:41:00 lyn120 kernel: remapped iobase = 0xf8000000
Jul 24 17:41:00 lyn120 kernel: irq = 10
Jul 24 17:41:00 lyn120 kernel: set Bus Mastering ON.
Jul 24 17:41:01 lyn120 kernel: check_region passed
Jul 24 17:41:01 lyn120 kernel: NIP: CC0148E8 XER: 20000000 LR: CC0148E8
REGS: c4
bb5c80 TRAP: 0300
Jul 24 17:41:01 lyn120 kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
Jul 24 17:41:01 lyn120 kernel: TASK = c4bb4000[477] 'insmod' mm->pgd
c45a8000 La
st syscall: 128
Jul 24 17:41:01 lyn120 kernel: last math c4bb4000
Jul 24 17:41:01 lyn120 kernel: GPR00: CC0148E8 C4BB5D30 C4BB4000
00000014 000000
01 00000014 C0120000 C011D010
Jul 24 17:41:01 lyn120 kernel: GPR08: 000F3E8C 00000000 000003F8
C4BB5C80 000000
0D 1001F2F0 00000000 100A4D90
Jul 24 17:41:01 lyn120 kernel: GPR16: 10010000 7FFFDCA8 00000000
C037D5C0 000090
32 00000000 CC3F598C 00000000
Jul 24 17:41:01 lyn120 kernel: GPR24: 00000000 00000000 CC3F0000
CC3F0000 000000
13 0000000A 00000000 F8000000
Jul 24 17:41:01 lyn120 kernel: Call backtrace:
Jul 24 17:41:01 lyn120 kernel: CC0148E8 CC0149F0 C0068390 C00B6100
CC0133F0 C001
B078 C0003900
Jul 24 17:41:01 lyn120 kernel: 10010000 100033F0 10003AB4 0FF0B69C
00000000
Jul 24 17:41:01 lyn120 kernel: Kernel panic: kernel access of bad area
pc cc0148
e8 lr cc0148e8 address 904A tsk insmod/477
Jul 24 17:46:22 lyn120 syslogd 1.3-3: restart.

So I tried 0xf9000000...same sort of thing happens.

If I try to initialize the driver without mapping, it will complain that
the device is in use.

I'm a memory-management virgin, can someone point me in the right
direction here?  It seems to me that this should be very simple and
straightforward, but I must be missing something.

relevant code from the 2.2 version of the driver:

    /* Get the board I/O address */
    iobase = (pdev->base_address[0] & PCI_BASE_ADDRESS_MEM_MASK);
    printk("iobase = 0x%x\n", iobase);

    /* Map iobase to LINUX virtual address. */
    iobase = 0xF8000000;
    printk("iobase now = 0x%x\n", iobase);

    (void *)iobase = ioremap((unsigned long)iobase, (unsigned
long)(256*1024));

    printk("remapped iobase = 0x%x\n", iobase);


--
Regards,

Darin W. Smith

`When you say "I wrote a program that crashed Windows", people just
stare at
you blankly and say "Hey, I got those with the system, *for free*".'
 --Linus Torvalds

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
