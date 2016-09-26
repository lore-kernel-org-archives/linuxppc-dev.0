Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjP9J4rxLzDrSp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 22:56:20 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QCrTWY104380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 08:56:18 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25p6t1t8x5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 08:56:18 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 18:26:14 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 698F9125805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:26:32 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QCu1xc17825958
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:26:01 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QCu2Xo002888
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:26:11 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/5] powerpc/eeh: Export eeh_pe_state_mark()
Date: Mon, 26 Sep 2016 22:56:04 +1000
In-Reply-To: <1474894567-15229-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1474894567-15229-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1474894567-15229-3-git-send-email-gwshan@linux.vnet.ibm.com>
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
