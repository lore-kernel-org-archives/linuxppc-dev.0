Message-Id: <199904280958.LAA24884@student.physik.uni-mainz.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Endianess problems in linuxppc kernel
Date: Wed, 28 Apr 1999 11:56:15 CEST
From: "Christian Bauer" <Christian.Bauer@uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Reply-To: Christian.Bauer@uni-mainz.de
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I'm experiencing endianess problems in some parts of the Linux kernel.

About the machine in question:

It's a freshly installed linuxppc-pre-r5 system (as of 24.Apr.99),
kernel 2.2.6 from ftp.kernel.org, egcs-1.1.2 used to compile the kernel.
Linux is booted with BootX 1.0.6. No extra kernel arguments given.
X11 server is XF68_FBDev (atyfb).

/proc/cpuinfo:

processor	: 0
cpu		: 603ev
clock		: 200MHz
revision	: 2.1
bogomips	: 133.12
zero pages	: total 0 (0Kb) current: 0 (0Kb) hits: 0/121 (0%)
machine		: Power Macintosh
motherboard	: AAPL,e826 MacRISC
L2 cache	: 256K unified
memory		: 48MB

/proc/pci:

PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Bandit (rev 3).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek 8029 (rev 0).
      Medium devsel.  IRQ 23.  
      I/O at 0x1000 [0x1001].
  Bus  0, device  16, function  0:
    Unknown class: Apple Unknown device (rev 1).
      Vendor id=106b. Device id=7.
      Medium devsel.  Master Capable.  Latency=32.  
      Non-prefetchable 32 bit memory at 0xf3000000 [0xf3000000].
  Bus  0, device  17, function  0:
    VGA compatible controller: ATI Mach64 VT (rev 64).
      Medium devsel.  Fast back-to-back capable.  IRQ 22.  
      Non-prefetchable 32 bit memory at 0x81000000 [0x81000000].
      I/O at 0x1000 [0x1001].
  Bus  0, device  20, function  0:
    PCI bridge: DEC DC21052 (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  Min Gnt=4.

The problems:

1. ne2k-pci driver
------------------

The NE2000 PCI card (RealTek 8029 chip) only works when I make the following
changes to drivers/net/ne2k-pci.c:

--- ne2k-pci.c.orig	Wed Apr 28 03:03:11 1999
+++ ne2k-pci.c	Wed Apr 28 03:03:29 1999
@@ -462,7 +462,8 @@
 	outb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
 
 #if defined(USE_LONGIO)
-	*(u32*)hdr = inl(NE_BASE + NE_DATAPORT);
+	*(u32*)hdr = le32_to_cpu(inl(NE_BASE + NE_DATAPORT));
+	le16_to_cpus(&hdr->count);
 #else
 	insw(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr)>>1);
 #endif
@@ -481,6 +482,7 @@
 {
 	int nic_base = dev->base_addr;
 	char *buf = skb->data;
+	int i;
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
 	if (ei_status.dmaing) {
@@ -500,10 +502,12 @@
 
 #if defined(USE_LONGIO)
 	insl(NE_BASE + NE_DATAPORT, buf, count>>2);
+	for (i=0; i<(count>>2); i++)
+		le32_to_cpus((u32*)buf + i);
 	if (count & 3) {
 		buf += count & ~3;
 		if (count & 2)
-			*((u16*)buf)++ = inw(NE_BASE + NE_DATAPORT);
+			*((u16*)buf)++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
 		if (count & 1)
 			*buf = inb(NE_BASE + NE_DATAPORT);
 	}
@@ -524,6 +528,7 @@
 {
 	int nic_base = NE_BASE;
 	unsigned long dma_start;
+	int i;
 
 	/* On little-endian it's always safe to round the count up for
 	   word writes. */
@@ -562,11 +567,12 @@
 	outb(start_page, nic_base + EN0_RSARHI);
 	outb(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
 #if defined(USE_LONGIO)
-	outsl(NE_BASE + NE_DATAPORT, buf, count>>2);
+	for (i=0; i<(count>>2); i++)
+		outl(cpu_to_le32(((u32*)buf)[i]), NE_BASE + NE_DATAPORT);
 	if (count & 3) {
 		buf += count & ~3;
 		if (count & 2)
-			outw(*((u16*)buf)++, NE_BASE + NE_DATAPORT);
+			outw(cpu_to_le16(*((u16*)buf)++), NE_BASE + NE_DATAPORT);
 	}
 #else
 	outsw(NE_BASE + NE_DATAPORT, buf, count>>1);

The "le16_to_cpus(&hdr->count)" fixes a real bug in the driver (it wouldn't
work on big-endian machines, no matter how outsl/insl works), but everything
else looks like the outsl/insl functions work with the wrong byte order
(little-endian vs. big-endian).


2. Video display
----------------

When the MacOS is set to 8 or 32 bit color depth:

 - console (8 bit): works fine
 - X11 in 8 bit: works fine
 - X11 in 16 bit: colors are right, but everything not drawn by the
   blitter (mainly icons and some text) looks like every two pixels
   are swapped (i.e. the byte order looks like it's "3412" when it should
   be "1234")
 - X11 in 32 bit: pixel order is right, but colors are wrong. Red and green
   are swapped, blue is missing. Here, it looks like we have a byte order of
   "4321". As in 16 bit, things drawn by the blitter are not affected.

When the MacOS is set to 16 bit color depth:

 - console (8 bit): colors are right, but the font is garbled. Every two
   neighbouring pixels are swapped (as in the 16 bit mode described above)
 - X11 in 8 bit: the same "pixel swap" problems as in the console (again,
   only with things drawn by the CPU). Moving the mouse pointer or moving
   windows leaves "droppings" on the screen.
 - X11 in 16 bit: pixel order is right, but colors are psychedelic. Looks
   like a byte order of "2143".
 - X11 in 32 bit: pixel order is right, colors are wrong. Red and blue are
   swapped, green is missing. Byte order seems to be "3412". Moving the
   mouse pointer or windows leaves "droppings" as in 8 bit mode.

Most interesting for me is that the behavour depends on what color depth
was displayed in MacOS before booting Linux. Clearly, Linux is not
initializing something neccessary.


3. Sound output
---------------

Playing a module with "mikmod" results in rhythmic noise (16 bit) or silence
(8 bit). When I change every instance of

  out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);

to

  out_le32(&awacs->byteswap, sound.hard.format == AFMT_S16_BE);

in "drivers/sound/dmasound.c", both 8 and 16 bit output work fine.


Does anyone have any suggestions (especially about the video problem)?

Bye,
Christian

-- 
  / Coding on PowerPC and proud of it
\/ http://www.uni-mainz.de/~bauec002/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
