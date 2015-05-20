Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABEAE1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:30:59 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH,
 v2] powerpc/mpc85xx: Add DPAA Ethernet QMan support to the device
 tree(s)
Date: Wed, 20 May 2015 15:29:35 +0300
Message-ID: <1432124975-6096-1-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: roy.pledge@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Emil Medve <Emilian.Medve@Freescale.com>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/boot/dts/b4qds.dtsi               |  1 +
 arch/powerpc/boot/dts/fsl/qoriq-dpaa-res1.dtsi | 77 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-dpaa-res2.dtsi | 56 +++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-dpaa-res3.dtsi | 77 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/kmcoge4.dts              |  1 +
 arch/powerpc/boot/dts/oca4080.dts              |  1 +
 arch/powerpc/boot/dts/p1023rdb.dts             |  1 +
 arch/powerpc/boot/dts/p2041rdb.dts             |  1 +
 arch/powerpc/boot/dts/p3041ds.dts              |  1 +
 arch/powerpc/boot/dts/p4080ds.dts              |  1 +
 arch/powerpc/boot/dts/p5020ds.dts              |  1 +
 arch/powerpc/boot/dts/p5040ds.dts              |  1 +
 arch/powerpc/boot/dts/t104xqds.dtsi            |  2 +
 arch/powerpc/boot/dts/t104xrdb.dtsi            |  2 +
 arch/powerpc/boot/dts/t208xqds.dtsi            |  2 +
 arch/powerpc/boot/dts/t208xrdb.dtsi            |  2 +
 arch/powerpc/boot/dts/t4240qds.dts             |  1 +
 arch/powerpc/boot/dts/t4240rdb.dts             |  1 +
 18 files changed, 229 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dpaa-res1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dpaa-res2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dpaa-res3.dtsi

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 24ed80d..3cd23db 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -218,3 +218,4 @@
 };
 
 /include/ "fsl/b4si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res1.dtsi
