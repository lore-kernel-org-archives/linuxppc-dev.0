Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:04 +1100
Subject: [PATCH 6/11] powerpc: iseries: Remove pointless
	iSeries_(restart|power_off|halt)
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094634.604BC67A3E@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These routines just call through to the mf routines, so point ppc_md straight
at the mf routines. We need to pass the cmd through to mf_reboot to make it
work, but that seems reasonable.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/mf.c    |    2 +-
 arch/powerpc/platforms/iseries/setup.c |   30 +++---------------------------
 include/asm-powerpc/iseries/mf.h       |    2 +-
 3 files changed, 5 insertions(+), 29 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/mf.c
+++ to-merge/arch/powerpc/platforms/iseries/mf.c
@@ -599,7 +599,7 @@ void mf_power_off(void)
  * Global kernel interface to tell the VSP object in the primary
  * partition to reboot this partition.
  */
-void mf_reboot(void)
+void mf_reboot(char *cmd)
 {
 	printk(KERN_INFO "mf.c: Preparing to bounce...\n");
 	signal_ce_msg_simple(0x4e, NULL);
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -554,30 +554,6 @@ static void iSeries_show_cpuinfo(struct 
 	seq_printf(m, "machine\t\t: 64-bit iSeries Logical Partition\n");
 }
 
-/*
- * Document me.
- */
-static void iSeries_restart(char *cmd)
-{
-	mf_reboot();
-}
-
-/*
- * Document me.
- */
-static void iSeries_power_off(void)
-{
-	mf_power_off();
-}
-
-/*
- * Document me.
- */
-static void iSeries_halt(void)
-{
-	mf_power_off();
-}
-
 static void __init iSeries_progress(char * st, unsigned short code)
 {
 	printk("Progress: [%04x] - %s\n", (unsigned)code, st);
@@ -716,9 +692,9 @@ struct machdep_calls __initdata iseries_
 	.get_irq	= iSeries_get_irq,
 	.init_early	= iSeries_init_early,
 	.pcibios_fixup	= iSeries_pci_final_fixup,
-	.restart	= iSeries_restart,
-	.power_off	= iSeries_power_off,
-	.halt		= iSeries_halt,
+	.restart	= mf_reboot,
+	.power_off	= mf_power_off,
+	.halt		= mf_power_off,
 	.get_boot_time	= iSeries_get_boot_time,
 	.set_rtc_time	= iSeries_set_rtc_time,
 	.get_rtc_time	= iSeries_get_rtc_time,
Index: to-merge/include/asm-powerpc/iseries/mf.h
===================================================================
--- to-merge.orig/include/asm-powerpc/iseries/mf.h
+++ to-merge/include/asm-powerpc/iseries/mf.h
@@ -41,7 +41,7 @@ extern void mf_deallocate_lp_events(HvLp
 		unsigned count, MFCompleteHandler hdlr, void *userToken);
 
 extern void mf_power_off(void);
-extern void mf_reboot(void);
+extern void mf_reboot(char *cmd);
 
 extern void mf_display_src(u32 word);
 extern void mf_display_progress(u16 value);
