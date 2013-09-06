Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B83C2C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:19 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 21:00:17 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5E3B038C805F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:14 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8610EV638076436
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:14 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8610Drs001346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:00:14 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] powerpc/eeh: Reorder output messages
Date: Fri,  6 Sep 2013 09:00:05 +0800
Message-Id: <1378429205-16248-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already had some output messages from EEH core. Occasionally,
we can see the output messages from EEH core before the stack
dump. That's not what we expected. The patch fixes that and shows
the stack dump prior to output messages from EEH core.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 55593ee..1fb331d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -327,11 +327,11 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	/* Isolate the PHB and send event */
 	eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
 	eeh_serialize_unlock(flags);
-	eeh_send_failure_event(phb_pe);
 
 	pr_err("EEH: PHB#%x failure detected\n",
 		phb_pe->phb->global_number);
 	dump_stack();
+	eeh_send_failure_event(phb_pe);
 
 	return 1;
 out:
@@ -454,8 +454,6 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 	eeh_serialize_unlock(flags);
 
-	eeh_send_failure_event(pe);
-
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out.
@@ -464,6 +462,8 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 		pe->addr, pe->phb->global_number);
 	dump_stack();
 
+	eeh_send_failure_event(pe);
+
 	return 1;
 
 dn_unlock:
-- 
1.7.5.4
