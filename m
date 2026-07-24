Return-Path: <linuxppc-dev+bounces-24781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45803C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 14:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h69324GWDz2yFg;
	Sat, 25 Jul 2026 00:14:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784902446;
	cv=none; b=bFpdDX+F+ZvAI+sBXvp8JrROuswCCKCQ2Ho3E4YvPZXyUK7eExRosXtih1Ca18gxh6zoxPaU3yVDSPdWsMzPZrvsQu5HIeTuKCkWBhQTdscVVd6mMwmITCfImRF2jMvlYYb129/OeAfFnRRNMQ8A4OiolUr87Wat8yEL/y7UmlDxSwR766QprZ0rwQ5Z1FB/WWvDEuJLF2Uu42yOAyJbR9fwNrIhn+YomzZXNWG62Cv6XI1tP6S/F3Lj2QyuhgOQLWHwvvyAWd0pkWwRi61F56qWfYjHZMASWligmY5sMoJwEb834FKKezC/8ofH/odyxK1qRhlhVLUbT09zrv5mVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784902446; c=relaxed/relaxed;
	bh=Wcw4jm8e3dO3tgSPSpXX+61fabl3+4VEktGHnLD/ogY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYnxjW8uR3mItTaoTyXvwWlwKVvpMSBOFL+44Y1g+vHnRjMc2i3LF8apGI6g8tXqCuGRDv8Tbtm+C0n4HMBZXSRQ8hHuAB5xjwa5eD3SBlCg+h4RAGtjGVmjeJd/ozX0rwqh4TT9OAFpcb1x3x6/wDGnxih7wG23lmU/lFzm+L+mphN9ALN7+X31khyR5AzPKXqOa8jzH80F//HVn2mFcgz/V1zawZICyyDb9lKh9qU2cyBkfVpcC/grQNRATYS+VWOwjGph0zve0dWABHid6FArSBj0S3IX2Nwn//xA7mU76YGk/f6Vgzbr11YIdPGJzJEbINbhoygNPNC0aZws1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=toPtzRhp; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=toPtzRhp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h693146Wsz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 00:14:05 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfg851992890;
	Fri, 24 Jul 2026 14:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Wcw4jm8e3dO3tgSPS
	pXX+61fabl3+4VEktGHnLD/ogY=; b=toPtzRhp4BA+TV0eDbB/dRBepq6apASr2
	aYmqgFfNeeobKfW05wus+1PFooxsPxuObB5/74ikZCytnL3v+RIRkbTipz5y2tpC
	jgEojCkfCQVcSxox5RfHAR4tdFGfdZpUGLekPEozzpp8hRFP+8cHpwbxf2syjZpC
	7QApm497Ki++04/vWsV7MGQRUgHQtLr7dz06IZrch4mJCEbW/l70ElRhUKyvj5UK
	VLmsWfklzCbHO4t6nI+3a6qUIfvAf748VFMBSREV3an0nl5hkC5ThODFWdmw7zKu
	i9NAAOmQpPlpXYbp5XqnojT3Aeicc4jnlaflIYAkqEA0uFldDJekQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00aqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:14:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4dOm013194;
	Fri, 24 Jul 2026 14:14:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whapr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:14:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDu2t31720096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA5820228;
	Fri, 24 Jul 2026 14:13:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03902021D;
	Fri, 24 Jul 2026 14:13:52 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:52 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3 4/5] perf trace-event: Fix heap buffer overflow in read_ftrace_printk()
Date: Fri, 24 Jul 2026 19:43:15 +0530
Message-ID: <20260724141316.99507-5-tshah@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a63732a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VtaRLcDhIP_0eUlUAlEA:9
X-Proofpoint-ORIG-GUID: AChTg5-hg2VGHP-lE3desCAIwFUdr2Nv
X-Proofpoint-GUID: ZUysvOTBUerWlPo3ANMQyZEYRiCIko1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX2IyR2EiDf77/
 mp++kyTYVhA5vx0Azg36xbdV9zGivLB9gmYWlLt3FIHmt9DOU38pDw4/NtcvfvrgnlxIVyfNsy4
 F8jLHFq0/madoqttImgCxyXUGbddOAEziOgVzpGYNI/gJuf1e4MJdLY67LHBHlY/CHWtabUtaFE
 nuJDpWPG7ZbCCdDcQp+KfypSd3hnbHXBvhAWDOlMbmZCO5orzf0HQ6SMBzV6uueVKLJwubnMm3T
 qt9xZD6Pb1NC8rrF3GdgD6LMenK+I3z/dcH+4sOVajhzMeQYYCH4HRqIYYkeCd68C0mo03dVuYN
 ZqzQRvVg4k43Ps54zeW8tzR7DiDKVsB3Lx09w8NFwtknr2vZHewmI8ygvBXTmlBX5FDsuM0gUzr
 6SaE9hJbzlFHklrF0Q/qNaFiVO+xVeAhzbMKjGFVN8c5JB2bC7UGoho8SjTYzVif91QBLuBRBH4
 WPM6PCXs5G9o0kqbL5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX4JLOgYTFelGB
 6FZm6icHqF2t5nuIxwWy6UVZDyjnOquDIlMkOMoqKWlEGBqRpXawkwBjI2LBtWDqT4kCMWSL9MV
 JKV9axleNKXkpo4hOuXuG4tq5N9vu48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

size is read directly from the input file as an unsigned int.
When size == UINT_MAX, malloc(size + 1) overflows to malloc(0),
so malloc(0) returns a minimal allocation while size itself
remains UINT_MAX. do_read(buf, size) then attempts to read
~4 GiB into that tiny buffer, causing a heap buffer overflow.

This was previously masked by do_read()'s size parameter being
'int': passing UINT_MAX truncated it to -1, which the read()
syscall rejected before any data was read. Widening do_read() to
size_t is correct on its own, but it removes this accidental guard
and exposes the pre-existing missing bounds check here.

Fix it by rejecting size == UINT_MAX before the allocation.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 52ed496d92c3..147a3b95ce06 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -180,6 +180,11 @@ static int read_ftrace_printk(struct tep_handle *pevent)
 	if (!size)
 		return 0;
 
+	if (size == UINT_MAX) {
+		pr_debug("invalid ftrace printk size\n");
+		return -1;
+	}
+
 	buf = malloc(size + 1);
 	if (buf == NULL)
 		return -1;
-- 
2.47.3


