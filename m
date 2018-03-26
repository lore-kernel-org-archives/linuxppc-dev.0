Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40904V16sdzF232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:30:33 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGSxgJ064589
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:30:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gy1t289k3-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:30:31 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:30:30 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 02/41] cxlflash: Avoid clobbering context control register
 value
Date: Mon, 26 Mar 2018 11:30:22 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522081822-57523-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

The SISLite specification originally defined the context control
register with a single field of bits to represent the LISN and
also stipulated that the register reset value be 0. The cxlflash
driver took advantage of this when programming the LISN for the
master contexts via an unconditional write - no other bits were
preserved.

When unmap support was added, SISLite was updated to define bit
0 of the context control register as a way for the AFU to notify
the context owner that unmap operations were supported. Thus the
assumptions under which the register is setup changed and the
existing unconditional write is clobbering the unmap state for
master contexts. This is presently not an issue due to the order
in which the context control register is programmed in relation to
the unmap bit being queried but should be addressed to avoid a
future regression in the event this code is moved elsewhere.

To remedy this issue, preserve the bits when programming the LISN
field in the context control register. Since the LISN will now be
programmed using a read value, assert that the initial state of the
LISN field is as described in SISLite (0).

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c    | 5 ++++-
 drivers/scsi/cxlflash/sislite.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 3d3e003..b83a55a 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1303,7 +1303,10 @@ static void afu_err_intr_init(struct afu *afu)
 	for (i = 0; i < afu->num_hwqs; i++) {
 		hwq = get_hwq(afu, i);
 
-		writeq_be(SISL_MSI_SYNC_ERROR, &hwq->host_map->ctx_ctrl);
+		reg = readq_be(&hwq->host_map->ctx_ctrl);
+		WARN_ON((reg & SISL_CTX_CTRL_LISN_MASK) != 0);
+		reg |= SISL_MSI_SYNC_ERROR;
+		writeq_be(reg, &hwq->host_map->ctx_ctrl);
 		writeq_be(SISL_ISTATUS_MASK, &hwq->host_map->intr_mask);
 	}
 }
diff --git a/drivers/scsi/cxlflash/sislite.h b/drivers/scsi/cxlflash/sislite.h
index bedf1ce..d8940f1 100644
--- a/drivers/scsi/cxlflash/sislite.h
+++ b/drivers/scsi/cxlflash/sislite.h
@@ -284,6 +284,7 @@ struct sisl_host_map {
 	__be64 cmd_room;
 	__be64 ctx_ctrl;	/* least significant byte or b56:63 is LISN# */
 #define SISL_CTX_CTRL_UNMAP_SECTOR	0x8000000000000000ULL /* b0 */
+#define SISL_CTX_CTRL_LISN_MASK		(0xFFULL)
 	__be64 mbox_w;		/* restricted use */
 	__be64 sq_start;	/* Submission Queue (R/W): write sequence and */
 	__be64 sq_end;		/* inclusion semantics are the same as RRQ    */
-- 
2.1.0
