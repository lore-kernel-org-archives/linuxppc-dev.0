In-Reply-To: <20040809232327.GC22109@smtp.west.cox.net>
References: <3461F858-E7F6-11D8-B7C4-000A95A0560C@us.ibm.com> <20040809232327.GC22109@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/mixed; boundary=Apple-Mail-3--957659066
Message-Id: <4D8F4794-F573-11D8-A775-000A95A0560C@us.ibm.com>
Cc: "'linuxppc-dev@lists.linuxppc.org' Development" <linuxppc-dev@lists.linuxppc.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: PReP bootloader VGA console
Date: Mon, 23 Aug 2004 21:14:17 -0500
To: Tom Rini <trini@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-3--957659066
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

On Aug 9, 2004, at 6:23 PM, Tom Rini wrote:
> On Fri, Aug 06, 2004 at 05:16:03PM -0500, Hollis Blanchard wrote:
>
>> But all of this would require more digging through makefiles and weak
>> aliases than it's probably worth.
>
> 'cmon, you know you want to. :)

Not a whole lot, but I did anyways. :)

This compiles and works on PReP. I have not even compile-tested the
other boards I may have impacted, but I tried to be careful.

I moved ISA initialization out of decompress_kernel() and into the
(weak) load_kernel() so that it only happens once: misc-prep.c calls it
in load_kernel(); no need to do it again.

--
Hollis Blanchard
IBM Linux Technology Center


--Apple-Mail-3--957659066
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="ppc-boot-isa.diff"
Content-Disposition: attachment;
	filename=ppc-boot-isa.diff

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1865  -> 1.1866
#	arch/ppc/boot/simple/Makefile	1.32    -> 1.33
#	arch/ppc/boot/simple/misc-prep.c	1.1     -> 1.2
#	arch/ppc/boot/include/nonstdio.h	1.5     -> 1.6
#	arch/ppc/boot/simple/legacy.S	1.2     ->         (deleted)
#	arch/ppc/boot/common/misc-common.c	1.13    -> 1.14
#	arch/ppc/boot/simple/misc.c	1.20    -> 1.21
#	arch/ppc/boot/simple/chrpmap.S	1.2     ->         (deleted)
#	arch/ppc/boot/common/serial_stub.c	1.1     -> 1.2
#	               (new)	        -> 1.2     arch/ppc/boot/simple/prepmap.c
#	               (new)	        -> 1.2     arch/ppc/boot/simple/chrpmap.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/08/23	hollis@ambient.ltc.austin.ibm.com	1.1866
# reorg the boot stuff a little to reflect the following:
# - ISA_io doesn't need to be initialized with assembly
# - serial_fixups() just initializes ISA_io, so should be renamed
# - we must initialize ISA_io before calling vga_init()
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/common/misc-common.c b/arch/ppc/boot/common/misc-common.c
--- a/arch/ppc/boot/common/misc-common.c	Mon Aug 23 21:30:32 2004
+++ b/arch/ppc/boot/common/misc-common.c	Mon Aug 23 21:30:32 2004
@@ -526,6 +526,11 @@
  * on others it's an offset from a given location. -- Tom
  */

