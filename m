Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 67180100DD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 20:57:51 +1100 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4 v4] powerpc, video: add SM501 support for charon board.
Date: Mon, 24 Jan 2011 10:57:48 +0100
Message-Id: <1295863068-11205-1-git-send-email-hs@denx.de>
In-Reply-To: <1291451028-22532-2-git-send-email-hs@denx.de>
References: <1291451028-22532-2-git-send-email-hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: linux-fbdev@vger.kernel.org
cc: devicetree-discuss@ozlabs.org
cc: Ben Dooks <ben@simtec.co.uk>
cc: Vincent Sanders <vince@simtec.co.uk>
cc: Samuel Ortiz <sameo@linux.intel.com>
cc: linux-kernel@vger.kernel.org

---
- changes since v1:
  - no board specific defconfig file for mpc52xx based boards as suggested
    from Wolfram Sang

- changes since v2:
  add Ben Dooks, Vincent Sanders and Samuel Ortiz and lkml to cc, as
  suggested from Paul Mundt.

- changes since v3:
  - rebased against v2.6.38-rc2

./scripts/checkpatch.pl 0004-powerpc-video-add-SM501-support-for-charon-board.patch
total: 0 errors, 0 warnings, 22 lines checked

0004-powerpc-video-add-SM501-support-for-charon-board.patch has no obvious style problems and is ready for submission.

 arch/powerpc/boot/dts/charon.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
index 9776889..0e00e50 100644
--- a/arch/powerpc/boot/dts/charon.dts
+++ b/arch/powerpc/boot/dts/charon.dts
@@ -186,6 +186,7 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <	0 0 0xfc000000 0x02000000
+				1 0 0xe0000000 0x04000000 // CS1 range, SM501
 				3 0 0xe8000000 0x00080000>;
 
 		flash@0,0 {
@@ -197,6 +198,15 @@
 			#address-cells = <1>;
 		};
 
+		display@1,0 {
+			compatible = "smi,sm501";
+			reg = <1 0x00000000 0x00800000
+			       1 0x03e00000 0x00200000>;
+			mode = "640x480-32@60";
+			interrupts = <1 1 3>;
+			little-endian;
+		};
+
 		mram0@3,0 {
 			compatible = "mtd-ram";
 			reg = <3 0x00000 0x80000>;
-- 
1.7.3.4
