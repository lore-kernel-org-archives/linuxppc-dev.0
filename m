Message-ID: <FA06AA2C99BCD511951200005A99441043863E@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Cc: "'acurtis@onz.com'" <acurtis@onz.com>
Date: Thu, 2 May 2002 16:06:46 -0700
Subject: linuxppc_2_4_devel - Walnut compile
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I downloaded and tried to compile an IBM405GP kernel using the Walnut
configuration. Here is the path I have taken. Hopefully someone can take me
the rest of the way home.

1. make menuconfig (xconfig - does not work)
    and stripped out all of the extra junk

2. linker error - early_serial* symbols undefined
   modified drivers/char/Makefile - to include serial.c

3. linker error - serial_close() undefined
   reviewed the source code in arch/ppc. I believe that I need serial_sicc.c

4. Reviewed arch/ppc/config.in and discovered the following
  a. Minor error in file was preventing menu "IBM 4xx options --->" from
displaying (fixed)
     This is the only place I can find a reference for SICC console support.
This is dependent on 3 conditions. 1) Board is STB03xxx (not in any menus)
2) SERIAL_SICC is true 3) UART0_TTYS1 is true.
  b. Removed the platform dependency.

5. serial_sicc.c - does not compile because the only place the symbols are
defined is in ibmstb3.h (guess it is platform dependent)

Obviously my assumption about SICC serial support was wrong. What do I need
to successfully compile and link this platform?

Thanks in advance!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
