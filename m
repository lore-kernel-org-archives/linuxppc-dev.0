Return-Path: <linuxppc-dev+bounces-20366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B3ACD3423
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 14:55:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Yx315c0z30PJ;
	Sat, 02 May 2026 00:55:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777647303;
	cv=none; b=AIprDN/Vkeg3p0IPLkUPNhX0lNi4CH7v8FpAD7fiY/NSnnl2AnNLv3Y3a/HoolbvFrx01WU3OOAH51+ro26yg1tern7kV0LqMeQwdcflLPNYHplmB2wpuquo4M7/r3VT7Tg1HUb69pv1lP/rH8ztpp6jtl8lTzEZUvyQ2vGZrasxOEgO6V2k27WjQhhk4HXJ/IhKwfM+eq/WUdIZa5MpVY2DtJNxErCTHwY1KqEqNgfbkjBcRSW70Rz0GuFfUvjdVZcp94Fm1EyzCIuFP8PdFZU515I/CKvnR9Tv3uIKf3NurZJN7Enkz3I0dD8W9vTKp7HZOIuPP2BGk7pmgBB8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777647303; c=relaxed/relaxed;
	bh=PaUPb61T35gRamkyqo/ocyRJdv5JEcgJkkvFNjCMw6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkFtfk3wgraeTWiizIu9CF9YW7oKc3fge9l0HEYQSZiUDBntGgwywX5b2q42PHhKDnp1s6BpiZBfnDjeRY18PzmdbbUZc+SKIC+Xr1l6XTht6UKAxthO3Ruo8dW2Z6gfqI8Lu4xH6PN/aZAT3AaQAutl++LsJY/UDBgHv9i3kQrN0TvH2X7QDScmgMcuVrl2M2hwxtgJOFNCveGJ4gO/5ojkzWG8nEEXV/BO8FXQHEkSJu9H76bd+zhGMcfeo0ORycclW0/N74bV7q+MUg2vwm8veWmiDQziBh1CZHex9Xw7m+hyeUrFgkKeHQAZE6txJwRUbJoLDW9icSJH7AEqAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WKMJSrPM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WKMJSrPM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Yx22zK2z309S
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 00:55:01 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6418Iuh61694171;
	Fri, 1 May 2026 14:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PaUPb61T35gRamkyq
	o/ocyRJdv5JEcgJkkvFNjCMw6E=; b=WKMJSrPMUAoerRxCUtinTc1qyfNtfgsSI
	azTITfG6aNQpczF4jgTOZma9VisUCvVrFmjzB9y1Yz82MfR5MqH5AUiW5lpW1ALE
	MSJpTK8aJRlbCFUcmTVIHJqIKvTG3DOmQkxEA0/MGo8TIl0j9vKIHQjASnrnVHyH
	fpQvPK0fu/sOsM7tVtxt3aZ/R4+v7jFl5jN8YOpaiHaJKsvMCQxbb/KGiX9Tkp4j
	047AyPutVEbDq1kJADY3luIN0hK5ZTtN9nwkBmnWlp2jnTrtUgPSY9HWEHUgb6gv
	25rfwFBJlziuXx9cGd4KA7T2zC4rMHxw/V9kNvnbtIfR9Ar0CIZVQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5n25c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 14:54:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641ErpE3015302;
	Fri, 1 May 2026 14:54:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqr05j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 14:54:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641EsrLq24052036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 14:54:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F172E20043;
	Fri,  1 May 2026 14:54:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A902720040;
	Fri,  1 May 2026 14:54:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.19.167])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 14:54:46 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V2 2/2] tools/perf: Add kernel-doc comment to auxtrace_record__init() function
Date: Fri,  1 May 2026 20:24:36 +0530
Message-Id: <20260501145436.1327-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260501145436.1327-1-atrajeev@linux.ibm.com>
References: <20260501145436.1327-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f4bec1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rIN8eMsy0-pcsuMf_RkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE0NCBTYWx0ZWRfX4RGGXf5sQWQs
 zgJnySMOQGmDKdYDndPklFEHkx1mTXRDccYqId4LbfHkIkjmXKnH7Yx5vRAZiYEqYt7TnKVn3Ll
 eJs2JwjqmskkC1zN91x4SdBAkSFjcqjYnnvEY18VusAtFAk38MLmxJSlzR137hAjtVuMZ3g27wz
 5M6HLKf+SJ+b1o9jq9BxdZj0vETXIsjsb/yQ8GT4MASg66Inf7RHNRrOL4ztxCMptpaInGBicP1
 1K8TsYIploU/XTAMC+g/LOAMr3mhalrU/OmEWaPo67hNliLbD3h3KiqpIjklGhRNQ4Ny2PQMs75
 3TtDkdyRni/hRObvwLR6MoePbVMU625fuOZy+nRqLhLGTQlSQPvWRmyQA36K27eTMn7UE5Jf7Jn
 +fT1FByviRWOfjbasUjNslQGU/PHVOXUBJo+i1qNGFHS/u7Y+RGoSHttQ07dUTExyZjonHvM3Jc
 WZn+N0eccW/LAEcOk3A==
X-Proofpoint-GUID: j7-9lroufTt8fT8PR_LhIWeGphBGGj0m
X-Proofpoint-ORIG-GUID: pseR7_Cu_uKjSUU7-m2QyVgNJ7bh7rTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010144

Add documentation comment describing the parameters
and return code for auxtrace_record__init() in util/auxtrace.c

Using "struct evlist *evlist __maybe_unused", gives below
warning with "scripts/kernel-doc".

 # ./scripts/kernel-doc -none tools/perf/util/auxtrace.c
 Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
 Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'

Updated  parameter as "struct evlist __maybe_unused *evlist"
With the change, there is no erros/warnings with kernel-doc

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/auxtrace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a224687ffbc1..8c0447c54003 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -896,8 +896,20 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
 	return 0;
 }
 
+/**
+ * auxtrace_record__init - Initialize an AUX area tracing record.
+ * @evlist: The list of events to check for AUX area tracing event.
+ * @err: Pointer to an integer to store return code.
+ *
+ * This function looks through the @evlist to determine which AUX area
+ * tracing hardware is being used and initializes the auxtrace_record
+ * structure.
+ *
+ * Return: A pointer to the struct auxtrace_record on success, or NULL on
+ * failure (@err needs to be set).
+ */
 struct auxtrace_record *__weak
-auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
+auxtrace_record__init(struct evlist __maybe_unused *evlist, int *err)
 {
 	*err = 0;
 	return NULL;
-- 
2.47.3


