Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 37068B6F16
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jul 2010 17:23:47 +1000 (EST)
Received: by iwn36 with SMTP id 36so4536645iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Jul 2010 00:23:46 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 Jul 2010 00:23:45 -0700
Message-ID: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
Subject: kernel boot stuck at udbg_putc_cpm()
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm debugging the kernel (2.6.33.5) ported for a MPC870 board. The
changes are mostly based on the board adder875. The first thing I want
to test is the serial port. So I enabled CONFIG_PPC_EARLY_DEBUG and
CONFIG_PPC_EARLY_DEBUG_CPM, and changed
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR to 0xfa202008. My IMMR is 0xfa200000.
However the kernel seems to stuck at udbg_putc_cpm(). The most
significant bit at 0xfa202008 never changed to zero.

I did a few debugging sessions, observed some frustrating things.
Would anyone here more experienced shed some lights on potential
causes?

First I set breakpoint at machine_init(). Below is the debug session.

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
machine_init (dt_ptr=5890816) at arch/powerpc/kernel/setup_32.c:121
121	{
(gdb) next
125		udbg_early_init();
(gdb) next
^C
Program received signal SIGSTOP, Stopped (signal).
udelay (usecs=<value optimized out>)
    at /home/rayan/wti/code/wti-linux-2.6.33.5/arch/powerpc/include/asm/time.h:78
78		return mftbl();
(gdb) li
73	#if defined(CONFIG_403GCX)
74		unsigned long tbl;
75		asm volatile("mfspr %0, 0x3dd" : "=r" (tbl));
76		return tbl;
77	#else
78		return mftbl();
79	#endif
80	}
81	
82	static inline unsigned int get_tbu(void)
(gdb) step
413			while (get_tbl() - start < loops)
(gdb) step
414				HMT_low();
(gdb) print start
No symbol "start" in current context.
(gdb) print loops
No symbol "loops" in current context.
(gdb)

Several observations regarding to the above debugging session.
1. The kernel seems not able to pass udbg_early_init(). However if
breakpoint was set at functions being executed later such as
probe_machine() or start_kernel(), the udbg_early_init() was executed
properly.
2. When the execution was interrupted, it stopped at __delay(). And
the kernel seems not able to get out of this __delay() function. There
was even no symbols for local variables. Why?

