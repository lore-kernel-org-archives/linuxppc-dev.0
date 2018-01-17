Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLqmc5gM5zF0bc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 12:50:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLqmc4qcSz8tF4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 12:50:40 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLqmc1QXHz9s7n
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 12:50:40 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H1mroi113139
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 20:50:38 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhsvjxxaf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 20:50:37 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 20:50:36 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] powerpc: export thread-tidr interfaces
Date: Tue, 16 Jan 2018 17:50:31 -0800
Message-Id: <1516153832-9282-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export set_thread_tidr() and clear_thread_tidr() interfaces so they
can be used by external modules.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2010e4c..f20c1ad 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1560,6 +1560,7 @@ void clear_thread_tidr(struct task_struct *t)
 	free_thread_tidr(t->thread.tidr);
 	t->thread.tidr = 0;
 }
+EXPORT_SYMBOL_GPL(clear_thread_tidr);
 
 void arch_release_task_struct(struct task_struct *t)
 {
@@ -1592,6 +1593,7 @@ int set_thread_tidr(struct task_struct *t)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_thread_tidr);
 
 #endif /* CONFIG_PPC64 */
 
-- 
2.7.4
