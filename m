Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C47D6679FB
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 03:30:02 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Date: Tue, 28 Mar 2006 20:14:32 +0400
Message-Id: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Updated the documentation to include the initial description of the CPM2
device that are used on PQII and PQIII families. Only initial sub-devices
described so far, but that should be sufficient to move the respective
boards to powerpc, with a reasonable minimum supporteddevice set.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 Documentation/powerpc/booting-without-of.txt |  149 ++++++++++++++++++++++++++
 1 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ee551c6..d44980c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1436,6 +1436,155 @@ platforms are moved over to use the flat
                descriptor-types-mask = <073f1127>;
        };
 
+   h) Freescale SOC communication processor module (CPM)
+	This represents cpm module that is installed on PQ (PowerQUICC)
+	series,1-st, 2-nd and 3-rd generation. Basically, is is a bus of devices,
+	both those that are inalienable cpm parts (BRGs, etc.), and those that could act
+	more or less as a complete entity (FCC, SCC). All af them should be
+	siblings on the "root" cpm node, using the common properties from
+	there. The description below applies to the CPM2 (2-nd rev. found on
+	PQ2 and PQ3) but I beleive could be extended to the PQ CPM1 as well
+	later.
+
+	1) Root cpm2 device
+	  Required properties:
+
+	    - device_type : Should be "cpm"
+	    - model : Model of the device.  Should be "CPM1" or "CPM2"
+    	    - reg : Offset and length of the register set for the device
+	    - command-proc : Offset to the CPM command processor
+
+	2) Baud-rate generators (BRG)
+          The CPM contains eight independent, identical baud-rate generators (BRGs) that can be
+          used with the FCCs, SCCs, and SMCs. The clocks produced by the BRGs are sent to the
+          bank-of-clocks selection logic, where they can be routed to the controllers. In addition, the
+          output of a BRG can be routed to a pin to be used externally.
+
+	  Required properties:
+
+	   - device_type : Should be "brg"
+	   - model : should be "BRGx", x relative to the BRG number (usually
+			   from 1 to 8)
+	   - reg : Offset to the configuration register (from cpm reg)
+	   - linux,phandle : phandle for this node; likely referenced by the CPM
+		   devices (SCC, FCC, SMC, etc.)
+
+	  Recommended properties:
+
+	   - clock-divider : 12-bit integer (internal counter that is decremented at the DIV16 output rate)
+	   - div16 : Either <0> or <1> the 1/16 prescalar before reaching the clock divider
+	   - ext-clock : Either <0> or phandle of the external clock source
+
+	3) CPM multiplexor
+	  CPM supports special NMSI mode of operation for its devices. In short,
+	  each serial device could be connected to the set of dedicated pins,
+	  and this pseudo-device controls such behavior. They are different for
+	  each device set, and could be recognised using "compatible" field.
+
+	  Required properties:
+
+	  - device_type : Should be "cpmux"
+	  - reg : offset to the configuration register
+	  - compatible : "fcc", "scc", or "smc"
+
+	4) SCCs (Serial Communications Controllers)
+
+	  Required properties:
+
+	  - device_type : "serial" or "network"
+	  - model : "SCCx", x is typically a small number depending on the
+	  devices amount
+	  - compatible : Either "fs_enet" or "cpm_uart"
+	  - reg : offset to the register set and its length
+	  - reg-pram : offset to the device parameter RAM
+	  - clock-setup : should be <CMX_RT CMX_MSK> where CMX_... values define
+	  multiplexor clock routing and clock mask respectively
+	  - interrupts : <a b> where a is the interrupt number and b is a
+		field that represents an encoding of the sense and level
+		information for the interrupt.  This should be encoded based on
+		the information in section 2) depending on the type of interrupt
+		controller you have.
+	  - interrupt-parent : the phandle for the interrupt controller that
+		services interrupts for this device.
+
+	5) FCCs (Fast Communications Controllers)
+
+	  Required properties:
+
+	  - device_type : should be "network"
+	  - model : "FCCx", x is typically a small number depending on the
+	  devices amount
+	  - compatible : should be "fs_enet"
+	  - address : List of bytes representing the ethernet address of
+		this controller
+	  - reg : offset to the register set and its length
+	  - reg-pram : offset to the device parameter RAM
+	  - clock-setup : should be <CMX_RT CMX_MSK> where CMX_... values define
+	  multiplexor clock routing and clock mask respectively
+	  - interrupts : <a b> where a is the interrupt number and b is a
+		field that represents an encoding of the sense and level
+		information for the interrupt.  This should be encoded based on
+		the information in section 2) depending on the type of interrupt
+		controller you have.
+	  - interrupt-parent : the phandle for the interrupt controller that
+		services interrupts for this device.
+	  - phy-handle : The phandle for the PHY connected to this ethernet
+		controller.
+   Example:
+ 	/*8272ADS*/
+	cpm@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "cpm";
+		model = "CPM2";
+		ranges = <0 f0000000 00100000>;
+		reg = <f0000000 000101a8>;
+		command-proc = <119c0>
+
+		brg@119f0 {
+			device_type = "brg";
+			model = "BRG1";
+			reg = <119f0>;
+			linux,phandle = <775>;
+		};
+
+		cpmux@11b04 {
+			device_type = "cpmux";
+			compatible = "fcc";
+			reg = <11b04>;
+		};
+
+		cpmux@11b08 {
+			device_type = "cpmux";
+			compatible = "scc";
+			reg = <11b08>;
+		};
+
+		scc@11a20 {
+			device_type = "serial";
+			compatible = "cpm_uart";
+			model = "SCC1";
+			reg = <11a20 100>;
+			reg_pram = <8000 ff>;
+			clock_setup = <0x00ffffff 0>;
+			interrupts = <28 3>;
+			interrupt-parent = <700>;
+			brg_phandle = <775>;
+		};
+
+		fcc@11300 {
+			device_type = "network";
+			compatible = "fs_enet";
+			model = "FCC1";
+			reg = <11300 1f>;
+			reg_pram = <8400 ff>;
+			address = [00 00 00 00 00 00];
+			interrupts = <20 3>;
+			interrupt-parent = <700>;
+			phy_handle = <2452000>;
+		};
+	};
 
    More devices will be defined as this spec matures.
 
