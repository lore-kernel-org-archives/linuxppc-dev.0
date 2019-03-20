Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF6EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:52:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F1B20835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F1B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Pmv35J3zzDqQ8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:52:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PmqZ387HzDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 10:49:46 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2KNnGlL124844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 19:49:43 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rbv8pg0pn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 19:49:43 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 20 Mar 2019 23:49:39 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 23:49:37 -0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2KNndZ341484532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2019 23:49:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65F7713604F;
 Wed, 20 Mar 2019 23:49:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C919136059;
 Wed, 20 Mar 2019 23:49:38 +0000 (GMT)
Received: from linux-xej6.aus.stglabs.ibm.com (unknown [9.40.195.184])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2019 23:49:38 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Subject: [PATCH 2/2] ibmvscsi: Fix empty event pool access during host removal
Date: Wed, 20 Mar 2019 13:41:51 -0500
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190320184151.31321-1-tyreld@linux.vnet.ibm.com>
References: <20190320184151.31321-1-tyreld@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032023-0020-0000-0000-00000ECB5ABD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177289; UDB=6.00615853; IPR=6.00957984; 
 MB=3.00026081; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-20 23:49:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032023-0021-0000-0000-000065283E22
Message-Id: <20190320184151.31321-2-tyreld@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200169
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
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The event pool used for queueing commands is destroyed fairly early in
the ibmvscsi_remove() code path. Since, this happens prior to the call
so scsi_remove_host() it is possible for further calls to queuecommand
to be processed which manifest as a panic due to a NULL pointer
dereference as seen here:

PANIC: "Unable to handle kernel paging request for data at address
0x00000000"

Context process backtrace:

DSISR: 0000000042000000 ????Syscall Result: 0000000000000000
4 [c000000002cb3820] memcpy_power7 at c000000000064204
[Link Register] [c000000002cb3820] ibmvscsi_send_srp_event at d000000003ed14a4
5 [c000000002cb3920] ibmvscsi_send_srp_event at d000000003ed14a4 [ibmvscsi] ?(unreliable)
6 [c000000002cb39c0] ibmvscsi_queuecommand at d000000003ed2388 [ibmvscsi]
7 [c000000002cb3a70] scsi_dispatch_cmd at d00000000395c2d8 [scsi_mod]
8 [c000000002cb3af0] scsi_request_fn at d00000000395ef88 [scsi_mod]
9 [c000000002cb3be0] __blk_run_queue at c000000000429860
10 [c000000002cb3c10] blk_delay_work at c00000000042a0ec
11 [c000000002cb3c40] process_one_work at c0000000000dac30
12 [c000000002cb3cd0] worker_thread at c0000000000db110
13 [c000000002cb3d80] kthread at c0000000000e3378
14 [c000000002cb3e30] ret_from_kernel_thread at c00000000000982c

The kernel buffer log is overfilled with this log:

[11261.952732] ibmvscsi: found no event struct in pool!

This patch reorders the operations during host teardown. Start by
calling the SRP transport and Scsi_Host remove functions to flush any
outstanding work and set the host offline. LLDD teardown follows
including destruction of the event pool, freeing the Command Response
Queue (CRQ), and unmapping any persistent buffers. The event pool
destruction is protected by the scsi_host lock, and the pool is purged
prior of any requests for which we never received a response. Finally,
move the removal of the scsi host from our global list to the end so
that the host is easily locatable for debugging purposes during
teardown.

Cc: <stable@vger.kernel.org> # v2.6.12+
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 2b22969f3f63..8cec5230fe31 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2295,17 +2295,27 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 static int ibmvscsi_remove(struct vio_dev *vdev)
 {
 	struct ibmvscsi_host_data *hostdata = dev_get_drvdata(&vdev->dev);
-	spin_lock(&ibmvscsi_driver_lock);
-	list_del(&hostdata->host_list);
-	spin_unlock(&ibmvscsi_driver_lock);
-	unmap_persist_bufs(hostdata);
+	unsigned long flags;
+
+	srp_remove_host(hostdata->host);
+	scsi_remove_host(hostdata->host);
+
+	purge_requests(hostdata, DID_ERROR);
+
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	release_event_pool(&hostdata->pool, hostdata);
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+
 	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,
 					max_events);
 
 	kthread_stop(hostdata->work_thread);
-	srp_remove_host(hostdata->host);
-	scsi_remove_host(hostdata->host);
+	unmap_persist_bufs(hostdata);
+
+	spin_lock(&ibmvscsi_driver_lock);
+	list_del(&hostdata->host_list);
+	spin_unlock(&ibmvscsi_driver_lock);
+
 	scsi_host_put(hostdata->host);
 
 	return 0;
-- 
2.12.3

