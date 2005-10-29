Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kegV029985@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:09 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, allinux@gmail.com,
	linuxppc64-dev@ozlabs.org
Subject: [patch 01/43] ppc: prevent GCC 4 from generating AltiVec
	instructions in kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Lee Nicks <allinux@gmail.com>

Depending on how GCC is built, GCC 4 may generate altivec instructions without
user explicitly requesting vector operations in the code.  Although this is a
performance booster for user applications, it is a problem for kernel.

This patch explicitly instruct GCC to NOT generate altivec instructions while
building the kernel.

Here are some test cases I ran.

(1) build gcc 4.0.1 with '--with-cpu=7450 --enable-altivec
    --enable-cxx-flags=-mcpu=7450', and use this gcc to build kernel WITHOUT
    this kernel patch.  Kernel fail to boot up on a 7450 board because of
    altivec instructions in kernel.

(2) build gcc 4.0.1 with "--with-cpu=7450 --enable-altivec
    --enable-cxx-flags=-mcpu=7450", and use this gcc to build kernel WITH this
    kernel patch.  Kernel boot up on a 7450 board without any problem.

(3) build gcc 4.0.1 with "--with-cpu=750 --enable-cxx-flags=-mcpu=750",
    and use this gcc to build kernel with or without this kernel patch. 
    Kernel boot up on a 7450 board without any problem.

This patch should also work with GCC 3 or even earlier GCC 2.95.3.

Signed-off-by: Lee Nicks <allinux@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/Makefile   |    4 ++++
 arch/ppc64/Makefile |    3 +++
 2 files changed, 7 insertions(+)

diff -puN arch/ppc64/Makefile~ppc-prevent-gcc-4-from-generating-altivec-instructions-in-kernel arch/ppc64/Makefile
--- devel/arch/ppc64/Makefile~ppc-prevent-gcc-4-from-generating-altivec-instructions-in-kernel	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc64/Makefile	2005-10-28 17:45:21.000000000 -0700
@@ -75,6 +75,9 @@ else
 	CFLAGS += $(call cc-option,-mtune=power4)
 endif
 
+# No AltiVec instruction when building kernel
+CFLAGS	+= $(call cc-option, -mno-altivec)
+
 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
 CFLAGS += $(call cc-option,-funit-at-a-time)
diff -puN arch/ppc/Makefile~ppc-prevent-gcc-4-from-generating-altivec-instructions-in-kernel arch/ppc/Makefile
--- devel/arch/ppc/Makefile~ppc-prevent-gcc-4-from-generating-altivec-instructions-in-kernel	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/Makefile	2005-10-28 17:44:02.000000000 -0700
@@ -26,6 +26,10 @@ CPPFLAGS	+= -Iarch/$(ARCH) -Iarch/$(ARCH
 AFLAGS		+= -Iarch/$(ARCH)
 CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -mmultiple
+
+# No AltiVec instruction when building kernel
+CFLAGS		+= $(call cc-option, -mno-altivec)
+
 CPP		= $(CC) -E $(CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
 LINUXINCLUDE    += -Iarch/$(ARCH)/include
_
