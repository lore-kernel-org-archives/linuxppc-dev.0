From: Paul Miller <pmiller9@users.sourceforge.net>
To: Embedded PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: 405EP peripheral bus
Date: Wed, 19 Nov 2003 14:43:16 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311191443.16246.pmiller9@users.sourceforge.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone messed around with accessing the peripheral bus on a 405EP PPC?  I've already written a driver to allow me to read/write to the EBC (external bus control) registers from userspace, but I can't seem to toggle CS0\, OE\, R/W, etc.  Is there anything special about CS0\ (after boot)?

By default, Intrinsyc/Linux sets ups the EBC registers as follows:

EBC0_B0CR  : 0xffe3a000
EBC0_B1CR  : 0x60018000
EBC0_B2CR  : 0x00000000
EBC0_B3CR  : 0x00000000
EBC0_B4CR  : 0x00000000
EBC0_B0AP  : 0x04002480
EBC0_B1AP  : 0x04005480
EBC0_B2AP  : 0x00000000
EBC0_B3AP  : 0x00000000
EBC0_B4AP  : 0x00000000
EBC0_BEAR  : 0x00000000
EBC0_BESR0 : 0x00000000
EBC0_BESR1 : 0x00000000
EBC0_CFG   : 0x80400000

and I changed B0CR to 0x0043a000 and I'm trying to use mmap like:

#define MAP_BASE		(0x00400000)
#define MAP_LENGTH	0x10
#define MAP_PROT		(PROT_READ | PROT_WRITE)
#define MAP_FLAGS		(MAP_SHARED)

volatile unsigned char *init_map(int *file)
{
	volatile unsigned char *map;

	if ((*file = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
		puts("Failure opening device.");
		return NULL;
	}

	map = (unsigned char *) mmap(NULL, MAP_LENGTH, MAP_PROT, MAP_FLAGS, *file, MAP_BASE);
	if (map == (void *) -1) {
		puts("Failure mapping memory.");
		close(*file);
		return NULL;
	}

	return map;
}

then reading/writing to the returned map address.  ... any suggestions?

I have an oscilloscope and digital logical analyzer available to probe signals.

Thanks!
-Paul

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
