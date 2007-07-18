Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C1E8DF091
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1Zxov027699
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:59 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZwSk001559
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:58 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BH8o007965
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:17 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id B7A52AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:57 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZvHD015437
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:57 -0500
Date: Tue, 17 Jul 2007 20:35:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 44/61] 8xx: Miscellaneous commproc.c cleanup.
Message-ID: <20070718013557.GP15238@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/commproc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index eb791ea..699bbd2 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -228,7 +228,7 @@ void cpm_reset(void)
 	 * manual recommends it.
 	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
 	 */
-	siu_conf = (sysconf8xx_t*)immr_map(im_siu_conf);
+	siu_conf = immr_map(im_siu_conf);
 	out_be32(&siu_conf->sc_sdcr, 1);
 	immr_unmap(siu_conf);
 
@@ -312,14 +312,14 @@ static rh_info_t cpm_dpmem_info;
 
 #define CPM_DPMEM_ALIGNMENT	8
 static u8 *dpram_vbase;
-static uint dpram_pbase;
+static unsigned long dpram_pbase;
 
 void m8xx_cpm_dpinit(void)
 {
 	spin_lock_init(&cpm_dpmem_lock);
 
-	dpram_vbase = immr_map_size(im_cpm.cp_dpmem, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
-	dpram_pbase = (uint)&((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem;
+	dpram_vbase = cpmp->cp_dpmem;
+	dpram_pbase = get_immrbase() + offsetof(immap_t, im_cpm.cp_dpmem);
 
 	/* Initialize the info header */
 	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
-- 
1.5.0.3
