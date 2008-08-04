Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id F333DDDDE2
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 18:47:30 +1000 (EST)
Date: Mon, 4 Aug 2008 11:46:11 +0300
From: Adrian Bunk <bunk@kernel.org>
To: ashish kalra <ashish.kalra@freescale.com>,
	Li Yang <leoli@freescale.com>, Jeff Garzik <jeff@garzik.org>,
	galak@kernel.crashing.org
Subject: [2.6 patch] sata_fsl.c: fix 8315DS workaround
Message-ID: <20080804084611.GA6088@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, "Robert P. J. Day" <rpjday@crashcourse.ca>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit e7eac96e8f0e57a6e9f94943557bc2b23be31471 (ata/sata_fsl: Move 
MPC8315DS link speed limit workaround to specific ifdef) aimed at 
limiting the workaround only to the affected hardware, but since the 
#ifdef used a nonexisting kconfig variable it actually killed
the workaround.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
cd54dd8b6a8bca44ead212d12fe116702cc31ed7 
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 3924e72..45878ef 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -640,7 +640,7 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
 	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
 
-#ifdef CONFIG_MPC8315_DS
+#ifdef CONFIG_MPC831x_RDB
 	/*
 	 * Workaround for 8315DS board 3gbps link-up issue,
 	 * currently limit SATA port to GEN1 speed
