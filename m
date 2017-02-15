Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNwMc389lzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:40 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FNJMfA090770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:23:38 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28my2qu784-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:23:38 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 09:23:35 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9768E2CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FNNOl427197670
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:32 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FNN0AD007109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:00 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "# v4 . 8+" <stable@vger.kernel.org>
Subject: [PATCH 1/3] pci/hotplug/pnv-php: Remove WARN_ON() in
 pnv_php_put_slot()
Date: Thu, 16 Feb 2017 10:22:32 +1100
In-Reply-To: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The WARN_ON() causes unnecessary backtrace when putting the parent
slot, which is likely to be NULL.

 WARNING: CPU: 2 PID: 1071 at drivers/pci/hotplug/pnv_php.c:85 \
                              pnv_php_release+0xcc/0x150 [pnv_php]
    :
 Call Trace:
 [c0000003bc007c10] [d00000000ad613c4] pnv_php_release+0x144/0x150 [pnv_php]
 [c0000003bc007c40] [c0000000006641d8] pci_hp_deregister+0x238/0x330
 [c0000003bc007cd0] [d00000000ad61440] pnv_php_unregister_one+0x70/0xa0 [pnv_php]
 [c0000003bc007d10] [d00000000ad614c0] pnv_php_unregister+0x50/0x80 [pnv_php]
 [c0000003bc007d40] [d00000000ad61e84] pnv_php_exit+0x50/0xcb4 [pnv_php]
 [c0000003bc007d70] [c00000000019499c] SyS_delete_module+0x1fc/0x2a0
 [c0000003bc007e30] [c00000000000b184] system_call+0x38/0xe0

Cc: <stable@vger.kernel.org> # v4.8+
Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 63cd9f3..da1bbf3 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -76,7 +76,7 @@ static void pnv_php_free_slot(struct kref *kref)
 static inline void pnv_php_put_slot(struct pnv_php_slot *php_slot)
 {
 
-	if (WARN_ON(!php_slot))
+	if (!php_slot)
 		return;
 
 	kref_put(&php_slot->kref, pnv_php_free_slot);
-- 
2.7.4
