Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTdL14jGdzDvvX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 11:23:21 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB10IfH6010250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:23:19 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2724mx457t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:23:18 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 1 Dec 2016 10:23:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D1C2E3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 11:23:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB10NE7C56754382
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 11:23:14 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB10NE8s029753
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 11:23:14 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, gwshan@linux.vnet.ibm.com
Cc: ukrishn@linux.vnet.ibm.com, pradghos@in.ibm.com
Subject: [PATCH] powerpc/eeh: fix deadlock when PE frozen state can't be
 cleared
Date: Thu,  1 Dec 2016 11:23:05 +1100
Message-Id: <20161201002305.14591-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In eeh_reset_device(), we take the pci_rescan_remove_lock immediately after
after we call eeh_reset_pe() to reset the PCI controller. We then call
eeh_clear_pe_frozen_state(), which can return an error. In this case, we
bail out of eeh_reset_device() without calling pci_unlock_rescan_remove().

Add a call to pci_unlock_rescan_remove() in the eeh_clear_pe_frozen_state()
error path so that we don't cause a deadlock later on.

Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
Fixes: 78954700631f ("powerpc/eeh: Avoid I/O access during PE reset")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index a62be72..5c31369 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -671,8 +671,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 
 	/* Clear frozen state */
 	rc = eeh_clear_pe_frozen_state(pe, false);
-	if (rc)
+	if (rc) {
+		pci_unlock_rescan_remove();
 		return rc;
+	}
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
