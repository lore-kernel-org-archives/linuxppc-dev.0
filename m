Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4A761A09C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 15:14:44 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 02003140139
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2014 15:14:43 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 20 Nov 2014 09:44:40 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8FE271258044
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2014 09:44:45 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAK4FC8g52297836
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2014 09:45:12 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAK4Eaa6023405
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2014 09:44:36 +0530
Subject: [PATCH] powerpc/powernv: Fix the hmi event version check.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Nov 2014 09:44:36 +0530
Message-ID: <20141120041345.3339.6873.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The current HMI event structure is an ABI and carries a version field to
accommodate future changes without affecting/rearranging current structure
members that are valid for previous versions. The current version check
"if (hmi_evt->version != OpalHMIEvt_V1)" seems to consider that version
will always be V1 which may not be true in future. If we start supporting
HMI event > V1, this check would fail without printing anything on older
kernels. This patch fixes this issue.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-hmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 5e1ed15..b322bfb 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -57,7 +57,7 @@ static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
 	};
 
 	/* Print things out */
-	if (hmi_evt->version != OpalHMIEvt_V1) {
+	if (hmi_evt->version < OpalHMIEvt_V1) {
 		pr_err("HMI Interrupt, Unknown event version %d !\n",
 			hmi_evt->version);
 		return;
