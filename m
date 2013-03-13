Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D985A2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:35:13 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Mar 2013 23:27:19 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DCFE3357804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:35:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2DDZ5HU655742
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:35:05 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2DDZ8gv014116
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 00:35:08 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V4 3/3] powerpc: rename USER_ESID_BITS* to ESID_BITS*
Date: Wed, 13 Mar 2013 19:04:55 +0530
Message-Id: <1363181695-5315-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1363181695-5315-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1363181695-5315-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Now we use ESID_BITS of kernel address to build proto vsid. So rename
USER_ESIT_BITS to ESID_BITS

Acked-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   16 ++++++++--------
 arch/powerpc/kernel/exceptions-64s.S  |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c |    4 ++--
 arch/powerpc/mm/pgtable_64.c          |    2 +-
 arch/powerpc/mm/slb_low.S             |    4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index a32461f..b59e06f 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -378,12 +378,12 @@ extern void slb_set_size(u16 size);
  */
 
 #define CONTEXT_BITS		19
-#define USER_ESID_BITS		18
-#define USER_ESID_BITS_1T	6
+#define ESID_BITS		18
+#define ESID_BITS_1T		6
 
 /*
  * 256MB segment
- * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
+ * The proto-VSID space has 2^(CONTEX_BITS + ESID_BITS) - 1 segments
  * available for user + kernel mapping. The top 4 contexts are used for
  * kernel mapping. Each segment contains 2^28 bytes. Each
  * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
@@ -396,15 +396,15 @@ extern void slb_set_size(u16 size);
  * doesn't overflow 64 bits. It should also be co-prime to vsid_modulus
  */
 #define VSID_MULTIPLIER_256M	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_256M		(CONTEXT_BITS + USER_ESID_BITS)
+#define VSID_BITS_256M		(CONTEXT_BITS + ESID_BITS)
 #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)
 
 #define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */
-#define VSID_BITS_1T		(CONTEXT_BITS + USER_ESID_BITS_1T)
+#define VSID_BITS_1T		(CONTEXT_BITS + ESID_BITS_1T)
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
 
 
-#define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
+#define USER_VSID_RANGE	(1UL << (ESID_BITS + SID_SHIFT))
 
 /*
  * This macro generates asm code to compute the VSID scramble
@@ -540,9 +540,9 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 		return 0;
 
 	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble((context << USER_ESID_BITS)
+		return vsid_scramble((context << ESID_BITS)
 				     | (ea >> SID_SHIFT), 256M);
-	return vsid_scramble((context << USER_ESID_BITS_1T)
+	return vsid_scramble((context << ESID_BITS_1T)
 			     | (ea >> SID_SHIFT_1T), 1T);
 }
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index aec4be9..3684cbd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1288,7 +1288,7 @@ _GLOBAL(do_stab_bolted)
 	addi	r9,r9,(MAX_USER_CONTEXT + 1)@l
 
 	srdi	r10,r11,SID_SHIFT
-	rldimi  r10,r9,USER_ESID_BITS,0 /* proto vsid */
+	rldimi  r10,r9,ESID_BITS,0 /* proto vsid */
 	ASM_VSID_SCRAMBLE(r10, r9, 256M)
 	rldic	r9,r10,12,16	/* r9 = vsid << 12 */
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index ead58e3..5d7d29a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -326,8 +326,8 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	vcpu3s->context_id[0] = err;
 
 	vcpu3s->proto_vsid_max = ((vcpu3s->context_id[0] + 1)
-				  << USER_ESID_BITS) - 1;
-	vcpu3s->proto_vsid_first = vcpu3s->context_id[0] << USER_ESID_BITS;
+				  << ESID_BITS) - 1;
+	vcpu3s->proto_vsid_first = vcpu3s->context_id[0] << ESID_BITS;
 	vcpu3s->proto_vsid_next = vcpu3s->proto_vsid_first;
 
 	kvmppc_mmu_hpte_init(vcpu);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e212a27..654258f 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -61,7 +61,7 @@
 #endif
 
 #ifdef CONFIG_PPC_STD_MMU_64
-#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
+#if TASK_SIZE_USER64 > (1UL << (ESID_BITS + SID_SHIFT))
 #error TASK_SIZE_USER64 exceeds user VSID range
 #endif
 #endif
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 77aafaa..17aa6df 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -232,7 +232,7 @@ _GLOBAL(slb_allocate_user)
  * r3 = EA, r9 = context, r10 = ESID, r11 = flags, clobbers r9, cr7 = <> PAGE_OFFSET
  */
 slb_finish_load:
-	rldimi  r10,r9,USER_ESID_BITS,0
+	rldimi  r10,r9,ESID_BITS,0
 	ASM_VSID_SCRAMBLE(r10,r9,256M)
 	/*
 	 * bits above VSID_BITS_256M need to be ignored from r10
@@ -301,7 +301,7 @@ _GLOBAL(slb_compare_rr_to_size)
  */
 slb_finish_load_1T:
 	srdi	r10,r10,(SID_SHIFT_1T - SID_SHIFT)	/* get 1T ESID */
-	rldimi  r10,r9,USER_ESID_BITS_1T,0
+	rldimi  r10,r9,ESID_BITS_1T,0
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
 	/*
 	 * bits above VSID_BITS_1T need to be ignored from r10
-- 
1.7.10
