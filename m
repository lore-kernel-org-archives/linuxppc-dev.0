Content-Type: text/plain;
  charset="us-ascii"
From: Dustin Byford <dustin@firein.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8240, ocd wiggler, gdb, and pre boot init
Date: Thu, 28 Mar 2002 03:37:16 -0700
MIME-Version: 1.0
Message-Id: <200203280337.16187.dustin@firein.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, I have a question about building a custom 8240 board that I'm
attempting to load a linux ppc kernel on and do some IP routing.

Currently I have wired the cpu and sdram to the point that I need to
initialize the sdram controller and attempt to load a small test program to
perform some memory testing.  I'm having trouble with gdb for cygwin, for the
wiggler at www.ocdemon.net.  I feel fairly confident that I am able to read
and write all of the registers (gpr, msr, etc...) but I'm not sure exactly
what's going on with writing to the CONFIG_ADDR and CONFIG_DATA ports to
start initializing the SDRAM interface.  Currently, when I do a

set *0xfec00000 = 0x8000000a8
print *0xfec00000

I get a 0x0, in fact every memory location I attempt to print is without
variance 0x0.  One time I was able to write to 0xfec00000 and the value did
successfully print, but I continually re-issued the print and after about 10
seconds the value returned to 0x0.  Writing to registers is rock solid every
time, even when bypassing the register cache, using rproxy, and using the
ocdcommander software on the macraigor site.  A logic analyzer is showing the
bits flowing in and out of the cpu, and the 'ocd log' in gdb shows no errors.
LED displays are showing me the value on PMAA and MAA and it appears that the
CPU is in fact attempting to fetch an instruction from rom after a reset
(which is not wired in right now).

Perhaps someone who has tried this before might have some pointers.  Has
anyone written a gdb script to initialize the sdram interface on an 8240 that
they'd be willing to share?

Thanks for any help!

			--Dustin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
