Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B0C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 20:48:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D5E204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 20:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D5E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430ZRj6z5SzF3Jx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 07:48:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tlfalcon@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430Tmt4Y1bzF3b4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 04:18:22 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wALHFJx6025656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 12:18:20 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nwam7atad-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 12:18:20 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.ibm.com>;
 Wed, 21 Nov 2018 17:18:19 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 21 Nov 2018 17:18:17 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wALHIFAc12386432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Nov 2018 17:18:15 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60B65BE04F;
 Wed, 21 Nov 2018 17:18:15 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67484BE056;
 Wed, 21 Nov 2018 17:18:14 +0000 (GMT)
Received: from oc3765557031.ibm.com (unknown [9.85.175.152])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 21 Nov 2018 17:18:14 +0000 (GMT)
From: Thomas Falcon <tlfalcon@linux.ibm.com>
To: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net 2/2] ibmvnic: Update driver queues after change in ring
 size support
Date: Wed, 21 Nov 2018 11:17:59 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1542820679-30184-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1542820679-30184-1-git-send-email-tlfalcon@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112117-8235-0000-0000-00000E2C4A65
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010094; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01120746; UDB=6.00581582; IPR=6.00900868; 
 MB=3.00024265; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-21 17:18:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112117-8236-0000-0000-000043705368
Message-Id: <1542820679-30184-3-git-send-email-tlfalcon@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-21_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210149
X-Mailman-Approved-At: Thu, 22 Nov 2018 07:44:48 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: tyreld@linux.ibm.com, Thomas Falcon <tlfalcon@linux.ibm.com>,
 mwb@linux.ibm.com, julietk@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

During device reset, queue memory is not being updated to accommodate
changes in ring buffer sizes supported by backing hardware. Track
any differences in ring buffer sizes following the reset and update
queue memory when possible.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 066897a..c0203a0 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1737,6 +1737,7 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 		    struct ibmvnic_rwi *rwi, u32 reset_state)
 {
 	u64 old_num_rx_queues, old_num_tx_queues;
+	u64 old_num_rx_slots, old_num_tx_slots;
 	struct net_device *netdev = adapter->netdev;
 	int i, rc;
 
@@ -1748,6 +1749,8 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 
 	old_num_rx_queues = adapter->req_rx_queues;
 	old_num_tx_queues = adapter->req_tx_queues;
+	old_num_rx_slots = adapter->req_rx_add_entries_per_subcrq;
+	old_num_tx_slots = adapter->req_tx_entries_per_subcrq;
 
 	ibmvnic_cleanup(netdev);
 
@@ -1810,7 +1813,11 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			if (rc)
 				return rc;
 		} else if (adapter->req_rx_queues != old_num_rx_queues ||
-			   adapter->req_tx_queues != old_num_tx_queues) {
+			   adapter->req_tx_queues != old_num_tx_queues ||
+			   adapter->req_rx_add_entries_per_subcrq !=
+							old_num_rx_slots ||
+			   adapter->req_tx_entries_per_subcrq !=
+							old_num_tx_slots) {
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
 			release_napi(adapter);
-- 
1.8.3.1

