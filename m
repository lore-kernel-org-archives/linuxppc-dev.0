Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EE0A67C37
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:48:12 +1000 (EST)
Subject: [PATCH] powerpc: get default bauds rate in udbg_scc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:47:58 +1000
Message-Id: <1159850878.5482.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On powermac, when open firmware is set to use the SCC for console, this
causes the low level udbg early console to read back the speed and
re-use it instead of hard coding 57600 bps. This doesn't (yet) pass the
detected speed all the way to pmac_zilog though.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/udbg_scc.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/udbg_scc.c	2006-07-03 12:01:14.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/udbg_scc.c	2006-08-31 13:19:38.000000000 +1000
@@ -111,8 +111,6 @@ void udbg_scc_init(int force_scc)
 	pmac_call_feature(PMAC_FTR_SCC_ENABLE, ch,
 			  PMAC_SCC_ASYNC | PMAC_SCC_FLAG_XMON, 1);
 
-
-	/* Setup for 57600 8N1 */
 	if (ch == ch_a)
 		addr += 0x20;
 	sccc = ioremap(addr & PAGE_MASK, PAGE_SIZE) ;
@@ -125,9 +123,21 @@ void udbg_scc_init(int force_scc)
 		x = in_8(sccc);
 	out_8(sccc, 0x09);		/* reset A or B side */
 	out_8(sccc, 0xc0);
+
+	/* If SCC was the OF output port, read the BRG value, else
+	 * Setup for 57600 8N1
+	 */
+	if (ch_def != NULL) {
+		out_8(sccc, 13);
+		scc_inittab[1] = in_8(sccc);
+		out_8(sccc, 12);
+		scc_inittab[3] = in_8(sccc);
+	}
+
 	for (i = 0; i < sizeof(scc_inittab); ++i)
 		out_8(sccc, scc_inittab[i]);
 
+
 	udbg_putc = udbg_scc_putc;
 	udbg_getc = udbg_scc_getc;
 	udbg_getc_poll = udbg_scc_getc_poll;
