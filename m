Return-Path: <linuxppc-dev+bounces-24785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED17C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 14:32:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h69S339YHz2ybR;
	Sat, 25 Jul 2026 00:32:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784903539;
	cv=none; b=ZRFmH2TCTW669Hd8DGGn1c7LHnVUh6WR2G1mYcKR+lgHaPcH+XPCBPKw5oj3ZWyWPRNwvbOp5jFupcg9LW1t4vsJxhUPDn2/wMJcBbW65IkGpFpEGueBYXHuODgcKgAX6xIFFij9R89t5hwVN3s2T59zLTRwhzJiaraIjvQ5ZJQijuUqQBwmmEhUCQ6kzV2vuW5i8UDU3uVs2NV1HL63RGfBDj7zjR8msWUZ9E0OFHFu3Hp6Ky6730f6+kAm/9pXzupTIzzIYvoee0esPwxPmm66GIonGpJ9+lsSh1gZeXc1iQu/Xdqoq51PAb5b9HC0TSVBD8WeBXeLfa9XlrEqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784903539; c=relaxed/relaxed;
	bh=w7d7iOIr4JYo5xD1xds79ix5oGBdZQ9fFETxdf9csPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3zROd1A1dubv3/YdbS8uuF3hWGOTtTurWXF1q1TmJrZyD3m8T9pRTerEvFWUDMuYWPFMfT1EfFfauVTW1CELhvjmlzkojDlDRMl6k7y5kjuI5TaxYyu7k2rye7uyt3zQFRpD/gyGpb2K+GYhrM0RBdSQpf9yDd5S3SNTZQQDC9ILBD+w7xwtRuBkvLlkLwb2NIjdn7IzefmZc/QYjS87zYSqNW8WVyEuF87e2WlLnzWjmQvJC5G3UFQ9GRhZrAOsEyld+WEEgWPhJA2v6kiHiWT6m6sDb7XriCZyB2x9b1Ad7OzT6vSUnZFSqgJSK6ObJ2v3qj8hiHU0P9qiRNamg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BFBU8sBp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BFBU8sBp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h69S15d7xz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 00:32:16 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfp221869292;
	Fri, 24 Jul 2026 14:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w7d7iOIr4JYo5xD1x
	ds79ix5oGBdZQ9fFETxdf9csPQ=; b=BFBU8sBpfFBjV2WU/9olCSFCSPFV0p2NL
	9QUrYjykJFIjZeFuspjZu6NK5cQxvV8vG4auDqOyn9Rp9zoPnjsRcbRrAGjE3AZp
	0fuvYiBJbnuDqXJbDxrVkCpW8pgJUT6idk9wCDtfdPw6bUr1p/gp00jl0YlRnBjM
	bjp1K54NCYG/gc4KZFh+VVhfMwkvXH0vxCHYl3X4R6pVTx7IV6vYuJoWIVNGRC/n
	Sl2xfvHD8VpBOrDfFUazRW72SgVqHB+1n5dNtGF4WeL0c+OITfNv0eazxP55peeB
	XLliZDbuTLAwmmjRdKas81/z5ohy5DIesEwXish591EocgNewZS9g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gmeyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:32:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OEJrJu028472;
	Fri, 24 Jul 2026 14:32:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahh877-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:32:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEW6IP45941068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:32:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4107C20218;
	Fri, 24 Jul 2026 14:13:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2916220219;
	Fri, 24 Jul 2026 14:13:26 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:25 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3 1/5] perf trace-event: Fix buffer overflow in read_string()
Date: Fri, 24 Jul 2026 19:43:12 +0530
Message-ID: <20260724141316.99507-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724141316.99507-1-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX5dSNSyfiHuuQ
 QchkfPkZuoIFejLrF0tqaq3lliyCT5nAQ7omipGu0EdbqiWF5ZlSoRn1+2Jdxe2CnRZcJ6yqyBo
 rr9Yyu6dtjKVHP8ZhZzFbEZxOO5TtJmNAndDlxkmTCHlwyW6RQCszRdw8a1elevVySF+0cqeWFS
 2LBTZ5y7kIhjHCe9Y8g4Ac0SCBmyYmbeVaSIQSzTOpQ6hg9ux0EvD/yELxXd5AJp4kkoGFpo+WD
 YV5Mbvab4BZjMz+w5KQWvRYqVN1YlHhIT56j0/raC4VkEfppZt18Q3wWFtA1gSGA7g3PtdyNOMW
 9EeYgeZ9Ymr1U7/bg160Q0ivB0V772yo+CP0xlYXZyJh8A3AkEMuUc8Z02+sgvQY1HUT/0GoXLC
 gb4MwrPpkxm75OzPtEFTjyQFiTdeOrK77edyGsCXkUxsVmV/09oQdcNXhHPDjNqWE6ATt1B3YRC
 fGbzg6uiAVF9OSSH9yg==
X-Proofpoint-GUID: JmEmseLqAqvadcmJ53hvSbQl9U8LCiiR
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a63776b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dRiuFSZL0wyzTp01T68A:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX5+nQOJkWgubE
 jAsI9qq1NvCCulgB0oGWi4axGAtagM9s+4JOhlLIwKzD3jxyWH7RXBkYKOfubBjwMxhfJ4Fs51S
 1/BvRI+jjnhNx9yX5a6dkrTrxlFH2mg=
X-Proofpoint-ORIG-GUID: uw26TiD8GjMtASbZASF3rX9VFAw0hoYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

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


