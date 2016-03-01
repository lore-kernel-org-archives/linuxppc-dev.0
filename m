Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A07EC1A074D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 15:27:56 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72C1F140324
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 15:27:56 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 1 Mar 2016 14:27:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 77B132BB0055
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 15:27:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u214Rgkd52166790
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 15:27:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u214RIDx029399
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 15:27:18 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u214RIqM028777
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 15:27:18 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 988C0A01E4
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 15:26:53 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: PMU libs: use signed long to read
 perf_event_paranoid
Date: Tue,  1 Mar 2016 15:26:36 +1100
Message-Id: <1456806396-27432-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpt from man 2 perf_event_open:

/proc/sys/kernel/perf_event_paranoid
  The perf_event_paranoid file can be set to restrict access to the
  performance counters.
    2 allow only user-space measurements.
    1 allow both kernel and user measurements (default).
    0 allow access to CPU-specific data but not raw tracepoint samples.
   -1 no restrictions.

require_paranoia_below() should return 0 if perf_event_paranoid is below a
specified level, the value from perf_event_paranoid is read into an
unsigned long so the incorrect value is returned when perf_event_paranoid
is set to -1.

Without this patch applied there is the same number of selftests/powerpc
which skip when /proc/sys/kernel/perf_event_paranoid is set to 1 or -1 but
no skips when set to zero.
With this patch applied there no skipped selftests/powerpc test when
/proc/sys/kernel/perf_event_paranoid is set to 0 or -1.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/pmu/lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index a361ad3..8b992fa 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -190,7 +190,7 @@ int parse_proc_maps(void)
 
 bool require_paranoia_below(int level)
 {
-	unsigned long current;
+	long current;
 	char *end, buf[16];
 	FILE *f;
 	int rc;
@@ -208,7 +208,7 @@ bool require_paranoia_below(int level)
 		goto out_close;
 	}
 
-	current = strtoul(buf, &end, 10);
+	current = strtol(buf, &end, 10);
 
 	if (end == buf) {
 		printf("Couldn't parse " PARANOID_PATH "?\n");
@@ -216,7 +216,7 @@ bool require_paranoia_below(int level)
 	}
 
 	if (current >= level)
-		goto out;
+		goto out_close;
 
 	rc = 0;
 out_close:
-- 
2.7.2
