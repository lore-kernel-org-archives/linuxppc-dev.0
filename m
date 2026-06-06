Return-Path: <linuxppc-dev+bounces-22150-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2816ACD8C8C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2026 12:20:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXcpC3Kwwz2yS6;
	Sat, 06 Jun 2026 22:20:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780748435;
	cv=none; b=jNjT0EMg6+YiFwH1ZJYBI2ODYUuQ3G7d1fyadpZFbIYMfQfjHaP03zeemFvZJcwM2P1ZNIlLbJ70wiKN0wUQjX+8wVM0E44Cu3UqL/ib/x+QOF+KBLCP/ayTPixftyZVHZGCKmgKhKVjK562a0vrHhjywR2ll0L3aGPhimx3kUbjtkVJCWLZGAam5ec8SmgwE59ZobjvKrkxA1Z8i7ivSpTkwTa9fOtoBMIuAnJKjeccuSBK5hk2FVQRXAxFXwoIjR2DniYATaedcgSakl5/Vul+3DipcYwIR3Dej3AZ0VlRZcmpf0yVs75EJ/U04cBJgJzH/FfAwk0xKYKA8E7p1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780748435; c=relaxed/relaxed;
	bh=fLwS1YIxOJfufyjYhB52Uo0u9IFZTzVVV64omQWyYzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9eIb5gQESaK80M3ScsqGL6gCdDHkFhXQQSX9B3GLHw+kYguZFqUPVhiGGwcearWWhmYle3YRjhYf40t9nvCZ/RsMl7fAv61eVXLx6l8hhwDht5f1Np7tarwbIVapvaveCwOkpqBjqUtZdPxuZpXnddNkNFg8d7hQKgZa7teYEyXN/MwrUmiKhlAHlsl7/6cCutbyEbCVtJaRrS2jwTQi87pHXwEvwQwxaqaQcRooIt66RJ2CO3dcJjFZV55G+jZJqiPxahryKdsf0F5dujXCwwJJxu4Ue4x21IyMkRynsUGfKGvDvZuO2EEPXusY+AaL2M8hfuRrtt2RQdu6+s7bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LVxdZk3Y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LVxdZk3Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXcpB2J2sz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 22:20:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656AIBab690954;
	Sat, 6 Jun 2026 12:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fLwS1YIxOJfufyjYhB52Uo0u9IFZTzVVV64omQWyY
	zo=; b=LVxdZk3YVzY6aUMp4wOqhdoklVmsOYF0zkUh6Peb/OXa4Vsd47dI5Gi7E
	Rh/Lnp2nwcIF35j952KppJTBVabnd6XHxUwWS8RyzTVwQJl1uqTMc9TG2tGeJ84u
	QH1PBeXCxj5YT4SSwW8+RkQCCl8PxvI5jCjjnk+MMzhCADKkw7pBgJbo1YyaI3s2
	z676XPt9RovE2qkdjGpE+/DMN82/phC5ofZVlbswFyjo2/5khiB53K+346hal5Hn
	OiLGvnbvsCzm4q7cGcsBSwyB4zeTs6NqPLn4P+O9pfQjlJmi0Hd3X6cdCZW1GtZj
	BiJWyVAMtr0wlCStqmyitZV3fGSjQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9yds4m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 12:20:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656C4Zhx019232;
	Sat, 6 Jun 2026 12:20:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qwtq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 12:20:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 656CKNTg59572716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jun 2026 12:20:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24B22004B;
	Sat,  6 Jun 2026 12:20:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F68D20049;
	Sat,  6 Jun 2026 12:20:17 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.26.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Jun 2026 12:20:17 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH] perf data convert json: Fix addr_location leak on time-filtered samples
Date: Sat,  6 Jun 2026 17:45:29 +0530
Message-ID: <20260606121528.406919-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMSBTYWx0ZWRfX8Iw0SN3iFMPH
 wguFV9Ws3di2OXsJNfhYZHrpNGTaGowB68+1Kjprz/x49/de5iE02z/u+VlC1gOukNrXR3DXnaX
 SDLrLKPT1QRkiP9GxsKd7xSEj3lyzuwuD7M4YgVHW0BUR5/7ckBorQI5qdSlrPMgNbavVee2NcV
 RWeLG4zeVXTvtMKuxvfdSu4uFKTlCvhpMmFBXnMhgytFnx2l2jUeR2DG3AEgfEx4tsYHwqsRrLS
 m6yInnVW06MGcGshficDPUX7sL0t1f0nGn7m4M8xGLBK2BYjNOMKeqiOUnTeFTRHMEQfZCRaOXb
 hoQPrrzDKwYmHNqnvfm5sHnu1nwesCq8cFgLaSOrMVkNPgYHTtxMubXTuNQkCLaiOTWAsYdCfiq
 PO8REQHjsVSW9ovPVQ44LStrIAYVOZds6LSwuV/DoE9pDrnHnkw0mIKNcUMKmDwOf9KYgeVZHJ3
 S6fDNAbzNch1EAeeeoA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a24108b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Ty57jLF3Lfqec-trjoQA:9
X-Proofpoint-GUID: rHho-ua72mM_R4wr9ymYhgyxrzht8VKz
X-Proofpoint-ORIG-GUID: Kyj7MI4yhoK0fw0vmueOMv-Vmd6nQHRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060121

When samples are skipped due to time filtering in process_sample_event(),
the early return path bypasses addr_location__exit(), causing memory leaks
of thread, map, and maps references acquired by machine__resolve().

These references must be released through addr_location__exit() before
returning.

Fixes: 8e746e95c3e4 ("perf data: Allow filtering conversion by time range")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/data-convert-json.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index d526c91312ed..6a8d00c80394 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -177,6 +177,7 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
 		++c->skipped;
+		addr_location__exit(&al);
 		return 0;
 	}
 
-- 
2.47.3


