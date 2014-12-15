Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7CA31A019D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Dec 2014 00:51:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 32F702BB0067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:04 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBFEp4qc34472086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:04 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBFEp3uo004614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:03 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [PATCHv2 4/8] perf probe powerpc: Handle powerpc dot symbols
Date: Mon, 15 Dec 2014 20:20:34 +0530
Message-Id: <09c7f8741ea27aea8666f9d0e9caa828ff40fba9.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
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

Fix up various perf aspects related to ppc64's usage of dot functions:
- ignore leading '.' when generating event names and when looking for
  existing events.
- use the proper prefix when ignoring SyS symbol lookups.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 8 ++++++++
 tools/perf/util/symbol.c      | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 9943ff3..74b7fef 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2080,6 +2080,10 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 {
 	int i, ret;
 
+	/* Skip the leading dot on powerpc */
+	if (*base == '.')
+		base++;
+
 	/* Try no suffix */
 	ret = e_snprintf(buf, len, "%s", base);
 	if (ret < 0) {
@@ -2538,6 +2542,10 @@ int del_perf_probe_events(struct strlist *dellist)
 			event = str;
 		}
 
+		/* Skip the leading dot on powerpc */
+		if (event && *event == '.')
+			event++;
+
 		ret = e_snprintf(buf, 128, "%s:%s", group, event);
 		if (ret < 0) {
 			pr_err("Failed to copy event.");
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c24c5b8..e7b9bae 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -139,6 +139,12 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	if (na >= 10 && !strncmp(syma->name, "compat_SyS", 10))
 		return SYMBOL_B;
 
+	/* On powerpc, ignore the dot variants */
+	if (na >= 4 && !strncmp(syma->name, ".SyS", 4))
+		return SYMBOL_B;
+	if (na >= 11 && !strncmp(syma->name, ".compat_SyS", 11))
+		return SYMBOL_B;
+
 	return SYMBOL_A;
 }
 
-- 
2.1.3
