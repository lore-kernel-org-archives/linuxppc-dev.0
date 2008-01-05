Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 4366FDDE06
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 15:49:11 +1100 (EST)
Message-ID: <477F0C46.6080900@pikatech.com>
Date: Fri, 04 Jan 2008 23:49:10 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Base Taco Platform support
Content-Type: multipart/mixed; boundary="------------070608070106000900030408"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070608070106000900030408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch for the base taco platform. It is against for-2.6.25. It 
adds basically everything in the arch/powerpc.

Cheers,
   Sean



--------------070608070106000900030408
Content-Type: text/plain;
 name="arch-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch-patch"

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3d8c..e6d3289 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -469,7 +469,7 @@ config MCA
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| PPC_PS3
+		|| PPC_PS3 || TACO
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
diff --git a/arch/powerpc/boot/44x.h b/arch/powerpc/boot/44x.h
index 0256344..be76731 100644
--- a/arch/powerpc/boot/44x.h
+++ b/arch/powerpc/boot/44x.h
@@ -12,5 +12,6 @@
 
 void ebony_init(void *mac0, void *mac1);
 void bamboo_init(void *mac0, void *mac1);
+void taco_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1e625c..7fd10ea 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -56,13 +56,13 @@ src-wlib := string.S crt0.S stdio.c main.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c
+		fsl-soc.c mpc8xx.c pq2.c taco.c
 src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
 		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
-		cuboot-katmai.c cuboot-rainier.c
+		cuboot-katmai.c cuboot-rainier.c cuboot-taco.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -206,6 +206,7 @@ image-$(CONFIG_RAINIER)			+= cuImage.rainier
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
+image-$(CONFIG_TACO)			+= cuImage.taco
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index f1928af..ece0c71 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1226,6 +1226,18 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
+	{ /* Matches both physical and logical PVR for 440EP (logical pvr = pvr | 0x8) */
+		.pvr_mask		= 0xf0000ff7,
+		.pvr_value		= 0x400008d4,
+		.cpu_name		= "440EP Rev. C",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440ep,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc440",
+	},
 	{ /* Use logical PVR for 440EP (logical pvr = pvr | 0x8) */
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x400008db,
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index d248013..ead4d82 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -53,6 +53,14 @@ config RAINIER
 	help
 	  This option enables support for the AMCC PPC440GRX evaluation board.
 
+config TACO
+	bool "Taco"
+	depends on 44x
+	default n
+	select 440EP
+	help
+	  This option enables support for the PIKA Appliance.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index a2a0dc1..3d01e71 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
 obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
+obj-$(CONFIG_TACO)	+= taco.o

--------------070608070106000900030408--
