Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 85856DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:18:30 +1000 (EST)
Date: Thu, 10 May 2007 02:18:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] fix warning in hash_native_64.c
Message-Id: <20070510021835.97209267.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, dgibson@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


arch/powerpc/mm/hash_native_64.c: In function 'native_hpte_clear':
arch/powerpc/mm/hash_native_64.c:353: warning: 'avpn' may be used uninitialized in this function

The change is really to BUG_ON the invers of the if condition and
outdent all the following code.  The comment above this imples that
changing this so it does the BUG_ON() is a reasonable fix.

David Gibson suggested using BUG_ON here.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_native_64.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 7b7fe2d..531a5ab 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/threads.h>
 #include <linux/smp.h>
+#include <linux/bug.h>
 
 #include <asm/abs_addr.h>
 #include <asm/machdep.h>
@@ -389,18 +390,19 @@ static void hpte_decode(hpte_t *hpte, unsigned long slot,
 		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
 	else
 		avpnm_bits = 0;
-	if (shift - avpnm_bits <= 23) {
-		avpn = HPTE_V_AVPN_VAL(hpte_v) << 23;
 
-		if (shift < 23) {
-			unsigned long vpi, pteg;
+	BUG_ON(!(shift - avpnm_bits <= 23));
 
-			pteg = slot / HPTES_PER_GROUP;
-			if (hpte_v & HPTE_V_SECONDARY)
-				pteg = ~pteg;
-			vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
-			avpn |= (vpi << mmu_psize_defs[size].shift);
-		}
+	avpn = HPTE_V_AVPN_VAL(hpte_v) << 23;
+
+	if (shift < 23) {
+		unsigned long vpi, pteg;
+
+		pteg = slot / HPTES_PER_GROUP;
+		if (hpte_v & HPTE_V_SECONDARY)
+			pteg = ~pteg;
+		vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
+		avpn |= (vpi << mmu_psize_defs[size].shift);
 	}
 
 	*va = avpn;
-- 
1.5.1.3
