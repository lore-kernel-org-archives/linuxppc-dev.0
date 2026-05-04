Return-Path: <linuxppc-dev+bounces-20424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EA0CD3430
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 15:42:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8QrL2DdCz2yZ3;
	Tue, 05 May 2026 01:42:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777909346;
	cv=none; b=kEZseliirxo0mKIxgUiPusFtwHVulONyjYUPKC5R4Q/wkAAvcCeSpMd4nhLPUD731iHWsB+BpCTiP7wugN/5QtYTtbj/Vr1LErn9AIUnKE+DfFDRMR5he4iVPqK0Md0l3XPZf9gSEtbMk3atZPg1UYOSoX3EqtEa12yvoH8OfFoSNO0XSMg4Z/EYWSNNWm4SSemECQo40A27TVFCTImfpFAsDFi9efV8PtP7r5wlcCSanE8oV+2Bwsh1S8rm7IkxpEIOHXKdo2mhWzujUDhqE0ARgFWKtGIX86RnyiuTZXy/ZBkck8tYxgez6vgIXfKAySD7+gun8VhunUqwcmNe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777909346; c=relaxed/relaxed;
	bh=iU+kuad77WgAER0Xt0/0sHxheaJL/nbFKFSiMXKtYnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YH8MsRpmewsEE9+0La4ZvBZ441hfTDsHY3PChOoyxk96yclbqz7p2MbphhUf7T/W+tSncrKEYIEBDr0ujsIoR3Tt2ELOjMmqoe7hWjIbUpKXKIGCdofQlYxtjnWIFc6eK6txkE7xkEDTS8LRWI0Rv2ZA0Us6z1Iv3xcUO/xHPpRqMhiZf/+FEEo7BBfvKZVtJxErW09YWgLXFDXrOFg03tkZJggalMwzBv1TeAokcFcId0txw0O56FYDMBLQhvRnzzyLXLK1ECXa5qc1FTDTfGUe12vKO0Ue+ihrlOmvo9mYjUQlJhN8JsGmcYIrFL5MKk8MiXlMVmyIbqJaojmz0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fwtRl8ql; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fwtRl8ql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8QrK3QkVz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 01:42:24 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Eklfk3011871;
	Mon, 4 May 2026 15:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iU+kuad77WgAER0Xt0/0sHxheaJL/nbFKFSiMXKtY
	nY=; b=fwtRl8qlT+oReezR5b2x0NLGODYDBrryqhojpNE+IHGEoekz4RIndOkaA
	ejSt72pW89MZMXsyY2CFYBT1fMcvzv9Kny1RK78ViztI9lDE43dGSYTTikdPkzxe
	+cIvuE5EnxDPLQ6qUEGDYRfQ8GnB+g3rmoJucAA8M+8N1rNAkYqX6gXx7/K2QB2T
	9G4KInwIWb55OOdqUMnNndMBwgQAaoaL32GSCWknYVc/TJTyJLbWpCH7QxJjwL5r
	7fttYoGoM31wXq9kUgMH1XBcxwGVfsgMBJ4juzj+oArieqPJUnfYZPsNJqs2ns90
	AQtK6pqczb4JuL2AuxVaVzOdcKBZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w67k87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:42:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsSIK016761;
	Mon, 4 May 2026 15:42:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjnrmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:42:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FgDHC44106170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:42:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCBFE2004B;
	Mon,  4 May 2026 15:42:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2683220040;
	Mon,  4 May 2026 15:42:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.208.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:42:07 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field in event term
Date: Mon,  4 May 2026 21:12:04 +0530
Message-Id: <20260504154205.21394-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f8be5a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=g2m9RzfYH6J901Z4KtUA:9
X-Proofpoint-ORIG-GUID: nexF7THWWWeXZv-unOZSwrOuqnh5ojho
X-Proofpoint-GUID: Z74undJVeWR371vXreh52SxflY17yq4-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MiBTYWx0ZWRfX5tfB1+DguB4H
 uC+j6R5uZb71wmilrBx21DgF3KlGJSc7uohgDc+J5uaCy+J423PVqOnAkxHklWoYO+7SCRtUM/v
 dT3tTf4zSyRo+uFdVmeY/Mi2T3b+18kqx4TBNBCMFyR8B4P4a8+dUzBj+ss0wXhg5o0As/erp2m
 FyqESk4c0GkGMNidlvnd18H3AWNAhUc0xo2+2/D53gHsefBlbA3GyfjZOLjzPpp8/ooazkz1ij8
 7HR1GzkT88VAm5RBnx1ZpD5Nr+z2EOI/8XZnE4fRWQUkT7esC7W/MClcsJ2nqwtqbZNJLSMmPcM
 ewYw+T5V+hmcGl0T/mgGIbG7zjvx+ZkFTKhzlw55IhIa2L+gS0vui1h9eNkMPGUcoIJwZ0+qAUE
 SIfM89tgLkLAgWsD3J/MCC45gM7BzyezGLQW33HuSDVfArkkBOrcFlxRbDSzKpDoCa1S0hwDw75
 MdU8Ko/Cu3vmW0xUZGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040152

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

Before the fix:

 # ./perf list|grep -w PM_PAU_CYC
  hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]

With this fix:

 # ./perf list|grep -w PM_PAU_CYC
  hv_24x7/PM_PAU_CYC,chip=?/                         [Kernel PMU event]

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v3 -> v4:
Updated commit message to show real example
addressing review comment from Namhyung.

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


