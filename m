Message-Id: <3.0.6.32.20000128150944.00969100@falcon.si.com>
Date: Fri, 28 Jan 2000 15:09:44 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Bootstrapping a PPC8260 board
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need to create a bootstrap program for a PPC8260-based board and am
looking for code (always most helpful :-), ideas, and critiques.  The
idea is to have a minimal bootstrap loader built into flash such that
it is sufficient to load a "real" program into RAM and start to run
that program.  The "real" program could be just a more elaborate
bootstrap program that is capable of loading via ethernet and knows how
to write to flash, or it could be a fully functional system.

The desire is to have a bare minimum program for the following reasons:
* Faster to implement
* Small and thus faster to load via a slow JTAG loader
* Lower risk of bugs
* Easier to port to different hardware
* It seems silly to have a full linux kernel just to be able to load a
    linux kernel

I'm proposing S-records in a pseudo file loaded via ethernet/IP/UDP/TFTP
* Host end is all standard protocols and readily available programs
* IP/UDP is reasonably simple to implement as a polled mode driver
* TFTP is simple to implement

My current plan is:
* Initialize the processor and the RAM interface.
  * No cache (the QUICC does all the high speed stuff)
  * No MMU
  * No interrupts
  * Blinky light (for debug use: blink every 'n' S-records seen)
* Set up an FCC to run ethernet
* The protocol stack will be simple polled mode ethernet/IP/UDP/TFTP
  * The MAC and IP addresses will be burned into flash
* Writing to the file "MEM" (or any file?) causes the TFTP code to
    look for S-records, convert them to bytes and write them to
    memory.  If there is a start address S-record, jump to that address.
* Enhancement: a read from the file "MEM<addr>-<length>" will return
    S-records representing that section of memory (<addr> and <length>
    are both eight ASCII-hex digits).
* Enhancement: be able to write to flash memory.
* Enhancement: use BootP to get the IP address, file to load, etc.
    This would change the loader from a "push" type system to a
    "pull" type system.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
