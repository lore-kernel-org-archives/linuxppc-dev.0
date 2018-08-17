Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41s8Mx6B44zDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 13:49:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: AlexeiS@astrosoft.ru, Bharat.Bhushan@nxp.com, aaro.koskinen@iki.fi,
 aik@ozlabs.ru, akshay.adiga@linux.vnet.ibm.com, alastair@d-silva.org,
 alistair@popple.id.au, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, arbab@linux.ibm.com, arnd@arndb.de,
 benh@kernel.crashing.org, boqun.feng@gmail.com, brgl@bgdev.pl,
 bsingharora@gmail.com, camelia.groza@nxp.com, christophe.leroy@c-s.fr,
 cyrilbur@gmail.com, dan.carpenter@oracle.com, darren@stevens-zone.net,
 david@gibson.dropbear.id.au, diana.craciun@nxp.com, eleon@ele0n.de,
 elfring@users.sourceforge.net, fbarrat@linux.ibm.com,
 fbarrat@linux.vnet.ibm.com, fthain@telegraphics.com.au,
 geert@linux-m68k.org, geoff@infradead.org, gregkh@linuxfoundation.org,
 haren@linux.vnet.ibm.com, hbathini@linux.ibm.com, hch@lst.de,
 j.neuschaefer@gmx.net, jk@ozlabs.org, joel@jms.id.au,
 jrdr.linux@gmail.com, keescook@chromium.org, leitao@debian.org,
 linux-kernel@hansmi.ch, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
 mahesh@linux.vnet.ibm.com, malat@debian.org, maurosr@linux.vnet.ibm.com,
 mikey@neuling.org, mukesh02@linux.vnet.ibm.com, muriloo@linux.ibm.com,
 npiggin@gmail.com, olof@lixom.net, oss@buserror.net, paulus@ozlabs.org,
 rashmica.g@gmail.com, rdunlap@infradead.org, rosattig@linux.vnet.ibm.com,
 ruscur@russell.cc, sbobroff@linux.ibm.com, shilpa.bhat@linux.vnet.ibm.com,
 sparth1292@gmail.com, stern@rowland.harvard.edu, stewart@linux.ibm.com,
 stewart@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 viresh.kumar@linaro.org, wei.guo.simon@gmail.com, zhongjiang@huawei.com,
 willy@infradead.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.19-1 tag
Date: Fri, 17 Aug 2018 13:49:18 +1000
Message-ID: <87r2ixac01.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
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

Please pull powerpc updates for 4.19.

There's a trivial conflict in Documentation/admin-guide/kernel-parameters.t=
xt
between our addition of nospectre_v1 and the x86 documentation for nosmt.

There's another in arch/m68k/mac/misc.c, which was coordinated with
Geert but unfortunately we still caused a conflict. The resolution is to
take the time64_t change and the CONFIG_ADB_PMU change.

The change to include/uapi/linux/pmu.h is safe and not perf related as
one would assume, the pmu there means Power Management Unit.

Finally there's the change to struct page. That was sent to linux-mm but
we couldn't tease an Ack out of anyone. Willy mentioned he wants to make
pt_mm generic in future, at which point we will happily shuffle our
field elsewhere.

cheers


The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.19-1

for you to fetch changes up to a2dc009afa9ae8b92305be7728676562a104cb40:

  powerpc/mm/book3s/radix: Add mapping statistics (2018-08-13 16:35:05 +100=
0)

=2D-------------------------------------------------------------------
powerpc updates for 4.19

Notable changes:

 - A fix for a bug in our page table fragment allocator, where a page table=
 page
   could be freed and reallocated for something else while still in use, le=
ading
   to memory corruption etc. The fix reuses pt_mm in struct page (x86 only)=
 for
   a powerpc only refcount.

 - Fixes to our pkey support. Several are user-visible changes, but bring u=
s in
   to line with x86 behaviour and/or fix outright bugs. Thanks to Florian W=
eimer
   for reporting many of these.

 - A series to improve the hvc driver & related OPAL console code, which ha=
ve
   been seen to cause hardlockups at times. The hvc driver changes in parti=
cular
   have been in linux-next for ~month.

 - Increase our MAX_PHYSMEM_BITS to 128TB when SPARSEMEM_VMEMMAP=3Dy.

 - Remove Power8 DD1 and Power9 DD1 support, neither chip should be in use
   anywhere other than as a paper weight.

 - An optimised memcmp implementation using Power7-or-later VMX instructions

 - Support for barrier_nospec on some NXP CPUs.

 - Support for flushing the count cache on context switch on some IBM CPUs
   (controlled by firmware), as a Spectre v2 mitigation.

 - A series to enhance the information we print on unhandled signals to bri=
ng it
   into line with other arches, including showing the offending VMA and dum=
ping
   the instructions around the fault.

Thanks to:
  Aaro Koskinen, Akshay Adiga, Alastair D'Silva, Alexey Kardashevskiy, Alex=
ey
  Spirkov, Alistair Popple, Andrew Donnellan, Aneesh Kumar K.V, Anju T Sudh=
akar,
  Arnd Bergmann, Bartosz Golaszewski, Benjamin Herrenschmidt, Bharat Bhusha=
n,
  Bjoern Noetel, Boqun Feng, Breno Leitao, Bryant G. Ly, Camelia Groza,
  Christophe Leroy, Christoph Hellwig, Cyril Bur, Dan Carpenter, Daniel Kla=
mt,
  Darren Stevens, Dave Young, David Gibson, Diana Craciun, Finn Thain, Flor=
ian
  Weimer, Frederic Barrat, Gautham R. Shenoy, Geert Uytterhoeven, Geoff Lev=
and,
  Guenter Roeck, Gustavo Romero, Haren Myneni, Hari Bathini, Joel Stanley,
  Jonathan Neusch=C3=A4fer, Kees Cook, Madhavan Srinivasan, Mahesh Salgaonk=
ar, Markus
  Elfring, Mathieu Malaterre, Mauro S. M. Rodrigues, Michael Hanselmann, Mi=
chael
  Neuling, Michael Schmitz, Mukesh Ojha, Murilo Opsfelder Araujo, Nicholas
  Piggin, Parth Y Shah, Paul Mackerras, Paul Menzel, Ram Pai, Randy Dunlap,
  Rashmica Gupta, Reza Arbab, Rodrigo R. Galvao, Russell Currey, Sam Bobrof=
f,
  Scott Wood, Shilpasri G Bhat, Simon Guo, Souptick Joarder, Stan Johnson,
  Thiago Jung Bauermann, Tyrel Datwyler, Vaibhav Jain, Vasant Hegde, Venkat=
 Rao
  B, zhong jiang.

