Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyBzF6STHzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 07:03:05 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8KL0t4Z131102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 17:03:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3wmr7aqu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 17:03:03 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 17:03:02 -0400
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 abdhalee@linux.vnet.ibm.com, paulus@samba.org,
 sachinp@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, stable@vger.kernel.org,
 #@b01ledav001.gho.pok.ibm.com, v3.12+@b01ledav001.gho.pok.ibm.com
Subject: [PATCH 2/2] powerpc/pseries: fix parent_dn reference leak in
 add_dt_node()
Date: Wed, 20 Sep 2017 17:02:52 -0400
In-Reply-To: <1505941372-9147-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <1505941372-9147-1-git-send-email-tyreld@linux.vnet.ibm.com>
Message-Id: <1505941372-9147-2-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A reference to the parent device node is held by add_dt_node() for the
node to be added. If the call to dlpar_configure_connector() fails
add_dt_node() returns ENOENT and that reference is not freed.

Add a call to of_node_put(parent_dn) prior to bailing out after a failed
dlpar_configure_connector() call.

Cc: stable@vger.kernel.org # v3.12+
Fixes: 8d5ff320766f ("powerpc/pseries: Make dlpar_configure_connector parent node aware")
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 210ce63..f7042ad 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -226,8 +226,10 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 		return -ENOENT;
 
 	dn = dlpar_configure_connector(drc_index, parent_dn);
-	if (!dn)
+	if (!dn) {
+		of_node_put(parent_dn);
 		return -ENOENT;
+	}
 
 	rc = dlpar_attach_node(dn, parent_dn);
 	if (rc)
-- 
1.8.3.1
