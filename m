Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40shnr2snwzF1gL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:10:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 06/23] powerpc/rfi-flush: Always enable fallback
 flush on pseries
Date: Fri, 25 May 2018 20:09:37 +1000
Message-Id: <20180525100954.31599-7-mpe@ellerman.id.au>
In-Reply-To: <20180525100954.31599-1-mpe@ellerman.id.au>
References: <20180525100954.31599-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This ensures the fallback flush area is always allocated on pseries,
so in case a LPAR is migrated from a patched to an unpatched system,
it is possible to enable the fallback flush in the target system.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
(cherry picked from commit 84749a58b6e382f109abf1e734bc4dd43c2c25bb)
---
 arch/powerpc/platforms/pseries/setup.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 8bbbb4e753b5..2708ddab209b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -468,26 +468,18 @@ static void pseries_setup_rfi_flush(void)
 
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
