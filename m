Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3h8l2rhfzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 23:14:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, lorenzo.pieralisi@arm.com, linux@armlinux.org.uk
Subject: [PATCH] powerpc: Drop include of linux/io.h from asm/io.h
Date: Thu, 13 Apr 2017 23:14:36 +1000
Message-Id: <1492089276-13713-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently powerpc's asm/io.h includes linux/io.h, and linux/io.h
includes asm/io.h.

This can cause problems because depending on which is included first the
order of definitions between the two files will change.

The include of linux/io.h was added back in 2008 in commit b41e5fffe8b8
("[POWERPC] devres: Add devm_ioremap_prot()"). It's not entirely clear
it was needed then, but devm_ioremap_prot() has since been removed
entirely as unused, in dedd24a12fe6 ("powerpc: Remove unused
devm_ioremap_prot()").

So it seems to be unnecessary and can potentially cause problems, so
remove the include of linux/io.h from asm/io.h

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5ed292431b5b..91919a98e5d0 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -25,8 +25,6 @@ extern struct pci_dev *isa_bridge_pcidev;
 #endif
 
 #include <linux/device.h>
-#include <linux/io.h>
-
 #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
-- 
2.7.4
