Return-Path: <linuxppc-dev+bounces-20102-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DDBFF8850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 06:43:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3HGC1BjSz2ySC;
	Sun, 26 Apr 2026 16:43:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777185811;
	cv=none; b=NKlS3cQfmro4Mh9Kh/XjN7CGBbvUqIBMaKk/PMlw/4xxoLWQ/jltBLiT/Xo9IaCzRiBjhjr8dlXvDymGgiqJ/fyec6YZtrdbZABZBS0mxcfknM+BR/PzEO2Vbkm/NXi1ckbJODTJwa89n6jCe++scqnekcAlaJZA1CaZhGhDDdEDW0Y1NHCc7qdI8ORE8izN8N4CRqNfa4Z7anbAAWfehABoqWjRlddhbikkx1Xn75/iqc+XwfpzY5wfOBW5V1DGzyLlQAzM6GbCxPiqQYZWHBM9c0U2tMpFrQ+2zMal886UEeImKw5ZTDy2u8RoFijE0u1YhzSr5jxGwpJLfrpGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777185811; c=relaxed/relaxed;
	bh=BvtwsbBAQmFfsApxt3IjotvrGVZq0fRyTEkJQ6H4GiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JaqaPyE8rHstnL9LB8VfWSpJmV07gNug7/c2VbK8GlvZo0EXjHK4MI1RNNtnS+sgjxEH2oWGMmPM0vgjirZ/3zBo5+NnsUFhTN1baHItVu28Xyx6ThO8r6W/P529IV8jQPUyedcNtWMHTOO4k7+hjxi+jue3c7nIX0k7CLUPYzIA7cqNZMsNurOtU8UDn4+x6SEjMLrLTTTMYD+1VA7xZwvBEqEB16EJKZI0ABuAWq/WdcHFWEcD72t3ynUl5I6maDtvIIfqOyM5tbpvKJdVzNOJvVRQioXVg7G8go8oe326Br+8QzXK2NI3uJNLSQRF6S/78tr5Ps/fscNaZlcayA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gH9QY3Pj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gH9QY3Pj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3HG954LSz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 16:43:28 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q5U6UX759455;
	Sun, 26 Apr 2026 06:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BvtwsbBAQmFfsApxt3IjotvrGVZq0fRyTEkJQ6H4G
	iA=; b=gH9QY3Pj/ypuBGLPX2eiahLyRYZMm8aTQ2N/WfftcQ9RCZWmYbHSh38JW
	1TodbPkKmrUNTUcknwVguvYpJuCtkOF1uF74cP/dftBK1sAF3N6tGjeJvSJYgWK+
	kMGdELbQbG2TYl0xSa6nO19yIDdduwStFO5BZM1BEHa0CRuj41mBXU5DcRYmucJV
	IVx7Wxhhlt2Vc0qRGkQ6FZa4i4NHxvyssN3y25x31qUWg7+VTa13B/y+yzsJbHuz
	uDsr9Ug+YwqsgMOJ8D8aPrVWtQYmtmuZOutBxBhABy4JGeyInbeUM4qF+HX7/jI1
	kT4NQX59DAZLLb2AUyv4vYH8OCCbA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v3955-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 06:43:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63Q6cx19020166;
	Sun, 26 Apr 2026 06:43:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh0jtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 06:43:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63Q6hBfs19858120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Apr 2026 06:43:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A05D20043;
	Sun, 26 Apr 2026 06:43:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5457620040;
	Sun, 26 Apr 2026 06:43:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Apr 2026 06:43:05 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Sun, 26 Apr 2026 12:13:01 +0530
Message-Id: <20260426064301.90614-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69edb404 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ftuLF5Up4WlwXrOVWlAA:9
X-Proofpoint-ORIG-GUID: bYUMPJ6H1heoRJh39AfiN_fYqvVf61Ci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDA2NCBTYWx0ZWRfXy+Aal/eGWTsM
 uqngYrTbES04FSB8FNE4WSD68/HBXt0Vnkt4Dvl7Ov0KQsKHG/mxWdH2ebypf8/UNNPh79T3Bmw
 02idVCyeZlNJmq8z1l8RenLJSpllNoOrYs2+hTfDftPqBTaQ4AcL3mWrD+dJxtpW9t4r9qaaefJ
 xMxMSiiSj8sgGxtxtzda09QiBhGmb04r+oFdRCAXg4sGYv7mVR3SIUQwZ63xLxywO3MZ8HdO5qB
 B43rgCSCwJ2IP0CWqGTHZam863m1ZnQa0mBM/KugpvCG7TpKDwLUJHeR6cEOA9NbCOUhp0w2th5
 K/ebcjxpC0qjxs0Ifozh9XZ5SaQ5MaKNHQUFQSwnY4E2yAcgt4mCwmNdrMNTBMXRrvV7Oteh07U
 7ZBh0lojKHSI3WokHyHH5v/hHgBA/OgF0MpEKiw6lhQycjcOo2Lw1Ir/Jah/CXytrl8Z9wOu+ub
 hYliZIycl1C1OdSxjbg==
X-Proofpoint-GUID: bWpierwrhwraEXgfOg4amxVOG0XjDD88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604260064

perf trace record fails some cases in powerpc

 # ./perf test "perf trace record and replay"
 128: perf trace record and replay                                    : FAILED!

 # ./perf trace record sleep 1
 # echo $?
   32

This is happening because of non-zero err value from
auxtrace_record__init() function.

 static int record__auxtrace_init(struct record *rec)
 {
        int err;

        if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
            && record__threads_enabled(rec)) {
                pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
                return -EINVAL;
        }

        if (!rec->itr) {
                rec->itr = auxtrace_record__init(rec->evlist, &err);
                if (err)
                        return err;
        }

Here "int err" is not initialised. The code expects "err" to be set
from auxtrace_record__init() function.

Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
err value in the beginning.

- Clear err value in beginning of function. Any fail later will
set appropriate return code to err.
- Even if we haven't found any event for auxtrace, perf record
should continue for other events. NULL return
will indicate that there is no auxtrace record initialized.
- Not having "err" set here will affect monitoring of other events
also because perf record will fail seeing random value in err.

With the fix,

 # ./perf trace record sleep 1
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/auxtrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index e39deff6c857..fe1ea4e222f3 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -71,6 +71,19 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	struct evsel *pos;
 	int found = 0;
 
+	/*
+	 * Assign err value to zero here. Any fail later
+	 * will set appropriate return code to err.
+	 * Even if we haven't found any event for auxtrace, perf
+	 * record should continue for other events. NULL return
+	 * will indicate that there is no auxtrace record initialized.
+	 *
+	 * Not having "err" set here will affect monitoring
+	 * of other events also because perf record will fail seeing
+	 * random value in err.
+	 */
+	*err = 0;
+
 	evlist__for_each_entry(evlist, pos) {
 		if (strstarts(pos->name, "vpa_dtl")) {
 			found = 1;
-- 
2.47.3


