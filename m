Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76AC7B7D49
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:01:47 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4O3vn7c008991
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 13:57:49 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4O3sPXo1609836
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 13:54:25 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4O41jMc023888
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:01:46 +1000
Date: Mon, 24 May 2010 09:31:37 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [RFC Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver XIX
Message-ID: <20100524040137.GA20873@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,
	Please find a new version of the patches that implement
hw-breakpoints for PowerPC Book III S. This patchset has some major
additions to hw-breakpoint exception handling that help reliable
restoration of breakpoints + increased coverage of breakpoints for
signal handlers.

The patches have been marked RFC, given that changes through patches
4/5 and 5/5 haven't been tested in particular and that they make
modifications to the generic framework too.

Kindly let me know your comments.

Changelog - ver XIX
--------------------
(Version XVIII: linuxppc-dev ref: 20100512033055.GA6384@in.ibm.com)
- Increased coverage of breakpoints during concurrent alignment_exception
  and signal handling (which previously had 'blind-spots').
- Support for kernel-thread breakpoints and kernel-space breakpoints inside the
  context of a user-space process.
- Patches re-based to commit f4b87dee923342505e1ddba8d34ce9de33e75050, thereby
  necessitating minor changes to arch_validate_hwbkpt_settings().

Thanks,
K.Prasad

Changelog - ver XVIII
--------------------
(Version XVII: linuxppc-dev ref: 20100414034340.GA6571@in.ibm.com)
- hw-breakpoint restoration variables are cleaned-up before unregistration
  through a new function hook arch_unregister_hw_breakpoint().
- emulate_single_step() now notifies DIE_SSTEP to registered handlers;
  causes single_step_dabr_instruction() to be invoked after alignment_exception.
- SIGTRAP is no longer generated for non-ptrace user-space breakpoints.
- Slight code restructuring for brevity and style corrections.

Changelog - ver XVII
--------------------
(Version XVI: linuxppc-dev ref: 20100330095809.GA14403@in.ibm.com)
- CONFIG_HAVE_HW_BREAKPOINT is now used to define the scope of the new code
  (in lieu of CONFIG_PPC_BOOK3S_64).
- CONFIG_HAVE_HW_BREAKPOINT is now dependant upon CONFIG_PERF_EVENTS and
  CONFIG_PPC_BOOK3S_64 (to overcome build failures under certain configs).
- Included a target in arch/powerpc/lib/Makefile to build sstep.o when
  HAVE_HW_BREAKPOINT.
- Added a dummy definition for hw_breakpoint_disable() when !HAVE_HW_BREAKPOINT.
- Tested builds under defconfigs for ppc64, cell and g5 (found no patch induced
  failures).

Changelog - ver XVI
--------------------
(Version XV: linuxppc-dev ref: 20100323140639.GA21836@in.ibm.com)
- Used a new config option CONFIG_PPC_BOOK3S_64 (in lieu of
  CONFIG_PPC64/CPU_FTR_HAS_DABR) to limit the scope of the new code.
- Disabled breakpoints before kexec of the machine using hw_breakpoint_disable().
- Minor optimisation in exception-64s.S to check for data breakpoint exceptions
  in DSISR finally (after check for other causes) + changes in code comments and 
  representation of DSISR_DABRMATCH constant.
- Rebased to commit ae6be51ed01d6c4aaf249a207b4434bc7785853b of linux-2.6.

Changelog - ver XV
--------------------
(Version XIV: linuxppc-dev ref: 20100308181232.GA3406@in.ibm.com)

- Additional patch to disable interrupts during data breakpoint exception
  handling.
- Moved HBP_NUM definition to cputable.h under a new CPU_FTR definition
  (CPU_FTR_HAS_DABR).
- Filtering of extraneous exceptions (due to accesses outside symbol length) is
  by-passed for ptrace requests.
- Removed flush_ptrace_hw_breakpoint() from __switch_to() due to incorrect
  coding placement.
- Changes to code comments as per community reviews for previous version.
- Minor coding-style changes in hw_breakpoint.c as per review comments.
- Re-based to commit ae6be51ed01d6c4aaf249a207b4434bc7785853b of linux-2.6

Changelog - ver XIV
--------------------
(Version XIII: linuxppc-dev ref: 20100215055605.GB3670@in.ibm.com)

- Removed the 'name' field from 'struct arch_hw_breakpoint'.
- All callback invocations through bp->overflow_handler() are replaced with
  perf_bp_event().
- Removed the check for pre-existing single-stepping mode in
  hw_breakpoint_handler() as this check is unreliable while in kernel-space.
  Side effect of this change is the non-triggering of hw-breakpoints while
  single-stepping kernel through KGDB or Xmon.
- Minor code-cleanups and addition of comments in hw_breakpoint_handler() and
  single_step_dabr_instruction().
- Re-based to commit 25cf84cf377c0aae5dbcf937ea89bc7893db5176 of linux-2.6

Changelog - ver XIII
--------------------
(Version XII: linuxppc-dev ref: 20100121084640.GA3252@in.ibm.com)

- Fixed a bug for user-space breakpoints (triggered following the failure of a
  breakpoint request).
- Re-based on commit 724e6d3fe8003c3f60bf404bf22e4e331327c596 of linux-2.6
  
Changelog - ver XII
--------------------
(Version XI: linuxppc-dev ref: 20100119091234.GA9971@in.ibm.com)

- Unset MSR_SE only if kernel was not previously in single-step mode.
- Pre-emption is now enabled before returning from the hw-breakpoint exception
  handler.
- Variables to track the source of single-step exception (breakpoint from kernel,
  user-space vs single-stepping due to other requests) are added.
- Extraneous hw-breakpoint exceptions (due to memory accesses lying outside
  monitored symbol length) is now done for both kernel and user-space
  (previously only user-space).
- single_step_dabr_instruction() now returns NOTIFY_DONE if kernel was in
  single-step mode even before the hw-breakpoint. This enables other users of
  single-step mode to be notified of the exception.
- User-space instructions are not emulated from kernel-space, they are instead
  single-stepped.
  
Changelog - ver XI
------------------
(Version X: linuxppc-dev ref: 20091211160144.GA23156@in.ibm.com)
- Conditionally unset MSR_SE in the single-step handler
- Added comments to explain the duration and need for pre-emption
disable following hw-breakpoint exception.

Changelog - ver X
------------------
- Re-write the PPC64 patches for the new implementation of hw-breakpoints that
  uses the perf-layer.
- Rebased to commit 7622fc234190a37d4e9fe3ed944a2b61a63fca03 of -tip.

Changelog - ver IX
-------------------
- Invocation of user-defined callback will be 'trigger-after-execute' (except
  for ptrace).
- Creation of a new global per-CPU breakpoint structure to help invocation of
  user-defined callback from single-step handler.
(Changes made now)
- Validation before registration will fail only if the address does not match
  the kernel symbol's (if specified) resolved address
  (through kallsyms_lookup_name()).
- 'symbolsize' value is expected to within the range contained by the symbol's
  starting address and the end of a double-word boundary (8 Bytes).
- PPC64's arch-dependant code is now aware of 'cpumask' in 'struct hw_breakpoint'
  and can accomodate requests for a subset of CPUs in the system.
- Introduced arch_disable_hw_breakpoint() required for
  <enable><disable>_hw_breakpoint() APIs.

Changelog - ver VIII
-------------------
- Reverting changes to allow one-shot breakpoints only for ptrace requests.
- Minor changes in sanity checking in arch_validate_hwbkpt_settings().
- put_cpu_no_resched() is no longer available. Converted to put_cpu().

Changelog - ver VII
-------------------
- Allow the one-shot behaviour for exception handlers to be defined by the user.
  A new 'is_one_shot' flag is added to 'struct arch_hw_breakpoint'.

Changelog - ver VI
------------------
The task of identifying 'genuine' breakpoint exceptions from those caused by
'out-of-range' accesses turned out to be more tricky than originally thought.
Some changes to this effect were made in version IV of this patchset, but they
were not sufficient for user-space. Basically the breakpoint address received
through ptrace is always aligned to 8-bytes since ptrace receives an encoded
'data' (consisting of address | translation_enable | bkpt_type), and the size of
the symbol is not known. However for kernel-space addresses, the symbol-size can
be determined using kallsyms_lookup_size_offset() and this is used to check if
DAR (in the exception context) is
'bkpt_address <= DAR <= (bkpt_address + symbol_size)', failing which we conclude
it as a stray exception.

The following changes are made to enable check:
- Addition of a symbolsize field in 'struct arch_hw_breakpoint' field.
- Store the size of the 'watched' kernel symbol into 'symbolsize' field in
  arch_store_info(0 routine.
- Verify if the above described condition is true when is_one_shot is FALSE in
  hw_breakpoint_handler().

Changelog - ver V
------------------
- Breakpoint requests from ptrace (for user-space) are designed to be one-shot
in PPC64. The patch contains changes to retain this behaviour by returning early
in hw_breakpoint_handler() [without re-initialising DABR] and unregistering the
user-space request in ptrace_triggered(). It is safe to make a
unregister_user_hw_breakpoint() call from the breakpoint exception context
[through ptrace_triggered()] without giving rise to circular locking-dependancy.
This is because there can be no kernel code running on the CPU (which received
the exception) with the same spinlock held.

- Minor change in 'type' member of 'struct arch_hw_breakpoint' from u8 to 'int'.

Changelog - ver IV
------------------
- While DABR register requires double-word (8 bytes) aligned addresses, i.e.
the breakpoint is active over a range of 8 bytes, PPC64 allows byte-level
addressability. This may lead to stray exceptions which have to be ignored in
hw_breakpoint_handler(), when DAR != (Breakpoint request address). However DABR
will be populated with the requested breakpoint address aligned to the previous
double-word address. The code is now modified to store user-requested address
in 'bp->info.address' but update the DABR with a double-word aligned address.

- Please note that the Data Breakpoint facility in Xmon is broken as of 2.6.29
and the same has not been integrated into this facility as described in Ver I.

Changelog - ver III
------------------
- Patches are based on commit 08f16e060bf54bdc34f800ed8b5362cdeda75d8b of -tip
tree.
- The declarations in arch/powerpc/include/asm/hw_breakpoint.h are done only if
CONFIG_PPC64 is defined. This eliminates the need to conditionally include this
header file.
- load_debug_registers() is done in start_secondary() i.e. during CPU
initialisation.
- arch_check_va_<> routines in hw_breakpoint.c are now replaced with a much
simpler is_kernel_addr() check in arch_validate_hwbkpt_settings()
- Return code of hw_breakpoint_handler() when triggered due to Lazy debug
register switching is now changed to NOTIFY_STOP.
- The ptrace code no longer sets the TIF_DEBUG task flag as it is proposed to
be done in register_user_hw_breakpoint() routine.
- hw_breakpoint_handler() is now modified to use hbp_kernel_pos value to
  determine if the trigger was a user/kernel space address. The DAR register
  value is checked with the address stored in 'struct hw_breakpoint' to avoid
  handling of exceptions that belong to kprobe/Xmon.


Changelog - ver II
------------------
- Split the monolithic patch into six logical patches
- Changed the signature of arch_check_va_in_<user><kernel>space functions. They
  are now marked static.
- HB_NUM is now called as HBP_NUM (to preserve a consistent short-name
  convention)
- Introduced hw_breakpoint_disable() and changes to kexec code to disable
  breakpoints before a reboot.
- Minor changes in ptrace code to use macro-defined constants instead of
  numbers.
- Introduced a new constant definition INSTRUCTION_LEN in reg.h
