Return-Path: <linuxppc-dev+bounces-26635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63261C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:46:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdY06506Kz301K;
	Mon, 07 Sep 2026 13:46:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788752790;
	cv=none; b=O2drVIYugKssyTZvYIEuY0zv+BmRN4PIeY/IvafcPE5VqMsxY4Nq7NbCQhSKiaFC8UUcIWFc2gJF1Pr1jaE4vkuSOJBjBeYA7QYbfOGei0W5Cy16DwMFbv3CUE18RMOH8htug43tYzG3X1Ny+cK/PC9sQyAZXToIyVWGeL4G9a1W5heyeNeV0L2tm3sWGvXXdrNLeiXQBxi4uFGqhtjJnceGEeJKHIbyeAofqorevEpNdt00LharQEqVo5wJ3dtw2J4Vls3Y0Y92m9+e5qEmAlHcD8LGPbUjJwyKZ+gBlEb91cMj7P/DB/k4gjbrNqU0nHgYYV4oRecGBWioAC+ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788752790; c=relaxed/relaxed;
	bh=9or9m5nBELjPR+Nji8Zzy3qCBUxgYFhZ4+eIzUZZwNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArUmIwe5RNMFFISUcKRmG/PkNNaoTBmFnatjxP3pfKViJpicP9WZSB5kttzPWFxpX++tXGZO7sc6eO3TMWgVcebsmD3IU5fLa85ms1735To81nT0Ri2i8Ewfburxw5Go460xeJG8sWaC3UYjfKFffCjf7Qfwuzi01lU9jQ1RJ2haMNz+WR7CTjvTnNKQi8yeHmoCXWP++l4F9u+fDabcBJpCHwrFjWMZ13l8sljFV9lSzxMK3DPDDTmSzCbhWIri2mHqX9gjqi/9uUPPK9Hth1GTrcRqV5edQWb8MiUs+1v1CN/JLSrtnk0PhhkyTZZ0K7aL7uaCZxYks2PvKwyM5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s+5yMc0m; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s+5yMc0m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdY055p8kz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 13:46:29 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870VZGd3363222;
	Mon, 7 Sep 2026 03:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9or9m5nBELjPR+Nji
	8Zzy3qCBUxgYFhZ4+eIzUZZwNg=; b=s+5yMc0mbHEhAv+6G7v56wIplq8KnU0Kg
	ugejFfMq/fSTvXaZIEeMygiMj97YLMfELM4RGbd5XJ0asQT2rNN4y4ZqVQxtSwzx
	raRM58y8FGvijplJglTtqr6r2I21uYGi6skt9RNsvrdpOktZnuFWaYNp48+cO6J6
	AvXjsoE3TQ02KRc0yLQISY/UJMQII7y0d/4tAdl2n9uD9a0RMkWt0eLvHAqq0UTn
	MlHx1eWg+bxfObD6uatfyZZg0YXERFiUsTZmPynXxey2MF83UY7X8JTwY+NpMY3x
	We+dvpsS5dSnc13H+pvQBCYfAyXKEtF6PUMZecipjnPznd4vwMw0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjre895-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6873fco0000944;
	Mon, 7 Sep 2026 03:46:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y3g5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:46:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6873kGCN50397656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 03:46:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C2C52004B;
	Mon,  7 Sep 2026 03:46:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED0420040;
	Mon,  7 Sep 2026 03:46:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 03:46:12 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        narnalli@in.ibm.com, vpuliyal@in.ibm.com
Subject: [PATCH 3/3] perf buildid-cache: skip caching non-ELF files and treat unreadable build-id as mismatch
Date: Mon,  7 Sep 2026 09:15:54 +0530
Message-Id: <20260907034554.714-3-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9e338f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Kr0y32fKJISN-0oWPqoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzMyBTYWx0ZWRfX6+nUsvtXcYuD
 gHEranJesLsvfKEQYxnRNYMh/ugLX1UDAQlLKYv6Ck8nTrKkrmA+i078pZXPipyjX7iKp2+gtU9
 6Ojj0pW8rlalUkN7jJIhlrR4myLnQGc=
