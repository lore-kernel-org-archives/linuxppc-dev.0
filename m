Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C8F6567B7C
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 21:04:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9PB4SP3020852
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 04:04:28 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9PB4P4X024164
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 06:04:27 -0500 (CDT)
Message-ID: <453F44E6.8030706@freescale.com>
Date: Wed, 25 Oct 2006 19:05:10 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove private physical address mapping routine in qe_lib.  Users
of qe_lib should use generic functions like iopa().
The change also addresses a bug found by Timur Tabi that cmd_input
got mapped in qe_issue_cmd().  It should be written to CECDR
unmodified.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Timur Tabi <timur@freescale.com>

---
 arch/powerpc/sysdev/qe_lib/qe.c |    3 +--
 include/asm-powerpc/immap_qe.h  |    9 ---------
 2 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 2bae632..e422322 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -122,8 +122,7 @@ int qe_issue_cmd(u32 cmd, u32 device, u8
 				mcn_shift = QE_CR_MCN_NORMAL_SHIFT;
 		}
 
-		out_be32(&qe_immr->cp.cecdr,
-			 immrbar_virt_to_phys((void *)cmd_input));
+		out_be32(&qe_immr->cp.cecdr, cmd_input);
 		out_be32(&qe_immr->cp.cecr,
 			 (cmd | QE_CR_FLG | ((u32) device << dev_shift) | (u32)
 			  mcn_protocol << mcn_shift));
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index ce12f85..7cccd16 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -464,14 +464,5 @@ struct qe_immap {
 extern struct qe_immap *qe_immr;
 extern phys_addr_t get_qe_base(void);
 
-static inline unsigned long immrbar_virt_to_phys(volatile void * address)
-{
-	if ( ((u32)address >= (u32)qe_immr) &&
-			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
-		return (unsigned long)(address - (u32)qe_immr +
-				(u32)get_qe_base());
-	return (unsigned long)virt_to_phys(address);
-}
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_IMMAP_QE_H */
