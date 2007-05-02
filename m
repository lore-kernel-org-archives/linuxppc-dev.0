Return-Path: <lukebr@linux.vnet.ibm.com>
Subject: [PATCH v4] powerpc: 64K page support for kexec
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070426223228.GA30000@lixom.net>
References: <1177626236.24866.99.camel@luke-laptop>
	<20070426223228.GA30000@lixom.net>
Content-Type: text/plain
Date: Wed, 02 May 2007 11:19:11 -0300
Message-Id: <1178115551.24866.139.camel@luke-laptop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
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

Same as previous versions without BUG_ON()s.

Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6.21-rc4/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-2.6.21-rc4.orig/arch/powerpc/mm/hash_native_64.c
+++ linux-2.6.21-rc4/arch/powerpc/mm/hash_native_64.c
@@ -26,6 +26,7 @@
 #include <asm/tlb.h>
 #include <asm/cputable.h>
 #include <asm/udbg.h>
+#include <asm/kexec.h>
 
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) udbg_printf(fmt)
@@ -340,31 +341,70 @@ static void native_hpte_invalidate(unsig
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
+	 * Does not work for 16G pages or 1 TB segments.
+	 */
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
@@ -374,15 +414,14 @@ static unsigned long slot2va(unsigned lo
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
 
@@ -408,8 +447,9 @@ static void native_hpte_clear(void)
 		 * already hold the native_tlbie_lock.
 		 */
 		if (hpte_v & HPTE_V_VALID) {
+			hpte_decode(hptep, slot, &psize, &va);
 			hptep->v = 0;
-			__tlbie(slot2va(hpte_v, slot), MMU_PAGE_4K);
+			__tlbie(va, psize);
 		}
 	}
 
