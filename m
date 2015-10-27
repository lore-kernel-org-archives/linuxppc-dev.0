Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AEDB1A0410
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 10:42:56 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] powerpc/fsl: Add #clock-cells and clockgen label to clockgen
 nodes
Date: Tue, 27 Oct 2015 18:42:35 -0500
Message-ID: <1445989355-8405-1-git-send-email-scottwood@freescale.com>
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

This allows new-style clock references to be used, which is needed for
fman.  The old clock nodes will be removed and all clock references
converted to new-style once the qoriq-cpufreq driver is updated to stop
depending on the old-style references in cpu nodes.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Patches to update the cpufreq driver have been posted, but they require
a change to include/linux/clk.h which is still awaiting a response from
Russell King.

 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
index 4ece1ed..88cd70d 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
@@ -32,13 +32,14 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-global-utilities@e1000 {
+clockgen: global-utilities@e1000 {
 	compatible = "fsl,qoriq-clockgen-1.0";
 	ranges = <0x0 0xe1000 0x1000>;
 	reg = <0xe1000 0x1000>;
 	clock-frequency = <0>;
 	#address-cells = <1>;
 	#size-cells = <1>;
+	#clock-cells = <2>;
 
 	sysclk: sysclk {
 		#clock-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
index 48e0b6e..6dfd7c5 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
@@ -32,12 +32,13 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-global-utilities@e1000 {
+clockgen: global-utilities@e1000 {
 	compatible = "fsl,qoriq-clockgen-2.0";
 	ranges = <0x0 0xe1000 0x1000>;
 	reg = <0xe1000 0x1000>;
 	#address-cells = <1>;
 	#size-cells = <1>;
+	#clock-cells = <2>;
 
 	sysclk: sysclk {
 		#clock-cells = <0>;
-- 
2.1.4
