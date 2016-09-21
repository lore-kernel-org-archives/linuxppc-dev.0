Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBTf6wh9zDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:22 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id z123so16524403pfz.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/41] powerpc/64: use asm sections for head/exception
 layout
Date: Wed, 21 Sep 2016 17:43:26 +1000
Message-Id: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There should be no functional changes since the last patches, but I
did add some comments to the new head-64.h macros.

Thanks,
Nick

Nicholas Piggin (41):
  powerpc/64s: exception vector macros
  powerpc/64s: consolidate exception handler alignment
  powerpc/64: use gas sections for arranging exception vectors
  powerpc/64s: consolidate System Reset 0x100 interrupt
  powerpc/64s: consolidate Machine Check 0x200 interrupt
  powerpc/64s: consolidate Data Storage 0x300 interrupt
  powerpc/64s: consolidate Data Segment 0x380 interrupt
  powerpc/64s: consolidate Instruction Storage 0x400 interrupt
  powerpc/64s: consolidate Instruction Segment 0x480 interrupt
  powerpc/64s: consolidate External 0x500 interrupt
  powerpc/64s: consolidate Alignment 0x600 interrupt
  powerpc/64s: consolidate Program 0x700 interrupt
  powerpc/64s: consolidate FP Unavailable 0x800 interrupt
  powerpc/64s: consolidate Decrementer 0x900 interrupt
  powerpc/64s: consolidate Hypervisor Decrementer 0x980 interrupt
  powerpc/64s: consolidate Directed Privileged Doorbell 0xa00 interrupt
  powerpc/64s: consolidate Reserved 0xb00 interrupt
  powerpc/64s: consolidate System Call 0xc00 interrupt
  powerpc/64s: consolidate Trace 0xd00 interrupt
  powerpc/64s: consolidate Hypervisor Data Storage 0xe00 interrupt
  powerpc/64s: consolidate Hypervisor Instruction Storage 0xe20
    interrupt
  powerpc/64s: consolidate Hypervisor Emulation Assistance 0xe40
    interrupt
  powerpc/64s: consolidate Hypervisor Maintenance 0xe60 interrupt
  powerpc/64s: consolidate Directed Hypervisor Doorbell 0xe80 interrupt
  powerpc/64s: consolidate Hypervisor Virtualization 0xea0 interrupt
  powerpc/64s: consolidate Reserved 0xec0, 0xee0 interrupts
  powerpc/64s: consolidate Performance Monitor 0xf00 interrupt
  powerpc/64s: consolidate Vector Unavailable 0xf20 interrupt
  powerpc/64s: consolidate VSX Unavailable 0xf40 interrupt
  powerpc/64s: consolidate Facility Unavailable 0xf60 interrupt
  powerpc/64s: consolidate Hypervisor Facility Unavailable 0xf80
    interrupt
  powerpc/64s: consolidate Reserved 0xfa0-0x1200 interrupts
  powerpc/64s: consolidate CBE System Error 0x1200 interrupt
  powerpc/64s: consolidate Instruction Breakpoint 0x1300 interrupt
  powerpc/64s: consolidate Softpatch 0x1500 interrupt
  powerpc/64s: consolidate Debug 0x1600 interrupt
  powerpc/64s: consolidate Altivec 0x1700 interrupt
  powerpc/64s: consolidate CBE Thermal 0x1800 interrupt
  powerpc/64s: move __replay_interrupt function below handlers
  powerpc/64s: use single macro for both parts of OOL exception
  powerpc/64s: remove unused exception code, small cleanups

 arch/powerpc/include/asm/exception-64s.h |  135 +-
 arch/powerpc/include/asm/head-64.h       |  416 ++++++
 arch/powerpc/kernel/exceptions-64s.S     | 2070 +++++++++++++++---------------
 arch/powerpc/kernel/head_64.S            |   58 +-
 arch/powerpc/kernel/vmlinux.lds.S        |   45 +-
 5 files changed, 1550 insertions(+), 1174 deletions(-)
 create mode 100644 arch/powerpc/include/asm/head-64.h

-- 
2.9.3
