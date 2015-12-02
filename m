Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D36E1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 20:44:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH 4/4] selftests/powerpc: Make context_switch touch
 FP/altivec/vector by default
Date: Wed,  2 Dec 2015 20:44:11 +1100
Message-Id: <1449049451-31373-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1449049451-31373-1-git-send-email-mpe@ellerman.id.au>
References: <1449049451-31373-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simply because it touches more code paths that way, and therefore tests
more things.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Anton Blanchard <anton@samba.org>
---
 tools/testing/selftests/powerpc/benchmarks/context_switch.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index d8b6d10f36a6..7b785941adec 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -33,15 +33,15 @@ static unsigned int timeout = 30;
 static int touch_vdso;
 struct timeval tv;
 
-static int touch_fp;
+static int touch_fp = 1;
 double fp;
 
-static int touch_vector;
+static int touch_vector = 1;
 typedef int v4si __attribute__ ((vector_size (16)));
 v4si a, b, c;
 
 #ifdef __powerpc__
-static int touch_altivec;
+static int touch_altivec = 1;
 
 static void __attribute__((__target__("no-vsx"))) altivec_touch_fn(void)
 {
@@ -354,11 +354,11 @@ static struct option options[] = {
 	{ "process", no_argument, &processes, 1 },
 	{ "timeout", required_argument, 0, 's' },
 	{ "vdso", no_argument, &touch_vdso, 1 },
-	{ "fp", no_argument, &touch_fp, 1 },
+	{ "no-fp", no_argument, &touch_fp, 0 },
 #ifdef __powerpc__
-	{ "altivec", no_argument, &touch_altivec, 1 },
+	{ "no-altivec", no_argument, &touch_altivec, 0 },
 #endif
-	{ "vector", no_argument, &touch_vector, 1 },
+	{ "no-vector", no_argument, &touch_vector, 0 },
 	{ 0, },
 };
 
-- 
2.5.0
