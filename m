Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkpxX68XrzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:20:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] selftests/powerpc: Use "Delta" rather than "Error" in normal
 output
Date: Wed,  6 Jul 2016 15:18:55 +1000
Message-Id: <1467782335-18758-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use "Delta" to refer to the difference between measurements, rather than
"Error", so scripts that look for "Error" aren't confused into thinking
there was a failure.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
index 5da355135df2..ae9a79086111 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
@@ -51,7 +51,7 @@ static int do_count_loop(struct event *event, uint64_t instructions,
 		printf("Looped for %lu instructions, overhead %lu\n", instructions, overhead);
 		printf("Expected %lu\n", expected);
 		printf("Actual   %llu\n", event->result.value);
-		printf("Error    %ld, %f%%\n", difference, percentage);
+		printf("Delta    %ld, %f%%\n", difference, percentage);
 		printf("Took %d EBBs\n", ebb_state.stats.ebb_count);
 	}
 
-- 
2.7.4
