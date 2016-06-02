Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL5505xrqzDr5K
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 21:45:24 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u52Behar021447
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 07:45:23 -0400
Message-Id: <201606021145.u52Behar021447@mx0a-001b2d01.pphosted.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ak3ft007-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 07:45:22 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 08:45:20 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B5EDC1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 07:45:11 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u52BjI2T27197702
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 08:45:18 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u52BjIeb029587
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jun 2016 08:45:18 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v2] powerpc: export cpu_to_core_id()
Date: Thu,  2 Jun 2016 08:45:14 -0300
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export cpu_to_core_id().  This will be used by the lpfc driver.

This enables topology_core_id() from  <linux/topology.h> (defined
to cpu_to_core_id() in arch/powerpc/include/asm/topology.h) to be
used by (non-builtin) modules.

That is arch-neutral, already used by eg, drivers/base/topology.c,
but it is builtin (obj-y in Makefile) thus didn't need the export.

Since the module uses topology_core_id() and this is defined to
cpu_to_core_id(), it needs the export, otherwise:

    ERROR: "cpu_to_core_id" [drivers/scsi/lpfc/lpfc.ko] undefined!
    make[1]: *** [__modpost] Error 1
    make: *** [modules] Error 2

Tested on next-20160601.

Changelog:
 - v2: include details about the need for this patch with regards 
       to the architecture-neutral topology API.

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
