Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ydkR21NrzF0sk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 21:09:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.9 06/23] powerpc/rfi-flush: Always enable fallback
 flush on pseries
Date: Sat,  2 Jun 2018 21:08:51 +1000
Message-Id: <20180602110908.29773-7-mpe@ellerman.id.au>
In-Reply-To: <20180602110908.29773-1-mpe@ellerman.id.au>
References: <20180602110908.29773-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 84749a58b6e382f109abf1e734bc4dd43c2c25bb upstream.

This ensures the fallback flush area is always allocated on pseries,
so in case a LPAR is migrated from a patched to an unpatched system,
it is possible to enable the fallback flush in the target system.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0982e13b2942..626bf1ce1d80 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,26 +459,18 @@ static void pseries_setup_rfi_flush(void)
 
 	/* Enable by default */
 	enable = true;
+	types = L1D_FLUSH_FALLBACK;
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
-		types = L1D_FLUSH_NONE;
-
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
 			types |= L1D_FLUSH_ORI;
 
-		/* Use fallback if nothing set in hcall */
-		if (types == L1D_FLUSH_NONE)
-			types = L1D_FLUSH_FALLBACK;
-
 		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
 		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
-	} else {
-		/* Default to fallback if case hcall is not available */
-		types = L1D_FLUSH_FALLBACK;
 	}
 
 	setup_rfi_flush(types, enable);
-- 
2.14.1
