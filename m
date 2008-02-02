Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 491BFDDE30
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 06:02:56 +1100 (EST)
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix storcenter DTS typos, feedback, IRQs.
Date: Sat, 02 Feb 2008 13:02:51 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JLNdb-0002G5-Cd@jdl.com>
Cc: andy@protium.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Cleaned up IRQ layout and removed unsused ISU allocations.
Fixed RTC address typo from /dts-v1/ conversion.
Incorporated list suggestions to use an "iomega," vendor prefix,
and to use a node reference rather than a hard path.

Signed-off-by: Jon Loeliger <jdl@@jdl.com>
---

Kumar,

I tried to use one large, linear IRQ block and shift the
IRQs up to, like, around 129 or so, but it did not work.
This patch definitely works, so I suspect some issue trying
to setup (non-)IRQs between 0x50000 and 0x51000 or so.  Ick.

In any even, this is defintely a valid bug fix.  If you
would, please pick up for 2.6.25.

Thanks,
jdl


 arch/powerpc/boot/dts/storcenter.dts            |   12 +++++-----
 arch/powerpc/platforms/embedded6xx/storcenter.c |   25 ++++------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
index 2204874..5893816 100644
--- a/arch/powerpc/boot/dts/storcenter.dts
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "StorCenter";
-	compatible = "storcenter";
+	compatible = "iomega,storcenter";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -62,12 +62,12 @@
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <5 2>;
+			interrupts = <17 2>;
 			interrupt-parent = <&mpic>;
 
 			rtc@68 {
 				compatible = "dallas,ds1337";
-				reg = <68>;
+				reg = <0x68>;
 			};
 		};
 
@@ -78,7 +78,7 @@
 			reg = <0x4500 0x20>;
 			clock-frequency = <97553800>; /* Hz */
 			current-speed = <115200>;
-			interrupts = <9 2>;
+			interrupts = <25 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -89,7 +89,7 @@
 			reg = <0x4600 0x20>;
 			clock-frequency = <97553800>; /* Hz */
 			current-speed = <9600>;
-			interrupts = <10 2>;
+			interrupts = <26 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -136,6 +136,6 @@
 	};
 
 	chosen {
-		linux,stdout-path = "/soc/serial@4500";
+		linux,stdout-path = &serial0;
 	};
 };
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index e12e9d2..8864e48 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -132,33 +132,18 @@ static void __init storcenter_init_IRQ(void)
 
 	paddr = (phys_addr_t)of_translate_address(dnp, prop);
 	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET,
-			4, 32, " EPIC     ");
+			16, 32, " OpenPIC  ");
 
 	of_node_put(dnp);
 
 	BUG_ON(mpic == NULL);
 
-	/* PCI IRQs */
 	/*
-	 * 2.6.12 patch:
-	 *         openpic_set_sources(0, 5, OpenPIC_Addr + 0x10200);
-	 *         openpic_set_sources(5, 2, OpenPIC_Addr + 0x11120);
-	 *         first_irq, num_irqs, __iomem first_ISR
-	 *         o_ss: i, src: 0, fdf50200
-	 *         o_ss: i, src: 1, fdf50220
-	 *         o_ss: i, src: 2, fdf50240
-	 *         o_ss: i, src: 3, fdf50260
-	 *         o_ss: i, src: 4, fdf50280
-	 *         o_ss: i, src: 5, fdf51120
-	 *         o_ss: i, src: 6, fdf51140
+	 * 16 Serial Interrupts followed by 16 Internal Interrupts.
+	 * I2C is the second internal, so it is at 17, 0x11020.
 	 */
 	mpic_assign_isu(mpic, 0, paddr + 0x10200);
-	mpic_assign_isu(mpic, 1, paddr + 0x10220);
-	mpic_assign_isu(mpic, 2, paddr + 0x10240);
-	mpic_assign_isu(mpic, 3, paddr + 0x10260);
-	mpic_assign_isu(mpic, 4, paddr + 0x10280);
-	mpic_assign_isu(mpic, 5, paddr + 0x11120);
-	mpic_assign_isu(mpic, 6, paddr + 0x11140);
+	mpic_assign_isu(mpic, 1, paddr + 0x11000);
 
 	mpic_init(mpic);
 }
@@ -178,7 +163,7 @@ static int __init storcenter_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "storcenter");
+	return of_flat_dt_is_compatible(root, "iomega,storcenter");
 }
 
 define_machine(storcenter){
-- 
1.5.4.rc4.25.g81cc
