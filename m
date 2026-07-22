Return-Path: <linuxppc-dev+bounces-24643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA0C44536
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 11:40:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4sks2Hdnz2xLm;
	Wed, 22 Jul 2026 21:40:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784720437;
	cv=none; b=j823A4nn8x0xb6c8L15z98GCcG5qoAICd5ki0/xrqx4wrAKupqBd/0HEZoQpQOINUgBCLZaqxB7QiL2QL14UeFThGF/MeH5SAS69meXGgcrqK89+2t8F3mFVuck53tQ33DMRnSqhukmIAYWxCh7ZmGmnAjUNWdPBoddpGeXhKWQ/6MSXLV5rIJOHMBTZ0JlvJu0OslvlcidTfXVktSwmSt03ClvRxs+2BDzf715RhTuqlhVV7G+gxxtmzRlzga0brrq3XIskS1liMj0kaeLWOV/FciP1QUB7A2sImUGMpmvtonP2INp2yDt23wkgm/QfTvV3YcEZ3CBSCj/vdQmEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784720437; c=relaxed/relaxed;
	bh=w7d7iOIr4JYo5xD1xds79ix5oGBdZQ9fFETxdf9csPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eopk51VOqjnmYGVSJD6y0KqqFQerg2RUanAEMyqp4EBvq7O4H6rxRq66aibr0A/BtbQ+UGW3Zlff47bn0aPfYeUpdyzhmYLDTNUqibSIaTj8PdAiM5F8S5Zk/BEkVUGOeIFWyOqp4/bGx8BPpofrUj94DG2bTIJqzGKozBvweFqFtdlxJ8yo3ruCKSTLdCT4EM7J8IKU9gX3hKB9nZJgKQzgJWcIZmJzsVUBwmRNbWMcH+FxIgS1cYX1C3rmm1jp5JOSaxaF5/Mo+6qiiWOlMBCCF0by/8icHTXc5/fG57sSeaWmrO1kW4UTk6bAZLGqVGtz1ts10K4hbQWDMbhtrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DX4QAEx+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DX4QAEx+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4skr0cm1z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 21:40:35 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9Bt0k3671763;
	Wed, 22 Jul 2026 11:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=w7d7iOIr4JYo5xD1xds79ix5oGBdZQ9fFETxdf9cs
	PQ=; b=DX4QAEx+CWVySPpwTb3BJNV1hTrxK9X0Qhyw4ANeKn64Uqms9XFalM/8D
	8jRf7SGZnOBT3RU3qNvgJKMnNTALLPR5WDWFPy6DmsBWM6YMCVt3SIcTce/+IOqc
	HxE0WPKldUAOyehUnFQ0dJOxSzBtwbZHfNsscBEJjJ0asLov0NGjkJQG+wUbbdCh
	ZHJ18M6Cm9esI0zSoS+YWcN1HX6Xo6AadXY4754mqZSM41bCwasFdhGQ6+s2Fivg
	BWffYBR6ck2YAutMB4WQxwk1EMCZglu9HjPM8sQocF3RY52bR7kHwpLtX6qv8PDv
	c2ecE7fFaDMZO4WExr23PkcdiknFQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah9ds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:40:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MBYdt0001355;
	Wed, 22 Jul 2026 11:40:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gevdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:40:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MBeMrD32506170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 11:40:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CB62004B;
	Wed, 22 Jul 2026 11:40:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A837C20040;
	Wed, 22 Jul 2026 11:40:07 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.17.145])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 11:40:07 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH] perf trace-event: Fix buffer overflow in read_string()
Date: Wed, 22 Jul 2026 17:05:54 +0530
Message-ID: <20260722113552.191143-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-ORIG-GUID: IH3K8sC4xbwUZdRWUfkS5Z0-Jx0su8TV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwOSBTYWx0ZWRfX4gSFAA3ui2d0
 rjpy8C5s+b9ypx7epq7Wmig/LJLlCdc6JPyjE6U70FZWVGAT33+JWJI22H/F7KEVRfBYEd58oMl
 HrFcAbKYi4HNLFDAI7YURk9jnyDC+i1ntDEQ9v5ySHZvdQ7JNghhAbbV2W7IdAn0ZGlwtalRQW4
 au/JQ8YMpMXr+h0ix+dSXVpL+uYD8k0nPL8ZivN33RwNBqntjXTTx2VqSYdvM/whzHnppEszqKE
 oY+Wu+9Peywh/QlI+L3DYaoYxUowCalFtywHrqILB5WqkRxMCsj4ugTTrgFaTWZWKZsUobPi2ul
 C/szwV8Kfa6amjC/tNSV+1j0OxZce38QdXxPL0ZhSiadPkta9vAfqwZlhVPUsOs5fUM8aXxHqLM
 KDkkViN2YHgJT90kISDn5BfKTFbF8W1Ppcw8rsDi+A9gOfuejpUbdZoz8eE41k2XhLu3nQHdUtI
 q5Yfkmh2soDibzAxGSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwOSBTYWx0ZWRfXygLOrSfbec70
 ZcLSlSrRoW21WB1hqnpwRE2RSVW+53drel6vd5W0s6cXbRugDimoXxmZEw2iqQ1nxn8XevIlUXu
 otNv+xW2g5ZYmdGasGvGRxNoYxtKfpM=
X-Proofpoint-GUID: 3KK8R3ZqYVz4hUkQvnfmDDtcy9DTfAnm
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a60ac2b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=dRiuFSZL0wyzTp01T68A:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220109

read_string() writes into buf[BUFSIZ] one byte at a time without
checking 'size' against the buffer bound before each write. A
string longer than BUFSIZ in the input overflows the stack buffer.

Add a bounds check before each write to prevent overflow. On
overflow the function returns NULL, matching its other error paths.

Fixes: 9215545e99d8 ("perf: Convert perf tracing data into a tracing_data event")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index ecbbb93f0185..afd458cf1387 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -127,6 +127,11 @@ static char *read_string(void)
 			}
 		}
 
+		if (size >= (int)sizeof(buf) - 1) {
+			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
+			goto out;
+		}
+
 		buf[size++] = c;
 
 		if (!c)
-- 
2.47.3


