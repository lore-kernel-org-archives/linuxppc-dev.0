Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB2F91A0BE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:08:06 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 81877140D86
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 10:08:06 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 4 Mar 2016 09:08:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2F1092BB0054
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 10:08:02 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23N7sVb3539340
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:08:02 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23N7UAB016451
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:07:30 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u23N7TUM015991
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2016 10:07:30 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B620DA01E4
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 10:07:05 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] selftests/powerpc: benchmarks/context_switch.c use vector
 instructions/types
Date: Fri,  4 Mar 2016 10:06:40 +1100
Message-Id: <1457046400-29276-2-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1457046400-29276-1-git-send-email-cyrilbur@gmail.com>
References: <1457046400-29276-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently it doesn't appear the resulting binary actually uses any Altivec
or VSX instructions the solution is to explicitly tell GCC to use vector
instructions and use vector types in the code.

Part of this this issue can be GCC version specific:

GCC 4.9.x is happy to use Altivec and VSX instructions if altivec.h is
includedi (and possibly if vector types are used), this also means that
4.9.x will use VSX instructions even if only -maltivec is passed. It is
also possible that Altivec instructions will be used even without -maltivec
or -mabi=altivec.

GCC 5.2.x complains about the lack of -maltivec parameter if altivec.h is
included and will not use VSX unless -mvsx is present on commandline.

GCC 5.3.0 has a regression that means __attribute__((__target__("no-vsx"))
fails to build. A fix is targeted for 5.4.

Furthermore LTO (Link Time Optimisation) doesn't play well with
__attribute__((__target__("no-vsx")), LTO can cause GCC to forget about the
attribute and compile with VSX instructions regardless. Be weary when
enabling -flfo for this test.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/benchmarks/Makefile         |  1 +
 tools/testing/selftests/powerpc/benchmarks/context_switch.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index 912445f..6816fc2 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -7,6 +7,7 @@ all: $(TEST_PROGS)
 $(TEST_PROGS): ../harness.c
 
 context_switch: ../utils.c
+context_switch: CFLAGS += -maltivec -mvsx -mabi=altivec
 context_switch: LDLIBS += -lpthread
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index e6af382..a36883a 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -25,7 +25,9 @@
 #include <sys/types.h>
 #include <sys/shm.h>
 #include <linux/futex.h>
-
+#ifdef __powerpc__
+#include <altivec.h>
+#endif
 #include "../utils.h"
 
 static unsigned int timeout = 30;
@@ -37,12 +39,15 @@ static int touch_fp = 1;
 double fp;
 
 static int touch_vector = 1;
-typedef int v4si __attribute__ ((vector_size (16)));
-v4si a, b, c;
+vector int a, b, c;
 
 #ifdef __powerpc__
 static int touch_altivec = 1;
 
+/*
+ * Note: LTO (Link Time Optimisation) doesn't play well with this function
+ * attribute. Be very careful enabling LTO for this test.
+ */
 static void __attribute__((__target__("no-vsx"))) altivec_touch_fn(void)
 {
 	c = a + b;
-- 
2.7.2
