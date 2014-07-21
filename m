Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA3BB1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:34:50 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] selftests/powerpc: Count decimal numbers of instructions
Date: Mon, 21 Jul 2014 14:34:42 +1000
Message-Id: <1405917282-31599-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1405917282-31599-1-git-send-email-mpe@ellerman.id.au>
References: <1405917282-31599-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This just makes it easier to visually compare the expected vs actual
values, as well as the raw result from instructions.

Before:

  instructions: result 68719476753 running/enabled 13101961654
  cycles: result 38077343785 running/enabled 13101725752
  Looped for 68719476736 instructions, overhead 17
  Expected 68719476753
  Actual   68719476753
  Delta    0, 0.000000%
  success: count_instructions

After:
  instructions: result 64000000016 running/enabled 12197599964
  cycles: result 35412471674 running/enabled 12197534110
  Looped for 64000000000 instructions, overhead 16
  Expected 64000000016
  Actual   64000000016
  Delta    0, 0.000000%
  success: count_instructions

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/pmu/count_instructions.c     | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/count_instructions.c b/tools/testing/selftests/powerpc/pmu/count_instructions.c
index 56572f0b1eb2..4622117b24c0 100644
--- a/tools/testing/selftests/powerpc/pmu/count_instructions.c
+++ b/tools/testing/selftests/powerpc/pmu/count_instructions.c
@@ -112,23 +112,23 @@ static int test_body(void)
 	overhead = determine_overhead(events);
 	printf("Overhead of null loop: %llu instructions\n", overhead);
 
-	/* Run for 1M instructions */
-	FAIL_IF(do_count_loop(events, 0x100000, overhead, true));
+	/* Run for 1Mi instructions */
+	FAIL_IF(do_count_loop(events, 1000000, overhead, true));
 
-	/* Run for 10M instructions */
-	FAIL_IF(do_count_loop(events, 0xa00000, overhead, true));
+	/* Run for 10Mi instructions */
+	FAIL_IF(do_count_loop(events, 10000000, overhead, true));
 
-	/* Run for 100M instructions */
-	FAIL_IF(do_count_loop(events, 0x6400000, overhead, true));
+	/* Run for 100Mi instructions */
+	FAIL_IF(do_count_loop(events, 100000000, overhead, true));
 
-	/* Run for 1G instructions */
-	FAIL_IF(do_count_loop(events, 0x40000000, overhead, true));
+	/* Run for 1Bi instructions */
+	FAIL_IF(do_count_loop(events, 1000000000, overhead, true));
 
-	/* Run for 16G instructions */
-	FAIL_IF(do_count_loop(events, 0x400000000, overhead, true));
+	/* Run for 16Bi instructions */
+	FAIL_IF(do_count_loop(events, 16000000000, overhead, true));
 
-	/* Run for 64G instructions */
-	FAIL_IF(do_count_loop(events, 0x1000000000, overhead, true));
+	/* Run for 64Bi instructions */
+	FAIL_IF(do_count_loop(events, 64000000000, overhead, true));
 
 	event_close(&events[0]);
 	event_close(&events[1]);
-- 
1.9.1
