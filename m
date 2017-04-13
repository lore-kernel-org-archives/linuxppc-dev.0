Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3gQm2pb2zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 22:41:52 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Move page table dump into powerpc subdirectory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Rashmica Gupta <rashmicy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170413124148.EB6C76E664@localhost.localdomain>
Date: Thu, 13 Apr 2017 14:41:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Page table dump is a powerpc specific thing, so it should
appear in powerpc/ subdirectory of debugfs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 22d2433333f5..df7664ea7ede 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -14,7 +14,7 @@
  * as published by the Free Software Foundation; version 2
  * of the License.
  */
-#include <linux/debugfs.h>
+#include <asm/debugfs.h>
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -483,8 +483,8 @@ static int ptdump_init(void)
 
 	populate_markers();
 	build_pgtable_complete_mask();
-	debugfs_file = debugfs_create_file("kernel_pagetables", 0400, NULL,
-			NULL, &ptdump_fops);
+	debugfs_file = debugfs_create_file("kernel_pagetables", 0400,
+			powerpc_debugfs_root, NULL, &ptdump_fops);
 	return debugfs_file ? 0 : -ENOMEM;
 }
 device_initcall(ptdump_init);
-- 
2.12.0
