Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 893C01007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 16:51:52 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p8T6plih007922
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2011 01:51:48 -0500
Subject: [PATCH] powerpc: Don't try OPAL takeover on old 970 blades
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Sep 2011 16:51:46 +1000
Message-ID: <1317279106.29415.179.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The firmware on old 970 blades supports some kind of takeover called
"TNK takeover" which will crash if we try to probe for OPAL takeover,
so don't do it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e96f5d0..b4fa661 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1313,6 +1313,16 @@ static void prom_query_opal(void)
 {
 	long rc;
 
+	/* We must not query for OPAL presence on a machine that
+	 * supports TNK takeover (970 blades), as this uses the same
+	 * h-call with different arguments and will crash
+	 */
+	if (PHANDLE_VALID(call_prom("finddevice", 1, 1,
+				    ADDR("/tnk-memory-map")))) {
+		prom_printf("TNK takeover detected, skipping OPAL check\n");
+		return;
+	}
+
 	prom_printf("Querying for OPAL presence... ");
 	rc = opal_query_takeover(&RELOC(prom_opal_size),
 				 &RELOC(prom_opal_align));
	
