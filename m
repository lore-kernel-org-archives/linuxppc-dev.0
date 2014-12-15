Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAE2C1A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Dec 2014 00:51:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0A9E13578060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBFEow5p24838232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:59 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBFEowGl004506
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:50:58 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [PATCHv2 2/8] perf probe: Improve detection of file/function name in
 the probe pattern
Date: Mon, 15 Dec 2014 20:20:32 +0530
Message-Id: <d60cf320bc3d51ca8980e48bc31044cacba8a920.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
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

Fix this by checking the probe pattern in more detail.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 28eb141..9943ff3 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -999,6 +999,24 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
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
+	c = 0;
+	if (!strpbrk(arg, "+@%") && (ptr = strpbrk(arg, ";:")) != NULL) {
+		/* This is a file spec if it includes a '.' before ; or : */
+		if (memchr(arg, '.', ptr-arg))
+			c = 1;
+	}
+
 	ptr = strpbrk(arg, ";:+@%");
 	if (ptr) {
 		nc = *ptr;
@@ -1009,10 +1027,9 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	if (tmp == NULL)
 		return -ENOMEM;
 
-	/* Check arg is function or file and copy it */
-	if (strchr(tmp, '.'))	/* File */
+	if (c == 1)
 		pp->file = tmp;
-	else			/* Function */
+	else
 		pp->function = tmp;
 
 	/* Parse other options */
-- 
2.1.3
