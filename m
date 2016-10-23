Return-Path: <afleming@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2GMf2CtQzDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:48:46 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id e5so6209176ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 16:48:46 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH v2 1/3] cyrus: Add poweroff/reset support
Date: Sun, 23 Oct 2016 18:48:37 -0500
Message-Id: <1477266519-25173-1-git-send-email-afleming@gmail.com>
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
v2: No changes

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
