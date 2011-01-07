Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 14:57:03 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 5/8] powerpc/kexec: Don't initialise kexec hooks to default
	handlers
Message-ID: <20110107145703.466def36@kryten>
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


There's no need to initialise ppc_md.machine_kexec and
ppc_md.machine_kexec_prepare to the default handlers.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/platforms/cell/qpace_setup.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/qpace_setup.c	2011-01-07 12:51:56.222461754 +1100
+++ powerpc.git/arch/powerpc/platforms/cell/qpace_setup.c	2011-01-07 12:51:58.112521318 +1100
@@ -145,8 +145,4 @@ define_machine(qpace) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= qpace_progress,
 	.init_IRQ		= iic_init_IRQ,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-#endif
 };
Index: powerpc.git/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/kexec.c	2011-01-07 12:51:56.222461754 +1100
+++ powerpc.git/arch/powerpc/platforms/pseries/kexec.c	2011-01-07 12:51:58.112521318 +1100
@@ -61,12 +61,3 @@ void __init setup_kexec_cpu_down_xics(vo
 {
 	ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
 }
-
-static int __init pseries_kexec_setup(void)
-{
-	ppc_md.machine_kexec = default_machine_kexec;
-	ppc_md.machine_kexec_prepare = default_machine_kexec_prepare;
-
-	return 0;
-}
-machine_device_initcall(pseries, pseries_kexec_setup);
