Message-ID: <3D42CA9D.3070108@dslextreme.com>
Date: Sat, 27 Jul 2002 09:30:21 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Cort Dougan <cort@fsmlabs.com>, Matthew Locke <mlocke@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
References: <20020725105336.F2276@host110.fsmlabs.com> <20020725162026.19919@192.168.4.1> <3D404F83.8010308@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> Benjamin Herrenschmidt wrote:
>
>
>> Well, while I tend to agree with you on this, experience proved that
>> slightly abusing the ppc_md. indirection somewhat helped make the
>> code cleaner (read: more self-contained, less cruft, ...)
>
>
> All of the architectures except PowerPC seem to have a indirect
> pointer to a power saving idle function from the idle loop.  If
> you don't want to follow this, we could have all of the board
> specific files contain a 'power_save()' function, which could be
> empty, always compile it and always call it.  Today, the power
> saving stuff is all 6xx/7xx/Mac specific, which kinda needs to
> change if we want address the needs of embedded processors and
> products.
>
>
>     -- Dan
>
>
>

Here is what I think might work.  I am borrowing the idea from i386 &
Arm.  This will allow greater flexibilty for thos who need it.  I have
an example for both a 4xx impilmentation and what would be needed in idle.c.

What do think :)


armin



diff -Nru a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
--- a/arch/ppc/kernel/idle.c	Sat Jul 27 09:24:06 2002
+++ b/arch/ppc/kernel/idle.c	Sat Jul 27 09:24:06 2002
@@ -1,5 +1,5 @@
  /*
- * BK Id: %F% %I% %G% %U% %#%
+ * BK Id: SCCS/s.idle.c 1.31 04/16/02 21:42:08 paulus
   */
  /*
   * Idle daemon for PowerPC.  Idle daemon will handle any action
@@ -11,6 +11,11 @@
   * modify it under the terms of the GNU General Public License
   * as published by the Free Software Foundation; either version
   * 2 of the License, or (at your option) any later version.
+ *
+ * 	07/27/02 - Armin
+ * 	added powersave idel loop indirection scheme borrowed from
+ * 	i386 & Arm so other ppc archs can have their own if the
+ * 	default is not sufficiant.
   */
  #include <linux/config.h>
  #include <linux/errno.h>
@@ -50,6 +55,8 @@

  void zero_paged(void);
  void power_save(void);
+void (*pm_idle)(void);
+

  unsigned long zero_paged_on = 0;
  unsigned long powersave_nap = 0;
@@ -96,9 +103,12 @@

	}
  		}
  #endif
-
	if (do_power_save && !current->need_resched)
-
		power_save();
+
	void (*idle)(void) = pm_idle;
+
	if (!idle)
+
		   idle = power_save;

+
	if (do_power_save && !current->need_resched)
+
		idle();
  		if (current->need_resched) {

	run_light_on(1);

	schedule();
diff -Nru a/arch/ppc/kernel/ppc4xx_setup.c b/arch/ppc/kernel/ppc4xx_setup.c
--- a/arch/ppc/kernel/ppc4xx_setup.c	Sat Jul 27 09:24:06 2002
+++ b/arch/ppc/kernel/ppc4xx_setup.c	Sat Jul 27 09:24:06 2002
@@ -27,6 +27,9 @@
   *	History: 04/18/02 - Armin
   *	added ash to setting CETE bit in calibrate()
   *
+ *		: 07/27/02 - Armin
+ *		Added powersave idle loop
+ *
   */

  #include <linux/config.h>
@@ -60,6 +63,7 @@

  /* Function Prototypes */
  static void ppc4xx_gdb_init(void);
+static void arch_power_save(void);

  extern void abort(void);
  extern void ppc4xx_find_bridges(void);
@@ -87,6 +91,7 @@
  extern void board_io_mapping(void);
  extern void board_setup_irq(void);
  extern void board_init(void);
+extern void (*pm_idle) (void);

  /* Global Variables */
  unsigned char __res[sizeof (bd_t)];
@@ -94,7 +99,7 @@
  static void __init
  ppc4xx_setup_arch(void)
  {
-
+
  	/* Setup PCI host bridges */

  #ifdef CONFIG_PCI
@@ -110,6 +115,9 @@
  	board_setup_arch();

  	ppc4xx_gdb_init();
+

+
pm_idle = arch_power_save;
+
  }

  /*
@@ -454,4 +462,38 @@
  	board_init();

  	return;
+}
+
+void arch_power_save(void)
+{
+
extern void (*pm_idle) (void);
+
extern unsigned long powersave_nap;
+
int nap = powersave_nap;
+

+
pm_idle = arch_power_save;
+

+
if (!(nap || (cur_cpu_spec[smp_processor_id()]->cpu_features &
CPU_FTR_CAN_DOZE)))
+
	return;
+
/*
+
  * Disable interrupts to prevent a lost wakeup
+
  * when going to sleep.  This is necessary even with
+
  * RTLinux since we are not guaranteed an interrupt
+
  * didn't come in and is waiting for a __sti() before
+
  * emulating one.  This way, we really do hard disable.
+
  *
+
  * We assume that we're sti-ed when we come in here.  We
+
  * are in the idle loop so if we're cli-ed then it's a bug
+
  * anyway.
+
  *  -- Cort
+
  */
+
_nmask_and_or_msr(MSR_EE, 0);
+
if (!current->need_resched)
+

+
	/* set the POW bit in the MSR, and enable interrupts
+
	 * so we wake up sometime! */
+
	_nmask_and_or_msr(0, MSR_POW | MSR_EE);
+

+
_nmask_and_or_msr(0, MSR_EE);
+

+
pm_idle = arch_power_save;
  }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
