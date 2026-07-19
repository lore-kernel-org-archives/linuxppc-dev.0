Return-Path: <linuxppc-dev+bounces-24422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E61C44521
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 13:03:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h33jS00C9z3br5;
	Sun, 19 Jul 2026 23:03:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784466187;
	cv=none; b=MLDC5m8NWSiGu0PUFh05GWqV21DRRb7WUYyvdbYztVDMO+agrWEshBgK3n199YWXVxK3VeIZ9+fQhsT6K1eVN+OaFfFVIE3WkfQJ3aa0cNHsHni5gThn+t+1MQTh+ZHfvI2R1Suu9w52ViCJdkl1+PAoYzNEhqJPlixEMbtmWafoVGmAZTGRdgujlJ1LY/QCyUfc8y4c9dXwUZyGoiEEK6CDfewmm/gc60tUpdTVEsSTaAY4bErb68UNnLbOCFdqVQCXOLjpZYWWQR9gtH2XbMnWHxmJoJY9LErk6bCc1rYvxjWemoBmdEafvYUHwuTGxP4uK4AKPpxkv0nKGRivHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784466187; c=relaxed/relaxed;
	bh=UodIreQE8qHt8550xsUq5VuxDg0b0zqTfU62eY5ynhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4vJthPrh7Paiy9va9uUeWDIcl0e/ShArY1Wsm8MOCh4O4NF1y9lyG2MHhKQ+RT6J0JYe+Q63/yRpsDggVZF4rj8P5UmVDgUw6gopSE83aKjGLxEM6zXlJaTPAuglNCWm+ItxE0zoqhsrgqDFC1YE9VDw7pOzsHrf2o7mzHDxJQUapOw3JaTrzcNqvIKopSR/MIXFiPWn/lVn76ZFrqxD3DW9p/UkUblHFsBGlOAnPQiu6R2SqwJ+xMeFAhzPh9meo9ba5KrR6W9fn7vy7sJZy3UfK5znXyR50grQSncN6jhsTK+kmaf5ZjD4byhdkkx1UOoT7uNsB3xx+ncchrwYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UEzjK6ee; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UEzjK6ee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h33jR32mTz2ywn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:03:07 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBnKT3359253;
	Sun, 19 Jul 2026 13:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UodIreQE8qHt8550x
	sUq5VuxDg0b0zqTfU62eY5ynhw=; b=UEzjK6eesynZkVzEcjJhZjwhcuLNsmhyw
	hI4eVmGSfWiFT/p/bM3mi4xqGwioJ8ZqYvDd/EJin/oHPL30E3mhr7OKFHbWEftS
	UramMPV2Db72VsJSFnoiDLh/lZi2qf2cZyg+rJVjCrakrWdwTn5Ai6lfUW5Sgzk1
	5F4xaMRDBn8+N9M44+WgiqkUy6SEgnezQFgWpaQn+WwKuW4xcpAshy9dMGeUSkCR
	FIpPRTfZ05NThRwpGdzKwW4579aU6QI9/D+4jDGBXaoOMw8GPz7RHTwVqiTD293j
	CZbwKKpPNtPLKbISSWsyRhiVXYozSBvRK/bb5dA345uVXAhWY65bg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790kfs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnjii013878;
	Sun, 19 Jul 2026 13:03:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagskh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD2wTo51904984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:02:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E49820040;
	Sun, 19 Jul 2026 13:02:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588E120043;
	Sun, 19 Jul 2026 13:02:53 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.124.218.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:02:52 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 5/6] scripts/arch-run.bash: Fix run_panic() success exit status
Date: Sun, 19 Jul 2026 18:30:26 +0530
Message-ID: <20260719130027.2347519-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JDXqqQ4I23DjeIsVc24dO4nragMNBanN
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5ccb07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=9Q_qCks6ew66Kax-6aoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX9o8qBCs819U4
 4cCtlTvwBOeEh6sDA5a9BztflVLAXs6LAiT1KQEbZbBCwoKnVtRVIVFsdGS/YV9ktOVFuhfwJFn
 hspzwWM3XTP8VmfbT3OiERR2aQdl7cE=
X-Proofpoint-GUID: ewa23QTZe4xKnV15BENYe0SF2KcGb51q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX5JSyaW1w+mR5
 6ZmfwUCBsGdhYhlGeaimTID9gRC206nF8ibKtD2iJL447QFQcsj7UT2b7YlR88LBXfzZO6bE+Ve
 2GYYD5pj5hvIJAAogPbyVVsuayrwMM20E64Z4OVJR5KzLjzGLk2Ok961vm9HOKJtitVL3w+GlEH
 lAwk7rjod2g3VHZFa1AljlM7ziWhh0g4z2x84TBVEZV5TnNvuq6sFlygM4bHsi4Ec/pf8Id9xwz
 uSR7Ak8TYMi0zlnEklwYMzFyDM4sRxlbPLT3QfwliCkbOWgCnUxodKhIxDpPWWm5FMB9BynH2SO
 ItvdLOVZ0t4/t7kXpthbT0Jfcm/xdcmrTeLAYLd1yowF05R/DnNQZY4U/Q8mU2D6qCybT6kslER
 rS9l9WBq5WZZ5HFYG7o2HheD6nUoWlR6TVKIQnrBXmyBh7jv59skZzANMpl8qx5+HoFAfnAofO3
 iOUC5p+IgN91EYV08CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

From: Nicholas Piggin <npiggin@gmail.com>

run_qemu_status() looks for "EXIT: STATUS=%d" if the harness command
returned 1, to determine the final status of the test. In the case of
panic tests, QEMU should terminate before successful exit status is
known, so the run_panic() command must produce the "EXIT: STATUS" line.

With this change, running a panic test returns 0 on success (panic),
and the run_test.sh unit test correctly displays it as PASS rather than
FAIL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 scripts/arch-run.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 01cc1ff2..41a903e4 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -313,6 +313,7 @@ run_panic ()
 	else
 		# some QEMU versions report multiple panic events
 		echo "PASS: guest panicked"
+		echo "EXIT: STATUS=1"
 		ret=1
 	fi
 
-- 
2.53.0


