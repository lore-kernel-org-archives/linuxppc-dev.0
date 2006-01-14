Return-Path: <grant@secretlab.ca>
Received: from localhost (S0106001346b91f0f.cg.shawcable.net [68.147.210.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96CAE689F2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 21:32:57 +1100 (EST)
Date: Sat, 14 Jan 2006 02:49:40 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, mporter@kernel.crashing.org,
	glikely@gmail.com
Subject: [PATCH 09/10] Bug fix for Xilinx silicon errata 213.
Message-ID: <20060114094940.GA12830@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pulled from Xilinx's Linux source code.  Also adds CONFIG entries to
differentiate between the VIRTEX_4_FX and VIRTEX_II_PRO where appropriate.

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/boot/simple/head.S    |    7 +++++++
 arch/ppc/platforms/4xx/Kconfig |   12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

94032273929311dfaa6cc5516a3376c67af83c0e
diff --git a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
index 5e4adc2..119b9dc 100644
--- a/arch/ppc/boot/simple/head.S
+++ b/arch/ppc/boot/simple/head.S
@@ -65,6 +65,13 @@ start_:
 			 */
 #endif
 
+#if defined(CONFIG_XILINX_VIRTEX_4_FX)
+	/* PPC errata 213: only for Virtex-4 FX */
+	mfccr0  0
+	oris    0,0,0x50000000@h
+	mtccr0  0
+#endif
+
 	mflr	r3	/* Save our actual starting address. */
 
 	/* The following functions we call must not modify r3 or r4.....
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 48def71..174ddbc 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -207,9 +207,19 @@ config 405GPR
 	depends on SYCAMORE
 	default y
 
+config XILINX_VIRTEX_II_PRO
+	bool
+	depends on XILINX_ML300
+	default y
+
+config XILINX_VIRTEX_4_FX
+	bool
+	depends on XILINX_ML403
+	default y
+
 config XILINX_VIRTEX
 	bool
-	depends on XILINX_ML300 || XILINX_ML403
+	depends on XILINX_VIRTEX_II_PRO || XILINX_VIRTEX_4_FX
 	default y
 
 config STB03xxx
-- 
1.1.2-g9e9b-dirty
