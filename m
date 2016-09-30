Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slXvT2B96zDvHs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 10:51:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fadump: Fix build break when CONFIG_PROC_VMCORE=n
Date: Fri, 30 Sep 2016 10:51:46 +1000
Message-Id: <1475196706-6105-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fadump code calls vmcore_cleanup() which only exists if
CONFIG_PROC_VMCORE=y. We don't want to depend on CONFIG_PROC_VMCORE,
because it's user selectable, so just wrap the call in an #ifdef.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/fadump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b3a663333d36..8d461303dd13 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1104,7 +1104,9 @@ static ssize_t fadump_release_memory_store(struct kobject *kobj,
 		 * Take away the '/proc/vmcore'. We are releasing the dump
 		 * memory, hence it will not be valid anymore.
 		 */
+#ifdef CONFIG_PROC_VMCORE
 		vmcore_cleanup();
+#endif
 		fadump_invalidate_release_mem();
 
 	} else
-- 
2.7.4
