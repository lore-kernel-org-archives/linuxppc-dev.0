Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCn4L6FrPzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 13:23:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/debug: PTDUMP should depend on DEBUG_FS
Date: Wed,  1 Feb 2017 13:23:44 +1100
Message-Id: <1485915824-14546-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_PPC_PTDUMP currently selects CONFIG_DEBUG_FS. But CONFIG_DEBUG_FS
is user-selectable, so we shouldn't select it. Instead depend on it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 949258d412d0..c86df246339e 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -356,8 +356,7 @@ config FAIL_IOMMU
 
 config PPC_PTDUMP
         bool "Export kernel pagetable layout to userspace via debugfs"
-        depends on DEBUG_KERNEL
-        select DEBUG_FS
+        depends on DEBUG_KERNEL && DEBUG_FS
         help
 	  This option exports the state of the kernel pagetables to a
 	  debugfs file. This is only useful for kernel developers who are
-- 
2.7.4
