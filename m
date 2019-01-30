Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F007C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:32:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1A920882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 12:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1A920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qN6d6Z01zDqNl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 23:32:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qN0T4chfzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 23:27:05 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UCOR3x073320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 07:27:03 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qbayku01d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 07:27:02 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Wed, 30 Jan 2019 12:27:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 30 Jan 2019 12:26:58 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0UCQu2U7733672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Jan 2019 12:26:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DDEDAE055;
 Wed, 30 Jan 2019 12:26:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0935AE04D;
 Wed, 30 Jan 2019 12:26:54 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.223.93])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 30 Jan 2019 12:26:54 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Manoj N . Kumar" <manoj@linux.ibm.com>,
 "Matthew R . Ochs" <mrochs@linux.ibm.com>,
 Uma Krishnan <ukrishn@linux.ibm.com>
Subject: [PATCH] scsi: cxlflash: Prevent deadlock when adapter probe fails
Date: Wed, 30 Jan 2019 17:56:51 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19013012-0012-0000-0000-000002EEE97D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013012-0013-0000-0000-00002126304F
Message-Id: <20190130122651.19255-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300099
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, linux-scsi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Presently when an error is encountered during probe of the cxlflash
adapter, a deadlock is seen with cpu thread stuck inside
cxlflash_remove(). Below is the trace of the deadlock as logged by
khungtaskd:

cxlflash 0006:00:00.0: cxlflash_probe: init_afu failed rc=-16
INFO: task kworker/80:1:890 blocked for more than 120 seconds.
       Not tainted 5.0.0-rc4-capi2-kexec+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/80:1    D    0   890      2 0x00000808
Workqueue: events work_for_cpu_fn

Call Trace:
 0x4d72136320 (unreliable)
 __switch_to+0x2cc/0x460
 __schedule+0x2bc/0xac0
 schedule+0x40/0xb0
 cxlflash_remove+0xec/0x640 [cxlflash]
 cxlflash_probe+0x370/0x8f0 [cxlflash]
 local_pci_probe+0x6c/0x140
 work_for_cpu_fn+0x38/0x60
 process_one_work+0x260/0x530
 worker_thread+0x280/0x5d0
 kthread+0x1a8/0x1b0
 ret_from_kernel_thread+0x5c/0x80
INFO: task systemd-udevd:5160 blocked for more than 120 seconds.

The deadlock occurs as cxlflash_remove() is called from
cxlflash_probe() without setting 'cxlflash_cfg->state' to STATE_PROBED
and the probe thread starts to wait on
'cxlflash_cfg->reset_waitq'. Since the device was never successfully
probed the 'cxlflash_cfg->state' never changes from STATE_PROBING
hence the deadlock occurs.

We fix this deadlock by setting the variable 'cxlflash_cfg->state' to
STATE_PROBED in case an error occurs during cxlflash_probe() and just
before calling cxlflash_remove().

Cc: stable@vger.kernel.org
Fixes: c21e0bbfc485("cxlflash: Base support for IBM CXL Flash Adapter")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index bfa13e3b191c..c8bad2c093b8 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3687,6 +3687,7 @@ static int cxlflash_probe(struct pci_dev *pdev,
 	host->max_cmd_len = CXLFLASH_MAX_CDB_LEN;
 
 	cfg = shost_priv(host);
+	cfg->state = STATE_PROBING;
 	cfg->host = host;
 	rc = alloc_mem(cfg);
 	if (rc) {
@@ -3775,6 +3776,7 @@ static int cxlflash_probe(struct pci_dev *pdev,
 	return rc;
 
 out_remove:
+	cfg->state = STATE_PROBED;
 	cxlflash_remove(pdev);
 	goto out;
 }
-- 
2.20.1

