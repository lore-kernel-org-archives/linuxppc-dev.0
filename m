Return-Path: <b04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D3AF8DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 01:48:58 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix invalid pointer usage in ucc_slow_init()
Date: Thu, 15 Mar 2007 09:48:53 -0500
Message-Id: <1173970133624-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In two places, ucc_slow_init() passes a physical address instead of the
virtual address to functions that were expecting the latter, causing a kernel
panic.  us_info->regs contains the physical address of the UCC register set.
The registers are ioremap'd to kernel space, and the virtual pointers are
stored in us_regs.  The code was using us_info->regs when it should have been
using us_regs.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 817df73..b930d68 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -187,7 +187,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
 
 	/* Init Guemr register */
-	if ((ret = ucc_init_guemr((struct ucc_common *) (us_info->regs)))) {
+	if ((ret = ucc_init_guemr((struct ucc_common *) us_regs))) {
 		printk(KERN_ERR "%s: cannot init GUEMR", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return ret;
@@ -195,7 +195,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 
 	/* Set UCC to slow type */
 	if ((ret = ucc_set_type(us_info->ucc_num,
-				(struct ucc_common *) (us_info->regs),
+				(struct ucc_common *) us_regs,
 				UCC_SPEED_TYPE_SLOW))) {
 		printk(KERN_ERR "%s: cannot set UCC type", __FUNCTION__);
 		ucc_slow_free(uccs);
-- 
1.5.0.2.260.g2eb065
