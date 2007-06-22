Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 589E2DDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 16:54:31 +1000 (EST)
Date: Fri, 22 Jun 2007 16:54:30 +1000
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Move iSeries_tb_recal from do_settimeofday() into it's own
	late_initcall.
Message-ID: <20070622065430.GZ9768@bakeyournoodle.com>
References: <20070622054324.GV9768@bakeyournoodle.com>
	<1182492836.5760.10.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1182492836.5760.10.camel@concordia.ozlabs.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 22, 2007 at 04:13:56PM +1000, Michael Ellerman wrote:

> The safer option would be to have the init call schedule work for 40-60
> seconds after boot, but it's up to you :)

Ummm is "no" a valid answer?

Seriously though the 40-60 second delay is mostly udev starting (which
takes a full 30 of them), as this code predates udev I think this patch
is restoring the timing to somthing closer to the oriinal intent (but
then again I'm not a mind reader, nor a time lord so I could be wrong).

I did a few boot tests, 10 with and 10 without the patch.

The mean delta without the patch is 123.1 and wiht it's 122.9, so I'm
pretty confident that calling the recalibration earlier isn't going to
have a large impact.

> While you're at it, can you de-camelcase the names? Same comment
> elsewhere.

Not in this patch:
$yacks{tony}++;
 
> Is ENODEV the magic "init-call didn't actually fail" value? You don't
> want anything in the log.

Yes -ENODEV is magic for initcalls, You'll only see anything in your
logs if you boot with initcall_debug=1.

> The comment is only going to be wrong once someone moves something
> around. Better still, why not put this code in setup.c?

Yeah okay that comment is lame.  As to moving the code,
iSeries_tb_recal() uses (static) functions from time.c and I though it
was better to place it here than export them.


> Newline here please :)

Sure.
 
> I don't think we bother with #ifdef around externs, unless you're
> providing a no-op version.

Ooops yup leaving the extern defined is okay :/

Below is an updated version for your viewing pleasure.

From: Tony Breeds <tony@bakeyournoodle.com>

Move iSeries_tb_recal from do_settimeofday() into it's own late_initcall.

Currently iSeries will recalibrate the cputime_factors, from the first
settimeofday() call.

It seems the reason for doing this is to ensure a resaonable time delta after
time_init().  On current kernels (with udev), this call is made 40-60 seconds
into the boot process, by moving it to a late initcall it is called
approximately 5 seconds after time_init() is called.  This is sufficient to
recalibrate the timebase.



Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/powerpc/kernel/time.c             |   30 +++++++++++++++----------
 arch/powerpc/platforms/iseries/setup.c |    7 +----
 include/asm-powerpc/time.h             |    4 +++
 3 files changed, 25 insertions(+), 16 deletions(-)

Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c
+++ working/arch/powerpc/kernel/time.c
@@ -77,9 +77,8 @@
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
 #ifdef CONFIG_PPC_ISERIES
-unsigned long iSeries_recal_titan = 0;
-unsigned long iSeries_recal_tb = 0; 
-static unsigned long first_settimeofday = 1;
+static unsigned long __initdata iSeries_recal_titan;
+static signed long __initdata iSeries_recal_tb;
 #endif
 
 /* The decrementer counts down by 128 every 128ns on a 601. */
@@ -551,10 +550,15 @@ EXPORT_SYMBOL(profile_pc);
  * returned by the service processor for the timebase frequency.  
  */
 
-static void iSeries_tb_recal(void)
+static int __init iSeries_tb_recal(void)
 {
 	struct div_result divres;
 	unsigned long titan, tb;
+
+	/* Make sure we only run on iSeries */
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	tb = get_tb();
 	titan = HvCallXm_loadTod();
 	if ( iSeries_recal_titan ) {
@@ -595,8 +599,18 @@ static void iSeries_tb_recal(void)
 	}
 	iSeries_recal_titan = titan;
 	iSeries_recal_tb = tb;
+
+	return 0;
 }
-#endif
+late_initcall(iSeries_tb_recal);
+
+/* Called from platform early init */
+void __init iSeries_time_init_early(void)
+{
+	iSeries_recal_tb = get_tb();
+	iSeries_recal_titan = HvCallXm_loadTod();
+}
+#endif /* CONFIG_PPC_ISERIES */
 
 /*
  * For iSeries shared processors, we have to let the hypervisor
@@ -760,12 +774,6 @@ int do_settimeofday(struct timespec *tv)
 	 * to the RTC again, or write to the RTC but then they don't call
 	 * settimeofday to perform this operation.
 	 */
-#ifdef CONFIG_PPC_ISERIES
-	if (firmware_has_feature(FW_FEATURE_ISERIES) && first_settimeofday) {
-		iSeries_tb_recal();
-		first_settimeofday = 0;
-	}
-#endif
 
 	/* Make userspace gettimeofday spin until we're done. */
 	++vdso_data->tb_update_count;
Index: working/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- working.orig/arch/powerpc/platforms/iseries/setup.c
+++ working/arch/powerpc/platforms/iseries/setup.c
@@ -79,8 +79,6 @@ extern void iSeries_pci_final_fixup(void
 static void iSeries_pci_final_fixup(void) { }
 #endif
 
-extern unsigned long iSeries_recal_tb;
-extern unsigned long iSeries_recal_titan;
 
 struct MemoryBlock {
 	unsigned long absStart;
@@ -292,8 +290,8 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-	iSeries_recal_tb = get_tb();
-	iSeries_recal_titan = HvCallXm_loadTod();
+	/* Snapshot the timebase, for use in later recalibration */
+	iSeries_time_init_early();
 
 	/*
 	 * Initialize the DMA/TCE management
Index: working/include/asm-powerpc/time.h
===================================================================
--- working.orig/include/asm-powerpc/time.h
+++ working/include/asm-powerpc/time.h
@@ -240,5 +240,7 @@ extern void snapshot_timebases(void);
 #define snapshot_timebases()			do { } while (0)
 #endif
 
+extern void iSeries_time_init_early(void);
+
 #endif /* __KERNEL__ */
 #endif /* __POWERPC_TIME_H */


Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
