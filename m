From: Cort Dougan <cort@fsmlabs.com>
Date: Sun, 21 Apr 2002 19:04:47 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Make heartbeat per-cpu (fix gemini, RTAS scan on chrps)
Message-ID: <20020421190447.B16420@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8P1HSweYDcXXzwPJ"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch makes the heartbeat calls per-cpu.  This allows gemini to only
call it on cpu 0 (to update the lights) and fixes the problem with CHRP SMP
boards that would end up calling the RTAS scan only on a few CPUS.  This
patches balances out the RTAS calls deterministically rather than
statistically.


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="percpu_heartbeat.patch"

diff -Nru a/arch/ppc/kernel/apus_setup.c b/arch/ppc/kernel/apus_setup.c
--- a/arch/ppc/kernel/apus_setup.c	Sun Apr 21 19:00:39 2002
+++ b/arch/ppc/kernel/apus_setup.c	Sun Apr 21 19:00:39 2002
@@ -109,8 +109,8 @@
 void (*mach_floppy_eject) (void) = NULL;
 #endif
 #ifdef CONFIG_HEARTBEAT
-void (*mach_heartbeat) (int) = NULL;
-extern void apus_heartbeat (void);
+void (*mach_heartbeat[NR_CPUS]) (int) = NULL;
+extern void apus_heartbeat[NR_CPUS] (void);
 #endif

 extern unsigned long amiga_model;
@@ -1075,8 +1075,8 @@
 	/*ppc_md.post_irq       = apus_post_irq;*/

 #ifdef CONFIG_HEARTBEAT
-	ppc_md.heartbeat      = apus_heartbeat;
-	ppc_md.heartbeat_count = 1;
+	ppc_md.heartbeat[0]      = apus_heartbeat;
+	ppc_md.heartbeat_count[0] = 1;
 #endif
 #ifdef APUS_DEBUG
 	__debug_serinit();
diff -Nru a/arch/ppc/kernel/chrp_setup.c b/arch/ppc/kernel/chrp_setup.c
--- a/arch/ppc/kernel/chrp_setup.c	Sun Apr 21 19:00:39 2002
+++ b/arch/ppc/kernel/chrp_setup.c	Sun Apr 21 19:00:39 2002
@@ -229,6 +229,8 @@
 chrp_setup_arch(void)
 {
 	struct device_node *device;
+	int i;
+	extern unsigned long smp_chrp_cpu_nr;

 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000/HZ;
@@ -287,19 +289,54 @@
 	/* Get the event scan rate for the rtas so we know how
 	 * often it expects a heartbeat. -- Cort
 	 */
-	if ( rtas_data ) {
+	if ( rtas_data )
+	{
 		struct property *p;
 		device = find_devices("rtas");
 		for ( p = device->properties;
 		      p && strncmp(p->name, "rtas-event-scan-rate", 20);
 		      p = p->next )
 			/* nothing */ ;
-		if ( p && *(unsigned long *)p->value ) {
-			ppc_md.heartbeat = chrp_event_scan;
-			ppc_md.heartbeat_reset = (HZ/(*(unsigned long *)p->value)*30)-1;
-			ppc_md.heartbeat_count = 1;
-			printk("RTAS Event Scan Rate: %lu (%lu jiffies)\n",
-			       *(unsigned long *)p->value, ppc_md.heartbeat_reset );
+		if ( p && *(unsigned long *)p->value )
+		{
+
+			/*
+			 * The CHRP RTAS note on multiprocessor systems:
+			 * "In a multiprocessor system, each processor should
+			 * call event-scan periodically, not always the same
+			 * one.  The event-scan function needs to be called a
+			 * total of rtas-event-scan-rate times a minute"
+			 *
+			 * My interpretation of the Chrp docs on the
+			 * scan rate is that not every CPU has to do
+			 * the event scan.  It seems to suggest that
+			 * occasionally a different CPU should scan
+			 * RTAS but this is so vague I think the authors
+			 * considered it unimportant.
+			 *
+			 * Paul disagrees, so I run the event scan on each
+			 * CPU.  This is probably safe since it won't hurt
+			 * and will only slow things down a bit.
+			 *
+			 * -- Cort <cort@fsmlabs.com>
+			 */
+			int rate;
+
+			/* avoid div 0 problems */
+			if ( smp_chrp_cpu_nr )
+				rate = *(ulong *)p->value / smp_chrp_cpu_nr;
+			else
+				rate = *(ulong *)p->value;
+
+			for ( i = 0; i < smp_chrp_cpu_nr ; i++ )
+			{
+				ppc_md.heartbeat[i] = chrp_event_scan;
+				ppc_md.heartbeat_reset[i] = (HZ/rate)-1;
+				ppc_md.heartbeat_count[i] = 1;
+			}
+			printk("RTAS Event Scan Rate: %lu calls/minute "
+			       "(%lu jiffies/cpu)\n",
+			       *(unsigned long *)p->value, rate );
 		}
 	}
 }
@@ -312,7 +349,8 @@
 	/* XXX: we should loop until the hardware says no more error logs -- Cort */
 	call_rtas( "event-scan", 4, 1, &ret, 0xffffffff, 0,
 		   __pa(log), 1024 );
-	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
+	ppc_md.heartbeat_count[smp_processor_id()] =
+		ppc_md.heartbeat_reset[smp_processor_id()];
 }

 void __chrp
diff -Nru a/arch/ppc/kernel/gemini_setup.c b/arch/ppc/kernel/gemini_setup.c
--- a/arch/ppc/kernel/gemini_setup.c	Sun Apr 21 19:00:39 2002
+++ b/arch/ppc/kernel/gemini_setup.c	Sun Apr 21 19:00:39 2002
@@ -196,7 +196,7 @@
 		direction *= -1;
 	led += direction;
 	*(char *)led = 0xff;
-	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
+	ppc_md.heartbeat_count[0] = ppc_md.heartbeat_reset[0];
 }

 int
