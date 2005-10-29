Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kxpS030035@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:28 -0700
Cc: akpm@osdl.org, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org,
	vbordug@ru.mvista.com, linuxppc64-dev@ozlabs.org
Subject: [patch 16/43] ppc32: ppc_sys fixes for 8xx and 82xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Vitaly Bordug <vbordug@ru.mvista.com>

This patch fixes a numbers of issues regarding to that both 8xx and 82xx
began to use ppc_sys model:
	- Platform is now identified by default deviceless SOC, if no
BOARD_CHIP_NAME is specified in the bard-specific header. For the list
of supported names refer to (arch/ppc/syslib/) mpc8xx_sys.c and
mpc82xx_sys.c for 8xx and 82xx respectively.
	- Fixed a bug in identification by name - if the name was not found, it
returned -1 instead of default deviceless ppc_spec.
	- fixed devices amount in the 8xx platform system descriptions

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/platforms/fads.h      |    2 ++
 arch/ppc/platforms/mpc885ads.h |    2 ++
 arch/ppc/syslib/m8260_setup.c  |    4 ++++
 arch/ppc/syslib/m8xx_setup.c   |    2 ++
 arch/ppc/syslib/mpc8xx_sys.c   |    4 ++--
 arch/ppc/syslib/ppc_sys.c      |    3 +++
 include/asm-ppc/cpm2.h         |    3 +++
 include/asm-ppc/mpc8260.h      |    4 ++++
 include/asm-ppc/mpc8xx.h       |    4 ++++
 9 files changed, 26 insertions(+), 2 deletions(-)

diff -puN arch/ppc/platforms/fads.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx arch/ppc/platforms/fads.h
--- devel/arch/ppc/platforms/fads.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/fads.h	2005-10-28 17:44:03.000000000 -0700
@@ -25,6 +25,8 @@
 
 #if defined(CONFIG_MPC86XADS)
 
+#define BOARD_CHIP_NAME "MPC86X"
+
 /* U-Boot maps BCSR to 0xff080000 */
 #define BCSR_ADDR		((uint)0xff080000)
 
diff -puN arch/ppc/platforms/mpc885ads.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx arch/ppc/platforms/mpc885ads.h
--- devel/arch/ppc/platforms/mpc885ads.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/mpc885ads.h	2005-10-28 17:44:03.000000000 -0700
@@ -88,5 +88,7 @@
 #define SICR_ENET_MASK	((uint)0x00ff0000)
 #define SICR_ENET_CLKRT	((uint)0x002c0000)
 
+#define BOARD_CHIP_NAME "MPC885"
+
 #endif /* __ASM_MPC885ADS_H__ */
 #endif /* __KERNEL__ */
diff -puN arch/ppc/syslib/m8260_setup.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx arch/ppc/syslib/m8260_setup.c
--- devel/arch/ppc/syslib/m8260_setup.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/m8260_setup.c	2005-10-28 17:44:03.000000000 -0700
@@ -62,6 +62,10 @@ m8260_setup_arch(void)
 	if (initrd_start)
 		ROOT_DEV = Root_RAM0;
 #endif
+
+	identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME,
+				in_be32(CPM_MAP_ADDR + CPM_IMMR_OFFSET));
+
 	m82xx_board_setup();
 }
 
diff -puN arch/ppc/syslib/m8xx_setup.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx arch/ppc/syslib/m8xx_setup.c
--- devel/arch/ppc/syslib/m8xx_setup.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/m8xx_setup.c	2005-10-28 17:44:03.000000000 -0700
@@ -399,6 +399,8 @@ platform_init(unsigned long r3, unsigned
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
 	}
 
+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
+
 	ppc_md.setup_arch		= m8xx_setup_arch;
 	ppc_md.show_percpuinfo		= m8xx_show_percpuinfo;
 	ppc_md.irq_canonicalize	= NULL;
diff -puN arch/ppc/syslib/mpc8xx_sys.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx arch/ppc/syslib/mpc8xx_sys.c
--- devel/arch/ppc/syslib/mpc8xx_sys.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/mpc8xx_sys.c	2005-10-28 17:44:03.000000000 -0700
@@ -24,7 +24,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "MPC86X",
 		.mask 		= 0xFFFFFFFF,
 		.value 		= 0x00000000,
-		.num_devices	= 2,
+		.num_devices	= 7,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC8xx_CPM_FEC1,
@@ -40,7 +40,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "MPC885",
 		.mask 		= 0xFFFFFFFF,
 		.value 		= 0x00000000,
-		.num_devices	= 3,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC8xx_CPM_FEC1,
diff -puN arch/ppc/syslib/ppc_sys.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx arch/ppc/syslib/ppc_sys.c
--- devel/arch/ppc/syslib/ppc_sys.c~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/ppc_sys.c	2005-10-28 17:44:03.000000000 -0700
@@ -69,6 +69,9 @@ static int __init find_chip_by_name_and_
 			matched[j++] = i;
 		i++;
 	}
+
+	ret = i;
+
 	if (j != 0) {
 		for (i = 0; i < j; i++) {
 			if ((ppc_sys_specs[matched[i]].mask & id) ==
diff -puN include/asm-ppc/cpm2.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx include/asm-ppc/cpm2.h
--- devel/include/asm-ppc/cpm2.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/include/asm-ppc/cpm2.h	2005-10-28 17:44:03.000000000 -0700
@@ -1087,6 +1087,9 @@ typedef struct im_idma {
 #define SCCR_PCIDF_MSK	0x00000078	/* PCI division factor	*/
 #define SCCR_PCIDF_SHIFT 3
 
+#ifndef CPM_IMMR_OFFSET
+#define CPM_IMMR_OFFSET	0x101a8
+#endif
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
diff -puN include/asm-ppc/mpc8260.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx include/asm-ppc/mpc8260.h
--- devel/include/asm-ppc/mpc8260.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/include/asm-ppc/mpc8260.h	2005-10-28 17:44:03.000000000 -0700
@@ -92,6 +92,10 @@ enum ppc_sys_devices {
 extern unsigned char __res[];
 #endif
 
+#ifndef BOARD_CHIP_NAME
+#define BOARD_CHIP_NAME ""
+#endif
+
 #endif /* CONFIG_8260 */
 #endif /* !__ASM_PPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
diff -puN include/asm-ppc/mpc8xx.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx include/asm-ppc/mpc8xx.h
--- devel/include/asm-ppc/mpc8xx.h~ppc32-ppc_sys-fixes-for-8xx-and-82xx	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/include/asm-ppc/mpc8xx.h	2005-10-28 17:44:03.000000000 -0700
@@ -113,6 +113,10 @@ enum ppc_sys_devices {
 	MPC8xx_CPM_USB,
 };
 
+#ifndef BOARD_CHIP_NAME
+#define BOARD_CHIP_NAME ""
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
_
