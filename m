Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411kdm3JhtzF34R
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 22:01:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, akshay.adiga@linux.vnet.ibm.com, alastair@d-silva.org,
 andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, anton@samba.org,
 arnd@arndb.de, bauerman@linux.ibm.com, bsingharora@gmail.com,
 christophe.leroy@c-s.fr, clg@kaod.org, colin.king@canonical.com,
 dale@farnsworth.org, duwe@lst.de, ego@linux.vnet.ibm.com,
 fabio.estevam@nxp.com, fbarrat@linux.vnet.ibm.com,
 fthain@telegraphics.com.au, haren@us.ibm.com, hbathini@linux.vnet.ibm.com,
 j.neuschaefer@gmx.net, jpoimboe@redhat.com, jrdr.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux@roeck-us.net,
 linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
 maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, malat@debian.org,
 mgreer@animalcreek.com, mikey@neuling.org, msuchanek@suse.de,
 naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com, olof@lixom.net,
 paul.gortmaker@windriver.com, paulus@ozlabs.org, peda@axentia.se,
 ravi.bangoria@linux.ibm.com, rdunlap@infradead.org, remi@machet.us,
 rostedt@goodmis.org, ruscur@russell.cc, sbobroff@linux.ibm.com,
 shilpa.bhat@linux.vnet.ibm.com, stewart@linux.ibm.com,
 vaibhav@linux.ibm.com, vaibhav@linux.vnet.ibm.com,
 viro@zeniv.linux.org.uk, wei.guo.simon@gmail.com, weiyongjun1@huawei.com,
 wsa+renesas@sang-engineering.com, xieyisheng1@huawei.com,
 yuehaibing@huawei.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.18-1 tag
Date: Thu, 07 Jun 2018 22:00:48 +1000
Message-ID: <877enabybz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc updates for 4.18:

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.18-1

for you to fetch changes up to ff5bc793e47b537bf3e904fada585e102c54dd8b:

  powerpc/64s/radix: Fix missing ptesync in flush_cache_vmap (2018-06-06 18=
:50:53 +1000)

- ------------------------------------------------------------------
powerpc updates for 4.18

Notable changes:

 - Support for split PMD page table lock on 64-bit Book3S (Power8/9).

 - Add support for HAVE_RELIABLE_STACKTRACE, so we properly support live
   patching again.

 - Add support for patching barrier_nospec in copy_from_user() and syscall =
entry.

 - A couple of fixes for our data breakpoints on Book3S.

 - A series from Nick optimising TLB/mm handling with the Radix MMU.

 - Numerous small cleanups to squash sparse/gcc warnings from Mathieu Malat=
erre.

 - Several series optimising various parts of the 32-bit code from Christop=
