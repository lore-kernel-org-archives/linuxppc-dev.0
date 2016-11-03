Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8XNM6XfrzDt31
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 15:41:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 1/2] selftests/powerpc: Abort load_unaligned_zeropad on
 unhandled SEGV
Date: Thu,  3 Nov 2016 15:41:00 +1100
Message-Id: <1478148061-5724-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the load unaligned zeropad test takes a SEGV which can't be handled,
we increment segv_error, print the offending NIP and then return without
taking any further action. In almost all cases this means we'll just
take the SEGV again, and loop eternally spamming the console.

Instead just abort(), it's a fatal error in the test. The test harness
will notice that the child died and print a nice message for us.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
index 6cae06117b55..cf7a4a114a90 100644
--- a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
+++ b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
@@ -73,7 +73,6 @@ extern char __stop___ex_table[];
 #error implement UCONTEXT_NIA
 #endif
 
-static int segv_error;
 
 static void segv_handler(int signr, siginfo_t *info, void *ptr)
 {
@@ -95,7 +94,7 @@ static void segv_handler(int signr, siginfo_t *info, void *ptr)
 	}
 
 	printf("No exception table match for NIA %lx ADDR %lx\n", *ip, addr);
-	segv_error++;
+	abort();
 }
 
 static void setup_segv_handler(void)
@@ -145,8 +144,6 @@ static int test_body(void)
 	for (i = 0; i < page_size; i++)
 		FAIL_IF(do_one_test(mem_region+i, i));
 
-	FAIL_IF(segv_error);
-
 	return 0;
 }
 
-- 
2.7.4
