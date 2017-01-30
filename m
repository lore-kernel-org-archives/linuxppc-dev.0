Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBln86fgCzDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:04 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 00/20] Support for radix guest and host on POWER9
Date: Mon, 30 Jan 2017 21:21:33 +1100
Message-Id: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The primary purpose of this patch series is to make it possible to run
a guest on POWER9 using the radix MMU under a KVM host that also uses
the radix MMU.  To do this, the guest needs to say that it supports
radix in the ibm,client-architecture-support vector, and if the host
agrees, the guest then needs to call the new H_REGISTER_PROCESS_TABLE
hypercall to tell the hypervisor where its process table is (the
process table contains pointers to the radix trees for each process).

On the host side, we add new KVM interfaces for userspace (e.g. QEMU)
to use to know whether the host supports radix guest, HPT guests, or
both, and for userspace to use to implement H_REGISTER_PROCESS_TABLE.
There are two new capabilities and two new ioctls.  These are added in
patch 8/20.

The host then needs to be able to construct the second-level radix
tree ("partition-scoped" in architecturese) which maps guest real
addresses to host real addresses.  We add PTEs to this table on
hypervisor page faults and remove them in response to MMU notifier
callbacks.

The patch series also includes some improvements for HPT guests
running under a HPT host.

Currently, the MMU type of the guest (radix or HPT) must be the same
as the host.  That is, if the host is booted in radix mode, it can
only run radix guests.  If the host is booted in HPT mode (e.g. by
putting "disable_radix" on the kernel command line), it can only run
HPT guests.

The patch series is against 4.10-rc4.

Differences since v1:

- Added TLB flushing when a vcpu moves from one physical CPU to
another.

- Guest exit path can now have the MMU on, meaning that the
guest can now use relocation-on interrupts.

- Added workarounds for the POWER9 DD1 chip.

- Use kvm_is_radix(kvm) consistently.

Paul.
---
 Documentation/virtual/kvm/api.txt         |  83 ++++
 arch/powerpc/include/asm/book3s/64/mmu.h  |  14 +-
 arch/powerpc/include/asm/exception-64s.h  |  10 +-
 arch/powerpc/include/asm/hvcall.h         |  11 +
 arch/powerpc/include/asm/kvm_book3s.h     |  26 +-
 arch/powerpc/include/asm/kvm_book3s_64.h  |   6 +
 arch/powerpc/include/asm/kvm_host.h       |   6 +
 arch/powerpc/include/asm/kvm_ppc.h        |   2 +
 arch/powerpc/include/asm/prom.h           |  17 +-
 arch/powerpc/include/asm/reg.h            |   4 +
 arch/powerpc/include/uapi/asm/kvm.h       |  20 +
 arch/powerpc/kernel/asm-offsets.c         |   2 +
 arch/powerpc/kernel/exceptions-64s.S      |  53 ++-
 arch/powerpc/kernel/prom_init.c           |  18 +-
 arch/powerpc/kvm/Makefile                 |   3 +-
 arch/powerpc/kvm/book3s.c                 |   1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c       | 110 +++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c    | 716 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c              | 205 ++++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c      |  38 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  25 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |   8 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 138 +++++-
 arch/powerpc/kvm/powerpc.c                |  32 ++
 arch/powerpc/mm/init-common.c             |   3 +-
 arch/powerpc/mm/init_64.c                 |  35 ++
 arch/powerpc/mm/pgtable-radix.c           |   2 +
 arch/powerpc/mm/pgtable_64.c              |  16 +-
 arch/powerpc/platforms/pseries/firmware.c |   2 +-
 arch/powerpc/platforms/pseries/lpar.c     |  29 ++
 include/uapi/linux/kvm.h                  |   6 +
 31 files changed, 1490 insertions(+), 151 deletions(-)
