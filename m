Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id 283BE2BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 14:37:23 +1000 (EST)
Received: from sonartech.com.au (daveg@dgees.sonartech.com.au [203.28.130.98])
	by sonartech.com.au (8.12.11/8.12.11) with ESMTP id i8G4Ux83012571
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 14:30:59 +1000
Message-ID: <414916BD.9080607@sonartech.com.au>
Date: Thu, 16 Sep 2004 14:29:49 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------010600000605080908020902"
Subject: Linux-2.6.9-rc2 kernel build for mvme5100 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010600000605080908020902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I've got two questions in regard to building linux-2.6.9-rc2 for a mvme5100

Target info:
build platform: mvme5100, gcc-3.3.4, debian-testing, linuxppc_2_4_devel, 
default mvme5100 config
target platform: mvme5100

Questions 1:

I was getting this error when I tried to build the kernel:

  CC      arch/ppc/boot/common/bootinfo.o
  CC      arch/ppc/boot/common/misc-common.o
  CC      arch/ppc/boot/common/ns16550.o
arch/ppc/boot/common/ns16550.c:14: error: conflicting types for `outb'
include/asm/io.h:142: error: previous declaration of `outb'
arch/ppc/boot/common/ns16550.c:15: error: conflicting types for `inb'
include/asm/io.h:157: error: previous declaration of `inb'
make[2]: *** [arch/ppc/boot/common/ns16550.o] Error 1
make[1]: *** [arch/ppc/boot/common] Error 2
make: *** [zImage] Error 2

I changed arch/ppc/boot/common/ns16550.c so that it managed to compile 
based on what was in io.h, the patch for which is attatched, are these 
changes okay?


Question 2:

I'm now getting the error:

daveg@occy:/usr/src/play-2.6.9.new$ make
  CHK     include/linux/version.h
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  GZIP    arch/ppc/boot/images/vmlinux.gz
  HOSTCC  arch/ppc/boot/utils/addnote
  HOSTCC  arch/ppc/boot/utils/mknote
  HOSTCC  arch/ppc/boot/utils/hack-coff
  HOSTCC  arch/ppc/boot/utils/mkprep
  HOSTCC  arch/ppc/boot/utils/mkbugboot
  HOSTCC  arch/ppc/boot/utils/mktree
  AS      arch/ppc/boot/simple/head.o
  AS      arch/ppc/boot/simple/relocate.o
  CC      arch/ppc/boot/simple/misc.o
  CC      arch/ppc/boot/simple/dummy.o
objcopy -O elf32-powerpc \
        --add-section=.image=arch/ppc/boot/images/vmlinux.gz \
        --set-section-flags=.image=contents,alloc,load,readonly,data \
        arch/ppc/boot/simple/dummy.o arch/ppc/boot/simple/image.o
ld -T /usr/src/play-2.6.9.new/arch/ppc/boot/ld.script -Ttext 0x00800000 
-Bstatic -o arch/ppc/boot/simple/zvmlinux arch/ppc/boot/simple/head.o 
arch/ppc/boot/simple/relocate.o arch/ppc/boot/simple/misc.o 
arch/ppc/boot/simple/image.o arch/ppc/boot/common/lib.a 
arch/ppc/boot/lib/lib.a
arch/ppc/boot/common/lib.a(ns16550.o)(.text+0x2e): In function 
`serial_init':
: undefined reference to `isa_io_base'
arch/ppc/boot/common/lib.a(ns16550.o)(.text+0x42): In function 
`serial_init':
: undefined reference to `isa_io_base'
arch/ppc/boot/common/lib.a(ns16550.o)(.text+0x7e): In function 
`serial_init':
: undefined reference to `isa_io_base'
arch/ppc/boot/common/lib.a(ns16550.o)(.text+0x86): In function 
`serial_init':
: undefined reference to `isa_io_base'
arch/ppc/boot/common/lib.a(ns16550.o)(.text+0xda): In function 
`serial_init':
: undefined reference to `isa_io_base'
arch/ppc/boot/common/lib.a(ns16550.o)(.text+0xfa): more undefined 
references to `isa_io_base' follow
make[2]: *** [arch/ppc/boot/simple/zvmlinux] Error 1
make[1]: *** [simple] Error 2
make: *** [zImage] Error 2

Now I know isa_io_base is declared/defined in arch/ppc/kernel/pci.c so 
how is it supposed to link?

Ta,
dlg




--------------010600000605080908020902
Content-Type: text/plain;
 name="ns16550.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ns16550.c.patch"

--- linux/arch/ppc/boot/common/ns16550.c	2004-08-14 20:56:23.000000000 +1000
+++ play-2.6.9.new/arch/ppc/boot/common/ns16550.c	2004-09-16 13:56:44.000000000 +1000
@@ -11,8 +11,8 @@
 
 #define SERIAL_BAUD	9600
 
-extern void outb(int port, unsigned char val);
-extern unsigned char inb(int port);
+extern void outb(unsigned int val, unsigned int port);
+extern unsigned int inb(unsigned int port);
 extern unsigned long ISA_io;
 
 static struct serial_state rs_table[RS_TABLE_SIZE] = {
@@ -47,7 +47,7 @@
 	/* save the LCR */
 	lcr = inb(com_port + (UART_LCR << shift));
 	/* Access baud rate */
-	outb(com_port + (UART_LCR << shift), 0x80);
+	outb(0x80, com_port + (UART_LCR << shift));
 	dlm = inb(com_port + (UART_DLM << shift));
 	/*
 	 * Test if serial port is unconfigured.
@@ -58,20 +58,20 @@
 
 	if ((dlm <= 4) && (lcr & 2))
 		/* port is configured, put the old LCR back */
-		outb(com_port + (UART_LCR << shift), lcr);
+		outb(lcr, com_port + (UART_LCR << shift));
 	else {
 		/* Input clock. */
-		outb(com_port + (UART_DLL << shift),
-		     (BASE_BAUD / SERIAL_BAUD) & 0xFF);
-		outb(com_port + (UART_DLM << shift),
-		     (BASE_BAUD / SERIAL_BAUD) >> 8);
+		outb((BASE_BAUD / SERIAL_BAUD) & 0xFF,
+		     com_port + (UART_DLL << shift));
+		outb((BASE_BAUD / SERIAL_BAUD) >> 8,
+		     com_port + (UART_DLM << shift));
 		/* 8 data, 1 stop, no parity */
-		outb(com_port + (UART_LCR << shift), 0x03);
+		outb(0x03, com_port + (UART_LCR << shift));
 		/* RTS/DTR */
-		outb(com_port + (UART_MCR << shift), 0x03);
+		outb(0x03, com_port + (UART_MCR << shift));
 	}
 	/* Clear & enable FIFOs */
-	outb(com_port + (UART_FCR << shift), 0x07);
+	outb(0x07, com_port + (UART_FCR << shift));
 
 	return (com_port);
 }
@@ -81,7 +81,7 @@
 {
 	while ((inb(com_port + (UART_LSR << shift)) & UART_LSR_THRE) == 0)
 		;
-	outb(com_port, c);
+	outb(c, com_port);
 }
 
 unsigned char

--------------010600000605080908020902--
