From: jtm@smoothsmoothie.com
Date: Fri, 7 Dec 2001 18:01:06 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: QSPAN PCI and 860
Message-ID: <20011208000106.GA2323@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to build a kernel with support for the QSPAN PCI bridge
and am running into some problems. Is there a best config to start
from? I've tried both RPX-Lite and MBX, and both failed.

When trying to compile for the RPX-Lite, I get errors in
m8xx_setup.c about i8259 not being defined. Does this really
need to be defined, even if we don't have an i8259?

If we comment that stuff out (just to get it to build), we
get an error on the following inline assembly from qspan860.c:
#define __get_qspan_pci_config(x, addr, op)		\
	__asm__ __volatile__(				\
		"1:	"op" %0,0(%1)\n"		\
		"	eieio\n"			\
		"2:\n"					\
		".section .fixup,\"ax\"\n"		\
		"3:	li %0,-1\n"			\
		"	b 2b\n"				\
		".section __ex_table,\"a\"\n"		\
		"	.align 2\n"			\
		"	.long 1b,3b\n"			\
		".text"					\
		: "=r"(x) : "r"(addr) : " %0")

The error is
	qspan_pci.c:125: unknown register name ` %0' in `asm'


Finally, what is the correct way to allocate 256K or more
of host RAM to map into the PCI address space? The peripheral
we are working with needs at least 256K of host memory.


Thanks.

--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
