Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D3729DDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 09:04:03 +1000 (EST)
Date: Thu, 12 Jun 2008 03:04:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: fsl_uli1575: fix RTC quirk to work on
	MPC8572DS and MPC8610HPCD
Message-ID: <20080611230402.GA21351@polina.dev.rtsoft.ru>
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080611230250.GA13412@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes RTC on MPC8572DS boards: dummy read helps only when
reading at the end of the bridge's memory (i.e. outside of behind the
bridge devices' assigned regions).

With this change the quirk also makes RTC work on MPC8610HPCD, so it's
unlikely that this will break MPC8641HPCN or MPC8544DS boards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/fsl_uli1575.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index afc9141..756561c 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -221,7 +221,7 @@ static void __devinit quirk_final_uli5249(struct pci_dev *dev)
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		if ((bus->resource[i]) &&
 			(bus->resource[i]->flags & IORESOURCE_MEM)) {
-			dummy = ioremap(bus->resource[i]->start, 0x4);
+			dummy = ioremap(bus->resource[i]->end - 3, 0x4);
 			if (dummy) {
 				in_8(dummy);
 				iounmap(dummy);
-- 
1.5.5.4
