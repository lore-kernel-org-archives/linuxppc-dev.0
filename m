Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g7yH1zYPzF18B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 06:56:06 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VKmigW146170
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 16:56:04 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjwedmaad-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 16:56:03 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 31 Jul 2018 14:56:03 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, rashmicy@gmail.com, Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/selftests: Wait all threads to join
Date: Tue, 31 Jul 2018 17:55:57 -0300
Message-Id: <1533070557-24432-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test tm-tmspr might exit before all threads stop executing, because it just
waits for the very last thread to join before proceeding/exiting.

This patch makes sure that all threads that were created will join before
proceeding/exiting.

This patch also guarantees that the amount of threads being created is equal
to thread_num.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
index 2bda81c7bf23..df1d7d4b1c89 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -98,7 +98,7 @@ void texasr(void *in)
 
 int test_tmspr()
 {
-	pthread_t 	thread;
+	pthread_t	*thread;
 	int	   	thread_num;
 	unsigned long	i;
 
@@ -107,21 +107,28 @@ int test_tmspr()
 	/* To cause some context switching */
 	thread_num = 10 * sysconf(_SC_NPROCESSORS_ONLN);
 
+	thread = malloc(thread_num * sizeof(pthread_t));
+	if (thread == NULL)
+		return EXIT_FAILURE;
+
 	/* Test TFIAR and TFHAR */
-	for (i = 0 ; i < thread_num ; i += 2){
-		if (pthread_create(&thread, NULL, (void*)tfiar_tfhar, (void *)i))
+	for (i = 0; i < thread_num; i += 2) {
+		if (pthread_create(&thread[i], NULL, (void *)tfiar_tfhar,
+				   (void *)i))
 			return EXIT_FAILURE;
 	}
-	if (pthread_join(thread, NULL) != 0)
-		return EXIT_FAILURE;
-
 	/* Test TEXASR */
-	for (i = 0 ; i < thread_num ; i++){
-		if (pthread_create(&thread, NULL, (void*)texasr, (void *)i))
+	for (i = 1; i < thread_num; i += 2) {
+		if (pthread_create(&thread[i], NULL, (void *)texasr, (void *)i))
 			return EXIT_FAILURE;
 	}
-	if (pthread_join(thread, NULL) != 0)
-		return EXIT_FAILURE;
+
+	for (i = 0; i < thread_num; i++) {
+		if (pthread_join(thread[i], NULL) != 0)
+			return EXIT_FAILURE;
+	}
+
+	free(thread);
 
 	if (passed)
 		return 0;
-- 
2.16.3
