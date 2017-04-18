Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Qmh4jV7zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 10:21:56 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3I0G2x0021271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:21:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29vwu0yyhy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:21:52 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 18:21:51 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com,
 sachinp@linux.vnet.ibm.com, devicetree@vger.kernel.org,
 pantelis.antoniou@konsulko.com, robh+dt@kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] powerpc/pseries: fix of_node_put() underflow during dlpar
 remove
Date: Mon, 17 Apr 2017 20:21:40 -0400
Message-Id: <1492474900-10658-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Historically device_node references were tracked using a kref embedded
as a struct field. Commit 75b57ecf9 refactored device_nodes to be
kobjects such that the device tree could by more simply exposed to
userspace using sysfs. Commit 0829f6d1f6 followed up these changes to
better control the kobject lifecycle and in particular the referecne
counting via of_node_get(), of_node_put(), and of_node_init(). A side
effect of this second commit was that it introduced an of_node_put()
call when a dynamic node is detached that removes the initial kobj
reference created by of_node_init() . Traditionally as the original
dynamic device node user the pseries code had assumed responsibilty for
releasing this final reference in its platform specific DLPAR detach code.

This patch fixes a refcount underflow introduced by commit 0829f6d1f6,
and recently exposed by the upstreaming of the recount API.

Messages like the following are no longer seen in the kernel log with this
patch following DLPAR remove operations of cpus and pci devices.

  [  269.589441] rpadlpar_io: slot PHB 72 removed
  [  270.589997] refcount_t: underflow; use-after-free.
  [  270.590019] ------------[ cut here ]------------
  [  270.590025] WARNING: CPU: 5 PID: 3335 at
     lib/refcount.c:128 refcount_sub_and_test+0xf4/0x110

Cc: stable@vger.kernel.org
Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 193e052..bda18d8 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -288,7 +288,6 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
-	of_node_put(dn); /* Must decrement the refcount */
 	return 0;
 }
 
-- 
1.8.3.1
