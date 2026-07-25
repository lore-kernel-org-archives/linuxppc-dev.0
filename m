Return-Path: <linuxppc-dev+bounces-24828-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D732C531D0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 18:50:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6v7z5Qy3z2ygW;
	Sun, 26 Jul 2026 04:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785005455;
	cv=none; b=TGgU1donZlhbvl4NHm63ijrYOi3qxJk0dP52x6znje7NcZ7T7gsSl1YlwCtbYpfUSRXUTflOEhITKRt0GLDE00Q+DjhsH018407z+VXnntJFctJRJ9O0cI8OGGUPAOxcKD7oPFN1U/eGnTa/a9+UJf8cqWrVTDSfCbSZepZPqv+zS1DkT4ZJZmwt+cCcZn3REeoO1C0fZF3w0xI1g9f7IDNoatfWxss9dVWk3A38yqHRygs5MQfXhfle2mOUTO6ktawydSTYDXIg/Dj6a51ifXzVA1wD8m/2CplcTzBFWUrNBLQz1Yro14AaQtejgazMDbeMNnsHzmFxzzqIkwWguA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785005455; c=relaxed/relaxed;
	bh=dCyrq5CHS5wCGO+JIrm/P7Mfm8gnyQxNnu6KZWxPQAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+gVtrbW8XsBgdyULfWJUoXtu5kGemagzgD42zeacQlJfBuPr8S67mWxzJkcxCBoSCsOyKikPIZ/ogAjIoMXEtmQVPTJKfVWhGCpwrCl2yP4/3MU/PqMYbOWzq1bzxQrI2rsBXvxXPaNAD2VJAPtURuShcE3au7Yp7q/OsS5UCS6WjsWgABL0SQotFMbbyVCrBMUXn1iODKCKbq4+8xiU27/6E/IgBqWUgpaar2TJ3iV2580xS2bcZLg65Pv1ftuxVTXIAmALxYFCDTtpsL80zvWsazh4bXGtnuJz4Vr4zcUxQUGcqRKZ6QsdQ64SP+Ud7oAE+/6mkFwt3Gr2J1ieA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mg4mPaEX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mg4mPaEX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6v7y6Ypvz2ygJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 04:50:54 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHIkwq1108778;
	Sat, 25 Jul 2026 18:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dCyrq5CHS5wCGO+JI
	rm/P7Mfm8gnyQxNnu6KZWxPQAU=; b=mg4mPaEXvsq5QPKoobegA/E0Jrq/GoFjx
	Ly+mj4+3ClbJyNgzM/JgcRcTadnnVAE1LMHoPqZy20kMMjt760cNCOyCKD3YiTAz
	TMu1zX8BNjc1dmXL7fJmbvnpV2qaXp+85MEsRqjKNzvadDUX0iexEuxRYIs0b/rX
	Iby6HTgF/fdFB33Xga5uzUOcsnBLKhoZ9k884+9mK1Ctcu8EpSzHrZcVZplk6jSY
	SJoRBJKwDq0PImCPWEzaz30aMTMDD+vs+CIeBc9D4h7BFU3rHVyCMStMONPlE8oj
	HW99nw5DcfNDFxDBRAHAQYZfu59LIA6lND0UzzSL/4pxXuphINlPw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0n92ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PIfJ0a031784;
	Sat, 25 Jul 2026 18:50:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c27r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PIoiex38207830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 18:50:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F049A20096;
	Sat, 25 Jul 2026 18:50:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 756E720090;
	Sat, 25 Jul 2026 18:50:34 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:50:34 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 5/5] perf trace-event: Fix infinite loop in skip()
Date: Sun, 26 Jul 2026 00:19:53 +0530
Message-ID: <20260725184953.234759-6-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfXyvdx/h41WMRh
 ZMbeWpmJyd5fdW5YGhoVJYMMFLwX3V66/0LMHaYaimrzPhT4dop8K/NNbhcFLVJYmzTza8E15vw
 sfdMog6OCTO4hZ1Pf8nqxJ4x7e3SeJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfX386AIN7C7uqP
 5ONoKZNRgdOvw6MAlY8VIzObnfsySbM2QGKucFadz4acrs5wr8P/GZvCDHhc5TD7TS+77+jyMHh
 pzdsYvjKY/ql4x0nxndlpQQwLuxi77jT93TIzJ6FC4z0It6CSLJ5GsZYjIkqHLnc260bhS+3TTm
 9JTI5kcKVLWrsQcRv6xTZv9WqE8xUmkYpUS6skFg1RMUt7z01mI7DnunibP/dZe/Pge5qRo9rKL
 CBOWuPJp0VyyMScAG1Gk7dpKrCsc+lwQV7bkcn3BCKarZ+zijtjFT8hnYNvMKx7PuIHshulq00h
 J13gHdviulBRC1Rs04SPcPeNgK/bR6NpxFFyZignFURoHlFOh/XaoZhb9pQIvTwzY7Vw/FBNM2O
 PpsWCt9kJH2h7FNhqA21BaHlOOgicQ9+hRNpe0GxhJkVXki8zq9o2AORw9aCCrM12oF3/OOQfWj
 1aYgoccIQ+SPebe5NsQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a650589 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1smD9fHUAMlVQ18p2oYA:9
X-Proofpoint-GUID: FaXT5qDx0NNTDQnoCeByahqBSUjZM7NW
X-Proofpoint-ORIG-GUID: 9981Nn3E9gtAMWH3KUOGHjNIpLjR_pov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250178

skip() ignores do_read()'s return value and unconditionally
subtracts the requested chunk size from 'size' on every iteration.
This was previously bounded by size being 'int': a maliciously
large 64-bit value was truncated on assignment, capping the loop
early by accident.

Now that size is size_t, a crafted file supplying a very large
size causes skip() to keep requesting BUFSIZ-sized reads and
subtracting BUFSIZ from size regardless of whether do_read()
actually succeeds, spinning indefinitely even after EOF or a read
error.

Check do_read()'s return value and break out of the loop on
failure or EOF, so forward progress is only counted when a read
actually succeeds.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 53f1920c3fcb..db1622fc99c2 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -72,12 +72,16 @@ static ssize_t do_read(void *data, size_t size)
 static void skip(size_t size)
 {
 	char buf[BUFSIZ];
-	size_t r;
+	ssize_t ret;
 
 	while (size) {
-		r = size > BUFSIZ ? BUFSIZ : size;
-		do_read(buf, r);
-		size -= r;
+		size_t len = size > BUFSIZ ? BUFSIZ : size;
+
+		ret = do_read(buf, len);
+		if (ret <= 0)
+			break;
+
+		size -= ret;
 	}
 }
 
-- 
2.47.3


