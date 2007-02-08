Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 089EEDDEFA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 04:49:27 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Rename ucc_slow_info.us_regs to .regs
Date: Thu,  8 Feb 2007 10:32:02 -0600
Message-Id: <1170952322770-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the 'us_regs' field of the ucc_slow_info structure in ucc_slow.h
to just 'regs'.  The equivalent field in the ucc_fast_info structure is
also called 'regs', so this patch makes them comparable, and makes the
code a little easier to read, because there already is a 'us_regs' in
another ucc_slow structure.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |    6 +++---
 include/asm-powerpc/ucc_slow.h        |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 47b5620..0e97e5c 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -179,7 +179,7 @@ int ucc_slow_init(struct ucc_slow_info *
 	uccs->us_info = us_info;
 	uccs->saved_uccm = 0;
 	uccs->p_rx_frame = 0;
-	uccs->us_regs = us_info->us_regs;
+	uccs->us_regs = us_info->regs;
 	us_regs = uccs->us_regs;
 	uccs->p_ucce = (u16 *) & (us_regs->ucce);
 	uccs->p_uccm = (u16 *) & (us_regs->uccm);
@@ -206,7 +206,7 @@ int ucc_slow_init(struct ucc_slow_info *
 	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
 
 	/* Init Guemr register */
-	if ((ret = ucc_init_guemr((struct ucc_common *) (us_info->us_regs)))) {
+	if ((ret = ucc_init_guemr((struct ucc_common *) (us_info->regs)))) {
 		uccs_err("ucc_slow_init: Could not init the guemr register.");
 		ucc_slow_free(uccs);
 		return ret;
@@ -214,7 +214,7 @@ int ucc_slow_init(struct ucc_slow_info *
 
 	/* Set UCC to slow type */
 	if ((ret = ucc_set_type(us_info->ucc_num,
-				(struct ucc_common *) (us_info->us_regs),
+				(struct ucc_common *) (us_info->regs),
 				UCC_SPEED_TYPE_SLOW))) {
 		uccs_err("ucc_slow_init: Could not init the guemr register.");
 		ucc_slow_free(uccs);
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
index ca93bc9..1babad9 100644
--- a/include/asm-powerpc/ucc_slow.h
+++ b/include/asm-powerpc/ucc_slow.h
@@ -150,7 +150,7 @@ struct ucc_slow_info {
 	int ucc_num;
 	enum qe_clock rx_clock;
 	enum qe_clock tx_clock;
-	struct ucc_slow *us_regs;
+	struct ucc_slow *regs;
 	int irq;
 	u16 uccm_mask;
 	int data_mem_part;
-- 
1.4.4
