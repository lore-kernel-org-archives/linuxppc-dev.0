Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A49D6B6F91
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Oct 2011 18:19:00 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/cpm: Clear muram before it is in use.
Date: Wed, 19 Oct 2011 02:18:52 -0500
Message-Id: <1319008732-8057-1-git-send-email-galak@kernel.crashing.org>
Cc: Hongjun Chen <Hong-jun.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongjun Chen <Hong-jun.Chen@freescale.com>

We need to ensure that MURAM is in a known and cleared out state before
using it as the bootloader could have utilized it from its own purposes
and left it in an unknown state.

If we don't clear it out we've seen issues with UCC ethernet:
* Multi ethernet interfaces can't work simultanously.
* Multi up/down Ethernet interfaces will halt these ports.
* UCC1 RGMII can't work when kernel boots from some hosts.

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Hongjun Chen <Hong-jun.Chen@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/cpm_common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index d55d0ad..8db10bb 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -3,7 +3,7 @@
  *
  * Author: Scott Wood <scottwood@freescale.com>
  *
- * Copyright 2007 Freescale Semiconductor, Inc.
+ * Copyright 2007-2008,2010 Freescale Semiconductor, Inc.
  *
  * Some parts derived from commproc.c/cpm2_common.c, which is:
  * Copyright (c) 1997 Dan error_act (dmalek@jlc.net)
@@ -146,6 +146,7 @@ unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
 	spin_lock_irqsave(&cpm_muram_lock, flags);
 	cpm_muram_info.alignment = align;
 	start = rh_alloc(&cpm_muram_info, size, "commproc");
+	memset(cpm_muram_addr(start), 0, size);
 	spin_unlock_irqrestore(&cpm_muram_lock, flags);
 
 	return start;
-- 
1.7.3.4
