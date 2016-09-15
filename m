Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZMHR3stKzDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 12:07:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZMHQ5M4Dz9t0t
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F23LB3102936
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:12 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25exsn0m1x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:12 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 12:07:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4F4CF2CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:08 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F278TL6488554
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:08 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F277Cs030650
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/eeh: Export eeh_pe_state_mark()
Date: Thu, 15 Sep 2016 12:07:20 +1000
In-Reply-To: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1473905242-898-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports eeh_pe_state_mark(). It will be used to mark the surprise
hot removed PE as isolated to avoid unexpected EEH error reporting in
surprise remove path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f0520da..de7d091 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -581,6 +581,7 @@ void eeh_pe_state_mark(struct eeh_pe *pe, int state)
 {
 	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
 }
+EXPORT_SYMBOL_GPL(eeh_pe_state_mark);
 
 static void *__eeh_pe_dev_mode_mark(void *data, void *flag)
 {
-- 
2.1.0
