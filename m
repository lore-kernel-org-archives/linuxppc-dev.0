Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 01B2BDE142
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 07:19:18 +1100 (EST)
Date: Tue, 30 Dec 2008 23:19:16 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20081230201916.GA20059@oksana.dev.rtsoft.ru>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds pcie nodes to the appropriate dts files, plus adds
some probing code for the boards.

Note that the nodes are disabled by default (via status property),
since old (community) U-Boots don't configure PCI-E controllers.

Also, remove of_device_is_avaliable() check from the mpc837x_mds.c
board file, as mpc83xx_add_bridge() has the same check now.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Dec 30, 2008 at 11:46:50AM -0600, Kumar Gala wrote:
[...]
>> +	pci1: pcie@e0009000 {
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		#interrupt-cells = <1>;
>> +		device_type = "pcie";
>
> should just be pci, not pcie

Fixed.

>>
>> +		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
>> +		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
>
> the size on the 0xb0000000 seems wrong

This is how FSL U-Boots configure the cfg window, and I'm trying to
retain the compatibility. Anyway, now Linux maps only the first 4kB
of that area, so we don't actually care about this, but dts is still
correct for older u-boots. Newer U-Boots might want to correct this
value if they want to use other cfg window setup...

>> +		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
>> +		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
>> +		bus-range = <0 0>;
>
> normally we have this as <0 255> and assume FW updates it.

Fixed.

>>
>> +		interrupt-map-mask = <0xf800 0 0 7>;
>> +		interrupt-map = <0 0 0 1 &ipic 1 8
>> +				 0 0 0 2 &ipic 1 8
>> +				 0 0 0 3 &ipic 1 8
>> +				 0 0 0 4 &ipic 1 8>;
>> +		clock-frequency = <0>;
>> +		/* cleared by u-boot */
>> +		status = "not configured";
>
> for pcie nodes we also include the virtual p2p bridge look at the 85xx
> or 86xx .dts w/pcie in them.

Fixed.

Thanks for review,

 arch/powerpc/boot/dts/mpc8315erdb.dts     |   68 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   68 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   68 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   68 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   68 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    2 +
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   10 +---
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    2 +
 8 files changed, 347 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index d3d3097..eb3c4ad 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -22,6 +22,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -330,4 +332,70 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 0484561..902d8f2 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -23,6 +23,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -390,4 +392,70 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 9fe8e4c..cfed419 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -22,6 +22,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -331,4 +333,70 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 67a08d2..67d0802 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -23,6 +23,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -376,4 +378,70 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 3a6d528..287e0b2 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -22,6 +22,8 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -317,4 +319,70 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	pci1: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 1 8
+				 0 0 0 2 &ipic 1 8
+				 0 0 0 3 &ipic 1 8
+				 0 0 0 4 &ipic 1 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xa0000000
+				  0x02000000 0 0xa0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
+
+	pci2: pcie@e000a000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8378-pcie", "fsl,mpc8314-pcie";
+		reg = <0xe000a000 0x00001000 0xd0000000 0x01000000>;
+		ranges = <0x02000000 0 0xc0000000 0xc0000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x00800000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &ipic 2 8
+				 0 0 0 2 &ipic 2 8
+				 0 0 0 3 &ipic 2 8
+				 0 0 0 4 &ipic 2 8>;
+		clock-frequency = <0>;
+		/* cleared by u-boot */
+		status = "not configured";
+
+		pcie@0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			reg = <0 0 0 0 0>;
+			ranges = <0x02000000 0 0xc0000000
+				  0x02000000 0 0xc0000000
+				  0 0x10000000
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00800000>;
+		};
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 5177bdd..b690fd7 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -38,6 +38,8 @@ static void __init mpc831x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc831x_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 530ef99..634785c 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -84,14 +84,10 @@ static void __init mpc837x_mds_setup_arch(void)
 		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
-		if (!of_device_is_available(np)) {
-			pr_warning("%s: disabled by the firmware.\n",
-				   np->full_name);
-			continue;
-		}
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
 		mpc83xx_add_bridge(np);
-	}
 #endif
 	mpc837xmds_usb_cfg();
 }
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 1d09654..3d7b953 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -38,6 +38,8 @@ static void __init mpc837x_rdb_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
+	for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
+		mpc83xx_add_bridge(np);
 #endif
 	mpc837x_usb_cfg();
 }
-- 
1.5.6.5
