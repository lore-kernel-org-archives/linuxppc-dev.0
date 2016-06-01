Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKhTm4GJRzDqZW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 06:17:00 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u51KDwr8046821
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 16:16:57 -0400
Message-Id: <201606012016.u51KDwr8046821@mx0a-001b2d01.pphosted.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23a4fwjy5r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 16:16:56 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 1 Jun 2016 17:16:55 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 686111DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 16:16:45 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u51KGqi45050622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 17:16:52 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u51KGpKe005205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 17:16:52 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: export cpu_to_core_id()
Date: Wed,  1 Jun 2016 17:16:46 -0300
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export cpu_to_core_id().  This will be used by the lpfc driver.

Tested on next-20160601.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 55c924b..67136e7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -593,6 +593,7 @@ out:
 	of_node_put(np);
 	return id;
 }
+EXPORT_SYMBOL_GPL(cpu_to_core_id);
 
 /* Helper routines for cpu to core mapping */
 int cpu_core_index_of_thread(int cpu)
-- 
1.8.3.1
