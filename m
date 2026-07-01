Return-Path: <linuxppc-dev+bounces-23281-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A168BC43327
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqthX13jBz2ymg;
	Wed, 01 Jul 2026 18:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895116;
	cv=none; b=LhuvxnL4Irnr+PMPA4KdzZshPHol0nXv8RNmdNxb1qCiR4Ww91V4L/zaB3oV+w8deWoWPA5jeJCYJ3zMsQd73C8twwvszBk8nbMzugQf4tBuDyQD+pMZRUJpfwEX1BUF0fIzI6VH+mfMwsaKmNIdrkWKXPAICqzSVqUO0LUrhgRS18+5nFIMm14LkSOE21YSzs1dwHW1ri8zyysJQoUx3jH7ARlGlEq2VurNFIHqgeU4UXIISvTOptbEm1aZPhJlNNg3BkM4Hi8OkisRf3wD0wzfi42EMMuooDPCviXdeybbjq83QidhpFOk8iUQVUMzpbA4rV0EGZ1lSFEjoy/XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895116; c=relaxed/relaxed;
	bh=VqGMFuUT6g3w1AWT/gPGiHpUT3ls0dKUM6LylJMzlLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgW1etg40T303RvuWdVEtfzVS3R2eEl8a5WTKeY9b13Vgy43roQFJB1QfqmDLvY9LeOlc7dOdjuQedzxDKWzC9M7S72ORsTP0CYcpfyg3ia5uCzgjzMcWxH8Ksg9ySH8mLB5msugmpqPmL4z8XRQ0JdhaGDLJ8K664tPTdNPEQE5i/fm34RRYfoHDZfEqA6FPukzF7vFy0TSPiQT2OmNvAwVMQs1aHwgfczeh63yjq0EoEFtlOo+EcpgE/c1N1QkzAi/rPokc8iPDGZB5wtS0pNAVedpi25ZhlTDRbDEVFqSCnpLidZ1khJbNhBOTVn9e6vi+vp3OjwZWL7lp8ELTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JOlOcU4i; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JOlOcU4i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqthW2KkXz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:38:35 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618Ih2r236526;
	Wed, 1 Jul 2026 08:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VqGMFuUT6g3w1AWT/
	gPGiHpUT3ls0dKUM6LylJMzlLI=; b=JOlOcU4igrT4ERmTIfDN8aVcj3KLhROBV
	E6KJ8tlsrpcowWu+heCumuidHKY83xAb5uTQovxXd07bw1DZYoQw/+397Dk8T9lc
	vsF8N3RTo5hLwvel2QUPsBiAey2MgI8azS9YQPbzCcbFkeU4PYs6CYqPqyorDn0T
	orDjNjpMRcAlbf3Tl0P5qxAnXJBP2lWDVOZmCV/FNXlbta5flR0MhTVom62ltHVq
	6+of2U73FKLJI87y+LvZOu7/XD0ChdGs1jyqmf/UYNxRPQmk8MDOP8uHjXGLO7Da
	n0tVnrHwwgcMxzzhpR/9TmncYy7xz1ngokDmuayt6vQbXuUlLPIOQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa34y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Ychl000663;
	Wed, 1 Jul 2026 08:38:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhye6my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618cQr150397680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:38:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7BD020040;
	Wed,  1 Jul 2026 08:38:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C2E2004B;
	Wed,  1 Jul 2026 08:38:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:38:24 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH 4/5] docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event format entries for htm pmu
Date: Wed,  1 Jul 2026 14:08:05 +0530
Message-Id: <20260701083806.79358-5-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701083806.79358-1-atrajeev@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX13mx/TZzTCTe
 pxaaJLCZZRvnYiM/enFQHRhL6nuXy96i/uKJX4Cl1/ZjNrx9ghGtDUzZjduZJj6tRN/+gXGjXt4
 KZmqEkleeuAgbFtGOvjJG/kycZ4BnsN2kyiZ63Y+FddCo3xzdBVzCizz5DWeRRr6GNLAzQvPTIn
 SsmkS6P+yZEbDAgTW3D7tgQkfSUFKx8xSruONBuItLQp/Kc5qwndN2pwdexBIsFmKwUXjyoeBmN
 q4XxOGMPohEAGp77YCQISYE4QFZ/knyWM4CNbDX0BKiETDYza7RYII1h3M1HoJYrONIlgDFBpvy
 DRSpVTLa+8ULSNuV+sARK2uPRkXZngw1QTJPOrT/5QwFVgY20wEJT2sc/BHveoQuPlOmIJbAprh
 K62bQVlmuMCyNRk2L7wkZY1SicVdiStVJCx/mokZ9PxoJ7V0z7NCWZAO8EUNfGNj131bixERMlm
 wtWPxJVk1kULXN1Mm8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX7jCAnzO9pRPC
 IAi1+Ao0qCLtLzW/mqVuwMbxI/BM2a8kLQbBvN+hsLYNJsHiUuyhLZ8tLTg7jzALR1yRe65CSMe
 Cc0wAQ2zqJT7nIHjcBJa0Y2T+R/y8jY=
X-Proofpoint-GUID: fl_15Np0M90CMsAiuk4Llo9nsAxuLs9C
X-Proofpoint-ORIG-GUID: fl_15Np0M90CMsAiuk4Llo9nsAxuLs9C
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44d209 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=aXd4d0V2UHYFZ3CtnQMA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010084

Details are added for the htm pmu event and format
attributes in the ABI documentation.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-htm        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
new file mode 100644
index 000000000000..784ba7c31b89
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
@@ -0,0 +1,21 @@
+What:           /sys/bus/event_source/devices/htm/format
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attribute are listed
+                below::
+
+				event  = "config:0-27"  - event ID
+
+What:           /sys/bus/event_source/devices/htm/events
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:	(RO) Attribute group to describe performance monitoring events
+                for the Hardware Trace Macro (HTM) trace. Each attribute in
+		this group describes a single performance monitoring event
+		supported by htm pmu.  The name of the file is the name of
+		the event (See ABI/testing/sysfs-bus-event_source-devices-events).
-- 
2.52.0


