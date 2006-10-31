Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D995567C4B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 20:52:59 +1100 (EST)
Received: from az33smr01 (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9V9qwgN024927
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 02:52:58 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01 (8.13.1/8.13.0) with ESMTP id k9V9qurM016894
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 03:52:57 -0600 (CST)
Message-ID: <45471D26.1050000@freescale.com>
Date: Tue, 31 Oct 2006 17:53:42 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 1/2] qe_lib: qe_issue_cmd writes wrong value to CECDR
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

Changed qe_issue_cmd() to write cmd_input to the CECDR unmodified.  It
was treating cmd_input as a virtual address and tried to convert it to
a physical address.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

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
