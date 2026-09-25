Return-Path: <linuxppc-dev+bounces-28156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C39DC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 04:49:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrdWP0wMtz3bbY;
	Fri, 25 Sep 2026 14:48:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790311713;
	cv=none; b=QyY4UiQDzH3W2DLvwPrGDpaLBqa7I+rHHjCx6xpgUgSMjBlZssCNprumrUMxbwS4tcIyi9/N4YFY7VAkjy5EgOkYCxJelEjlR/c4mvtrrSg1gxPhBXk3ek3x1jqpzH1JgdDjmfSjGvLGt8eI3HN5o5VwqxYdnxIL8LTheNSeCgTqRkQ0EsXTS6wNw0VZx26cyksgKXxegE5HbmBN4h9siOlOFRDaP7UDDJO+VKXaAkDTAVPrNbEulb8GAN7F/jRmWtdZS+cEqF05rS4Jhon8wCtycv69P6StdGDD4i0JlhOX2bDqmYNlscVZ7SEQERlGhjMAV4DmMjzqnNBmJpgfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790311713; c=relaxed/relaxed;
	bh=JUKiUsRnWKd0DWGYizm+NwQe/3rOK2AG/MaGniTV4XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBbdnFeqfuXAFobDRYPzJbkj8EhVARUxYEagZOT5xiM6mtmAl18m3dGaMVl0me4kU5ZnZ6rxFbXJxZwm9YZ9wE/XxKohfjOOzJn3fWOhMb8AbL0RJ/PhXNHW0ls/dJEhb0+vLaT+Vb4xACA8NGwRRjnRIW0TAiryjmri3cQWGDRld5akaNHC2k6G5vpUShajeWqRvLcFBekkAR5OuP3gvP7Pu9gnoh86M5Ikcgh8gYbDFNOdPWiAwH/5/R5fI+1zIqCH5s9L1QnBJbEtTJ6RasJ+yOEd1mRm5JUjyc12q1hwY10iOi2QGsP86GfRJGD+WbY+YDUJv79xVFirxcoP9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hFQB2LJO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hFQB2LJO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrdWM4N2Tz30Vn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 14:48:31 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4amAt103433;
	Fri, 25 Sep 2026 04:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JUKiUsRnWKd0DWGYi
	zm+NwQe/3rOK2AG/MaGniTV4XI=; b=hFQB2LJOq2MiR/pmHWkzAemxkAk6uhgcY
	TJ91fJjmbSqlnVJibIHPwhxTLjdep3WoMUEmLeY2TT2mGm/A5P2uEn+LTghscxLe
	BmPDdcLjV4XSwySJsEybanLTlSbEESDQn9EiMLJu8eTE4L8Hpbj12JWi+tviELPb
	qkp9klGz1kzE0QZf5nfZmRGJCiPRgFu5PAtbRZJLp/8xk+bYzLv/s52p0hrLALMU
	ftazz12M8JYcmHYd0t9yduzXnjSbl/bTd1EHCY8kJcBNXcYth3pSEOAxms5L/N4S
	Od7XJQlJNVkddgL3AyAsyRLCAuEp4gAzHNuAEZhDmJ+opkJDmF25w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvm9yc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ldFJ3248931;
	Fri, 25 Sep 2026 04:48:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt30y1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:48:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P4mQpf12780250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 04:48:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7491A5805C;
	Fri, 25 Sep 2026 04:48:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D885805E;
	Fri, 25 Sep 2026 04:48:25 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.142.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 04:48:25 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v11 06/11] scsi: ibmvfc: add FPIN extended flag and async sub-CRQ queue handle
Date: Thu, 24 Sep 2026 21:48:55 -0700
Message-ID: <20260925044900.414340-7-tyreld@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lnc10Cjde8nyzNGxCIAZTOnu050SalQr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfX61V7lRRy1yP3
 gK85jnm+3NW0lz0Z01ux/F2x5f2yHSuZzs1E4hkUzk+6aEzICaHJGF2Z9oUaTbdrbGEG71K0Rzo
 3GkmQ0g3m5ry0cqqqbiSha+6iawWZLc=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab5fd1c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=_ck89SwLLagabBJyydIA:9
