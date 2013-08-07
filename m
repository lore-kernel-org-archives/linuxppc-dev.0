Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77E6C2C00E1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 12:26:49 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 12:10:27 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5DCFA357804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 12:25:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7729Bfx58261682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 12:09:12 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r772P0sQ023936
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 12:25:00 +1000
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Fix undefined variable
Date: Tue,  6 Aug 2013 22:24:46 -0400
Message-Id: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
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

Also '__func__' should be added to IODA_EEH_DBG(),

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 0cd1c4a..a49bee7 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -843,7 +843,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		 * specific PHB.
 		 */
 		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
-			err_type, severity, pe_no, hose->global_number);
+			__func__, err_type, severity,
+			frozen_pe_no, hose->global_number);
 		switch (err_type) {
 		case OPAL_EEH_IOC_ERROR:
 			if (severity == OPAL_EEH_SEV_IOC_DEAD) {
-- 
1.8.2.1
