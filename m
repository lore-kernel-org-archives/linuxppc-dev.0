Subject: gcc for ppc/predefined macros
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1075715340.19857.14.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 02 Feb 2004 10:49:01 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just had to find out very painfully that
my cross-gcc-3.3.2 doesn't have __powerpc__
as a predefined macro anymore:

(SuSE-built-) gcc 2.95.3:
.../powerpc-linux-cpp -dM ~/foo.h |grep -i pc

#define powerpc 1
#define __PPC__ 1
#define PPC 1
#define _ARCH_PPC 1
#define __PPC 1
#define __powerpc__ 1
#define __powerpc 1


(gentoo-crossdev-build-) gcc 3.3.2:
.../powerpc-unknown-eabi-cpp -dM ~/foo.h |grep -i pc

#define _ARCH_PPC 1
#define __PPC 1
#define PPC 1
#define __PPC__ 1

The kernel relies on __powerpc__ in some places,
in fact, the serial console won't work anymore
since the LCR gets setup incorrectly in
serial_console_setup located in serial.c.

The workaround is easy,
just added -D__powerpc__ to CFLAGS_KERNEL.

--
Stefan Nickl
Project Engineering
Kontron Modular Computers
Sudetenstr. 7
D-87600 Kaufbeuren
Phone ++49/8341/803-294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
