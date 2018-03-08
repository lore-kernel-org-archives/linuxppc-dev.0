Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxhKY6MZqzF1l8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 18:02:41 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH RFC 0/5] powerpc & KVM: Work around POWER9 TM hardware bugs
Date: Thu,  8 Mar 2018 18:02:26 +1100
Message-Id: <1520492551-799-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

 arch/powerpc/include/asm/asm-prototypes.h |   3 +
 arch/powerpc/include/asm/cputable.h       |   5 +-
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
 arch/powerpc/kernel/dt_cpu_ftrs.c         |   3 +
 arch/powerpc/kernel/exceptions-64s.S      |   4 +-
 arch/powerpc/kernel/idle_book3s.S         |  19 +++
 arch/powerpc/kvm/Makefile                 |   7 +
 arch/powerpc/kvm/book3s_hv.c              |  18 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 150 ++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_tm.c           | 216 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_tm_builtin.c   | 109 +++++++++++++++
 arch/powerpc/kvm/powerpc.c                |   5 +-
 arch/powerpc/platforms/powernv/idle.c     |  77 +++++++++++
 23 files changed, 694 insertions(+), 14 deletions(-)
