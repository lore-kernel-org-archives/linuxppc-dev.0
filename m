Return-Path: <BATV+578e219acb784a2ea3b2+4271+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48BB91A099E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:36:59 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 12/21] perf probe: Improve detection of file/function name in
 the probe pattern
Date: Mon,  4 May 2015 18:36:21 -0300
Message-Id: <1430775390-22523-13-git-send-email-acme@kernel.org>
In-Reply-To: <1430775390-22523-1-git-send-email-acme@kernel.org>
References: <1430775390-22523-1-git-send-email-acme@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

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
Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/db680f7cb11c4452b632f908e67151f3aa0f4602.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index eb75a5e..416c10f 100644
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
@@ -2766,6 +2786,9 @@ int del_perf_probe_events(struct strlist *dellist)
 			event = str;
 		}
 
+		if (event && *event == '.')
+			event++;
+
 		ret = e_snprintf(buf, 128, "%s:%s", group, event);
 		if (ret < 0) {
 			pr_err("Failed to copy event.");
-- 
2.1.0
