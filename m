Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 945C8DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 01:31:27 +1000 (EST)
Date: Fri, 28 Sep 2007 10:30:54 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.23' branch
Message-ID: <Pine.LNX.4.64.0709281028570.30643@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.23' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.23

to receive the following updates:

 arch/powerpc/boot/dts/mpc8349emitx.dts  |    1 +
 arch/powerpc/platforms/83xx/usb.c       |    4 ++--
 arch/powerpc/sysdev/commproc.c          |    2 +-
 arch/ppc/8xx_io/commproc.c              |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

Jochen Friedrich (3):
      [POWERPC] Fix copy'n'paste typo in commproc.c
      [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem
      [POWERPC] Fix cpm_uart driver for cpm1 machines

jacmet@sunsite.dk (2):
      [POWERPC] Fix mpc834x USB-MPH configuration.
      [POWERPC] mpc8349emitx.dts: Setup USB-DR for peripheral mode.

commit f93c7c5aab8d5efaf99c88c8452d9303baabc89b
Author: jacmet@sunsite.dk <jacmet@sunsite.dk>
Date:   Fri Sep 28 16:21:15 2007 +0200

    [POWERPC] mpc8349emitx.dts: Setup USB-DR for peripheral mode.

    Setup dr_mode for USB-DR to peripheral as the default (host mode) doesn't make
    much sense for the mini-AB connector on the ITX board.

    Peripheral mode is preferable to OTG as the fsl_usb2_udc.c driver doesn't yet
    properly support it.

    Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 39db0fd9db6caea8887f61fee4a0e53c6f8fec5e
Author: jacmet@sunsite.dk <jacmet@sunsite.dk>
Date:   Fri Sep 28 16:21:14 2007 +0200

    [POWERPC] Fix mpc834x USB-MPH configuration.

    mpc834x USB-MPH configuration got broken by commit
    6f442560021aecf08658e26ed9a37e6928ef0fa1. The selection bits in SICRL
    should be cleared rather than set to configure the USB MUXes for the MPH.

    Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit d214602804a85e5da68b745ae69d9beaa5bedc93
Author: Jochen Friedrich <jochen@scram.de>
Date:   Mon Sep 24 19:15:43 2007 +0200

    [POWERPC] Fix cpm_uart driver for cpm1 machines

    in cpm_uart_cpm1.h, DPRAM_BASE is assigned an address derived from cpmp.
    On ARC=ppc, this is a physical address with 1:1 DMA mapping which can't
    be used for arithmetric compare operations with virtual addresses
    returned by cpm_dpram_addr. This patch changes the assignment to use
    cpm_dpram_addr as well, like in cpm_uart_cpm2.h.

    Signed-off-by: Jochen Friedrich <jochen@scram.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit bc63818931ea55c54d6e59b7d38bff8f295dc8c1
Author: Jochen Friedrich <jochen@scram.de>
Date:   Mon Sep 24 19:14:57 2007 +0200

    [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem

    cpm_dpram_addr returns physical memory of the DP RAM instead of
    iomapped virtual memory. As there usually is a 1:1 MMU map of
    the IMMR area, this is often not noticed. However, cpm_dpram_phys
    assumes this iomapped virtual memory and returns garbage on the
    1:1 mapped memory causing CPM1 uart console to fail.

    This patch fixes the problem (copied from the powerpc tree).

    Signed-off-by: Jochen Friedrich <jochen@scram.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 83af919e0f239e87bc644a2c932b9cebf5771380
Author: Jochen Friedrich <jochen@scram.de>
Date:   Mon Sep 24 19:13:46 2007 +0200

    [POWERPC] Fix copy'n'paste typo in commproc.c

    The powerpc version of commproc.c exports cpm_dpram_addr twice
    and cpm_dpram_phys not at all due to a typo. This patch fixes this
    problem.

    CC      arch/powerpc/sysdev/commproc.o
    arch/powerpc/sysdev/commproc.c:398: error: redefinition of '__kcrctab_cpm_dpram_addr'
    arch/powerpc/sysdev/commproc.c:392: error: previous definition of '__kcrctab_cpm_dpram_addr' was here
    arch/powerpc/sysdev/commproc.c:398: error: redefinition of '__kstrtab_cpm_dpram_addr'
    arch/powerpc/sysdev/commproc.c:392: error: previous definition of '__kstrtab_cpm_dpram_addr' was here
    arch/powerpc/sysdev/commproc.c:398: error: redefinition of '__ksymtab_cpm_dpram_addr'
    arch/powerpc/sysdev/commproc.c:392: error: previous definition of '__ksymtab_cpm_dpram_addr' was here
    make[1]: *** [arch/powerpc/sysdev/commproc.o] Error 1
    make: *** [arch/powerpc/sysdev] Error 2

    Signed-off-by: Jochen Friedrich <jochen@scram.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 502f47c..44c065a 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -99,6 +99,7 @@
 			#size-cells = <0>;
 			interrupt-parent = < &ipic >;
 			interrupts = <26 8>;
+			dr_mode = "peripheral";
 			phy_type = "ulpi";
 		};

diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index e7fdf01..eafe760 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -76,14 +76,14 @@ int mpc834x_usb_cfg(void)
 			if (port0_is_dr)
 				printk(KERN_WARNING
 					"834x USB port0 can't be used by both DR and MPH!\n");
-			sicrl |= MPC834X_SICRL_USB0;
+			sicrl &= ~MPC834X_SICRL_USB0;
 		}
 		prop = of_get_property(np, "port1", NULL);
 		if (prop) {
 			if (port1_is_dr)
 				printk(KERN_WARNING
 					"834x USB port1 can't be used by both DR and MPH!\n");
-			sicrl |= MPC834X_SICRL_USB1;
+			sicrl &= ~MPC834X_SICRL_USB1;
 		}
 		of_node_put(np);
 	}
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..dd5417a 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -395,4 +395,4 @@ uint cpm_dpram_phys(u8* addr)
 {
 	return (dpram_pbase + (uint)(addr - dpram_vbase));
 }
-EXPORT_SYMBOL(cpm_dpram_addr);
+EXPORT_SYMBOL(cpm_dpram_phys);
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 7088428..9da880b 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -459,7 +459,7 @@ EXPORT_SYMBOL(cpm_dpdump);

 void *cpm_dpram_addr(unsigned long offset)
 {
-	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
+	return (void *)(dpram_vbase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index a99e45e..2a64778 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -37,6 +37,6 @@ static inline void cpm_set_smc_fcr(volatile smc_uart_t * up)
 	up->smc_tfcr = SMC_EB;
 }

-#define DPRAM_BASE	((unsigned char *)&cpmp->cp_dpmem[0])
+#define DPRAM_BASE	((unsigned char *)cpm_dpram_addr(0))

 #endif
