Return-Path: <afleming@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTGS90B4tzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 05:12:09 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id v82so9710572oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 12:12:08 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH 1/3] cyrus: Add poweroff/reset support
Date: Tue,  6 Sep 2016 14:11:57 -0500
Message-Id: <1473189119-29458-2-git-send-email-afleming@gmail.com>
In-Reply-To: <1473189119-29458-1-git-send-email-afleming@gmail.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyrus uses GPIOs to complete board shutdown/reset.
Add nodes to indicate that support to the device tree.

Signed-off-by: Andy Fleming <afleming@gmail.com>
---
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
index c603390..e417aaa 100644
--- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
+++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
@@ -150,6 +150,17 @@
 				  0 0x00010000>;
 		};
 	};
+
+        gpio-poweroff {
+                compatible = "gpio-poweroff";
+                gpios = <&gpio0 3 1>;
+        };
+
+        gpio-restart {
+                compatible = "gpio-restart";
+                gpios = <&gpio0 2 1>;
+        };
+
 };
 
 /include/ "p5020si-post.dtsi"
-- 
1.9.1
