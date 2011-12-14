Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9796F1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 10:55:18 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pBENtCMe025654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2011 17:55:14 -0600
Message-ID: <1323906911.21839.23.camel@pasglop>
Subject: [PATCH] powerpc: Fix old bug in prom_init setting of the color
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 15 Dec 2011 10:55:11 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have an array of 16 entries and a loop of 32 iterations... oops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index cc58486..e3d0ecd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2079,7 +2079,7 @@ static void __init prom_check_displays(void)
 		/* Setup a usable color table when the appropriate
 		 * method is available. Should update this to set-colors */
 		clut = RELOC(default_colors);
-		for (i = 0; i < 32; i++, clut += 3)
+		for (i = 0; i < 16; i++, clut += 3)
 			if (prom_set_color(ih, i, clut[0], clut[1],
 					   clut[2]) != 0)
 				break;
