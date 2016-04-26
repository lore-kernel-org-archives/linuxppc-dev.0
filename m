Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFR4qx7zDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:39 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 23/23] powerpc/4xx: Device tree update for the 460ex DWC
 SATA
Date: Tue, 26 Apr 2016 12:03:24 +0300
Message-Id: <1461661404-1952-24-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device tree update for the Applied micro processor 460ex on-chip SATA to use
"dmas" property.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/boot/dts/canyonlands.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 3dc75de..549c24c 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -190,12 +190,21 @@
 					 /* DMA */ 0x2 &UIC0 0xc 0x4>;
 		};
 
+		AHBDMA: dma@bffd0800 {
+			compatible = "snps,dma-spear1340";
+			reg = <4 0xbffd0800 0x400>;
+			interrupt-parent = <&UIC3>;
+			interrupts = <0x5 0x4>;
+			#dma-cells = <3>;
+		};
+
 		SATA0: sata@bffd1000 {
 			compatible = "amcc,sata-460ex";
-			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+			reg = <4 0xbffd1000 0x800>;
 			interrupt-parent = <&UIC3>;
-			interrupts = <0x0 0x4       /* SATA */
-				      0x5 0x4>;     /* AHBDMA */
+			interrupts = <0x0 0x4>;
+			dmas = <&AHBDMA 0 1 0>;
+			dma-names = "sata-dma";
 		};
 
 		POB0: opb {
-- 
2.8.0.rc3
