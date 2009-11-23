Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D2D1B6F01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 09:29:06 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix DEBUG_HIGHMEM build break from d4515646699
Date: Mon, 23 Nov 2009 16:28:53 -0600
Message-Id: <1259015333-23485-1-git-send-email-beckyb@kernel.crashing.org>
Cc: mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code was added to mm/higmem.c that depends on several
kmap types that powerpc does not support.  We add dummy
invalid definitions for KM_NMI, KM_NM_PTE, and KM_IRQ_PTE.

According to list discussion, this fix should not be needed
anymore starting with 2.6.33.  The code is commented to this
effect so hopefully we will remember to remove this.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/kmap_types.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kmap_types.h b/arch/powerpc/include/asm/kmap_types.h
index b6bac6f..9163695 100644
--- a/arch/powerpc/include/asm/kmap_types.h
+++ b/arch/powerpc/include/asm/kmap_types.h
@@ -29,5 +29,16 @@ enum km_type {
 	KM_TYPE_NR
 };
 
+/*
+ * This is a temporary build fix that (so they say on lkml....) should no longer
+ * be required after 2.6.33, because of changes planned to the kmap code.
+ * Let's try to remove this cruft then.
+ */
+#ifdef CONFIG_DEBUG_HIGHMEM
+#define KM_NMI		(-1)
+#define KM_NMI_PTE	(-1)
+#define KM_IRQ_PTE	(-1)
+#endif
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_KMAP_TYPES_H */
-- 
1.6.0.6
