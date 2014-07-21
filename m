Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B85E71A018B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:34:49 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] selftests/powerpc: Count more instructions
Date: Mon, 21 Jul 2014 14:34:41 +1000
Message-Id: <1405917282-31599-2-git-send-email-mpe@ellerman.id.au>
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

Although we expect some small discrepancies for very large counts, we
seem to be able to count up to 64G instructions without too much skew, so
do so.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/count_instructions.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/powerpc/pmu/count_instructions.c b/tools/testing/selftests/powerpc/pmu/count_instructions.c
index 5e241e14f204..56572f0b1eb2 100644
--- a/tools/testing/selftests/powerpc/pmu/count_instructions.c
+++ b/tools/testing/selftests/powerpc/pmu/count_instructions.c
@@ -124,6 +124,12 @@ static int test_body(void)
 	/* Run for 1G instructions */
 	FAIL_IF(do_count_loop(events, 0x40000000, overhead, true));
 
+	/* Run for 16G instructions */
+	FAIL_IF(do_count_loop(events, 0x400000000, overhead, true));
+
+	/* Run for 64G instructions */
+	FAIL_IF(do_count_loop(events, 0x1000000000, overhead, true));
+
 	event_close(&events[0]);
 	event_close(&events[1]);
 
-- 
1.9.1
