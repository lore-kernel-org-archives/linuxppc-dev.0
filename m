Return-Path: <BATV+db733a0251b4e1030805+4867+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjkfL0bZmzDwTb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 04:04:26 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chris Riyder <chris.ryder@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, stable@kernel.org,
 #@infradead.org, v4.9+@infradead.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/29] perf annotate: Don't throw error for zero length symbols
Date: Tue, 20 Dec 2016 14:03:52 -0300
Message-Id: <20161220170358.4350-24-acme@kernel.org>
In-Reply-To: <20161220170358.4350-1-acme@kernel.org>
References: <20161220170358.4350-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

'perf report --tui' exits with error when it finds a sample of zero
length symbol (i.e. addr == sym->start == sym->end). Actually these are
valid samples. Don't exit TUI and show report with such symbols.

Reported-and-Tested-by: Anton Blanchard <anton@samba.org>
Link: https://lkml.org/lkml/2016/10/8/189
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chris Riyder <chris.ryder@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@kernel.org # v4.9+
Link: http://lkml.kernel.org/r/1479804050-5028-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c81a3950a7fe..06cc04e5806a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -647,7 +647,8 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 
 	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map->unmap_ip(map, addr));
 
-	if (addr < sym->start || addr >= sym->end) {
+	if ((addr < sym->start || addr >= sym->end) &&
+	    (addr != sym->end || sym->start != sym->end)) {
 		pr_debug("%s(%d): ERANGE! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 "\n",
 		       __func__, __LINE__, sym->name, sym->start, addr, sym->end);
 		return -ERANGE;
-- 
2.9.3
