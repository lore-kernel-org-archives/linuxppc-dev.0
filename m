Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B677B1A17F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 01:59:44 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 11:59:42 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id ED2DA38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 11:59:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t91Fxd4x55640208
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 15:59:39 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91FxcPs028400
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 11:59:39 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <manoj@linux.vnet.ibm.com>
Subject: [PATCH v5 34/34] cxlflash: Fix to escalate to LINK_RESET on login
 timeout
Date: Thu,  1 Oct 2015 10:58:52 -0500
Message-Id: <1443715132-26119-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Manoj Kumar <manoj@linux.vnet.ibm.com>

A 'login timed out' asynchronous error interrupt is generated if no
response is seen to a FLOGI within 2 seconds.  If the time out error
is not escalated to a LINK_RESET the port will not be available for
use. This fix provides the required escalation.

Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index c152703..afaf533 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1100,7 +1100,7 @@ static const struct asyc_intr_info ainfo[] = {
 	{SISL_ASTATUS_FC0_OTHER, "other error", 0, CLR_FC_ERROR | LINK_RESET},
 	{SISL_ASTATUS_FC0_LOGO, "target initiated LOGO", 0, 0},
 	{SISL_ASTATUS_FC0_CRC_T, "CRC threshold exceeded", 0, LINK_RESET},
-	{SISL_ASTATUS_FC0_LOGI_R, "login timed out, retrying", 0, 0},
+	{SISL_ASTATUS_FC0_LOGI_R, "login timed out, retrying", 0, LINK_RESET},
 	{SISL_ASTATUS_FC0_LOGI_F, "login failed", 0, CLR_FC_ERROR},
 	{SISL_ASTATUS_FC0_LOGI_S, "login succeeded", 0, SCAN_HOST},
 	{SISL_ASTATUS_FC0_LINK_DN, "link down", 0, 0},
-- 
2.1.0
