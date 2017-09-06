Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnL1B5ftWzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 20:49:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Julia.Lawall@lip6.fr, aik@ozlabs.ru, alistair@popple.id.au,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, anton@samba.org, arvind.yadav.cs@gmail.com,
 benh@kernel.crashing.org, bhumirks@gmail.com, bryantly@linux.vnet.ibm.com,
 bsingharora@gmail.com, christophe.leroy@c-s.fr, clabbe.montjoie@gmail.com,
 clg@kaod.org, dan.carpenter@oracle.com, davem@davemloft.net,
 douly.fnst@cn.fujitsu.com, ego@linux.vnet.ibm.com,
 elfring@users.sourceforge.net, fbarrat@linux.vnet.ibm.com,
 geliangtang@gmail.com, geoff@infradead.org, hare@suse.de,
 haren@linux.vnet.ibm.com, ivan@de.ibm.com, jallen@linux.vnet.ibm.com,
 julia.lawall@lip6.fr, laurentiu.tudor@nxp.com, leitao@debian.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, matthew.brown.dev@gmail.com, me@tobin.cc,
 mikey@neuling.org, mopsfelder@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, npiggin@gmail.com, oohall@gmail.com,
 oss@buserror.net, paulus@ozlabs.org, rashmica.g@gmail.com,
 robh@kernel.org, rui.teng@linux.vnet.ibm.com, ruscur@russell.cc,
 sam.bobroff@au1.ibm.com, santosh@fossix.org, schwab@linux-m68k.org,
 shilpa.bhat@linux.vnet.ibm.com, sjitindarsingh@gmail.com,
 srikar@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 victora@linux.vnet.ibm.com, yamada.masahiro@socionext.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.14-1 tag
Date: Wed, 06 Sep 2017 20:48:55 +1000
Message-ID: <87fuc0p0fc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.14.

Slightly late pull request due to me travelling and only having spotty
3G 'net access. Hopefully everything is in order. No merge conflicts or
anything that I'm aware of. The "since commit" below is a bit confused
because I merged my fixes branch, the actual base of next was 4.13-rc2.

cheers