+void ISA_init(unsigned long base)
+{
+	ISA_io = (unsigned char *)base;
+}
+
 void
 outb(int port, unsigned char val)
 {
diff -Nru a/arch/ppc/boot/common/serial_stub.c b/arch/ppc/boot/common/serial_stub.c
--- a/arch/ppc/boot/common/serial_stub.c	Mon Aug 23 21:30:32 2004
+++ b/arch/ppc/boot/common/serial_stub.c	Mon Aug 23 21:30:32 2004
@@ -11,11 +11,6 @@
  * is" without any warranty of any kind, whether express or implied.
  */

-void __attribute__ ((weak))
-serial_fixups(void)
-{
-}
-
 unsigned long __attribute__ ((weak))
 serial_init(int chan, void *ignored)
 {
diff -Nru a/arch/ppc/boot/include/nonstdio.h b/arch/ppc/boot/include/nonstdio.h
--- a/arch/ppc/boot/include/nonstdio.h	Mon Aug 23 21:30:32 2004
+++ b/arch/ppc/boot/include/nonstdio.h	Mon Aug 23 21:30:32 2004
@@ -30,3 +30,5 @@
 extern void puts(const char *);
 extern void udelay(long delay);
 extern unsigned char inb(int port);
+extern void board_isa_init(void);
+extern void ISA_init(unsigned long base);
diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	Mon Aug 23 21:30:32 2004
+++ b/arch/ppc/boot/simple/Makefile	Mon Aug 23 21:30:32 2004
@@ -73,7 +73,7 @@
 zimageinitrd-$(CONFIG_GEMINI)		:= zImage.initrd-STRIPELF
          end-$(CONFIG_GEMINI)		:= gemini

-     extra.o-$(CONFIG_K2)		:= legacy.o
+     extra.o-$(CONFIG_K2)		:= prepmap.o
          end-$(CONFIG_K2)		:= k2
    cacheflag-$(CONFIG_K2)		:= -include $(clear_L2_L3)

@@ -89,7 +89,7 @@
          end-$(motorola)		:= pplus

 # Overrides previous assingment
-     extra.o-$(CONFIG_PPLUS)		:= legacy.o
+     extra.o-$(CONFIG_PPLUS)		:= prepmap.o
      extra.o-$(CONFIG_LOPEC)		:= mpc10x_memory.o

       zimage-$(pcore)			:= zImage-STRIPELF
@@ -100,7 +100,7 @@

       zimage-$(CONFIG_PPC_PREP)		:= zImage-PPLUS
 zimageinitrd-$(CONFIG_PPC_PREP)		:= zImage.initrd-PPLUS
-     extra.o-$(CONFIG_PPC_PREP)		:= legacy.o
+     extra.o-$(CONFIG_PPC_PREP)		:= prepmap.o
         misc-$(CONFIG_PPC_PREP)		+= misc-prep.o mpc10x_memory.o
          end-$(CONFIG_PPC_PREP)		:= prep

diff -Nru a/arch/ppc/boot/simple/chrpmap.S b/arch/ppc/boot/simple/chrpmap.S
--- a/arch/ppc/boot/simple/chrpmap.S	Mon Aug 23 21:30:32 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,19 +0,0 @@
-/*
- * arch/ppc/boot/simple/chrpmap.S
- *
- * Author: Tom Rini <trini@mvista.com>
- *
- * This will go and setup ISA_io to 0xFE00000 and return.
- */
-
-#include <asm/ppc_asm.h>
-
-	.text
-
-	.globl serial_fixups
-serial_fixups:
-	lis	r3,ISA_io@h	/* Load ISA_io */
-	ori	r3,r3,ISA_io@l
-	lis	r4,0xFE00	/* Load the value, 0xFE00000 */
-	stw	r4,0(r3)	/* store */
-	blr
diff -Nru a/arch/ppc/boot/simple/chrpmap.c b/arch/ppc/boot/simple/chrpmap.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/simple/chrpmap.c	Mon Aug 23 21:30:32 2004
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2004 Hollis Blanchard <hollisb@us.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <nonstdio.h>
+
+void board_isa_init(void)
+{
+	ISA_init(0xFE000000);
+}
diff -Nru a/arch/ppc/boot/simple/legacy.S b/arch/ppc/boot/simple/legacy.S
--- a/arch/ppc/boot/simple/legacy.S	Mon Aug 23 21:30:32 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,19 +0,0 @@
-/*
- * arch/ppc/boot/simple/legacy.S
- *
- * Author: Tom Rini <trini@mvista.com>
- *
- * This will go and setup ISA_io to 0x8000000 and return.
- */
-
-#include <asm/ppc_asm.h>
-
-	.text
-
-	.globl serial_fixups
-serial_fixups:
-	lis	r3,ISA_io@h	/* Load ISA_io */
-	ori	r3,r3,ISA_io@l
-	lis	r4,0x8000	/* Load the value, 0x8000000 */
-	stw	r4,0(r3)	/* store */
-	blr
diff -Nru a/arch/ppc/boot/simple/misc-prep.c b/arch/ppc/boot/simple/misc-prep.c
--- a/arch/ppc/boot/simple/misc-prep.c	Mon Aug 23 21:30:32 2004
+++ b/arch/ppc/boot/simple/misc-prep.c	Mon Aug 23 21:30:32 2004
@@ -88,6 +88,7 @@
 		ofinit(OFW_interface);
 	}

+	board_isa_init();
 #if defined(CONFIG_VGA_CONSOLE)
 	vga_init((unsigned char *)0xC0000000);
 #endif /* CONFIG_VGA_CONSOLE */
diff -Nru a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
--- a/arch/ppc/boot/simple/misc.c	Mon Aug 23 21:30:32 2004
+++ b/arch/ppc/boot/simple/misc.c	Mon Aug 23 21:30:32 2004
@@ -97,7 +97,6 @@
 	struct bi_record *rec;
 	unsigned long initrd_loc, TotalMemory = 0;

-	serial_fixups();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	com_port = serial_init(0, NULL);
 #endif
@@ -268,10 +267,16 @@
 	return rec;
 }

+void __attribute__ ((weak))
+board_isa_init(void)
+{
+}
+
 /* Allow decompress_kernel to be hooked into.  This is the default. */
 void * __attribute__ ((weak))
 load_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
 		void *ign1, void *ign2)
 {
+		board_isa_init();
 		return decompress_kernel(load_addr, num_words, cksum);
 }
diff -Nru a/arch/ppc/boot/simple/prepmap.c b/arch/ppc/boot/simple/prepmap.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/simple/prepmap.c	Mon Aug 23 21:30:32 2004
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2004 Hollis Blanchard <hollisb@us.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <nonstdio.h>
+
+void board_isa_init(void)
+{
+	ISA_init(0x80000000);
+}

--Apple-Mail-3--957659066--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
