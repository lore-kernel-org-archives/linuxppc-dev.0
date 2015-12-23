Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6ED11A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 16:50:27 +1100 (AEDT)
Received: by mail-pa0-x232.google.com with SMTP id cy9so45768781pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 21:50:27 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	mpe@ellermen.id.au
Subject: [PATCH 2/5] selftests/powerpc: Standardise TM calls
Date: Wed, 23 Dec 2015 16:49:51 +1100
Message-Id: <1450849794-23174-3-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
References: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently tbegin, tend etc are written as opcodes or asm instructions. So
standardise these to asm instructions.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 16 +++++-----------
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c |  4 ++--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
index 8fde93d6021f..d9c49f41515e 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -31,12 +31,6 @@
 #include "utils.h"
 #include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TEND            ".long 0x7C00055D ;"
-#define TCHECK          ".long 0x7C00059C ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
-#define SPRN_TEXASR     0x82
 #define SPRN_DSCR       0x03
 
 int test_body(void)
@@ -55,13 +49,13 @@ int test_body(void)
 			"mtspr   %[sprn_dscr], 3;"
 
 			/* start and suspend a transaction */
-			TBEGIN
+			"tbegin.;"
 			"beq     1f;"
-			TSUSPEND
+			"tsuspend.;"
 
 			/* hard loop until the transaction becomes doomed */
 			"2: ;"
-			TCHECK
+			"tcheck 0;"
 			"bc      4, 0, 2b;"
 
 			/* record DSCR and TEXASR */
@@ -70,8 +64,8 @@ int test_body(void)
 			"mfspr   3, %[sprn_texasr];"
 			"std     3, %[texasr];"
 
-			TRESUME
-			TEND
+			"tresume.;"
+			"tend.;"
 			"li      %[rv], 0;"
 			"1: ;"
 			: [rv]"=r"(rv), [dscr2]"=m"(dscr2), [texasr]"=m"(texasr)
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
index e44a238c1d77..1f0eb567438d 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -60,9 +60,9 @@ int tm_signal_stack()
 		exit(1);
 	asm volatile("li 1, 0 ;"		/* stack ptr == NULL */
 		     "1:"
-		     ".long 0x7C00051D ;"	/* tbegin */
+		     "tbegin.;"
 		     "beq 1b ;"			/* retry forever */
-		     ".long 0x7C0005DD ; ;"	/* tsuspend */
+		     "tsuspend.;"
 		     "ld 2, 0(1) ;"		/* trigger segv" */
 		     : : : "memory");
 
-- 
2.5.0
