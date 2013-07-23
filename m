Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC2EE2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 13:50:40 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] Powerpc: Add 3.3v voltage support for T4240QDS
Date: Tue, 23 Jul 2013 10:59:05 +0800
Message-ID: <1374548345-15017-2-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
References: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r39252@freescale.com, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 scottwood@freescale.com, cjb@laptop.org,
 Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale T4240QDS reference board has extra voltage shifters added
to allow 3.3V operation, so add 3.3v voltage support for T4240QDS.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for this patch set:
	- split from patch [PATCH 1/2] Powerpc: Add
	- voltage ranges support for T4

 arch/powerpc/boot/dts/t4240qds.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 0555976..5beccdd 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -148,6 +148,11 @@
 				interrupts = <0x1 0x1 0 0>;
 			};
 		};
+
+		sdhc@114000 {
+			compatible = "fsl,t4240-esdhc", "fsl,esdhc";
+			voltage-ranges = <1800 1800 3300 3300>;
+		};
 	};
 
 	pci0: pcie@ffe240000 {
-- 
1.8.0
