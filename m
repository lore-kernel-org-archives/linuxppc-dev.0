Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Date: Wed, 4 May 2005 17:05:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Cc: trini@kernel.crashing.org
Subject: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What do people think of this patch?  The motivation for it is that a
biarch gcc-4.0 will by default tune for POWER4, even for a 32-bit
compile, meaning that we end up with a lot of nops we don't need.
This also takes out -mstring.

With this, the text size reduces by about 120k for my normal config
when compiling with a biarch gcc-4.0.  The text size also reduces
slightly when compiling with the Debian gcc-3.3.5 (32-bit only, not
biarch).

If there are no objections I'll send this to Andrew and Linus.

Paul.

diff -urN linux-2.6/arch/ppc/Makefile pmac-2.5/arch/ppc/Makefile
--- linux-2.6/arch/ppc/Makefile	2005-05-02 08:29:36.000000000 +1000
+++ pmac-2.5/arch/ppc/Makefile	2005-05-03 16:45:57.000000000 +1000
@@ -23,15 +23,14 @@
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
 AFLAGS		+= -Iarch/$(ARCH)
-CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
-		-ffixed-r2 -mmultiple
+CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe -ffixed-r2 -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
 
 CHECKFLAGS	+= -D__powerpc__
 
-ifndef CONFIG_E500
-CFLAGS		+= -mstring
-endif
+cpu-opt-$(CONFIG_6xx)		+= -mcpu=750 -mtune=7450
+
+CFLAGS += $(cpu-opt-y)
 
 cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
