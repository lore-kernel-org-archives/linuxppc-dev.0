Return-Path: <geyslan@gmail.com>
Received: from mail-qg0-x243.google.com (mail-qg0-x243.google.com
 [IPv6:2607:f8b0:400d:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 210731A0BC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 10:43:53 +1100 (AEDT)
Received: by qgea14 with SMTP id a14so1948367qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2015 15:43:50 -0800 (PST)
From: "Geyslan G. Bem" <geyslan@gmail.com>
To: 
Cc: "Geyslan G. Bem" <geyslan@gmail.com>, Alexander Graf <agraf@suse.com>,
 Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: remove unused variable 'vcpu_book3s'
Date: Tue,  1 Dec 2015 20:42:10 -0300
Message-Id: <1449013410-19103-1-git-send-email-geyslan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The vcpu_book3s struct is assigned but never used. So remove it.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 774a253..9bf7031 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -377,15 +377,12 @@ no_seg_found:
 
 static void kvmppc_mmu_book3s_64_slbmte(struct kvm_vcpu *vcpu, u64 rs, u64 rb)
 {
-	struct kvmppc_vcpu_book3s *vcpu_book3s;
 	u64 esid, esid_1t;
 	int slb_nr;
 	struct kvmppc_slb *slbe;
 
 	dprintk("KVM MMU: slbmte(0x%llx, 0x%llx)\n", rs, rb);
 
-	vcpu_book3s = to_book3s(vcpu);
-
 	esid = GET_ESID(rb);
 	esid_1t = GET_ESID_1T(rb);
 	slb_nr = rb & 0xfff;
-- 
2.6.2
