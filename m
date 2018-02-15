Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj51V3HLdzF1Ly
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 05:50:03 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1FInItc112918
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 13:50:00 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g5chd9mkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 13:50:00 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 11:49:59 -0700
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com, aik@ozlabs.ru,
 ruscur@russell.cc, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Add conditional check on notify_resume
Date: Thu, 15 Feb 2018 12:49:51 -0600
Message-Id: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>

EEH structure is not populated with function
notify resume when running on systems that do not support
it, i.e: BMC. Hence adding a conditional check for NULL for
systems that don't add function notify_resume.

Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Tested-by: Carol L. Soto <clsoto@us.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index beea218..0c0b66f 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -384,7 +384,8 @@ static void *eeh_report_resume(void *data, void *userdata)
 	eeh_pcid_put(dev);
 	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 #ifdef CONFIG_PCI_IOV
-	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
+	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
+		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
 #endif
 	return NULL;
 }
-- 
2.7.2