=2D-------------------------------------------------------------------
Aaro Koskinen (1):
      powerpc: Enable kernel XZ compression option on BOOK3S_32

Akshay Adiga (2):
      powernv/cpuidle: Parse dt idle properties into global structure
      powernv/cpuidle: Use parsed device tree values for cpuidle_init

Alastair D'Silva (7):
      Revert "cxl: Add kernel API to allow a context to operate with reloca=
te disabled"
      Revert "cxl: Add support for interrupts on the Mellanox CX4"
      Revert "cxl: Add preliminary workaround for CX4 interrupt limitation"
      Revert "cxl: Add kernel APIs to get & set the max irqs per context"
      Revert "cxl: Add cxl_check_and_switch_mode() API to switch bi-modal c=
ards"
      Revert "cxl: Add support for using the kernel API with a real PHB"
      Revert "powerpc/powernv: Add support for the cxl kernel api on the re=
al phb"

Alexey Kardashevskiy (8):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size
      powerpc/powernv/ioda2: Add 256M IOMMU page size to the default POWER8=
 case
      powerpc/powernv: Remove useless wrapper
      powerpc/powernv: Move TCE manupulation code to its own file
      KVM: PPC: Make iommu_table::it_userspace big endian
      powerpc/powernv: Add indirect levels to it_userspace
      powerpc/powernv: Rework TCE level allocation
      powerpc/powernv/ioda: Allocate indirect TCE levels on demand

Alexey Spirkov (1):
      powerpc/44x: Mark mmu_init_secondary() as __init

Alistair Popple (1):
      powerpc/powernv/npu: Add a debugfs setting to change ATSD threshold

Aneesh Kumar K.V (11):
      powerpc/mm: Check memblock_add against MAX_PHYSMEM_BITS range
      powerpc/mm: Increase MAX_PHYSMEM_BITS to 128TB with SPARSEMEM_VMEMMAP=
 config
      powerpc/mm/hash: Remove the superfluous bitwise operation when find h=
pte group
      powerpc/mm/hash: Add hpte_get_old_v and use that instead of opencoding
      powerpc/mm/hash: Reduce contention on hpte lock
      powerpc/pseries: Use pr_xxx() in lpar.c
      powerpc/pseries/mm: Improve error reporting on HCALL failures
      powerpc/mm/tlbflush: update the mmu_gather page size while iterating =
address range
      powerpc/powernv/idle: Fix build error
      powerpc/mm/hash: Remove unnecessary do { } while(0) loop
      powerpc/mm/book3s/radix: Add mapping statistics

Anju T Sudhakar (1):
      powerpc/perf: Remove sched_task function defined for thread-imc

Arnd Bergmann (1):
      powerpc: xmon: use ktime_get_coarse_boottime64

Bartosz Golaszewski (3):
      powerpc/dts: Use 'atmel' as at24 manufacturer for pdm360ng
      powerpc/dts: Use 'atmel' as at24 manufacturer for kmcent2
      powerpc/dts: Use a correct at24 compatible fallback in ac14xx

Benjamin Herrenschmidt (3):
      powerpc/xive: Remove now useless pr_debug statements
      powerpc/xive: Remove xive_kexec_teardown_cpu()
      powerpc/powernv/opal: Use standard interrupts property when available

Bharat Bhushan (1):
      powerpc/mpic: Pass first free vector number to mpic_setup_error_int()

Boqun Feng (1):
      powerpc/xmon: Add address lookup for percpu symbols

Breno Leitao (5):
      scripts: Add ppc64le support for checkstack.pl
      powerpc/pci: Remove legacy debug code
      selftests/powerpc: Fix strncpy usage
      selftests/powerpc: Fix typos
      selftests/powerpc: Kill child processes on SIGINT

Camelia Groza (3):
      powerpc/configs/dpaa: enable the Cortina PHY driver
      powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver compatible
      powerpc/dts/fsl: t2080rdb: use the Cortina PHY driver compatible

Christoph Hellwig (1):
      powerpc: Do not redefine NEED_DMA_MAP_STATE

Christophe Leroy (26):
      powerpc/8xx: fix handling of early NULL pointer dereference
      powerpc: remove kdump.h from page.h
      powerpc: remove unneeded inclusions of cpu_has_feature.h
      powerpc/405: move PPC405_ERR77 in asm-405.h
      powerpc: move ASM_CONST and stringify_in_c() into asm-const.h
      powerpc: clean the inclusion of stringify.h
      powerpc: clean inclusions of asm/feature-fixups.h
      powerpc: remove superflous inclusions of asm/fixmap.h
      powerpc: declare set_breakpoint() static
      powerpc/book3s: Remove PPC_PIN_SIZE
      powerpc: fix includes in asm/processor.h
      powerpc/nohash: fix hash related comments in pgtable.h
      powerpc/44x: remove page.h from mmu-44x.h
      powerpc: remove unnecessary inclusion of asm/tlbflush.h
      powerpc: split asm/tlbflush.h
      selftests/powerpc: Add test for 32 bits memcmp
      selftests/powerpc: Add test for strlen()
      powerpc/lib: Implement strlen() in assembly for PPC32
      selftests/powerpc: Update strlen() test to test the new assembly func=
tion for PPC32
      powerpc: Make CPU selection logic generic in Makefile
      powerpc: Allow CPU selection also on PPC32
      powerpc: Allow CPU selection of e300core variants
      powerpc/cpm1: fix compilation error with CONFIG_PPC_EARLY_DEBUG_CPM
      powerpc/cpm1: fix compilation error with CONFIG_PPC_EARLY_DEBUG_CPM
      powerpc/lib: Use patch_site to patch copy_32 functions once cache is =
enabled
      powerpc/mm: remove huge_pte_offset_and_shift() prototype

Cyril Bur (2):
      powerpc/tm: Update function prototype comment
      powerpc/tm: Remove struct thread_info param from tm_reclaim_thread()

Dan Carpenter (1):
      powerpc: Fix size calculation using resource_size()

Daniel Klamt (1):
      powerpc/xive: Replace msleep(x) with msleep(OPAL_BUSY_DELAY_MS)

Darren Stevens (2):
      powerpc/pasemi: Search for PCI root bus by compatible property
      powerpc/pasemi: Use pr_err/pr_warn... for kernel messages

David Gibson (1):
      powerpc/hugetlbpage: Rmove unhelpful HUGEPD_*_SHIFT macros

Diana Craciun (6):
      powerpc/64: Disable the speculation barrier from the command line
      powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
      powerpc/64: Make meltdown reporting Book3S 64 specific
      powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E
      powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platfo=
