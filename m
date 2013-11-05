Return-Path: <kernelfans@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEBE72C034E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 18:42:25 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id kp14so8202814pab.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2013 23:42:23 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 2/3] powerpc/kvm: fix rare but potential deadlock scene
Date: Tue,  5 Nov 2013 15:42:43 +0800
Message-Id: <1383637364-14691-2-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
realmode, so it can trigger the deadlock.

Suppose the following scene:

Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of vcpus.

If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched out,
and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be caught in
realmode for a long time.

What makes things even worse if the following happens,
  On cpuM, bitlockX is hold, on cpuN, Y is hold.
  vcpu_B_2 try to lock Y on cpuM in realmode
  vcpu_A_2 try to lock X on cpuN in realmode

Oops! deadlock happens

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 043eec8..28160ac 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -474,8 +474,10 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	}
 
 	/* Find the HPTE in the hash table */
+	preempt_disable();
 	index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
 					 HPTE_V_VALID | HPTE_V_ABSENT);
+	preempt_enable();
 	if (index < 0)
 		return -ENOENT;
 	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
-- 
1.8.1.4
