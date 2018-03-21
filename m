Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mMJ1J3KzF0Xp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:32:12 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 0/5] KVM & powerpc: Work around POWER9 TM hardware bugs
Date: Wed, 21 Mar 2018 21:31:58 +1100
Message-Id: <1521628323-14451-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series applies on top of my patch series "powerpc: Free up
CPU feature bits".

POWER9 has some shortcomings in its implementation of transactional
memory.  Starting with v2.2 of the "Nimbus" chip, some changes have
been made to the hardware which make it able to generate hypervisor
interrupts in the situations where hardware needs the hypervisor to
provide some assistance with the implementation.  Specifically, the
core does not have enough storage to store a complete checkpoint of
all the architected state for all 4 threads, and therefore needs to
be able to offload the checkpointed state of threads which are in
transactional suspended state (for threads that are in transactional
state, the hardware can simply abort the transaction).

This series implements the hypervisor assistance for TM for KVM
guests, thus allowing them to use TM.  This then means that we can
allow live migration of guests on POWER8 that may be using TM to
POWER9 hosts.

This version adds a feature bit for the XER[SO] bug workaround so that
it can be turned off on future systems which may still require
hypervisor assistance for TM but have the XER[SO] bug fixed.  It also
makes the test in the idle code (which includes a sync instruction)
conditional on the XER[SO] bug feature bit, meaning that the code to
force SMT4 mode will only work when that feature bit is set.

v2: The end result is the same as v1, but I avoid introducing a
compile error in the middle of the series.

Paul.

 arch/powerpc/include/asm/asm-prototypes.h |   3 +
 arch/powerpc/include/asm/cputable.h       |   7 +-
 arch/powerpc/include/asm/kvm_asm.h        |   2 +
 arch/powerpc/include/asm/kvm_book3s.h     |   4 +
 arch/powerpc/include/asm/kvm_book3s_64.h  |  43 ++++++
 arch/powerpc/include/asm/kvm_book3s_asm.h |   1 +
 arch/powerpc/include/asm/kvm_host.h       |   1 +
 arch/powerpc/include/asm/paca.h           |   3 +
 arch/powerpc/include/asm/powernv.h        |   1 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/reg.h            |   7 +
 arch/powerpc/kernel/asm-offsets.c         |   3 +
 arch/powerpc/kernel/cputable.c            |  23 +++-
 arch/powerpc/kernel/dt_cpu_ftrs.c         |   5 +
 arch/powerpc/kernel/exceptions-64s.S      |   4 +-
 arch/powerpc/kernel/idle_book3s.S         |  21 +++
 arch/powerpc/kvm/Makefile                 |   7 +
 arch/powerpc/kvm/book3s_hv.c              |  18 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 166 ++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_tm.c           | 216 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_tm_builtin.c   | 109 +++++++++++++++
 arch/powerpc/kvm/powerpc.c                |   5 +-
 arch/powerpc/platforms/powernv/idle.c     |  81 +++++++++++
 23 files changed, 720 insertions(+), 14 deletions(-)
