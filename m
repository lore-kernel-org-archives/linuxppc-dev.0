Return-Path: <linuxppc-dev+bounces-20382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60520CD13DA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2026 14:32:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g79P55M9vz2xnk;
	Sun, 03 May 2026 00:32:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777732377;
	cv=none; b=Q9/XPBwMaX/R+8gDIEAtQeuhMPxaOldeG8vzulXzP6vtjfVtxaBKuD8o8H6wM4As+aefO/KYNfk07Wuk+4iyTyhHWHiH7LGnodZs5uKIcQQOtoz/hFzV8GjrGO3zb2/4U+Bk10tz+yr5cuB12kkIJBTo6hsmUV0zMzS3suJs0F3BLmXmnp4tHfWzwyxk9IMBlkPikaHQTAxL5b9WWqfe1RF4Zj6DpWAX5EloC9H/0VjI9bAJypGIwPQOXZA2xFnDpxWYNVJn6UiKd4VYPpPrTmXZpFWr7lm+E0P09udbAf0DeueqPQEkdiIV5JDdRM4DkHsKLrD7jbvNSkO9s/r/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777732377; c=relaxed/relaxed;
	bh=kuHqVdlej+Yn0HOXIpjPZZdn1xMOEqKbsgmm1UXRwMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3geCBvxfwS9NdP6b5y5P/5CJa3RYXgwkIRRzBsQV16XX96eqFFUSfMqhVU93IOhsJjikQUUN60hNFOW7rQcCCxdTqsfjIYcMpZTA4REIuJU+VHkj/bJfP/IQ6v/tB9A5uW7PU+0lWOq0QaLVzRX9JAyVHsXDCSyQS4armY05YVyr05Vup5CEiNYf9SBCVHUsp3x3dSDNE9XsqT1scXhkSHcW+5KszaHHk/eY7a5nVhi8cztmhIrUJvgm7vRo2vkxBvmmcjYGui3nh5B+bfxtZhhuRzxGoUp3zxpMwb7E+nnU/eSPsylrTKpFfSjYqXoap79/fD0A0Z16jDirsiBDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZXXY0bci; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZXXY0bci;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g79P44NQHz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 00:32:56 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6427NKNt2333320;
	Sat, 2 May 2026 14:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kuHqVdlej+Yn0HOXIpjPZZdn1xMOEqKbsgmm1UXRw
	MU=; b=ZXXY0bcimFS7s+UuKIRYE6gYUWW/BXtHAvxgkOyFfZ9XTVuTFlNyV/xSW
	az3N3Z2JFKiQEgq6vSse/rJqp3Vv22bCDXEp5c8HMFUY5WxMON1KXhce6FR8BW5f
	i9yzeVVnFUmWQ6YrcN721u0/T7TkmcAIqwyyPSv68HxRphmBl4YDnLNBOfpzXO7j
	8z5ZvDWx6WY0+5UKn+CM6HrYQAa2pr3x77bi+NveGCtZaTvKEYEcWGOQw+SaLfEY
	8IpXROzu5d8r1/udbTpHxNTUfpWw6EJZMGXAxljuVOUY7vnIELN0lKb4MkuZGVeK
	Z9HTI/BQe7LatXzOSDkbbf2qZG6qw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y495cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:32:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642EOmWM009315;
	Sat, 2 May 2026 14:32:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9fs9dxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:32:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642EWjs735782920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 14:32:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 136E320043;
	Sat,  2 May 2026 14:32:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAF2B20040;
	Sat,  2 May 2026 14:32:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 14:32:39 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V4 1/2] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Sat,  2 May 2026 20:02:36 +0530
Message-Id: <20260502143237.23456-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDE0MSBTYWx0ZWRfX+GjDJc/uByfZ
 x5pXiEs0i+/wemKBf8qOSBAF900UmW9wZc2CaZiMFnbBkSzA/HKVOpx7w7XCUAEmjIQC4S2OUPB
 WE2Sptqf+QHGRjvpTWY4UyrFKQnsqpxD4UFCMS0Q+2oStG11OVtLOZUSRE3xwmoNzNhwjJTivfl
 3KPpQ6x4ZPT5c5g/b32Q+4mUdhk9JvGSVyEHScsNl8sAlua0NNAHgGD03PIDCMijXAHtJ1a/04k
 UJCQFgfM+Rvawxqf22UorkgBBJpPMqrXFd31Qb2RFFHHS4l8aH/fNaW38/5SFIybWTC0BdBStie
 qgkcqFa0fgeebRTdJnGqRqRDMbZArfBviQKquz/vhp8ys70cOnJANaEPNYSduhdPRFJKL5qVt51
 VANLUWk/Sw/geQ8Una6eX2XicrmrNnZrOBhRYuvOh0Yfgmy8v7mKwmgTaXSQshNYpqnstuwhE3l
 6zQT0B7AeI49opQ+TyA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f60b11 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UYfmDeaf6v5XVjAx5qsA:9
X-Proofpoint-GUID: cfOsUC42KIWAZtrn4Zl9Swbig2OcC7po
X-Proofpoint-ORIG-GUID: -ZT8zzJPUQgicBy1YPMdRHKy-ouycN71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020141

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
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
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


