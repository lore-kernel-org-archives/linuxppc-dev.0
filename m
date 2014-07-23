Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3B651A046A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:45 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 08/10] selftests/powerpc: Add cycles test with MMCR2 handling
Date: Wed, 23 Jul 2014 17:31:38 +1000
Message-Id: <1406100700-9702-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |  3 +-
 .../powerpc/pmu/ebb/cycles_with_mmcr2_test.c       | 91 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 251447eafe49..3dc4332698cb 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -13,7 +13,8 @@ PROGS := reg_access_test event_attributes_test cycles_test	\
 	 close_clears_pmcc_test instruction_count_test		\
 	 fork_cleanup_test ebb_on_child_test			\
 	 ebb_on_willing_child_test back_to_back_ebbs_test	\
-	 lost_exception_test no_handler_test
+	 lost_exception_test no_handler_test			\
+	 cycles_with_mmcr2_test
 
 all: $(PROGS)
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
new file mode 100644
index 000000000000..d43029b0800c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test of counting cycles while manipulating the user accessible bits in MMCR2.
+ */
+
+/* We use two values because the first freezes PMC1 and so we would get no EBBs */
+#define MMCR2_EXPECTED_1 0x4020100804020000UL /* (FC1P|FC2P|FC3P|FC4P|FC5P|FC6P) */
+#define MMCR2_EXPECTED_2 0x0020100804020000UL /* (     FC2P|FC3P|FC4P|FC5P|FC6P) */
+
+
+int cycles_with_mmcr2(void)
+{
+	struct event event;
+	uint64_t val, expected[2], actual;
+	int i;
+	bool bad_mmcr2;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	/* XXX Set of MMCR2 must be after enable */
+	expected[0] = MMCR2_EXPECTED_1;
+	expected[1] = MMCR2_EXPECTED_2;
+	i = 0;
+	bad_mmcr2 = false;
+
+	/* Make sure we loop until we take at least one EBB */
+	while ((ebb_state.stats.ebb_count < 20 && !bad_mmcr2) ||
+		ebb_state.stats.ebb_count < 1)
+	{
+		mtspr(SPRN_MMCR2, expected[i % 2]);
+
+		FAIL_IF(core_busy_loop());
+
+		val = mfspr(SPRN_MMCR2);
+		if (val != expected[i % 2]) {
+			bad_mmcr2 = true;
+			actual = val;
+		}
+
+		i++;
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	if (bad_mmcr2)
+		printf("Bad MMCR2 value seen is 0x%lx\n", actual);
+
+	FAIL_IF(bad_mmcr2);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(cycles_with_mmcr2, "cycles_with_mmcr2");
+}
-- 
1.9.1
