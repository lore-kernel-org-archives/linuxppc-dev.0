Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE28DDE282
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 02:51:48 +1100 (EST)
Date: Fri, 28 Mar 2008 10:51:33 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] sata_fsl: reduce compatibility to fsl,pq-sata
Message-Id: <20080328105133.43eb4fb1.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

as prescribed in Documentation/powerpc/booting-without-of.txt.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8379_mds.dts |    8 ++++----
 drivers/ata/sata_fsl.c                |    5 +----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 49c05e9..eac8e1b 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -255,14 +255,14 @@
 		};
 
 		sata@18000 {
-			compatible = "fsl,mpc8379-sata";
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
-			compatible = "fsl,mpc8379-sata";
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index fdb4a92..6f78a9f 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -255,28 +255,28 @@
 		};
 
 		sata@18000 {
-			compatible = "fsl,mpc8379-sata";
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
 		sata@19000 {
-			compatible = "fsl,mpc8379-sata";
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
 		sata@1a000 {
-			compatible = "fsl,mpc8379-sata";
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x1a000 0x1000>;
 			interrupts = <46 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 
 		sata@1b000 {
-			compatible = "fsl,mpc8379-sata";
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
 			reg = <0x1b000 0x1000>;
 			interrupts = <47 0x8>;
 			interrupt-parent = <&ipic>;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 07791a7..4c19855 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1348,10 +1348,7 @@ static int sata_fsl_remove(struct of_device *ofdev)
 
 static struct of_device_id fsl_sata_match[] = {
 	{
-		.compatible = "fsl,mpc8315-sata",
-	},
-	{
-		.compatible = "fsl,mpc8379-sata",
+		.compatible = "fsl,pq-sata",
 	},
 	{},
 };
-- 
1.5.4.4.481.g5075
