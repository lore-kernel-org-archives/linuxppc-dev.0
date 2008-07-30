Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D90E6DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 05:29:27 +1000 (EST)
Message-Id: <200807301929.m6UJT4u1011918@imap1.linux-foundation.org>
Subject: [patch 2/2] powerpc: replace __FUNCTION__ with __func__
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Wed, 30 Jul 2008 12:29:03 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	harvey.harrison@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Harvey Harrison <harvey.harrison@gmail.com>

__FUNCTION__ is gcc-specific, use __func__

[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kernel/lparcfg.c        |    8 ++++----
 arch/powerpc/platforms/pseries/cmm.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -puN arch/powerpc/kernel/lparcfg.c~powerpc-replace-__function__-with-__func__ arch/powerpc/kernel/lparcfg.c
--- a/arch/powerpc/kernel/lparcfg.c~powerpc-replace-__function__-with-__func__
+++ a/arch/powerpc/kernel/lparcfg.c
@@ -505,10 +505,10 @@ static ssize_t update_ppp(u64 *entitleme
 		return -EINVAL;
 
 	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
-	         __FUNCTION__, ppp_data.entitlement, ppp_data.weight);
+		 __func__, ppp_data.entitlement, ppp_data.weight);
 
 	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
-		 __FUNCTION__, new_entitled, new_weight);
+		 __func__, new_entitled, new_weight);
 
 	retval = plpar_hcall_norets(H_SET_PPP, new_entitled, new_weight);
 	return retval;
@@ -551,10 +551,10 @@ static ssize_t update_mpp(u64 *entitleme
 		return -EINVAL;
 
 	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
-	         __FUNCTION__, mpp_data.entitled_mem, mpp_data.mem_weight);
+	         __func__, mpp_data.entitled_mem, mpp_data.mem_weight);
 
 	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
-	         __FUNCTION__, new_entitled, new_weight);
+		 __func__, new_entitled, new_weight);
 
 	rc = plpar_hcall_norets(H_SET_MPP, new_entitled, new_weight);
 	return rc;
diff -puN arch/powerpc/platforms/pseries/cmm.c~powerpc-replace-__function__-with-__func__ arch/powerpc/platforms/pseries/cmm.c
--- a/arch/powerpc/platforms/pseries/cmm.c~powerpc-replace-__function__-with-__func__
+++ a/arch/powerpc/platforms/pseries/cmm.c
@@ -121,7 +121,7 @@ static long cmm_alloc_pages(long nr)
 			npa = (struct cmm_page_array *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
 								       __GFP_NORETRY | __GFP_NOMEMALLOC);
 			if (!npa) {
-				pr_info("%s: Can not allocate new page list\n", __FUNCTION__);
+				pr_info("%s: Can not allocate new page list\n", __func__);
 				free_page(addr);
 				break;
 			}
@@ -138,7 +138,7 @@ static long cmm_alloc_pages(long nr)
 		}
 
 		if ((rc = plpar_page_set_loaned(__pa(addr)))) {
-			pr_err("%s: Can not set page to loaned. rc=%ld\n", __FUNCTION__, rc);
+			pr_err("%s: Can not set page to loaned. rc=%ld\n", __func__, rc);
 			spin_unlock(&cmm_lock);
 			free_page(addr);
 			break;
_
