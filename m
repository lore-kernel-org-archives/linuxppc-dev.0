Return-Path: <BATV+b9b5b997e1b0c89ea184+2113+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80D0FB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:38:18 +1000 (EST)
Subject: [PATCH] Remove machine_is(chrp) from 64-bit kernel
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
Content-Type: text/plain
Date: Sat, 06 Jun 2009 17:38:10 +0100
Message-Id: <1244306290.3751.2032.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CHRP platform type only exists in a 32-bit build. Don't bother
checking machine_is(chrp) if we're in 64-bit mode.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 45936c9..c22f7e8 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -518,9 +518,10 @@ static int __init pmac_declare_of_platform_devices(void)
 {
 	struct device_node *np;
 
+#ifdef CONFIG_PPC32
 	if (machine_is(chrp))
 		return -1;
-
+#endif
 	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np)
 		of_platform_device_create(np, "valkyrie", NULL);

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
