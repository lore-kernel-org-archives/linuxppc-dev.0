Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4928A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 23:15:57 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Oct 2012 22:13:24 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9GC5qD262980326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 23:05:53 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9GCFmXI012301
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2012 23:15:49 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, schwab@linux-m68k.org
Subject: [PATCH] powerpc: Build fix for powerpc KVM
Date: Tue, 16 Oct 2012 17:45:44 +0530
Message-Id: <1350389744-24627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Fix build failure for powerpc KVM

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_32.h |    1 +
 arch/powerpc/kvm/book3s_32_mmu_host.c    |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_32.h b/arch/powerpc/include/asm/kvm_book3s_32.h
index 38040ff..ce0ef6c 100644
--- a/arch/powerpc/include/asm/kvm_book3s_32.h
+++ b/arch/powerpc/include/asm/kvm_book3s_32.h
@@ -42,5 +42,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 #define SID_SHIFT	28
 #define ESID_MASK	0xf0000000
 #define VSID_MASK	0x00fffffff0000000ULL
+#define VPN_SHIFT	12
 
 #endif /* __ASM_KVM_BOOK3S_32_H__ */
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 00aa612..b0f625a 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -173,8 +173,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	BUG_ON(!map);
 
 	vsid = map->host_vsid;
-	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)
-
+	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) |
+		((eaddr & ~ESID_MASK) >> VPN_SHIFT);
 next_pteg:
 	if (rr == 16) {
 		primary = !primary;
-- 
1.7.10
