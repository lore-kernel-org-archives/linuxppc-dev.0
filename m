Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 14:58:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 6/8] powerpc/kexec: Remove empty ppc_md.machine_kexec_prepare
Message-ID: <20110107145836.77ed440c@kryten>
In-Reply-To: <20110107145255.72cf30ba@kryten>
References: <20110107145255.72cf30ba@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We check for a valid handler before calling ppc_md.machine_kexec_prepare
so we can just remove these empty handlers.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/platforms/embedded6xx/wii.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/embedded6xx/wii.c	2010-12-13 22:52:03.535243386 +1100
+++ powerpc.git/arch/powerpc/platforms/embedded6xx/wii.c	2011-01-07 12:51:59.422562597 +1100
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/seq_file.h>
-#include <linux/kexec.h>
 #include <linux/of_platform.h>
 #include <linux/memblock.h>
 #include <mm/mmu_decl.h>
@@ -226,13 +225,6 @@ static void wii_shutdown(void)
 	flipper_quiesce();
 }
 
-#ifdef CONFIG_KEXEC
-static int wii_machine_kexec_prepare(struct kimage *image)
-{
-	return 0;
-}
-#endif /* CONFIG_KEXEC */
-
 define_machine(wii) {
 	.name			= "wii",
 	.probe			= wii_probe,
@@ -246,9 +238,6 @@ define_machine(wii) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 	.machine_shutdown	= wii_shutdown,
-#ifdef CONFIG_KEXEC
-	.machine_kexec_prepare	= wii_machine_kexec_prepare,
-#endif
 };
 
 static struct of_device_id wii_of_bus[] = {
Index: powerpc.git/arch/powerpc/platforms/embedded6xx/gamecube.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/embedded6xx/gamecube.c	2010-12-13 22:52:03.555243746 +1100
+++ powerpc.git/arch/powerpc/platforms/embedded6xx/gamecube.c	2011-01-07 12:51:59.422562597 +1100
@@ -75,14 +75,6 @@ static void gamecube_shutdown(void)
 	flipper_quiesce();
 }
 
-#ifdef CONFIG_KEXEC
-static int gamecube_kexec_prepare(struct kimage *image)
-{
-	return 0;
-}
-#endif /* CONFIG_KEXEC */
-
-
 define_machine(gamecube) {
 	.name			= "gamecube",
 	.probe			= gamecube_probe,
@@ -95,9 +87,6 @@ define_machine(gamecube) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 	.machine_shutdown	= gamecube_shutdown,
-#ifdef CONFIG_KEXEC
-	.machine_kexec_prepare	= gamecube_kexec_prepare,
-#endif
 };
 
 
