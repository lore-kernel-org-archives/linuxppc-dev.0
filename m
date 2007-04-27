Return-Path: <lukebr@linux.vnet.ibm.com>
Subject: [PATCH v4] powerpc: 64K page support for kexec
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <772e4d4c76807769449cf1bf874d2ce1@bga.com>
References: <1177626236.24866.99.camel@luke-laptop>
	, <1177601310.24866.94.camel@luke-laptop>
	<772e4d4c76807769449cf1bf874d2ce1@bga.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 13:22:20 -0300
Message-Id: <1177690940.24866.124.camel@luke-laptop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a couple of kexec problems related to 64K page
support in the kernel.  kexec issues a tlbie for each pte.  The
parameters for the tlbie are the page size and the virtual address.
Support was missing for the computation of these two parameters
for 64K pages.  This patch adds that support.

Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-2.6.21-rc4/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-2.6.21-rc4.orig/arch/powerpc/mm/hash_native_64.c
+++ linux-2.6.21-rc4/arch/powerpc/mm/hash_native_64.c
@@ -340,31 +340,74 @@ static void native_hpte_invalidate(unsig
 	local_irq_restore(flags);
 }
 
-/*
- * XXX This need fixing based on page size. It's only used by
- * native_hpte_clear() for now which needs fixing too so they
- * make a good pair...
- */
-static unsigned long slot2va(unsigned long hpte_v, unsigned long slot)
-{
-	unsigned long avpn = HPTE_V_AVPN_VAL(hpte_v);
-	unsigned long va;
-
-	va = avpn << 23;
-
-	if (! (hpte_v & HPTE_V_LARGE)) {
-		unsigned long vpi, pteg;
+#define LP_SHIFT	12
+#define LP_BITS		8
+#define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
+
+static void hpte_decode(hpte_t *hpte, unsigned long slot, 
+			int *psize, unsigned long *va)
+{
+	unsigned long hpte_r = hpte->r;
+	unsigned long hpte_v = hpte->v;
+	unsigned long avpn;
+	int i, size, shift, penc, avpnm_bits;
+		
+	if (!(hpte_v & HPTE_V_LARGE))
+		size = MMU_PAGE_4K;
+	else {
+		for (i = 0; i < LP_BITS; i++) {
+			if ((hpte_r & LP_MASK(i+1)) == LP_MASK(i+1))
+				break;
+		}
+		penc = LP_MASK(i+1) >> LP_SHIFT;
+		for (size = 0; size < MMU_PAGE_COUNT; size++) {
 
-		pteg = slot / HPTES_PER_GROUP;
-		if (hpte_v & HPTE_V_SECONDARY)
-			pteg = ~pteg;
+			/* 4K pages are not represented by LP */
+			if (size == MMU_PAGE_4K)
+				continue;
+
+			/* valid entries have a shift value */
+			if (!mmu_psize_defs[size].shift)
+				continue;
 
-		vpi = ((va >> 28) ^ pteg) & htab_hash_mask;
+			if (penc == mmu_psize_defs[size].penc)
+				break;
+		}
+	}
 
-		va |= vpi << PAGE_SHIFT;
+	/*
+	 * FIXME, the code below works for 16M, 64K, and 4K pages as these
+	 * fall under the p<=23 rules for calculating the virtual address.
+	 * In the case of 16M pages, an extra bit is stolen from the AVPN
+	 * field to achieve the requisite 24 bits. 
+	 * 
+	 * You can use kexec -l to debug new page support!
+	 */
+	BUG_ON(hpte_v & 0x4000000000000000UL && !panic);   /* 1T segment */
+	BUG_ON(size == MMU_PAGE_16G && !panic);
+	BUG_ON(size == MMU_PAGE_64K_AP && !panic);
+
+	shift = mmu_psize_defs[size].shift;
+	if (mmu_psize_defs[size].avpnm)
+		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
+	else
+		avpnm_bits = 0;
+	if (shift - avpnm_bits <= 23) {
+		avpn = HPTE_V_AVPN_VAL(hpte_v) << 23;
+
+		if (shift < 23) {
+			unsigned long vpi, pteg;
+
+			pteg = slot / HPTES_PER_GROUP;
+			if (hpte_v & HPTE_V_SECONDARY)
+				pteg = ~pteg;
+			vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
+			avpn |= (vpi << mmu_psize_defs[size].shift);
+		}
 	}
 
-	return va;
+	*va = avpn;
+	*psize = size;
 }
 
 /*
@@ -374,15 +417,14 @@ static unsigned long slot2va(unsigned lo
  *
  * TODO: add batching support when enabled.  remember, no dynamic memory here,
  * athough there is the control page available...
- *
- * XXX FIXME: 4k only for now !
  */
 static void native_hpte_clear(void)
 {
 	unsigned long slot, slots, flags;
 	hpte_t *hptep = htab_address;
-	unsigned long hpte_v;
+	unsigned long hpte_v, va;
 	unsigned long pteg_count;
+	int psize;
 
 	pteg_count = htab_hash_mask + 1;
 
@@ -408,8 +450,9 @@ static void native_hpte_clear(void)
 		 * already hold the native_tlbie_lock.
 		 */
 		if (hpte_v & HPTE_V_VALID) {
+			hpte_decode(hptep, slot, &psize, &va);
 			hptep->v = 0;
-			__tlbie(slot2va(hpte_v, slot), MMU_PAGE_4K);
+			__tlbie(va, psize);
 		}
 	}
 
