Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCt3wprzDrHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:06 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0IpJP038752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g88ybg7mk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:03 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:01 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 04/12] selftests/powerpc: Use less common thread names
Date: Tue, 20 Feb 2018 11:22:33 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-5-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"ping" and "pong" (in particular "ping") are common names. If a
selftests causes a kernel BUG_ON or any kind of backtrace the process
name is displayed. Setting a more unique name avoids confusion as to
which process caused the problem.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-unavailable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
index e6a0fad2bfd0..bcfa8add5748 100644
--- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
+++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
@@ -315,7 +315,7 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
 		rc = pthread_create(&t0, attr, ping, (void *) &flags);
 		if (rc)
 			pr_err(rc, "pthread_create()");
-		rc = pthread_setname_np(t0, "ping");
+		rc = pthread_setname_np(t0, "tm-unavailable-ping");
 		if (rc)
 			pr_warn(rc, "pthread_setname_np");
 		rc = pthread_join(t0, &ret_value);
@@ -359,7 +359,7 @@ int main(int argc, char **argv)
 		pr_err(rc, "pthread_create()");
 
 	/* Name it for systemtap convenience */
-	rc = pthread_setname_np(t1, "pong");
+	rc = pthread_setname_np(t1, "tm-unavailable-pong");
 	if (rc)
 		pr_warn(rc, "pthread_create()");
 
-- 
2.16.2