rms
      Documentation: Add nospectre_v1 parameter

Finn Thain (11):
      macintosh/via-pmu: Fix section mismatch warning
      macintosh/via-pmu: Add missing mmio accessors
      macintosh/via-pmu: Don't clear shift register interrupt flag twice
      macintosh/via-pmu: Enhance state machine with new 'uninitialized' sta=
te
      macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
      macintosh/via-pmu: Add support for m68k PowerBooks
      macintosh/via-pmu: Explicitly specify CONFIG_PPC_PMAC dependencies
      macintosh/via-pmu68k: Don't load driver on unsupported hardware
      macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
      macintosh/via-pmu: Clean up interrupt statistics
      macintosh/via-pmu: Disambiguate interrupt statistics

Frederic Barrat (4):
      Revert "cxl: Add cxl_slot_is_supported API"
      Revert "cxl: Allow a default context to be associated with an externa=
l pci_dev"
      cxl: Remove abandonned capi support for the Mellanox CX4, final clean=
up
      ocxl: Fix page fault handler in case of fault on dying process

Geoff Levand (1):
      powerpc/ps3: Set driver coherent_dma_mask

Guenter Roeck (1):
      powerpc/4xx: Fix error return path in ppc4xx_msi_probe()

Haren Myneni (2):
      powerpc/powernv: Export opal_check_token symbol
      crypto/nx: Initialize 842 high and normal RxFIFO control registers

Hari Bathini (3):
      powerpc/kdump: Handle crashkernel memory reservation failure
      powerpc/fadump: handle crash memory ranges array index overflow
      powerpc/fadump: merge adjacent memory ranges to reduce PT_LOAD segeme=
nts

Joel Stanley (1):
      powerpc: Remove Power8 DD1 from cputable

Jonathan Neusch=C3=A4fer (1):
      powerpc: wii: Remove outdated comment about memory fixups

Kees Cook (2):
      powerpc/mpc5200: Remove VLA usage
      powerpc/msi: Remove VLA usage

Mahesh Salgaonkar (3):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.
      powerpc/pseries: Defer the logging of rtas error to irq work queue.
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Markus Elfring (1):
      powerpc/kexec: Use common error handling code in setup_new_fdt()

Mathieu Malaterre (7):
      powerpc/powermac: Add missing include of header pmac.h
      cxl: remove a dead branch
      powerpc/powermac: Remove variable x that's never read
      powerpc/powermac: Make some functions static
      powerpc: Move `path` variable inside DEBUG_PROM
      powerpc/32: Include setup.h header file to fix warnings
      powerpc/mm: remove warning about =E2=80=98type=E2=80=99 being set

Mauro S. M. Rodrigues (1):
      powerpc/eeh: Avoid misleading message "EEH: no capable adapters found"

Michael Ellerman (45):
      powerpc/64s: Report SLB multi-hit rather than parity error
      Merge branch 'topic/ppc-kvm' into next
      selftests/powerpc: Remove Power9 copy_unaligned test
      selftests/powerpc: Remove Power9 paste tests
      selftests/powerpc: Consolidate copy/paste test logic
      powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2
      powerpc: Add ppc32_allmodconfig defconfig target
      powerpc: Add ppc64le and ppc64_book3e allmodconfig targets
      powerpc/mm: Don't report PUDs as memory leaks when using kmemleak
      powerpc/64: Disable irq restore warning for now
      powerpc: Add a checkpatch wrapper with our preferred settings
      selftests/powerpc: Add a helper for checking if we're on ppc64le
      selftests/powerpc: Only run some tests on ppc64le
      selftests/powerpc: Give some tests longer to run
      powerpc/64s: Move SET_SCRATCH0() into EXCEPTION_PROLOG_PSERIES()
      powerpc/64s: Move SET_SCRATCH0() into EXCEPTION_RELON_PROLOG_PSERIES()
      powerpc/64s: Rename STD_EXCEPTION_PSERIES to STD_EXCEPTION
      powerpc/64s: Rename STD_EXCEPTION_PSERIES_OOL to STD_EXCEPTION_OOL
      powerpc/64s: Rename STD_RELON_EXCEPTION_PSERIES to STD_RELON_EXCEPTION
      powerpc/64s: Rename STD_RELON_EXCEPTION_PSERIES_OOL to STD_RELON_EXCE=
PTION_OOL
      powerpc/64s: Rename EXCEPTION_PROLOG_PSERIES_1 to EXCEPTION_PROLOG_2
      powerpc/64s: Remove PSERIES from the NORI macros
      powerpc/64s: Rename EXCEPTION_RELON_PROLOG_PSERIES_1
      powerpc/64s: Rename EXCEPTION_RELON_PROLOG_PSERIES
      powerpc/64s: Rename EXCEPTION_PROLOG_PSERIES to EXCEPTION_PROLOG
      powerpc/64s: Drop _MASKABLE_EXCEPTION_PSERIES()
      powerpc/64s: Drop _MASKABLE_RELON_EXCEPTION_PSERIES()
      powerpc/64s: Remove PSERIES naming from the MASKABLE macros
      powerpc/64s: Drop unused loc parameter to MASKABLE_EXCEPTION macros
      powerpc/64s: Don't use __MASKABLE_EXCEPTION unnecessarily
      powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
      powerpc/64: Call setup_barrier_nospec() from setup_arch()
      powerpc/asm: Add a patch_site macro & helpers for patching instructio=
ns
      powerpc/64s: Add new security feature flags for count cache flush
      powerpc/64s: Add support for software count cache flush
      powerpc/pseries: Query hypervisor for count cache flush settings
      powerpc/powernv: Query firmware for count cache flush settings
      powerpc/64s: Make rfi_flush_fallback a little more robust
      selftests/powerpc: Skip earlier in alignment_handler test
      selftests/powerpc: Add more version checks to alignment_handler test
      selftests/powerpc/64: Test exception cases in copy_tofrom_user
      powerpc/uaccess: Enable get_user(u64, *p) on 32-bit
      Merge branch 'fixes' into next
      Merge branch 'topic/hvc' into next
      Merge branch 'next' of https://git.kernel.org/.../scottwood/linux int=
o next

Michael Hanselmann (1):
      MAINTAINERS: Remove the entry for the orphaned ams driver

Michael Neuling (3):
      powerpc: Document issues with the DAWR on POWER9
      powerpc: Document issues with TM on POWER9
      powerpc/powernv/memtrace: Remove memtrace mmap()

