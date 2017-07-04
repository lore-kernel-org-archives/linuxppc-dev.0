Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1mSL16WHzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 11:21:53 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v641IVBB038269
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 21:21:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bfc04399g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 21:21:51 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 4 Jul 2017 11:21:49 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v641Lld42359610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 11:21:47 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v641LcMJ031256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 11:21:38 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v641LcmB031253
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 11:21:38 +1000
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 78184A01C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 11:21:46 +1000 (AEST)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: context_switch: Fix pthread errors
Date: Tue,  4 Jul 2017 11:21:15 +1000
Message-Id: <20170704012115.30870-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Turns out pthreads returns an errno and doesn't set errno. This doesn't
play well with perror().

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 .../selftests/powerpc/benchmarks/context_switch.c        | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index 778f5fbfd784..7486e532d3e2 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -75,6 +75,7 @@ static void touch(void)
 
 static void start_thread_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 {
+	int rc;
 	pthread_t tid;
 	cpu_set_t cpuset;
 	pthread_attr_t attr;
@@ -82,14 +83,23 @@ static void start_thread_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 	CPU_ZERO(&cpuset);
 	CPU_SET(cpu, &cpuset);
 
-	pthread_attr_init(&attr);
+	rc = pthread_attr_init(&attr);
+	if (rc) {
+		errno = rc;
+		perror("pthread_attr_init");
+		exit(1);
+	}
 
-	if (pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset)) {
+	rc = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
+	if (rc)	{
+		errno = rc;
 		perror("pthread_attr_setaffinity_np");
 		exit(1);
 	}
 
-	if (pthread_create(&tid, &attr, fn, arg)) {
+	rc = pthread_create(&tid, &attr, fn, arg);
+	if (rc) {
+		errno = rc;
 		perror("pthread_create");
 		exit(1);
 	}
-- 
2.13.2
