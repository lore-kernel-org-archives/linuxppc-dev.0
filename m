Return-Path: <valentinrothberg@gmail.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzXBm0Hz3zDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 17:01:04 +1000 (AEST)
Received: by mail-wm0-x22c.google.com with SMTP id g17so21125410wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 00:01:03 -0700 (PDT)
From: Valentin Rothberg <valentinrothberg@gmail.com>
To: aneesh.kumar@linux.vnet.ibm.com,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] powerpc/mm/radix: fix STD_MMU_64 typo
Date: Tue,  3 May 2016 08:59:27 +0200
Message-Id: <1462258767-83025-1-git-send-email-valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

s/MMU_STD_64/STD_MMU_64/

Fixes: 11ffc1cfa4c2 ("powerpc/mm/radix: Use STD_MMU_64 to properly
                      isolate hash related code")
Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---

I only compile tested this change.  The issue has been detected with
scripts/checkkconfigsymbols.py

 arch/powerpc/kernel/mce_power.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index bec70338672e..7353991c4ece 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -80,7 +80,7 @@ void __flush_tlb_power9(unsigned int action)
 
 
 /* flush SLBs and reload */
-#ifdef CONFIG_PPC_MMU_STD_64
+#ifdef CONFIG_PPC_STD_MMU_64
 static void flush_and_reload_slb(void)
 {
 	struct slb_shadow *slb;
@@ -125,7 +125,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 	 * reset the error bits whenever we handle them so that at the end
 	 * we can check whether we handled all of them or not.
 	 * */
-#ifdef CONFIG_PPC_MMU_STD_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (dsisr & slb_error_bits) {
 		flush_and_reload_slb();
 		/* reset error bits */
@@ -157,7 +157,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 	switch (P7_SRR1_MC_IFETCH(srr1)) {
 	case 0:
 		break;
-#ifdef CONFIG_PPC_MMU_STD_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	case P7_SRR1_MC_IFETCH_SLB_PARITY:
 	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
 		/* flush and reload SLBs for SLB errors. */
@@ -184,7 +184,7 @@ static long mce_handle_ierror_p7(uint64_t srr1)
 
 	handled = mce_handle_common_ierror(srr1);
 
-#ifdef CONFIG_PPC_MMU_STD_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
 		flush_and_reload_slb();
 		handled = 1;
@@ -332,7 +332,7 @@ static long mce_handle_ierror_p8(uint64_t srr1)
 
 	handled = mce_handle_common_ierror(srr1);
 
-#ifdef CONFIG_PPC_MMU_STD_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (P7_SRR1_MC_IFETCH(srr1) == P8_SRR1_MC_IFETCH_ERAT_MULTIHIT) {
 		flush_and_reload_slb();
 		handled = 1;
-- 
2.7.4
