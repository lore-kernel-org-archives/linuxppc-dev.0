Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:02 +1100
Subject: [PATCH 5/11] powerpc: iseries: mf related cleanups
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094632.ADC4467B6B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some cleanups in the iSeries code.
 - Make mf_display_progress() check mf_initialized rather than the caller.
 - Set mf_initialized in mf_init() rather than in setup.c
 - Then move mf_initialized into mf.c, the only place it's used.
 - Move the mf related logic from iSeries_progress() to mf_display_progress()
 - Use a #define to size the pending_event_prealloc array
 - Use that define in the initialsation loop rather than sizeof jiggery pokery
 - Remove stupid comment(s)
 - Mark stuff static and/or __init

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/mf.c    |   32 +++++++++++++++++++++++---------
 arch/powerpc/platforms/iseries/setup.c |   11 +----------
 include/asm-powerpc/iseries/mf.h       |    1 -
 3 files changed, 24 insertions(+), 20 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/mf.c
+++ to-merge/arch/powerpc/platforms/iseries/mf.c
@@ -46,6 +46,7 @@
 #include "setup.h"
 
 extern int piranha_simulator;
+static int mf_initialized = 0;
 
 /*
  * This is the structure layout for the Machine Facilites LPAR event
@@ -143,7 +144,8 @@ static spinlock_t pending_event_spinlock
 static struct pending_event *pending_event_head;
 static struct pending_event *pending_event_tail;
 static struct pending_event *pending_event_avail;
-static struct pending_event pending_event_prealloc[16];
+#define PENDING_EVENT_PREALLOC_LEN 16
+static struct pending_event pending_event_prealloc[PENDING_EVENT_PREALLOC_LEN];
 
 /*
  * Put a pending event onto the available queue, so it can get reused.
@@ -625,7 +627,7 @@ void mf_display_src(u32 word)
 /*
  * Display a single word SRC of the form "PROGXXXX" on the VSP control panel.
  */
-void mf_display_progress(u16 value)
+static __init void mf_display_progress_src(u16 value)
 {
 	u8 ce[12];
 	u8 src[72];
@@ -649,30 +651,42 @@ void mf_display_progress(u16 value)
  * Clear the VSP control panel.  Used to "erase" an SRC that was
  * previously displayed.
  */
-void mf_clear_src(void)
+static void mf_clear_src(void)
 {
 	signal_ce_msg_simple(0x4b, NULL);
 }
 
+void __init mf_display_progress(u16 value)
+{
+	if (piranha_simulator || !mf_initialized)
+		return;
+
+	if (0xFFFF == value)
+		mf_clear_src();
+	else
+		mf_display_progress_src(value);
+}
+
 /*
  * Initialization code here.
  */
-void mf_init(void)
+void __init mf_init(void)
 {
 	int i;
 
-	/* initialize */
 	spin_lock_init(&pending_event_spinlock);
-	for (i = 0;
-	     i < sizeof(pending_event_prealloc) / sizeof(*pending_event_prealloc);
-	     ++i)
+
+	for (i = 0; i < PENDING_EVENT_PREALLOC_LEN; i++)
 		free_pending_event(&pending_event_prealloc[i]);
+
 	HvLpEvent_registerHandler(HvLpEvent_Type_MachineFac, &hv_handler);
 
 	/* virtual continue ack */
 	signal_ce_msg_simple(0x57, NULL);
 
-	/* initialization complete */
+	mf_initialized = 1;
+	mb();
+
 	printk(KERN_NOTICE "mf.c: iSeries Linux LPAR Machine Facilities "
 			"initialized\n");
 }
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -89,8 +89,6 @@ extern unsigned long embedded_sysmap_end
 extern unsigned long iSeries_recal_tb;
 extern unsigned long iSeries_recal_titan;
 
-static int mf_initialized;
-
 static unsigned long cmd_mem_limit;
 
 struct MemoryBlock {
@@ -347,8 +345,6 @@ static void __init iSeries_init_early(vo
 	HvCallEvent_setLpEventQueueInterruptProc(0, 0);
 
 	mf_init();
-	mf_initialized = 1;
-	mb();
 
 	/* If we were passed an initrd, set the ROOT_DEV properly if the values
 	 * look sensible. If not, clear initrd reference.
@@ -585,12 +581,7 @@ static void iSeries_halt(void)
 static void __init iSeries_progress(char * st, unsigned short code)
 {
 	printk("Progress: [%04x] - %s\n", (unsigned)code, st);
-	if (!piranha_simulator && mf_initialized) {
-		if (code != 0xffff)
-			mf_display_progress(code);
-		else
-			mf_clear_src();
-	}
+	mf_display_progress(code);
 }
 
 static void __init iSeries_fixup_klimit(void)
Index: to-merge/include/asm-powerpc/iseries/mf.h
===================================================================
--- to-merge.orig/include/asm-powerpc/iseries/mf.h
+++ to-merge/include/asm-powerpc/iseries/mf.h
@@ -45,7 +45,6 @@ extern void mf_reboot(void);
 
 extern void mf_display_src(u32 word);
 extern void mf_display_progress(u16 value);
-extern void mf_clear_src(void);
 
 extern void mf_init(void);
 