Mukesh Ojha (2):
      powerpc/powernv/opal-dump : Handles opal_dump_info properly
      powerpc/powernv/opal-dump : Use IRQ_HANDLED instead of numbers in int=
errupt handler

Murilo Opsfelder Araujo (7):
      powerpc/prom_init: Remove linux,stdout-package property
      powerpc/traps: Print unhandled signals in a separate function
      powerpc/traps: Use an explicit ratelimit state for show_signal_msg()
      powerpc/traps: Use %lx format in show_signal_msg()
      powerpc/traps: Print VMA for unhandled signals
      powerpc: Add show_user_instructions()
      powerpc/traps: Show instructions on exceptions

Nicholas Piggin (22):
      powerpc/64s: Remove POWER9 DD1 support
      tty: hvc: use mutex instead of spinlock for hvc_structs lock
      tty: hvc: hvc_poll() break hv read loop
      tty: hvc: hvc_poll() may sleep
      tty: hvc: hvc_write() may sleep
      tty: hvc: introduce the hv_ops.flush operation for hvc drivers
      powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE] closely
      powerpc: NMI IPI make NMI IPIs fully sychronous
      powerpc/powernv: opal_put_chars partial write fix
      powerpc/powernv: Fix OPAL console driver OPAL_BUSY loops
      powerpc/powernv: opal-kmsg standardise OPAL_BUSY handling
      powerpc/powernv: opal-kmsg use flush fallback from console code
      powerpc/powernv: Implement and use opal_flush_console
      powerpc/powernv: Remove OPALv1 support from opal console driver
      powerpc/powernv: move opal console flushing to udbg
      powerpc/powernv: implement opal_put_chars_atomic
      tty: hvc: remove unexplained "just in case" spin delay
      powernv/cpuidle: Fix idle states all being marked invalid
      powerpc/64s/radix: tlb do not flush on page size when fullmm
      powerpc/64s: free page table caches at exit_mmap time
      powerpc/64s: Fix page table fragment refcount race vs speculative ref=
erences
      powerpc/64s: move machine check SLB flushing to mm/slb.c

Parth Y Shah (1):
      misc: cxl: changed asterisk position

Paul Mackerras (3):
      powerpc/64: Make exception table clearer in __copy_tofrom_user_base
      selftests/powerpc/64: Test all paths through copy routines
      powerpc/64: Copy as much as possible in __copy_tofrom_user

Ram Pai (9):
      powerpc/pkeys: Give all threads control of their key permissions
      powerpc/pkeys: Deny read/write/execute by default
      powerpc/pkeys: key allocation/deallocation must not change pkey regis=
ters
      powerpc/pkeys: Save the pkey registers before fork
      powerpc/pkeys: Fix calculation of total pkeys.
      powerpc/pkeys: Preallocate execute-only key
      powerpc/pkeys: make protection key 0 less special
      selftests/powerpc: Fix core-pkey for default execute permission change
      selftests/powerpc: Fix ptrace-pkey for default execute permission cha=
nge

Randy Dunlap (2):
      chrp/nvram.c: add MODULE_LICENSE()
      powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning

Rashmica Gupta (2):
      powerpc/powernv: Allow memory that has been hot-removed to be hot-add=
ed
      Documentation: Update documentation on ppc-memtrace

Reza Arbab (1):
      powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage

Rodrigo R. Galvao (1):
      powerpc/Makefiles: Convert ifeq to ifdef where possible

Sam Bobroff (1):
      powerpc/pseries: fix EEH recovery of some IOV devices

Shilpasri G Bhat (3):
      cpufreq: powernv: Remove global pstate ramp-down timer in POWER9
      powerpc/powernv: Add support to enable sensor groups
      hwmon: (ibmpowernv) Add attributes to enable/disable sensor groups

Simon Guo (5):
      powerpc/64: Align bytes before fall back to .Lshort in powerpc64 memc=
mp()
      powerpc: add vcmpequd/vcmpequb ppc instruction macro
      powerpc/64: enhance memcmp() with VMX instruction for long bytes comp=
arision
      powerpc/64: add 32 bytes prechecking before using VMX optimization on=
 memcmp()
      selftests/powerpc: Update memcmp_64 selftest for VMX implementation

Souptick Joarder (1):
      ocxl: Change return type for fault handler

Vaibhav Jain (1):
      cxl: Fix wrong comparison in cxl_adapter_context_get()

