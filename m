Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C3E60B6F7C
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 06:38:29 +1100 (EST)
Received: from mail117-ch1 (localhost.localdomain [127.0.0.1])	by
 mail117-ch1-R.bigfish.com (Postfix) with ESMTP id 215CE9A0119	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 19:38:18 +0000 (UTC)
Received: from CH1EHSMHS014.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail117-ch1.bigfish.com (Postfix) with ESMTP id
 EB67A6E8046	for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 19:38:15 +0000
 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: do not force PHYS_64BIT on the P1022DS
Date: Thu, 3 Nov 2011 14:38:19 -0500
Message-ID: <1320349099-22594-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kconfig option PHYS_64BIT sets the size of phys_addr_t to 64 bits, which
allows support for a 36-bit physical address space.  With this option, the
kernel can support more than 2GB of RAM, but the larger address size
impacts performance slightly.

By including "select PHYS_64BIT" in the Kconfig for a particular board,
that option is forced enabled, and it becomes impossible to create a 32-bit
kernel.  Instead, we should depend on the defconfig to enable this option.
We still build a 36-bit kernel by default, and we also allow users to build
32-bit kernels if they really want.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 12f5932..dddada4 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -80,7 +80,6 @@ config P1010_RDB
 config P1022_DS
 	bool "Freescale P1022 DS"
 	select DEFAULT_UIMAGE
-	select PHYS_64BIT	# The DTS has 36-bit addresses
 	select SWIOTLB
 	help
 	  This option enables support for the Freescale P1022DS reference board.
-- 
1.7.3.4
