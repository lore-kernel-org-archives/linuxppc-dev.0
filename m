Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0116.outbound.protection.outlook.com [207.46.100.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0518D1A0CCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 01:16:30 +1100 (AEDT)
From: <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, <mpe@ellerman.id.au>,
 <madalin.bucur@freescale.com>, Igal Liberman <igal.liberman@freescale.com>
Subject: [PATCH] powerpc/mpc85xx: Update B4 FMan MURAM size
Date: Thu, 5 Nov 2015 12:23:06 +0200
Message-ID: <1446718986-11710-1-git-send-email-igal.liberman@freescale.com>
Reply-To: <igal.liberman@freescale.com>
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

From: Igal Liberman <igal.liberman@freescale.com>

FMan V3H has 2 different MURAM sizes:
    In B4860/4420 the MURAM size is 512KB.
    In T4240 and T2080 the MURAM size is 384KB.

The MURAM size in FMan V3H device tree is 384KB.
This patch updates the MURAM size for B4 to 512KB.

Based on prior submissions:
https://patchwork.ozlabs.org/patch/503921/
https://patchwork.ozlabs.org/patch/503922/

Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index d51e2bb..abadc28 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -473,6 +473,11 @@
 	fman@400000 {
 		interrupts = <96 2 0 0>, <16 2 1 30>;
 
+		muram@0 {
+			compatible = "fsl,fman-muram";
+			reg = <0x0 0x80000>;
+		};
+
 		enet0: ethernet@e0000 {
 		};
 
-- 
1.7.9.5
