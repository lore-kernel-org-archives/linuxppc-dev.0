Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA6B9DEDC3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:43 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1Zcnc019087
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:38 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1Zbgn001481
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:37 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AupG007920
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:56 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id D2E94AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:36 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zaa8015374
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:36 -0500
Date: Tue, 17 Jul 2007 20:35:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 29/61] fsl_soc: Fix get_immrbase() to use ranges,
	rather than reg.
Message-ID: <20070718013536.GA15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is not always the case that the SoC's first reg property points
to the beginning of the entire SoC block.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index c0ddc80..a837742 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -52,10 +52,19 @@ phys_addr_t get_immrbase(void)
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
 		unsigned int size;
-		const void *prop = of_get_property(soc, "reg", &size);
+		u32 naddr;
+		const u32 *prop = of_get_property(soc, "#address-cells", &size);
+
+		if (prop && size == 4)
+			naddr = *prop;
+		else
+			naddr = 2;
+
+		prop = of_get_property(soc, "ranges", &size);
+
+		if (prop && size >= 12)
+			immrbase = of_translate_address(soc, prop + naddr);
 
-		if (prop)
-			immrbase = of_translate_address(soc, prop);
 		of_node_put(soc);
 	};
 
-- 
1.5.0.3
