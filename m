Return-Path: <linuxppc-dev+bounces-28158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E66C98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 04:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrdWR4t7sz3bhH;
	Fri, 25 Sep 2026 14:48:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790311715;
	cv=none; b=VyJudLNvysyGVDjCBQFfcbS/Fsp/uYWYzTDxaJwJfJ/uJNT0KIhm9wC7cY/lJYQHVdpox/nUq9v0KXHCgaAb0cSQWyhzt4HGuM6/ZlikmhBToayxq0l94CCbkPeH5Yg5YetXXB8wpTcqo8U05I/l0J2V2Iv28WoWLj1zaIhnnAFxC37bCYLzcPwYweapYaPj1XK+VZRPX0uvj0cc1JOX9Tm5xH9n+fU7Cs3hOKvUsSGc4Z9lcWBcd4CRf9yxPu5+2hNr/MofuavhnEA93aCYou9z2RN2V48CQzrgsU57G0Dk67n038IXU/9FtuZXuSut9wGca+/yo9Yim74LG9kZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790311715; c=relaxed/relaxed;
	bh=x0YcKBRgZN6dyN1BoxGupBY4J52MP3XNvWFFfqScVng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3//bC04mPeUkmNQeuRIiVVY9Cm2tBkDtIvAfqtpx54+L3exGT8FkG63q2D7DEc/edqagjrehThXIQ9yly1vPrKTfB7FshGqsv3r040JnF3RrKtrDdyQK5ZwvF/oiv5gXxErwXSz5dD2Dbqr0zxK1/lJe/w9A0agCX5dWQDX0GbnmGkGJNUif6cKCv3yShOGbwJXmjTH+micZCQIROwj639xz+3OmhYn/oftJqLU0GEevnCb/YIAEBI24FsoNcTL7lnaxOyI+QIyKHq78PXyIPZQ3iivGv3gqDsd1LFH3gcp3r9002eGg6acv0A0aMZht640M2jf36mTywV0nI9iWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cztjSUyd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cztjSUyd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrdWP3Blbz3bc6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 14:48:33 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aOIu2393772;
	Fri, 25 Sep 2026 04:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x0YcKBRgZN6dyN1Bo
	xGupBY4J52MP3XNvWFFfqScVng=; b=cztjSUyd4qcj7xRtn5SKg/nPMWXJv6BmU
	Bxpij1PXMuWA8lsVjf8OOIPgG+Sr/ZR3TCaIIb9HGzpWrFkR0G5uc9ZhFiFsHDPp
	CZgD4MAIJ8QnILxEURt3IZQ32E6pchx5Evox5tHhiWXpR6s7g10fucdTY2035lBz
	VxPbKS92jEd+XMNkBUwus7jwXWtCwAmzaIj0c4dxh9OcMY+csyu6FykfB+QtiK7i
	CpM6jru6np/EF25ORKn7qai4jIHEUXCBpufc6WHMvras0bJZSVIy4VlpplDe/UXe
	o1oLqm3NfpuxtHrV41C0I4gBmXTD3neBn7u4jjQCX+ylYMofiqOoA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske2568k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lYIV1959518;
	Fri, 25 Sep 2026 04:48:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ed91m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P4mS5p7733868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 04:48:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D6458051;
	Fri, 25 Sep 2026 04:48:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B47635805C;
	Fri, 25 Sep 2026 04:48:27 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.142.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 04:48:27 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v11 08/11] scsi: ibmvfc: add interrupt routine for asynchronous sub CRQ
Date: Thu, 24 Sep 2026 21:48:57 -0700
Message-ID: <20260925044900.414340-9-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925044900.414340-1-tyreld@linux.ibm.com>
References: <20260925044900.414340-1-tyreld@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _0pQjgQPQX4DhgM9g74M-1h3fQQlH_5Q
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab5fd1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=w-kvVH-zZ2E7PihfXZYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfX5yeTQZNKhXrY
 gn+RQzT0yw1CEj1s9g/knaUlNoI8Lzzfa+SeBEvTjUxOAp13cksfsyflh44ybTleLav+F/Zd9Ag
 vMwbqOGyjpJYmzHxa2UxDmlhxdvz0Sc=
