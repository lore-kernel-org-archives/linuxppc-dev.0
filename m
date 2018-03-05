Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwBqQ3L7FzDsGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 07:49:54 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25KhvED046557
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 15:49:52 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghbw037u8-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 15:49:51 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Mon, 5 Mar 2018 13:49:51 -0700
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gromero@linux.vnet.ibm.com, mpe@ellerman.id.au, cyrilbur@gmail.com
Subject: [PATCH] selftests/powerpc: Skip tm-unavailable if TM is not enabled
Date: Mon,  5 Mar 2018 15:48:55 -0500
In-Reply-To: <1520282935-20111-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1520282935-20111-1-git-send-email-gromero@linux.vnet.ibm.com>
Message-Id: <1520282935-20111-2-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some processor revisions do not support transactional memory, and
additionally kernel support can be disabled. In either case the
tm-unavailable test should be skipped, otherwise it will fail with
a SIGILL.

That commit also sets this selftest to be called through the test
harness as it's done for other TM selftests.

Finally, it avoids using "ping" as a thread name since it's
ambiguous and can be confusing when shown, for instance,
in a kernel backtrace log.

Fixes: 77fad8bfb1d2 ("selftests/powerpc: Check FP/VEC on exception in TM")
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 .../testing/selftests/powerpc/tm/tm-unavailable.c  | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
index e6a0fad..156c8e7 100644
--- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
+++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
@@ -80,7 +80,7 @@ bool is_failure(uint64_t condition_reg)
 	return ((condition_reg >> 28) & 0xa) == 0xa;
 }
 
-void *ping(void *input)
+void *tm_una_ping(void *input)
 {
 
 	/*
@@ -280,7 +280,7 @@ void *ping(void *input)
 }
 
 /* Thread to force context switch */
-void *pong(void *not_used)
+void *tm_una_pong(void *not_used)
 {
 	/* Wait thread get its name "pong". */
 	if (DEBUG)
@@ -311,11 +311,11 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
 	do {
 		int rc;
 
-		/* Bind 'ping' to CPU 0, as specified in 'attr'. */
-		rc = pthread_create(&t0, attr, ping, (void *) &flags);
+		/* Bind to CPU 0, as specified in 'attr'. */
+		rc = pthread_create(&t0, attr, tm_una_ping, (void *) &flags);
 		if (rc)
 			pr_err(rc, "pthread_create()");
-		rc = pthread_setname_np(t0, "ping");
+		rc = pthread_setname_np(t0, "tm_una_ping");
 		if (rc)
 			pr_warn(rc, "pthread_setname_np");
 		rc = pthread_join(t0, &ret_value);
@@ -333,13 +333,15 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
 	}
 }
 
-int main(int argc, char **argv)
+int tm_unavailable_test(void)
 {
 	int rc, exception; /* FP = 0, VEC = 1, VSX = 2 */
 	pthread_t t1;
 	pthread_attr_t attr;
 	cpu_set_t cpuset;
 
+	SKIP_IF(!have_htm());
+
 	/* Set only CPU 0 in the mask. Both threads will be bound to CPU 0. */
 	CPU_ZERO(&cpuset);
 	CPU_SET(0, &cpuset);
@@ -354,12 +356,12 @@ int main(int argc, char **argv)
 	if (rc)
 		pr_err(rc, "pthread_attr_setaffinity_np()");
 
-	rc = pthread_create(&t1, &attr /* Bind 'pong' to CPU 0 */, pong, NULL);
+	rc = pthread_create(&t1, &attr /* Bind to CPU 0 */, tm_una_pong, NULL);
 	if (rc)
 		pr_err(rc, "pthread_create()");
 
 	/* Name it for systemtap convenience */
-	rc = pthread_setname_np(t1, "pong");
+	rc = pthread_setname_np(t1, "tm_una_pong");
 	if (rc)
 		pr_warn(rc, "pthread_create()");
 
@@ -394,3 +396,9 @@ int main(int argc, char **argv)
 		exit(0);
 	}
 }
+
+int main(int argc, char **argv)
+{
+	test_harness_set_timeout(220);
+	return test_harness(tm_unavailable_test, "tm_unavailable_test");
+}
-- 
2.7.4
