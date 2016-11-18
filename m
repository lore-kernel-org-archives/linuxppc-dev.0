Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqNy5dzJzDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:50 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 00/13] KVM: PPC: Support POWER9 guests
Date: Fri, 18 Nov 2016 18:28:29 +1100
Message-Id: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches adds support to HV KVM for running KVM guests
on POWER9 systems.  This allows us to run KVM guests that use HPT
(hashed page table) address translation and know about the POWER9
processor.  With this, Suraj Jitindar Singh's recent patch series
"powerpc: add support for ISA v2.07 compat level" and suitable changes
to the user-mode driver will allow us to run guests on POWER9 in
POWER8 (or POWER7) compatibility mode.

For now we require the host to be in HPT mode (not radix).

This series of patches is based on v4.9-rc4 plus my patch "powerpc/64:
Simplify adaptation to new ISA v3.00 HPTE format" and Yongji Xie's
two-patch series "KVM: PPC: Book3S HV: Optimize for MMIO emulation".

Paul.
---
 Documentation/virtual/kvm/api.txt              |   2 +
 arch/powerpc/include/asm/kvm_host.h            |   3 +
 arch/powerpc/include/asm/kvm_ppc.h             |   7 +-
 arch/powerpc/include/asm/mmu.h                 |   5 +
 arch/powerpc/include/asm/opal.h                |   3 +
 arch/powerpc/include/asm/reg.h                 |   5 +
 arch/powerpc/include/uapi/asm/kvm.h            |   4 +
 arch/powerpc/kernel/asm-offsets.c              |   3 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c            |  39 +++++--
 arch/powerpc/kvm/book3s_hv.c                   | 140 ++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_builtin.c           |  69 +++++++++---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c            | 113 ++++++++++++++------
 arch/powerpc/kvm/book3s_hv_rm_xics.c           |  23 ++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        | 132 ++++++++++++++++-------
 arch/powerpc/kvm/powerpc.c                     |  11 +-
 arch/powerpc/mm/hash_utils_64.c                |  28 +----
 arch/powerpc/mm/pgtable-radix.c                |  18 ++--
 arch/powerpc/mm/pgtable_64.c                   |  33 ++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
 arch/powerpc/platforms/powernv/opal.c          |   2 +
 20 files changed, 483 insertions(+), 160 deletions(-)
