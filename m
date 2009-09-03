Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2776BB70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 04:39:44 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97605DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 04:39:43 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n83IahQl020210
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:36:43 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n83Ide9t487668
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:39:40 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n83Idd5X003579
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:39:39 +1000
Date: Fri, 4 Sep 2009 00:09:30 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver IX
Message-ID: <20090903183930.GA4590@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
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
	Please find a new set of patches with the changes as listed below.

These patches have to be applied over the set of patches sent to LKML here:
http://lkml.org/lkml/2009/8/28/272 that enable per-cpu breakpoint support and
a few new APIs.

Changelog - ver IX
-------------------
- Invocation of user-defined callback will be 'trigger-after-execute' (except
  for ptrace).
- Creation of a new global per-CPU breakpoint structure to help invocation of
  user-defined callback from single-step handler.
- Validation before registration will fail only if the address does not match
  the kernel symbol's (if specified) resolved address
  (through kallsyms_lookup_name()).
- 'symbolsize' value is expected to within the range contained by the symbol's
  starting address and the end of a double-word boundary (8 Bytes).
- PPC64's arch-dependant code is now aware of 'cpumask' in 'struct hw_breakpoint'
  and can accomodate requests for a subset of CPUs in the system.
- Introduced arch_disable_hw_breakpoint() required for
  <enable><disable>_hw_breakpoint() APIs.

Kindly let me know your comments on the same.

Thanks,
K.Prasad

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
- load_debug_registers() is done in start_secondary() i.e. during CPU initialisation.
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