Next I set the breakpoint at probe_machine(). The gdb session is shown
below. Again a couple of frustrating observations.
1. The kernel seems not able to get into the for loop. The breakpoint
set inside the for loop never got hit.
2. Once the execution was interrupted, it stopped at __delay() again,
same as the previous gdb session.

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
probe_machine () at arch/powerpc/kernel/setup-common.c:525
525	{
(gdb) step
535		for (machine_id = &__machine_desc_start;
(gdb) print __machine_desc_start
$1 = {name = 0xc013ea64 "My MPC870", pci_dma_dev_setup = 0,
  pci_dma_bus_setup = 0, probe = 0xc01544c4 <my870_probe>,
  setup_arch = 0xc015442c <my870_setup>, init_early = 0, show_cpuinfo = 0,
  show_percpuinfo = 0, init_IRQ = 0xc01541d4 <mpc8xx_pics_init>,
  get_irq = 0xc001344c <mpc8xx_get_irq>, pcibios_fixup = 0,
  pci_probe_mode = 0, pci_irq_fixup = 0, pci_setup_phb = 0,
  restart = 0xc0013f0c <mpc8xx_restart>, power_off = 0, halt = 0, panic = 0,
  cpu_die = 0, time_init = 0, set_rtc_time = 0xc0013fdc <mpc8xx_set_rtc_time>,
  get_rtc_time = 0xc0013f78 <mpc8xx_get_rtc_time>, get_boot_time = 0,
  rtc_read_val = 0, rtc_write_val = 0,
  calibrate_decr = 0xc0151e70 <generic_calibrate_decr>,
  progress = 0xc0153110 <udbg_progress>, log_error = 0, nvram_read_val = 0,
  nvram_write_val = 0, nvram_write = 0, nvram_read = 0, nvram_size = 0,
  nvram_sync = 0, system_reset_exception = 0, machine_check_exception = 0,
  feature_call = 0, pci_get_legacy_ide_irq = 0, phys_mem_access_prot = 0,
  idle_loop = 0, power_save = 0, enable_pmcs = 0, set_dabr = 0, init = 0,
  kgdb_map_scc = 0, pcibios_after_init = 0, pci_exclude_device = 0,
  pcibios_fixup_resources = 0, pcibios_fixup_bus = 0,
  pcibios_enable_device_hook = 0, machine_shutdown = 0}
(gdb) print __machine_desc_end
$2 = {name = 0x0, pci_dma_dev_setup = 0, pci_dma_bus_setup = 0, probe = 0,
  setup_arch = 0, init_early = 0, show_cpuinfo = 0, show_percpuinfo = 0,
  init_IRQ = 0, get_irq = 0, pcibios_fixup = 0, pci_probe_mode = 0,
  pci_irq_fixup = 0, pci_setup_phb = 0, restart = 0, power_off = 0, halt = 0,
  panic = 0, cpu_die = 0, time_init = 0, set_rtc_time = 0, get_rtc_time = 0,
  get_boot_time = 0, rtc_read_val = 0, rtc_write_val = 0, calibrate_decr = 0,
  progress = 0, log_error = 0, nvram_read_val = 0, nvram_write_val = 0,
  nvram_write = 0, nvram_read = 0, nvram_size = 0, nvram_sync = 0,
  system_reset_exception = 0, machine_check_exception = 0, feature_call = 0,
  pci_get_legacy_ide_irq = 0, phys_mem_access_prot = 0, idle_loop = 0,
  power_save = 0, enable_pmcs = 0, set_dabr = 0, init = 0, kgdb_map_scc = 0,
  pcibios_after_init = 0, pci_exclude_device = 0, pcibios_fixup_resources = 0,
  pcibios_fixup_bus = 0, pcibios_enable_device_hook = 0, machine_shutdown = 0}
(gdb) step
536		     machine_id < &__machine_desc_end;
(gdb) print machine_id
$3 = (struct machdep_calls *) 0x0
(gdb) step
525	{
(gdb) step
535		for (machine_id = &__machine_desc_start;
(gdb) step
525	{
(gdb) step
536		     machine_id < &__machine_desc_end;
(gdb) step
535		for (machine_id = &__machine_desc_start;
(gdb) step
525	{
(gdb) step
535		for (machine_id = &__machine_desc_start;
(gdb) list
530		 * Iterate all ppc_md structures until we find the proper
531		 * one for the current machine type
532		 */
533		DBG("Probing machine type ...\n");
534	
535		for (machine_id = &__machine_desc_start;
536		     machine_id < &__machine_desc_end;
537		     machine_id++) {
538			DBG("  %s ...", machine_id->name);
539			memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
(gdb) list
540			if (ppc_md.probe()) {
541				DBG(" match !\n");
542				break;
543			}
544			DBG("\n");
545		}
546		/* What can we do if we didn't find ? */
547		if (machine_id >= &__machine_desc_end) {
548			DBG("No suitable machine found !\n");
549			for (;;);
(gdb) b 540
Breakpoint 1 at 0xc000cdb8: file arch/powerpc/kernel/setup-common.c, line 540.
(gdb) cont
Continuing.
^C
Program received signal SIGSTOP, Stopped (signal).
udelay (usecs=<value optimized out>) at arch/powerpc/kernel/time.c:414
414				HMT_low();
(gdb)

Finally I decided to set the breakpoint at start_kernel(). This time
where the kernel stuck was different from the previous two debugging
trials. The kernel was stuck before it reached the start_kernel(). And
I believe this udbg_put_cpm() was called when the kernel tried to
print "id mach(): done" inside machine_init().

 145        if (ppc_md.progress)
 146                ppc_md.progress("id mach(): done", 0x200);

The debug session is shown below. I also dump the cpm_udbg_txdesc from
BDI, which showed that the bit0 was always 1.

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
0xc0012df8 in udbg_putc_cpm (c=105 'i')
    at /home/rayan/wti/code/wti-linux-2.6.33.5/arch/powerpc/include/asm/io.h:155
155	DEF_MMIO_IN_BE(in_be32, 32, lwz);
(gdb) next
48		while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
(gdb) next
48		while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
(gdb) next
48		while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
(gdb) b 51
Breakpoint 1 at 0xc0012e2c: file arch/powerpc/sysdev/cpm_common.c, line 51.
(gdb) cont
Continuing.
^C
Program received signal SIGSTOP, Stopped (signal).
udbg_putc_cpm (c=105 'i') at arch/powerpc/sysdev/cpm_common.c:48
48		while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
(gdb) frame
#0  udbg_putc_cpm (c=105 'i') at arch/powerpc/sysdev/cpm_common.c:48
48		while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
(gdb)

BDI>md 0xfa202000 4
fa202000 : 0xffffffff  -         1  ....
fa202004 : 0xffffffff  -         1  ....
fa202008 : 0xffffffff  -         1  ....
fa20200c : 0xffffffff  -         1  ....

Thanks a lot,
-Shawn.
