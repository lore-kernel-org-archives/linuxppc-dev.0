Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lNNJ030117@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:53 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, luther@debian.org,
	linuxppc64-dev@ozlabs.org
Subject: [patch 38/43] Various powerpc 32bit ppc64 build fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Sven Luther <sven.luther@wanadoo.fr>

Find here attached two small build fixes for the 32bit ppc64 kernels.  I
know the support for those kernels will soon go away, and debian is not
using them anymore, but until then it is nice to not have it broken, since
other users may need it.

Signed-off-by: Sven Luther <luther@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/boot/simple/misc-prep.c |    2 ++
 arch/ppc/platforms/Makefile      |    6 ++++++
 2 files changed, 8 insertions(+)

diff -puN arch/ppc/boot/simple/misc-prep.c~various-powerpc-32bit-ppc64-build-fixes arch/ppc/boot/simple/misc-prep.c
--- devel/arch/ppc/boot/simple/misc-prep.c~various-powerpc-32bit-ppc64-build-fixes	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc/boot/simple/misc-prep.c	2005-10-28 17:44:04.000000000 -0700
@@ -152,9 +152,11 @@ load_kernel(unsigned long load_addr, int
 		hold_residual->VitalProductData.Reserved5 = 0xdeadbeef;
 	}
 
+#if defined(CONFIG_6xx)
 	/* Now go and clear out the BATs and ensure that our MSR is
 	 * correct .*/
 	disable_6xx_mmu();
+#endif
 
 	/* Make r3 be a pointer to the residual data. */
 	return (unsigned long)hold_residual;
diff -puN arch/ppc/platforms/Makefile~various-powerpc-32bit-ppc64-build-fixes arch/ppc/platforms/Makefile
--- devel/arch/ppc/platforms/Makefile~various-powerpc-32bit-ppc64-build-fixes	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/Makefile	2005-10-28 17:44:04.000000000 -0700
@@ -9,9 +9,15 @@ obj-$(CONFIG_APUS)		+= apus_setup.o
 ifeq ($(CONFIG_APUS),y)
 obj-$(CONFIG_PCI)		+= apus_pci.o
 endif
+ifeq ($(CONFIG_6xx),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
 					pmac_low_i2c.o pmac_cache.o
+else
+obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
+					pmac_feature.o pmac_pci.o pmac_sleep.o \
+					pmac_low_i2c.o
+endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o \
 					chrp_pegasos_eth.o
 ifeq ($(CONFIG_PPC_CHRP),y)
_
