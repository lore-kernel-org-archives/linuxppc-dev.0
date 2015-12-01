Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 751BC1A1DDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:08:45 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so215236787pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:08:43 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id ux3sm55304740pac.18.2015.11.30.21.08.41
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 30 Nov 2015 21:08:42 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] selftests/powerpc: Standardise TM calls
Date: Tue,  1 Dec 2015 16:08:22 +1100
Message-Id: <1448946504-11653-2-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
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
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 16 ++++++----------
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c |  4 ++--
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
index 42d4c8caad81..88c46481e59b 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -29,12 +29,8 @@
 #include <asm/tm.h>
 
 #include "utils.h"
+#include "tm.h"
 
-#define TBEGIN          ".long 0x7C00051D ;"
-#define TEND            ".long 0x7C00055D ;"
-#define TCHECK          ".long 0x7C00059C ;"
-#define TSUSPEND        ".long 0x7C0005DD ;"
-#define TRESUME         ".long 0x7C2005DD ;"
 #define SPRN_TEXASR     0x82
 #define SPRN_DSCR       0x03
 
@@ -52,13 +48,13 @@ int test_body(void)
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
@@ -67,8 +63,8 @@ int test_body(void)
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
index 82c29cb222dc..8ffd5cee7271 100644
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
