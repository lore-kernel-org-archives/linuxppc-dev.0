Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] do firmware feature fixups after features are initialised 
Date: Fri, 08 Jun 2007 14:00:35 +1000
Message-ID: <9094.1181275235@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On pSeries the firmware features are not setup until ppc_md.init_early,
so we can't do the firmware feature sections fixups till after this.

Currently firmware feature sections is only used on iSeries which inits
the firmware features much earlier.  This is a bug in waiting on
pSeries. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
paulus: since we aren't hitting this currently, it can wait for 2.6.23. 

 arch/powerpc/kernel/setup_64.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/setup_64.c
@@ -350,13 +350,11 @@ void __init setup_system(void)
 {
 	DBG(" -> setup_system()\n");
 
-	/* Apply the CPUs-specific and firmware specific fixups to kernel
-	 * text (nop out sections not relevant to this CPU or this firmware)
+	/* Apply CPUs-specific fixups to kernel text (nop out sections
+	 * not relevant to this CPU)
 	 */
 	do_feature_fixups(cur_cpu_spec->cpu_features,
 			  &__start___ftr_fixup, &__stop___ftr_fixup);
-	do_feature_fixups(powerpc_firmware_features,
-			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
@@ -394,6 +392,12 @@ void __init setup_system(void)
 	if (ppc_md.init_early)
 		ppc_md.init_early();
 
+	/* Apply firmware specific fixups to kernel text (nop out
+	 * sections not relevant to this firmware)
+	 */
+	do_feature_fixups(powerpc_firmware_features,
+			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
+
  	/*
 	 * We can discover serial ports now since the above did setup the
 	 * hash table management for us, thus ioremap works. We do that early