The following changes since commit 1a92a80ad386a1a6e3b36d576d52a1a456394b70:

  powerpc/mm: Ensure cpumask update is ordered (2017-08-18 13:07:16 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.14-1

for you to fetch changes up to 265601f034df3566f22da11240977aab8860f6a7:

  powerpc/xive: Fix section __init warning (2017-09-04 19:38:07 +1000)

=2D---------------------------------------------------------------
powerpc updates for 4.14

Nothing really major this release, despite quite a lot of activity. Just lo=
ts of
things all over the place.

Some things of note include:

 - Access via perf to a new type of PMU (IMC) on Power9, which can count bo=
th
   core events as well as nest unit events (Memory controller etc).

 - Optimisations to the radix MMU TLB flushing, mostly to avoid unnecessary=
 Page
   Walk Cache (PWC) flushes when the structure of the tree is not changing.

 - Reworks/cleanups of do_page_fault() to modernise it and bring it closer =
to
   other architectures where possible.

 - Rework of our page table walking so that THP updates only need to send I=
PIs
   to CPUs where the affected mm has run, rather than all CPUs.

 - The size of our vmalloc area is increased to 56T on 64-bit hash MMU syst=
ems.
   This avoids problems with the percpu allocator on systems with very spar=
se
   NUMA layouts.

 - STRICT_KERNEL_RWX support on PPC32.

 - A new sched domain topology for Power9, to capture the fact that pairs of
   cores may share an L2 cache.

 - Power9 support for VAS, which is a new mechanism for accessing coprocess=
ors,
   and initial support for using it with the NX compression accelerator.

 - Major work on the instruction emulation support, adding support for many=
 new
   instructions, and reworking it so it can be used to implement the emulat=
ion
   needed to fixup alignment faults.

 - Support for guests under PowerVM to use the Power9 XIVE interrupt contro=
ller.

And probably that many things again that are almost as interesting, but I h=
ad to
keep the list short. Plus the usual fixes and cleanups as always.

Thanks to:
  Alexey Kardashevskiy, Alistair Popple, Andreas Schwab, Aneesh Kumar K.V, =
Anju
  T Sudhakar, Arvind Yadav, Balbir Singh, Benjamin Herrenschmidt, Bhumika G=
oyal,
  Breno Leitao, Bryant G. Ly, Christophe Leroy, C=C3=A9dric Le Goater, Dan =
Carpenter,
  Dou Liyang, Frederic Barrat, Gautham R. Shenoy, Geliang Tang, Geoff Levan=
d,
  Hannes Reinecke, Haren Myneni, Ivan Mikhaylov, John Allen, Julia Lawall, =
LABBE
  Corentin, Laurentiu Tudor, Madhavan Srinivasan, Markus Elfring, Masahiro
  Yamada, Matt Brown, Michael Neuling, Murilo Opsfelder Araujo, Nathan Font=
enot,
  Naveen N. Rao, Nicholas Piggin, Oliver O'Halloran, Paul Mackerras, Rashmi=
ca
  Gupta, Rob Herring, Rui Teng, Sam Bobroff, Santosh Sivaraj, Scott Wood,
  Shilpasri G Bhat, Sukadev Bhattiprolu, Suraj Jitindar Singh, Tobin C. Har=
ding,
  Victor Aoqui.

=2D---------------------------------------------------------------
Alexey Kardashevskiy (6):
      powerpc/pci: Remove unused parameter from add_one_dev_pci_data()
      powerpc/eeh: Reduce to one the number of places where edev is allocat=
ed
      powerpc/eeh: Remove unnecessary pointer to phb from eeh_dev
      powerpc/eeh: Remove unnecessary config_addr from eeh_dev
      powerpc/eeh: Reduce use of pci_dn::node
      powerpc/pci: Remove OF node back pointer from pci_dn

Alistair Popple (1):
      powerpc/powernv/npu: Move tlb flush before launching ATSD

Andreas Schwab (2):
      powerpc: Fix invalid use of register expressions
      powerpc/l2cr_6xx: Fix invalid use of register expressions

Aneesh Kumar K.V (8):
      powerpc/mm: Build fix for non SPARSEMEM_VMEMAP config
      mm/hugetlb: Allow arch to override and call the weak function
      powerpc/mm/hugetlb: Add support for reserving gigantic huge pages via=
 kernel command line
      powerpc/mm/hugetlb: Allow runtime allocation of 16G.
      powerpc/mm: Rename find_linux_pte_or_hugepte()
      powerpc/mm: Don't send IPI to all cpus on THP updates
      powerpc/mm/cxl: Add the fault handling cpu to mm cpumask
      powerpc/mm/cxl: Add barrier when setting mm cpumask

Anju T (1):
      powerpc/perf/imc: Fix nest events on muti socket system

Anju T Sudhakar (3):
      powerpc/perf: Add nest IMC PMU support
      powerpc/perf: Add core IMC PMU support
      powerpc/perf: Add thread IMC PMU support

Arvind Yadav (3):
      macintosh/rack-meter: Make of_device_ids const
      powerpc/512x: Constify clk_div_tables
      powerpc/4xx: Constify cpm_suspend_ops

Balbir Singh (6):
      powerpc/xmon: Fix display of SPRs
      powerpc/xmon: Dump all 64 bits of HDEC
      powerpc/xmon: Add AMR, UAMOR, AMOR, IAMR to SPR dump
      powerpc/xmon: Add ISA v3.0 SPRs to SPR dump
      powerpc/configs: Enable function trace by default
      powerpc/configs: Enable THP and 64K for ppc64(le)_defconfig

Benjamin Herrenschmidt (37):
      powerpc/mm/radix: Improve _tlbiel_pid to be usable for PWC flushes
      powerpc/mm/radix: Improve TLB/PWC flushes
      powerpc/mm/radix: Avoid flushing the PWC on every flush_tlb_range
      powerpc/mm: Move exception_enter/exit to a do_page_fault wrapper
      powerpc/mm: Pre-filter SRR1 bits before do_page_fault()
      powerpc/6xx: Handle DABR match before calling do_page_fault
      powerpc/mm: Update definitions of DSISR bits
      powerpc/mm: Update bits used to skip hash_page
      powerpc/mm: Use symbolic constants for filtering SRR1 bits on ISIs
      powerpc/mm: Move out definition of CPU specific is_write bits
      powerpc/mm: Move error_code checks for bad faults earlier
      powerpc/mm: Overhaul handling of bad page faults
      powerpc/mm: Move debugger check to notify_page_fault()
      powerpc/mm: Simplify returns from __do_page_fault
      powerpc/mm: Fix reporting of kernel execute faults
      powerpc/mm: Make bad_area* helper functions
      powerpc/mm: Rework mm_fault_error()
      powerpc/mm: Move CMO accounting out of do_page_fault into a helper
      powerpc/mm: Cosmetic fix to page fault accounting
      powerpc/mm: Move the DSISR_PROTFAULT sanity check
      powerpc/mm: Move/simplify faulthandler_disabled() and !mm check
      powerpc/mm: Add a bunch of (un)likely annotations to do_page_fault
      powerpc/mm: Set fault flags earlier
      powerpc/mm: Move page fault VMA access checks to a helper
      powerpc/mm: Don't lose "major" fault indication on retry
      powerpc/mm: Cleanup check for stack expansion
      powerpc: Remove old unused icswx based coprocessor support
      powerpc/xive: Ensure active irqd when setting affinity
      powerpc: Fix missing newline before {
      powerpc: Remove redundant FP/Altivec giveup code
      powerpc: Remove redundant clear of MSR_VSX in __giveup_vsx()
      powerpc: Remove more redundant VSX save/tests
      powerpc/mm: Move pgdir setting into a helper
      powerpc/mm: Avoid double irq save/restore in activate_mm
      powerpc/mm: Use mm_is_thread_local() instread of open-coding
      powerpc/mm: Optimize detection of thread local mm's
      powerpc/mm: Make switch_mm_irqs_off() out of line

Bhumika Goyal (2):
      drivers/macintosh: Make wf_control_ops and wf_pid_param const
      powerpc: Add const to bin_attribute structures

Breno Leitao (2):
      powerpc/xmon: Dump ftrace buffers for the current CPU only
      powerpc/xmon: Disable tracing when entering xmon

Bryant G. Ly (1):
      powerpc/kernel: Change retrieval of pci_dn

Christophe Leroy (31):
      powerpc/32: Fix boot failure on non 6xx platforms
      powerpc/8xx: Simplify CONFIG_8xx checks in Makefile
      powerpc/8xx: Move 8xx machine check handlers into platforms/8xx
      powerpc/8xx: Remove SoftwareEmulation()
      powerpc/cpm1: link to CONFIG_CPM1 instead of CONFIG_8xx
      powerpc/8xx: Move mpc8xx_pic.c from sysdev to platform/8xx
      powerpc/time: refactor MFTB() to limit number of ifdefs
      powerpc/kconfig: Simplify PCI_QSPAN selection
      powerpc/8xx: Getting rid of remaining use of CONFIG_8xx
      powerpc/8xx: remove CONFIG_8xx
      powerpc/8xx: Use symbolic PVR value
      powerpc/8xx: Use symbolic names for DSISR bits in DSI
      powerpc/8xx: Remove cpu dependent macro instructions from head_8xx
      powerpc/8xx: Fix two CONFIG_8xx left behind
      powerpc/8xx: Ensures RAM mapped with LTLB is seen as block mapped on =
8xx.
      powerpc/8xx: Remove macro that checks kernel address
      powerpc/32: Avoid risk of unrecoverable TLBmiss inside entry_32.S
      powerpc/8xx: Make pinning of ITLBs optional
      powerpc/8xx: Do not allow Pinned TLBs with STRICT_KERNEL_RWX or DEBUG=
_PAGEALLOC
      powerpc/8xx: mark init functions with __init
      powerpc/8xx: Reduce DTLB miss handler by one insn
      powerpc/mm: Ensure change_page_attr() doesn't invalidate pinned TLBs
      powerpc/mm: Fix kernel RAM protection after freeing unused memory on =
PPC32
      powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32
      powerpc/mm: declare some local functions static
      powerpc/mm: Simplify __set_fixmap()
      powerpc/hugetlb: fix page rights verification in gup_hugepte()
      powerpc/32: add memset16()
      powerpc: fix location of two EXPORT_SYMBOL
      powerpc/32: optimise memset()
      powerpc/32: remove a NOP from memset()

C=C3=A9dric Le Goater (10):
      powerpc/xive: Fix the size of the cpumask used in xive_find_target_in=
_mask()
      powerpc/xive: introduce a common routine xive_queue_page_alloc()
      powerpc/xive: guest exploitation of the XIVE interrupt controller
      powerpc/xive: rename xive_poke_esb() in xive_esb_read()
      powerpc/xive: introduce xive_esb_write()
      powerpc/xive: add the HW IRQ number under xive_irq_data
      powerpc/xive: introduce H_INT_ESB hcall
      powerpc/xive: add XIVE Exploitation Mode to CAS
      powerpc/xive: improve debugging macros
      powerpc/xive: Fix section __init warning

Dan Carpenter (3):
      powerpc/perf: Fix double unlock in imc_common_cpuhp_mem_free()
      powerpc/83xx: Use sizeof correct type when ioremapping
      powerpc/44x: Fix mask and shift to zero bug

Dou Liyang (1):
      powerpc/topology: Remove the unused parent_node() macro

Frederic Barrat (2):
      powerpc/powernv: Enable PCI peer-to-peer
      cxl: Fix driver use count

Gautham R. Shenoy (2):
      powerpc/powernv: Save/Restore additional SPRs for stop4 cpuidle
      powerpc/powernv: Clear PECE1 in LPCR via stop-api only on Hotplug

Geliang Tang (2):
      powerpc/pseries: use memdup_user_nul
      powerpc/powernv: use memdup_user

Geoff Levand (1):
      block/ps3vram: Check return of ps3vram_cache_init

Hannes Reinecke (1):
      powerpc: conditionally compile platform-specific serial drivers

Haren Myneni (7):
      crypto/nx: Rename nx842_powernv_function as icswx function
      crypto/nx: Create nx842_configure_crb function
      crypto/nx: Create nx842_delete_coprocs function
      crypto/nx: Add nx842_add_coprocs_list function
      crypto/nx: Use kzalloc for workmem allocation
      crypto/nx: Add P9 NX specific error codes for 842 engine
      crypto/nx: Add P9 NX support for 842 compression engine

Ivan Mikhaylov (1):
      powerpc/44x/fsp2: Enable eMMC arasan for fsp2 platform

John Allen (1):
      powerpc/pseries: Don't attempt to acquire drc during memory hot add f=
or assigned lmbs

Julia Lawall (3):
      powerpc/chrp: Store the intended structure
      powerpc/iommu: Use permission-specific DEVICE_ATTR variants
      powerpc/macintosh: constify wf_sensor_ops structures

LABBE Corentin (1):
      powerpc/powernv: Fix build error in opal-imc.c when NUMA=3Dn

Laurentiu Tudor (1):
      powerpc: allow compiling with GENERIC_MSI_IRQ_DOMAIN

Madhavan Srinivasan (7):
      powerpc/powernv: Add IMC OPAL APIs
      powerpc/powernv: Detect and create IMC device
      powerpc/perf: Update default sdar_mode value for power9
      powerpc/perf: Factor out PPMU_ONLY_COUNT_RUN check code from power8
      powerpc/perf: Add PM_LD_MISS_L1 and PM_BR_2PATH to power9 event list
      powerpc/perf: Cleanup of PM_BR_CMPL vs. PM_BRU_CMPL in Power9 event l=
ist
      powerpc/perf: Fix usage of nest_imc_refc

Markus Elfring (6):
      block/ps3vram: Delete an error message for a failed memory allocation=
 in ps3vram_cache_init()
      powerpc/mm: Use seq_putc() in two functions
      powerpc/eeh: Delete an error out of memory message at init time
      axonram: Delete an error message for a failed memory allocation in ax=
on_ram_probe()
      axonram: Improve a size determination in axon_ram_probe()
      axonram: Return directly after a failed kzalloc() in axon_ram_probe()

Masahiro Yamada (1):
      powerpc: Squash lines for simple wrapper functions

Matt Brown (6):
      powerpc/powernv: Use darn instruction for get_random_seed() on Power9
      powerpc/lib/sstep: Add cmpb instruction emulation
      powerpc/lib/sstep: Add popcnt instruction emulation
      powerpc/lib/sstep: Add bpermd instruction emulation
      powerpc/lib/sstep: Add prty instruction emulation
      powerpc/lib/sstep: Add isel instruction emulation

Michael Ellerman (78):
      powerpc/pseries: Don't needlessly initialise rv to 0
      powerpc/configs: Add a powernv_be_defconfig
      powerpc/udbg: Reduce the footgun potential of EARLY_DEBUG_LPAR(_HVSI)
      powerpc/mm/book3s64: Make KERN_IO_START a variable
      powerpc/mm/slb: Move comment next to the code it's referring to
      powerpc/mm/hash64: Make vmalloc 56T on hash
      powerpc/47x: Guard 47x cputable entries with CONFIG_PPC_47x
      powerpc/44x: Simplify CONFIG_44x checks in Makefile
      powerpc/44x: Move 44x machine check handlers into platforms/44x
      powerpc/4xx: Create 4xx pseudo-platform in platforms/4xx
      powerpc/4xx: Move machine_check_4xx() into platforms/4xx
      powerpc/traps: Inline get_mc_reason()
      powerpc/traps: machine_check_generic() is only used on 32-bit
      powerpc/mce: Move 64-bit machine check code into mce.c
      powerpc/traps: Use SRR1 defines for program check reasons
      powerpc/mm: Fix section mismatch warning in early_check_vec5()
      powerpc/xive: Fix section mismatch warnings
      powerpc/mm/nohash: Move definition of PGALLOC_GFP to fix build errors
      powerpc/iommu: Avoid undefined right shift in iommu_range_alloc()
      Merge branch 'topic/ppc-kvm' into next
      Merge branch 'fixes' into next
      powerpc/vio: Use device_type to detect family
      powerpc/64s: Fix replay interrupt return label name
      powerpc/oops: Fix the oops markers to use pr_cont()
      powerpc/oops: Print the kernel's endian in the oops
      powerpc/oops: Use IS_ENABLED() for oops markers
      powerpc/oops: Print CR/XER on same line as MSR
      powerpc/oops: Line up NIP & MSR with other rows
      powerpc/configs: Update for symbol movement only
      powerpc/configs: Drop unneeded CONFIG_CRYPTO_ANSI_CPRNG
      powerpc/configs: Explicitly drop CONFIG_INPUT_MOUSEDEV
      powerpc/configs: Drop no longer needed CONFIG_FHANDLE
      powerpc/configs: Drop no longer needed CONFIG_DEVKMEM
      powerpc/configs: Update for CONFIG_DEBUG_FS being selected via CONFIG=
_RCU_TRACE
      powerpc/configs: Update for CONFIG_FIXED_PHY being selected by CONFIG=
_OF_MDIO
      powerpc/configs: Update for CONFIG_NF_CT_PROTO_(SCTP|UDPLITE)=3Dy
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_DEV_VMX_ENCRYPT
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_HMAC
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_ECB
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_SHA256
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_NULL
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_NULL in g5 / c2k
      powerpc/configs: Drop no longer needed CONFIG_CRYPTO_GCM
      powerpc/configs: Drop no longer needed CONFIG_DEVPTS_MULTIPLE_INSTANC=
ES
      powerpc/configs: Drop unnecessary CONFIG_NUMA_BALANCING_DEFAULT_ENABL=
ED
      powerpc/configs: Drop unnecessary CONFIG_UPROBE_EVENT
      powerpc/configs: Drop no longer needed CONFIG_SMP for pseries/ppc64/p=
owernv
      powerpc/configs: Drop no longer needed PCI_MSI on powernv
      powerpc/configs: Drop unnecessary CONFIG_POWERNV_OP_PANEL
      powerpc/configs: Drop MEMORY_HOTREMOVE from ppc64/cell
      powerpc/configs: Drop CONFIG_SERIAL_TXX9_* from cell/ppc64
      powerpc/configs: Drop no longer needed CONFIG_AUDITSYSCALL
      powerpc/configs: Add CONFIG_RAS now required for CONFIG_EDAC
      powerpc/configs: Drop no longer needed CONFIG_IPV6
      powerpc/configs: Drop no longer needed CONFIG_SCSI
      powerpc/configs: Drop unnecessary CONFIG_EDAC from ppc64e
      powerpc/configs: Drop no longer needed CONFIG_LIBCRC32C
      powerpc/configs: Turn CONFIG_R128 back in pmac32_defconfig
      powerpc/configs: Drop removed CONFIG_LOGFS
      powerpc/configs: Update for CONFIG_INPUT_MOUSEDEV=3Dn
      powerpc/configs/mpc5200: Drop no longer needed CONFIG_FB
      powerpc/configs/6xx: Turn CONFIG_DRM_RADEON back on
      powerpc/configs/6xx: Drop no longer needed CONFIG_TIMER_STATS
      powerpc/configs/6xx: Clean up duplicate CONFIG_EXT4 values
      powerpc/configs/6xx: Drop removed CONFIG_BLK_DEV_HD
      powerpc/configs/6xx: Drop no longer needed CONFIG_NF_CONNTRACK_PROC_C=
OMPAT
      powerpc/configs/6xx: Reinstate CONFIG_CPU_FREQ_STAT
      powerpc/configs/6xx: Drop no longer needed CONFIG_NETFILTER_XT_MATCH_=
SOCKET
      powerpc/configs/6xx: Drop no longer needed CONFIG_BT_HCIUART_H4
      powerpc/configs/6xx: Switch CONFIG_USB_EHCI_FSL to =3Dm
      powerpc/configs/c2k: Switch CONFIG_GEN_RTC from =3Dm to =3Dy
      powerpc/configs/6xx: Drop no longer selectable CONFIG_BT_HCIUART_LL
      powerpc/configs/6xx: Drop removed CONFIG_USB_LED
      Merge branch 'topic/ppc-kvm' into next
      powerpc/mm/radix: Add pr_fmt() to pgtable-radix.c
      powerpc/mm/radix: Prettify mapped memory range print out
      powerpc: Fix DAR reporting when alignment handler faults
      powerpc/sstep: Avoid used uninitialized error

Michael Neuling (1):
      selftests/powerpc: Force ptrace tests to build -fno-pie

Murilo Opsfelder Araujo (1):
      MAINTAINERS: Add drivers/watchdog/wdrtas.c to powerpc section

Nathan Fontenot (1):
      powerpc/pseries: Check memory device state before onlining/offlining

Naveen N. Rao (5):
      powerpc/xmon: Exclude all of xmon from ftrace
      powerpc/string: Implement optimized memset variants
      powerpc/bpf: Use memset32() to pre-fill traps in BPF page(s)
      powerpc/kprobes: Don't save/restore DAR/DSISR to/from pt_regs for opt=
probes
      powerpc/uprobes: Implement arch_uretprobe_is_alive()

Nicholas Piggin (29):
      powerpc/64s: Fix mce accounting for powernv
      powerpc: Fix powerpc-specific watchdog build configuration
      powerpc: Add irq accounting for system reset interrupts
      powerpc: Add irq accounting for watchdog interrupts
      powerpc/pseries: Don't print failure message in energy driver
      powerpc/64s: Avoid a branch in masked_[H]interrupt()
      powerpc/64s: Optimise clearing of MSR_EE in masked_[H]interrupt()
      powerpc/64s: masked_interrupt() returns to kernel so avoid restoring =
r13
      powerpc/64: Cleanup __check_irq_replay()
      powerpc/64s: Merge HV and non-HV paths for doorbell IRQ replay
      powerpc/64s: Use the HV handler for external IRQ replay in HV mode on=
 POWER9
      powerpc/64: Remove redundant instruction in interrupt replay
      powerpc/64s: Remove spurious IRQ reason in IRQ replay
      powerpc/64: Optimise set/clear of CTRL[RUN] (runlatch)
      KVM: PPC: Book3S HV: POWER9 does not require secondary thread managem=
ent
      powerpc/64s: Move IDLE_STATE_ENTER_SEQ[_NORET] into idle_book3s.S
      powerpc/64s: POWER9 can execute stop without a sync sequence
      powerpc/64s: Drop no longer used IDLE_STATE_ENTER_SEQ
      powerpc/64s: idle POWER9 can execute stop in virtual mode
      powerpc/powernv: powernv platform is not constrained by RMA
      powerpc/64s/radix: Remove bolted-SLB address limit for per-cpu stacks
      powerpc/64s/radix: Do not allocate SLB shadow structures
      powerpc/64: Fix watchdog configuration regressions
      powerpc: Do not call ppc_md.panic in fadump panic notifier
      powerpc/pseries/le: Work around a firmware quirk
      powerpc: Do not send system reset request through the oops path
      powerpc/powernv: Flush console before platform error reboot
      powerpc/powernv: Use kernel crash path for machine checks
      powerpc: Machine check interrupt is a non-maskable interrupt

Oliver O'Halloran (4):
      powerpc/smp: Use cpu_to_chip_id() to find core siblings
      powerpc/smp: Rework CPU topology construction
      powerpc/smp: Add cpu_l2_cache_map
      powerpc/smp: Add Power9 scheduler topology

Paul Mackerras (20):
      powerpc: Correct instruction code for xxlor instruction
      powerpc: Change analyse_instr so it doesn't modify *regs
      powerpc: Don't check MSR FP/VMX/VSX enable bits in analyse_instr()
      powerpc: Handle most loads and stores in instruction emulation code
      powerpc/64: Fix update forms of loads and stores to write 64-bit EA
      powerpc: Fix emulation of the isel instruction
      powerpc: Don't update CR0 in emulation of popcnt, prty, bpermd instru=
ctions
      powerpc: Add emulation for the addpcis instruction
      powerpc: Make load/store emulation use larger memory accesses
      powerpc: Emulate FP/vector/VSX loads/stores correctly when regs not l=
ive
      powerpc: Emulate vector element load/store instructions
      powerpc: Emulate load/store floating double pair instructions
      powerpc: Emulate the dcbz instruction
      powerpc: Set regs->dar if memory access fails in emulate_step()
      powerpc: Handle opposite-endian processes in emulation code
      powerpc: Separate out load/store emulation into its own function
      powerpc: Use instruction emulation infrastructure to handle alignment=
 faults
      powerpc: Emulate load/store floating point as integer word instructio=
ns
      powerpc: Wrap register number correctly for string load/store instruc=
tions
      powerpc: Fix kernel crash in emulation of vector loads and stores

Rashmica Gupta (2):
      powerpc/powernv: Enable removal of memory for in memory tracing
      Add documentation for the powerpc memtrace debugfs files

Rob Herring (4):
      powerpc: Convert to using %pOF instead of full_name
      powerpc: pseries: remove dlpar_attach_node dependency on full path
      ide: pmac: Convert to using %pOF instead of full_name
      macintosh: Convert to using %pOF instead of full_name

Rui Teng (1):
      powerpc/mm: Fix check of multiple 16G pages from device tree

Sam Bobroff (1):
      selftests/powerpc: Improve tm-resched-dscr

Santosh Sivaraj (1):
      powerpc/powernv: Get cpu only after validity check

Scott Wood (1):
      powerpc/ipic: Support edge on IRQ0

Shilpasri G Bhat (3):
      powerpc/powernv: Add support for powercap framework
      powerpc/powernv: Add support to set power-shifting-ratio
      powerpc/powernv: Add support to clear sensor groups data

Sukadev Bhattiprolu (10):
      powerpc/powernv/vas: Define macros, register fields and structures
      powerpc/powernv: Move GET_FIELD/SET_FIELD to vas.h
      powerpc/powernv/vas: Define vas_init() and vas_exit()
      powerpc/powernv/vas: Define helpers to access MMIO regions
      powerpc/powernv/vas: Define helpers to init window context
      powerpc/powernv/vas: Define helpers to alloc/free windows
      powerpc/powernv/vas: Define vas_rx_win_open() interface
      powerpc/powernv/vas: Define vas_win_close() interface
      powerpc/powernv/vas: Define vas_tx_win_open()
      powerpc/powernv/vas: Define copy/paste interfaces

Suraj Jitindar Singh (1):
      powerpc/mm: Properly invalidate when setting process table base

Tobin C. Harding (1):
      powerpc/asm: Convert .llong directives to .8byte

Victor Aoqui (1):
      powerpc/kernel: Avoid preemption check in iommu_range_alloc()

 Documentation/ABI/testing/ppc-memtrace             |   45 +
 .../ABI/testing/sysfs-firmware-opal-powercap       |   31 +
 Documentation/ABI/testing/sysfs-firmware-opal-psr  |   18 +
 .../devicetree/bindings/powerpc/ibm,vas.txt        |   22 +
 .../bindings/powerpc/opal/sensor-groups.txt        |   27 +
 MAINTAINERS                                        |   10 +
 arch/powerpc/Kconfig                               |   38 +-
 arch/powerpc/Makefile                              |    6 +-
 arch/powerpc/boot/4xx.c                            |    2 +-
 arch/powerpc/boot/Makefile                         |   11 +-
 arch/powerpc/boot/crt0.S                           |   20 +-
 arch/powerpc/boot/dts/fsp2.dts                     |   33 +-
 arch/powerpc/boot/ppc_asm.h                        |    8 +
 arch/powerpc/boot/serial.c                         |    4 +
 arch/powerpc/boot/util.S                           |   24 +-
 arch/powerpc/configs/40x/acadia_defconfig          |    1 -
 arch/powerpc/configs/40x/ep405_defconfig           |    1 -
 arch/powerpc/configs/40x/kilauea_defconfig         |    1 -
 arch/powerpc/configs/40x/klondike_defconfig        |    1 -
 arch/powerpc/configs/40x/makalu_defconfig          |    1 -
 arch/powerpc/configs/40x/obs600_defconfig          |    1 -
 arch/powerpc/configs/40x/virtex_defconfig          |    3 +-
 arch/powerpc/configs/40x/walnut_defconfig          |    1 -
 arch/powerpc/configs/44x/akebono_defconfig         |    2 -
 arch/powerpc/configs/44x/bamboo_defconfig          |    1 -
 arch/powerpc/configs/44x/currituck_defconfig       |    2 -
 arch/powerpc/configs/44x/ebony_defconfig           |    1 -
 arch/powerpc/configs/44x/eiger_defconfig           |    4 -
 arch/powerpc/configs/44x/fsp2_defconfig            |    3 +-
 arch/powerpc/configs/44x/icon_defconfig            |    3 -
 arch/powerpc/configs/44x/iss476-smp_defconfig      |    2 -
 arch/powerpc/configs/44x/katmai_defconfig          |    1 -
 arch/powerpc/configs/44x/rainier_defconfig         |    1 -
 arch/powerpc/configs/44x/redwood_defconfig         |    4 -
 arch/powerpc/configs/44x/sequoia_defconfig         |    1 -
 arch/powerpc/configs/44x/taishan_defconfig         |    1 -
 arch/powerpc/configs/44x/virtex5_defconfig         |    3 +-
 arch/powerpc/configs/44x/warp_defconfig            |    1 -
 arch/powerpc/configs/52xx/cm5200_defconfig         |    1 -
 arch/powerpc/configs/52xx/lite5200b_defconfig      |    3 +-
 arch/powerpc/configs/52xx/motionpro_defconfig      |   15 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig        |    2 -
 arch/powerpc/configs/83xx/asp8347_defconfig        |    2 -
 arch/powerpc/configs/83xx/kmeter1_defconfig        |    1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |    3 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |    2 -
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig    |    4 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig    |    6 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |    2 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig  |    1 -
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig    |    2 -
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig    |    4 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig    |    5 +-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig    |    4 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig    |    5 +-
 arch/powerpc/configs/83xx/sbc834x_defconfig        |    4 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |    3 +-
 arch/powerpc/configs/85xx/ksi8560_defconfig        |    4 +-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig    |    4 +-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig    |    6 +-
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig    |    4 +-
 arch/powerpc/configs/85xx/sbc8548_defconfig        |    4 +-
 arch/powerpc/configs/85xx/socrates_defconfig       |    3 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig        |    3 -
 arch/powerpc/configs/85xx/tqm8540_defconfig        |    4 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig        |    4 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig        |    2 -
 arch/powerpc/configs/85xx/tqm8555_defconfig        |    4 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig        |    4 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    5 +-
 arch/powerpc/configs/adder875_defconfig            |    2 +-
 arch/powerpc/configs/amigaone_defconfig            |    2 -
 arch/powerpc/configs/be.config                     |    1 +
 arch/powerpc/configs/c2k_defconfig                 |    5 +-
 arch/powerpc/configs/cell_defconfig                |    9 +-
 arch/powerpc/configs/chrp32_defconfig              |    3 +-
 arch/powerpc/configs/ep8248e_defconfig             |    1 -
 arch/powerpc/configs/ep88xc_defconfig              |    2 +-
 arch/powerpc/configs/g5_defconfig                  |   11 +-
 arch/powerpc/configs/gamecube_defconfig            |    2 -
 arch/powerpc/configs/holly_defconfig               |    3 +-
 arch/powerpc/configs/linkstation_defconfig         |    3 -
 arch/powerpc/configs/maple_defconfig               |    9 +-
 arch/powerpc/configs/mgcoge_defconfig              |    2 -
 arch/powerpc/configs/mpc512x_defconfig             |   28 +-
 arch/powerpc/configs/mpc5200_defconfig             |    4 -
 arch/powerpc/configs/mpc7448_hpc2_defconfig        |    4 +-
 arch/powerpc/configs/mpc8272_ads_defconfig         |    1 -
 arch/powerpc/configs/mpc83xx_defconfig             |   10 +-
 arch/powerpc/configs/mpc866_ads_defconfig          |    4 +-
 arch/powerpc/configs/mpc86xx_basic_defconfig       |   12 +-
 arch/powerpc/configs/mpc885_ads_defconfig          |    2 +-
 arch/powerpc/configs/mvme5100_defconfig            |    3 -
 arch/powerpc/configs/pasemi_defconfig              |    5 +-
 arch/powerpc/configs/pmac32_defconfig              |   11 +-
 arch/powerpc/configs/powernv_defconfig             |   18 +-
 arch/powerpc/configs/ppc40x_defconfig              |    3 +-
 arch/powerpc/configs/ppc44x_defconfig              |    4 +-
 arch/powerpc/configs/ppc64_defconfig               |   38 +-
 arch/powerpc/configs/ppc64e_defconfig              |   10 +-
 arch/powerpc/configs/ppc6xx_defconfig              |   46 +-
 arch/powerpc/configs/pq2fads_defconfig             |    1 -
 arch/powerpc/configs/ps3_defconfig                 |    3 -
 arch/powerpc/configs/pseries_defconfig             |   42 +-
 arch/powerpc/configs/tqm8xx_defconfig              |    3 +-
 arch/powerpc/configs/wii_defconfig                 |    5 -
 arch/powerpc/include/asm/Kbuild                    |    1 +
 arch/powerpc/include/asm/asm-compat.h              |    2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |    4 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |    6 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h       |    4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |    2 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |    8 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |    2 -
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    9 +-
 arch/powerpc/include/asm/book3s/64/radix.h         |    2 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |    5 +-
 arch/powerpc/include/asm/bug.h                     |    1 +
 arch/powerpc/include/asm/cache.h                   |    2 +-
 arch/powerpc/include/asm/cpuidle.h                 |   27 +-
 arch/powerpc/include/asm/cputable.h                |    4 +-
 arch/powerpc/include/asm/eeh.h                     |    5 +-
 arch/powerpc/include/asm/fadump.h                  |    2 +
 arch/powerpc/include/asm/feature-fixups.h          |    6 +-
 arch/powerpc/include/asm/fixmap.h                  |   10 +-
 arch/powerpc/include/asm/fs_pd.h                   |    2 +-
 arch/powerpc/include/asm/hardirq.h                 |    4 +
 arch/powerpc/include/asm/hugetlb.h                 |   14 -
 arch/powerpc/include/asm/hvcall.h                  |   13 +-
 arch/powerpc/include/asm/icswx.h                   |    3 +
 arch/powerpc/include/asm/imc-pmu.h                 |  128 ++
 arch/powerpc/include/asm/kvm_book3s_asm.h          |    4 +
 arch/powerpc/include/asm/machdep.h                 |    1 -
 arch/powerpc/include/asm/mmu_context.h             |   76 +-
 arch/powerpc/include/asm/nmi.h                     |    3 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |    5 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |    1 +
 arch/powerpc/include/asm/opal-api.h                |   24 +-
 arch/powerpc/include/asm/opal.h                    |   19 +-
 arch/powerpc/include/asm/paca.h                    |    7 +
 arch/powerpc/include/asm/pci-bridge.h              |    1 -
 arch/powerpc/include/asm/pgalloc.h                 |    2 +
 arch/powerpc/include/asm/pgtable.h                 |   12 +-
 arch/powerpc/include/asm/pnv-pci.h                 |    2 +
 arch/powerpc/include/asm/ppc-opcode.h              |   16 +-
 arch/powerpc/include/asm/ppc_asm.h                 |   16 +-
 arch/powerpc/include/asm/prom.h                    |    5 +-
 arch/powerpc/include/asm/pte-walk.h                |   35 +
 arch/powerpc/include/asm/reg.h                     |   99 +-
 arch/powerpc/include/asm/reg_booke.h               |    3 -
 arch/powerpc/include/asm/setup.h                   |    1 -
 arch/powerpc/include/asm/smp.h                     |    6 +
 arch/powerpc/include/asm/sstep.h                   |   95 +-
 arch/powerpc/include/asm/string.h                  |   26 +
 arch/powerpc/include/asm/timex.h                   |    6 +-
 arch/powerpc/include/asm/tlb.h                     |   11 +-
 arch/powerpc/include/asm/topology.h                |    2 -
 arch/powerpc/include/asm/vas.h                     |  159 ++
 arch/powerpc/include/asm/xive.h                    |    5 +
 arch/powerpc/kernel/Makefile                       |    4 +-
 arch/powerpc/kernel/align.c                        |  774 +------
 arch/powerpc/kernel/asm-offsets.c                  |    8 +
 arch/powerpc/kernel/btext.c                        |    2 +-
 arch/powerpc/kernel/cacheinfo.c                    |   34 +-
 arch/powerpc/kernel/cputable.c                     |    8 +-
 arch/powerpc/kernel/eeh.c                          |   20 +-
 arch/powerpc/kernel/eeh_dev.c                      |    7 +-
 arch/powerpc/kernel/eeh_driver.c                   |    2 +-
 arch/powerpc/kernel/eeh_pe.c                       |   90 +-
 arch/powerpc/kernel/eeh_sysfs.c                    |    3 -
 arch/powerpc/kernel/entry_32.S                     |   22 +
 arch/powerpc/kernel/entry_64.S                     |    9 +-
 arch/powerpc/kernel/exceptions-64s.S               |   37 +-
 arch/powerpc/kernel/fadump.c                       |   31 +-
 arch/powerpc/kernel/head_32.S                      |    6 +-
 arch/powerpc/kernel/head_64.S                      |    8 +-
 arch/powerpc/kernel/head_8xx.S                     |  109 +-
 arch/powerpc/kernel/idle_book3s.S                  |  130 +-
 arch/powerpc/kernel/io-workarounds.c               |    9 +-
 arch/powerpc/kernel/iommu.c                        |    7 +-
 arch/powerpc/kernel/irq.c                          |   65 +-
 arch/powerpc/kernel/isa-bridge.c                   |   32 +-
 arch/powerpc/kernel/kgdb.c                         |    4 +-
 arch/powerpc/kernel/kvm.c                          |    7 -
 arch/powerpc/kernel/l2cr_6xx.S                     |    4 +-
 arch/powerpc/kernel/legacy_serial.c                |   12 +-
 arch/powerpc/kernel/mce.c                          |   33 +
 arch/powerpc/kernel/of_platform.c                  |    2 +-
 arch/powerpc/kernel/optprobes_head.S               |    8 -
 arch/powerpc/kernel/paca.c                         |   13 +-
 arch/powerpc/kernel/pci-common.c                   |   15 +-
 arch/powerpc/kernel/pci_32.c                       |    4 +-
 arch/powerpc/kernel/pci_64.c                       |    4 +-
 arch/powerpc/kernel/pci_dn.c                       |   22 +-
 arch/powerpc/kernel/pci_of_scan.c                  |   24 +-
 arch/powerpc/kernel/process.c                      |   95 +-
 arch/powerpc/kernel/prom_init.c                    |   34 +-
 arch/powerpc/kernel/ptrace.c                       |   42 +-
 arch/powerpc/kernel/reloc_64.S                     |    6 +-
 arch/powerpc/kernel/rtas_pci.c                     |   33 +-
 arch/powerpc/kernel/setup-common.c                 |   36 +-
 arch/powerpc/kernel/setup_32.c                     |    7 +-
 arch/powerpc/kernel/setup_64.c                     |   39 +-
 arch/powerpc/kernel/smp.c                          |  228 +-
 arch/powerpc/kernel/swsusp_asm64.S                 |    2 +-
 arch/powerpc/kernel/systbl.S                       |   14 +-
 arch/powerpc/kernel/traps.c                        |  305 +--
 arch/powerpc/kernel/uprobes.c                      |    9 +
 arch/powerpc/kernel/vdso32/gettimeofday.S          |   12 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |    2 +-
 arch/powerpc/kernel/watchdog.c                     |    3 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    5 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |   32 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |   12 +-
 arch/powerpc/kvm/book3s_hv.c                       |   13 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   18 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |    8 +
 arch/powerpc/kvm/e500_mmu_host.c                   |    3 +-
 arch/powerpc/lib/Makefile                          |    3 +-
 arch/powerpc/lib/copy_32.S                         |   44 +-
 arch/powerpc/lib/copypage_power7.S                 |   14 +-
 arch/powerpc/lib/copyuser_power7.S                 |   66 +-
 arch/powerpc/lib/ldstfp.S                          |  299 +--
 arch/powerpc/lib/mem_64.S                          |   19 +-
 arch/powerpc/lib/memcpy_power7.S                   |   66 +-
 arch/powerpc/lib/quad.S                            |   62 +
 arch/powerpc/lib/sstep.c                           | 2232 ++++++++++++++--=
----
 arch/powerpc/lib/string_64.S                       |    2 +-
 arch/powerpc/mm/8xx_mmu.c                          |   29 +-
 arch/powerpc/mm/Makefile                           |    4 +-
 arch/powerpc/mm/dump_hashpagetable.c               |    2 +-
 arch/powerpc/mm/dump_linuxpagetables.c             |    2 +-
 arch/powerpc/mm/fault.c                            |  562 ++---
 arch/powerpc/mm/hash_low_32.S                      |    2 +-
 arch/powerpc/mm/hash_utils_64.c                    |   16 +-
 arch/powerpc/mm/hugetlbpage.c                      |  219 +-
 arch/powerpc/mm/icswx.c                            |  292 ---
 arch/powerpc/mm/icswx.h                            |   68 -
 arch/powerpc/mm/icswx_pid.c                        |   87 -
 arch/powerpc/mm/init_32.c                          |    8 +-
 arch/powerpc/mm/init_64.c                          |    6 +-
 arch/powerpc/mm/mem.c                              |    2 +-
 arch/powerpc/mm/mmu_context.c                      |   99 +
 arch/powerpc/mm/mmu_context_book3s64.c             |   20 +-
 arch/powerpc/mm/mmu_decl.h                         |   10 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |   24 +-
 arch/powerpc/mm/pgtable-hash64.c                   |   12 +-
 arch/powerpc/mm/pgtable-radix.c                    |   33 +-
 arch/powerpc/mm/pgtable_32.c                       |   66 +-
 arch/powerpc/mm/pgtable_64.c                       |    2 +
 arch/powerpc/mm/slb_low.S                          |   23 +-
 arch/powerpc/mm/tlb-radix.c                        |  108 +-
 arch/powerpc/mm/tlb_hash64.c                       |   13 +-
 arch/powerpc/mm/tlb_nohash_low.S                   |    2 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |    6 +-
 arch/powerpc/perf/Makefile                         |    1 +
 arch/powerpc/perf/callchain.c                      |    3 +-
 arch/powerpc/perf/imc-pmu.c                        | 1306 ++++++++++++
 arch/powerpc/perf/isa207-common.c                  |   31 +-
 arch/powerpc/perf/isa207-common.h                  |    5 +-
 arch/powerpc/perf/power8-pmu.c                     |   33 +-
 arch/powerpc/perf/power9-events-list.h             |    9 +-
 arch/powerpc/perf/power9-pmu.c                     |   23 +-
 arch/powerpc/platforms/44x/Makefile                |    4 +-
 arch/powerpc/platforms/44x/machine_check.c         |   89 +
 arch/powerpc/platforms/4xx/Makefile                |    8 +
 .../{sysdev/ppc4xx_cpm.c =3D> platforms/4xx/cpm.c}   |   10 +-
 .../{sysdev/ppc4xx_gpio.c =3D> platforms/4xx/gpio.c} |    3 +-
 .../ppc4xx_hsta_msi.c =3D> platforms/4xx/hsta_msi.c} |    0
 arch/powerpc/platforms/4xx/machine_check.c         |   26 +
 .../{sysdev/ppc4xx_msi.c =3D> platforms/4xx/msi.c}   |    3 +-
 .../{sysdev/ppc4xx_ocm.c =3D> platforms/4xx/ocm.c}   |    0
 .../{sysdev/ppc4xx_pci.c =3D> platforms/4xx/pci.c}   |  118 +-
 .../{sysdev/ppc4xx_pci.h =3D> platforms/4xx/pci.h}   |    0
 .../{sysdev/ppc4xx_soc.c =3D> platforms/4xx/soc.c}   |    5 +-
 arch/powerpc/{sysdev =3D> platforms/4xx}/uic.c       |   14 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |    4 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   12 +-
 arch/powerpc/platforms/52xx/efika.c                |    8 +-
 arch/powerpc/platforms/52xx/media5200.c            |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |    4 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |    8 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |    3 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |    2 +-
 arch/powerpc/platforms/83xx/suspend.c              |    4 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    8 +-
 arch/powerpc/platforms/85xx/xes_mpc85xx.c          |    4 +-
 arch/powerpc/platforms/8xx/Kconfig                 |    3 +-
 arch/powerpc/platforms/8xx/Makefile                |    2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |    2 +-
 arch/powerpc/platforms/8xx/machine_check.c         |   37 +
 .../{sysdev/mpc8xx_pic.c =3D> platforms/8xx/pic.c}   |    2 +-
 .../{sysdev/mpc8xx_pic.h =3D> platforms/8xx/pic.h}   |    0
 arch/powerpc/platforms/Kconfig.cputype             |   45 +-
 arch/powerpc/platforms/Makefile                    |    1 +
 arch/powerpc/platforms/amigaone/setup.c            |    6 +-
 arch/powerpc/platforms/cell/axon_msi.c             |   36 +-
 arch/powerpc/platforms/cell/interrupt.c            |    4 +-
 arch/powerpc/platforms/cell/iommu.c                |   24 +-
 arch/powerpc/platforms/cell/ras.c                  |    4 +-
 arch/powerpc/platforms/cell/spider-pci.c           |    4 +-
 arch/powerpc/platforms/cell/spider-pic.c           |    4 +-
 arch/powerpc/platforms/cell/spu_manage.c           |   26 +-
 arch/powerpc/platforms/chrp/pci.c                  |   18 +-
 arch/powerpc/platforms/chrp/pegasos_eth.c          |    2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c   |    6 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c      |    2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c    |    2 +-
 arch/powerpc/platforms/maple/pci.c                 |   10 +-
 arch/powerpc/platforms/pasemi/pci.c                |    2 +-
 arch/powerpc/platforms/powermac/feature.c          |   14 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |   50 +-
 arch/powerpc/platforms/powermac/pci.c              |    6 +-
 arch/powerpc/platforms/powermac/pfunc_base.c       |   24 +-
 arch/powerpc/platforms/powermac/pfunc_core.c       |    6 +-
 arch/powerpc/platforms/powermac/pic.c              |    8 +-
 arch/powerpc/platforms/powermac/setup.c            |    2 +-
 arch/powerpc/platforms/powernv/Kconfig             |   22 +
 arch/powerpc/platforms/powernv/Makefile            |    5 +-
 arch/powerpc/platforms/powernv/copy-paste.h        |   46 +
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   29 +-
 arch/powerpc/platforms/powernv/idle.c              |   34 +-
 arch/powerpc/platforms/powernv/memtrace.c          |  282 +++
 arch/powerpc/platforms/powernv/npu-dma.c           |   12 +-
 arch/powerpc/platforms/powernv/opal-async.c        |    4 +-
 arch/powerpc/platforms/powernv/opal-flash.c        |    2 +-
 arch/powerpc/platforms/powernv/opal-hmi.c          |   22 +-
 arch/powerpc/platforms/powernv/opal-imc.c          |  226 ++
 arch/powerpc/platforms/powernv/opal-powercap.c     |  244 +++
 arch/powerpc/platforms/powernv/opal-prd.c          |   13 +-
 arch/powerpc/platforms/powernv/opal-psr.c          |  175 ++
 .../powerpc/platforms/powernv/opal-sensor-groups.c |  212 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   11 +-
 arch/powerpc/platforms/powernv/opal-xscom.c        |    8 +-
 arch/powerpc/platforms/powernv/opal.c              |  152 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   18 +-
 arch/powerpc/platforms/powernv/pci.c               |   75 +
 arch/powerpc/platforms/powernv/pci.h               |    5 +
 arch/powerpc/platforms/powernv/powernv.h           |    2 +
 arch/powerpc/platforms/powernv/rng.c               |   45 +-
 arch/powerpc/platforms/powernv/smp.c               |   11 +-
 arch/powerpc/platforms/powernv/vas-window.c        | 1134 ++++++++++
 arch/powerpc/platforms/powernv/vas.c               |  151 ++
 arch/powerpc/platforms/powernv/vas.h               |  467 ++++
 arch/powerpc/platforms/ps3/repository.c            |   22 +-
 arch/powerpc/platforms/ps3/setup.c                 |   15 -
 arch/powerpc/platforms/pseries/Kconfig             |    1 +
 arch/powerpc/platforms/pseries/dlpar.c             |    9 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c       |    4 +-
 arch/powerpc/platforms/pseries/event_sources.c     |    6 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   17 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   57 +-
 arch/powerpc/platforms/pseries/hvCall.S            |    2 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |    5 +-
 arch/powerpc/platforms/pseries/iommu.c             |   58 +-
 arch/powerpc/platforms/pseries/kexec.c             |    6 +-
 arch/powerpc/platforms/pseries/mobility.c          |    2 +-
 arch/powerpc/platforms/pseries/msi.c               |   23 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c         |    2 +-
 arch/powerpc/platforms/pseries/pseries.h           |    2 +-
 arch/powerpc/platforms/pseries/pseries_energy.c    |    7 +-
 arch/powerpc/platforms/pseries/ras.c               |   15 +
 arch/powerpc/platforms/pseries/reconfig.c          |   15 +-
 arch/powerpc/platforms/pseries/setup.c             |    9 +-
 arch/powerpc/platforms/pseries/smp.c               |   27 +-
 arch/powerpc/platforms/pseries/vio.c               |   10 +-
 arch/powerpc/purgatory/trampoline.S                |    6 +-
 arch/powerpc/sysdev/Makefile                       |   12 +-
 arch/powerpc/sysdev/axonram.c                      |   46 +-
 arch/powerpc/sysdev/dcr.c                          |    4 +-
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c          |   12 +-
 arch/powerpc/sysdev/fsl_gtm.c                      |   14 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   16 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   47 +-
 arch/powerpc/sysdev/fsl_rio.c                      |   36 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   12 +-
 arch/powerpc/sysdev/fsl_soc.c                      |    2 +-
 arch/powerpc/sysdev/fsl_soc.h                      |    2 +-
 arch/powerpc/sysdev/ipic.c                         |    1 +
 arch/powerpc/sysdev/mpic.c                         |    4 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |    2 +-
 arch/powerpc/sysdev/mpic_msi.c                     |    2 +-
 arch/powerpc/sysdev/mpic_timer.c                   |   19 +-
 arch/powerpc/sysdev/msi_bitmap.c                   |    4 +-
 arch/powerpc/sysdev/mv64x60_dev.c                  |   20 +-
 arch/powerpc/sysdev/mv64x60_pci.c                  |    6 +-
 arch/powerpc/sysdev/of_rtc.c                       |   12 +-
 arch/powerpc/sysdev/scom.c                         |    5 +-
 arch/powerpc/sysdev/simple_gpio.c                  |    3 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |    4 +-
 arch/powerpc/sysdev/xive/Kconfig                   |    5 +
 arch/powerpc/sysdev/xive/Makefile                  |    1 +
 arch/powerpc/sysdev/xive/common.c                  |   90 +-
 arch/powerpc/sysdev/xive/native.c                  |   22 +-
 arch/powerpc/sysdev/xive/spapr.c                   |  662 ++++++
 arch/powerpc/sysdev/xive/xive-internal.h           |    7 +
 arch/powerpc/xmon/Makefile                         |    4 +
 arch/powerpc/xmon/xmon.c                           |   86 +-
 drivers/block/ps3vram.c                            |   10 +-
 drivers/crypto/nx/Kconfig                          |    1 +
 drivers/crypto/nx/nx-842-powernv.c                 |  514 ++++-
 drivers/crypto/nx/nx-842.c                         |    2 +-
 drivers/crypto/nx/nx-842.h                         |   13 +-
 drivers/ide/pmac.c                                 |   18 +-
 drivers/macintosh/macio_sysfs.c                    |    2 +-
 drivers/macintosh/rack-meter.c                     |   14 +-
 drivers/macintosh/smu.c                            |    8 +-
 drivers/macintosh/via-cuda.c                       |    4 +-
 drivers/macintosh/windfarm_cpufreq_clamp.c         |    2 +-
 drivers/macintosh/windfarm_fcu_controls.c          |    4 +-
 drivers/macintosh/windfarm_lm75_sensor.c           |    2 +-
 drivers/macintosh/windfarm_lm87_sensor.c           |    6 +-
 drivers/macintosh/windfarm_max6690_sensor.c        |    2 +-
 drivers/macintosh/windfarm_rm31.c                  |    4 +-
 drivers/macintosh/windfarm_smu_controls.c          |    2 +-
 drivers/macintosh/windfarm_smu_sat.c               |    4 +-
 drivers/macintosh/windfarm_smu_sensors.c           |   10 +-
 drivers/misc/cxl/api.c                             |    4 +
 drivers/misc/cxl/fault.c                           |   16 +
 drivers/misc/cxl/file.c                            |    8 +-
 drivers/tty/hvc/hvc_vio.c                          |   12 +
 include/linux/cpuhotplug.h                         |    3 +
 include/linux/hugetlb.h                            |    1 +
 mm/hugetlb.c                                       |    4 +-
 tools/testing/selftests/powerpc/ptrace/Makefile    |    2 +-
 .../powerpc/switch_endian/switch_endian_test.S     |    2 +-
 tools/testing/selftests/powerpc/tm/Makefile        |    1 +
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |   12 +-
 428 files changed, 11415 insertions(+), 4993 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZr9KYAAoJEFHr6jzI4aWAh6YP/j6TDDDrdJWAEYv02S+1Qx5T
rBPL+POZoFq2vGzBB2l1u2ttB5SBUb7q2iM5JMKmdadUJD60XMtdSi+YtRHmvERC
qB6t2pfok0EkLNU9N6XlywP3Rqk3f+oZNxwJ9D2i4j+y6VhTRYFXPlIu0OFKEo8x
HVd49ElBZq1NkauTLmOTXVxnfik2uMZm6kW8sIP7ZhDF3TIwb0hjFgcO/jaNpGB9
WfsEZnUg2uIDBWBjEcEbkZhibo/JwNLueOLNrRDKbY8AmHkOFvowY5p6aEWSs2sS
MHKZAerCbNBOPJN+qR0GJs+NpsGmPUd6AoPFDnaTW2DwlStTpT8/iXYver09VHJt
XqG+b4R4itZQ/qOr0e/UntXjUPz3FAoSDe0xPIrXi6DX7JSsovwUoGNWjqXC8H2F
j8Gjr6B0eL+jtlyUWfiPDafl3w7DPJbFuG4IHRLo3Fo3TV6POFWyZ0+fXKskWD8w
frrLoEjsN8MPt5/Gaz/NbA8WlUs5p/0VLb0JOLSBFWNC+IzEm4wh2Lm2PFeLELQy
GqB6E214N31o9+sr8NIWVM3UAwHnNF/BV1+Dk0dcWF/EJxVVGcID8rTx4NdcZB5j
ZlgEjQTDGn4ApgwGoSUWcWXStAt1sIkoRS1rmyyF8o6JPRImaakx5h5Ozxom9dar
/tM56dHuhluCX9Xu4f1I
=/xh8
-----END PGP SIGNATURE-----
--=-=-=--
