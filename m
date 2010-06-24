Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6C85B6F16
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 05:44:20 +1000 (EST)
Date: Thu, 24 Jun 2010 19:44:15 +0000
From: Denis Kirjanov <dkirjanov@hera.kernel.org>
To: agraf@suse.de
Subject: [PATCH] kvm/ppc: fix build warning
Message-ID: <20100624194415.GA24107@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mtosatti@redhat.com, avi@redhat.com, kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix build warning:
arch/powerpc/kvm/book3s_64_mmu.c: In function 'kvmppc_mmu_book3s_64_esid_to_vsid':
arch/powerpc/kvm/book3s_64_mmu.c:446: warning: 'slb' may be used uninitialized in this function
Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
arch/powerpc/kvm/book3s_64_mmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 4025ea2..61f2621 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -443,7 +443,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 					     u64 *vsid)
 {
 	ulong ea = esid << SID_SHIFT;
-	struct kvmppc_slb *slb;
+	struct kvmppc_slb *uninitialized_var(slb);
 	u64 gvsid = esid;
 
 	if (vcpu->arch.msr & (MSR_DR|MSR_IR)) {
