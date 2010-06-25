Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 81757100812
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 11/26] KVM: PPC: Make RMO a define
Date: Sat, 26 Jun 2010 01:24:59 +0200
Message-Id: <1277508314-915-12-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerPC it's very normal to not support all of the physical RAM in real mode.
To check if we're matching on the shared page or not, we need to know the limits
so we can restrain ourselves to that range.

So let's make it a define instead of open-coding it. And while at it, let's also
increase it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    2 ++
 arch/powerpc/kvm/book3s.c           |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 83c45ea..e35c1ac 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -47,6 +47,8 @@
 #define HPTEG_HASH_NUM_VPTE		(1 << HPTEG_HASH_BITS_VPTE)
 #define HPTEG_HASH_NUM_VPTE_LONG	(1 << HPTEG_HASH_BITS_VPTE_LONG)
 
+#define KVM_RMO			0x0fffffffffffffffULL
+
 struct kvm;
 struct kvm_run;
 struct kvm_vcpu;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index e76c950..2f55aa5 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -462,7 +462,7 @@ static int kvmppc_xlate(struct kvm_vcpu *vcpu, ulong eaddr, bool data,
 		r = vcpu->arch.mmu.xlate(vcpu, eaddr, pte, data);
 	} else {
 		pte->eaddr = eaddr;
-		pte->raddr = eaddr & 0xffffffff;
+		pte->raddr = eaddr & KVM_RMO;
 		pte->vpage = VSID_REAL | eaddr >> 12;
 		pte->may_read = true;
 		pte->may_write = true;
@@ -576,7 +576,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		pte.may_execute = true;
 		pte.may_read = true;
 		pte.may_write = true;
-		pte.raddr = eaddr & 0xffffffff;
+		pte.raddr = eaddr & KVM_RMO;
 		pte.eaddr = eaddr;
 		pte.vpage = eaddr >> 12;
 	}
-- 
1.6.0.2
