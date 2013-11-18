Return-Path: <Jason.Jin@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8C152C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 18:34:05 +1100 (EST)
From: Jason Jin <Jason.Jin@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH V3] powerpc: Add a vga alias node for P1022
Date: Mon, 18 Nov 2013 14:48:03 +0800
Message-ID: <1384757283-18113-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In u-boot, when set the video as console, the name 'vga' is used
as a general name for the video device, during the fdt_fixup_stdout
process, the 'vga' name is used to search in the dtb to setup the
'linux,stdout-path' node. Though the P1022 DIU is not VGA-compatible
device,
to meet the 'vga' name used in u-boot, the vga alias node is added for
P1022 in this patch. At the same time, a display alias is also added
so that no other components grow dependencies on the vga alias node.

Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
---
V2: Update the description and also add a display alias.
V3: Add code comment for the inaccurate vag name. Thanks for Scott's input.

 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index e179803..be49300 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -174,7 +174,7 @@
 
 /include/ "pq3-gpio-0.dtsi"
 
-	display@10000 {
+	display: display@10000 {
 		compatible = "fsl,diu", "fsl,p1022-diu";
 		reg = <0x10000 1000>;
 		interrupts = <64 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
index 1956dea..362ac51 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
@@ -50,6 +50,9 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		/*inaccurate vga name for U-Boot compatibility*/
+		vga = &display;
+		display = &display;
 	};
 
 	cpus {
-- 
1.8.0
