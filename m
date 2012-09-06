Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B605F2C0455
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 01:30:03 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 01:29:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q86FKUf928508312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 01:20:30 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q86FTdQg006195
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 01:29:39 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V8 11/11] arch/powerpc: Update VSID allocation documentation
Date: Thu,  6 Sep 2012 20:59:11 +0530
Message-Id: <1346945351-7672-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This update the proto-VSID and VSID scramble related information
to be more generic by using names instead of current values.

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |   40 ++++++++++++++-------------------
 arch/powerpc/mm/mmu_context_hash64.c  |    8 ++++---
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index de9cfed..428f23e 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -324,51 +324,45 @@ extern void slb_set_size(u16 size);
 #endif /* __ASSEMBLY__ */
 
 /*
- * VSID allocation
+ * VSID allocation (256MB segment)
  *
- * We first generate a 36-bit "proto-VSID".  For kernel addresses this
- * is equal to the ESID, for user addresses it is:
- *	(context << 15) | (esid & 0x7fff)
+ * We first generate a 38-bit "proto-VSID".  For kernel addresses this
+ * is equal to the ESID | 1 << 37, for user addresses it is:
+ *	(context << USER_ESID_BITS) | (esid & ((1U << USER_ESID_BITS) - 1)
  *
- * The two forms are distinguishable because the top bit is 0 for user
- * addresses, whereas the top two bits are 1 for kernel addresses.
- * Proto-VSIDs with the top two bits equal to 0b10 are reserved for
- * now.
+ * This splits the proto-VSID into the below range
+ *  0 - (2^(CONTEXT_BITS + USER_ESID_BITS) - 1) : User proto-VSID range
+ *  2^(CONTEXT_BITS + USER_ESID_BITS) - 2^(VSID_BITS) : Kernel proto-VSID range
+ *
+ * We also have CONTEXT_BITS + USER_ESID_BITS = VSID_BITS - 1
+ * That is, we assign half of the space to user processes and half
+ * to the kernel.
  *
  * The proto-VSIDs are then scrambled into real VSIDs with the
  * multiplicative hash:
  *
  *	VSID = (proto-VSID * VSID_MULTIPLIER) % VSID_MODULUS
- *	where	VSID_MULTIPLIER = 268435399 = 0xFFFFFC7
- *		VSID_MODULUS = 2^36-1 = 0xFFFFFFFFF
  *
- * This scramble is only well defined for proto-VSIDs below
- * 0xFFFFFFFFF, so both proto-VSID and actual VSID 0xFFFFFFFFF are
- * reserved.  VSID_MULTIPLIER is prime, so in particular it is
+ * VSID_MULTIPLIER is prime, so in particular it is
  * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
  * Because the modulus is 2^n-1 we can compute it efficiently without
  * a divide or extra multiply (see below).
  *
  * This scheme has several advantages over older methods:
  *
- * 	- We have VSIDs allocated for every kernel address
+ *	- We have VSIDs allocated for every kernel address
  * (i.e. everything above 0xC000000000000000), except the very top
  * segment, which simplifies several things.
  *
- *	- We allow for 16 significant bits of ESID and 19 bits of
- * context for user addresses.  i.e. 16T (44 bits) of address space for
- * up to half a million contexts.
+ *	- We allow for USER_ESID_BITS significant bits of ESID and
+ * CONTEXT_BITS  bits of context for user addresses.
+ *  i.e. 64T (46 bits) of address space for up to half a million contexts.
  *
- * 	- The scramble function gives robust scattering in the hash
+ *	- The scramble function gives robust scattering in the hash
  * table (at least based on some initial results).  The previous
  * method was more susceptible to pathological cases giving excessive
  * hash collisions.
  */
-/*
- * WARNING - If you change these you must make sure the asm
- * implementations in slb_allocate (slb_low.S), do_stab_bolted
- * (head.S) and ASM_VSID_SCRAMBLE (below) are changed accordingly.
- */
 
 /*
  * This should be computed such that protovosid * vsid_mulitplier
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index daa076c..40bc5b0 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -30,9 +30,11 @@ static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
 /*
- * The proto-VSID space has 2^35 - 1 segments available for user mappings.
- * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
- * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
+ * 256MB segment
+ * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
+ * available for user mappings. Each segment contains 2^28 bytes. Each
+ * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
+ * (19 == 37 + 28 - 46).
  */
 #define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
 
-- 
1.7.10
