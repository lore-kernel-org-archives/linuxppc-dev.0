Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A4552C02F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 23:09:06 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Mar 2013 17:35:29 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 60F41125804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 17:40:00 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2CC8rXx13566064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 17:38:54 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2CC8uta025220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 23:08:56 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V3 3/3] powerpc: rename USER_ESID_BITS* to ESID_BITS*
Date: Tue, 12 Mar 2013 17:38:51 +0530
Message-Id: <1363090131-14545-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1363090131-14545-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1363090131-14545-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   16 ++++++++--------
 arch/powerpc/kernel/exceptions-64s.S  |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c |    4 ++--
 arch/powerpc/mm/pgtable_64.c          |    2 +-
 arch/powerpc/mm/slb_low.S             |    4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 90f0ab1..c322100 100644
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
index c90dec0..1b7c73a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1288,7 +1288,7 @@ _GLOBAL(do_stab_bolted)
 	subi	r9,r9,4		/* context */
 
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
index 946c617..9e44b58 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -231,7 +231,7 @@ _GLOBAL(slb_allocate_user)
  * r3 = EA, r9 = context, r10 = ESID, r11 = flags, clobbers r9, cr7 = <> PAGE_OFFSET
  */
 slb_finish_load:
-	rldimi  r10,r9,USER_ESID_BITS,0
+	rldimi  r10,r9,ESID_BITS,0
 	ASM_VSID_SCRAMBLE(r10,r9,256M)
 	/*
 	 * bits above VSID_BITS_256M need to be ignored from r10
@@ -300,7 +300,7 @@ _GLOBAL(slb_compare_rr_to_size)
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
