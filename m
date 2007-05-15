Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id DA292DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:23:36 +1000 (EST)
Received: from [10.50.1.88] (rhino.az.mvista.com [10.50.1.88])
	by hermes.mvista.com (Postfix) with ESMTP id E2C311CF56
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:23:35 -0700 (PDT)
Subject: [PATCH 1/5] Add MTD support to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1179245829.8132.100.camel@rhino>
References: <1179245829.8132.100.camel@rhino>
Content-Type: text/plain
Date: Tue, 15 May 2007 09:23:35 -0700
Message-Id: <1179246215.8132.107.camel@rhino>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -335,4 +335,17 @@
 			big-endian;
 		};
 	};
+
+	flash@ff800000 {
+		device_type = "rom";
+		compatible = "direct-mapped";
+		probe-type = "CFI";
+		reg = <ff800000 00800000>;
+		bank-width = <2>;
+		partitions = <00000000 00300000
+			      00300000 00100000
+			      00400000 00300000
+			      00700000 00100000>;
+		partition-names = "kernel", "firmware b", "fs", "firmware a";
+	};
 };
