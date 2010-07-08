Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0A548B6EED
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 03:16:18 +1000 (EST)
Date: Thu, 8 Jul 2010 21:16:16 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/cpm1: Mark micropatch code/data static and __init
Message-ID: <20100708171616.GC11621@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This saves runtime memory and fixes lots of sparse warnings like this:

    CHECK   arch/powerpc/sysdev/micropatch.c
  arch/powerpc/sysdev/micropatch.c:27:6: warning: symbol 'patch_2000'
  was not declared. Should it be static?
  arch/powerpc/sysdev/micropatch.c:146:6: warning: symbol 'patch_2f00'
  was not declared. Should it be static?
  ...

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/include/asm/cpm1.h  |    3 ++-
 arch/powerpc/sysdev/micropatch.c |   18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm1.h b/arch/powerpc/include/asm/cpm1.h
index 81b0119..bd07650 100644
--- a/arch/powerpc/include/asm/cpm1.h
+++ b/arch/powerpc/include/asm/cpm1.h
@@ -17,6 +17,7 @@
 #ifndef __CPM1__
 #define __CPM1__
 
+#include <linux/init.h>
 #include <asm/8xx_immap.h>
 #include <asm/ptrace.h>
 #include <asm/cpm.h>
@@ -54,7 +55,7 @@ extern cpm8xx_t __iomem *cpmp; /* Pointer to comm processor */
 
 extern void cpm_setbrg(uint brg, uint rate);
 
-extern void cpm_load_patch(cpm8xx_t *cp);
+extern void __init cpm_load_patch(cpm8xx_t *cp);
 
 extern void cpm_reset(void);
 
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/sysdev/micropatch.c
index 6c56ae9..c0bb76e 100644
--- a/arch/powerpc/sysdev/micropatch.c
+++ b/arch/powerpc/sysdev/micropatch.c
@@ -4,6 +4,7 @@
  * also relocates SMC2, but this would require additional changes
  * to uart.c, so I am holding off on that for a moment.
  */
+#include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -25,7 +26,7 @@
 
 #ifdef CONFIG_I2C_SPI_UCODE_PATCH
 
-uint patch_2000[] = {
+static uint patch_2000[] __initdata = {
 	0x7FFFEFD9,
 	0x3FFD0000,
 	0x7FFB49F7,
@@ -144,7 +145,7 @@ uint patch_2000[] = {
 	0x5F8247F8
 };
 
-uint patch_2f00[] = {
+static uint patch_2f00[] __initdata = {
 	0x3E303430,
 	0x34343737,
 	0xABF7BF9B,
@@ -183,7 +184,7 @@ uint patch_2f00[] = {
 
 #ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
 
-uint patch_2000[] = {
+static uint patch_2000[] __initdata = {
 	0x3fff0000,
 	0x3ffd0000,
 	0x3ffb0000,
@@ -506,7 +507,7 @@ uint patch_2000[] = {
 	0x6079e2bb
 };
 
-uint patch_2f00[] = {
+static uint patch_2f00[] __initdata = {
 	0x30303030,
 	0x3e3e3434,
 	0xabbf9b99,
@@ -573,7 +574,7 @@ uint patch_2f00[] = {
 	0xf22f3f23
 };
 
-uint patch_2e00[] = {
+static uint patch_2e00[] __initdata = {
 	0x27eeeeee,
 	0xeeeeeeee,
 	0xeeeeeeee,
@@ -599,7 +600,7 @@ uint patch_2e00[] = {
 
 #ifdef CONFIG_USB_SOF_UCODE_PATCH
 
-uint patch_2000[] = {
+static uint patch_2000[] __initdata = {
 	0x7fff0000,
 	0x7ffd0000,
 	0x7ffb0000,
@@ -614,15 +615,14 @@ uint patch_2000[] = {
 	0x60750000
 };
 
-uint patch_2f00[] = {
+static uint patch_2f00[] __initdata = {
 	0x3030304c,
 	0xcab9e441,
 	0xa1aaf220
 };
 #endif
 
-void
-cpm_load_patch(cpm8xx_t	*cp)
+void __init cpm_load_patch(cpm8xx_t *cp)
 {
 	volatile uint		*dp;		/* Dual-ported RAM. */
 	volatile cpm8xx_t	*commproc;
-- 
1.7.0.5
