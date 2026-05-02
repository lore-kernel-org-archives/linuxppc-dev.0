Return-Path: <linuxppc-dev+bounces-20380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D84CD3423
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2026 14:13:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g78yl3fcGz2xnk;
	Sun, 03 May 2026 00:13:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777731215;
	cv=none; b=gl1RDWIogutFFvQOujmoRsQIo1pZ2SUvqz3p4chumG+nj9P1X5u+1+0ynPJHK5qxJNyPpRgeB9Vx0pOXQR8oOX5OcejMaWEZMfV/smye/copURrN2b7S3VoyVw2CmdUukG7rLnQ68tIvAhBUJTZPLI/CF+7OlY8+lnkT/0lvLidYFOqbBNGCCAqA4L1T+8pJQbmjnsrcdPGGZDtbUb9Y8xUokMNA9hRqmJ8pmIGyA5evnyA1aKXJxOARfG5SqoCo4PMGl3vSyvBGnG2ix+SdjJU5o55a5ox2/8aqvUClFLUT5JmtBuEOpZPdKrmxSMiJQZZGbbPIHrXXBj7ARzH/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777731215; c=relaxed/relaxed;
	bh=NQrnYnlv2aAV3m8E8dm1/D40QRqTd3oQDjHplzORYhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7TKvJpb7f+WlhniyXmo4eXcTMpE70adTznDJv+tLepi2W+WJcmQygHGfiKRrzu3KVvsWLEzSzw5bs5KIN6Weq6th/rPPamxpAVyrIXcYRooZUb6JZ5y0iJ7PtrztVaYoZrqI2E4kU0Hoc+/couS2dQpbavtYV0JEEGQ8WYdB08FnNP2N2R2/yNLhl6i9mtpy7JXEso0y4an7Gw8dHvFBoOTyJnhh1v2cJbzJmsG/XYjfQYIyrzgq1DhjcwD7SgFXKUitjUwN0s5nGnV+GPUyU7jrRFZJB3XPdMmtyISCyTvpaRGwOlqMDKJMfFr75f5glbDWElPFCnTvcYTEB2G+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I9u1HIgX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I9u1HIgX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g78yj5jw2z2xlr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 00:13:32 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64247jb31939676;
	Sat, 2 May 2026 14:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NQrnYnlv2aAV3m8E8dm1/D40QRqTd3oQDjHplzORY
	hU=; b=I9u1HIgXV2PwGhR1plwyVjynBUsyhQ4AmkNH3NThKQuXMhYzFnV/kyo7Y
	h+6SYr/oZVFP6vLpPIDIb1GQypLQovB0NiULIfo5Y6y0H4UsDFcVdm2RSQUciLZy
	yYYDEnqrDM3cDhkxSWKwj74x+1X0jPjYulyGNAFclGacz5kOPso0LCeZHm0Gj9Zw
	w06enfTfeYqVx4c/DYm9Ov9uPAbP8evgYolYx2pxwtQhpp8y7sTsDV1fq4oAeRbk
	G46S5IJqcS8rWj128ryF3P54o/EHHMnn2QlnY4RZVNZnt6j13MDwbkIaP2F0A2yr
	rBVzs6huYOOhWxTfSMNpSuwgJF8zA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y115g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:13:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642E9WPZ006849;
	Sat, 2 May 2026 14:13:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9jysc3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:13:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642EDGGJ31785306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 14:13:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 155BA20043;
	Sat,  2 May 2026 14:13:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB7320040;
	Sat,  2 May 2026 14:13:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.37])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 14:13:10 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V3 1/2] tools/perf: Fix the check for parameterized field in event term
Date: Sat,  2 May 2026 19:42:57 +0530
Message-Id: <20260502141258.17128-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Dd5NJWAcZdTcg9JcDuyXVWXmel297htt
X-Proofpoint-GUID: v3b8Wpc3F7E56A3wawAnh1eCXMBYpARW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDE0MSBTYWx0ZWRfX9rLyTNIXt5pI
 YV6pYYakdONQ43gaObDL2T5QOBUJ90azDIIz0H7MYRzc78S7JNPgqFe5I7tEWK6Dgs8wgRMFdG8
 hsSrj41O2rAfdYu2axgRQfnVn2W8oqSMxFmhvWIS1ZWjrrGbAX86Q3Nt0waXPQnQx/mnHYAbVj/
 OV/ewH/Q7cR0uoDY2ODZp1yblya0VGLWPDxjqvPcDrzkStFQ048uNORMLnsm1TqoXvXKMEH8dv4
 LK5K4a0EwhcXuW6lZEEvmvWoawciPA/CAqU5tKih3l8/aUCGVe8xt/f6hgVfMxCTe53Dc4+a+Of
 YdIEjDpo073gMmYqGd00iam4CVB/BpiP8axCkU44FmadWcR/v5yHroMX50ykd9mxFfdpkDUBHbx
 7djav89PHIPMEUUPzI9vUUwYkC05/BgpOtBd3S1Qop4pjgFT2tXdHf+h58OsSNGQMYywmMFysEn
 EC2GHZc4Z9JrpcqU8Mg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f60681 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=g2m9RzfYH6J901Z4KtUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020141

The format_alias() function in util/pmu.c has a check to
detect whether the event has parameterized field ( =? ).
The string alias->terms contains the event and if the event
has user configurable parameter, there will be presence of
sub string "=?" in the alias->terms.

Snippet of code:

 /* Paramemterized events have the parameters shown. */
       if (strstr(alias->terms, "=?")) {
               /* No parameters. */
               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);

if "strstr" contains the substring, it returns a pointer
and hence enters the above check which is not the expected
check. And hence "perf list" doesn't have the parameterized
fields in the result.

Fix this check to use:

if (!strstr(alias->terms, "=?")) {

With this change, perf list shows the events correctly with
the strings showing parameters.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v2 -> v3:
Split the strstr correction in a single patch

 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..0b8d58543f17 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 						   skip_duplicate_pmus);
 
 	/* Paramemterized events have the parameters shown. */
-	if (strstr(alias->terms, "=?")) {
+	if (!strstr(alias->terms, "=?")) {
 		/* No parameters. */
 		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
-- 
2.47.3