X-Proofpoint-ORIG-GUID: F6CFnRsFVufhhvjwX8GklVrO-xI5HWfT
X-Proofpoint-GUID: su6n1N9a_siayTk17Myvon4AQBSzSw2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzMyBTYWx0ZWRfX8JxBVCNouuz0
 6RSpPkTk9fdR1+RLZGeXz44NBnfPin1bMqJTRLIJ0ujMbiIVQDlbadord7N6BuSGftbvVxHyG25
 Mkf32qoWxiA6uwo9El2plWHd2lqF9tjw0Uzp2iGzWQPNfmxmY9bFVlRwKX13Q5D+kAou/vO0bSn
 SMFGyulvB/99CIpzM2Z1Y9pOywefuH+IisKGuX9oqZflUabgSRcdChj1GbeBvKQGmIq6PvxwoyN
 pKdoEuGc4x895N5NGbENTedPJoAEE/Dk6C8OT6tLTzHvUuTNdWHqLyI9+nhi9zJ/+H8XDlacLbG
 dT/KaA1PKaCNZ/eFBN3x7XzOJv0yeNvinKVD0ppyVVqu+HfdgVsbhJaUR6jOG/Qrlsr1s1IJ0S2
 sV8srQj0hR0Yqw2I07e0n8jt6pvVGEzkdoEqLA0BBSMwxf/WOKynI94YD9a0nNSvHCsx9KIpDNI
 qxPPcgJKC6XTFjovhMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070033

Two related hardening fixes for the build-id cache population path
(perf_session__cache_build_ids, called at the end of perf record):

1. build_id_cache__add(): Before hard-linking or copying a file into
   the cache, verify it is a valid ELF using the shared is_valid_elf()
   helper (introduced in patch 1/3).  If it is not, emit a warning and
   skip the cache write.

   This prevents a race condition that can occur with test harnesses
   such as SPEC CPU, which briefly rename the benchmark binary to a
   .used.<pid> path and write a shell script placeholder there during
   run-directory cleanup.  If perf's cache write races with that window
   -- seeing the renamed path in /proc/<pid>/maps and reading the
   build-id from the still-valid inode, then copying the file after the
   placeholder has been written -- the cache ends up containing the
   shell script instead of the ELF.  The ELF magic check catches this
   at copy time.

2. dso__build_id_mismatch(): Previously, if filename__read_build_id_ns()
   failed (e.g. the file is not an ELF, or has been replaced), the
   function returned false (no mismatch), allowing caching to proceed
   with whatever file happened to be at that path.  Change the default
   return value to true (mismatch) so that an unreadable build-id is
   treated conservatively as a mismatch and caching is skipped.

Together these ensure that only genuine ELF binaries with a verifiable
build-id matching what perf recorded are written into the cache.

Reported-by: Narendra Nalli <narnalli@in.ibm.com>
Reported-by: Vijay Puliyala <vpuliyal@in.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/build-id.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 28b6b3f8d5d3..32ddbd5e61f6 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -684,6 +684,10 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 		if (is_kallsyms) {
 			if (copyfile("/proc/kallsyms", filename))
 				goto out_free;
+		} else if (!is_valid_elf(realname)) {
+			pr_warning("build-id cache: skipping non-ELF file: %s\n",
+				   realname);
+			goto out_free;
 		} else if (nsi && nsinfo__need_setns(nsi)) {
 			if (copyfile_ns(name, filename, nsi))
 				goto out_free;
@@ -874,7 +878,11 @@ static int filename__read_build_id_ns(const char *filename,
 static bool dso__build_id_mismatch(struct dso *dso, const char *name)
 {
 	struct build_id bid = { .size = 0, };
-	bool ret = false;
+	/*
+	 * Default to mismatch: if we cannot read the build-id (e.g. file
+	 * replaced or not an ELF), treat it conservatively as a mismatch.
+	 */
+	bool ret = true;
 
 	mutex_lock(dso__lock(dso));
 	if (filename__read_build_id_ns(name, &bid, dso__nsinfo(dso)) >= 0)
-- 
2.43.0


