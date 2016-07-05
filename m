Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBdV0td5zDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:04:46 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdR2GnKz9sXy
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:04:42 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/41] powerpc/prom_init: PTRRELOC is not needed
Date: Tue,  5 Jul 2016 15:03:39 +1000
Message-Id: <1467695057-12431-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's one line of code still using PTRRELOC in prom_init, it
shouldn't be necessary since that code is relocatable. Take it
out.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6ee4b72..54e450c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1980,7 +1980,7 @@ static void __init prom_check_displays(void)
 				break;
 
 #ifdef CONFIG_LOGO_LINUX_CLUT224
-		clut = PTRRELOC(logo_linux_clut224.clut);
+		clut = logo_linux_clut224.clut;
 		for (i = 0; i < logo_linux_clut224.clutsize; i++, clut += 3)
 			if (prom_set_color(ih, i + 32, clut[0], clut[1],
 					   clut[2]) != 0)
-- 
2.7.4
