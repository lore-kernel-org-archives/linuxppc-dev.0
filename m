Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkh6j0C7QzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:13:01 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 12 Apr 2016 19:12:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9179B2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3C9CYEx55378074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3C9C99b012780
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 19:12:10 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Mark Wielaard <mjw@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 1/2] perf tools: Fix kprobe and kretprobe handling with
 kallsyms on ppc64le
Date: Tue, 12 Apr 2016 14:40:49 +0530
Message-Id: <75df860aad8216bf4b9bcd10c6351ecc0e3dee54.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1460451721.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Cc: Mark Wielaard <mjw@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>
Reported-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2: Removed un-necessary check for uprobes

 tools/perf/arch/powerpc/util/sym-handling.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index bbc1a50..6974ba0 100644
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
2.7.4
