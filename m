Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C71D2C0082
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2013 12:30:35 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 18 Jan 2013 18:30:32 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6DC3DC40003
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 18:30:18 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0J1USRB153218
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 18:30:28 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0J1URrZ014647
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 18:30:28 -0700
Date: Fri, 18 Jan 2013 17:30:52 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: acme@ghostprotocols.net, Anton Blanchard <anton@au1.ibm.com>,
 paulus@samba.org
Subject: [PATCH] perf: Fix compile warnings in tests/attr.c
Message-ID: <20130119013052.GA24693@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 4d266e5040c33103f5d226b0d16b89f8ef79e3ad Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 18 Jan 2013 11:14:28 -0800
Subject: [PATCH] perf: Fix compile warnings in tests/attr.c

Replace '%llu' in printf()s with 'PRIu64' in 'tools/perf/tests/attr.c'
to fix compile warnings (which become errors due to -Werror).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index f61dd3f..5cbb2b3 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -65,7 +65,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	FILE *file;
 	char path[PATH_MAX];
 
-	snprintf(path, PATH_MAX, "%s/event-%d-%llu-%d", dir,
+	snprintf(path, PATH_MAX, "%s/event-%d-%" PRIu64 "-%d", dir,
 		 attr->type, attr->config, fd);
 
 	file = fopen(path, "w+");
@@ -74,7 +74,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 		return -1;
 	}
 
-	if (fprintf(file, "[event-%d-%llu-%d]\n",
+	if (fprintf(file, "[event-%d-%" PRIu64 "-%d]\n",
 		    attr->type, attr->config, fd) < 0) {
 		perror("test attr - failed to write event file");
 		fclose(file);
@@ -91,10 +91,10 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	/* struct perf_event_attr */
 	WRITE_ASS(type,   PRIu32);
 	WRITE_ASS(size,   PRIu32);
-	WRITE_ASS(config,  "llu");
-	WRITE_ASS(sample_period, "llu");
-	WRITE_ASS(sample_type,   "llu");
-	WRITE_ASS(read_format,   "llu");
+	WRITE_ASS(config,  PRIu64);
+	WRITE_ASS(sample_period, PRIu64);
+	WRITE_ASS(sample_type,   PRIu64);
+	WRITE_ASS(read_format,   PRIu64);
 	WRITE_ASS(disabled,       "d");
 	WRITE_ASS(inherit,        "d");
 	WRITE_ASS(pinned,         "d");
@@ -119,10 +119,10 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	WRITE_ASS(exclude_callchain_user, "d");
 	WRITE_ASS(wakeup_events, PRIu32);
 	WRITE_ASS(bp_type, PRIu32);
-	WRITE_ASS(config1, "llu");
-	WRITE_ASS(config2, "llu");
-	WRITE_ASS(branch_sample_type, "llu");
-	WRITE_ASS(sample_regs_user,   "llu");
+	WRITE_ASS(config1, PRIu64);
+	WRITE_ASS(config2, PRIu64);
+	WRITE_ASS(branch_sample_type, PRIu64);
+	WRITE_ASS(sample_regs_user,   PRIu64);
 	WRITE_ASS(sample_stack_user,  PRIu32);
 
 	fclose(file);
-- 
1.7.1
