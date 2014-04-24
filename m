Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CE7AC14015E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DD3A62CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dWVr19529954
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80QjT014816
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 05/25] powerpc/eeh: EEH_PE_ISOLATED not reflect HW state
Date: Thu, 24 Apr 2014 18:00:11 +1000
Message-Id: <1398326431-24305-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When doing PE reset, EEH_PE_ISOLATED is cleared unconditionally.
However, We should remove that if the PE reset has cleared the
frozen state successfully. Otherwise, the flag should be kept.
The patch fixes the issue.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f167676..cc728e8 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -612,12 +612,6 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 #define PCI_BUS_RST_HOLD_TIME_MSEC 250
 	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
 
-	/* We might get hit with another EEH freeze as soon as the
-	 * pci slot reset line is dropped. Make sure we don't miss
-	 * these, and clear the flag now.
-	 */
-	eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
-
 	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
@@ -646,8 +640,10 @@ int eeh_reset_pe(struct eeh_pe *pe)
 		eeh_reset_pe_once(pe);
 
 		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if ((rc & flags) == flags)
+		if ((rc & flags) == flags) {
+			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 			return 0;
+		}
 
 		if (rc < 0) {
 			pr_err("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
-- 
1.8.3.2
