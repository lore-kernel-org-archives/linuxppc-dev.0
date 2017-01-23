Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6mkZ1201zDqNM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:51:01 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0NMnMFs052767
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:51:00 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 285teqs0u9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:50:59 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 08:50:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BA97F3578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:50:55 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0NMolA415335624
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:50:55 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0NMoNZb008332
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:50:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc/kernel: Fix unbalanced refcount on RTAS device
 node
Date: Tue, 24 Jan 2017 09:49:54 +1100
In-Reply-To: <1485211794-11093-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1485211794-11093-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1485211794-11093-4-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RTAS device-tree node's refcount has been increased by one in
the function call of_find_node_by_name(), but it's missed to be
decreased by one in the error path. It leads to unbalanced refcount
on RTAS device-tree node.

This fixes above issue by decreasing RTAS device-tree node's refcount
in error path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index ba5a4cc..b8a4987 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1158,6 +1158,7 @@ void __init rtas_initialize(void)
 	no_base = of_property_read_u32(rtas.dev, "linux,rtas-base", &base);
 	no_size = of_property_read_u32(rtas.dev, "rtas-size", &size);
 	if (no_base || no_size) {
+		of_node_put(rtas.dev);
 		rtas.dev = NULL;
 		return;
 	}
-- 
2.7.4
