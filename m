Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F3E1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:13:12 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EE2F140DA5
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 7 Oct 2015 13:13:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 48B3B2CE8050
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:09 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t973D1n350725038
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:13:09 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t973CabI001637
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:12:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 5/5] powerpc/pseries: Cleanup on pseries_eeh_get_state()
Date: Wed,  7 Oct 2015 14:12:09 +1100
Message-Id: <1444187529-32217-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This cleans up pseries_eeh_get_state(), no functional changes:

   * Return EEH_STATE_NOT_SUPPORT early when the 2nd RTAS output
     argument is zero to avoid nested if statements.
   * Skip clearing bits in the PE state represented by variable
     "result" to simplify the code.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 60 ++++++++++++----------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1ba55d0..ac3ffd9 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -433,42 +433,34 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
 		return ret;
 
 	/* Parse the result out */
-	result = 0;
-	if (rets[1]) {
-		switch(rets[0]) {
-		case 0:
-			result &= ~EEH_STATE_RESET_ACTIVE;
-			result |= EEH_STATE_MMIO_ACTIVE;
-			result |= EEH_STATE_DMA_ACTIVE;
-			break;
-		case 1:
-			result |= EEH_STATE_RESET_ACTIVE;
-			result |= EEH_STATE_MMIO_ACTIVE;
-			result |= EEH_STATE_DMA_ACTIVE;
-			break;
-		case 2:
-			result &= ~EEH_STATE_RESET_ACTIVE;
-			result &= ~EEH_STATE_MMIO_ACTIVE;
-			result &= ~EEH_STATE_DMA_ACTIVE;
-			break;
-		case 4:
-			result &= ~EEH_STATE_RESET_ACTIVE;
-			result &= ~EEH_STATE_MMIO_ACTIVE;
-			result &= ~EEH_STATE_DMA_ACTIVE;
-			result |= EEH_STATE_MMIO_ENABLED;
-			break;
-		case 5:
-			if (rets[2]) {
-				if (state) *state = rets[2];
-				result = EEH_STATE_UNAVAILABLE;
-			} else {
-				result = EEH_STATE_NOT_SUPPORT;
-			}
-			break;
-		default:
+	if (!rets[1])
+		return EEH_STATE_NOT_SUPPORT;
+
+	switch(rets[0]) {
+	case 0:
+		result = EEH_STATE_MMIO_ACTIVE |
+			 EEH_STATE_DMA_ACTIVE;
+		break;
+	case 1:
+		result = EEH_STATE_RESET_ACTIVE |
+			 EEH_STATE_MMIO_ACTIVE  |
+			 EEH_STATE_DMA_ACTIVE;
+		break;
+	case 2:
+		result = 0;
+		break;
+	case 4:
+		result = EEH_STATE_MMIO_ENABLED;
+		break;
+	case 5:
+		if (rets[2]) {
+			if (state) *state = rets[2];
+			result = EEH_STATE_UNAVAILABLE;
+		} else {
 			result = EEH_STATE_NOT_SUPPORT;
 		}
-	} else {
+		break;
+	default:
 		result = EEH_STATE_NOT_SUPPORT;
 	}
 
-- 
2.1.0
