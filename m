Return-Path: <laurent@vivier.eu>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEA6F1A0CED
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 22:47:22 +1100 (AEDT)
From: Laurent Vivier <laurent@vivier.eu>
To: benh@kernel.crashing.org,
	paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
Date: Thu,  5 Nov 2015 12:47:09 +0100
Message-Id: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When I try to cross compile a ppc64 kernel, it generally
fails on the VDSO stage. This is true for powerpc64 cross-
compiler, but also when I try to build a ppc64le kernel
on a ppc64 host.

VDSO64L fails:

  VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
/usr/bin/powerpc64-linux-gnu-ld: arch/powerpc/kernel/vdso64/sigtramp.o:
file class ELFCLASS64 incompatible with ELFCLASS32
/usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong format

This fails because gcc calls "collect2" with
"--oformat elf32-powerpcle" with ppc64 objects, without the
"--oformat" ld works well because it use the format of the
first object as output format.

As this case is correctly managed to build the other kernel
objects, this patch replaces $(GCC) by $(LD) to generate the
VDSO objects.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/powerpc/kernel/vdso64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index effca94..618c420 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -36,7 +36,7 @@ $(obj-vdso64): %.o: %.S
 
 # actual build commands
 quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso64ld = $(LD) $(LDFLAGS) $(ldflags-y) -T $^ -o $@
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 
-- 
2.5.0
