Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 97C90DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 09:22:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: current ARCH=powerpc for v2pro.
Date: Fri, 30 Nov 2007 14:21:58 -0800
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20071130222205.73E79A68013@mail72-blu.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Grant,

I'm trying to bring up your arch/powerpc work, using a compiled in
device tree.  I added this:

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..48f745d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -53,7 +53,7 @@ src-wlib :=3D string.S crt0.S stdio.c main.c
flatdevtree.c flatd
                cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c
uartlite.c \
                fsl-soc.c mpc8xx.c pq2.c
 src-plat :=3D of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
-               cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
+               virtex.c cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
                ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c
cuboot-8xx.c \
                cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c
cuboot-bamboo.c=20
                fixed-head.S ep88xc.c cuboot-hpc2.c
@@ -159,6 +159,7 @@ image-$(CONFIG_EBONY)                       +=3D
treeImage.ebo
 image-$(CONFIG_BAMBOO)                 +=3D treeImage.bamboo
cuImage.bamboo
 image-$(CONFIG_SEQUOIA)                        +=3D cuImage.sequoia
 image-$(CONFIG_WALNUT)                 +=3D treeImage.walnut
+image-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)                    +=3D
zImage.virtex
 endif
=20
 # For 32-bit powermacs, build the COFF and miboot images
diff --git a/arch/powerpc/boot/virtex.c b/arch/powerpc/boot/virtex.c
new file mode 100644
index 0000000..32cebc1
--- /dev/null
+++ b/arch/powerpc/boot/virtex.c
@@ -0,0 +1,20 @@
+
+
+#include "ops.h"
+#include "stdio.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "io.h"
+
+BSS_STACK(4096);
+
+void platform_init(void)
+{
+       unsigned long end_of_ram =3D 0xfffffff;
+       unsigned long avail_ram =3D end_of_ram - (unsigned long) _end;
+
+       simple_alloc_init(_end, avail_ram, 32, 32);
+       ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+       serial_console_init();
+        printf("booting virtex\n");
+}

and got as far as:

---
booting virtex

zImage starting: loaded at 0x00400000 (sp: 0x00551f14)
Allocating 0x2d7324 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040b000:0x00550d74)...done 0x2b35ec bytes

Linux/PowerPC load: root=3D/dev/xsysace/disc0/part2
Finalizing device tree... flat tree at 0x409870
---

Tracing through the code, it appears that there is a machine check in
memset_io in early_init():

unsigned long __init early_init(unsigned long dt_ptr)
{
	unsigned long offset =3D reloc_offset();
	struct cpu_spec *spec;

	/* First zero the BSS -- use memset_io, some platforms don't
have
	 * caches on yet */
	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
			__bss_stop - __bss_start);

	/*
	 * Identify the CPU type and fix up code sections
	 * that depend on which cpu we have.
	 */
	spec =3D identify_cpu(offset, mfspr(SPRN_PVR));

	do_feature_fixups(spec->cpu_features,
			  PTRRELOC(&__start___ftr_fixup),
			  PTRRELOC(&__stop___ftr_fixup));

	return KERNELBASE + offset;
}

Which seems bizarre, because that code is very simple.  I'm guessing
that something in the memory configuration is wierd (or maybe
zImage.virtex is not the right way to do this?) but I'm a little lost
where to look from here.  I also tried it with both paulus_master and
your virtex-for-2.6.24 branch.

Any ideas?

Steve
