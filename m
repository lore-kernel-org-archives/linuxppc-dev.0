Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B12B42C013C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 16:01:37 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 11:26:00 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D17BFE0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:31:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7762hco36700334
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 11:32:43 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7761UVx004163
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 11:31:31 +0530
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/eeh: powerpc/eeh: Fix undefined variable
Date: Wed,  7 Aug 2013 02:01:19 -0400
Message-Id: <1375855279-28592-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'pe_no' hasn't been defined, it should be an typo error,
it should be 'frozen_pe_no'.

Also '__func__' has missed in IODA_EEH_DBG(),

For safety reasons, use pr_info() directly, instead
of use IODA_EEH_DBG()

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 0cd1c4a..8bc19c8 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -36,13 +36,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-/* Debugging option */
-#ifdef IODA_EEH_DBG_ON
-#define IODA_EEH_DBG(args...)	pr_info(args)
-#else
-#define IODA_EEH_DBG(args...)
-#endif
-
 static char *hub_diag = NULL;
 static int ioda_eeh_nb_init = 0;
 
@@ -823,17 +816,17 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 		/* If OPAL API returns error, we needn't proceed */
 		if (rc != OPAL_SUCCESS) {
-			IODA_EEH_DBG("%s: Invalid return value on "
-				     "PHB#%x (0x%lx) from opal_pci_next_error",
-				     __func__, hose->global_number, rc);
+			pr_info("%s: Invalid return value on "
+				"PHB#%x (0x%lx) from opal_pci_next_error",
+				__func__, hose->global_number, rc);
 			continue;
 		}
 
 		/* If the PHB doesn't have error, stop processing */
 		if (err_type == OPAL_EEH_NO_ERROR ||
 		    severity == OPAL_EEH_SEV_NO_ERROR) {
-			IODA_EEH_DBG("%s: No error found on PHB#%x\n",
-				     __func__, hose->global_number);
+			pr_info("%s: No error found on PHB#%x\n",
+				__func__, hose->global_number);
 			continue;
 		}
 
@@ -842,8 +835,9 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		 * highest priority reported upon multiple errors on the
 		 * specific PHB.
 		 */
-		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
-			err_type, severity, pe_no, hose->global_number);
+		pr_info("%s: Error (%d, %d, %d) on PHB#%x\n",
+			__func__, err_type, severity,
+			frozen_pe_no, hose->global_number);
 		switch (err_type) {
 		case OPAL_EEH_IOC_ERROR:
 			if (severity == OPAL_EEH_SEV_IOC_DEAD) {
-- 
1.8.2.1
