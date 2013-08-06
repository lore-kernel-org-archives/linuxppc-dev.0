Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5D15D2C0391
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:46:18 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 14/31] dts: mpc512x: prepare for preprocessor support
Date: Tue,  6 Aug 2013 22:43:54 +0200
Message-Id: <1375821851-31609-15-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prepare C preprocessor support when processing MPC512x DTS files
- switch from DTS syntax to CPP syntax for include specs
- create a symlink such that DTS processing can reference includes

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts          |    2 +-
 arch/powerpc/boot/dts/include/dt-bindings |    1 +
 arch/powerpc/boot/dts/mpc5121ads.dts      |    2 +-
 arch/powerpc/boot/dts/pdm360ng.dts        |    2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 120000 arch/powerpc/boot/dts/include/dt-bindings

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a27a460..a543c40 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -10,7 +10,7 @@
  */
 
 
-/include/ "mpc5121.dtsi"
+#include <mpc5121.dtsi>
 
 / {
 	model = "ac14xx";
diff --git a/arch/powerpc/boot/dts/include/dt-bindings b/arch/powerpc/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/powerpc/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index 7d3cb79..c228a0a 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "mpc5121.dtsi"
+#include <mpc5121.dtsi>
 
 / {
 	model = "mpc5121ads";
diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 7433740..871c16d 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -13,7 +13,7 @@
  * option) any later version.
  */
 
-/include/ "mpc5121.dtsi"
+#include <mpc5121.dtsi>
 
 / {
 	model = "pdm360ng";
-- 
1.7.10.4
