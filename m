Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4B43667B86
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 07:25:56 +1000 (EST)
Subject: [PATCH] Directly reference i8259@4d0 nodes in mpc8641_hpcn.dts.
From: Jon Loeliger <jdl@freescale.com>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <1155840700.27466.64.camel@basalt.austin.ibm.com>
References: <1155835482.10054.140.camel@cashmere.sps.mot.com>
	<1155840700.27466.64.camel@basalt.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1155849609.10054.175.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 17 Aug 2006 16:20:09 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rather than using some hand-coded linux,phandle
node references, use DTC's direct node refs ability
and let it manage the phandle names instead.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

On Thu, 2006-08-17 at 13:51, Hollis Blanchard wrote:
> Doesn't the device tree compiler add linux,phandle properties as needed?
> In this case that would be when the node is referenced by a
> "<&/foo/bar/i8259@4d0>" property.
> 
> On Thu, 2006-08-17 at 12:24 -0500, Jon Loeliger wrote:
> > Add 'linux,phandle' entry to i8259@4d0 node.
> > 
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> > ---

Paul,

If you think this is better, please apply this patch
instead of my previous patch with the subject line:

    Patch] Fix the mpc8641_hpcn.dts file.

Thanks,
jdl


 arch/powerpc/boot/dts/mpc8641_hpcn.dts |  121 ++++++++++++++++----------------
 1 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index e832a88..49d85a5 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -32,7 +32,6 @@
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
 			32-bit;
-			linux,boot-cpu;
 		};
 		PowerPC,8641@1 {
 			device_type = "cpu";
@@ -202,95 +201,95 @@
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x11 */
-				8800 0 0 1 4d0 3 2
-				8800 0 0 2 4d0 4 2
-				8800 0 0 3 4d0 5 2
-				8800 0 0 4 4d0 6 2
+				8800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 3 2
+				8800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 4 2
+				8800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 5 2
+				8800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 6 2
 
 				/* IDSEL 0x12 */
-				9000 0 0 1 4d0 4 2
-				9000 0 0 2 4d0 5 2
-				9000 0 0 3 4d0 6 2
-				9000 0 0 4 4d0 3 2
+				9000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 4 2
+				9000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 5 2
+				9000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 6 2
+				9000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 3 2
 
 				/* IDSEL 0x13 */
-				9800 0 0 1 4d0 0 0
-				9800 0 0 2 4d0 0 0
-				9800 0 0 3 4d0 0 0
-				9800 0 0 4 4d0 0 0
+				9800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				9800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				9800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				9800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x14 */
-				a000 0 0 1 4d0 0 0
-				a000 0 0 2 4d0 0 0
-				a000 0 0 3 4d0 0 0
-				a000 0 0 4 4d0 0 0
+				a000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				a000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				a000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				a000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x15 */
-				a800 0 0 1 4d0 0 0
-				a800 0 0 2 4d0 0 0
-				a800 0 0 3 4d0 0 0
-				a800 0 0 4 4d0 0 0
+				a800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				a800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				a800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				a800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x16 */
-				b000 0 0 1 4d0 0 0
-				b000 0 0 2 4d0 0 0
-				b000 0 0 3 4d0 0 0
-				b000 0 0 4 4d0 0 0
+				b000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				b000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				b000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				b000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x17 */
-				b800 0 0 1 4d0 0 0
-				b800 0 0 2 4d0 0 0
-				b800 0 0 3 4d0 0 0
-				b800 0 0 4 4d0 0 0
+				b800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				b800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				b800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				b800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x18 */
-				c000 0 0 1 4d0 0 0
-				c000 0 0 2 4d0 0 0
-				c000 0 0 3 4d0 0 0
-				c000 0 0 4 4d0 0 0
+				c000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				c000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				c000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				c000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x19 */
-				c800 0 0 1 4d0 0 0
-				c800 0 0 2 4d0 0 0
-				c800 0 0 3 4d0 0 0
-				c800 0 0 4 4d0 0 0
+				c800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				c800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				c800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				c800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x1a */
-				d000 0 0 1 4d0 6 2
-				d000 0 0 2 4d0 3 2
-				d000 0 0 3 4d0 4 2
-				d000 0 0 4 4d0 5 2
+				d000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 6 2
+				d000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 3 2
+				d000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 4 2
+				d000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 5 2
 
 
 				/* IDSEL 0x1b */
-				d800 0 0 1 4d0 5 2
-				d800 0 0 2 4d0 0 0
-				d800 0 0 3 4d0 0 0
-				d800 0 0 4 4d0 0 0
+				d800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 5 2
+				d800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				d800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				d800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x1c */
-				e000 0 0 1 4d0 9 2
-				e000 0 0 2 4d0 a 2
-				e000 0 0 3 4d0 c 2
-				e000 0 0 4 4d0 7 2
+				e000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 9 2
+				e000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 a 2
+				e000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 c 2
+				e000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 7 2
 
 				/* IDSEL 0x1d */
-				e800 0 0 1 4d0 9 2
-				e800 0 0 2 4d0 a 2
-				e800 0 0 3 4d0 b 2
-				e800 0 0 4 4d0 0 0
+				e800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 9 2
+				e800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 a 2
+				e800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 b 2
+				e800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x1e */
-				f000 0 0 1 4d0 c 2
-				f000 0 0 2 4d0 0 0
-				f000 0 0 3 4d0 0 0
-				f000 0 0 4 4d0 0 0
+				f000 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 c 2
+				f000 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				f000 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				f000 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 
 				/* IDSEL 0x1f */
-				f800 0 0 1 4d0 6 2
-				f800 0 0 2 4d0 0 0
-				f800 0 0 3 4d0 0 0
-				f800 0 0 4 4d0 0 0
+				f800 0 0 1 &/soc8641@f8000000/pci@8000/i8259@4d0 6 2
+				f800 0 0 2 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				f800 0 0 3 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
+				f800 0 0 4 &/soc8641@f8000000/pci@8000/i8259@4d0 0 0
 				>;
 			i8259@4d0 {
 				clock-frequency = <0>;
-- 
2006_06_07.01.gittree_pull-dirty
