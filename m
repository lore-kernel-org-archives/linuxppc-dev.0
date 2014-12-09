Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B1411A0BF8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 03:35:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CD3BC2CE8066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HZ69C22610068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:06 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HZ50t012246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:06 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [RFC PATCH 8/8] perf probe powerpc: Fixup function entry if using
 kallsyms lookup
Date: Tue,  9 Dec 2014 23:04:06 +0530
Message-Id: <e5bfde8d51546041e50699c4ed3bad8c3c1bf84f.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
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

On powerpc ABIv2, if no debug-info is found and we use kallsyms,
we need to fixup the function entry to point to the local entry point.
Use offset of 8 since current toolchains always generate 2
instructions (8 bytes).

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index adcdbd2..0970e2a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2318,6 +2318,15 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 		}
 		/* Add one probe point */
 		tp->address = map->unmap_ip(map, sym->start) + pp->offset;
+#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
+		/*
+		 * If we used kallsyms, we should fixup the function entry address here.
+		 * ppc64le ABIv2 local entry point is currently always 2 instructions (8 bytes)
+		 * after the global entry point. Fix this if it ever changes.
+		 */
+		if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
+			tp->address += 8;
+#endif
 		if (reloc_sym) {
 			tp->symbol = strdup_or_goto(reloc_sym->name, nomem_out);
 			tp->offset = tp->address - reloc_sym->addr;
-- 
2.1.3
