Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83DF967A77
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 08:55:29 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:55:11 +1000
Message-Id: <1111964111.6099.19.camel@gaston>
Mime-Version: 1.0
Subject: [PATCH] Fix sleep/wakeup problems on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

There have been various reports lately of sleep beeing broken on iBook
G3. Frank (no name provided here) found a typo in my code that cleans
the L1 cache on these CPU models. This patch fixes it, I'd appreciate
some feedback about wether that fixes the problem or not.

Ben.

Index: linux-work/arch/ppc/platforms/pmac_cache.S
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cache.S	2005-03-15 11:56:42.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_cache.S	2005-03-28 08:51:46.000000000 +1000
@@ -73,7 +73,7 @@
 
 	/* disable / invalidate / enable L1 data */
 	mfspr	r3,SPRN_HID0
-	rlwinm	r0,r0,0,~HID0_DCE
+	rlwinm	r3,r3,0,~HID0_DCE
 	mtspr	SPRN_HID0,r3
 	sync
 	isync
