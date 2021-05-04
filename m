Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05060C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 03:09:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C6061176
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 03:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C6061176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZ4Yv29swz3d63
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 13:09:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r7UPI/8d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=r7UPI/8d; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZ4SF00fbz3005
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 13:04:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14432k6b152217; Mon, 3 May 2021 23:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WiEr7S6HAFkq9Ytp0m+amn449sv6uOK0HAHhFh2gIFo=;
 b=r7UPI/8d4UGUhqpoJWxFS0cA5O/Lcs/vvVC6aUcwGVwrzOuStAIA3YhQ76xue9H44iP0
 R0+egVROdSOalurC6L/fGJgBZaQ7KlesS9wk0SCwIlpIy3g6dYT2ZEmEB70uN5EHVAsr
 IMnaXuqBsy9dwtDDTHvowJ26TBWn2+jJF67eSJOOraOJRYwELxrpEdZGElIdmoGjMjUW
 05uoTRRaccheETxJQZxAkvKnOB0WoXMJYtBtueVI/Zgadow9QhAXXnJbQMo5ndxJ5UmK
 +XIzlNCMqaGdlYTQ1WcX/6AhC5w8GhWiQyFeruoC5f4Y3WijFTriU8JR4kQXYBQ6qphy wA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38awgv8gpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 May 2021 23:04:09 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1442vqsG001282;
 Tue, 4 May 2021 03:04:08 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 388xm972p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 03:04:08 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 144347Cq39518472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 May 2021 03:04:07 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79153AC05B;
 Tue,  4 May 2021 03:04:07 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41A48AC059;
 Tue,  4 May 2021 03:04:07 +0000 (GMT)
Received: from localhost (unknown [9.211.126.236])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  4 May 2021 03:04:07 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC 10/10] powerpc/rtas_flash: convert to rtas_sched_if_busy()
Date: Mon,  3 May 2021 22:03:58 -0500
Message-Id: <20210504030358.1715034-11-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504030358.1715034-1-nathanl@linux.ibm.com>
References: <20210504030358.1715034-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: csBv_A_S8VBfiOmWvl5xBlZRs5atqD9p
X-Proofpoint-ORIG-GUID: csBv_A_S8VBfiOmWvl5xBlZRs5atqD9p
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-04_01:2021-05-03,
 2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=929 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040023
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
Cc: aik@ozlabs.ru, ajd@linux.ibm.com, tyreld@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

rtas_sched_if_busy() has better behavior for RTAS_BUSY (-2) and small
extended delay values.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a99179d83538..bedefb9178ec 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -378,7 +378,7 @@ static void manage_flash(struct rtas_manage_flash_t *args_buf, unsigned int op)
 	do {
 		rc = rtas_call(rtas_token("ibm,manage-flash-image"), 1, 1,
 			       NULL, op);
-	} while (rtas_busy_delay(rc));
+	} while (rtas_sched_if_busy(rc));
 
 	args_buf->status = rc;
 }
@@ -456,7 +456,7 @@ static void validate_flash(struct rtas_validate_flash_t *args_buf)
 			       (u32) __pa(rtas_data_buf), args_buf->buf_size);
 		memcpy(args_buf->buf, rtas_data_buf, VALIDATE_BUF_SIZE);
 		spin_unlock(&rtas_data_buf_lock);
-	} while (rtas_busy_delay(rc));
+	} while (rtas_sched_if_busy(rc));
 
 	args_buf->status = rc;
 	args_buf->update_results = update_results;
-- 
2.30.2

