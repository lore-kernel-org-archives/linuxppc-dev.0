Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F3791A1836
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:09:07 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:08:54 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 55A2B357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:52 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s916iRNo6488352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 16:44:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9178JuP019054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:08:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] powerpc/eeh: Fix condition for isolated state
Date: Wed,  1 Oct 2014 17:07:49 +1000
Message-Id: <1412147274-28770-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function eeh_pe_state_mark() could possibly have combination of
multiple EEH PE state as its argument. The patch fixes the condition
used to check if EEH_PE_ISOLATED is included.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index eef08f0..8c4429b 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -525,7 +525,7 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
 	pe->state |= state;
 
 	/* Offline PCI devices if applicable */
-	if (state != EEH_PE_ISOLATED)
+	if (!(state & EEH_PE_ISOLATED))
 		return NULL;
 
 	eeh_pe_for_each_dev(pe, edev, tmp) {
-- 
1.8.3.2
