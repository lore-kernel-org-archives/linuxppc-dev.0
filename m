Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 262B1DECC6
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:10:13 +1000 (EST)
Date: Wed, 16 Jul 2008 18:05:58 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ep8248e: Unconditionally select PHYLIB for
	mdio_bitbang
Message-ID: <Pine.LNX.4.64.0807161802590.26841@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davej@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Its possible to build the phylib as a module, however this breaks the
board code because alloc_mdio_bitbang and mdiobus_register are not
available if we build as a module.  These are needed by the board code
since it implements the low level mdio bitbang ops.

So we unconditionally select PHYLIB to ensure its built into the kernel
if we are building in EP8248E support.

Long term we should look at moving the mdio_ops into its own file so it
can be built as a module.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This patch supercededs:

[PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET

I've reverted the old patch and applied the new patch in my git tree and
have asked Ben to pull and push it to Linus.

- k

 arch/powerpc/platforms/82xx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 1c8034b..75eb1ed 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -30,6 +30,7 @@ config EP8248E
 	select 8272
 	select 8260
 	select FSL_SOC
+	select PHYLIB
 	select MDIO_BITBANG
 	help
 	  This enables support for the Embedded Planet EP8248E board.
-- 
1.5.5.1
