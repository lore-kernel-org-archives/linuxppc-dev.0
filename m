Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl3c218D6zDsff
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:45 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T5m1lv119422
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:43 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25rudn36e5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:42 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 15:51:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0AC7A3578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T5pbtu48169028
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T5pbRc032670
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 2/7] powerpc/eeh: Export confirm_error_lock
Date: Thu, 29 Sep 2016 15:52:00 +1000
In-Reply-To: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1475128325-5367-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports @confirm_error_lock so that eeh_serialize_{lock, unlock}()
can be used to freeze the affected PE in PCI surprise hot remove path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 0699f15..130bcae 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -116,6 +116,7 @@ struct eeh_ops *eeh_ops = NULL;
 
 /* Lock to avoid races due to multiple reports of an error */
 DEFINE_RAW_SPINLOCK(confirm_error_lock);
+EXPORT_SYMBOL_GPL(confirm_error_lock);
 
 /* Lock to protect passed flags */
 static DEFINE_MUTEX(eeh_dev_mutex);
-- 
2.1.0
