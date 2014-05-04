Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7B4514018B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 09:28:51 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 09:28:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7C7D52CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 09:28:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s44N7TOW2294090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 09:07:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s44NSj0C019155
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 09:28:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 1/3] powerpc/eeh: Clear frozen state for child PE
Date: Mon,  5 May 2014 09:29:02 +1000
Message-Id: <1399246144-20247-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit cb523e09 ("powerpc/eeh: Avoid I/O access during PE
reset"), the PE is kept as frozen state on hardware level until
the PE reset is done completely. After that, we explicitly clear
the frozen state of the affected PE. However, there might have
frozen child PEs of the affected PE and we also need clear their
frozen state as well. Otherwise, the recovery is going to fail.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7100a5b..8bb40e7 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -447,8 +447,9 @@ static void *eeh_pe_detach_dev(void *data, void *userdata)
  * PE reset (for 3 times), we try to clear the frozen state
  * for 3 times as well.
  */
-static int eeh_clear_pe_frozen_state(struct eeh_pe *pe)
+static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
 {
+	struct eeh_pe *pe = (struct eeh_pe *)data;
 	int i, rc;
 
 	for (i = 0; i < 3; i++) {
@@ -461,13 +462,24 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *pe)
 	}
 
 	/* The PE has been isolated, clear it */
-	if (rc)
+	if (rc) {
 		pr_warn("%s: Can't clear frozen PHB#%x-PE#%x (%d)\n",
 			__func__, pe->phb->global_number, pe->addr, rc);
-	else
+		return (void *)pe;
+	}
+
+	return NULL;
+}
+
+static int eeh_clear_pe_frozen_state(struct eeh_pe *pe)
+{
+	void *rc;
+
+	rc = eeh_pe_traverse(pe, __eeh_clear_pe_frozen_state, NULL);
+	if (!rc)
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 
-	return rc;
+	return rc ? -EIO : 0;
 }
 
 /**
-- 
1.8.3.2
