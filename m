Return-Path: <tianyu.lan@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qN5sR27hvzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Mar 2016 14:27:06 +1100 (AEDT)
From: Lan Tianyu <tianyu.lan@intel.com>
To: agraf@suse.com, gleb@kernel.org, pbonzini@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 guangrong.xiao@linux.intel.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] KVM/PPC: update the comment of memory barrier in the
 kvmppc_prepare_to_enter()
Date: Sun, 13 Mar 2016 11:10:30 +0800
Message-Id: <1457838631-26775-8-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1457838631-26775-1-git-send-email-tianyu.lan@intel.com>
References: <1457838631-26775-1-git-send-email-tianyu.lan@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The barrier also orders the write to mode from any reads
to the page tables done and so update the comment.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 19aa59b..6a68730 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -96,6 +96,9 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 		 * so we don't miss a request because the requester sees
 		 * OUTSIDE_GUEST_MODE and assumes we'll be checking requests
 		 * before next entering the guest (and thus doesn't IPI).
+		 * This also orders the write to mode from any reads
+		 * to the page tables done while the VCPU is running.
+		 * Please see the comment in kvm_flush_remote_tlbs.
 		 */
 		smp_mb();
 
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
