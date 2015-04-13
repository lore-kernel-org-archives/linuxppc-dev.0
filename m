Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF4061A091B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 07:51:04 +1000 (AEST)
Date: Tue, 14 Apr 2015 07:51:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 stewart@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Cap 64bit userspace backtraces to
 PERF_MAX_STACK_DEPTH
Message-ID: <20150414075103.265073a6@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We cap 32bit userspace backtraces to PERF_MAX_STACK_DEPTH
(currently 127), but we forgot to do the same for 64bit backtraces.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/perf/callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 2396dda..ead5535 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -243,7 +243,7 @@ static void perf_callchain_user_64(struct perf_callchain_entry *entry,
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
 
-	for (;;) {
+	while (entry->nr < PERF_MAX_STACK_DEPTH) {
 		fp = (unsigned long __user *) sp;
 		if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
 			return;
-- 
2.1.0
