Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41brrz6XKVzF0f7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 22:25:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] selftests/powerpc: Give some tests longer to run
Date: Thu, 26 Jul 2018 22:24:59 +1000
Message-Id: <20180726122459.9293-3-mpe@ellerman.id.au>
In-Reply-To: <20180726122459.9293-1-mpe@ellerman.id.au>
References: <20180726122459.9293-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of these long running tests can time out on heavily loaded
systems, give them longer to run.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/benchmarks/futex_bench.c         | 1 +
 tools/testing/selftests/powerpc/benchmarks/mmap_bench.c          | 2 ++
 tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c | 1 +
 tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c    | 1 +
 tools/testing/selftests/powerpc/stringloops/memcmp.c             | 1 +
 5 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/powerpc/benchmarks/futex_bench.c b/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
index 2fc711d9150d..d58e4dc50fcd 100644
--- a/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
+++ b/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
@@ -38,5 +38,6 @@ int test_futex(void)
 
 int main(void)
 {
+	test_harness_set_timeout(300);
 	return test_harness(test_futex, "futex_bench");
 }
diff --git a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
index 7a0a462a2272..033de0560d99 100644
--- a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
+++ b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
@@ -84,5 +84,7 @@ int main(int argc, char *argv[])
 			exit(1);
 		}
 	}
+
+	test_harness_set_timeout(300);
 	return test_harness(test_mmap, "mmap_bench");
 }
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
index ae9a79086111..35a3426e341c 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
@@ -162,5 +162,6 @@ int instruction_count(void)
 
 int main(void)
 {
+	test_harness_set_timeout(300);
 	return test_harness(instruction_count, "instruction_count");
 }
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
index eb8acb78bc6c..2ed7ad33f7a3 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
@@ -98,5 +98,6 @@ static int lost_exception(void)
 
 int main(void)
 {
+	test_harness_set_timeout(300);
 	return test_harness(lost_exception, "lost_exception");
 }
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
index b5cf71727b2d..b1fa7546957f 100644
--- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
@@ -154,5 +154,6 @@ static int testcases(void)
 
 int main(void)
 {
+	test_harness_set_timeout(300);
 	return test_harness(testcases, "memcmp");
 }
-- 
2.14.1
