Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03EB5B711D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:14 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 11/27] KVM: PPC: Make PAM a define
Date: Thu, 29 Jul 2010 14:47:52 +0200
Message-Id: <1280407688-9815-12-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
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

v2 -> v3:

  - RMO -> PAM (non-magic page)
---
 arch/powerpc/include/asm/kvm_host.h |    3 +++
 arch/powerpc/kvm/book3s.c           |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 221cf85..1674da8 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -48,6 +48,9 @@
 #define HPTEG_HASH_NUM_VPTE		(1 << HPTEG_HASH_BITS_VPTE)
 #define HPTEG_HASH_NUM_VPTE_LONG	(1 << HPTEG_HASH_BITS_VPTE_LONG)
 
+/* Physical Address Mask - allowed range of real mode RAM access */
+#define KVM_PAM			0x0fffffffffffffffULL
+
 struct kvm;
 struct kvm_run;
 struct kvm_vcpu;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 06229fe..0ed5376 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -465,7 +465,7 @@ static int kvmppc_xlate(struct kvm_vcpu *vcpu, ulong eaddr, bool data,
 		r = vcpu->arch.mmu.xlate(vcpu, eaddr, pte, data);
 	} else {
 		pte->eaddr = eaddr;
-		pte->raddr = eaddr & 0xffffffff;
+		pte->raddr = eaddr & KVM_PAM;
 		pte->vpage = VSID_REAL | eaddr >> 12;
 		pte->may_read = true;
 		pte->may_write = true;
@@ -579,7 +579,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		pte.may_execute = true;
 		pte.may_read = true;
 		pte.may_write = true;
-		pte.raddr = eaddr & 0xffffffff;
+		pte.raddr = eaddr & KVM_PAM;
 		pte.eaddr = eaddr;
 		pte.vpage = eaddr >> 12;
 	}
-- 
1.6.0.2
