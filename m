Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAF3B1A04EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 03:35:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7E0103578062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HYxa841877600
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HYwqk012042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:34:59 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [RFC PATCH 5/8] perf probe powerpc: Allow matching against dot symbols
Date: Tue,  9 Dec 2014 23:04:03 +0530
Message-Id: <d23252a0bb8a34b2eac9049b34d674aa2d6a2b6a.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow perf probe to work on powerpc ABIv1 without the need to specify the
leading dot '.' for functions. 'perf probe do_fork' works with this patch.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index d465f7c..174c22e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2221,6 +2221,15 @@ static int probe_function_filter(struct map *map __maybe_unused,
 		num_matched_functions++;
 		return 0;
 	}
+#ifdef __powerpc64__
+	/* Allow matching against the dot variant */
+	if (sym->name[0] == '.' && looking_function_name[0] != '.' &&
+	    (sym->binding == STB_GLOBAL || sym->binding == STB_LOCAL) &&
+	    strcmp(looking_function_name, sym->name+1) == 0) {
+		num_matched_functions++;
+		return 0;
+	}
+#endif
 	return 1;
 }
 
-- 
2.1.3
