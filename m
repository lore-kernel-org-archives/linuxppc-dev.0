Return-Path: <linuxppc-dev+bounces-19143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC29D35171
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 11:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm2cb3jWrz2xgv;
	Wed, 01 Apr 2026 22:21:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775042495;
	cv=none; b=NirgAO6IbT4ez916z8iUqRNT31S20ahiygSKgU/2N0ogBS4eFrC6UnyxwDJcZnVnvyACmPj1jL96pG9xpX/FZ8uN42r3qqLvXM2WP5DiACZzBJn81wSTpyYPVWAQ2fIFH9SmVZbfwu2coJVx8st1V/jzxARsBMFwSw98Uq6E9cm6+ej1WaXEkrNtKz2XUdIS5smejSt9LkVAqRpwqr5AKqYaiRG001v6YQdh9XY08lhm0ceAiusY1hZDhH45uE43Xehtaf8zH2FBrd6CLP4Urpu8SuHSW41iSqP6lm6h7e7JUNTTmYQ1264Urvc9WJds952gerECfIa/OREqS+flLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775042495; c=relaxed/relaxed;
	bh=1gWu5swfhBndrAfvrNOR5ecjoMQCuxPVWMqjRl0uPqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJELXdx+BmhABSpsLc7Wv4AoOl7VljHiVsWFxKahQUiZcBudurkVveSopAbQg1U9LD0Zh4l+6Jv20Ga50JCEUU3RI/OF0a576PdqrqP7jnEogWdWSIi9NRsSX5BsrAyFhr+2uzEpS49ycFXHBgSgl2TAkQzBGHME3buRq0MOYO+OwIn5cD8TGYsPxpvhF41/rB96UJK9lF2qF8iTYwWviNT5kIKmQ/Wg4/eCpuQpmk/FyddNPQL/ToHgn02e9liCWFRM5T1wFSikjnLv1JRlcifSMQtJ4yxsKaCR2F4AIiDyQwAxVeI6aVKzAuT2NunA+RsWc5s8vu+Okz/v01KMqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e4LCjVLA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e4LCjVLA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm2cZ2RzJz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 22:21:33 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319ZMpc4177299;
	Wed, 1 Apr 2026 11:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1gWu5swfhBndrAfvrNOR5ecjoMQCuxPVWMqjRl0uP
	qQ=; b=e4LCjVLAu7v1KbNYBG0uw7jD/rqQNGhAbIkbosmXu4ZT1SQBXrOOTqsZ/
	HtXZ//ap9DCG7dFHNEQWPP/pWnCzSAOZBEzda/5rDKiRKMWdOTFfOdj0cOcrpFka
	NAkdRz6KrHBSHDX7qp20YIRBndfW26sXn/UDNRKi9/DSxK7167UZafQpRwn9Qs4R
	ChQzcNpJ/zi55ma9Ge3gDehoji/23ZGtUX8Aewo4Fmj/mCIeN1YTMY7TjF7G0TkC
	ycZNcw2FTURyY5rMQVLx+QFjIST1BECeDGaC1BrA7cbBYgSNPFkfd1KshysIJGDl
	1RzcF5qjZVpGkhkT4p1sk4F/Q55dg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms720p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631AVJY7021722;
	Wed, 1 Apr 2026 11:21:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasnf4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLEja28770698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3950D20043;
	Wed,  1 Apr 2026 11:21:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62A1420040;
	Wed,  1 Apr 2026 11:21:12 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:12 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 0/4] powerpc/bpf: Add support for instruction array and indirect jump
