From: Allen Curtis <acurtis@onz.com>
Reply-To: acurtis@onz.com
To: dan@embeddededge.com
Subject: Misc 8260 fixes/options
Date: Tue, 27 Aug 2002 17:10:10 -0700
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YS1JDUPFK9SG2GTD0OZE"
Message-Id: <200208271710.10344.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--------------Boundary-00=_YS1JDUPFK9SG2GTD0OZE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Added support for:
Custom reset vector
Local RAM allocation
fix in pgtable.c
etc..
--
All things come to those who wait. Some of us just have to wait a little
longer...
--------------Boundary-00=_YS1JDUPFK9SG2GTD0OZE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="8260misc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="8260misc.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1114.1.2 -> 1.1114.1.3
#	  arch/ppc/config.in	1.151   -> 1.152
#	arch/ppc/kernel/ppc_ksyms.c	1.98    -> 1.99
#	include/asm-ppc/commproc.h	1.4     -> 1.5
#	arch/ppc/kernel/m8260_setup.c	1.38    -> 1.39
#	arch/ppc/mm/pgtable.c	1.21    -> 1.22
#	arch/ppc/8260_io/commproc.c	1.12    -> 1.13
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1114.1.3
# Misc 8260 related enhancements and fixes.
# --------------------------------------------
#
diff -Nru a/arch/ppc/8260_io/commproc.c b/arch/ppc/8260_io/commproc.c
--- a/arch/ppc/8260_io/commproc.c	Tue Aug 27 16:33:49 2002
+++ b/arch/ppc/8260_io/commproc.c	Tue Aug 27 16:33:49 2002
@@ -37,6 +37,10 @@
 static	uint	dp_alloc_top;	/* Max offset + 1 */
 static	uint	host_buffer;	/* One page of host buffer */
 static	uint	host_end;	/* end + 1 */
+#ifdef CONFIG_8260_LRAM
+static	uint	ldram_buffer;	/* Starting address for LDRAM */
+static	uint	ldram_end;	/* end + 1 */
+#endif
 cpm8260_t	*cpmp;		/* Pointer to comm processor space */

 /* We allocate this here because it is used almost exclusively for
@@ -67,6 +71,13 @@

 	vpgaddr = host_buffer;

+#ifdef CONFIG_8260_LRAM
+	/* Local DRAM for CPM communication buffers
+	*/
+	ldram_buffer = ioremap(CONFIG_8260_LRAM_BASE, CONFIG_8260_LRAM_SIZE);
+	ldram_end	 = ldram_buffer + CONFIG_8260_LRAM_BASE;
+#endif
+
 	/* Tell everyone where the comm processor resides.
 	*/
 	cpmp = (cpm8260_t *)commproc;
@@ -126,6 +137,35 @@

 	return(retloc);
 }
+
+#ifdef CONFIG_8260_LRAM
+/* Due to CPM lockup problems, communication buffers should
+ * be allocated with this routine.
+ */
+uint
+m8260_cpm_lramalloc(uint size, uint align)
+{
+	uint	retloc;
+	uint	align_mask, off;
+	uint	savebase;
+
+	align_mask = align - 1;
+	savebase = ldram_buffer;
+
+	if ((off = (ldram_buffer & align_mask)) != 0)
+		ldram_buffer += (align - off);
+
+	if ((ldram_buffer + size) >= ldram_end) {
+		ldram_buffer = savebase;
+		return(0);
+	}
+
+	retloc = ldram_buffer;
+	ldram_buffer += size;
+
+	return(retloc);
+}
+#endif

 /* Set a baud rate generator.  This needs lots of work.  There are
  * eight BRGs, which can be connected to the CPM channels or output
diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Tue Aug 27 16:33:49 2002
+++ b/arch/ppc/config.in	Tue Aug 27 16:33:49 2002
@@ -74,6 +74,10 @@
 	if [ "$CONFIG_EST8260" = "y" -o "$CONFIG_RPX6" = "y" ]; then
 	  define_bool CONFIG_EMBEDDEDBOOT y
 	fi
+
+	if [ "$CONFIG_TQM8260" = "y" ]; then
+	  define_bool CONFIG_8260_RTC_TMCNT
+	fi
 fi

 if [ "$CONFIG_40x" = "y" ]; then
@@ -379,6 +383,10 @@
     fi
   fi

+  bool "Set custom reset vector address" CONFIG_RESET_VECTOR
+  if [ "$CONFIG_RESET_VECTOR" = "y" ]; then
+    hex "  Physical address of reset vector" CONFIG_RESET_VECTOR_ADDR 0xfff00100
+  fi
   bool "Set custom kernel base address" CONFIG_KERNEL_START_BOOL
   if [ "$CONFIG_KERNEL_START_BOOL" = "y" ]; then
     hex "  Virtual address of kernel base" CONFIG_KERNEL_START 0xc0000000
diff -Nru a/arch/ppc/kernel/m8260_setup.c b/arch/ppc/kernel/m8260_setup.c
--- a/arch/ppc/kernel/m8260_setup.c	Tue Aug 27 16:33:49 2002
+++ b/arch/ppc/kernel/m8260_setup.c	Tue Aug 27 16:33:49 2002
@@ -99,7 +99,7 @@
 static static int
 m8260_set_rtc_time(unsigned long time)
 {
-#ifdef CONFIG_TQM8260
+#ifdef CONFIG_8260_RTC_TMCNT
 	((immap_t *)IMAP_ADDR)->im_sit.sit_tmcnt = time;
 	((immap_t *)IMAP_ADDR)->im_sit.sit_tmcntsc = 0x3;
 #else
@@ -111,7 +111,7 @@
 static unsigned long
 m8260_get_rtc_time(void)
 {
-#ifdef CONFIG_TQM8260
+#ifdef CONFIG_8260_RTC_TMCNT
 	return ((immap_t *)IMAP_ADDR)->im_sit.sit_tmcnt;
 #else
 	/* Get time from the RTC.
@@ -132,6 +132,8 @@
 	 */
 #ifdef CONFIG_TQM8260
 	startaddr = 0x40000104;
