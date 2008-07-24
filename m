Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 304A7DDF3E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 01:58:52 +1000 (EST)
Subject: [PATCH] c2k: fix list of enabled address space
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 08:53:39 -0700
Message-Id: <1216914819.19203.43.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, "Welch, Martyn \(GE EntSol,
	Intelligent Platforms\)" <martyn.welch@gefanuc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Marvell chip SRAM was disabled and some reserved bit set by mistake. 
This bug was found thanks to Martyn Welch.

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---
 arch/powerpc/boot/cuboot-c2k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-c2k.c b/arch/powerpc/boot/cuboot-c2k.c
index e435949..cf993ea 100644
--- a/arch/powerpc/boot/cuboot-c2k.c
+++ b/arch/powerpc/boot/cuboot-c2k.c
@@ -56,7 +56,7 @@ static void c2k_bridge_setup(u32 mem_size)
 		fatal("Error: Missing marvell,mv64360 device tree node\n\r");
 
 	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE));
-	enables |= 0x007ffe00; /* Disable all cpu->pci windows */
+	enables |= 0x0007fe00; /* Disable all cpu->pci windows */
 	out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE), enables);
 
 	/* Get the cpu -> pci i/o & mem mappings from the device tree */
