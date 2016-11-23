Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvx0BqVzDw1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:13 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 00/11] KVM: PPC: Book3S HV: Support KVM guests on POWER9
Date: Wed, 23 Nov 2016 11:31:54 +1100
Message-Id: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
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
processor.  With suitable changes to the user-mode driver, this can
also run guests on POWER9 in POWER8 or POWER7 compatibility mode.

For now we require the host to be in HPT mode (not radix).

This series of patches is based on the ppc-kvm topic branch from the
powerpc tree merged with my current kvm-ppc-next tree.

Paul.
---
 Documentation/virtual/kvm/api.txt       |   2 +
 arch/powerpc/include/asm/kvm_asm.h      |   1 +
 arch/powerpc/include/asm/kvm_host.h     |   3 +
 arch/powerpc/include/asm/kvm_ppc.h      |   7 +-
 arch/powerpc/include/uapi/asm/kvm.h     |   4 +
 arch/powerpc/kernel/asm-offsets.c       |   3 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c     |  39 ++++--
 arch/powerpc/kvm/book3s_hv.c            | 203 ++++++++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv_builtin.c    |  69 +++++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     | 111 +++++++++++------
 arch/powerpc/kvm/book3s_hv_rm_xics.c    |  23 +++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 136 ++++++++++++++-------
 arch/powerpc/kvm/powerpc.c              |  11 +-
 13 files changed, 468 insertions(+), 144 deletions(-)
