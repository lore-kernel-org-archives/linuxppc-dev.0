Return-Path: <linuxppc-dev+bounces-27524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4D1C982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 23:11:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlZN94hvxz3bmQ;
	Thu, 17 Sep 2026 09:09:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789600185;
	cv=none; b=bL1/fOodvYT1w1Vw1e8Wxg7LpJKkJ64ej7TBhD64cV9VVO8GKmdZS7DXcqbkhZwwYElLwmjmm/Sp0hRr11tLQt7veGQwuJgixVcHGCn2pgNxx0xLo0lu6N+sapcrkDtchKHCwoTAMg7JNcd03qv1QwuKd1xDmZxGseGDwmnLTldJQeE3Stdx64RhuB6lPTmppsOgf9i/rINLDSmE0DEFhy6+Hq8UrR/aHTHHdcYoY+5bjIiKKrG/XH7XnSmAUlEA9R3Rg/dL2Q6aAJOdhaWVQ2w9u81FY49XzAuO0sYLZ+OO8CSPiIsvfS5IjT+duordZgS8Y7RFXbI5VYPZ6Ui79A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789600185; c=relaxed/relaxed;
	bh=rRGClmLfdI+ky+NkVLKwrOC8+1UKQ5lurLYhttbQnyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l37W9764yPOjQRxTF6LRl8tHIxgTl4WubaTzoSPDgCzLF22RoVuMt+sefnqA2duuh+YIr0JXLtJblagCLzWR86skcZBQG0M8yEd/4BsMUxLCU59Vo+uKjEaVGLIHXCTjj/b4kYEny2zFaMIIPPYvXwIEhmbQ28fg6NRhfmLHmkxxnFNe8VfS326E8dqnTnl1Y4+q12R7APoQ05KjtWww6N00XJVP0zzm4KKHS0EtLJeKXmo9ZJbkwfD8V0QbMDL9Ag9NVepNP5s41GF7GJnYZuhm73EpDUd8KQlnhz0f91f6tJdXknP/7WHN1Gcx2HC5BCAacMIH+FHxvlAwtPCPtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jGHFSZHs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jGHFSZHs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlZN908MFz3bm3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:09:44 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1Vs9006704;
	Wed, 16 Sep 2026 23:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rRGClm
	LfdI+ky+NkVLKwrOC8+1UKQ5lurLYhttbQnyU=; b=jGHFSZHs7YAPzQBZOQrrLe
	IiPAzt3/s6udLiJ/rMpAklqxROGwp6Uu4v264xKMLqRjD+rY8quR+FABIbOnwKwP
	2jsO4urD+dGOb+kRbGypsxu92m0w/LDT66VGrL0kDZcAZfC32UBzw7Ixgxii/dia
	fZnK/HKqvAC2XepoQ8cSmBe3LRg1+K2W+cnOZ2MIF8mjvJCOo9mPr1Y+o58F8WlP
	zXrwp7MxSgPm09NuVeIcCbTl662eEFhOxwk++ud1+u/x+UVXxKfplUf61kl0/J2j
	lOyqPXAfx+vWREMsl8tg55C9jbfqn8RiepQCYv3XWStgrJZz/tAiuL+vGvS0JNZw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83ydyr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMnhpK1663474;
	Wed, 16 Sep 2026 23:09:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089rtjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:09:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GN9dl932899816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 23:09:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBBF58054;
	Wed, 16 Sep 2026 23:09:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 991B75804E;
	Wed, 16 Sep 2026 23:09:38 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.141.190])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 23:09:38 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 11/20] scsi: ibmvfc: fix UAF and hang in ibmvfc_cancel_all_mq() on send failure
