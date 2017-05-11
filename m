Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNyRM6HJyzDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:57:19 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u187so4042166pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:57:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/5] powerpc/64: do not link crtsaveres.o in boot
Date: Fri, 12 May 2017 01:56:50 +1000
Message-Id: <20170511155652.8287-4-npiggin@gmail.com>
In-Reply-To: <20170511155652.8287-1-npiggin@gmail.com>
References: <20170511155652.8287-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

crtsaveres.S is empty with 64-bit builds already, so just don't
build and link it to match the vmlinux build.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/boot/Makefile    | 3 ++-
 arch/powerpc/boot/crtsavres.S | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e82f333cc84a..305d4d6b0ce0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -95,13 +95,14 @@ libfdtheader := fdt.h libfdt.h libfdt_internal.h
 $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
-src-wlib-y := string.S crt0.S crtsavres.S stdio.c decompress.c main.c \
+src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
 		uartlite.c mpc52xx-psc.c opal.c
 src-wlib-$(CONFIG_PPC64_BOOT_WRAPPER) +=  opal-calls.S
+src-wlib-$(CONFIG_PPC32) += crtsavres.S
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
 src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
diff --git a/arch/powerpc/boot/crtsavres.S b/arch/powerpc/boot/crtsavres.S
index f3d9b35c07d4..085fb2b9a8b8 100644
--- a/arch/powerpc/boot/crtsavres.S
+++ b/arch/powerpc/boot/crtsavres.S
@@ -37,12 +37,13 @@
  *    the executable file might be covered by the GNU General Public License.
  */
 
+#ifdef __powerpc64__
+#error "On PPC64, FPR save/restore functions are provided by the linker."
+#endif
+
 	.file	"crtsavres.S"
 	.section ".text"
 
-/* On PowerPC64 Linux, these functions are provided by the linker.  */
-#ifndef __powerpc64__
-
 #define _GLOBAL(name) \
 	.type name,@function; \
 	.globl name; \
@@ -230,4 +231,3 @@ _GLOBAL(_rest32gpr_31_x)
 	mtlr	0
 	mr	1,11
 	blr
-#endif
-- 
2.11.0
