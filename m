Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0080.outbound.protection.outlook.com [104.47.36.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtgVn2DfpzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 08:14:09 +1100 (AEDT)
From: Roy Pledge <roy.pledge@nxp.com>
To: <robin.murphy@arm.com>, <oss@buserror.net>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>
CC: <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [RFC PATCH 3/5] dts: arch/powerpc: Update Freescale DTS for QBMan
 memory allocations
Date: Wed, 29 Mar 2017 17:13:55 -0400
Message-ID: <1490822037-6752-4-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

QBMan now uses the shared-dma-pool mechansim to manage early
memory reservations.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 arch/powerpc/boot/dts/fsl/b4qds.dtsi        |  6 ++++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 15 ---------------
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts   |  6 ++++++
 arch/powerpc/boot/dts/fsl/kmcent2.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/kmcoge4.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/oca4080.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/p1023rdb.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/p2041rdb.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/p3041ds.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/p4080ds.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/p5020ds.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/p5040ds.dts       |  6 ++++++
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/t1023rdb.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/t1024qds.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/t1024rdb.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi   |  6 ++++++
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi     |  6 ++++++
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi     |  6 ++++++
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 15 ---------------
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi     |  6 ++++++
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi     |  6 ++++++
 arch/powerpc/boot/dts/fsl/t4240qds.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/t4240rdb.dts      |  6 ++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 15 ---------------
 32 files changed, 126 insertions(+), 165 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4qds.dtsi b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
index 3785ef8..a2abd1e 100644
--- a/arch/powerpc/boot/dts/fsl/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
@@ -110,16 +110,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 1b33f51..844d99b 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -32,21 +32,6 @@
  * this software, even if advised of the possibility of such damage.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
index c603390..2b2227b 100644
--- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
+++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
@@ -31,16 +31,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dts/fsl/kmcent2.dts
index 47afa43..98f5257 100644
--- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
@@ -28,16 +28,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
index e103c0f..6cfff87 100644
--- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
@@ -31,16 +31,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/oca4080.dts b/arch/powerpc/boot/dts/fsl/oca4080.dts
index 17bc6f3..e06ce75 100644
--- a/arch/powerpc/boot/dts/fsl/oca4080.dts
+++ b/arch/powerpc/boot/dts/fsl/oca4080.dts
@@ -55,16 +55,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1023rdb.dts b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
index 9716ca6..d4abdcf 100644
--- a/arch/powerpc/boot/dts/fsl/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p1023rdb.dts
@@ -53,16 +53,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index da6d3fc..9dbbba6 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
 &lbc {
 	#address-cells = <2>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041rdb.dts b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
index e50fea9..4f6c233 100644
--- a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
@@ -64,16 +64,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 51e975d..f8615bb 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
 &lbc {
 	compatible = "fsl,p2041-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041ds.dts b/arch/powerpc/boot/dts/fsl/p3041ds.dts
index 40748e4..50507c9 100644
--- a/arch/powerpc/boot/dts/fsl/p3041ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p3041ds.dts
@@ -65,16 +65,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 187676f..a19b86c 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
 &lbc {
 	compatible = "fsl,p3041-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080ds.dts b/arch/powerpc/boot/dts/fsl/p4080ds.dts
index 816b978..813117a 100644
--- a/arch/powerpc/boot/dts/fsl/p4080ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p4080ds.dts
@@ -65,16 +65,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index a025208..42868c7 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10 0>;
-};
-
 &lbc {
 	compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020ds.dts b/arch/powerpc/boot/dts/fsl/p5020ds.dts
index cd6f373..479f772 100644
--- a/arch/powerpc/boot/dts/fsl/p5020ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5020ds.dts
@@ -65,16 +65,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index cd008cd..dec5e12 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &lbc {
 	compatible = "fsl,p5020-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p5040ds.dts b/arch/powerpc/boot/dts/fsl/p5040ds.dts
index 4508473..b97ca39 100644
--- a/arch/powerpc/boot/dts/fsl/p5040ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5040ds.dts
@@ -77,16 +77,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index e2bd931..7a109d5 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -32,21 +32,6 @@
  * software, even if advised of the possibility of such damage.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &lbc {
 	compatible = "fsl,p5040-elbc", "fsl,elbc", "simple-bus";
 	interrupts = <25 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/t1023rdb.dts b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
index 5ba6fbf..034ec42 100644
--- a/arch/powerpc/boot/dts/fsl/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
@@ -47,18 +47,24 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 4908af5..de951f8 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -34,21 +34,6 @@
 
 #include <dt-bindings/thermal/thermal.h>
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t1024qds.dts b/arch/powerpc/boot/dts/fsl/t1024qds.dts
index d6858b7..a6fa860 100644
--- a/arch/powerpc/boot/dts/fsl/t1024qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024qds.dts
@@ -47,18 +47,24 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 73a6453..09cf13c 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -51,18 +51,24 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 145c7f4..3fa5a14 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -34,21 +34,6 @@
 
 #include <dt-bindings/thermal/thermal.h>
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
index 863f943..531600b 100644
--- a/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
@@ -39,16 +39,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
index 2fd4cbe..bb7cc7b 100644
--- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
@@ -71,16 +71,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 5fdddbd..d0ba614 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -45,16 +45,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index a97296c..5215e86 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
index ec080bd..334da3b 100644
--- a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
@@ -45,16 +45,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
index ff87e67..102fe75 100644
--- a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
@@ -45,16 +45,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t4240qds.dts b/arch/powerpc/boot/dts/fsl/t4240qds.dts
index 9573cea..92375b4 100644
--- a/arch/powerpc/boot/dts/fsl/t4240qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240qds.dts
@@ -326,16 +326,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
index 8166c66..5cd8a62 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -86,16 +86,22 @@
 		ranges;
 
 		bman_fbpr: bman-fbpr {
+			compatible = "shared-dma-pool";
 			size = <0 0x1000000>;
 			alignment = <0 0x1000000>;
+			no-map;
 		};
 		qman_fqd: qman-fqd {
+			compatible = "shared-dma-pool";
 			size = <0 0x400000>;
 			alignment = <0 0x400000>;
+			no-map;
 		};
 		qman_pfdr: qman-pfdr {
+			compatible = "shared-dma-pool";
 			size = <0 0x2000000>;
 			alignment = <0 0x2000000>;
+			no-map;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 68c4ead..97d5ae1 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -32,21 +32,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&bman_fbpr {
-	compatible = "fsl,bman-fbpr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_fqd {
-	compatible = "fsl,qman-fqd";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
-&qman_pfdr {
-	compatible = "fsl,qman-pfdr";
-	alloc-ranges = <0 0 0x10000 0>;
-};
-
 &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-- 
2.9.3
