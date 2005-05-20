Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
Date: Fri, 20 May 2005 16:05:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Set cpu type explicitly, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a revised version of my patch to set the cpu type explicitly
for gcc when compiling the kernel.  Setting the cpu type is a good
idea in any case, and particularly if you have a biarch gcc.  This
sets the type for all of the ppc cpu families we support.

Any further comments?  Are -mcpu=860 and -mcpu=8540 reasonable for 8xx
and 85xx respectively?  I used -mcpu=power4 rather than -mcpu=970
because the former works with gcc-3.6.6 as in debian and the latter
doesn't.  Unfortunately -mcpu=440 doesn't work either in gcc 3.3,
though it does in gcc 3.4 (as does -mcpu=970).

Paul.

diff -urN linux-2.6/arch/ppc/Makefile pmac-2.5/arch/ppc/Makefile
--- linux-2.6/arch/ppc/Makefile	2005-05-02 08:29:36.000000000 +1000
+++ pmac-2.5/arch/ppc/Makefile	2005-05-19 15:26:42.000000000 +1000
@@ -23,15 +23,20 @@
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
+cpu-opt-$(CONFIG_40x)		+= -mcpu=405
+cpu-opt-$(CONFIG_44x)		+= -mcpu=440
+cpu-opt-$(CONFIG_POWER3)	+= -mcpu=power3
+cpu-opt-$(CONFIG_POWER4)	+= -mcpu=power4
+cpu-opt-$(CONFIG_8xx)		+= -mcpu=860
+cpu-opt-$(CONFIG_E500)		+= -mcpu=8540
+
+CFLAGS += $(cpu-opt-y)
 
 cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
