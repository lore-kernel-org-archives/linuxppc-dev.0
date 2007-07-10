Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02573DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:23:30 +1000 (EST)
Date: Tue, 10 Jul 2007 00:23:10 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: bzolnier@gmail.com
Subject: [PATCH] ide: Use inline function for eieio
Message-ID: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move to using inline function variant of eieio instead of inline assmebly.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit ff6ce6329e19cb82ee12447fe16c76c3dae7c1f4
tree ef830cd02624a79d7fa8c33b41f7229ff25a7d77
parent b30083183bf4987c8f7e9a8f753002a7ca5dc084
author Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jul 2007 00:13:54 -0500
committer Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jul 2007 00:13:54 -0500

 drivers/ide/pci/scc_pata.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
index 55bc0a3..b9fd2ac 100644
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -165,9 +165,9 @@ scc_ide_outbsync(ide_drive_t * drive, u8 addr, unsigned long port)
 	ide_hwif_t *hwif = HWIF(drive);

 	out_be32((void*)port, addr);
-	__asm__ __volatile__("eieio":::"memory");
+	eieio();
 	in_be32((void*)(hwif->dma_base + 0x01c));
-	__asm__ __volatile__("eieio":::"memory");
+	eieio();
 }

 static void
