Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 022A11A1DB7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 17:56:38 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
CC: <Jason.Jin@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: [PATCH] powerpc: Add a vga alias node for P1022
Date: Mon, 17 Aug 2015 15:50:57 +0800
Message-ID: <1439797857-32653-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Jin <Jason.Jin@freescale.com>

In u-boot, when set the video as console, the name 'vga' is used
as a general name for the video device, during the fdt_fixup_stdout
process, the 'vga' name is used to search in the dtb to setup the
'linux,stdout-path' node. Though the P1022 DIU is not VGA-compatible
device, to meet the 'vga' name used in u-boot, the vga alias node is
added for P1022 in this patch. At the same time, a display alias is
also added so that no other components grow dependencies on the vga
alias node.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index ebf2022..426bf41 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -175,7 +175,7 @@
 
 /include/ "pq3-gpio-0.dtsi"
 
-	display@10000 {
+	display: display@10000 {
 		compatible = "fsl,diu", "fsl,p1022-diu";
 		reg = <0x10000 1000>;
 		interrupts = <64 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
index 1956dea..de76ae8 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
@@ -50,6 +50,8 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		vga = &display;
+		display = &display;
 	};
 
 	cpus {
-- 
2.1.0.27.g96db324
