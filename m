Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc265qfBzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 00/42] powerpc/64: use asm sections for head/exception
 layout
Date: Wed,  5 Oct 2016 11:22:22 +1100
Message-Id: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v3 of Nick's series to change the way we construct the 64-bit Book3S
exception vectors, as applied to the tree by me.

Changes since his v2 are:
 - macro names have been shortened to EXC_REAL() etc.
 - the end macros which were empty have been dropped (until/if we need them)
 - some minor fixes for older toolchains.

Any bugs introduced since v2 are mine :)

cheers

Nicholas Piggin (42):
  powerpc/64s: Add new exception vector macros
  powerpc/64s: Consolidate exception handler alignment
  powerpc/64: Change the way relocation copy is calculated
  powerpc: Use gas sections for arranging exception vectors
  powerpc/64s: Consolidate System Reset 0x100 interrupt
  powerpc/64s: Consolidate Machine Check 0x200 interrupt
  powerpc/64s: Consolidate Data Storage 0x300 interrupt
  powerpc/64s: Consolidate Data Segment 0x380 interrupt
  powerpc/64s: Consolidate Instruction Storage 0x400 interrupt
  powerpc/64s: Consolidate Instruction Segment 0x480 interrupt
  powerpc/64s: Consolidate External 0x500 interrupt
  powerpc/64s: Consolidate Alignment 0x600 interrupt
  powerpc/64s: Consolidate Program 0x700 interrupt
  powerpc/64s: Consolidate FP Unavailable 0x800 interrupt
  powerpc/64s: Consolidate Decrementer 0x900 interrupt
  powerpc/64s: Consolidate Hypervisor Decrementer 0x980 interrupt
  powerpc/64s: Consolidate Directed Privileged Doorbell 0xa00 interrupt
  powerpc/64s: Consolidate Reserved 0xb00 interrupt
  powerpc/64s: Consolidate System Call 0xc00 interrupt
  powerpc/64s: Consolidate Trace 0xd00 interrupt
  powerpc/64s: Consolidate Hypervisor Data Storage 0xe00 interrupt
  powerpc/64s: Consolidate Hypervisor Instruction Storage 0xe20 interrupt
  powerpc/64s: Consolidate Hypervisor Emulation Assistance 0xe40 interrupt
  powerpc/64s: Consolidate Hypervisor Maintenance 0xe60 interrupt
  powerpc/64s: Consolidate Directed Hypervisor Doorbell 0xe80 interrupt
  powerpc/64s: Consolidate Hypervisor Virtualization 0xea0 interrupt
  powerpc/64s: Consolidate Reserved 0xec0, 0xee0 interrupts
  powerpc/64s: Consolidate Performance Monitor 0xf00 interrupt
  powerpc/64s: Consolidate Vector Unavailable 0xf20 interrupt
  powerpc/64s: Consolidate VSX Unavailable 0xf40 interrupt
  powerpc/64s: Consolidate Facility Unavailable 0xf60 interrupt
  powerpc/64s: Consolidate Hypervisor Facility Unavailable 0xf80 interrupt
  powerpc/64s: Consolidate Reserved 0xfa0-0x1200 interrupts
  powerpc/64s: Consolidate CBE System Error 0x1200 interrupt
  powerpc/64s: Consolidate Instruction Breakpoint 0x1300 interrupt
  powerpc/64s: Consolidate Softpatch 0x1500 interrupt
  powerpc/64s: Consolidate Debug 0x1600 interrupt
  powerpc/64s: Consolidate Altivec 0x1700 interrupt
  powerpc/64s: Consolidate CBE Thermal 0x1800 interrupt
  powerpc/64s: Move __replay_interrupt function below handlers
  powerpc/64s: Use a single macro for both parts of OOL exception
  powerpc/64s: Remove unused exception code, small cleanups

 arch/powerpc/include/asm/exception-64s.h |  137 +-
 arch/powerpc/include/asm/head-64.h       |  393 ++++++
 arch/powerpc/kernel/exceptions-64s.S     | 2069 +++++++++++++++---------------
 arch/powerpc/kernel/head_64.S            |   53 +-
 arch/powerpc/kernel/vmlinux.lds.S        |   53 +-
 5 files changed, 1538 insertions(+), 1167 deletions(-)
 create mode 100644 arch/powerpc/include/asm/head-64.h

-- 
2.7.4
