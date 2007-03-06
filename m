Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 46FCBDDDFE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 19:33:56 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l268XmkW005821
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 01:33:48 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l268Xkw9025253
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 02:33:47 -0600 (CST)
Subject: [patch]: Remove fixed setting of ROOT_DEV for 7448HPC2 platforms
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1173161436.9465.91.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 06 Mar 2007 14:10:36 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove fixed setting of ROOT_DEV for 7448HPC2 platforms.
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

---

 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 3fcc85f..9922574 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -91,16 +91,6 @@ static void __init mpc7448_hpc2_setup_ar
 	}
 	tsi108_csr_vir_base = get_vir_csrbase();
 
-#ifdef	CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-#endif
-
 	/* setup PCI host bridge */
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-- 
1.4.0
