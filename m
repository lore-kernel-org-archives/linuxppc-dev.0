From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15367.29270.548171.448033@argo.ozlabs.ibm.com>
Date: Fri, 30 Nov 2001 22:49:42 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: platform_serial.h
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Currently include/asm-ppc/serial.h has definitions for the 4 standard
PC serial ports plus other oddball ISA multiport serial adaptors:
fourport, accent, boca and hub6.

Has anyone *ever* used any of these ISA multiport adaptors on a PPC
system?  I wouldn't be at all surprised if the answer was no.

I would like to move those extra oddball things out to
include/asm-ppc/isa-serial.h.  Then I think <asm/serial.h> should
include <platform_serial.h>, and if that doesn't define
STD_SERIAL_PORT_DEFNS, define that to be the 4 standard PC serial
ports.

It boils down to the question of what default serial ports we think a
platform should get if it doesn't provide a platform_serial.h file:

- none,
- the four standard PC ports, or
- the four standard PC ports plus the oddball ones?

If we go for the second option and a platform wants the oddball ones,
it can #include <asm/isa-serial.h> in its platform_serial.h file.

Note that none of this will affect PCI multiport serial cards at all.

Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
