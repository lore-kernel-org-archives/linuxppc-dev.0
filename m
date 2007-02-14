Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 337B3DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:29:16 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org, g.liakhovetski@gmx.de
Subject: [PATCH v3] powerpc: delete boot-cpu property from all DTS files
Date: Wed, 14 Feb 2007 15:29:07 -0600
Message-Id: <11714885473600-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 'linux,boot-cpu' property is obsolete, so remove it from all of the DTS
files and from booting-without-of.txt.  The boot CPU is actually defined in
the device tree header, and U-Boot sets that field.  The device tree compiler
also complains if the property exists.

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

Note: The '64-bit' property is already defined by the OF PPC binding and is
added to show an example of a property without a value.  We're not actually
adding a new property definition.

 Documentation/powerpc/booting-without-of.txt |    5 ++---
 arch/powerpc/boot/dts/kuroboxHD.dts          |    1 -
 arch/powerpc/boot/dts/kuroboxHG.dts          |    1 -
 arch/powerpc/boot/dts/mpc7448hpc2.dts        |    1 -
 arch/powerpc/boot/dts/mpc8272ads.dts         |    1 -
 arch/powerpc/boot/dts/mpc8323emds.dts        |    1 -
 arch/powerpc/boot/dts/mpc8360emds.dts        |    1 -
 arch/powerpc/boot/dts/mpc8560ads.dts         |    1 -
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    1 -
 arch/powerpc/boot/dts/mpc866ads.dts          |    1 -
 arch/powerpc/boot/dts/mpc885ads.dts          |    1 -
 11 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 3b51467..c539bfc 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -497,7 +497,7 @@ looks like in practice.
       |   |- device_type = "cpu"
       |   |- reg = <0>
       |   |- clock-frequency = <5f5e1000>
-      |   |- linux,boot-cpu
+      |   |- 64-bit
       |   |- linux,phandle = <2>
       |
       o memory@0
@@ -519,7 +519,7 @@ physical memory layout.  It also includes misc information passed
 through /chosen, like in this example, the platform type (mandatory)
 and the kernel command line arguments (optional).

-The /cpus/PowerPC,970@0/linux,boot-cpu property is an example of a
+The /cpus/PowerPC,970@0/64-bit property is an example of a
 property without a value. All other properties have a value. The
 significance of the #address-cells and #size-cells properties will be
 explained in chapter IV which defines precisely the required nodes and
@@ -778,7 +778,6 @@ address which can extend beyond that limit.
       bytes
     - d-cache-size : one cell, size of L1 data cache in bytes
     - i-cache-size : one cell, size of L1 instruction cache in bytes
-    - linux, boot-cpu : Should be defined if this cpu is the boot cpu.

   Recommended properties:

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 096e94a..b897918 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -35,7 +35,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"

 		PowerPC,603e { /* Really 8241 */
 			linux,phandle = <2100>;
-			linux,boot-cpu;
 			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <bebc200>;	/* Fixed by bootwrapper */
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index d06b0b0..7531027 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -35,7 +35,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"

 		PowerPC,603e { /* Really 8241 */
 			linux,phandle = <2100>;
-			linux,boot-cpu;
 			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index c4d9562..4164351 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -36,7 +36,6 @@
 			bus-frequency = <0>;		// From U-Boot
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 26b44f7..260b2e4 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -34,7 +34,6 @@
                        clock-frequency = <0>;
                        32-bit;
                        linux,phandle = <201>;
-                       linux,boot-cpu;
                };
        };

diff --git a/arch/powerpc/boot/dts/mpc8323emds.dts b/arch/powerpc/boot/dts/mpc8323emds.dts
index fa7ef24..eaf0f86 100644
--- a/arch/powerpc/boot/dts/mpc8323emds.dts
+++ b/arch/powerpc/boot/dts/mpc8323emds.dts
@@ -34,7 +34,6 @@
 			clock-frequency = <0>;
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc8360emds.dts b/arch/powerpc/boot/dts/mpc8360emds.dts
index 9022192..303bd66 100644
--- a/arch/powerpc/boot/dts/mpc8360emds.dts
+++ b/arch/powerpc/boot/dts/mpc8360emds.dts
@@ -39,7 +39,6 @@
 			clock-frequency = <1F78A400>;
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 119bd5d..c74d6eb 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -35,7 +35,6 @@
 			clock-frequency = <312c8040>;
 			32-bit;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index f0c7731..258fccb 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -32,7 +32,6 @@
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
 			32-bit;
-			linux,boot-cpu;
 		};
 		PowerPC,8641@1 {
 			device_type = "cpu";
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 5d40052..2b56b5d 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -37,7 +37,6 @@
 			interrupts = <f 2>;	// decrementer interrupt
 			interrupt-parent = <ff000000>;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index cf1a19f..faecd08 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -37,7 +37,6 @@
 			interrupts = <f 2>;	// decrementer interrupt
 			interrupt-parent = <ff000000>;
 			linux,phandle = <201>;
-			linux,boot-cpu;
 		};
 	};

--
1.5.0
