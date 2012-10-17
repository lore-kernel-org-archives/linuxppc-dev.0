Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F6042C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 19:25:57 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Oct 2012 13:55:52 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9H8Pngu30867642
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 13:55:49 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9H8PmH5002267
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 19:25:49 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, schwab@linux-m68k.org,
 mikey@neuling.org
Subject: [PATCH -V2] powerpc: Build fix for powerpc KVM
Date: Wed, 17 Oct 2012 13:55:45 +0530
Message-Id: <1350462345-15785-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Fix build failure for powerpc KVM by adding missing VPN_SHIFT definition
and the ';'

arch/powerpc/kvm/book3s_32_mmu_host.c: In function 'kvmppc_mmu_map_page':
arch/powerpc/kvm/book3s_32_mmu_host.c:176: error: 'VPN_SHIFT' undeclared (first use in this function)
arch/powerpc/kvm/book3s_32_mmu_host.c:176: error: (Each undeclared identifier is reported only once
arch/powerpc/kvm/book3s_32_mmu_host.c:176: error: for each function it appears in.)
arch/powerpc/kvm/book3s_32_mmu_host.c:178: error: expected ';' before 'next_pteg'
arch/powerpc/kvm/book3s_32_mmu_host.c:190: error: label 'next_pteg' used but not defined
make[1]: *** [arch/powerpc/kvm/book3s_32_mmu_host.o] Error 1

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
