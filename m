Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11CBD1A0BEB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:22 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 12384E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:39:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC69aJ65929256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:10 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC67Dn004026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 1/7] perf probe: Improve detection of file/function name in
 the probe pattern
Date: Tue, 28 Apr 2015 17:35:34 +0530
Message-Id: <db680f7cb11c4452b632f908e67151f3aa0f4602.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, perf probe considers patterns including a '.' to be a file.
However, this causes problems on powerpc ABIv1 where all functions have
a leading '.':

  $ perf probe -F | grep schedule_timeout_interruptible
  .schedule_timeout_interruptible
  $ perf probe .schedule_timeout_interruptible
  Semantic error :File always requires line number or lazy pattern.
    Error: Command Parse Error.

Fix this:
- by checking the probe pattern in more detail, and
- skipping leading dot if one exists when creating/deleting events.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changes:
- Folded initial part of patch 04 [now 03] into this per Masami.
- Moved to using a bool file_spec and some whitespace changes.


 tools/perf/util/probe-event.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index d8bb616..a8c19d5 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1077,6 +1077,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	struct perf_probe_point *pp = &pev->point;
 	char *ptr, *tmp;
 	char c, nc = 0;
+	bool file_spec = false;
 	/*
 	 * <Syntax>
 	 * perf probe [EVENT=]SRC[:LN|;PTN]
@@ -1105,6 +1106,23 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		arg = tmp;
 	}
 
+	/*
+	 * Check arg is function or file name and copy it.
+	 *
+	 * We consider arg to be a file spec if and only if it satisfies
+	 * all of the below criteria::
+	 * - it does not include any of "+@%",
+	 * - it includes one of ":;", and
+	 * - it has a period '.' in the name.
+	 *
+	 * Otherwise, we consider arg to be a function specification.
+	 */
+	if (!strpbrk(arg, "+@%") && (ptr = strpbrk(arg, ";:")) != NULL) {
+		/* This is a file spec if it includes a '.' before ; or : */
+		if (memchr(arg, '.', ptr - arg))
+			file_spec = true;
+	}
+
 	ptr = strpbrk(arg, ";:+@%");
 	if (ptr) {
 		nc = *ptr;
@@ -1115,10 +1133,9 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	if (tmp == NULL)
 		return -ENOMEM;
 
-	/* Check arg is function or file and copy it */
-	if (strchr(tmp, '.'))	/* File */
+	if (file_spec)
 		pp->file = tmp;
-	else			/* Function */
+	else
 		pp->function = tmp;
 
 	/* Parse other options */
@@ -2265,6 +2282,9 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 {
 	int i, ret;
 
+	if (*base == '.')
+		base++;
+
 	/* Try no suffix */
 	ret = e_snprintf(buf, len, "%s", base);
 	if (ret < 0) {
@@ -2751,6 +2771,9 @@ int del_perf_probe_events(struct strlist *dellist)
 			event = str;
 		}
 
+		if (event && *event == '.')
+			event++;
+
 		ret = e_snprintf(buf, 128, "%s:%s", group, event);
 		if (ret < 0) {
 			pr_err("Failed to copy event.");
-- 
2.3.5
