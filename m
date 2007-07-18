Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D943DF05B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:02 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZvL4027692
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:58 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZvQd001556
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:57 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BGag007962
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:16 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 7BD35AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:56 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZuOi015433
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:56 -0500
Date: Tue, 17 Jul 2007 20:35:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 43/61] 8xx: Always reset CPM if not using early console.
Message-ID: <20070718013556.GO15238@ld0162-tx32.am.freescale.net>
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

Some CPM devices conflict with each other, and the bootloader
may have initialized a conflicting device.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/commproc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index b0a58fd..eb791ea 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -208,7 +208,7 @@ void cpm_reset(void)
 
 	cpmp = &mpc8xx_immr->im_cpm;
 
-#ifdef CONFIG_UCODE_PATCH
+#ifndef CONFIG_PPC_EARLY_DEBUG
 	/* Perform a reset.
 	*/
 	out_be16(&cpmp->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
@@ -216,7 +216,9 @@ void cpm_reset(void)
 	/* Wait for it.
 	*/
 	while (in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG);
+#endif
 
+#ifdef CONFIG_UCODE_PATCH
 	cpm_load_patch(cpmp);
 #endif
 
-- 
1.5.0.3
