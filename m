Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DFAA2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:34 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Jul 2012 16:52:30 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6UBMQPT27394160
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 16:52:27 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6UBMPT2027654
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V5 11/13] arch/powerpc: properly isolate kernel and user
 proto-VSID
Date: Mon, 30 Jul 2012 16:52:17 +0530
Message-Id: <1343647339-25576-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The proto-VSID space is divided into two class
User:   0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1

With KERNEL_START at 0xc000000000000000, the proto vsid for
the kernel ends up with 0xc00000000 (36 bits). With 64TB
patchset we need to have kernel proto-VSID in the
[2^37 to 2^38 - 1] range due to the increased USER_ESID_BITS.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   16 +++++++++++++---
 arch/powerpc/kernel/exceptions-64s.S  |    4 +++-
 arch/powerpc/mm/slb_low.S             |   16 ++++++++++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index daa3e4b..8e97715 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -516,9 +516,19 @@ typedef struct {
 /* This is only valid for addresses >= PAGE_OFFSET */
 static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
-	if (ssize == MMU_SEGSIZE_256M)
-		return vsid_scramble(ea >> SID_SHIFT, 256M);
-	return vsid_scramble(ea >> SID_SHIFT_1T, 1T);
+	unsigned long proto_vsid;
+	/*
+	 * We need to make sure proto_vsid for the kernel is
+	 * >= 2^(CONTEXT_BITS + USER_ESID_BITS[_1T])
+	 */
+	if (ssize == MMU_SEGSIZE_256M) {
+		proto_vsid = ea >> SID_SHIFT;
+		proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS));
+		return vsid_scramble(proto_vsid, 256M);
+	}
+	proto_vsid = ea >> SID_SHIFT_1T;
+	proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS_1T));
+	return vsid_scramble(proto_vsid, 1T);
 }
 
 /* Returns the segment size indicator for a user address */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1c06d29..40ed208 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -958,7 +958,9 @@ _GLOBAL(do_stab_bolted)
 	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
 
 	/* Calculate VSID */
-	/* This is a kernel address, so protovsid = ESID */
+	/* This is a kernel address, so protovsid = ESID | 1 << 37 */
+	li	r9,0x1
+	rldimi  r11,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	ASM_VSID_SCRAMBLE(r11, r9, 256M)
 	rldic	r9,r11,12,16	/* r9 = vsid << 12 */
 
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index db2cb3f..405d380 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -57,8 +57,16 @@ _GLOBAL(slb_allocate_realmode)
 _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
 BEGIN_FTR_SECTION
+	li	r9,0x1
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
+	li	r9,0x1
+	/*
+	 * shift 12 bits less here, slb_finish_load_1T will do
+	 * the necessary shits
+	 */
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	b	slb_finish_load_1T
 
 1:
@@ -86,8 +94,16 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 	li	r11,0
 6:
 BEGIN_FTR_SECTION
+	li	r9,0x1
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	b	slb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
+	li	r9,0x1
+	/*
+	 * shift 12 bits less here, slb_finish_load_1T will do
+	 * the necessary shits
+	 */
+	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
 	b	slb_finish_load_1T
 
 0:	/* user address: proto-VSID = context << 15 | ESID. First check
-- 
1.7.10
