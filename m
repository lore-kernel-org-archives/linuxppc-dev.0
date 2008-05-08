Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 8DBEADE1D6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 00:20:54 +1000 (EST)
Date: Thu, 8 May 2008 18:20:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] [POWERPC] fsl_uli1575: change RTC quirk to work on
	MPC8610HPCD
Message-ID: <20080508142053.GC7172@polina.dev.rtsoft.ru>
References: <20080508142005.GA6749@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080508142005.GA6749@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently fsl_uli1575.c's RTC quirk reads at ->start, but I got the RTC
working on the MPC8610HPCD only when reading at 0xa0100000-0xafffffff,
i.e. memory outside of behind-the-bridge devices' assigned regions.

This patch wasn't tested on the MPC85xxDS and MPC8641HPCN boards, I
don't have any of these.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 +
 arch/powerpc/platforms/fsl_uli1575.c       |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 2fa672b..71dbd9d 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -229,6 +229,7 @@ MACH_PCI_FIXUP_HEADER(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575
 MACH_PCI_FIXUP_HEADER(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5288, hpcd_quirk_uli5288);
 MACH_PCI_FIXUP_HEADER(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5229, hpcd_quirk_uli5229);
 MACH_PCI_FIXUP_FINAL(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
+MACH_PCI_FIXUP_FINAL(mpc86xx_hpcd, PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
 #endif /* CONFIG_PCI */
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 63ea4eb..a1b400a 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -221,7 +221,7 @@ void __devinit quirk_final_uli5249(struct pci_dev *dev)
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		if ((bus->resource[i]) &&
 			(bus->resource[i]->flags & IORESOURCE_MEM)) {
-			dummy = ioremap(bus->resource[i]->start, 0x4);
+			dummy = ioremap(bus->resource[i]->end - 3, 0x4);
 			if (dummy) {
 				in_8(dummy);
 				iounmap(dummy);
-- 
1.5.5.1
