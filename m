Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2661BDE03F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 06:38:35 +1100 (EST)
Date: Tue, 3 Mar 2009 22:38:33 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH RFC] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090303193833.GA8941@oksana.dev.rtsoft.ru>
References: <20090303160201.GA3242@oksana.dev.rtsoft.ru>
	<20090303175746.GC8692@ld0162-tx32.am.freescale.net>
	<20090303183407.GA27678@oksana.dev.rtsoft.ru>
	<49AD796A.90601@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49AD796A.90601@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently it doesn't matter where the mdio nodes are placed, but with
power management support (i.e. when sleep = <> properties will take
effect), mdio nodes placement will become important: mdio controller
is a part of the ethernet block, so the mdio nodes should be placed
correctly. Otherwise we may wrongly assume that MDIO controllers are
available during sleep.

Suggested-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Mar 03, 2009 at 12:39:38PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
>> On Tue, Mar 03, 2009 at 11:57:46AM -0600, Scott Wood wrote:
>>> On Tue, Mar 03, 2009 at 07:02:01PM +0300, Anton Vorontsov wrote:
>>>>  		mdio@24520 {
>>>> @@ -226,6 +244,8 @@
>>>>  			interrupt-parent = <&ipic>;
>>>>  			tbi-handle = <&tbi0>;
>>>>  			phy-handle = <&phy2>;
>>>> +			sleep = <&pmc 0xc0000000>;
>>>> +			fsl,magic-packet;
>>>>  		};
>>> Note that this makes it look to the kernel like enet0 can be put to sleep
>>> without putting the mdio (which is shared with enet1) to sleep.  This is
>>> why I moved mdio under the ethernet node on 8313erdb.
>>
>> And that isn't absolutely correct either, since enet1 depends on
>> net0... If enet0's mdio goes into sleep mode before enet1, then
>> enet1 will fail to send power-down command to its PHY...
>
> But the kernel knows that enet1 depends on mdio0.  Getting the kernel to  
> act on that knowledge isn't the device tree's problem.

Well, that makes sense. I'd like to move mdio nodes in a separate
patch though, since the original patch becomes difficult to review
because of too many changes...

A question though... do we want real addr translation via ranges, or
the dummy "ranges;" are OK?

Here is the RFC. It's tested to work on MPC8377-RDB.

Please review carefully..

Thanks,

 arch/powerpc/boot/dts/mpc8315erdb.dts    |   84 ++++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8349emitx.dts   |   73 ++++++++++++++------------
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |   44 ++++++++-------
 arch/powerpc/boot/dts/mpc834x_mds.dts    |   85 ++++++++++++++++--------------
 arch/powerpc/boot/dts/mpc8377_mds.dts    |   84 ++++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8377_rdb.dts    |   71 ++++++++++++++-----------
 arch/powerpc/boot/dts/mpc8378_mds.dts    |   84 ++++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8378_rdb.dts    |   73 ++++++++++++++-----------
 arch/powerpc/boot/dts/mpc8379_mds.dts    |   83 ++++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8379_rdb.dts    |   70 ++++++++++++++-----------
 10 files changed, 413 insertions(+), 338 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 88d691c..ba355b5 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -190,66 +190,74 @@
 			phy_type = "utmi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&ipic>;
-				interrupts = <20 0x8>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&ipic>;
-				interrupts = <19 0x8>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = < &phy0 >;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&ipic>;
+					interrupts = <20 0x8>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&ipic>;
+					interrupts = <19 0x8>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = < &phy1 >;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index b5eda94..c42413a 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -170,57 +170,52 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			/* Vitesse 8201 */
-			phy1c: ethernet-phy@1c {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x1c>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				/* Vitesse 8201 */
+				phy1c: ethernet-phy@1c {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x1c>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
@@ -228,6 +223,18 @@
 			fixed-link = <1 1 1000 0 0>;
 			linux,network-index = <1>;
 			tbi-handle = <&tbi1>;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index c87a601..c8c6d8e 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -149,37 +149,41 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			/* Vitesse 8201 */
-			phy1c: ethernet-phy@1c {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x1c>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				/* Vitesse 8201 */
+				phy1c: ethernet-phy@1c {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x1c>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index d9adba0..86039a6 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -167,69 +167,76 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index cebfc50..c1afcbc 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -196,48 +196,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -246,14 +213,43 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -262,6 +258,18 @@
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 32311c8..c3d1fbe 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -248,42 +248,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -292,14 +265,36 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -308,6 +303,18 @@
 			tbi-handle = <&tbi1>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 155841d..fabdd82 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -235,48 +235,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -285,14 +252,43 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -301,6 +297,18 @@
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 54ad96c..e11ae76 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -248,64 +248,73 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
+			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
+			tbi-handle = <&tbi1>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 9deb5b2..143aa53 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -233,47 +233,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -282,14 +250,43 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -298,6 +295,18 @@
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 3f4778f..58145d0 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -246,41 +246,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x24000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -289,14 +263,36 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@24520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x24520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <0x25000 0x1000>;
+			ranges;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -305,6 +301,18 @@
 			tbi-handle = <&tbi1>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@25520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x25520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
-- 
1.5.6.5