he Leroy.

 - Removal of support for two old machines, "SBC834xE" and "C2K" ("GEFanuc,=
C2K"),
   which is why the diffstat has so many deletions.

And many other small improvements & fixes.

There's a few out-of-area changes. Some minor ftrace changes OK'ed by Steve=
, and
a fix to our powernv cpuidle driver. Then there's a series touching mm, x86=
 and
fs/proc/task_mmu.c, which cleans up some details around pkey support. It was
ack'ed/reviewed by Ingo & Dave and has been in next for several weeks.

Thanks to:
  Akshay Adiga, Alastair D'Silva, Alexey Kardashevskiy, Al Viro, Andrew
  Donnellan, Aneesh Kumar K.V, Anju T Sudhakar, Arnd Bergmann, Balbir Singh,
  C=C3=A9dric Le Goater, Christophe Leroy, Christophe Lombard, Colin Ian Ki=
ng, Dave
  Hansen, Fabio Estevam, Finn Thain, Frederic Barrat, Gautham R. Shenoy, Ha=
ren
  Myneni, Hari Bathini, Ingo Molnar, Jonathan Neusch=C3=A4fer, Josh Poimboe=
uf,
  Kamalesh Babulal, Madhavan Srinivasan, Mahesh Salgaonkar, Mark Greer, Mat=
hieu
  Malaterre, Matthew Wilcox, Michael Neuling, Michal Suchanek, Naveen N. Ra=
o,
  Nicholas Piggin, Nicolai Stange, Olof Johansson, Paul Gortmaker, Paul
  Mackerras, Peter Rosin, Pridhiviraj Paidipeddi, Ram Pai, Rashmica Gupta, =
Ravi
  Bangoria, Russell Currey, Sam Bobroff, Samuel Mendoza-Jonas, Segher
  Boessenkool, Shilpasri G Bhat, Simon Guo, Souptick Joarder, Stewart Smith,
  Thiago Jung Bauermann, Torsten Duwe, Vaibhav Jain, Wei Yongjun, Wolfram S=
ang,
  Yisheng Xie, YueHaibing.

- ------------------------------------------------------------------
Akshay Adiga (1):
      powerpc/powernv/cpuidle: Init all present cpus for deep states

Al Viro (6):
      powerpc/syscalls: Switch trivial cases to SYSCALL_DEFINE
      powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE
      powerpc/syscalls: switch rtas(2) to SYSCALL_DEFINE
      powerpc/syscalls: kill ppc32_select()
      powerpc/syscalls: timer_create can be handle by perfectly normal COMP=
AT_SYS_SPU
      powerpc/ptrace: Use copy_{from, to}_user() rather than open-coding

Alastair D'Silva (7):
      powerpc: Add TIDR CPU feature for POWER9
      powerpc: Use TIDR CPU feature to control TIDR allocation
      powerpc: use task_pid_nr() for TID allocation
      ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
      ocxl: Expose the thread_id needed for wait on POWER9
      ocxl: Add an IOCTL so userspace knows what OCXL features are available
      ocxl: Document new OCXL IOCTLs

Alexey Kardashevskiy (2):
      powerpc/ioda: Use ibm, supported-tce-sizes for IOMMU page size mask
      powerpc/powernv/ioda2: Remove redundant free of TCE pages

Aneesh Kumar K.V (20):
      powerpc/kvm: Switch kvm pmd allocator to custom allocator
      powerpc/mm/book3s64: Move book3s64 code to pgtable-book3s64
      powerpc/mm: Use pmd_lockptr instead of opencoding it
      powerpc/mm: Rename pte fragment functions
      powerpc/mm/book3e/64: Remove unsupported 64Kpage size from 64bit booke
      powerpc/mm/nohash: Remove pte fragment dependency from nohash
      powerpc/mm/book3s64/4k: Switch 4k pagesize config to use pagetable fr=
agment
      powerpc/book3s64/mm: Simplify the rcu callback for page table free
      powerpc/mm: Implement helpers for pagetable fragment support at PMD l=
evel
      powerpc/mm: Use page fragments for allocation page table at PMD level
      powerpc/book3s64: Enable split pmd ptlock.
      powerpc/livepatch: Fix build error with kprobes disabled.
      powerpc/mm: Fix kernel crash on page table free
      powerpc/mm/hugetlb: Update huge_ptep_set_access_flags to call __ptep_=
set_access_flags directly
      powerpc/mm/radix: Move function from radix.h to pgtable-radix.c
      powerpc/mm: Change function prototype
      powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang
      powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch
      powerpc/mm/hugetlb: Update hugetlb related locks
      powerpc/mm/hash: hard disable irq in the SLB insert path

Anju T Sudhakar (5):
      powerpc/perf: Fix memory allocation for core-imc based on num_possibl=
e_cpus()
      powerpc/perf: Rearrange memory freeing in imc init
      powerpc/perf: Replace the direct return with goto statement
      powerpc/perf: Return appropriate value for unknown domain
      powerpc/perf: Unregister thread-imc if core-imc not supported

Arnd Bergmann (5):
      powerpc: always enable RTC_LIB
      powerpc: rtas: clean up time handling
      powerpc: use time64_t in read_persistent_clock
      powerpc: use time64_t in update_persistent_clock
      powerpc: remove unused to_tm() helper

Balbir Singh (1):
      Revert "powerpc/powernv: Increase memory block size to 1GB on radix"

Christophe Leroy (30):
      powerpc/nohash: Remove hash related code from nohash headers.
      powerpc/nohash: Remove _PAGE_BUSY
      powerpc/nohash: Use IS_ENABLED() to simplify __set_pte_at()
      powerpc: get rid of PMD_PAGE_SIZE() and _PMD_SIZE
      Revert "powerpc/64: Fix checksum folding in csum_add()"
      powerpc: Avoid an unnecessary test and branch in longjmp()
      powerpc/32: Use stmw/lmw for registers save/restore in asm
      powerpc/mm: Use instruction symbolic names in store_updates_sp()
      powerpc/mm: Only read faulting instruction when necessary in do_page_=
fault()
      powerpc/8xx: fix invalid register expression in head_8xx.S
      powerpc/64: Fix strncpy() related build failures with GCC 8.1
      powerpc: Fix build by disabling attribute-alias warning for SYSCALL_D=
EFINEx
      powerpc/dma: remove unnecessary BUG()
      powerpc/mm: constify FIRST_CONTEXT in mmu_context_nohash
      powerpc/mm: Avoid unnecessary test and reduce code size
      powerpc/mm: constify LAST_CONTEXT in mmu_context_nohash
      powerpc/mm: Remove stale_map[] handling on non SMP processors
      powerpc/64: optimises from64to32()
      powerpc/misc: merge reloc_offset() and add_reloc_offset()
      powerpc/boot: remove unused variable in mpc8xx
      powerpc/8xx: Remove RTC clock on 88x
      powerpc/signal32: Use fault_in_pages_readable() to prefault user cont=
ext
      powerpc/lib: Adjust .balign inside string functions for PPC32
      powerpc/32: Optimise __csum_partial()
      powerpc: Implement csum_ipv6_magic in assembly
      powerpc/Makefile: set -mcpu=3D860 flag for the 8xx
      powerpc/time: inline arch_vtime_task_switch()
      powerpc/lib: optimise 32 bits __clear_user()
      powerpc/lib: optimise PPC32 memcmp
      powerpc: fix build failure by disabling attribute-alias warning in pc=
i_32

Colin Ian King (4):
      macintosh/windfarm: fix spelling mistake: "ttarged" -> "ttarget"
      powerpc/rtas: Fix spelling mistake "Discharching" -> "Discharging"
      powerpc: fix spelling mistake: "Usupported" -> "Unsupported"
      powerpc-opal: fix spelling mistake "Uniterrupted" -> "Uninterrupted"

C=C3=A9dric Le Goater (4):
      powerpc/64/kexec: fix race in kexec when XIVE is shutdown
      powerpc/xive: fix hcall H_INT_RESET to support long busy delays
      powerpc/xive: shutdown XIVE when kexec or kdump is performed
      powerpc/xive: prepare all hcalls to support long busy delays

Fabio Estevam (1):
      powerpc: cpm_gpio: Remove owner assignment from platform_driver

Finn Thain (1):
      powerpc/lib: Fix "integer constant is too large" build failure

Gautham R. Shenoy (1):
      cpuidle: powernv: Fix promotion from snooze if next state disabled

Haren Myneni (1):
      powerpc/powernv: copy/paste - Mask SO bit in CR

Hari Bathini (1):
      powerpc/fadump: Do not use hugepages when fadump is active

Jonathan Neusch=C3=A4fer (6):
      powerpc: wii_defconfig: Disable Ethernet driver support code
      powerpc: wii_defconfig: Enable GPIO-related options
      powerpc: wii_defconfig: Enable Wii SDHCI driver
      powerpc: wii_defconfig: Disable BCMA support
      powerpc/embedded6xx/flipper-pic: Don't match all IRQ domains
      powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled b=
y Starlet

Josh Poimboeuf (1):
      powerpc/modules: remove unused mod_arch_specific.toc field

Madhavan Srinivasan (1):
      powerpc/perf: Update raw-event code encoding comment for power8

Mahesh Salgaonkar (2):
      powerpc/fadump: exclude memory holes while reserving memory in second=
 kernel
      powerpc/fadump: Unregister fadump on kexec down path.

Mark Greer (5):
      powerpc/embedded6xx: Remove C2K board support
      powerpc/boot: Remove support for Marvell MPSC serial controller
      powerpc/boot: Remove support for Marvell mv64x60 i2c controller
      powerpc/boot: Remove core support for Marvell mv64x60 hostbridges
      powerpc: Remove core support for Marvell mv64x60 hostbridges

Mathieu Malaterre (21):
      powerpc/kvm: Prefer fault_in_pages_readable function
      powerpc/xmon: Add __printf annotation to xmon_printf()
      powerpc: Add __printf verification to prom_printf
      powerpc/altivec: Add missing prototypes for altivec
      powerpc/sparse: Fix plain integer as NULL pointer warning
      powerpc/mm/radix: Use do/while(0) trick for single statement block
      powerpc/wii: Make hlwd_pic_init function static
      powerpc/chrp/setup: Remove idu_size variable and make some functions =
static
      powerpc/powermac: Mark variable x as unused
      powerpc/chrp/pci: Make some functions static
      powerpc/powermac: Move pmac_pfunc_base_install prototype to header fi=
le
      powerpc/powermac: Add missing prototype for note_bootable_part()
      powerpc/52xx: Add missing functions prototypes
      powerpc: Add missing prototype
      powerpc/tau: Synchronize function prototypes and body
      powerpc: Make function btext_initialize static
      powerpc/tau: Make some function static
      powerpc/chrp/time: Make some functions static, add missing header inc=
lude
      powerpc/32: Add a missing include header
      powerpc: Add a missing include header
      powerpc/prom: Fix %u/%llx usage since prom_printf() change

Michael Ellerman (36):
      powerpc: Only support DYNAMIC_FTRACE not static
      tracing: Remove PPC32 wart from config TRACING_SUPPORT
      mm/pkeys: Remove include of asm/mmu_context.h from pkeys.h
      mm/pkeys, powerpc, x86: Provide an empty vma_pkey() in linux/pkeys.h
      x86/pkeys: Move vma_pkey() into asm/pkeys.h
      x86/pkeys: Add arch_pkeys_enabled()
      mm/pkeys: Add an empty arch_pkeys_enabled()
      powerpc/pkeys: Drop private VM_PKEY definitions
      powerpc/pseries: hcall_exit tracepoint retval should be signed
      powerpc/syscalls: Add COMPAT_SPU_NEW() macro
      powerpc: Make it clearer that systbl check errors are errors
      powerpc/lib: Fix feature fixup test of external branch
      powerpc/lib: Fix the feature fixup tests to actually work
      powerpc/lib: Rename ftr_fixup_test7 to ftr_fixup_test_too_big
      powerpc/lib: Add alt patching test of branching past the last instruc=
tion
      powerpc/prom: Drop support for old FDT versions
      powerpc/powernv: Fix memtrace build when NUMA=3Dn
      Merge branch 'topic/ppc-kvm' into next
      powerpc/io: Add __raw_writeq_be() __raw_rm_writeq_be()
      powerpc/powernv: Use __raw_[rm_]writeq_be() in pci-ioda.c
      powerpc/powernv: Use __raw_[rm_]writeq_be() in npu-dma.c
      powerpc/xmon: Specify the full format in DUMP() macro
      powerpc/xmon: Realign paca dump fields
      powerpc/xmon: Update paca fields dumped in xmon
      Merge branch 'topic/ppc-kvm' into next
      Merge branch 'topic/kbuild' into next
      Merge branch 'fixes' into next
      Merge branch 'topic/pkey' into next
      powerpc: Rename thread_struct.fs to addr_limit
      powerpc: Check address limit on user-mode return (TIF_FSCHECK)
      powerpc/64: Save stack pointer when we hard disable interrupts
      powerpc/nmi: Add an API for sending "safe" NMIs
      powerpc/64s: Wire up arch_trigger_cpumask_backtrace()
      powerpc/stacktrace: Update copyright
      powerpc: Use barrier_nospec in copy_from_user()
      powerpc/64: Use barrier_nospec in syscall entry

Michael Neuling (6):
      powerpc/ptrace: Fix enforcement of DAWR constraints
      powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_=
DEBUGREG
      selftests/powerpc: Remove redundant cp_abort test
      selftests/powerpc: Add missing .gitignores
      selftests/powerpc: Add ptrace hw breakpoint test
      selftests/powerpc: Add perf breakpoint test

Michal Suchanek (6):
      powerpc/xmon: Also setup debugger hooks when single-stepping
      powerpc/64s: Add barrier_nospec
      powerpc/64s: Add support for ori barrier_nospec patching
      powerpc/64s: Patch barrier_nospec in modules
      powerpc/64s: Enable barrier_nospec based on firmware settings
      powerpc/64s: Enhance the information in cpu_show_spectre_v1()

Naveen N. Rao (10):
      powerpc64/ftrace: Add a field in paca to disable ftrace in unsafe cod=
e paths
      powerpc64/ftrace: Rearrange #ifdef sections in ftrace.h
      powerpc64/ftrace: Add helpers to hard disable ftrace
      powerpc64/ftrace: Delay enabling ftrace on secondary cpus
      powerpc64/ftrace: Disable ftrace during hotplug
      powerpc64/ftrace: Disable ftrace during kvm entry/exit
      powerpc64/kexec: Hard disable ftrace before switching to the new kern=
el
      powerpc64/module: Tighten detection of mcount call sites with -mprofi=
le-kernel
      powerpc64/ftrace: Use the generic version of ftrace_replace_code()
      powerpc64/ftrace: Implement support for ftrace_regs_caller()

Nicholas Piggin (32):
      powerpc/config: powernv_defconfig updates
      powerpc/watchdog: don't update the watchdog timestamp if a lockup is =
detected
      powerpc/watchdog: provide more data in watchdog messages
      selftests/powerpc: fix exec benchmark
      powerpc/mm/radix: implement LPID based TLB flushes to be used by KVM
      powerpc/powernv: Fix opal_event_shutdown() called with interrupts dis=
abled
      powerpc/kbuild: Set default generic machine type for 32-bit compile
      powerpc/kbuild: Remove CROSS32 defines from top level powerpc Makefile
      powerpc/kbuild: Use flags variables rather than overriding LD/CC/AS
      powerpc/64: irq_work avoid interrupt when called with hardware irqs e=
nabled
      powerpc/pseries: put cede MSR[EE] check under IRQ_SOFT_MASK_DEBUG
      powerpc/64s: micro-optimise __hard_irq_enable() for mtmsrd L=3D1 supp=
ort
      powerpc/64: remove start_tb and accum_tb from thread_struct
      powerpc/pseries: lparcfg calculate PURR on demand
      powerpc: generic clockevents broadcast receiver call tick_receive_bro=
adcast
      powerpc: allow soft-NMI watchdog to cover timer interrupts with large=
 decrementers
      powerpc: move timer broadcast code under GENERIC_CLOCKEVENTS_BROADCAS=
T ifdef
      powerpc: move a stray NMI IPI case under NMI_IPI ifdef
      powerpc/time: account broadcast timer event interrupts separately
      powerpc/pmu/fsl: fix is_nmi test for irq mask change
      powerpc/64: change softe to irqmask in show_regs and xmon
      powerpc/powernv: call OPAL_QUIESCE before OPAL_SIGNAL_SYSTEM_RESET
      powerpc/powernv: process all OPAL event interrupts with kopald
      powerpc/64s/radix: do not flush TLB when relaxing access
      powerpc/64s/radix: do not flush TLB on spurious fault
      powerpc/64s/radix: make ptep_get_and_clear_full non-atomic for the fu=
ll case
      powerpc/64s/radix: prefetch user address in update_mmu_cache
      powerpc/64s/radix: avoid ptesync after set_pte and ptep_set_access_fl=
ags
      powerpc/64s/radix: optimise pte_update
      powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask
      powerpc/64s: Fix compiler store ordering to SLB shadow area
      powerpc/64s/radix: Fix missing ptesync in flush_cache_vmap

Olof Johansson (1):
      powerpc/pasemi: Set PCI_SCAN_ALL_PCI_DEVS

Paul Gortmaker (1):
      powerpc: remove retired sbc834x support

Peter Rosin (1):
      powerpc/fsl/dts: fix the i2c-mux compatible for t104xqds

Ram Pai (4):
      mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS i=
s enabled
      mm, powerpc, x86: introduce an additional vma bit for powerpc pkey
      mm/pkeys, x86, powerpc: Display pkey in smaps if arch supports pkeys
      powerpc/pkeys: Detach execute_only key on !PROT_EXEC

Ravi Bangoria (3):
      powerpc/sstep: Introduce GETTYPE macro
      powerpc/sstep: Fix kernel crash if VSX is not present
      powerpc/sstep: Fix emulate_step test if VSX not present

Russell Currey (1):
      powerpc/xive: Remove (almost) unused macros

Sam Bobroff (12):
      powerpc/eeh: Add final message for successful recovery
      powerpc/eeh: Fix use-after-release of EEH driver
      powerpc/eeh: Remove unused eeh_pcid_name()
      powerpc/eeh: Strengthen types of eeh traversal functions
      powerpc/eeh: Add message when PE processing at parent
      powerpc/eeh: Clean up pci_ers_result handling
      powerpc/eeh: Introduce eeh_for_each_pe()
      powerpc/eeh: Introduce eeh_edev_actionable()
      powerpc/eeh: Introduce eeh_set_channel_state()
      powerpc/eeh: Introduce eeh_set_irq_state()
      powerpc/eeh: Cleaner handling of EEH_DEV_NO_HANDLER
      powerpc/eeh: Refactor report functions

Shilpasri G Bhat (3):
      powernv: opal-sensor: Add support to read 64bit sensor values
      hwmon: (ibmpowernv): Add support to read 64 bit sensors
      hwmon: (ibmpowernv) Add energy sensors

Simon Guo (3):
      powerpc: Export msr_check_and_set() to modules
      powerpc/reg: Add TEXASR related macros
      powerpc: Export tm_enable()/tm_disable/tm_abort() APIs

Souptick Joarder (1):
      powerpc/cell/spufs: Change return type to vm_fault_t

Stewart Smith (1):
      hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Thiago Jung Bauermann (2):
      selftests/powerpc: Add ptrace tests for Protection Key registers
      selftests/powerpc: Add core file test for Protection Key registers

Torsten Duwe (1):
      powerpc/livepatch: Implement reliable stack tracing for the consisten=
cy model

Vaibhav Jain (2):
      cxl: Disable prefault_mode in Radix mode
      cxl: Configure PSL to not use APC virtual machines

Wei Yongjun (1):
      ocxl: Fix missing unlock on error in afu_ioctl_enable_p9_wait()

Wolfram Sang (1):
      powerpc/watchdog: fix typo 'can by' to 'can be'

Yisheng Xie (1):
      powerpc/xmon: use match_string() helper

YueHaibing (1):
      powerpc/xics: Add missing of_node_put() in error path


 Documentation/ABI/testing/sysfs-class-cxl          |   4 +-
 Documentation/accelerators/ocxl.rst                |  11 +
 Documentation/devicetree/bindings/marvell.txt      | 516 ------------------
 arch/powerpc/Kconfig                               |   3 +
 arch/powerpc/Makefile                              |  32 +-
 arch/powerpc/boot/Makefile                         |  23 +-
 arch/powerpc/boot/cuboot-c2k.c                     | 189 -------
 arch/powerpc/boot/dts/c2k.dts                      | 366 -------------
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi            |   2 +-
 arch/powerpc/boot/dts/sbc8349.dts                  | 331 ------------
 arch/powerpc/boot/mpc8xx.c                         |   3 +-
 arch/powerpc/boot/mpsc.c                           | 169 ------
 arch/powerpc/boot/mv64x60.c                        | 581 -----------------=
----
 arch/powerpc/boot/mv64x60.h                        |  70 ---
 arch/powerpc/boot/mv64x60_i2c.c                    | 204 --------
 arch/powerpc/boot/ops.h                            |   1 -
 arch/powerpc/boot/serial.c                         |   4 -
 arch/powerpc/configs/83xx/sbc834x_defconfig        |  74 ---
 arch/powerpc/configs/c2k_defconfig                 | 389 --------------
 arch/powerpc/configs/powernv_defconfig             | 108 ++--
 arch/powerpc/configs/wii_defconfig                 |  14 +
 arch/powerpc/include/asm/asm-prototypes.h          |  20 +-
 arch/powerpc/include/asm/barrier.h                 |  15 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |   1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h       |   7 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |   8 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |   7 +
 arch/powerpc/include/asm/book3s/64/hash.h          |  10 -
 arch/powerpc/include/asm/book3s/64/mmu.h           |   7 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |  46 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  28 +-
 arch/powerpc/include/asm/book3s/64/radix-4k.h      |   3 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h     |   4 +
 arch/powerpc/include/asm/book3s/64/radix.h         |  86 ++-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   7 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  12 +-
 arch/powerpc/include/asm/cache.h                   |   3 +
 arch/powerpc/include/asm/cacheflush.h              |  14 +-
 arch/powerpc/include/asm/checksum.h                |  15 +-
 arch/powerpc/include/asm/cputable.h                |   3 +-
 arch/powerpc/include/asm/cputime.h                 |  16 +-
 arch/powerpc/include/asm/eeh.h                     |  11 +-
 arch/powerpc/include/asm/feature-fixups.h          |   9 +
 arch/powerpc/include/asm/ftrace.h                  |  31 +-
 arch/powerpc/include/asm/hardirq.h                 |   1 +
 arch/powerpc/include/asm/hugetlb.h                 |  21 +-
 arch/powerpc/include/asm/hw_irq.h                  |  11 +-
 arch/powerpc/include/asm/imc-pmu.h                 |   1 +
 arch/powerpc/include/asm/io.h                      |  10 +
 arch/powerpc/include/asm/machdep.h                 |   2 +-
 arch/powerpc/include/asm/mmu-book3e.h              |   6 -
 arch/powerpc/include/asm/mmu_context.h             |   5 -
 arch/powerpc/include/asm/module.h                  |  10 +-
 arch/powerpc/include/asm/mpc52xx.h                 |   6 +-
 arch/powerpc/include/asm/nmi.h                     |   6 +
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |   1 +
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  41 +-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |   3 -
 arch/powerpc/include/asm/nohash/64/pgalloc.h       |  95 ++--
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h   |  57 --
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  46 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |  58 +-
 arch/powerpc/include/asm/nohash/pte-book3e.h       |   6 -
 arch/powerpc/include/asm/opal-api.h                |   8 +
 arch/powerpc/include/asm/opal.h                    |   5 +-
 arch/powerpc/include/asm/paca.h                    |   3 +-
 arch/powerpc/include/asm/page.h                    |   1 +
 arch/powerpc/include/asm/pgtable.h                 |   1 +
 arch/powerpc/include/asm/pkeys.h                   |  13 -
 arch/powerpc/include/asm/plpar_wrappers.h          |   8 +-
 arch/powerpc/include/asm/pmac_pfunc.h              |   1 +
 arch/powerpc/include/asm/pnv-ocxl.h                |   2 +-
 arch/powerpc/include/asm/ppc-opcode.h              |   1 +
 arch/powerpc/include/asm/ppc_asm.h                 |   6 +-
 arch/powerpc/include/asm/processor.h               |  10 +-
 arch/powerpc/include/asm/pte-common.h              |   8 -
 arch/powerpc/include/asm/reg.h                     |  32 +-
 arch/powerpc/include/asm/rheap.h                   |   3 +
 arch/powerpc/include/asm/rtas.h                    |   2 +-
 arch/powerpc/include/asm/setup.h                   |   9 +
 arch/powerpc/include/asm/smp.h                     |   1 +
 arch/powerpc/include/asm/sstep.h                   |   2 +
 arch/powerpc/include/asm/switch_to.h               |   1 -
 arch/powerpc/include/asm/syscalls.h                |   2 +-
 arch/powerpc/include/asm/systbl.h                  |   6 +-
 arch/powerpc/include/asm/thread_info.h             |   8 +-
 arch/powerpc/include/asm/time.h                    |  11 -
 arch/powerpc/include/asm/tlb.h                     |  13 +
 arch/powerpc/include/asm/tm.h                      |   2 -
 arch/powerpc/include/asm/trace.h                   |   7 +-
 arch/powerpc/include/asm/uaccess.h                 |  21 +-
 arch/powerpc/include/asm/xive-regs.h               |   6 -
 arch/powerpc/include/asm/xmon.h                    |   2 +-
 arch/powerpc/include/asm/xor.h                     |  12 +-
 arch/powerpc/include/asm/xor_altivec.h             |  19 +
 arch/powerpc/kernel/align.c                        |   2 +-
 arch/powerpc/kernel/asm-offsets.c                  |   1 +
 arch/powerpc/kernel/btext.c                        |  10 +-
 arch/powerpc/kernel/dma.c                          |   2 -
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   1 +
 arch/powerpc/kernel/eeh.c                          |  19 +-
 arch/powerpc/kernel/eeh_driver.c                   | 496 ++++++++++--------
 arch/powerpc/kernel/eeh_pe.c                       |  26 +-
 arch/powerpc/kernel/entry_64.S                     |  11 +
 arch/powerpc/kernel/exceptions-64s.S               |   1 +
 arch/powerpc/kernel/fadump.c                       |  40 +-
 arch/powerpc/kernel/head_8xx.S                     |   2 +-
 arch/powerpc/kernel/hw_breakpoint.c                |   4 +-
 arch/powerpc/kernel/irq.c                          |   8 +-
 arch/powerpc/kernel/kvm.c                          |   4 +-
 arch/powerpc/kernel/machine_kexec.c                |   2 +
 arch/powerpc/kernel/machine_kexec_64.c             |   8 +-
 arch/powerpc/kernel/misc.S                         |  36 +-
 arch/powerpc/kernel/module.c                       |   6 +
 arch/powerpc/kernel/module_32.c                    |   4 +-
 arch/powerpc/kernel/module_64.c                    |  44 +-
 arch/powerpc/kernel/nvram_64.c                     |   4 +-
 arch/powerpc/kernel/pci_32.c                       |  11 +-
 arch/powerpc/kernel/pci_64.c                       |   8 +-
 arch/powerpc/kernel/ppc_save_regs.S                |   4 +
 arch/powerpc/kernel/process.c                      | 147 ++----
 arch/powerpc/kernel/prom.c                         |  23 +-
 arch/powerpc/kernel/prom_init.c                    | 189 ++++---
 arch/powerpc/kernel/ptrace.c                       |  21 +-
 arch/powerpc/kernel/rtas-proc.c                    |  26 +-
 arch/powerpc/kernel/rtas-rtc.c                     |   4 +-
 arch/powerpc/kernel/rtas.c                         |   7 +-
 arch/powerpc/kernel/security.c                     |  71 +++
 arch/powerpc/kernel/setup-common.c                 |   6 -
 arch/powerpc/kernel/setup.h                        |   6 +
 arch/powerpc/kernel/setup_64.c                     |   7 +
 arch/powerpc/kernel/signal.c                       |   4 +
 arch/powerpc/kernel/signal.h                       |   6 +-
 arch/powerpc/kernel/signal_32.c                    |  61 ++-
 arch/powerpc/kernel/signal_64.c                    |  19 +-
 arch/powerpc/kernel/smp.c                          |  46 +-
 arch/powerpc/kernel/stacktrace.c                   | 181 ++++++-
 arch/powerpc/kernel/sys_ppc32.c                    |   9 -
 arch/powerpc/kernel/syscalls.c                     |   4 +
 arch/powerpc/kernel/systbl.S                       |   2 +-
 arch/powerpc/kernel/systbl_chk.c                   |   2 +-
 arch/powerpc/kernel/systbl_chk.sh                  |   4 +-
 arch/powerpc/kernel/tau_6xx.c                      |  15 +-
 arch/powerpc/kernel/time.c                         | 227 +++-----
 arch/powerpc/kernel/tm.S                           |  12 +
 arch/powerpc/kernel/trace/ftrace.c                 | 212 ++++++--
 arch/powerpc/kernel/trace/ftrace_32.S              |  20 -
 arch/powerpc/kernel/trace/ftrace_64.S              |  29 -
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |  88 +++-
 arch/powerpc/kernel/trace/ftrace_64_pg.S           |   6 +-
 arch/powerpc/kernel/vdso32/Makefile                |  15 +-
 arch/powerpc/kernel/vecemu.c                       |   1 +
 arch/powerpc/kernel/vmlinux.lds.S                  |   7 +
 arch/powerpc/kernel/watchdog.c                     |  32 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  36 +-
 arch/powerpc/kvm/book3s_hv.c                       |   4 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   3 +
 arch/powerpc/lib/Makefile                          |   5 +-
 arch/powerpc/lib/checksum_32.S                     |  46 +-
 arch/powerpc/lib/checksum_64.S                     |  28 +
 arch/powerpc/lib/feature-fixups-test.S             |  42 +-
 arch/powerpc/lib/feature-fixups.c                  |  60 ++-
 arch/powerpc/lib/memcmp_32.S                       |  45 ++
 arch/powerpc/lib/sstep.c                           |  26 +-
 arch/powerpc/lib/string.S                          |  70 +--
 arch/powerpc/lib/string_32.S                       |  90 ++++
 arch/powerpc/lib/test_emulate_step.c               |  21 +-
 arch/powerpc/lib/xor_vmx_glue.c                    |   1 +
 arch/powerpc/mm/fault.c                            |  76 ++-
 arch/powerpc/mm/hash_utils_64.c                    |  10 +-
 arch/powerpc/mm/hugetlbpage.c                      |  40 +-
 arch/powerpc/mm/mem.c                              |   4 +-
 arch/powerpc/mm/mmu_context.c                      |   6 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |  39 +-
 arch/powerpc/mm/mmu_context_nohash.c               | 135 ++---
 arch/powerpc/mm/pgtable-book3s64.c                 | 279 +++++++++-
 arch/powerpc/mm/pgtable-hash64.c                   |   8 +-
 arch/powerpc/mm/pgtable-radix.c                    |  38 +-
 arch/powerpc/mm/pgtable.c                          |  49 +-
 arch/powerpc/mm/pgtable_64.c                       | 171 ------
 arch/powerpc/mm/pkeys.c                            |   4 +-
 arch/powerpc/mm/ppc_mmu_32.c                       |   2 +-
 arch/powerpc/mm/slb.c                              |  21 +-
 arch/powerpc/mm/subpage-prot.c                     |   8 +-
 arch/powerpc/mm/tlb-radix.c                        | 366 ++++++++++++-
 arch/powerpc/mm/tlb_hash32.c                       |  10 +-
 arch/powerpc/perf/core-fsl-emb.c                   |   2 +-
 arch/powerpc/perf/imc-pmu.c                        |  68 ++-
 arch/powerpc/perf/isa207-common.h                  |  64 ---
 arch/powerpc/perf/power8-pmu.c                     |  64 +++
 arch/powerpc/platforms/83xx/Kconfig                |   7 -
 arch/powerpc/platforms/83xx/Makefile               |   1 -
 arch/powerpc/platforms/83xx/sbc834x.c              |  73 ---
 arch/powerpc/platforms/8xx/adder875.c              |   2 -
 arch/powerpc/platforms/8xx/ep88xc.c                |   2 -
 arch/powerpc/platforms/8xx/m8xx_setup.c            |  11 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |   2 -
 arch/powerpc/platforms/Kconfig.cputype             |   4 +
 arch/powerpc/platforms/cell/spu_callbacks.c        |   2 +-
 arch/powerpc/platforms/cell/spu_syscalls.c         |   3 +-
 arch/powerpc/platforms/cell/spufs/file.c           |  33 +-
 arch/powerpc/platforms/chrp/pci.c                  |  12 +-
 arch/powerpc/platforms/chrp/setup.c                |  12 +-
 arch/powerpc/platforms/chrp/time.c                 |   6 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |  10 -
 arch/powerpc/platforms/embedded6xx/Makefile        |   1 -
 arch/powerpc/platforms/embedded6xx/c2k.c           | 148 ------
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   8 -
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   7 +-
 arch/powerpc/platforms/maple/maple.h               |   2 +-
 arch/powerpc/platforms/maple/time.c                |   5 +-
 arch/powerpc/platforms/pasemi/pasemi.h             |   2 +-
 arch/powerpc/platforms/pasemi/pci.c                |   2 +
 arch/powerpc/platforms/pasemi/time.c               |   4 +-
 arch/powerpc/platforms/powermac/bootx_init.c       |   6 +-
 arch/powerpc/platforms/powermac/pci.c              |   4 +-
 arch/powerpc/platforms/powermac/pmac.h             |   2 +-
 arch/powerpc/platforms/powermac/setup.c            |   9 +-
 arch/powerpc/platforms/powermac/smp.c              |   1 -
 arch/powerpc/platforms/powermac/time.c             |  48 +-
 arch/powerpc/platforms/powernv/copy-paste.h        |   6 +-
 arch/powerpc/platforms/powernv/idle.c              |   4 +-
 arch/powerpc/platforms/powernv/memtrace.c          |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |   5 +-
 arch/powerpc/platforms/powernv/ocxl.c              |   4 +-
 arch/powerpc/platforms/powernv/opal-hmi.c          |   2 +-
 arch/powerpc/platforms/powernv/opal-imc.c          |  22 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |  89 ++--
 arch/powerpc/platforms/powernv/opal-rtc.c          |   5 +-
 arch/powerpc/platforms/powernv/opal-sensor.c       |  53 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   2 +
 arch/powerpc/platforms/powernv/opal.c              |  23 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  46 +-
 arch/powerpc/platforms/powernv/powernv.h           |   3 +-
 arch/powerpc/platforms/powernv/setup.c             |  11 +-
 arch/powerpc/platforms/powernv/smp.c               |  17 +-
 arch/powerpc/platforms/ps3/platform.h              |   2 +-
 arch/powerpc/platforms/ps3/repository.c            |   4 +-
 arch/powerpc/platforms/ps3/time.c                  |  26 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c       |   2 +-
 arch/powerpc/platforms/pseries/kexec.c             |   7 +-
 arch/powerpc/platforms/pseries/lpar.c              |   3 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |  18 +-
 arch/powerpc/platforms/pseries/setup.c             |   1 +
 arch/powerpc/sysdev/Makefile                       |   3 -
 arch/powerpc/sysdev/cpm_gpio.c                     |   1 -
 arch/powerpc/sysdev/mv64x60.h                      |  13 -
 arch/powerpc/sysdev/mv64x60_dev.c                  | 535 -----------------=
--
 arch/powerpc/sysdev/mv64x60_pci.c                  | 171 ------
 arch/powerpc/sysdev/mv64x60_pic.c                  | 297 -----------
 arch/powerpc/sysdev/mv64x60_udbg.c                 | 152 ------
 arch/powerpc/sysdev/xics/xics-common.c             |   7 +-
 arch/powerpc/sysdev/xive/native.c                  |   2 +-
 arch/powerpc/sysdev/xive/spapr.c                   |  88 +++-
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh    |  12 +-
 arch/powerpc/xmon/nonstdio.h                       |   8 +-
 arch/powerpc/xmon/spu-dis.c                        |  18 +-
 arch/powerpc/xmon/xmon.c                           | 261 ++++-----
 arch/x86/include/asm/mmu_context.h                 |  15 -
 arch/x86/include/asm/pkeys.h                       |  13 +
 arch/x86/kernel/setup.c                            |   8 -
 drivers/cpuidle/cpuidle-powernv.c                  |  32 +-
 drivers/hwmon/ibmpowernv.c                         |   9 +-
 drivers/macintosh/via-pmu.c                        |  18 +-
 drivers/macintosh/windfarm_pm121.c                 |   2 +-
 drivers/macintosh/windfarm_pm81.c                  |   2 +-
 drivers/macintosh/windfarm_pm91.c                  |   2 +-
 drivers/misc/cxl/pci.c                             |   4 +-
 drivers/misc/cxl/sysfs.c                           |  16 +-
 drivers/misc/ocxl/context.c                        |   5 +-
 drivers/misc/ocxl/file.c                           |  80 +++
 drivers/misc/ocxl/link.c                           |  38 +-
 drivers/misc/ocxl/ocxl_internal.h                  |   1 +
 drivers/tty/hvc/hvc_opal.c                         |   1 -
 fs/proc/task_mmu.c                                 |  13 +-
 include/linux/mm.h                                 |  14 +-
 include/linux/pkeys.h                              |  13 +-
 include/misc/ocxl.h                                |   9 +
 include/uapi/misc/ocxl.h                           |  14 +
 kernel/sys_ni.c                                    |   2 +-
 kernel/trace/Kconfig                               |   6 +-
 scripts/recordmcount.pl                            |  18 +-
 tools/testing/selftests/powerpc/Makefile           |   1 -
 .../testing/selftests/powerpc/alignment/.gitignore |   1 +
 .../selftests/powerpc/benchmarks/exec_target.c     |   7 +-
 .../selftests/powerpc/context_switch/.gitignore    |   1 -
 .../selftests/powerpc/context_switch/Makefile      |   5 -
 .../selftests/powerpc/context_switch/cp_abort.c    | 110 ----
 tools/testing/selftests/powerpc/include/reg.h      |   1 +
 tools/testing/selftests/powerpc/ptrace/.gitignore  |   2 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |   6 +-
 tools/testing/selftests/powerpc/ptrace/child.h     | 139 +++++
 tools/testing/selftests/powerpc/ptrace/core-pkey.c | 461 ++++++++++++++++
 .../selftests/powerpc/ptrace/perf-hwbreak.c        | 195 +++++++
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c      | 342 ++++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 327 ++++++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    |  38 ++
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 298 files changed, 5696 insertions(+), 6903 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/marvell.txt
 delete mode 100644 arch/powerpc/boot/cuboot-c2k.c
 delete mode 100644 arch/powerpc/boot/dts/c2k.dts
 delete mode 100644 arch/powerpc/boot/dts/sbc8349.dts
 delete mode 100644 arch/powerpc/boot/mpsc.c
 delete mode 100644 arch/powerpc/boot/mv64x60.c
 delete mode 100644 arch/powerpc/boot/mv64x60.h
 delete mode 100644 arch/powerpc/boot/mv64x60_i2c.c
 delete mode 100644 arch/powerpc/configs/83xx/sbc834x_defconfig
 delete mode 100644 arch/powerpc/configs/c2k_defconfig
 delete mode 100644 arch/powerpc/include/asm/nohash/64/pgtable-64k.h
 create mode 100644 arch/powerpc/include/asm/xor_altivec.h
 create mode 100644 arch/powerpc/lib/memcmp_32.S
 create mode 100644 arch/powerpc/lib/string_32.S
 delete mode 100644 arch/powerpc/platforms/83xx/sbc834x.c
 delete mode 100644 arch/powerpc/platforms/embedded6xx/c2k.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60.h
 delete mode 100644 arch/powerpc/sysdev/mv64x60_dev.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60_pci.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60_pic.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60_udbg.c
 delete mode 100644 tools/testing/selftests/powerpc/context_switch/.gitigno=
re
 delete mode 100644 tools/testing/selftests/powerpc/context_switch/Makefile
 delete mode 100644 tools/testing/selftests/powerpc/context_switch/cp_abort=
.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/child.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/core-pkey.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbGR2pAAoJEFHr6jzI4aWAzq8QAJEPg0NmJ2CHmwqYCmrUG5HQ
NelMOxgWUCaOpXaQ6dWHhSgXMfK82cM7xQ1MjlsBdUCdfTRfaqVCjXCXvXiPDo/T
2ST0JT6xe8MoPT8RbqYY5dguaFbwdgDMsf0cgglOmWOegnyVUOEH7D9KiJ5iUeb0
dUq0ZsZ7vroQFCw3wJwsRwTBw+a8Jtb6yM8QWujzo4TOePpgWVr2qJvcBUPieOcf
kkheIQgp3Q7N1AK+LEx8gODrWKClkoKv5ACxXYzC4xvhFMA7H9PYVY1YB2/68Db6
NHBkeCoxYC8RwfDLczEpQnj8FgOfatJNqcCygqe/fHPGB9mydZNSSaIgJwyd64Rz
Nkqy6wzirPSAbVr0mpx/RNQaraWDDoLHCk7QK/1QrS/cpJb6bvURqjsMwkRVCnS+
x5MZvgb+Pkdt1aXXT6X6Qgso3QbNYvqJRmya9tjnUfyrorauwu+Grj8AteU50ACC
n8hSppD7qqU99KqoySsgrHsqj+ShrVL6n/TgOJOkdMtJexGoMxsUy1UgWO2pxqFc
uOsekJaxYrPHRnDkePTRUTHa27oqj0MJ5kwYBM1P0W6O5L1VY21IVzALgmj0O+6r
KC+ONQVCst7jlVF5E0vTBnzDrp30WOZVxmU9iGb0ha9X/JU0pvHaci7CXtKpko33
705n/Q3r4XFNNbHc4zfN
=3D2yFv
-----END PGP SIGNATURE-----
