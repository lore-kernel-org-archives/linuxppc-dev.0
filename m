Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zQr51dHrzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 19:02:12 +1000 (AEST)
Message-Id: <b3f2074b89ef0e3352fb11b69be30caeaa823fa0.1535360497.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: wire up memtest
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 27 Aug 2018 09:02:07 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add call to early_memtest() so that kernel compiled with
CONFIG_MEMTEST really perform memtest at startup when requested
via 'memtest' boot parameter.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93fa0c99681e..904b728eb20d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -33,6 +33,7 @@
 #include <linux/serial_8250.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
+#include <linux/bootmem.h>
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <asm/debugfs.h>
@@ -917,6 +918,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Parse memory topology */
 	mem_topology_setup();
 
+	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
+
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
 	 * we can map physical -> logical CPU ids.
-- 
2.13.3
