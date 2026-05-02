Return-Path: <linuxppc-dev+bounces-20379-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1DCD13DA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2026 07:39:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g70DR3F1Nz30Jy;
	Sat, 02 May 2026 17:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777707591;
	cv=none; b=XQrF4vsJjky6BJCRdZCKgdzFOijzN4olCY2yfrlypciLJbKsGTMT0vBjWYgc2aL6Y/+2CjynolFxsJ4mPtn4jrETt0GVm811+vZNHkE+etOARWp1VipXRc2izTF/rVZZ6gfzrYBuhNo34EtqqzZvQGbOhid3T7Qy0eTPxCpCBcDBWEmyDlq22dORJTN2vuAeTvltHyVX6jQiKF8PtukoiGPRPGoASh5oXuiBUc2zQ3FxF3kcpzWfT6YVyhkRPko0Hn5Wsj+BqpqLHOlYTuO4nxrXKyqGmmSR2DgAHTjZBbNKrqlTFU20tMKiDrz5HQgHWcGmZN7NfNEgipqy0A10Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777707591; c=relaxed/relaxed;
	bh=Xnbge8CoMk91fCFY+7ORptdU/ah1OI5WNPSruc3SwOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTDvIYAU6bQZQItSmZgegcEm9a7CSafIWpOcehi+3P/iX3Gp73zWSTll5ER7Bic2k9ZI5VoLU9FWAbePHmx2PgW00UUUo0oC5mIu1c9q/NIDII3XhreWvASU8j3097GgloPIs9YmIy+fK3oXN/5uWKzk6awssbn1kMi5aNCr5C3BCRRSg97R2T8F07J6a8Q1LnW5jew2zpi1CTevyjT1cmZchS2YmXAbY4uCtYWWGeV1U8qno7rvTSlZt0Knu9c4otHkSaUfqPx7poSp3HCrROZL8woQ7ZTAgdj9NPcnnwAG5DfTwomebMOEa+7BWJmJQw+81Gwx7HS1MXM3JkHO6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pQVlS8gF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pQVlS8gF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g70DQ63jQz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 17:39:50 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64245iLU1991207;
	Sat, 2 May 2026 07:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xnbge8CoMk91fCFY+
	7ORptdU/ah1OI5WNPSruc3SwOA=; b=pQVlS8gF0RtEtSZWj/lLb4zqEst4TSGdS
	kBtFmcef31lq8eSQRxc/Za9PPYn/bcb9urtebL145TBCy6mapr+sxPEwyKARO9lw
	f4UaYhJAIpTVjhhXnOS5Ua4vDvFQg56pb6/uSFK7isjQAfE9B8ggRyQrSrKt9pvz
	V+Msk82/jO7UAABjctnBsDQd7U9Js6Saimn8zVD8GimKHraapACsBM6d+5ygbp9o
	jOLZfDl5/xwIFExhN7s89RPdT8eEJNl2AcLw7dPSxIKp8GJWi9E2vHc0qkABcFyn
	KBAAX+i3Oe3bmXhLBtx8syib2c7GUsnyll+lE6EXIVD+4RIWa9+pw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x48cyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 07:39:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6427OWdY018472;
	Sat, 2 May 2026 07:39:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dw9gvghgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 07:39:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6427dfdm62325010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 07:39:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A508A2004D;
	Sat,  2 May 2026 07:39:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360CD2004B;
	Sat,  2 May 2026 07:39:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 07:39:35 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V3 2/2] tools/perf: Add kernel-doc comment to auxtrace_record__init() function
Date: Sat,  2 May 2026 13:09:24 +0530
Message-Id: <20260502073924.99965-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260502073924.99965-1-atrajeev@linux.ibm.com>
References: <20260502073924.99965-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDA3MyBTYWx0ZWRfX+wH46C5zpQqO
 Wn3Ga1v/a7pGVy6A6q9mFHKpm7B0pE6S/sShqC2ejeYuDiyjr9b47tOiieUOtRLZtesM83qMUGA
 wHAbq098C8tkuFqGHSX+SVm0Nv+OCA6lnAlFbJ63kxm3BCZ/yGmLpl2iYbSN21g2hcuwFKxDHm2
 enXLiTzP+BBbT4MtPVDebs7RD9CR1L+AiZRmAiNlHgU+ZQka3UjtbWg/15NHaSTctwNB9KSJIIk
 1BS7Gs0vnhH17VZsHBWw0jYfWPhlaIYf3CG1RuaIpbMkX4Cubl7vC3DxMzibIAPcSn7RHFRmixF
 ZDVE4K/gy1+Em86UJj2pC+TvYHPc7qRyJ3TIFU+2yr0Mg8blbuStlSmRqUR/ZqT1tDUPfDDdKhx
 P5H0AOsR9NzAedq4AsMpwQlYQnIVMFperW872rrkbqreMKO3EOcyb0d4c9CbmUNGVOkEX4V0ybN
 IwAWqtg3gypYxdjMimg==
X-Proofpoint-ORIG-GUID: u5c1YBMnXLrbHmRniOJgDvlWHoWX-Rdd
X-Proofpoint-GUID: yK053_OTjNwlPlZPqNKECOGiKeJtBxs4
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f5aa42 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=V_ROcSP5cVqbivJN_SYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020073

Add documentation comment describing the parameters
and return code for auxtrace_record__init() in util/auxtrace.c

Using "struct evlist *evlist __maybe_unused", gives below
warning with "scripts/kernel-doc".

 # ./scripts/kernel-doc -none tools/perf/util/auxtrace.c
 Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
 Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'

Updated  parameter as "struct evlist __maybe_unused *evlist"
With the change, there is no erros/warnings with kernel-doc

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v2 -> v3:
Addressed review comment from Sashiko:
Update return value expectation for success and fail
correctly.

 tools/perf/util/auxtrace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a224687ffbc1..6aeccedc7f2d 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -896,8 +896,23 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
 	return 0;
 }
 
+/**
+ * auxtrace_record__init - Initialize an AUX area tracing record.
+ * @evlist: The list of events to check for AUX area tracing event.
+ * @err: Pointer to an integer to store return code.
+ *
+ * This function looks through the @evlist to determine which AUX area
+ * tracing hardware is being used and initializes the auxtrace_record
+ * structure.
+ *
+ * Return:
+ * a) A pointer to the struct auxtrace_record on success.
+ * b) NULL with @err = 0 if no AUX area tracing event is found/supported
+ *    (not considered an error).
+ * c) NULL with @err < 0 on actual auxtrace_record__init failure.
+ */
 struct auxtrace_record *__weak
-auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
+auxtrace_record__init(struct evlist __maybe_unused *evlist, int *err)
 {
 	*err = 0;
 	return NULL;
-- 
2.47.3