+#elif  CONFIG_RESET_VECTOR
+	startaddr = CONFIG_RESET_VECTOR_ADDR;
 #else
 	startaddr = 0xff000104;
 #endif
@@ -146,13 +148,14 @@
 static void
 m8260_power_off(void)
 {
-   m8260_restart(NULL);
+   __cli();
+   while (1);
 }

 static void
 m8260_halt(void)
 {
-   m8260_restart(NULL);
+   m8260_power_off();
 }


diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Tue Aug 27 16:33:49 2002
+++ b/arch/ppc/kernel/ppc_ksyms.c	Tue Aug 27 16:33:49 2002
@@ -353,6 +353,21 @@
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */

+#if defined(CONFIG_8260)
+extern uint m8260_cpm_dpalloc(uint size, uint align);
+extern uint m8260_cpm_hostalloc(uint size, uint align);
+extern void m8260_cpm_setbrg(uint brg, uint rate);
+extern void m8260_cpm_fastbrg(uint brg, uint rate, int div16);
+EXPORT_SYMBOL(m8260_cpm_dpalloc);
+EXPORT_SYMBOL(m8260_cpm_hostalloc);
+EXPORT_SYMBOL(m8260_cpm_setbrg);
+EXPORT_SYMBOL(m8260_cpm_fastbrg);
+#ifdef CONFIG_8260_LRAM
+extern uint m8260_cpm_lramalloc(uint size, uint align);
+EXPORT_SYMBOL(m8260_cpm_lramalloc);
+#endif
+#endif
+
 EXPORT_SYMBOL(ret_to_user_hook);
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
diff -Nru a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c	Tue Aug 27 16:33:49 2002
+++ b/arch/ppc/mm/pgtable.c	Tue Aug 27 16:33:49 2002
@@ -356,6 +356,10 @@
 /* is x a power of 2? */
 #define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))

+#define _128KB			(128*1024U)
+#define _256MB			(256*1024*1024U)
+#define is_size_ok(x)		(!((x) < _128KB || (x) > _256MB))
+
 /*
  * Set up a mapping for a block of I/O.
  * virt, phys, size must all be page-aligned.
@@ -373,7 +377,7 @@
 	/*
 	 * Use a BAT for this if possible...
 	 */
-	if (io_bat_index < 2 && is_power_of_2(size)
+	if (io_bat_index < 2 && is_power_of_2(size) && is_size_ok(size)
 	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
 		setbat(io_bat_index, virt, phys, size, flags);
 		++io_bat_index;
diff -Nru a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
--- a/include/asm-ppc/commproc.h	Tue Aug 27 16:33:49 2002
+++ b/include/asm-ppc/commproc.h	Tue Aug 27 16:33:49 2002
@@ -67,9 +67,13 @@
  * and dual port ram.
  */
 extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
-uint		m8xx_cpm_dpalloc(uint size);
-uint		m8xx_cpm_hostalloc(uint size);
-void		m8xx_cpm_setbrg(uint brg, uint rate);
+uint m8260_cpm_dpalloc(uint size, uint align);
+uint m8260_cpm_hostalloc(uint size, uint align);
+#ifdef CONFIG_8260_LRAM
+extern uint m8260_cpm_lramalloc(uint size, uint align);
+#endif
+void m8260_cpm_setbrg(uint brg, uint rate);
+void m8260_cpm_fastbrg(uint brg, uint rate, int div16);

 /* Buffer descriptors used by many of the CPM protocols.
 */

--------------Boundary-00=_YS1JDUPFK9SG2GTD0OZE--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
