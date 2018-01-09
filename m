Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zG1Wk3JqMzF0RJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 16:52:49 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel] powerpc/lpar/debug: Initialize flags before printing
 debug message
Date: Tue,  9 Jan 2018 16:52:14 +1100
Message-Id: <20180109055214.32199-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With enabled DEBUG, there is a compile error:
"error: ‘flags’ is used uninitialized in this function".

This moves pr_devel() little further where @flags are initialized.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

/home/aik/p/guest-kernel/arch/powerpc/platforms/pseries/lpar.c: In function ‘pSeries_lpar_hpte_updatepp’:
/home/aik/p/guest-kernel/include/linux/printk.h:320:2: error: ‘flags’ is used uninitialized in this function [-Werror=un
initialized]
  printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
  ^
/home/aik/p/guest-kernel/arch/powerpc/platforms/pseries/lpar.c:304:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^
---
 arch/powerpc/platforms/pseries/lpar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0ee4a46..1365424 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -306,14 +306,14 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
+	flags = (newpp & 7) | H_AVPN;
+	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+		/* Move pp0 into bit 8 (IBM 55) */
+		flags |= (newpp & HPTE_R_PP0) >> 55;
+
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
 
-	flags = (newpp & 7) | H_AVPN;
-	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
-		/* Move pp0 into bit 8 (IBM 55) */
-		flags |= (newpp & HPTE_R_PP0) >> 55;
-
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
-- 
2.11.0
