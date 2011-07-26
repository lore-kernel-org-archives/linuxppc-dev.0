Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74C56B702E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 16:48:43 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/4] powerpc/85xx: Merge PCI/PCI Express error
	management registers
Date: Tue, 26 Jul 2011 06:48:35 +0000
Message-ID: <267A3B246C22C34A8E574051858E077010EE6D@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311244195-4418-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1311244195-4418-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: Xie Shaohui-B21989
>Sent: Thursday, July 21, 2011 6:30 PM
>To: linuxppc-dev@lists.ozlabs.org
>Cc: Gala Kumar-B11780; Jiang Kai-B18973; Kumar Gala; Xie Shaohui-B21989
>Subject: [PATCH 3/4] powerpc/85xx: Merge PCI/PCI Express error management
>registers
>
>From: Kai.Jiang <Kai.Jiang@freescale.com>
>
>There are some differences of register offset and definition between pci
>and pcie error management registers. While, some other pci/pcie error
>management registers are nearly the same.
>
>Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>---
> arch/powerpc/sysdev/fsl_pci.h |   31 +++++++++++++++++++++++++------
> 1 files changed, 25 insertions(+), 6 deletions(-)
>
>difg --gite a/arch/powerpc/sysdev/fsl_pci.h
>b/arch/powerpc/sysdev/fsl_pci.h index a39ed5c..60a76e9 100644
>--- a/arch/powerpc/sysdev/fsl_pci.h
>+++ b/arch/powerpc/sysdev/fsl_pci.h
>@@ -74,13 +74,32 @@ struct ccsr_pci {
>  */
> 	struct pci_inbound_window_regs piw[4];
>
>+/* Merge PCI/PCI Express error management registers */
> 	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect
>register */
>-	u8	res21[4];
>-	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt
>enable register */
>-	u8	res22[4];
>-	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error
>disable register */
>-	u8	res23[12];
>-	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture
>status register */
>+	__be32	pex_err_cap_dr;		/* 0x.e04 */
>+					/* - PCI error capture disabled register */
>+					/* - PCIE has no this register */
>+	__be32	pex_err_en;		/* 0x.e08 */
>+					/* - PCI/PCIE error interrupt enable
>register*/
>+	__be32	pex_err_attrib;		/* 0x.e0c */
>+					/* - PCI error attributes capture register
>*/
>+					/* - PCIE has no this register */
>+	__be32	pex_err_disr;		/* 0x.e10 */
>+					/* - PCI error address capture register */
>+					/* - PCIE error disable register */
>+	__be32	pex_err_ext_addr;	/* 0x.e14 */
>+					/* - PCI error extended addr capture
>register*/
>+					/* - PCIE has no this register */
>+	__be32	pex_err_dl;		/* 0x.e18 */
>+					/* - PCI error data low capture register */
>+					/* - PCIE has no this register */
>+	__be32	pex_err_dh;		/* 0x.e1c */
>+					/* - PCI error data high capture register */
>+					/* - PCIE has no this register */
>+	__be32	pex_err_cap_stat;	/* 0x.e20 */
>+					/* - PCI gasket timer register */
>+					/* - PCIE error capture status register */
>+
> 	u8	res24[4];
> 	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture
>register 0 */
> 	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture
>register 0 */
>--
>1.6.4
[Xie Shaohui] I've verified this patch can apply for galak/powerpc.git 'nex=
t' branch with no change.


Best Regards,=20
Shaohui Xie
