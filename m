Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTVzy0kD2zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 11:37:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	sam.bobroff@au1.ibm.com
Subject: [PATCH] selftests/powerpc: Fix TM resched DSCR test with some
 compilers
Date: Fri, 19 May 2017 11:37:45 +1000
Message-Id: <1495157865-12924-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The tm-resched-dscr test has started failing sometimes, depending on
what compiler it's built with, eg:

  test: tm_resched_dscr
  Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:76: test_body: Assertion `rv' failed.
  !! child died by signal 6

When it fails we see that the compiler doesn't initialise rv to 1 before
entering the inline asm block. Although that's counter intuitive, it
is allowed because we tell the compiler that the inline asm will write
to rv (using "=r"), meaning the original value is irrelevant.

Marking it as a read/write parameter would presumably work, but it seems
simpler to fix it by setting the initial value of rv in the inline asm.

Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
index d9c49f41515e..e79ccd6aada1 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -42,12 +42,12 @@ int test_body(void)
 	printf("Check DSCR TM context switch: ");
 	fflush(stdout);
 	for (;;) {
-		rv = 1;
 		asm __volatile__ (
 			/* set a known value into the DSCR */
 			"ld      3, %[dscr1];"
 			"mtspr   %[sprn_dscr], 3;"
 
+			"li      %[rv], 1;"
 			/* start and suspend a transaction */
 			"tbegin.;"
 			"beq     1f;"
-- 
2.7.4
