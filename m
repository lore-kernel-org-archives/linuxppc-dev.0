Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjqHL4D31zDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 19:34:22 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAO8YJ34048378
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 03:34:19 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eefqk8wsg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 03:34:16 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 24 Nov 2017 08:33:56 -0000
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
Subject: [PATCH v2 2/2] powerpc: Do not assign thread.tidr if already assigned
Date: Fri, 24 Nov 2017 14:03:38 +0530
In-Reply-To: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
References: <20171124083338.15283-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20171124083338.15283-2-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If set_thread_tidr() is called twice for same task_struct then it will
allocate a new tidr value to it leaving the previous value still
dangling in the vas_thread_ida table.

To fix this the patch changes set_thread_tidr() to check if a tidr
value is already assigned to the task_struct and if yes then returns
the existing value from function instead of allocating a new one.

Fixes: ec233ede4c86("powerpc: Add support for setting SPRN_TIDR")
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
v2 ->	Fix minor spell errors in patch description
---
 arch/powerpc/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5d8176c7c2d8..9a72282b022d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1577,6 +1577,9 @@ int set_thread_tidr(struct task_struct *t)
 	if (t != current)
 		return -EINVAL;
 
+	if (t->thread.tidr)
+		return t->thread.tidr;
+
 	rc = assign_thread_tidr();
 	if (rc > 0) {
 		t->thread.tidr = rc;
-- 
2.14.3
