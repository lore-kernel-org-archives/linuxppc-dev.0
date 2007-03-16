Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 69922DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 07:03:45 +1100 (EST)
Received: from ubuntu (achn-4db49b59.pool.einsundeins.de [77.180.155.89])
	by post.webmailer.de (mrclete mo61) (RZmta 5.1)
	with ESMTP id D04882j2GI5cDx for <linuxppc-dev@ozlabs.org>;
	Fri, 16 Mar 2007 21:03:43 +0100 (MET)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Fix PCIX configuration of Ocotea & Taishan for > 512MB
	DDR
Date: Fri, 16 Mar 2007 21:06:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703162106.00855.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[PATCH] ppc: Fix PCIX configuration of Ocotea & Taishan for > 512MB DDR

Change the configuration of the PCIX PCI->PLB inbound memory window
to be 2GB instead of 512kB. The comment already mentioned 2GB, but the
code unfortunately didn't reflect this.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 7eb6a3d9d0d0dadd5634d6c7c3fd262652076355
tree 620c232e5cf39d5cf905ec503f4fc86456cef104
parent 2553194704512d8a00d6e50b9e780ecc87d1ca2a
author Stefan Roese <sr@denx.de> Fri, 16 Mar 2007 20:57:00 +0100
committer Stefan Roese <sr@denx.de> Fri, 16 Mar 2007 20:57:00 +0100

 arch/ppc/platforms/4xx/ocotea.c  |    2 +-
 arch/ppc/platforms/4xx/taishan.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
index 14780eb..626264a 100644
--- a/arch/ppc/platforms/4xx/ocotea.c
+++ b/arch/ppc/platforms/4xx/ocotea.c
@@ -178,7 +178,7 @@ ocotea_setup_pcix(void)
 	/* Setup 2GB PCI->PLB inbound memory window at 0, enable MSIs */
 	PCIX_WRITEL(0x00000000, PCIX0_PIM0LAH);
 	PCIX_WRITEL(0x00000000, PCIX0_PIM0LAL);
-	PCIX_WRITEL(0xe0000007, PCIX0_PIM0SA);
+	PCIX_WRITEL(0x80000007, PCIX0_PIM0SA);
 
 	eieio();
 }
diff --git a/arch/ppc/platforms/4xx/taishan.c b/arch/ppc/platforms/4xx/taishan.c
index bb0253e..5d9af8d 100644
--- a/arch/ppc/platforms/4xx/taishan.c
+++ b/arch/ppc/platforms/4xx/taishan.c
@@ -235,7 +235,7 @@ taishan_setup_pcix(void)
 	/* Setup 2GB PCI->PLB inbound memory window at 0, enable MSIs */
 	PCIX_WRITEL(0x00000000, PCIX0_PIM0LAH);
 	PCIX_WRITEL(0x00000000, PCIX0_PIM0LAL);
-	PCIX_WRITEL(0xe0000007, PCIX0_PIM0SA);
+	PCIX_WRITEL(0x80000007, PCIX0_PIM0SA);
 	PCIX_WRITEL(0xffffffff, PCIX0_PIM0SAH);
 
 	iounmap(pcix_reg_base);
