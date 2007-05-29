Return-Path: <dgibson@ozlabs.org>
Date: Tue, 29 May 2007 15:37:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Don't use HOSTCFLAGS in BOOTCFLAGS
Message-ID: <20070529053712.GE30266@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the bootwrapper code for powerpc, we include HOSTCFLAGS into the
BOOTCFLAGS used for buildinf the zImage wrapper code.  Since the
wrapper code is not host code, this makes no sense.  This patch
removes the use of HOSTCFLAGS here, instead including directly into
BOOTCFLAGS those flags from the normal kernel CFLAGS which also make
sense in the bootwrapper code.

In particular, this makes the bootwrapper use -msoft-float, preventing
the compiler from generating floating point instructions.  Previously,
under some circumstances the compiler could generate floating point
instructions in the bootwrapper which would cause exceptions on
embedded CPUS which don't have floating point support.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-29 15:22:07.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-29 15:31:30.000000000 +1000
@@ -11,20 +11,18 @@
 #	bootloader and increase compatibility with OpenFirmware.
 #
 #	To this end we need to define BOOTCC, etc, as the tools
-#	needed to build the 32 bit image.  These are normally HOSTCC,
-#	but may be a third compiler if, for example, you are cross
-#	compiling from an intel box.  Once the 64bit ppc gcc is
-#	stable it will probably simply be a compiler switch to
-#	compile for 32bit mode.
+#	needed to build the 32 bit image.  That's normally the same
+#	compiler for the rest of the kernel, with the -m32 flag added.
 #	To make it easier to setup a cross compiler,
 #	CROSS32_COMPILE is setup as a prefix just like CROSS_COMPILE
 #	in the toplevel makefile.
 
 all: $(obj)/zImage
 
-HOSTCC		:= gcc
-BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
-		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
+BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+		 -fno-strict-aliasing -Os -msoft-float -pipe \
+		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
+		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifeq ($(call cc-option-yn, -fstack-protector),y)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
