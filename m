Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk2vB4ZXjzDqfx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 12:17:26 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id r187so798242pfr.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:17:26 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] selftests/powerpc: fix build error in powerpc ptrace
 selftests.
Date: Fri,  1 Sep 2017 10:17:14 +0800
Message-Id: <1504232234-4161-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

GCC 7 will take "r2" in clobber list as an error will it will get following
build errors for powerpc ptrace selftests even with -fno-pic option:
  ptrace-tm-vsx.c: In function ‘tm_vsx’:
  ptrace-tm-vsx.c:42:2: error: PIC register clobbered by ‘r2’ in ‘asm’
    asm __volatile__(
    ^~~
  make[1]: *** [ptrace-tm-vsx] Error 1
  ptrace-tm-spd-vsx.c: In function ‘tm_spd_vsx’:
  ptrace-tm-spd-vsx.c:55:2: error: PIC register clobbered by ‘r2’ in ‘asm’
    asm __volatile__(
    ^~~
  make[1]: *** [ptrace-tm-spd-vsx] Error 1
  ptrace-tm-spr.c: In function ‘tm_spr’:
  ptrace-tm-spr.c:46:2: error: PIC register clobbered by ‘r2’ in ‘asm’
    asm __volatile__(
    ^~~

This patch fix the build error by removing "r2" out of clobber list.

Reported-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Tested-by: Seth Forshee <seth.forshee@canonical.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile            | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c | 4 ++--
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c     | 3 +--
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c     | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index fe6bc60..c836f6d 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -6,7 +6,7 @@ include ../../lib.mk
 
 all: $(TEST_PROGS)
 
-CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm
+CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pic
 
 $(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
index 0df3c23..277dade 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
@@ -79,8 +79,8 @@ void tm_spd_vsx(void)
 		: [res] "=r" (result), [texasr] "=r" (texasr)
 		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
 		[sprn_texasr] "i"  (SPRN_TEXASR)
-		: "memory", "r0", "r1", "r2", "r3", "r4",
-		"r8", "r9", "r10", "r11"
+		: "memory", "r0", "r1", "r3", "r4",
+		"r7", "r8", "r9", "r10", "r11"
 		);
 
 	if (result) {
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
index 94e57cb..51427a2 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
@@ -76,8 +76,7 @@ void tm_spr(void)
 		: [tfhar] "=r" (tfhar), [res] "=r" (result),
 		[texasr] "=r" (texasr), [cptr1] "=r" (cptr1)
 		: [sprn_texasr] "i"  (SPRN_TEXASR)
-		: "memory", "r0", "r1", "r2", "r3", "r4",
-		"r8", "r9", "r10", "r11", "r31"
+		: "memory", "r0", "r8", "r31"
 		);
 
 	/* There are 2 32bit instructions before tbegin. */
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
index b4081e2..17c23ca 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
@@ -67,7 +67,7 @@ void tm_vsx(void)
 		: [res] "=r" (result), [texasr] "=r" (texasr)
 		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
 		[sprn_texasr] "i"  (SPRN_TEXASR), [cptr1] "r" (&cptr[1])
-		: "memory", "r0", "r1", "r2", "r3", "r4",
+		: "memory", "r0", "r1", "r3", "r4",
 		"r7", "r8", "r9", "r10", "r11"
 		);
 
-- 
1.8.3.1