new file mode 100644
index 0000000..24d83e0
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res1.dtsi
@@ -0,0 +1,77 @@
+/*
+ * QorIQ DPAA resources device tree stub [ FQIDs, BPIDs ]
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/* These stubs are required to alloc qbman drivers to determine what ranges of
+ * resources are available for dynamic allocation, primarily because there are
+ * some legacy "a priori" assumptions in certain subsystems (eg. networking)
+ * that certain resources are reserved for their use. When those drivers (and in
+ * some cases, their corresponding device-tree nodes) are updated to dynamically
+ * allocate their resources, then *all* resources can be managed by the
+ * allocators and there may be no further need to define these stubs.
+ *
+ * A couple of qualifiers to the above statement though:
+ *
+ * - Some resource ranges are hardware-specific, rather than being defined by
+ *   software memory allocation choices. Eg. the number of available BPIDs is
+ *   baked into silicon and so will probably always need to be expressed in the
+ *   device-tree, though in that case it will express all BPIDs, not just those
+ *   available for dynamic allocation.
+ *
+ * - Even for memory-backed resources that are software determined (FQIDs), this
+ *   information may only be configured and available on the control-plane
+ *   partition that manages the device, so in AMP or hypervised scenarios there
+ *   may still be need to a way to provide allocation ranges. Ie. for O/S
+ *   instances that don't know how many resources are available to hardware, and
+ *   possibly even for O/S instances that do know how many are available but
+ *   that should not "own" all of them.
+ */
+
+&qportals {
+	qman-fqids@0 {
+		compatible = "fsl,fqid-range";
+		fsl,fqid-range = <256 256>;
+	};
+	qman-fqids@1 {
+		compatible = "fsl,fqid-range";
+		fsl,fqid-range = <32768 32768>;
+	};
+	qman-pools@0 {
+		compatible = "fsl,pool-channel-range";
+		fsl,pool-channel-range = <0x21 0xf>;
+	};
+	qman-cgrids@0 {
+		compatible = "fsl,cgrid-range";
+		fsl,cgrid-range = <0 256>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res2.dtsi
new file mode 100644
index 0000000..9280f60
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res2.dtsi
@@ -0,0 +1,56 @@
+/*
+ * QorIQ DPAA resources device tree stub [ FQIDs, BPIDs ]
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/* The comments in qoriq-dpaa-res1.dtsi apply here too so will not be repeated.
+ * This alternative file is to support p1023 which does not have the same
+ * resource ranges as other SoCs to date. */
+
+&qportals {
+	qman-fqids@0 {
+		compatible = "fsl,fqid-range";
+		fsl,fqid-range = <256 256>;
+	};
+	qman-fqids@1 {
+		compatible = "fsl,fqid-range";
+		fsl,fqid-range = <32768 32768>;
+	};
+	qman-pools@0 {
+		compatible = "fsl,pool-channel-range";
+		fsl,pool-channel-range = <0x21 0x3>;
+	};
+	qman-cgrids@0 {
+		compatible = "fsl,cgrid-range";
+		fsl,cgrid-range = <0 64>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res3.dtsi
new file mode 100644
index 0000000..e3bda8b
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-dpaa-res3.dtsi
@@ -0,0 +1,77 @@
+/*
+ * QorIQ DPAA resources device tree stub [ FQIDs, BPIDs ]
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/* These stubs are required to alloc qbman drivers to determine what ranges of
+ * resources are available for dynamic allocation, primarily because there are
+ * some legacy "a priori" assumptions in certain subsystems (eg. networking)
+ * that certain resources are reserved for their use. When those drivers (and in
+ * some cases, their corresponding device-tree nodes) are updated to dynamically
+ * allocate their resources, then *all* resources can be managed by the
+ * allocators and there may be no further need to define these stubs.
+ *
+ * A couple of qualifiers to the above statement though:
+ *
+ * - Some resource ranges are hardware-specific, rather than being defined by
+ *   software memory allocation choices. Eg. the number of available BPIDs is
+ *   baked into silicon and so will probably always need to be expressed in the
+ *   device-tree, though in that case it will express all BPIDs, not just those
+ *   available for dynamic allocation.
+ *
+ * - Even for memory-backed resources that are software determined (FQIDs), this
+ *   information may only be configured and available on the control-plane
+ *   partition that manages the device, so in AMP or hypervised scenarios there
+ *   may still be need to a way to provide allocation ranges. Ie. for O/S
+ *   instances that don't know how many resources are available to hardware, and
+ *   possibly even for O/S instances that do know how many are available but
+ *   that should not "own" all of them.
+ */
+
+&qportals {
+	qman-fqids@0 {
+		compatible = "fsl,fqid-range";
+		fsl,fqid-range = <256 512>;
+	};
+	qman-fqids@1 {
+		compatible = "fsl,fqid-range";
+		fsl,fqid-range = <32768 32768>;
+	};
+	qman-pools@0 {
+		compatible = "fsl,pool-channel-range";
+		fsl,pool-channel-range = <0x401 0xf>;
+	};
+	qman-cgrids@0 {
+		compatible = "fsl,cgrid-range";
+		fsl,cgrid-range = <0 256>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
index 97e6d11..3c00b94 100644
--- a/arch/powerpc/boot/dts/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/kmcoge4.dts
@@ -165,3 +165,4 @@
 };
 
 /include/ "fsl/p2041si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/oca4080.dts b/arch/powerpc/boot/dts/oca4080.dts
index eb76caa..2c28aa1 100644
--- a/arch/powerpc/boot/dts/oca4080.dts
+++ b/arch/powerpc/boot/dts/oca4080.dts
@@ -131,3 +131,4 @@
 };
 
 /include/ "fsl/p4080si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
index 9236e37..0d97986 100644
--- a/arch/powerpc/boot/dts/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -246,3 +246,4 @@
 };
 
 /include/ "fsl/p1023si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res2.dtsi"
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index c1e69dc..1c2d22e 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -236,3 +236,4 @@
 };
 
 /include/ "fsl/p2041si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 2192fe9..c8b22a1 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -270,3 +270,4 @@
 };
 
 /include/ "fsl/p3041si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index fad4416..9bf6d58 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -204,3 +204,4 @@
 };
 
 /include/ "fsl/p4080si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 7382636..aa19e4e 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -270,3 +270,4 @@
 };
 
 /include/ "fsl/p5020si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index 35dabf5..4933389 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -240,3 +240,4 @@
 };
 
 /include/ "fsl/p5040si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res1.dtsi"
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/t104xqds.dtsi
index f7e9bfb..4b2288e 100644
--- a/arch/powerpc/boot/dts/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/t104xqds.dtsi
@@ -179,3 +179,5 @@
 		};
 	};
 };
+
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/t104xrdb.dtsi
index 76e07a3..edf6bae 100644
--- a/arch/powerpc/boot/dts/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
@@ -175,3 +175,5 @@
 		};
 	};
 };
+
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/t208xqds.dtsi
index c42e07f4..ef6fda0 100644
--- a/arch/powerpc/boot/dts/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/t208xqds.dtsi
@@ -263,3 +263,5 @@
 		};
 	};
 };
+
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
diff --git a/arch/powerpc/boot/dts/t208xrdb.dtsi b/arch/powerpc/boot/dts/t208xrdb.dtsi
index e1463b1..1505f07 100644
--- a/arch/powerpc/boot/dts/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t208xrdb.dtsi
@@ -197,3 +197,5 @@
 		};
 	};
 };
+
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 6df7776..789f97b 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -296,3 +296,4 @@
 };
 
 /include/ "fsl/t4240si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
index 46049cf..d2c3723 100644
--- a/arch/powerpc/boot/dts/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/t4240rdb.dts
@@ -199,3 +199,4 @@
 };
 
 /include/ "fsl/t4240si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
-- 
1.7.11.7