X-Proofpoint-GUID: lnc10Cjde8nyzNGxCIAZTOnu050SalQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAxOCBTYWx0ZWRfXwPv8AJ6XuE7G
 SYCpDeyyt1sE6cuOSXFMbz98NWO53Tg53pPlt27LYRX0P3tmP6OsIf263HCAtwtRirZVxPq6Y54
 6gwYYqqD7h7x5gCLxikxp9OpUqXxYJOkRBKFS0OrI/Y82PEpFYY1ivdaZMx1L3LvPW4VDS6XWh5
 X4ZV3XPP4C80DTv8Kw7qdYCPrMkLuKul8UIT9aBeR4Ho46lBM962sj7VgeSLI32VhJxfSVv4zvp
 Qh8DxSIwoO1Iv2qV5AcRkI8L6pL/KPTUwSbskkOugupPsNhyTUfkzeUQwf3wSPRuwtU0dCegf3j
 jts7rIvKGOVYqpVX2xVK9aJxig/YkFp3HZ/FUPkq8qKxaePJRvOYnqOz+HXb3u5PFx6cCodsxpj
 zNO8hIS9ejBeQKP3MJUffibfTzv8QNbRefY3itCqPDqETE5GYB28fqbCVO4emmSjXSEEnfu4E7e
 ix8O+BEDu40QGDD1hgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250018

From: Dave Marquardt <davemarq@linux.ibm.com>

Add IBMVFC_ASYNC_IS_FPIN_EXT flag bit (0x02) to ibmvfc_async_sub_crq.flags
to distinguish extended FPIN events from standard ones.

Add async_scrqs field of type ibmvfc_channels to ibmvfc_host to hold the
channel set for the asynchronous sub-CRQ, alongside the existing scsi_scrqs
and nvme_scrqs channels. This uses the same ibmvfc_channels infrastructure
as the SCSI and NVMe channel queues.

Add IBMVFC_ASYNC_SUB_CRQ_FMT to enum ibmvfc_msg_fmt and a corresponding
async_scrq pointer to union ibmvfc_msgs to support the new async sub-CRQ
message format.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index d7a30e7a4a28..df2f312fd7b9 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -773,6 +773,7 @@ struct ibmvfc_async_sub_crq {
 	volatile u8 valid;
 	u8 flags;
 #define IBMVFC_ASYNC_ID_IS_ASSOC_ID	0x01
+#define IBMVFC_ASYNC_IS_FPIN_EXT	0x02
 	u8 link_state;
 	u8 fpin_status;
 	__be16 event;
@@ -893,6 +894,7 @@ enum ibmvfc_msg_fmt {
 	IBMVFC_CRQ_FMT = 0,
 	IBMVFC_ASYNC_FMT,
 	IBMVFC_SUB_CRQ_FMT,
+	IBMVFC_ASYNC_SUB_CRQ_FMT,
 };
 
 union ibmvfc_msgs {
@@ -900,6 +902,7 @@ union ibmvfc_msgs {
 	struct ibmvfc_crq *crq;
 	struct ibmvfc_async_crq *async;
 	struct ibmvfc_sub_crq *scrq;
+	struct ibmvfc_async_sub_crq *async_scrq;
 };
 
 struct ibmvfc_queue {
@@ -992,6 +995,7 @@ struct ibmvfc_host {
 	struct ibmvfc_queue async_crq;
 	struct ibmvfc_channels scsi_scrqs;
 	struct ibmvfc_channels nvme_scrqs;
+	struct ibmvfc_channels async_scrqs;
 	struct ibmvfc_npiv_login login_info;
 	union ibmvfc_npiv_login_data *login_buf;
 	dma_addr_t login_buf_dma;
-- 
2.55.0


