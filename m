Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40BAFDDF85
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:29:59 +1000 (EST)
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Date: Sat, 25 Aug 2007 13:29:54 +0400
Message-ID: <20070825092954.4087.95333.stgit@localhost.localdomain>
In-Reply-To: <20070825091440.4087.1428.stgit@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Stefan Roese <sr@denx.de>

---

 arch/powerpc/boot/dts/sequoia.dts |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index ef6f41c..8eb258f 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -92,6 +92,32 @@
 		#size-cells = <1>;
 		ranges;
 		clock-frequency = <0>; /* Filled in by zImage */
+		
+		pci {
+			/* irqs are routed to irq67, dependless of devsel/PIRQx */
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &UIC2 3 8>;	
+
+			interrupt-parent = <&UIC2>;
+			interrupts = <3 8>;
+	    
+			bus-range = <0 0>;
+	
+			/* 
+			 * mem is at 80000000 set up indirectly
+			 * io is at 0001_e800_0000
+			 */
+			ranges = <02000000 0 80000000 1 80000000 0 10000000
+				01000000 0 00000000 1 e8000000 0 00100000>;
+
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+
+    			reg = <1 eec00000 40 1 ef400000 40>;  /* phb cfg, phb reg */
+			compatible = "ibm, 440epx";
+			device_type = "pci";
+		};
 
 		SDRAM0: sdram {
 			device_type = "memory-controller";
