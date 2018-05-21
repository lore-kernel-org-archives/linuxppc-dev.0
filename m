Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDTR1WdhzF12T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 19:47:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Update paca fields dumped in xmon
Date: Mon, 21 May 2018 19:47:20 +1000
Message-Id: <20180521094720.15338-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The set of paca fields we dump in xmon has gotten somewhat out of
date. Update to add some recently added fields.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 94cc8ba36c14..a2cbf0caa1f7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2425,6 +2425,16 @@ static void dump_one_paca(int cpu)
 	DUMP(p, thread_idle_state, "x");
 	DUMP(p, thread_mask, "x");
 	DUMP(p, subcore_sibling_mask, "x");
+	DUMP(p, thread_sibling_pacas, "px");
+	DUMP(p, requested_psscr, "llx");
+	DUMP(p, stop_sprs.pid, "llx");
+	DUMP(p, stop_sprs.ldbar, "llx");
+	DUMP(p, stop_sprs.fscr, "llx");
+	DUMP(p, stop_sprs.hfscr, "llx");
+	DUMP(p, stop_sprs.mmcr1, "llx");
+	DUMP(p, stop_sprs.mmcr2, "llx");
+	DUMP(p, stop_sprs.mmcra, "llx");
+	DUMP(p, dont_stop, "x");
 #endif
 
 	DUMP(p, accounting.utime, "llx");
-- 
2.14.1
