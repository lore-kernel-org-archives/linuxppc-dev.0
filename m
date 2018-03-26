Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4090BH3fVczF22g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:35:35 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGNPYo110478
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:35:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy14r2hs7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:35:33 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:35:32 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 39/41] cxlflash: Synchronize reset and remove ops
Date: Mon, 26 Mar 2018 11:35:27 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082127-58900-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following Oops can be encountered if a device removal or system
shutdown is initiated while an EEH recovery is in process:

[c000000ff2f479c0] c008000015256f18 cxlflash_pci_slot_reset+0xa0/0x100
                                      [cxlflash]
[c000000ff2f47a30] c00800000dae22e0 cxl_pci_slot_reset+0x168/0x290 [cxl]
[c000000ff2f47ae0] c00000000003ef1c eeh_report_reset+0xec/0x170
[c000000ff2f47b20] c00000000003d0b8 eeh_pe_dev_traverse+0x98/0x170
[c000000ff2f47bb0] c00000000003f80c eeh_handle_normal_event+0x56c/0x580
[c000000ff2f47c60] c00000000003fba4 eeh_handle_event+0x2a4/0x338
[c000000ff2f47d10] c0000000000400b8 eeh_event_handler+0x1f8/0x200
[c000000ff2f47dc0] c00000000013da48 kthread+0x1a8/0x1b0
[c000000ff2f47e30] c00000000000b528 ret_from_kernel_thread+0x5c/0xb4

The remove handler frees AFU memory while the EEH recovery is in progress,
leading to a race condition. This can result in a crash if the recovery
thread tries to access this memory.

To resolve this issue, the cxlflash remove handler will evaluate the
device state and yield to any active reset or probing threads.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 42a95b7..dfe7648 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -946,9 +946,9 @@ static void cxlflash_remove(struct pci_dev *pdev)
 		return;
 	}
 
-	/* If a Task Management Function is active, wait for it to complete
-	 * before continuing with remove.
-	 */
+	/* Yield to running recovery threads before continuing with remove */
+	wait_event(cfg->reset_waitq, cfg->state != STATE_RESET &&
+				     cfg->state != STATE_PROBING);
 	spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
 	if (cfg->tmf_active)
 		wait_event_interruptible_lock_irq(cfg->tmf_waitq,
-- 
2.1.0
