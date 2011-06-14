Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9AF8DB6FAB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 15:22:31 +1000 (EST)
Received: by eyg5 with SMTP id 5so1855952eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 22:22:25 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tqm8540: add description for onboard flash
Date: Tue, 14 Jun 2011 09:22:27 +0400
Message-Id: <1308028947-8738-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/tqm8540.dts |   40 +++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index b5c0940..987c862 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -278,6 +278,46 @@
 		};
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8540-localbus", "fsl,pq3-localbus",
+			     "simple-bus";
+		reg = <0xe0005000 0x1000>;
+
+		ranges = <0x0 0x0 0xfe000000 0x02000000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x02000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			partition@0 {
+				label = "kernel";
+				reg = <0x00000000 0x00180000>;
+			};
+			partition@180000 {
+				label = "root";
+				reg = <0x00180000 0x01dc0000>;
+			};
+			partition@1f40000 {
+				label = "env1";
+				reg = <0x01f40000 0x00040000>;
+			};
+			partition@1f80000 {
+				label = "env2";
+				reg = <0x01f80000 0x00040000>;
+			};
+			partition@1fc0000 {
+				label = "u-boot";
+				reg = <0x01fc0000 0x00040000>;
+				read-only;
+			};
+		};
+	};
+
 	pci0: pci@e0008000 {
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
-- 
1.7.5.3
