Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF8CFDF054
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1Ztou019163
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:55 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZsNP001550
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:55 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BDOs007956
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:14 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 01EE6AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:54 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zref015424
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:53 -0500
Date: Tue, 17 Jul 2007 20:35:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 41/61] 8xx: Keep a global mpc8xx_immr mapping.
Message-ID: <20070718013553.GM15238@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/sysdev/commproc.c |   20 +++++++++++---------
 include/asm-powerpc/fs_pd.h    |   21 +++++----------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index e8e79f8..f73e96d 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -48,6 +48,7 @@ static void m8xx_cpm_dpinit(void);
 static uint host_buffer; /* One page of host buffer */
 static uint host_end;    /* end + 1 */
 cpm8xx_t *cpmp;          /* Pointer to comm processor space */
+immap_t *mpc8xx_immr;
 cpic8xx_t *cpic_reg;
 
 static struct device_node *cpm_pic_node;
@@ -197,21 +198,26 @@ end:
 
 void cpm_reset(void)
 {
-	cpm8xx_t *commproc;
 	sysconf8xx_t *siu_conf;
 
-	commproc = (cpm8xx_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+	mpc8xx_immr = ioremap(get_immrbase(), 0x4000);
+	if (!mpc8xx_immr) {
+		printk(KERN_CRIT "Could not map IMMR\n");
+		return;
+	}
+
+	cpmp = &mpc8xx_immr->im_cpm;
 
 #ifdef CONFIG_UCODE_PATCH
 	/* Perform a reset.
 	*/
-	out_be16(&commproc->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
+	out_be16(&cpmp->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
 
 	/* Wait for it.
 	*/
-	while (in_be16(&commproc->cp_cpcr) & CPM_CR_FLG);
+	while (in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG);
 
-	cpm_load_patch(commproc);
+	cpm_load_patch(cpmp);
 #endif
 
 	/* Set SDMA Bus Request priority 5.
@@ -226,10 +232,6 @@ void cpm_reset(void)
 
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
-
-	/* Tell everyone where the comm processor resides.
-	*/
-	cpmp = commproc;
 }
 
 /* We used to do this earlier, but have to postpone as long as possible
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 2179a5a..82536a2 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -32,22 +32,11 @@
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
 
-#define immr_map(member)						\
-({									\
-	u32 offset = offsetof(immap_t, member);				\
-	void *addr = ioremap (IMAP_ADDR + offset,			\
-			      sizeof( ((immap_t*)0)->member));		\
-	addr;								\
-})
-
-#define immr_map_size(member, size)					\
-({									\
-	u32 offset = offsetof(immap_t, member);				\
-	void *addr = ioremap (IMAP_ADDR + offset, size);		\
-	addr;								\
-})
-
-#define immr_unmap(addr)		iounmap(addr)
+extern immap_t *mpc8xx_immr;
+
+#define immr_map(member) (&mpc8xx_immr->member)
+#define immr_map_size(member, size) (&mpc8xx_immr->member)
+#define immr_unmap(addr) iounmap(addr)
 #endif
 
 static inline int uart_baudrate(void)
-- 
1.5.0.3