zhong jiang (1):
      powerpc/powermac: of_node_put() is not needed after iterator


 Documentation/ABI/testing/ppc-memtrace             |   9 +-
 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 Documentation/hwmon/ibmpowernv                     |  43 +-
 Documentation/powerpc/DAWR-POWER9.txt              |  58 ++
 Documentation/powerpc/transactional_memory.txt     |  44 ++
 MAINTAINERS                                        |   5 -
 arch/m68k/configs/mac_defconfig                    |   2 +-
 arch/m68k/configs/multi_defconfig                  |   2 +-
 arch/m68k/mac/config.c                             |   2 +-
 arch/m68k/mac/misc.c                               |  54 +-
 arch/powerpc/Kconfig                               |  12 +-
 arch/powerpc/Makefile                              |  49 +-
 arch/powerpc/boot/Makefile                         |   2 +-
 arch/powerpc/boot/dts/ac14xx.dts                   |  20 +-
 arch/powerpc/boot/dts/fsl/kmcent2.dts              |   2 +-
 arch/powerpc/boot/dts/fsl/t2080rdb.dts             |   4 +-
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |   8 +-
 arch/powerpc/boot/dts/pdm360ng.dts                 |   2 +-
 arch/powerpc/configs/book3s_32.config              |   2 +
 arch/powerpc/configs/dpaa.config                   |   1 +
 arch/powerpc/crypto/md5-asm.S                      |   1 +
 arch/powerpc/crypto/sha1-powerpc-asm.S             |   1 +
 arch/powerpc/include/asm/asm-405.h                 |  19 +
 arch/powerpc/include/asm/asm-compat.h              |  26 +-
 arch/powerpc/include/asm/asm-const.h               |  14 +
 arch/powerpc/include/asm/asm-prototypes.h          |  11 +-
 arch/powerpc/include/asm/atomic.h                  |   1 +
 arch/powerpc/include/asm/barrier.h                 |  14 +-
 arch/powerpc/include/asm/bitops.h                  |   1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h       |   7 -
 arch/powerpc/include/asm/book3s/32/tlbflush.h      |  25 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |   5 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   2 +
 arch/powerpc/include/asm/book3s/64/hugetlb.h       |  20 -
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  15 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |  30 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   5 +-
 arch/powerpc/include/asm/book3s/64/radix.h         |  40 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   2 -
 arch/powerpc/include/asm/book3s/tlbflush.h         |  11 +
 arch/powerpc/include/asm/cacheflush.h              |   1 -
 arch/powerpc/include/asm/cmpxchg.h                 |   2 +-
 arch/powerpc/include/asm/code-patching-asm.h       |  18 +
 arch/powerpc/include/asm/code-patching.h           |   3 +
 arch/powerpc/include/asm/cpuidle.h                 |  13 +
 arch/powerpc/include/asm/cputable.h                |  29 +-
 arch/powerpc/include/asm/cputime.h                 |   1 -
 arch/powerpc/include/asm/dbell.h                   |   2 +-
 arch/powerpc/include/asm/dcr-native.h              |   1 +
 arch/powerpc/include/asm/debug.h                   |   1 -
 arch/powerpc/include/asm/dt_cpu_ftrs.h             |   2 -
 arch/powerpc/include/asm/eeh.h                     |  15 +-
 arch/powerpc/include/asm/exception-64s.h           | 118 ++-
 arch/powerpc/include/asm/fadump.h                  |   3 -
 arch/powerpc/include/asm/feature-fixups.h          |   2 +
 arch/powerpc/include/asm/firmware.h                |   3 +-
 arch/powerpc/include/asm/fixmap.h                  |   1 -
 arch/powerpc/include/asm/futex.h                   |   2 +-
 arch/powerpc/include/asm/head-64.h                 |  16 +-
 arch/powerpc/include/asm/highmem.h                 |   2 +-
 arch/powerpc/include/asm/hugetlb.h                 |   3 -
 arch/powerpc/include/asm/hvcall.h                  |   2 +
 arch/powerpc/include/asm/hw_breakpoint.h           |   1 +
 arch/powerpc/include/asm/hw_irq.h                  |  10 +-
 arch/powerpc/include/asm/iommu.h                   |  12 +-
 arch/powerpc/include/asm/jump_label.h              |   2 +-
 arch/powerpc/include/asm/kvm_booke_hv_asm.h        |   2 +
 arch/powerpc/include/asm/mmu-44x.h                 |  10 +-
 arch/powerpc/include/asm/mmu.h                     |   3 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   7 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  19 +-
 arch/powerpc/include/asm/nohash/tlbflush.h         |  53 ++
 arch/powerpc/include/asm/opal-api.h                |   4 +-
 arch/powerpc/include/asm/opal.h                    |   5 +
 arch/powerpc/include/asm/paca.h                    |   8 +-
 arch/powerpc/include/asm/page.h                    |   3 +-
 arch/powerpc/include/asm/page_64.h                 |   2 +
 arch/powerpc/include/asm/pkeys.h                   |  38 +-
 arch/powerpc/include/asm/pnv-pci.h                 |   7 -
 arch/powerpc/include/asm/ppc-opcode.h              |  14 +-
 arch/powerpc/include/asm/ppc_asm.h                 |   1 +
 arch/powerpc/include/asm/processor.h               |   5 +-
 arch/powerpc/include/asm/ptrace.h                  |   1 +
 arch/powerpc/include/asm/reg.h                     |   2 +
 arch/powerpc/include/asm/reg_a2.h                  |   2 +
 arch/powerpc/include/asm/reg_fsl_emb.h             |   2 +
 arch/powerpc/include/asm/security_features.h       |   7 +
 arch/powerpc/include/asm/setup.h                   |   6 +-
 arch/powerpc/include/asm/smp.h                     |   1 -
 arch/powerpc/include/asm/sparsemem.h               |  13 +-
 arch/powerpc/include/asm/spinlock.h                |   2 +-
 arch/powerpc/include/asm/stacktrace.h              |  13 +
 arch/powerpc/include/asm/string.h                  |   2 +
 arch/powerpc/include/asm/synch.h                   |   2 +-
 arch/powerpc/include/asm/thread_info.h             |   3 +-
 arch/powerpc/include/asm/tlb.h                     |   4 +-
 arch/powerpc/include/asm/tlbflush.h                |  86 +--
 arch/powerpc/include/asm/uaccess.h                 |  14 +-
 arch/powerpc/include/asm/xive.h                    |   1 -
 arch/powerpc/kernel/Makefile                       |  17 +-
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/cpu_setup_6xx.S                |   1 +
 arch/powerpc/kernel/cputable.c                     |  38 -
 arch/powerpc/kernel/crash.c                        |   1 -
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   4 +-
 arch/powerpc/kernel/eeh.c                          |   2 +-
 arch/powerpc/kernel/entry_32.S                     |  12 +
 arch/powerpc/kernel/entry_64.S                     |  64 ++
 arch/powerpc/kernel/exceptions-64e.S               |   5 +
 arch/powerpc/kernel/exceptions-64s.S               |  48 +-
 arch/powerpc/kernel/fadump.c                       | 126 ++-
 arch/powerpc/kernel/fpu.S                          |   2 +
 arch/powerpc/kernel/head_32.S                      |   1 +
 arch/powerpc/kernel/head_40x.S                     |   1 +
 arch/powerpc/kernel/head_64.S                      |   1 +
 arch/powerpc/kernel/head_8xx.S                     |   8 +-
 arch/powerpc/kernel/head_fsl_booke.S               |   1 +
 arch/powerpc/kernel/idle_6xx.S                     |   1 +
 arch/powerpc/kernel/idle_book3e.S                  |   7 +-
 arch/powerpc/kernel/idle_book3s.S                  |  52 +-
 arch/powerpc/kernel/idle_e500.S                    |   1 +
 arch/powerpc/kernel/idle_power4.S                  |   1 +
 arch/powerpc/kernel/irq.c                          |  41 +-
 arch/powerpc/kernel/kvm_emul.S                     |   1 +
 arch/powerpc/kernel/l2cr_6xx.S                     |   1 +
 arch/powerpc/kernel/machine_kexec.c                |   8 +-
 arch/powerpc/kernel/machine_kexec_file_64.c        |  28 +-
 arch/powerpc/kernel/mce_power.c                    |  44 +-
 arch/powerpc/kernel/misc_32.S                      |   1 +
 arch/powerpc/kernel/misc_64.S                      |   1 +
 arch/powerpc/kernel/module.c                       |   4 +-
 arch/powerpc/kernel/pci-common.c                   |   3 -
 arch/powerpc/kernel/ppc_save_regs.S                |   1 +
 arch/powerpc/kernel/process.c                      |  64 +-
 arch/powerpc/kernel/prom.c                         |  33 +-
 arch/powerpc/kernel/prom_init.c                    |  12 +-
 arch/powerpc/kernel/security.c                     | 141 +++-
 arch/powerpc/kernel/setup-common.c                 |   2 +
 arch/powerpc/kernel/setup_32.c                     |  11 +-
 arch/powerpc/kernel/setup_64.c                     |   1 +
 arch/powerpc/kernel/smp.c                          |  50 +-
 arch/powerpc/kernel/swsusp_32.S                    |   1 +
 arch/powerpc/kernel/swsusp_asm64.S                 |   1 +
 arch/powerpc/kernel/tm.S                           |   5 +-
 arch/powerpc/kernel/traps.c                        |  52 +-
 arch/powerpc/kernel/vdso.c                         |   1 -
 arch/powerpc/kernel/vector.S                       |   1 +
 arch/powerpc/kernel/vmlinux.lds.S                  |   4 +-
 arch/powerpc/kernel/watchdog.c                     |   1 -
 arch/powerpc/kvm/book3s.c                          |   1 -
 arch/powerpc/kvm/book3s_32_mmu.c                   |   1 -
 arch/powerpc/kvm/book3s_64_mmu.c                   |   1 -
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   1 -
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  15 +-
 arch/powerpc/kvm/book3s_64_slb.S                   |   3 +
 arch/powerpc/kvm/book3s_64_vio.c                   |  12 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |  20 +-
 arch/powerpc/kvm/book3s_hv.c                       |  11 -
 arch/powerpc/kvm/book3s_hv_interrupts.S            |   2 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   1 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  18 +-
 arch/powerpc/kvm/book3s_interrupts.S               |   1 +
 arch/powerpc/kvm/book3s_pr.c                       |   1 -
 arch/powerpc/kvm/book3s_rmhandlers.S               |   1 +
 arch/powerpc/kvm/book3s_segment.S                  |   3 +
 arch/powerpc/kvm/book3s_xive_template.c            |  39 +-
 arch/powerpc/kvm/e500.c                            |   1 -
 arch/powerpc/kvm/e500mc.c                          |   1 -
 arch/powerpc/kvm/powerpc.c                         |   1 -
 arch/powerpc/lib/Makefile                          |   2 +-
 arch/powerpc/lib/code-patching.c                   |  16 +
 arch/powerpc/lib/copy_32.S                         |   9 +-
 arch/powerpc/lib/copypage_64.S                     |   1 +
 arch/powerpc/lib/copypage_power7.S                 |   4 +-
 arch/powerpc/lib/copyuser_64.S                     | 587 +++++++-------
 arch/powerpc/lib/copyuser_power7.S                 |  21 +-
 arch/powerpc/lib/feature-fixups-test.S             |   1 +
 arch/powerpc/lib/feature-fixups.c                  |  35 +-
 arch/powerpc/lib/hweight_64.S                      |   1 +
 arch/powerpc/lib/ldstfp.S                          |   1 +
 arch/powerpc/lib/locks.c                           |   1 -
 arch/powerpc/lib/memcmp_64.S                       | 414 +++++++++-
 arch/powerpc/lib/memcpy_64.S                       |  11 +-
 arch/powerpc/lib/memcpy_power7.S                   |  28 +-
 arch/powerpc/lib/strlen_32.S                       |  78 ++
 arch/powerpc/lib/vmx-helper.c                      |   4 +-
 arch/powerpc/mm/44x_mmu.c                          |   2 +-
 arch/powerpc/mm/Makefile                           |   4 +-
 arch/powerpc/mm/dump_hashpagetable.c               |   3 +-
 arch/powerpc/mm/fault.c                            |   1 -
 arch/powerpc/mm/hash64_4k.c                        |   8 +-
 arch/powerpc/mm/hash64_64k.c                       |  15 +-
 arch/powerpc/mm/hash_low_32.S                      |   1 +
 arch/powerpc/mm/hash_native_64.c                   |  78 +-
 arch/powerpc/mm/hash_utils_64.c                    |  41 +-
 arch/powerpc/mm/highmem.c                          |   2 +-
 arch/powerpc/mm/hugepage-hash64.c                  |   9 +-
 arch/powerpc/mm/hugetlbpage.c                      |  26 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |  25 +-
 arch/powerpc/mm/mmu_context_hash32.c               |   1 -
 arch/powerpc/mm/mmu_decl.h                         |   1 -
 arch/powerpc/mm/pgtable-book3s64.c                 |  39 +-
 arch/powerpc/mm/pgtable-radix.c                    |  79 +-
 arch/powerpc/mm/pkeys.c                            | 141 ++--
 arch/powerpc/mm/slb.c                              |  39 +
 arch/powerpc/mm/slb_low.S                          |   1 +
 arch/powerpc/mm/subpage-prot.c                     |   1 -
 arch/powerpc/mm/tlb-radix.c                        |  18 -
 arch/powerpc/mm/tlb_low_64e.S                      |   1 +
 arch/powerpc/mm/tlb_nohash_low.S                   |   2 +
 arch/powerpc/net/Makefile                          |   2 +-
 arch/powerpc/net/bpf_jit32.h                       |   1 +
 arch/powerpc/net/bpf_jit_asm.S                     |   1 +
 arch/powerpc/net/bpf_jit_comp.c                    |   1 +
 arch/powerpc/net/bpf_jit_comp64.c                  |   1 +
 arch/powerpc/perf/core-book3s.c                    |  34 -
 arch/powerpc/perf/imc-pmu.c                        | 108 ++-
 arch/powerpc/perf/isa207-common.c                  |  12 +-
 arch/powerpc/perf/isa207-common.h                  |   5 -
 arch/powerpc/perf/power9-pmu.c                     |  54 +-
 arch/powerpc/perf/req-gen/_begin.h                 |   2 +
 arch/powerpc/perf/req-gen/perf.h                   |   1 +
 arch/powerpc/platforms/4xx/msi.c                   |  51 +-
 arch/powerpc/platforms/52xx/Makefile               |   2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c           |   5 +-
 arch/powerpc/platforms/85xx/t1042rdb_diu.c         |   4 +
 arch/powerpc/platforms/Kconfig.cputype             |  39 +-
 arch/powerpc/platforms/cell/Makefile               |   2 +-
 arch/powerpc/platforms/cell/cbe_thermal.c          |   1 +
 arch/powerpc/platforms/cell/spufs/sputrace.h       |   1 +
 arch/powerpc/platforms/chrp/nvram.c                |   3 +
 arch/powerpc/platforms/embedded6xx/wii.c           |  10 -
 arch/powerpc/platforms/pasemi/dma_lib.c            |   6 +-
 arch/powerpc/platforms/pasemi/gpio_mdio.c          |   2 +-
 arch/powerpc/platforms/pasemi/idle.c               |   4 +-
 arch/powerpc/platforms/pasemi/iommu.c              |   2 +-
 arch/powerpc/platforms/pasemi/misc.c               |   4 +-
 arch/powerpc/platforms/pasemi/pci.c                |  16 +-
 arch/powerpc/platforms/pasemi/setup.c              |  53 +-
 arch/powerpc/platforms/powermac/cache.S            |   1 +
 arch/powerpc/platforms/powermac/feature.c          |   2 -
 arch/powerpc/platforms/powermac/pci.c              |  12 +-
 arch/powerpc/platforms/powermac/sleep.S            |   1 +
 arch/powerpc/platforms/powermac/time.c             |   4 +-
 arch/powerpc/platforms/powermac/udbg_scc.c         |   4 +-
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  12 +-
 arch/powerpc/platforms/powernv/idle.c              | 245 +++---
 arch/powerpc/platforms/powernv/memtrace.c          | 121 ++-
 arch/powerpc/platforms/powernv/npu-dma.c           |  17 +-
 arch/powerpc/platforms/powernv/opal-dump.c         |  18 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      | 126 +--
 arch/powerpc/platforms/powernv/opal-kmsg.c         |  30 +-
 .../powerpc/platforms/powernv/opal-sensor-groups.c |  28 +
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   4 +
 arch/powerpc/platforms/powernv/opal.c              | 154 ++--
 arch/powerpc/platforms/powernv/pci-cxl.c           | 199 -----
 arch/powerpc/platforms/powernv/pci-ioda-tce.c      | 399 ++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c          | 208 +----
 arch/powerpc/platforms/powernv/pci.c               | 158 ----
 arch/powerpc/platforms/powernv/pci.h               |  53 +-
 arch/powerpc/platforms/powernv/setup.c             |  10 +-
 arch/powerpc/platforms/powernv/smp.c               |  27 +-
 arch/powerpc/platforms/powernv/vas.h               |   1 +
 arch/powerpc/platforms/pseries/Makefile            |   2 +-
 arch/powerpc/platforms/pseries/hvCall.S            |   1 +
 arch/powerpc/platforms/pseries/kexec.c             |   2 +-
 arch/powerpc/platforms/pseries/lpar.c              |  51 +-
 arch/powerpc/platforms/pseries/mobility.c          |   1 +
 arch/powerpc/platforms/pseries/ras.c               |  51 +-
 arch/powerpc/platforms/pseries/setup.c             |  50 +-
 arch/powerpc/purgatory/trampoline.S                |  10 +-
 arch/powerpc/sysdev/Makefile                       |   2 +-
 arch/powerpc/sysdev/cpm1.c                         |   1 -
 arch/powerpc/sysdev/fsl_mpic_err.c                 |   2 +-
 arch/powerpc/sysdev/mpic.c                         |   6 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |   2 +-
 arch/powerpc/sysdev/msi_bitmap.c                   |  15 +-
 arch/powerpc/sysdev/xive/common.c                  |  30 +-
 arch/powerpc/sysdev/xive/native.c                  |  34 +-
 arch/powerpc/tools/checkpatch.sh                   |  22 +
 arch/powerpc/xmon/spr_access.S                     |   1 +
 arch/powerpc/xmon/xmon.c                           |  38 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  20 +-
 drivers/cpuidle/cpuidle-powernv.c                  | 158 +---
 drivers/crypto/nx/nx-842-powernv.c                 |  31 +-
 drivers/hwmon/ibmpowernv.c                         | 238 +++++-
 drivers/macintosh/Kconfig                          |  19 +-
 drivers/macintosh/Makefile                         |   1 -
 drivers/macintosh/adb.c                            |   2 +-
 drivers/macintosh/via-pmu.c                        | 346 +++++----
 drivers/macintosh/via-pmu68k.c                     | 850 -----------------=