Date: Wed, 16 Sep 2026 16:09:12 -0700
Message-ID: <20260916230921.2204729-12-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916230921.2204729-1-tyreld@linux.ibm.com>
References: <20260916230921.2204729-1-tyreld@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXyEJM+q/jKb0r
 KvsOqEXPKlDXQDhnDnjKkwrxAwExEs/s+6u/XSqpb+yTDSXNVljorO/65SB0LOwbOmEELOSlivO
 zeW+Jg7KSPbq9epw2QKX95an4KSDUemQL28V5kHaDwaDsWW+M52JGdzvDh6M/sRDiwbQrSNNpHG
 cUZgWS1Aqns+4TP0BCkE8j6oxePLNG53RiA6YT3KKGpl66O+yWtUOWSC8l+eZsTCWI9PDcT2dJK
 ICG/vIRB9/4FbgZXep6w5XQjUjUdO1JZQbP25q3IZPqoOw+/Xblvzo2Ewv893VtZbQffkTuoHPE
 SDQ3M3lqPJK+MjwRdXocvhfixzdzMTObA4nOCOSU2xuzgnVzFos0mx3YXdiRQY1SvnXVtbxKwDA
 UP7m9qoRqj2PbFLKkSiqQduyXnNPchnji45+yRFsLb0wfmxyTkwvXARmX1E6rWML8ndzwvsVPp7
 R5jnACvcz8Wi//Wg6og==
X-Proofpoint-ORIG-GUID: aMA0zyScOwWsNfQb8P309C9tiAJR1otE
X-Proofpoint-GUID: aMA0zyScOwWsNfQb8P309C9tiAJR1otE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX9cBjh0rYhyQ+
 0Wmc5cD5Y56FN9JKz9FWyJrbCypnx0bBdZDGMoLyzCNcvZl6MSAjpm3ulnhnYHEtIKMbomVUOuF
 AlH3BZVqXNRsb7HQznvUK9pO4B5BNHs=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab21b6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=nlcoev9x_0hUi8ert_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322

ibmvfc_cancel_all_mq() discards the return value of ibmvfc_send_event().
When ibmvfc_send_event() fails due to H_CLOSED it internally frees the
event before returning SCSI_MLQUEUE_HOST_BUSY. The caller then performs
list_add_tail() on the freed event — a use-after-free — and subsequently
blocks indefinitely on wait_for_completion(&evt->comp) for a completion
that will never arrive.

Fix by capturing the return value. On failure, drop the locks, log the
error (consistent with ibmvfc_cancel_all_sq()), drain and free any
cancel events already queued from earlier loop iterations, then return 0.
Returning 0 on send failure is correct: when the adapter closes the CRQ
the firmware delivers a transport event through ibmvfc_handle_crq() which
completes all outstanding commands, so the error recovery caller will
naturally see them return.

Fixes: 5ca8f4e826ff ("ibmvfc: don't call locked done variant for MADs on send failure")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index e2f2fa42bcfd..190410847efb 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -2693,6 +2693,7 @@ static int ibmvfc_cancel_all_mq(struct scsi_device *sdev, int type)
 	unsigned long flags;
 	int num_hwq, i;
 	int fail = 0;
+	int rc;
 	LIST_HEAD(cancelq);
 	u16 status;
 
@@ -2719,7 +2720,18 @@ static int ibmvfc_cancel_all_mq(struct scsi_device *sdev, int type)
 				return -ENOMEM;
 			}
 			evt->sync_iu = &queues[i].cancel_rsp;
-			ibmvfc_send_event(evt, vhost, default_timeout);
+			rc = ibmvfc_send_event(evt, vhost, default_timeout);
+			if (rc) {
+				spin_unlock(queues[i].q_lock);
+				spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+				sdev_printk(KERN_ERR, sdev, "Failed to send cancel event. rc=%d\n", rc);
+				list_for_each_entry_safe(evt, temp, &cancelq, cancel) {
+					wait_for_completion(&evt->comp);
+					list_del(&evt->cancel);
+					ibmvfc_free_event(evt);
+				}
+				return 0;
+			}
 			list_add_tail(&evt->cancel, &cancelq);
 		}
 
-- 
2.55.0


