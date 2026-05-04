Return-Path: <linuxppc-dev+bounces-20422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CBCCD3439
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 15:13:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8QCC27b4z2yZN;
	Tue, 05 May 2026 01:13:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777907623;
	cv=none; b=AK3XPDtxRr9Nvxk/sb08jh+SckUt0fjTPNH2c9kGZpRzBEU/ArigGsxFWF34GiIR73EhaOJ5chynf3Ofm5xKS47eogPyNtU82d8xNb1gkid2VUdjhRPgUhwpIl+J/r/jhkb0vpcHtJmvYT+liXDxEd8gBOHpOmIW0fH37HvFG7hechI+zbZR9Zglx5m/m/IQ/GI2ykomw306td6wzHUss0qtE+oAKdZXW+qQApyXqYZ9NMor3ANu1UC/r4JBY/+lbxSETnVsglRNTvBQe+JNNgIiuSTt9g+wJrA6/OpPnwfwXHqOCussOQMpEkZK7zTUH4bXQwnxNPDpcvFzzJ2oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777907623; c=relaxed/relaxed;
	bh=gXgbgzfQRi7AGx3+dyd8Lfq9Z/7JkNqsY55X/jMKO5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XwNCmIEf9biU8e/qLGB5cX+lBntffnNjipvQT2B1BO111wmC/yCQ3qNE8bCj97koJC0OpaYWitM/Rsyu09EcTIjFvCUwAa2Yz/k3rSr1mXv63KzTtz6L1wN+nCr3S1iKBwGgYoQZNGSV4umCGM7ZMzODCgnOCCkeIFVtaodQokhuihpIJb9pRGAktRdqrc/OYK6yQxCbBBIx3ztzyTYbThjODe97hFg2b/R5fhV8DzEc24V3wdO7SrsQTlaDC8TmKQfYJ1T3tE3yQ+0ZKWFCB5oKpYcb7BXGa9nFPXLHhTxazIDoGxBHnUkB9PqA5h2smK9xeNkffOWKSN3ImswijQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B++gdd0A; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B++gdd0A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8QC91wvZz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 01:13:40 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644EoSYB2607845;
	Mon, 4 May 2026 15:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gXgbgzfQRi7AGx3+dyd8Lfq9Z/7JkNqsY55X/jMKO
	5k=; b=B++gdd0A9EcXy9FL+Al2frStPz6G9DmrrOFlMbUm2sd8Dqxq6xddoe2YF
	9Nl4tiSWFEg1PDm+vLVv/QRhm6PzDMeSH2yHJvfF+B7DMuR4kaFdJJjzbsodXxWS
	gWSPkWBeR2NkAnnzzy1Glhqc4mE8+llhwOVpaJ9tHmmtD4YYhIcpKFlgklsRibTi
	DUxY35nUdMsZw+JHKtphzePl2mvPEo06x0AnRYz0Faf+g7jRZfYDqZkg3+5u/k6s
	ih6z6orAoibBsTd+WChH2kGGPH0j+f4a9RT4BhKCUQ5syMa8AQQXYh3deCmQBbEc
	uiBWKUOElmeOUoS0DBlOUyu3adPfg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y17mxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:13:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsSeJ017439;
	Mon, 4 May 2026 15:13:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq5tsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:13:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FDVwI38601176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:13:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EED9C2004B;
	Mon,  4 May 2026 15:13:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1013920049;
	Mon,  4 May 2026 15:13:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.208.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:13:25 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V5 1/2] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Mon,  4 May 2026 20:43:20 +0530
Message-Id: <20260504151321.12346-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: iLo4FBlXZTFexpenr-Z1FOO_JKBSAAdf
X-Proofpoint-GUID: LgL2sFeULV6Dx3LSwXtiP8dXqu0polC6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NCBTYWx0ZWRfX+VQA66onVwNg
 6BVDVExLZLMUz2Cu32Cc+oXgLx87ZibEnDK67MPnZ/228mtisSmZVUh5xRhAkiyS242ZOUr05tu
 cH+rc81IZPD1KeVShyMrLesjuCDiNtCgfMHdMjtGmfRGKLdhpCUc7h2v+xlB0guWUzKtEE5lIvc
 3HWGtyWQjdpQ26h9x2KMlJuszTl/CE8uT1Wjxjf91iT7ydv6J/kzw0Qy/dx5ZwrNwo56BUzqLK4
 7IHHnzwSRRJz+D2O75toc+lO+CHUfO8CWVhXSE6G08LOwWnqHzic0AR7mOG2oV7PC2/gzcLOT94
 bUqBPEWOgfEtDmsAkmNxzQi8VPohwOgLwSrnitI+ZwN9fRSV3zg5CIqEqLbWWcRPxgN+2GDmmuW
 a1PxiNywgdaKbcsA5Mwzii9+TaVERwK/mHRUc07PX+GJ0EbmyFk+pp67TKkfpreKz4rFEiHBY3n
 NXXHbW4GA64KWAxhM5Q==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f8b79f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=UYfmDeaf6v5XVjAx5qsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040154

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

Set err to -EINVAL before invoking auxtrace_record__init() in
builtin-record.c

With the fix,

 # ./perf trace record sleep 1
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v4:
Added Reviewed-by from Adrian

v1 -> v2
Addressed review comment from Adrian:
- Set err to -EINVAL before invoking auxtrace_record__init() in
  builtin-record.c
- Added kernel-doc to auxtrace_record__init() in tools/perf/util/auxtrace.c
Addressed review comment from Namhyung:
- Added fixes tag

 tools/perf/arch/powerpc/util/auxtrace.c | 6 ++++++
 tools/perf/builtin-record.c             | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index e39deff6c857..4600a1661b4f 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -71,6 +71,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	struct evsel *pos;
 	int found = 0;
 
+	/*
+	 * Set err value to zero here. Any fail later
+	 * will set appropriate return code to err.
+	 */
+	*err = 0;
+
 	evlist__for_each_entry(evlist, pos) {
 		if (strstarts(pos->name, "vpa_dtl")) {
 			found = 1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..708825747af5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -865,6 +865,7 @@ static int record__auxtrace_init(struct record *rec)
 	}
 
 	if (!rec->itr) {
+		err = -EINVAL;
 		rec->itr = auxtrace_record__init(rec->evlist, &err);
 		if (err)
 			return err;
-- 
2.47.3


