Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1EC7DDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 18:41:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4C8fP6A017459
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 01:41:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4C8fMV5006912
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:41:25 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: akpm@linux-foundation.org, galak@kernel.crashing.org, davem@davemloft.net,
	mporter@kernel.crashing.org
Subject: [PATCH 2/6] powerpc/fsl_rio: use LAW address from device tree
Date: Tue, 12 May 2009 16:35:59 +0800
Message-Id: <1242117363-14949-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1242117363-14949-1-git-send-email-leoli@freescale.com>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of fixed address in old code.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index abdb124..fa0720f 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1077,8 +1077,9 @@ int fsl_rio_setup(struct of_device *dev)
 
 	INIT_LIST_HEAD(&port->dbells);
 	port->iores.start = law_start;
-	port->iores.end = law_start + law_size;
+	port->iores.end = law_start + law_size - 1;
 	port->iores.flags = IORESOURCE_MEM;
+	port->iores.name = "rio_io_win";
 
 	priv->bellirq = irq_of_parse_and_map(dev->node, 2);
 	priv->txirq = irq_of_parse_and_map(dev->node, 3);
@@ -1156,14 +1157,15 @@ int fsl_rio_setup(struct of_device *dev)
 		out_be32((priv->regs_win + RIO_ISR_AACR), RIO_ISR_AACR_AA);
 
 	/* Configure maintenance transaction window */
-	out_be32(&priv->maint_atmu_regs->rowbar, 0x000c0000);
-	out_be32(&priv->maint_atmu_regs->rowar, 0x80077015);
+	out_be32(&priv->maint_atmu_regs->rowbar, law_start >> 12);
+	out_be32(&priv->maint_atmu_regs->rowar, 0x80077015);	/* 4M */
 
 	priv->maint_win = ioremap(law_start, RIO_MAINT_WIN_SIZE);
 
 	/* Configure outbound doorbell window */
-	out_be32(&priv->dbell_atmu_regs->rowbar, 0x000c0400);
-	out_be32(&priv->dbell_atmu_regs->rowar, 0x8004200b);
+	out_be32(&priv->dbell_atmu_regs->rowbar,
+			(law_start + RIO_MAINT_WIN_SIZE) >> 12);
+	out_be32(&priv->dbell_atmu_regs->rowar, 0x8004200b);	/* 4k */
 	fsl_rio_doorbell_init(port);
 
 	return 0;
-- 
1.5.4
