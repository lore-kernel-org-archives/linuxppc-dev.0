Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4RHS3bCCzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 07:37:24 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73LYDig000815
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 17:37:22 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkahcy48-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 17:37:22 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 15:37:21 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH] ibmvfc: Set READ FCP_XFER_READY DISABLED bit in PRLI
Date: Wed,  3 Aug 2016 16:36:52 -0500
In-Reply-To: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
Message-Id: <1470260213-19087-2-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The READ FCP_XFER_READY DISABLED bit is required to always be set to
one since FCP-3. Set it in the service parameter page frame during
process login.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index ab67ec4..4a680ce 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3381,6 +3381,7 @@ static void ibmvfc_tgt_send_prli(struct ibmvfc_target *tgt)
 	prli->parms.type = IBMVFC_SCSI_FCP_TYPE;
 	prli->parms.flags = cpu_to_be16(IBMVFC_PRLI_EST_IMG_PAIR);
 	prli->parms.service_parms = cpu_to_be32(IBMVFC_PRLI_INITIATOR_FUNC);
+	prli->parms.service_parms |= cpu_to_be32(IBMVFC_PRLI_READ_FCP_XFER_RDY_DISABLED);
 
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_INIT_WAIT);
 	if (ibmvfc_send_event(evt, vhost, default_timeout)) {
-- 
2.7.4
