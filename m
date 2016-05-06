Return-Path: <BATV+855daf51ec5a7c0bcd54+4639+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1CN34rx2zDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:29:55 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Mark Wielaard <mjw@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/17] perf powerpc: Fix kprobe and kretprobe handling with
 kallsyms on ppc64le
Date: Thu,  5 May 2016 21:29:37 -0300
Message-Id: <1462494580-27164-15-git-send-email-acme@kernel.org>
In-Reply-To: <1462494580-27164-1-git-send-email-acme@kernel.org>
References: <1462494580-27164-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

So far, we used to treat probe point offsets as being offset from the
LEP. However, userspace applications (objdump/readelf) always show
disassembly and offsets from the function GEP. This is confusing to the
user as we will end up probing at an address different from what the
user expects when looking at the function disassembly with
readelf/objdump. Fix this by changing how we modify probe address with
perf.

If only the function name is provided, we assume the user needs the LEP.
Otherwise, if an offset is specified, we assume that the user knows the
exact address to probe based on function disassembly, and so we just
place the probe from the GEP offset.

Finally, kretprobe was also broken with kallsyms as we were trying to
specify an offset. This patch also fixes that issue.

Reported-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: Mark Wielaard <mjw@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/75df860aad8216bf4b9bcd10c6351ecc0e3dee54.1460451721.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index bbc1a50768dd..6974ba0fa065 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -71,12 +71,21 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 			     struct probe_trace_event *tev, struct map *map)
 {
 	/*
-	 * ppc64 ABIv2 local entry point is currently always 2 instructions
-	 * (8 bytes) after the global entry point.
+	 * When probing at a function entry point, we normally always want the
+	 * LEP since that catches calls to the function through both the GEP and
+	 * the LEP. Hence, we would like to probe at an offset of 8 bytes if
+	 * the user only specified the function entry.
+	 *
+	 * However, if the user specifies an offset, we fall back to using the
+	 * GEP since all userspace applications (objdump/readelf) show function
+	 * disassembly with offsets from the GEP.
+	 *
+	 * In addition, we shouldn't specify an offset for kretprobes.
 	 */
-	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
-		tev->point.address += PPC64LE_LEP_OFFSET;
+	if (pev->point.offset || pev->point.retprobe || !map)
+		return;
+
+	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
 		tev->point.offset += PPC64LE_LEP_OFFSET;
-	}
 }
 #endif
-- 
2.5.5
