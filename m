From: "Elan Feingold" <elan@nxnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: A few questions about booting
Date: Tue, 31 Jul 2001 12:22:11 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGECEFJCEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

EST 8260 board, bus at 50Mhz.

We're now a bit further in the boot process, but we're still having some
trouble, probably caused by our imperfect understanding of the complete boot
process.  Here's what we do:

1. We use limon 1.5.0 to load a zImage into memory at 0x900000.  We had to
modify limon to get it to do that because it wanted to load the zImage at
0x000000, which of course led to the decompression failing -- I guess limon
really wanted to use the decompressed kernel.

2. The kernel decompresses, and then starts to boot ("Now booting Linux").
That's the last print out we ever see.  The kernel *appears* to be stuck in
time_init() which I guess would explain why we don't see printouts, because
the console doesn't get setup until later, right?  Any ideas why that would
happen?

Our confusion also stems from the bootinfo stuff.  Limon builds this
"enhanced" structure that doesn't really resemble the standard bootinfo
structure in est8260.h.  I think this residual data gets passed to the Linux
bootloader (which calls embed_config(), which I think modifies what's passed
in by limon/ppcboot, etc., right?).  We ignore the limon data and simply
hardwire the values to be what was displayed by limon (cheezy, I know, but
easy for now).  I don't understand the huge bd_info structure in est8260.h
(passed in by ppcboot, I guess).  Who uses the structure?  I couldn't find
any reference to source that used half of the values.  We use the simpler
bd_info structure defined at the bottom of the file, and hardwire the values
in embed_config().  I believe this memory then gets passed to the actual
linux kernel, correct?

The kernel seems to only use:

bi_busfreq, bi_memsize, bi_baudrate, bi_brgfreq, bi_enetaddr, bi_intfreq

for anything useful.  So why are the only parameters in the structure setup
at all??????  Like bi_vco, or bi_immr, or all those complicated fields in
the enhanced ppcboot structure?

Here are our values for you to laugh at, or comment on:

baudrate = 9600  (matches limon)
busfreq = 50000000
intfreq = 200000000
cpmfreq = 100000000
vco = 2 * cpmfreq
brgfreq = 50000000
memsize = 16*1024*1024
memstart = 0
immr = IMAP_ADDR

Any help would be much appreciated.  We've been using the Vision ICE system
for debugging, and it's a bit of a pain, because the Linux ELF symbols
assume 0x00000000 base, and since the MMU maps this into 0xc0000000, the
debugger gets confused.

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
