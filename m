Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17986.44428.934539.499645@cargo.ozlabs.ibm.com>
Date: Thu, 10 May 2007 15:28:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Generalize hpte_decode()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the necessary support to hpte_decode() to handle 1TB
segments and 16GB pages, and also removes an uninitialized value
warning on avpn.

We don't have any code to generate HPTEs for 1TB segments or 16GB
pages yet, so this is mostly for completeness, and also to fix the
warning.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 7b7fe2d..7d722ee 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -376,31 +376,28 @@ static void hpte_decode(hpte_t *hpte, unsigned long slot,
 		}
 	}
 
-	/*
-	 * FIXME, the code below works for 16M, 64K, and 4K pages as these
-	 * fall under the p<=23 rules for calculating the virtual address.
-	 * In the case of 16M pages, an extra bit is stolen from the AVPN
-	 * field to achieve the requisite 24 bits.
-	 *
-	 * Does not work for 16G pages or 1 TB segments.
-	 */
+	/* This works for all page sizes, and for 256M and 1T segments */
 	shift = mmu_psize_defs[size].shift;
-	if (mmu_psize_defs[size].avpnm)
-		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
-	else
-		avpnm_bits = 0;
-	if (shift - avpnm_bits <= 23) {
-		avpn = HPTE_V_AVPN_VAL(hpte_v) << 23;
+	avpn = (HPTE_V_AVPN_VAL(hpte_v) & ~mmu_psize_defs[size].avpnm) << 23;
 
-		if (shift < 23) {
-			unsigned long vpi, pteg;
+	if (shift < 23) {
+		unsigned long vpi, vsid, pteg;
 
-			pteg = slot / HPTES_PER_GROUP;
-			if (hpte_v & HPTE_V_SECONDARY)
-				pteg = ~pteg;
+		pteg = slot / HPTES_PER_GROUP;
+		if (hpte_v & HPTE_V_SECONDARY)
+			pteg = ~pteg;
+		switch (hpte_v >> HPTE_V_SSIZE_SHIFT) {
+		case MMU_SEGSIZE_256M:
 			vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
-			avpn |= (vpi << mmu_psize_defs[size].shift);
+			break;
+		case MMU_SEGSIZE_1T:
+			vsid = avpn >> 40;
+			vpi = (vsid ^ (vsid << 25) ^ pteg) & htab_hash_mask;
+			break;
+		default:
+			avpn = vpi = psize = 0;
 		}
+		avpn |= (vpi << mmu_psize_defs[size].shift);
 	}
 
 	*va = avpn;
diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
index e2ca55b..b8dca30 100644
--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -73,8 +73,9 @@ extern char initial_stab[];
 
 #define HPTES_PER_GROUP 8
 
+#define HPTE_V_SSIZE_SHIFT	62
 #define HPTE_V_AVPN_SHIFT	7
-#define HPTE_V_AVPN		ASM_CONST(0xffffffffffffff80)
+#define HPTE_V_AVPN		ASM_CONST(0x3fffffffffffff80)
 #define HPTE_V_AVPN_VAL(x)	(((x) & HPTE_V_AVPN) >> HPTE_V_AVPN_SHIFT)
 #define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & HPTE_V_AVPN))
 #define HPTE_V_BOLTED		ASM_CONST(0x0000000000000010)
@@ -151,6 +152,15 @@ struct mmu_psize_def
 #define MMU_PAGE_16G		5	/* 16G */
 #define MMU_PAGE_COUNT		6
 
+/*
+ * Segment sizes.
+ * These are the values used by hardware in the B field of
+ * SLB entries and the first dword of MMU hashtable entries.
+ * The B field is 2 bits; the values 2 and 3 are unused and reserved.
+ */
+#define MMU_SEGSIZE_256M	0
+#define MMU_SEGSIZE_1T		1
+
 #ifndef __ASSEMBLY__
 
 /*
