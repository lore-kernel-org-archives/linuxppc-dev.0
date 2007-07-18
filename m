Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49344DE41A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:08 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1a3MM019192
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:03 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1a26S001569
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:02 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BLDE007974
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:21 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 9808EAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:01 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1a1tI015449
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:01 -0500
Date: Tue, 17 Jul 2007 20:36:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 47/61] 8xx: Don't hardcode the vendor in cpuinfo.
Message-ID: <20070718013601.GS15238@ld0162-tx32.am.freescale.net>
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

If the vendor output is desired, it should be included in the board name.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/8xx/m8xx_setup.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 601b389..1113384 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -263,8 +263,6 @@ void mpc8xx_show_cpuinfo(struct seq_file *m)
 	uint memsize = total_memory;
 	const char *model = "";
 
-	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-
 	root = of_find_node_by_path("/");
 	if (root)
 		model = of_get_property(root, "model", NULL);
-- 
1.5.0.3