----
 drivers/misc/cxl/Kconfig                           |   8 -
 drivers/misc/cxl/Makefile                          |   2 +-
 drivers/misc/cxl/api.c                             | 132 ----
 drivers/misc/cxl/base.c                            |  83 --
 drivers/misc/cxl/context.c                         |   3 +-
 drivers/misc/cxl/cxl.h                             |  41 -
 drivers/misc/cxl/cxllib.c                          |   4 -
 drivers/misc/cxl/debugfs.c                         |   5 -
 drivers/misc/cxl/fault.c                           |   2 +-
 drivers/misc/cxl/guest.c                           |   8 -
 drivers/misc/cxl/main.c                            |   7 +-
 drivers/misc/cxl/native.c                          |   3 +-
 drivers/misc/cxl/pci.c                             | 392 +---------
 drivers/misc/cxl/phb.c                             |  44 --
 drivers/misc/cxl/vphb.c                            |  46 +-
 drivers/misc/ocxl/context.c                        |  22 +-
 drivers/misc/ocxl/link.c                           |  24 +-
 drivers/misc/ocxl/sysfs.c                          |   5 +-
 drivers/tty/hvc/hvc_console.c                      | 194 +++--
 drivers/tty/hvc/hvc_console.h                      |   1 +
 drivers/tty/hvc/hvc_opal.c                         |  31 +-
 drivers/usb/host/ehci-ps3.c                        |   6 +-
 drivers/usb/host/ohci-ps3.c                        |   6 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                |  65 +-
 include/linux/mm_types.h                           |   5 +-
 include/misc/cxl-base.h                            |  10 -
 include/misc/cxl.h                                 |  68 --
 include/uapi/linux/pmu.h                           |   4 +-
 scripts/checkstack.pl                              |  11 +-
 sound/ppc/snd_ps3.c                                |   5 +
 .../testing/selftests/powerpc/alignment/.gitignore |   4 -
 tools/testing/selftests/powerpc/alignment/Makefile |   5 +-
 .../powerpc/alignment/alignment_handler.c          | 107 ++-
 .../powerpc/alignment/copy_first_unaligned.c       |  33 +-
 .../alignment/copy_paste_unaligned_common.c        |  53 --
 .../alignment/copy_paste_unaligned_common.h        |  26 -
 .../selftests/powerpc/alignment/copy_unaligned.c   |  41 -
 .../powerpc/alignment/paste_last_unaligned.c       |  43 --
 .../selftests/powerpc/alignment/paste_unaligned.c  |  43 --
 .../selftests/powerpc/benchmarks/futex_bench.c     |   1 +
 .../selftests/powerpc/benchmarks/mmap_bench.c      |   2 +
 .../testing/selftests/powerpc/copyloops/.gitignore |  17 +-
 tools/testing/selftests/powerpc/copyloops/Makefile |  45 +-
 .../selftests/powerpc/copyloops/asm/asm-compat.h   |   0
 .../powerpc/copyloops/asm/feature-fixups.h         |   0
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  44 +-
 .../powerpc/copyloops/copy_tofrom_user_reference.S |  24 +
 .../selftests/powerpc/copyloops/exc_validate.c     | 124 +++
 tools/testing/selftests/powerpc/copyloops/stubs.S  |  19 +
 .../powerpc/dscr/dscr_inherit_exec_test.c          |   8 +-
 tools/testing/selftests/powerpc/harness.c          |  18 +-
 tools/testing/selftests/powerpc/include/utils.h    |   2 +
 .../powerpc/pmu/ebb/instruction_count_test.c       |   1 +
 .../powerpc/pmu/ebb/lost_exception_test.c          |   1 +
 .../selftests/powerpc/primitives/asm/asm-const.h   |   1 +
 .../powerpc/primitives/asm/feature-fixups.h        |   1 +
 tools/testing/selftests/powerpc/ptrace/core-pkey.c |   4 +
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c |   4 +
 .../testing/selftests/powerpc/stringloops/Makefile |  29 +-
 .../selftests/powerpc/stringloops/asm/cache.h      |   1 +
 .../selftests/powerpc/stringloops/asm/ppc-opcode.h |  39 +
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |  25 +
 .../testing/selftests/powerpc/stringloops/memcmp.c |  99 ++-
 .../selftests/powerpc/stringloops/memcmp_32.S      |   1 +
 .../testing/selftests/powerpc/stringloops/string.c |  21 +
 .../testing/selftests/powerpc/stringloops/strlen.c | 127 +++
 .../selftests/powerpc/stringloops/strlen_32.S      |   1 +
 tools/testing/selftests/powerpc/tm/tm-sigreturn.c  |   1 +
 tools/testing/selftests/powerpc/tm/tm-tar.c        |   1 +
 tools/testing/selftests/powerpc/tm/tm-vmxcopy.c    |   1 +
 tools/testing/selftests/powerpc/utils.c            |  17 +
 363 files changed, 5246 insertions(+), 5250 deletions(-)
 create mode 100644 Documentation/powerpc/DAWR-POWER9.txt
 create mode 100644 arch/powerpc/configs/book3s_32.config
 create mode 100644 arch/powerpc/include/asm/asm-405.h
 create mode 100644 arch/powerpc/include/asm/asm-const.h
 create mode 100644 arch/powerpc/include/asm/book3s/32/tlbflush.h
 create mode 100644 arch/powerpc/include/asm/book3s/tlbflush.h
 create mode 100644 arch/powerpc/include/asm/code-patching-asm.h
 create mode 100644 arch/powerpc/include/asm/nohash/tlbflush.h
 create mode 100644 arch/powerpc/include/asm/stacktrace.h
 create mode 100644 arch/powerpc/lib/strlen_32.S
 create mode 100644 arch/powerpc/platforms/powernv/pci-ioda-tce.c
 create mode 100755 arch/powerpc/tools/checkpatch.sh
 delete mode 100644 drivers/macintosh/via-pmu68k.c
 delete mode 100644 drivers/misc/cxl/phb.c
 delete mode 100644 tools/testing/selftests/powerpc/alignment/copy_paste_un=
