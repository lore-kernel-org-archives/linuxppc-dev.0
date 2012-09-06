Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc: Use the XDABR hcall
Date: Thu,  6 Sep 2012 15:17:49 +1000
Message-Id: <1346908671-7464-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1346908671-7464-1-git-send-email-mikey@neuling.org>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We never use the XDABR hcall since we check for DABR hcall first.
XDABR syscall is better since it allows us to also set the DABRX.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/pseries/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 51ecac9..36b7744 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -529,10 +529,10 @@ static void __init pSeries_init_early(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hvc_vio_init_early();
 #endif
-	if (firmware_has_feature(FW_FEATURE_DABR))
-		ppc_md.set_dabr = pseries_set_dabr;
-	else if (firmware_has_feature(FW_FEATURE_XDABR))
+	if (firmware_has_feature(FW_FEATURE_XDABR))
 		ppc_md.set_dabr = pseries_set_xdabr;
+	else if (firmware_has_feature(FW_FEATURE_DABR))
+		ppc_md.set_dabr = pseries_set_dabr;
 
 	pSeries_cmo_feature_init();
 	iommu_init_early_pSeries();
-- 
1.7.9.5
