Return-Path: <linuxppc-dev+bounces-25071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389B6C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:35:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fbF4pqRz2yDs;
	Thu, 30 Jul 2026 16:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785393337;
	cv=none; b=G3J8X4Hdhx2P4QXkycYozAks6GXnNXuUdlK0Qw9Gp+ptKDceASoxLeWeSU3vflHBGB/APjROf0HpqCao4m7C0hxI4DqKupRuLhjJRE7cvDT5poLLdsqKSRKBfoVzG9yntPRGKOm8cDjh2Ic+1VNeLYd6zbTmBMJuWsTuXkTHiKEjehTrx0SK9X0AkvIvxsxxErW9qK4fux+v55KyrkfH5nmS7V45R+x2xkiNqIQTeuokpBF4uJVkDtYGe13bAcEbrQiPaQPIODdYZYTsaoOjCjcIgp2PxC+6u+o8FfnR25VEVLP+QOUzgADpsmOZ21IXGCiYVtoPsltxDO7Q84FcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785393337; c=relaxed/relaxed;
	bh=5jQP6MIYnYcQYA3EUzYTZ444eL4w24GdY9PBQD7th6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTS0OJwkAxROyBW0Zybuo2pcV9jd6YEvCOhNna5g3EgFNcixbUBA+3qhTi1dFuHIS56lvrQBFLaemSileTHSsEwoJw6YfkgX5k6SjbhBUT+bN56lFJjv8UNmhC4kqeOvFmXBY1dBtr02/+44BOf/O31cViT4rWk/q1bGFFhQH5kQrRCFgEDUGWF+Qv5JkMu4NbRr7IK4Q0H9aaIOtVvGRgLgpTfnlQXZ/LSqRdXEJtoXyGhTrpnn5pXvspyXrWiWBqj0Kn9wfD6jtZvLYa3X33z24W902oUIn1YwOMfJ6M5+AvhSI5ra7zEaZB7b9Lmd4dqbyOmuBq0xfImuz7Ixmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Urz6fYiE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=praveen@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Urz6fYiE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=praveen@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fbD58Qvz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:35:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3lq3T1901528
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5jQP6MIYnYcQYA3EU
	zYTZ444eL4w24GdY9PBQD7th6k=; b=Urz6fYiE4yAJ0kwJ+Z38U/dw72xPfVC7Y
	BQPArUBtBRd5za1E2shtNmHcsOlBTPcmX5mQMSM8IrVChYl9H8z1ech2IzbGrBAg
	p2TEFRsDNW0yLNNZgmOROlYmYL71u4VC7uJfsZGS2/ojkAvBN+19VXtQXjvVtWP/
	bd8iDh9PgCO6ijMKnm5fywKwas+bQj4YQxPyfS7/EGE2fH6GSAs0BCaJZtEmEMLE
	FdUoHi6hGyPXY+2tMma6b8Sbyd6UUhe7pSY9RKdx++BaeSZfTG+dPCpGWJBYdlZ7
	KvnbK1MVaPAoHm0hNROuIZhDErll2+zDwBsVAcwYamNCS5Bs71LLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7pcbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:35:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U6BHPP027334
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:35:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwa84s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 06:35:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U6ZWsC32244312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 06:35:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D78F85805C;
	Thu, 30 Jul 2026 06:35:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC91258054;
	Thu, 30 Jul 2026 06:35:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.66.49])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 06:35:29 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: mahesh@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: Re: [PATCH 0/4] Base support for Power12
Date: Thu, 30 Jul 2026 12:05:06 +0530
Message-ID: <20260730063506.25823-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729145405.3230272-1-mahesh@linux.ibm.com>
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
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
X-Proofpoint-GUID: UP7rG7FjpEyrM-JRkgRi0wfDsM-4Yev8
X-Proofpoint-ORIG-GUID: UP7rG7FjpEyrM-JRkgRi0wfDsM-4Yev8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0MiBTYWx0ZWRfX9G0GTmyMZHL2
 q+xa1Z7utkBfVsqNprKGYzuHuQnmnsRf6WGlEg6BTEyc+iaQMosfZQknsFnkK85ZYxoMGXJSzXS
 3RqpYGKozQt5b1o4KN+K7sBTLcwIZM0ocE2mCYyivY5mVI3dQjgaj2tsYmaDwEzpKiVyS/b4n+y
 84rNtDKHGMxiB7/62UN/SKVslaQXbE3OMRur0FMEt6EHpKY76oUL7uTybN4v6A/TNR2l4lIOQle
 hS79RKmLJTppLTnbQl1Y4sA43tINeev4n2T+oSvH+Gph5WkJM3rtaOuMmDl9PfMGzuxQHUoagW9
 Y3PbYTksF87yjUwejvm8Q+g6SQhEYiy7pHk1XQVNVSzwNeFGY36DxVGdd2FWPKlaQCEnoTq7Xy8
 TfP9HfLWON6lXGb87hc7booDo8jm8gp3DvhaEHOc01em8FuqPqGB2eno8gGW4FyJW1Vsrq3apH6
 r7tiixKSfWRUtqCkuYw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6af0b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=j_nrsbsRuxRbdvPsdAQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0MiBTYWx0ZWRfX6/XuGK4FyhFF
 VBduEmj8hPEUZT0AMpnvPhNT9AewPRxPp2078tpEwMY63AW5GU9TTBfq7n+vG5r7TTx6vV6CiCf
 a/RB582j5gi0VM1C/pagGPSEp9uQ7mM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300042

Tested on Power9, Power10 and Power11. System boots well on all
three platforms.

Tested-by: Praveen K Pandey <praveen@linux.ibm.com>

