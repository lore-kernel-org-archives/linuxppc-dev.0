Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A5663B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 10:12:09 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 872A6DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:12:09 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n6RA1bQL016107
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 20:01:37 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6R0C8Dc483346
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:12:08 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6R0C7T5015524
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:12:08 +1000
Date: Mon, 27 Jul 2009 05:41:52 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 0/6] [Patch 0/6] PPC64-HWBKPT: Hardware Breakpoint
	interfaces - ver VIII
Message-ID: <20090727001152.GA13562@in.ibm.com>
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

Hi David,
	I'm back with a new version of patches after a brief hiatus!

After much deliberation about modifying the code to change the timing of signal
delivery to user-space, it has been decided to retain the existing behaviour
i.e. SIGTRAP delivered to user-space after execution of causative instruction
although exception is raised before execution of it.

One-shot behaviour will now be restricted only to ptrace requests. Kernel-space
and non-ptrace user-space requests will result in persistent breakpoints.

Reasons
--------
- Signal delivery before execution of instruction requires complex workarounds
- One of the plausible workarounds is a two-pass hw-breakpoint handler which
  delivers the signal after the first pass (with the breakpoints enabled).
  In the second pass, it follows the existing semantics of
  disable_hbp-->enable_ss-->single_step-->disable_ss-->enable_hbp.
- Possibility of nested exceptions is a problem here.
- Proper identification of a  second-pass of first exception and a new nested
  exception is difficult. Possibility of stray exceptions due to accesses in
  neighbouring memory regions of the breakpoint address further complicates it.
- Alternatives are i)use one-shot for all user-space requests ii)disable signal
  delivery for non-ptrace requests, allow the user-defined callback routine to
  generate signal.
- Using one-shot for all user-space requests will break the register/unregister
  interface semantics.
- Disabling signal delivery for non-ptrace requests is one of the options
  but will be a digression from x86 behaviour, or would require changes in x86
  code too. Even user-defined callback routines cannot deliver signal
  before instruction execution.

Considering all the above, we propose a behaviour that delivers the signal to
user-space after breakpoint execution. In due course, it will be good to have
ptrace on PPC64 follow the same behaviour.

Changelog - ver VIII
-------------------
- Reverting changes to allow one-shot breakpoints only for ptrace requests.
- Minor changes in sanity checking in arch_validate_hwbkpt_settings().
- put_cpu_no_resched() is no longer available. Converted to put_cpu().

Thanks,
K.Prasad

Previous changelogs
-------------------
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
