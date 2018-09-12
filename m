Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429YMk576qzF3Bh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 06:31:13 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CKTUH4012680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 16:31:11 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mf9amsfe4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 16:31:11 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 16:31:10 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: gromero@linux.vnet.ibm.com, Breno Leitao <leitao@debian.org>
Subject: [PATCH v2] selftests/powerpc: Do not fail with reschedule
Date: Wed, 12 Sep 2018 17:31:05 -0300
In-Reply-To: <3404db1f-cd5a-5ca1-0559-26d2ad08f410@linux.vnet.ibm.com>
References: <3404db1f-cd5a-5ca1-0559-26d2ad08f410@linux.vnet.ibm.com>
Message-Id: <1536784265-19806-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are cases where the test is not expecting to have the transaction
aborted, but, the test process might have been rescheduled, either in the
OS level or by KVM (if it is running on a KVM guest machine). The process
reschedule will cause a treclaim/recheckpoint which will cause the
transaction to doom, aborting the transaction as soon as the process is
rescheduled back to the CPU. This might cause the test to fail, but this is
not a failure in essence.

If that is the case, TEXASR[FC] is indicated with either
TM_CAUSE_RESCHEDULE or TM_CAUSE_KVM_RESCHEDULE for KVM interruptions.

In this scenario, ignore these two failures and avoid the whole test to
return failure.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Gustavo Romero <gromero@linux.ibm.com>
---
 tools/testing/selftests/powerpc/tm/tm-unavailable.c | 9 ++++++---
 tools/testing/selftests/powerpc/tm/tm.h             | 9 +++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
index 156c8e750259..09894f4ff62e 100644
--- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
+++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
@@ -236,7 +236,8 @@ void *tm_una_ping(void *input)
 	}
 
 	/* Check if we were not expecting a failure and a it occurred. */
-	if (!expecting_failure() && is_failure(cr_)) {
+	if (!expecting_failure() && is_failure(cr_) &&
+	    !failure_is_reschedule()) {
 		printf("\n\tUnexpected transaction failure 0x%02lx\n\t",
 			failure_code());
 		return (void *) -1;
@@ -244,9 +245,11 @@ void *tm_una_ping(void *input)
 
 	/*
 	 * Check if TM failed due to the cause we were expecting. 0xda is a
-	 * TM_CAUSE_FAC_UNAV cause, otherwise it's an unexpected cause.
+	 * TM_CAUSE_FAC_UNAV cause, otherwise it's an unexpected cause, unless
+	 * it was caused by a reschedule.
 	 */
-	if (is_failure(cr_) && !failure_is_unavailable()) {
+	if (is_failure(cr_) && !failure_is_unavailable() &&
+	    !failure_is_reschedule()) {
 		printf("\n\tUnexpected failure cause 0x%02lx\n\t",
 			failure_code());
 		return (void *) -1;
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index df4204247d45..5518b1d4ef8b 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -52,6 +52,15 @@ static inline bool failure_is_unavailable(void)
 	return (failure_code() & TM_CAUSE_FAC_UNAV) == TM_CAUSE_FAC_UNAV;
 }
 
+static inline bool failure_is_reschedule(void)
+{
+	if ((failure_code() & TM_CAUSE_RESCHED) == TM_CAUSE_RESCHED ||
+	    (failure_code() & TM_CAUSE_KVM_RESCHED) == TM_CAUSE_KVM_RESCHED)
+		return true;
+
+	return false;
+}
+
 static inline bool failure_is_nesting(void)
 {
 	return (__builtin_get_texasru() & 0x400000);
-- 
2.19.0
