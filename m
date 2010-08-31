Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id A6AACB7105
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 05/35] KVM: PPC: Fix sid map search after flush
Date: Tue, 31 Aug 2010 04:31:46 +0200
Message-Id: <1283221937-21006-6-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After a flush the sid map contained lots of entries with 0 for their gvsid and
hvsid value. Unfortunately, 0 can be a real value the guest searches for when
looking up a vsid so it would incorrectly find the host's 0 hvsid mapping which
doesn't belong to our sid space.

So let's also check for the valid bit that indicated that the sid we're
looking at actually contains useful data.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index aa516ad..ebb1b5d 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -65,14 +65,14 @@ static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 
 	sid_map_mask = kvmppc_sid_hash(vcpu, gvsid);
 	map = &to_book3s(vcpu)->sid_map[sid_map_mask];
-	if (map->guest_vsid == gvsid) {
+	if (map->valid && (map->guest_vsid == gvsid)) {
 		dprintk_slb("SLB: Searching: 0x%llx -> 0x%llx\n",
 			    gvsid, map->host_vsid);
 		return map;
 	}
 
 	map = &to_book3s(vcpu)->sid_map[SID_MAP_MASK - sid_map_mask];
-	if (map->guest_vsid == gvsid) {
+	if (map->valid && (map->guest_vsid == gvsid)) {
 		dprintk_slb("SLB: Searching 0x%llx -> 0x%llx\n",
 			    gvsid, map->host_vsid);
 		return map;
-- 
1.6.0.2