aligned_common.c
 delete mode 100644 tools/testing/selftests/powerpc/alignment/copy_paste_un=
aligned_common.h
 delete mode 100644 tools/testing/selftests/powerpc/alignment/copy_unaligne=
d.c
 delete mode 100644 tools/testing/selftests/powerpc/alignment/paste_last_un=
aligned.c
 delete mode 100644 tools/testing/selftests/powerpc/alignment/paste_unalign=
ed.c
 create mode 100644 tools/testing/selftests/powerpc/copyloops/asm/asm-compa=
t.h
 create mode 100644 tools/testing/selftests/powerpc/copyloops/asm/feature-f=
ixups.h
 create mode 100644 tools/testing/selftests/powerpc/copyloops/copy_tofrom_u=
ser_reference.S
 create mode 100644 tools/testing/selftests/powerpc/copyloops/exc_validate.c
 create mode 100644 tools/testing/selftests/powerpc/copyloops/stubs.S
 create mode 120000 tools/testing/selftests/powerpc/primitives/asm/asm-cons=
t.h
 create mode 120000 tools/testing/selftests/powerpc/primitives/asm/feature-=
fixups.h
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/cache.h
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/ppc-opc=
ode.h
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_32.S
 create mode 100644 tools/testing/selftests/powerpc/stringloops/string.c
 create mode 100644 tools/testing/selftests/powerpc/stringloops/strlen.c
 create mode 120000 tools/testing/selftests/powerpc/stringloops/strlen_32.S

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAlt2Rb8ACgkQUevqPMjh
pYDQIBAAlNYIEDM0aeHaNW+YexPyRbOFCdoNTpcaultAk5n2GpTIK66FAZpOS7At
bhZXfde27olpSPAUX6XqxDDEYBU54k3o4lR7SpvnfrKS5qvkTl5rfy+AiG3oen6w
thsmTAHAL6kaVrotRLFMJc1R8d9TealJKaIsryzfBcxOTN2OXEzv1O/wUDywkwkp
qwXplcaC16Vz5ZERO1rJlF5fEM3aL6tOQ2TCiEJyn/4krINV39VqTE+BVUNzv8Eh
Yrotji5enpWfTPKMrPjoTYQLV4ejhwdUdakP/PP4wzAGCm3If1kz3b1jLG1IEY5Q
FI2RUxtr7verU7t97J29sX6cy5LRyhMjX2SaLICt1dFToYezXZFjlPOgX7NNCMUR
YzGbhiQjeNqh+awxQy3mBsXhVqgLfnpYJJD3lNDKDJwQCzQ3A17zfv0ffEwzvt8T
eP33LqlKUAbMGXnRut2vmmOfeV0xHvHgX82CWeRc/6EH6CJ0Cw3eWeZ37Zvsgk1c
QXddZzKe+m2xOx+s8COk/i4/TAe+NnuS9gAiayvBbGLqz8jbfmaU8LT838EXmm5z
XuHZKRdkgKX0600OQ/IK71N2bHBI42JwaNK70GD2UEvNtS/ACuacuZfq8/KjPAdR
HsfAuqueNE6gq6Y1t5ifGinZdVwTBrkQshNiD3Mr4XeS40BjNv0=
=HS6M
-----END PGP SIGNATURE-----
--=-=-=--
