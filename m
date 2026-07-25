Return-Path: <linuxppc-dev+bounces-24825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D6FC531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 18:50:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6v7N6qgQz2yYY;
	Sun, 26 Jul 2026 04:50:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785005424;
	cv=none; b=NPUef3xzsjx8kF/bHAThrrb8pG2t1hgVRZHR/yxMIyncbTBqqjZXUSEhLNmLl4XR1wm24u07SdbH0jRX5i9y9tJuOTCRYooaY7DOuAwACC2Wtk+sOcSbNX22TkRETjPKfOOV3CCLA1puZhe/pDl2riUWzUisC3aqnyQBhi7p7Y2G3n/DVZhd6+lcTjWMy6c61OOsbHWuDCvZgotubM7WZMpDf+72yUTs5AXRPTccUnsr5rCHD56wSc9rRbRbwLXzlIf5DouoiG1+d1ilYNV8YD8wJd22rAX0zbxQgGEOU1pPuiGNiqHr6QubdusJMEqsB5vBIbefOacM6keK4SAsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785005424; c=relaxed/relaxed;
	bh=w7d7iOIr4JYo5xD1xds79ix5oGBdZQ9fFETxdf9csPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fybK2+iBwXr+PDy1rO6sAoorIv2GQcTjQPZXut/jvvkG62waKOnl3lQSIEWnmQdBPFSg6oIIF25ilEnL+BHxQ1RhxPmh43gPHHhoun96HT4q9iPkGK+ziPWEalRrza0cF4QN9q2PLEV6UtXkZs12SHr/RN7mwA7p8VsRe/cNDsCC90zLpGDnNsBNaILOrYDdx8uVBfTKWcFKyY4cKetpDpT6CxmR92YWGTXJH1zvRhCgs5EQWe6DCF+EkwdZUoxx5baesTYaHJiBUVeFpH0m5L4fVuwxitgcTzyiyH48HN6kl3+EhzqowfDdm82xUEfLMLKnlA1gvMtlCFfYiVX20w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H0Xr/Ijd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H0Xr/Ijd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6v7M5lTMz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 04:50:22 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHIIfO1239122;
	Sat, 25 Jul 2026 18:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w7d7iOIr4JYo5xD1x
	ds79ix5oGBdZQ9fFETxdf9csPQ=; b=H0Xr/IjdQigSaldXnV/94OVebNyVJH2XM
	BnLGkdFsw+YV2tqMwcm33nM8xN//U/Lt3+gu/QCJFbFjhzrEVOe4IYyD1MCwHx1j
	jwLuG3NGe+PvQ52fHuQKJNrVu2XAymBUOB0nv4iJ9QQ5+Nr5qrVY57XYuiPErX1c
	e8YH1/3Q8gN7f6N9RMNxAOqt/MllZ5fzbM9Xql7EH+hTBtJnoAle8AAiWpHPeX9z
	47YoACrK5NfU/UGDJTfpDmlAwKwYj4l85CNmhQdVEa4p7GpJfdP0apRIrF7tGaV3
	wgr00uTyJ3BI2ZJyBLIOQKOjZArk0TMpHxP1NJqTTstxfL9fBFipA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwch30n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PIfG16007773;
	Sat, 25 Jul 2026 18:50:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5ha775-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PIoBgd38142354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 18:50:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4E172008D;
	Sat, 25 Jul 2026 18:50:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF5F62008B;
	Sat, 25 Jul 2026 18:50:06 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:50:06 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 1/5] perf trace-event: Fix buffer overflow in read_string()
Date: Sun, 26 Jul 2026 00:19:49 +0530
Message-ID: <20260725184953.234759-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rSXIlTL0onPWCmq7ZfJPLqdO7PjrDHVA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfXwFQEE4va6rNZ
 HzNnwpkyoXyI7KI0ezEhes+Lqvrm5vaHh9/TniZqcTD5PjWhYNQbNSYb4fd542+nufGlyUqcFhF
 auEGaw58H42nQLFt2RN1CGVWMJy4BvE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a650568 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=dRiuFSZL0wyzTp01T68A:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfX1/2TD08awFx2
 +jMzABs5bGuiC0AjBF1yXLvcypJlpGbn3sYmd5GLiTEZ6INuL9eMo5fy4ql0jawzcoB0n3aHbds
 OlVh/KPBAlrq8YIAagcAAXM+1vzky5iB+Yreh8brZ65BrY82IZuPYPNIB5/OqstSJY4KFYJzzcB
 amM8AOnRgeDst4CG0tpIOhKIwiey4GynevHEYUaF+DjFBbKIX5Ce2SYaFGAdb0O4kR+vsNCW0uw
 aCtFI4gpXBnDcqu+Z4K0iDcOEEGD2oBUvnfgTul/HnfarbqRzZ/tEzhanUutpLqBHJI4arvpCrc
 6kpHGdoi6pfkiFBDIylvFqID2fAEDuRidRJe5uP3+BPiH5xi1Q8dfzHmpDo4Vvs6Ok2VFpK+yjw
 kMapW+haDSq03Cipo23aShUVzNxZryD0UogNkR+cCX6mbL2ZVr1fIC8mJktGBETPYR3KSrae8j8
 beCTEuQJxjHIkT8I3bQ==
X-Proofpoint-GUID: b5cK79YeVKnAPPZA77kkk4BQk3hyUObk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250178

read_string() writes into buf[BUFSIZ] one byte at a time without
checking 'size' against the buffer bound before each write. A
string longer than BUFSIZ in the input overflows the stack buffer.

Add a bounds check before each write to prevent overflow. On
overflow the function returns NULL, matching its other error paths.

Fixes: 9215545e99d8 ("perf: Convert perf tracing data into a tracing_data event")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index ecbbb93f0185..afd458cf1387 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -127,6 +127,11 @@ static char *read_string(void)
 			}
 		}
 
+		if (size >= (int)sizeof(buf) - 1) {
+			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
+			goto out;
+		}
+
 		buf[size++] = c;
 
 		if (!c)
-- 
2.47.3


