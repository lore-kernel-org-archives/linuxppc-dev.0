Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjqVY12HTzDrbh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 19:44:04 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAO8h9RP134522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 03:44:02 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eeex6kfve-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 03:44:01 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 24 Nov 2017 08:33:52 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
Date: Fri, 24 Nov 2017 14:03:37 +0530
Message-Id: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is an unsafe signed to unsigned conversion in set_thread_tidr()
that may cause an error value to be assigned to SPRN_TIDR register and
used as thread-id.

The issue happens as assign_thread_tidr() returns an int and
thread.tidr is an unsigned-long. So a negative error code returned
from assign_thread_tidr() will fail the error check and gets assigned
as tidr as a large positive value.

To fix this the patch assigns the return value of assign_thread_tidr()
to a temporary int and assigns it to thread.tidr iff its '> 0'.

The patch shouldn't impact the calling convention of set_thread_tidr()
i.e all -ve return-values are error codes, +ve return values are
assigned Thread-ids. The way function is implemented it should never
return a '0'.

Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

---
Changelog:

v2  ->	* Update the patch description to document the calling
	convention of set_thread_tidr(). [Mpe]
	* Fix a tidr allocation leak.
---
 arch/powerpc/kernel/process.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bfdd783e3916..5d8176c7c2d8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1569,19 +1569,21 @@ void arch_release_task_struct(struct task_struct *t)
  */
 int set_thread_tidr(struct task_struct *t)
 {
+	int rc;
+
 	if (!cpu_has_feature(CPU_FTR_ARCH_300))
 		return -EINVAL;
 
 	if (t != current)
 		return -EINVAL;
 
-	t->thread.tidr = assign_thread_tidr();
-	if (t->thread.tidr < 0)
-		return t->thread.tidr;
-
-	mtspr(SPRN_TIDR, t->thread.tidr);
+	rc = assign_thread_tidr();
+	if (rc > 0) {
+		t->thread.tidr = rc;
+		mtspr(SPRN_TIDR, t->thread.tidr);
+	}
 
-	return 0;
+	return rc;
 }
 
 #endif /* CONFIG_PPC64 */
-- 
2.14.3