X-Proofpoint-GUID: _0pQjgQPQX4DhgM9g74M-1h3fQQlH_5Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfX5P6R28GjWVCc
 XXNXKq4DFxRuw2OKhcMyjy7Am2bZQTQM5IOFRUpOxw40Bc3hNoDLwk3dweNgFSvlrml7yKOxlIz
 4JjYtTBNrYqE91TgFWTG5gnoqqdMBb/oKnUMevZ6Ou68+t/k4nxfyU1Etc7QbNfOxVgSSfotT1M
 K5DDYll9ReyhpORHI53aKgNp8ag7pVV3h1XblxrQJFkqq0uM6e+aOkgSTT3O19cQ8jNw0xfCbTh
 55RDX7PjA93zHAlQmD4VVYij3ZwLJ7UT25FS2KpxOMGjDchp0UOWGHWnPZ5KcxZfgEMusFfpjfr
 iThb49trYcCDzaLuIi8mWaaw24cN7fR3ZyFwFKB7bmjUKhn+M74xQS6iVeq2QGtbQ2KfdyJL8ae
 BerWBXhssHWfrAuUSUIRLyq3nkN/4Awf9kiq21REAB5RpsXKrug+amIgaJfjeAY2ljdm8i9Gy83
 9K3Zk0lxm4/C54zyaVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250018

From: Dave Marquardt <davemarq@linux.ibm.com>

Add ibmvfc_interrupt_async_subq(), an IRQ handler dedicated to
asynchronous sub-CRQ events from the adapter. The handler disables
the sub-CRQ IRQ and then calls ibmvfc_drain_async_subq() to consume
all pending entries before re-enabling interrupts.

ibmvfc_drain_async_subq() holds the per-queue q_lock while
processing. It loops over available CRQ entries via ibmvfc_next_scrq(),
wrapping each in a typed struct ibmvfc_async_crq_event and dispatching
it to ibmvfc_handle_async(), then clears the valid bit and issues a
write barrier. After draining, it re-enables the sub-CRQ IRQ and performs
one final check for a newly arrived entry to close the IRQ-enable race;
if one is found it is processed before exiting the loop.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 54 +++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 321bb2f7219e..b354bfb1a9b6 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4377,6 +4377,60 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
 	return crq;
 }
 
+static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_host *vhost = scrq->vhost;
+	unsigned long flags;
+	struct ibmvfc_crq *crq;
+	int done = 0;
+
+	spin_lock_irqsave(vhost->host->host_lock, flags);
+	spin_lock(scrq->q_lock);
+	while (!done) {
+		while ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
+			struct ibmvfc_async_crq_event ae = {
+				.type = IBMVFC_ASYNC_CRQ_SUB,
+				.subq = *(struct ibmvfc_async_sub_crq *)crq,
+			};
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		}
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		crq = ibmvfc_next_scrq(scrq);
+		if (crq != NULL) {
+			struct ibmvfc_async_crq_event ae = {
+				.type = IBMVFC_ASYNC_CRQ_SUB,
+				.subq = *(struct ibmvfc_async_sub_crq *)crq,
+			};
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		} else
+			done = 1;
+	}
+	spin_unlock(scrq->q_lock);
+	spin_unlock_irqrestore(vhost->host->host_lock, flags);
+}
+
+/**
+ * ibmvfc_interrupt_async_subq - Handle an async event from the adapter
+ * @irq:           interrupt request
+ * @scrq_instance: async subq
+ *
+ **/
+static irqreturn_t __maybe_unused ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
+{
+	struct ibmvfc_queue *scrq = (struct ibmvfc_queue *)scrq_instance;
+
+	ibmvfc_toggle_scrq_irq(scrq, 0);
+	ibmvfc_drain_async_subq(scrq);
+
+	return IRQ_HANDLED;
+}
+
 static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 {
 	struct ibmvfc_crq *crq;
-- 
2.55.0


