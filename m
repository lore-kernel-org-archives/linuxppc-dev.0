Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9A1B9DDDFB
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 11:23:54 +1100 (EST)
Date: Sat, 18 Oct 2008 04:23:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: remove device_type = "board-control"
Message-ID: <20081018002352.GA9661@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't want to encourage the bogus device_type usage.

The device type isn't used in the code, so we can simply remove it from
the documentation and dts files.

Boards should specify proper compatible entries instead.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Sat, Oct 11, 2008 at 05:56:18PM +1100, David Gibson wrote:
[...]
> > +Example:
> > +
> > +	bcsr@1,0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		device_type = "board-control";
> 
> This device_type field should not be used.  I know it is in the
> existing samples, which is another bug.  But please don't document it
> (and thereby further encourage it).

I didn't forget your comment. ;-) Here is a cleanup patch for
the documentation and dts files.

 Documentation/powerpc/dts-bindings/fsl/board.txt |    6 +++---
 arch/powerpc/boot/dts/mpc832x_mds.dts            |    2 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts            |    2 +-
 arch/powerpc/boot/dts/mpc836x_mds.dts            |    2 +-
 arch/powerpc/boot/dts/mpc8568mds.dts             |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/board.txt b/Documentation/powerpc/dts-bindings/fsl/board.txt
index e97877f..2bd9888 100644
--- a/Documentation/powerpc/dts-bindings/fsl/board.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/board.txt
@@ -2,13 +2,13 @@
 
 Required properties:
 
- - device_type : Should be "board-control"
+ - compatible : Should be "fsl,<board>-bcsr"
  - reg : Offset and length of the register set for the device
 
 Example:
 
 	bcsr@f8000000 {
-		device_type = "board-control";
+		compatible = "fsl,mpc8360mds-bcsr";
 		reg = <f8000000 8000>;
 	};
 
@@ -46,7 +46,7 @@ Example:
 	bcsr@1,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		device_type = "board-control";
+		compatible = "fsl,mpc8360mds-bcsr";
 		reg = <1 0 0x8000>;
 		ranges = <0 1 0 0x8000>;
 
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index e4cc176..57c595b 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -60,7 +60,7 @@
 	};
 
 	bcsr@f8000000 {
-		device_type = "board-control";
+		compatible = "fsl,mpc8323mds-bcsr";
 		reg = <0xf8000000 0x8000>;
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 04bfde3..c986c54 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -49,7 +49,7 @@
 	};
 
 	bcsr@e2400000 {
-		device_type = "board-control";
+		compatible = "fsl,mpc8349mds-bcsr";
 		reg = <0xe2400000 0x8000>;
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index bdb14ba..98443fc 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -71,7 +71,7 @@
 		bcsr@1,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			device_type = "board-control";
+			compatible = "fsl,mpc8360mds-bcsr";
 			reg = <1 0 0x8000>;
 			ranges = <0 1 0 0x8000>;
 
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index a15f103..c80158f 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -52,7 +52,7 @@
 	};
 
 	bcsr@f8000000 {
-		device_type = "board-control";
+		compatible = "fsl,mpc8568mds-bcsr";
 		reg = <0xf8000000 0x8000>;
 	};
 
-- 
1.5.6.3
