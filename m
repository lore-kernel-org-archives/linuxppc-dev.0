Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 323B6DDFB3
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 12:06:26 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6S26KIL001177
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 21:06:21 -0500
Subject: [PATCH] powerpc/powermac: Use sane default baudrate for SCC debugging
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 12:06:19 +1000
Message-Id: <1217210779.11188.148.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When using the "sccdbg" option to route early kernel messages and
xmon to the SCC serial port on PowerMacs, when this wasn't the
configured output port of Open Firmware, we initialize the baudrate
to 57600bps. This isn't a very good default on some powermacs where
both the FW and pmac_zilog will default to 38400. This fixes it to
use the same logic as pmac_zilog to pick a default speed.
    
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index 47de4d3..572771f 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -125,13 +125,23 @@ void udbg_scc_init(int force_scc)
 	out_8(sccc, 0xc0);
 
 	/* If SCC was the OF output port, read the BRG value, else
-	 * Setup for 57600 8N1
+	 * Setup for 38400 or 57600 8N1 depending on the machine
 	 */
 	if (ch_def != NULL) {
 		out_8(sccc, 13);
 		scc_inittab[1] = in_8(sccc);
 		out_8(sccc, 12);
 		scc_inittab[3] = in_8(sccc);
+	} else if (machine_is_compatible("RackMac1,1")
+		   || machine_is_compatible("RackMac1,2")
+		   || machine_is_compatible("MacRISC4")) {
+		/* Xserves and G5s default to 57600 */
+		scc_inittab[1] = 0;
+		scc_inittab[3] = 0;
+	} else {
+		/* Others default to 38400 */
+		scc_inittab[1] = 0;
+		scc_inittab[3] = 1;
 	}
 
 	for (i = 0; i < sizeof(scc_inittab); ++i)
