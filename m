Return-Path: <timur@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6202B710C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2011 04:39:12 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <stable@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: fix compatible properties of the P1022DS DMA
	nodes used for audio
Date: Thu, 3 Feb 2011 11:39:04 -0600
Message-ID: <1296754744-22526-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to prevent the fsl_dma driver from claiming the DMA channels that the
P1022DS audio driver needs, the compatible properties for those nodes must say
"fsl,ssi-dma-channel" instead of "fsl,eloplus-dma-channel".

Commit b2e0861e51f2961954330dcafe6d148ee3ab5cff upstream.

Signed-off-by: Timur Tabi <timur@freescale.com>
Cc: stable@kernel.org
---
 arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 2bbecbb..69422eb 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -291,13 +291,13 @@
 			ranges = <0x0 0xc100 0x200>;
 			cell-index = <1>;
 			dma00: dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
+				compatible = "fsl,ssi-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
 				interrupts = <76 2>;
 			};
 			dma01: dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
+				compatible = "fsl,ssi-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
 				interrupts = <77 2>;
-- 
1.7.3.4
