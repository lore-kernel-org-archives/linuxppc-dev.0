Return-Path: <linuxppc-dev+bounces-26634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB02C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:46:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdY013FX1z2yxN;
	Mon, 07 Sep 2026 13:46:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788752785;
	cv=none; b=gS7Qj8lz1Jydj/N1K0v5tq5Rbsds50av0z5YCznTKX5BTeROcerw3aCWU//bg/WlbtuR6VAtRfdzPgE2K3iZIrY+lk8gINHhLG+UYDfC6s6qZT6r1UaFqvovdSqBlod2f8naGbPdE5rcnPSl2nAsEPBg/tnBnGNl5nVqOJ9L3vVlj9SRB1x4cPV7yRjX0IXoxjZVPvOcu6oZsTny2fvz1OhOMRwAcc2pcUkHLu1jINHFfQJnQa3+il6q4QdXL3dLaHA7YZtszkO8wj5/XOsyLBy1LjCF/L4NxJyse0N1n1nNw2QJDrl+MPTJG9j0J/GUdrO/pL3KXmHuXatNpq0FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788752785; c=relaxed/relaxed;
	bh=wuAzvh/hiT0YChSFY3ZTs+QY0e+9zRS0NJVOuutaFS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9pV0nP/OBD/q6/p0lDYEHgcmMhQ9r2kYqnFdKOszV9r6MqyK6szQieAwOZBAn/4fOxx3xEcFuQHvviNauVi6gYQIc0LtqvLPQnkZ9YxZZp9TPnUvHZny+75oh8nY9fUjyIKsVWqZ9oc+gbPr2cX9Gdvvk3T/x1pzFTV4FtpDsN8Dnk+t5fglEP5wU3c9CEmI/fA7UxIraGBNy5V30JIWX8t7pBN5fjCF4ZmRUh8mocjb87ZNjTNoJUYTnbBkWY2zzm7XyRM5dWbWCZc4kYszgpOMIovHTo+vL+/CcxaLn2bFjJ+YCt8rTy++qoayAktcy83pI9eDX7m4LT7+LLUpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s6ADs/gG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s6ADs/gG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdY0061mkz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 13:46:24 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870VTGb2634785;
	Mon, 7 Sep 2026 03:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wuAzvh/hiT0YChSFY
	3ZTs+QY0e+9zRS0NJVOuutaFS0=; b=s6ADs/gGjoi8NCmdgvjQ3rzqPvBWxT9qt
	hLaKOcOQcfNrKlUmBBsPm403eb4Lcj2eyQG2mO9qVusFwXLsdmukrRcyfz9J4iO5
	nB6lBsGXX6QAapTKd/HdqBKFB8JyeZ6PpfpnA9TlFMeNArDLmlJVkutrjQKRvg+5
	9Hzxdt7+Izu5aTiaxY0iQYK8d8qh8nBFdLv0U5kS9/gFaiNwfYn4Ozsrgx17Dfaj
	Bo8mFpopWDguLUugLwqCqgQEmbAPjImbNC4JCjGh3+q/Kyi3W5wAiMRxTfZN3BxK
	Xpv42E/3LDYz36f6dKScOoVIXsXlsAkSc+BukFXF9oNsxg08BIN1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjpark-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6873fFrm025536;
	Mon, 7 Sep 2026 03:46:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwgun0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6873kCuG12779986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 03:46:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 066842004B;
	Mon,  7 Sep 2026 03:46:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E4C920040;
	Mon,  7 Sep 2026 03:46:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 03:46:08 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        narnalli@in.ibm.com, vpuliyal@in.ibm.com
Subject: [PATCH 2/3] perf annotate: fall back to original binary if build-id cache entry is not a valid ELF
Date: Mon,  7 Sep 2026 09:15:53 +0530
Message-Id: <20260907034554.714-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260907034554.714-1-atrajeev@linux.ibm.com>
References: <20260907034554.714-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bf8QyQpG_CrEssq0DUKuMAW_ezEcXoMw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzMyBTYWx0ZWRfX9C/BZCmScDzo
 ogvVIiahziIrWc806oOjs0q460DWpyWjvuv3Q8HR3fOU5sEGty2JsfsHQ5W0W3VZdgfC3m1oy8y
 ijYOEwx9WBwbZ01RU9jh6/qdkcKt1ZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzMyBTYWx0ZWRfXx74AC3lKIvx0
 m3vYvH8V7tmXTcj/B84iI24gKpalzycKpw0M06xvjvyvVWznR8Lf2pjDDw2TDOQ5PGwaPcBPVY9
 1Ma2MDCn847ow4z6gnkMggmF8w7fYpq5AUon5MTTkL1pVciUQVD03fuCJagpqtXT1HUKunilluc
 7R8TxbSoCT2QtVllpRUETJrDWLs89b7EjKXwAI+Ue6gou45xq78loUaHEIkcKS49L+IzkcfRvau
 x9j2kL0XuyEuqtHoztpFQYQkWssORgalr7WEZD7/uhkbFjSKG2AAj75DADzGGCY2W6u/6Md9+LT
 sMcS/HtpcEBzVjQtS4ld1d3rT6VXrHtrFSj41UcCkTNvVkALpKrQCVjJNQ5TrnjORKw/e6YiIlY
 xhYVCOK4rU6vsV+5QjDpPYyFcZS6XcCq2rj1xz17i0Dqm+FeItVGkAiK1zhnlOFKue12rlpoAuh
 Iy8TmqgY7RzQpifeK9Q==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9e338d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=NNguoazYH1MIl4a9DQEA:9
X-Proofpoint-GUID: IOIiFlN4DuSgiblOdZtYNmw6ox9lq7d_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070033

When perf annotate looks up the build-id cache to find the binary to
pass to objdump, it currently only checks that the cache file exists
and is readable (access(filename, R_OK)).  It does not verify that the
file is actually an ELF.

If the cache entry was populated with a non-ELF file (e.g. a shell
script placeholder left by a test harness such as SPEC CPU), objdump
receives a non-ELF file, produces no output, and perf reports an
error:

  Couldn't annotate <symbol>: Internal error: Invalid -1 error code

Fix this by calling the shared is_valid_elf() helper (introduced in
the previous patch) before accepting the cache entry.  If the check
fails, emit a warning and fall back to the original binary path, which
is the same behaviour as when the cache entry is missing or unreadable.

Reported-by: Narendra Nalli <narnalli@in.ibm.com>
Reported-by: Vijay Puliyala <vpuliyal@in.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/disasm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 6cfdbabbb8c7..e263a2a8715d 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1201,6 +1201,12 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	if (len < 0)
 		goto fallback;
 
+	if (!is_valid_elf(filename)) {
+		pr_warning("build-id cache file is not a valid ELF, falling back to original binary: %s\n",
+			filename);
+		goto fallback;
+	}
+
 	linkname[len] = '\0';
 	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
 		access(filename, R_OK)) {
-- 
2.43.0


