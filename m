Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtTH72n4PzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 00:33:22 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] macintosh: Do not arbitrarily limit architecture for
 macintosh drivers.
Date: Wed, 29 Mar 2017 15:33:18 +0200
Message-Id: <20170329133318.16189-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mac mouse emulation is neat solution for notebooks with suboptimal
touchpads. For historical reason this is available on x86 but not arm or
mips so remove the limitation.

The other more specific drivers depend on various platform drivers
anyway so users will not select those by accident.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/macintosh/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 97a420c11eed..c23c040bc668 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -1,7 +1,6 @@
 
 menuconfig MACINTOSH_DRIVERS
 	bool "Macintosh device drivers"
-	depends on PPC || MAC || X86
 	default y if (PPC_PMAC || MAC)
 	---help---
 	  Say Y here to get to see options for devices used with Macintosh
-- 
2.10.2
