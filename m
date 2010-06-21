Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id EC6BA1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Jun 2010 23:25:21 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Use kernel hash function
Date: Mon, 21 Jun 2010 15:25:19 +0200
Message-Id: <1277126719-32150-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The linux kernel already provides a hash function. Let's reuse that
instead of reinventing the wheel!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_32_mmu_host.c |   10 ++--------
 arch/powerpc/kvm/book3s_64_mmu_host.c |   11 ++---------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 0bb6600..37779a5 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/hash.h>
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -182,14 +183,7 @@ static int kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
  * a hash, so we don't waste cycles on looping */
 static u16 kvmppc_sid_hash(struct kvm_vcpu *vcpu, u64 gvsid)
 {
-	return (u16)(((gvsid >> (SID_MAP_BITS * 7)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 6)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 5)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 4)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 3)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 2)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 1)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 0)) & SID_MAP_MASK));
+	return hash_64(gvsid, SID_MAP_BITS);
 }
 
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index e4b5744..5d0e281 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/hash.h>
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -164,17 +165,9 @@ static int kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
  * a hash, so we don't waste cycles on looping */
 static u16 kvmppc_sid_hash(struct kvm_vcpu *vcpu, u64 gvsid)
 {
-	return (u16)(((gvsid >> (SID_MAP_BITS * 7)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 6)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 5)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 4)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 3)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 2)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 1)) & SID_MAP_MASK) ^
-		     ((gvsid >> (SID_MAP_BITS * 0)) & SID_MAP_MASK));
+	return hash_64(gvsid, SID_MAP_BITS);
 }
 
-
 static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 {
 	struct kvmppc_sid_map *map;
-- 
1.6.0.2
