Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Q7Tf1b7XzF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 11:49:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: maddy@linux.ibm.com
Subject: [PATCH] powerpc/64s: Default l1d_size to 64K in RFI fallback flush
Date: Tue, 17 Apr 2018 11:49:20 +1000
Message-Id: <20180417014920.21450-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

If there is no d-cache-size property in the device tree, l1d_size could
be zero. We don't actually expect that to happen, it's only been seen
on mambo (simulator) in some configurations.

A zero-size l1d_size leads to the loop in the asm wrapping around to
2^64-1, and then walking off the end of the fallback area and
eventually causing a page fault which is fatal.

Just default to 64K which is correct on some CPUs, and sane enough to
not cause a crash on others.

Fixes: aa8a5e0062ac9 ('powerpc/64s: Add support for RFI flush of L1-D cache')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
[mpe: Rewrite comment and change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44c30dd38067..b78f142a4148 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -890,6 +890,17 @@ static void __ref init_fallback_flush(void)
 		return;
 
 	l1d_size = ppc64_caches.l1d.size;
+
+	/*
+	 * If there is no d-cache-size property in the device tree, l1d_size
+	 * could be zero. That leads to the loop in the asm wrapping around to
+	 * 2^64-1, and then walking off the end of the fallback area and
+	 * eventually causing a page fault which is fatal. Just default to
+	 * something vaguely sane.
+	 */
+	if (!l1d_size)
+		l1d_size = (64 * 1024);
+
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	/*
-- 
2.14.1
