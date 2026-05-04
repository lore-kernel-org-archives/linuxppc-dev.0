Return-Path: <linuxppc-dev+bounces-20423-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05899CD3430
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 15:13:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8QCJ5FN4z30FR;
	Tue, 05 May 2026 01:13:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777907628;
	cv=none; b=B8sxDy6tP5YdtHLg1aZ4vNKpE/SCrXfnznh3iT0en9q0BCWYBlpE/azP1fKAi3l7npBCXETUDKu7eLshUik87iohCs549bJpv5L74rJNaD7OMSTH+F9lP5w8IfwJfCty0TpYDOUZCxf5nQ4eugL2j97Q1KUak4mWFkTlA8mKoUOawrHRKAVxrWn12aU21kb+Vjt9zsT9KoK5T96430QwM55mqtuA5s16UL4EI6+cDXJquIPt2xK8hsp+lw91B5S/l5T0F/mu8718zvrgUhMIbw068KmTqxynIQPcFWn1CUVG9cPD8m3g3Ko6vgmTb7wZovA3XQAY/z+70qhMAEwApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777907628; c=relaxed/relaxed;
	bh=ydgkvSL5z+MYv6RNhr7y2GSysjQVXtkJqmjVLG7BJOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SmWORn/lTSfR8XoflbzxdCIm4INyVALF6Zfo3vd6TqhR+SmgEg46eYd53xlu66GXcEUT6S4Vw5PnawEENN2PRgUnJz+o3MsXXawRgnpLjSisPMiBc4hTvj3TaQVcTi9FvcrXxiDJ3MqSuuw+OlbMQk/JahvjNSmrYUniHfXDWlIr400GjndIz17MVcqlOScUBsQd7NZNogUm9HK72p9I6ejM+HbSC3z3xXtbtjua8BeurFaNn9s7q3JSEW/n6ZGZL9RmWMNnkqFNa6gZGrImWZRMpV0SP0kQmdYDqdJAZ9dE59CNvAAsM3PIWR5qO0xGDroD+5N7vk1fzWY8+nh+Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NkGx5jZj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NkGx5jZj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8QCH6Rhvz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 01:13:47 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644EgnAZ3104130;
	Mon, 4 May 2026 15:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ydgkvSL5z+MYv6RNh
	r7y2GSysjQVXtkJqmjVLG7BJOo=; b=NkGx5jZjjSPyUl4iKVIKNPtzbiuPEb7Mn
	+ueUr8XmmnxBQ+1hU4yD4ji+fW53a/G4dfld0ZvdNIFmlf0BU0zOXL3e3JP5ijGv
	t4zsD7ZItzzq17VC76/u+vK4Wvc7JB+Al+r74aM1syABH8VcFWl2QqgQYE6fVV/Y
	AD0u3XNSALSgC7abnscKw8c6DpfMcLgnglXsyic6R8Jmgnya6LpMW2LRG0EthWIw
	szkLePAb2FgKgpxWTehFP9gI+wTBAJlmYOPxxJ5AT3j6CfzRBiHbkldOxB3aBzDx
	qFOw/0AtLnNme7WjvGxkbcPISZADkYTXgRMzrz2n7/X7+hHHLHisw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w67f2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:13:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsTXA008937;
	Mon, 4 May 2026 15:13:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvws9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:13:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FDaLp61866326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:13:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C4BF2004E;
	Mon,  4 May 2026 15:13:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F94220049;
	Mon,  4 May 2026 15:13:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.208.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:13:31 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V5 2/2] tools/perf: Add kernel-doc comment to auxtrace_record__init() function
Date: Mon,  4 May 2026 20:43:21 +0530
Message-Id: <20260504151321.12346-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260504151321.12346-1-atrajeev@linux.ibm.com>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f8b7a5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rIN8eMsy0-pcsuMf_RkA:9
X-Proofpoint-ORIG-GUID: SSjChCb329VBE86ySS1fYvSvtBT_FHn5
X-Proofpoint-GUID: b4nYdZbbxEfrWQBz3b_8rVLRxXHhVSkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MiBTYWx0ZWRfX5GR+DpXxmVJJ
 lVNMg7ipRCOLUVGyiEuu+bVCXFVZ06LGVnWs+SbJGP/cjqQxIYrNlW+n0JcvSHRN/4+MjiM2HAg
 E62VJcGL0OE0rScBTCj8c4ko4Th0dp8gSA63sY0TdIakS77dynS4bAlYFVTHZulCVuWcXCGUecs
 7sEoaUOTlNnDbQnitgQyY+uAreTr6ZCzVNBXksaQhsL3Jel+dGICyQ1oN6FCxjYX+2NRtCgQw8a
 UQe/XUv+SJ1DpXMfCcQ/e4IcLDihJ8xQ7ew1MG9wKLXZiIFDqzU3xL7B+r9i0Q8CE4yt8o7vv56
 6AIUFlU5HWyi+1R7+QFmoMQWTJp4DPAroojvUdBWesu/+liv+2dfmEHfSeo5v0G+3K/YOdX8DJ9
 s3JPEH60LeoffT74GoF3kcbq0KInBTSlS0Wb0TPhJFohPeKknXwwVHYzvevMnI14U1DXIhcnv4L
 j3P1VUIehnNMKJyNacA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040152

Add documentation comment describing the parameters
and return code for auxtrace_record__init() in util/auxtrace.c

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v4 > v5:
Addressed review comment from Namhyung:
- Used original placement for __maybe_unused as
"struct evlist *evlist __maybe_unused"
- Added return code expectation on success case

v3 -> v4:
Addressed review comment from Sashiko:
Update return value expectation for fail as
non zero return err code.

v2 -> v3:
Addressed review comment from Sashiko:
Update return value expectation for success and fail
correctly.

 tools/perf/util/auxtrace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a224687ffbc1..a9f007d47c0b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -896,6 +896,21 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
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
+ * Return:
+ * a) A pointer to the struct auxtrace_record with @err = 0 on success.
+ * b) NULL with @err = 0 if no AUX area tracing event is found/supported
+ *    (not considered an error).
+ * c) NULL with non-zero @err on actual auxtrace_record__init failure.
+ */
 struct auxtrace_record *__weak
 auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
 {
-- 
2.47.3