@@ -325,7 +325,7 @@

 	/* Stop LED's on shutdown. From Tim Moloney <moloney@mrsl.com> */

-	ppc_md.heartbeat = NULL;
+	ppc_md.heartbeat[0] = NULL;
 	for (i = 0; i < GEMINI_LEDS; i++)
 		gemini_led_off(i);
 	for(;;);
@@ -664,9 +664,9 @@
 #endif
 		ROOT_DEV = to_kdev_t(0x0801); /* /dev/sda1 */

-	ppc_md.heartbeat = gemini_heartbeat;
-	ppc_md.heartbeat_reset = HZ/8;
-	ppc_md.heartbeat_count = 1;
+	ppc_md.heartbeat[0] = gemini_heartbeat;
+	ppc_md.heartbeat_reset[0] = HZ/8;
+	ppc_md.heartbeat_count[0] = 1;

 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
diff -Nru a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c	Sun Apr 21 19:00:39 2002
+++ b/arch/ppc/kernel/time.c	Sun Apr 21 19:00:39 2002
@@ -194,15 +194,14 @@
 		write_unlock(&xtime_lock);

 		/*
-		 * We only run the heartbeat on cpu 0.  We also
-		 * need to make sure we catch up with lost interrupts
+		 * We need to make sure we catch up with lost interrupts
 		 * so we do it in this loop rather than after this
 		 * loop like we used to do.
 		 *     -- Cort <cort@fsmlabs.com>
 		 */
-		if ( !smp_processor_id() && ppc_md.heartbeat &&
-		     !ppc_md.heartbeat_count-- )
-			ppc_md.heartbeat();
+		if ( ppc_md.heartbeat[smp_processor_id()] &&
+		     !ppc_md.heartbeat_count[smp_processor_id()]-- )
+			ppc_md.heartbeat[smp_processor_id()]();

 	}
 	if ( !disarm_decr[smp_processor_id()] )
diff -Nru a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
--- a/include/asm-ppc/machdep.h	Sun Apr 21 19:00:39 2002
+++ b/include/asm-ppc/machdep.h	Sun Apr 21 19:00:39 2002
@@ -10,6 +10,7 @@
 #ifdef CONFIG_APUS
 #include <asm-m68k/machdep.h>
 #endif
+#include <linux/threads.h>

 struct pt_regs;
 struct pci_bus;
@@ -39,9 +40,9 @@
 	unsigned long	(*get_rtc_time)(void);
 	void		(*calibrate_decr)(void);

-	void		(*heartbeat)(void);
-	unsigned long	heartbeat_reset;
-	unsigned long	heartbeat_count;
+	void		(*heartbeat[NR_CPUS])(void);
+	unsigned long	heartbeat_reset[NR_CPUS];
+	unsigned long	heartbeat_count[NR_CPUS];

 	unsigned long	(*find_end_of_memory)(void);
 	void		(*setup_io_mappings)(void);

--8P1HSweYDcXXzwPJ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