Date: Wed,  1 Apr 2026 11:21:29 -0400
Message-ID: <20260401152133.42544-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ccffaf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PrvU3QX_WBFfOzZGQxIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfX/ntHbDZBQBhA
 i5ej0Jt/i49kLDa4gK4o61hNUOn5w0Zc+iXv7PcMaSh+U/Xtu2Nkc1EQcn/sFsFP75g+3u+yIx2
 uokNVwO63p8bCRT4FbqyBAeuuYAxSCFRyck23D1C6erz6q1Bbfc2ys3V+OmspmG4MIiOB9wtub0
 IBuzVpV5B9V1MFUd6NZv3IBD8RocDgt7FRV0nJ4SGOnOgAa3KTPwt9pKHYdujezthdh2eJvI1za
 ximTxgPx58WO03vJSFRXZkzdJG8ZBDtxnvW+1YxUTN6Avh8zD9lCXmCx7HrQc+X1FZ1bYYXC7NB
 hypOj0pIT9hiQYlwRCUxcfiOq3PEE3sbko5ym1MLZWNAu0joIQG6YVHELanSmuOJq7k+itqSLzR
 B9INGKGDHt9HiVNcVCsbb4nWGcikXxJTAm5Dp5w2FLTwLfx5K+tuC+SRhOgQkHSJ5tUoe/AXhyE
 chf+tV376sE033LT0kQ==
X-Proofpoint-GUID: IcPYZ5CPA12J2Lr2MlzngmgiRMKFO4P5
X-Proofpoint-ORIG-GUID: IcPYZ5CPA12J2Lr2MlzngmgiRMKFO4P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

From: Abhishek Dubey <adubey@linux.ibm.com>

The first 2 patch enable support for instruction array. Now, the
instruction offset map maintain the mapping:
original inst -> xlated inst -> jited inst

The last two patch enable support for indirect jump. Any eligile
register can store jump target address for control flow to jump.

The later features will be enabled on ppc32 in a separate series.

The patch series is rebased over:
https://lore.kernel.org/bpf/20260401141043.41513-1-adubey@linux.ibm.com

All selftest related to instruction array and indirect jump
are passing on ppc64.

# ./test_progs-cpuv4 -n 20
#20/1    bpf_gotox/one-switch:OK
#20/2    bpf_gotox/one-switch-non-zero-sec-offset:OK
#20/3    bpf_gotox/two-switches:OK
#20/4    bpf_gotox/big-jump-table:OK
#20/5    bpf_gotox/static-global:OK
#20/6    bpf_gotox/nonstatic-global:OK
#20/7    bpf_gotox/other-sec:OK
#20/8    bpf_gotox/static-global-other-sec:OK
#20/9    bpf_gotox/nonstatic-global-other-sec:OK
#20/10   bpf_gotox/one-jump-two-maps:OK
#20/11   bpf_gotox/one-map-two-jumps:OK
#20/12   bpf_gotox/check-ldimm64-off:OK
#20/13   bpf_gotox/check-ldimm64-off-gotox:OK
#20      bpf_gotox:OK
Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs-cpuv4 -n 21
#21/1    bpf_insn_array/one2one:OK
#21/2    bpf_insn_array/simple:OK
#21/3    bpf_insn_array/deletions:OK
#21/4    bpf_insn_array/deletions-with-functions:OK
#21/5    bpf_insn_array/blindness:OK
#21/6    bpf_insn_array/incorrect-index:OK
#21/7    bpf_insn_array/load-unfrozen-map:OK
#21/8    bpf_insn_array/no-map-reuse:OK
#21/9    bpf_insn_array/bpf-side-ops:OK
#21      bpf_insn_array:OK
Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

v2->v3:
  Address minor comments
  Collecting Tested-by and Acked-by tags
v1->v2:
  Handle image offset for ABIv1

[v2]: https://lore.kernel.org/bpf/20260227014315.39980-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260225010950.20218-1-adubey@linux.ibm.com

Abhishek Dubey (4):
  powerpc/bpf: Add support for instruction array
  selftest/bpf: Enable instruction array test for powerpc
  powerpc64/bpf: Add support for indirect jump
  selftest/bpf: Enable gotox tests for powerpc64

 arch/powerpc/net/bpf_jit_comp.c                         | 7 +++++++
 arch/powerpc/net/bpf_jit_comp64.c                       | 8 ++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c      | 4 ++--
 4 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.52.0


