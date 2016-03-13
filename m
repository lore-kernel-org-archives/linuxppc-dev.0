Return-Path: <tianyu.lan@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qN5s73glrzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Mar 2016 14:26:50 +1100 (AEDT)
From: Lan Tianyu <tianyu.lan@intel.com>
To: pbonzini@redhat.com, guangrong.xiao@linux.intel.com, agraf@suse.com,
 benh@kernel.crashing.org, gleb@kernel.org, hpa@zytor.com,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, tglx@linutronix.de, x86@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 0/7] KVM/X86/PPC: Clear up kvm mmu memory barriers and update
 related comments
Date: Sun, 13 Mar 2016 11:10:23 +0800
Message-Id: <1457838631-26775-1-git-send-email-tianyu.lan@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is to clear up kvm mmu memory barriers.
1) Remove redundant barrier (PATCH 1)
2) Replace origin barrier functions with preferrable ones (PATCH 2, 3, 5)
3) Fix unpaired barriers (PATCH 4)
4) Update or add barrier related comments (PATCH 6, 7)

Lan Tianyu (7):
  KVM: Remove redundant smp_mb() in the kvm_mmu_commit_zap_page()
  KVM/x86: Replace smp_mb() with smp_store_mb/release() in the
    walk_shadow_page_lockless_begin/end()
  KVM: Replace smp_mb() with smp_mb_after_atomic() in the
    kvm_make_all_cpus_request()
  KVM/x86: Call smp_wmb() before increasing tlbs_dirty
  KVM: Replace smp_mb() with smp_load_acquire() in the
    kvm_flush_remote_tlbs()
  KVM/x86: update the comment of memory barrier in the
    vcpu_enter_guest()
  KVM/PPC:  update the comment of memory barrier in the
    kvmppc_prepare_to_enter()

 arch/powerpc/kvm/powerpc.c |  3 +++
 arch/x86/kvm/mmu.c         | 23 ++++++++++-------------
 arch/x86/kvm/paging_tmpl.h | 11 +++++++++++
 arch/x86/kvm/x86.c         |  8 ++++++--
 virt/kvm/kvm_main.c        | 22 ++++++++++++++++++----
 5 files changed, 48 insertions(+), 19 deletions(-)

-- 
1.8.4.rc0.1.g8f6a3e5.dirty
