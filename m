Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2x7P4smZzDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 20:55:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/cell: Drop select of MEMORY_HOTPLUG
Date: Mon,  1 Aug 2016 20:55:07 +1000
Message-Id: <1470048908-9405-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SPU_FS selects MEMORY_HOTPLUG, which is problematic because
MEMORY_HOTPLUG is user selectable, meaning we can end up with a broken
.config where MEMORY_HOTPLUG is enabled but its dependencies are not,
leading to build breakages.

The select of MEMORY_HOTPLUG for SPU_FS was added back in 2006, in
commit 4da30d15b6d5 ("[POWERPC] spufs: fix memory hotplug dependency").

However we reworked the spufs code and removed the dependency on memory
hotplug in 2007 in commit 78bde53e351b ("[POWERPC] spufs: remove need
for struct page for SPEs").

So drop the select as it's no longer needed and causes problems.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/cell/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index d9088f0b8fcc..441ad3bad3db 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -46,7 +46,6 @@ config SPU_FS
 	default m
 	depends on PPC_CELL
 	select SPU_BASE
-	select MEMORY_HOTPLUG
 	help
 	  The SPU file system is used to access Synergistic Processing
 	  Units on machines implementing the Broadband Processor
-- 
2.7.4
