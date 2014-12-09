Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79E321A0622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 03:35:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 554AB3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:04 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HZ43V41746564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:04 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HZ35O012205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:04 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [RFC PATCH 7/8] perf probe powerpc: Use DWARF info only if necessary
Date: Tue,  9 Dec 2014 23:04:05 +0530
Message-Id: <50dd0fedb50e3a56ff8f25c44098db3e2a2d6374.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
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

Use symbol table lookups by default if DWARF is not necessary, since
powerpc ABIv2 encodes local entry points in the symbol table and the
function entry address in DWARF may not be appropriate for kprobes,
as described here:
https://sourceware.org/bugzilla/show_bug.cgi?id=17638

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 174c22e..adcdbd2 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2382,6 +2382,14 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
 		}
 	}
 
+#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
+	if (!perf_probe_event_need_dwarf(pev)) {
+		ret = find_probe_trace_events_from_map(pev, tevs, max_tevs, target);
+		if (ret > 0)
+			return ret;	/* Found in symbol table */
+	}
+#endif
+
 	/* Convert perf_probe_event with debuginfo */
 	ret = try_to_find_probe_trace_events(pev, tevs, max_tevs, target);
 	if (ret != 0)
-- 
2.1.3
