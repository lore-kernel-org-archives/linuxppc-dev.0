Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29241B7234
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 11/26] KVM: PPC: Revert "KVM: PPC: Use kernel hash function"
Date: Tue, 17 Aug 2010 15:57:46 +0200
Message-Id: <1282053481-18787-12-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
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

It turns out the in-kernel hash function is sub-optimal for our subtle
hash inputs where every bit is significant. So let's revert to the original
hash functions.

This reverts commit 05340ab4f9a6626f7a2e8f9fe5397c61d494f445.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_32_mmu_host.c |   10 ++++++++--
 arch/powerpc/kvm/book3s_64_mmu_host.c |   11 +++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 343452c..57dddeb 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/kvm_host.h>
-#include <linux/hash.h>
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -77,7 +76,14 @@ void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
  * a hash, so we don't waste cycles on looping */
 static u16 kvmppc_sid_hash(struct kvm_vcpu *vcpu, u64 gvsid)
 {
-	return hash_64(gvsid, SID_MAP_BITS);
+	return (u16)(((gvsid >> (SID_MAP_BITS * 7)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 6)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 5)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 4)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 3)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 2)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 1)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 0)) & SID_MAP_MASK));
 }
 
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 321c931..e7c4d00 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/kvm_host.h>
-#include <linux/hash.h>
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -44,9 +43,17 @@ void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
  * a hash, so we don't waste cycles on looping */
 static u16 kvmppc_sid_hash(struct kvm_vcpu *vcpu, u64 gvsid)
 {
-	return hash_64(gvsid, SID_MAP_BITS);
+	return (u16)(((gvsid >> (SID_MAP_BITS * 7)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 6)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 5)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 4)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 3)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 2)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 1)) & SID_MAP_MASK) ^
+		     ((gvsid >> (SID_MAP_BITS * 0)) & SID_MAP_MASK));
 }
 
+
 static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 {
 	struct kvmppc_sid_map *map;
-- 
1.6.0.2
