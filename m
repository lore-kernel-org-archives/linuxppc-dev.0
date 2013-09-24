Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 99A122C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 16:22:36 +1000 (EST)
Message-ID: <1380003745.5443.30.camel@pasglop>
Subject: [PATCH] powerpc/zImage: make the "OF" wrapper support ePAPR boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Sep 2013 16:22:25 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes the "OF" zImage wrapper (zImage.pseries, zImage.pmac,
zImage.maple) work if booted via a flat device-tree (ePAPR boot
mode), and thus potentially usable with kexec.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile        |  4 ++--
 arch/powerpc/boot/epapr-wrapper.c |  9 +++++++++
 arch/powerpc/boot/epapr.c         |  4 ++--
 arch/powerpc/boot/of.c            | 16 +++++++++++++++-
 arch/powerpc/boot/wrapper         |  9 +++++----
 5 files changed, 33 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/boot/epapr-wrapper.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 6a15c96..15ca225 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -74,7 +74,7 @@ src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c
 src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
 src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c
 
-src-plat-y := of.c
+src-plat-y := of.c epapr.c
 src-plat-$(CONFIG_40x) += fixed-head.S ep405.c cuboot-hotfoot.c \
 				treeboot-walnut.c cuboot-acadia.c \
 				cuboot-kilauea.c simpleboot.c \
@@ -97,7 +97,7 @@ src-plat-$(CONFIG_EMBEDDED6xx) += cuboot-pq2.c cuboot-mpc7448hpc2.c \
 					prpmc2800.c
 src-plat-$(CONFIG_AMIGAONE) += cuboot-amigaone.c
 src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
-src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c
+src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
 
 src-wlib := $(sort $(src-wlib-y))
 src-plat := $(sort $(src-plat-y))
diff --git a/arch/powerpc/boot/epapr-wrapper.c b/arch/powerpc/boot/epapr-wrapper.c
new file mode 100644
index 0000000..c101910
--- /dev/null
+++ b/arch/powerpc/boot/epapr-wrapper.c
@@ -0,0 +1,9 @@
+extern void epapr_platform_init(unsigned long r3, unsigned long r4,
+				unsigned long r5, unsigned long r6,
+				unsigned long r7);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	epapr_platform_init(r3, r4, r5, r6, r7);
+}
diff --git a/arch/powerpc/boot/epapr.c b/arch/powerpc/boot/epapr.c
index 06c1961..02e91aa 100644
--- a/arch/powerpc/boot/epapr.c
+++ b/arch/powerpc/boot/epapr.c
@@ -48,8 +48,8 @@ static void platform_fixups(void)
 		       fdt_addr, fdt_totalsize((void *)fdt_addr), ima_size);
 }
 
-void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-		   unsigned long r6, unsigned long r7)
+void epapr_platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			 unsigned long r6, unsigned long r7)
 {
 	epapr_magic = r6;
 	ima_size = r7;
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 61d9899..62e2f43 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -26,6 +26,9 @@
 
 static unsigned long claim_base;
 
+void epapr_platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			 unsigned long r6, unsigned long r7);
+
 static void *of_try_claim(unsigned long size)
 {
 	unsigned long addr = 0;
@@ -61,7 +64,7 @@ static void of_image_hdr(const void *hdr)
 	}
 }
 
-void platform_init(unsigned long a1, unsigned long a2, void *promptr)
+static void of_platform_init(unsigned long a1, unsigned long a2, void *promptr)
 {
 	platform_ops.image_hdr = of_image_hdr;
 	platform_ops.malloc = of_try_claim;
@@ -81,3 +84,14 @@ void platform_init(unsigned long a1, unsigned long a2, void *promptr)
 		loader_info.initrd_size = a2;
 	}
 }
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	/* Detect OF vs. ePAPR boot */
+	if (r5)
+		of_platform_init(r3, r4, (void *)r5);
+	else
+		epapr_platform_init(r3, r4, r5, r6, r7);
+}
+
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 6761c74..cd7af84 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -148,18 +148,18 @@ make_space=y
 
 case "$platform" in
 pseries)
-    platformo=$object/of.o
+    platformo="$object/of.o $object/epapr.o"
     link_address='0x4000000'
     ;;
 maple)
-    platformo=$object/of.o
+    platformo="$object/of.o $object/epapr.o"
     link_address='0x400000'
     ;;
 pmac|chrp)
-    platformo=$object/of.o
+    platformo="$object/of.o $object/epapr.o"
     ;;
 coff)
-    platformo="$object/crt0.o $object/of.o"
+    platformo="$object/crt0.o $object/of.o $object/epapr.o"
     lds=$object/zImage.coff.lds
     link_address='0x500000'
     pie=
@@ -253,6 +253,7 @@ treeboot-iss4xx-mpic)
     platformo="$object/treeboot-iss4xx.o"
     ;;
 epapr)
+    platformo="$object/epapr.o $object/epapr-wrapper.o"
     link_address='0x20000000'
     pie=-pie
     ;;
