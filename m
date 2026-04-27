Return-Path: <linuxppc-dev+bounces-20143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9331AFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 04:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3rfD3KmQz2yqt;
	Mon, 27 Apr 2026 14:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777265268;
	cv=none; b=PjRe1z8Hfh7h5MvsONJXVFJxOjPdvN/SWeddAf7H+B8WTOS2ZhhnBdZATAtAP1PdMiULFrl+mzU0li8xltYZtP2tTcsPdyD5BXHQw1V9BjbgxQPcF747DJKLahlAReydyQgKHZ846+qxsRjtLIbUdVBR8MmB7MGx8rgEKTB6nhjCXdNHB0vTpQ3cIBpagx1FyHg4qWdjOILceI8Rn/EASTA77rbwUqNwx74sEKSAHPnyr1TYDzGmpIJSU59m2XmYEEJCbt/l3vpkZjZn9RYAltjoqracr7RVeCZc0B4qrHE+kAmgr965qLig0Hnigrriehkcyc3FqkwThJFL1UhzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777265268; c=relaxed/relaxed;
	bh=AwrkFtRE1229PVlMmfPTQSCJ3kikN1O8+74g//G/nHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eye6Btj13Ws8ASxGKjcFSp19BdjrXQBdrIKPeiqxO5PL84ghN7+NirxSR+/3b/1r6ISHyCKpv6RgUW/uLw4B+ebZ/2U+TpYnYdsOYC3ImjQVnweEJhOdcF3we5c1KENiOy9HrFgTGKWIlJdgZ9ecg9844kklHBS17E7YAjGmaW87Bfe2AmUtHPcVNtepmIsaOSwOxcV8MJ3rKT1ExOxq6riWxmLtydq5cemUmqQnTJPe8wsCw9R9ooepGpRNzuUufU5D6oS2jqO8XPytsyjQ/lcFDCOW3y/xK+44w/Fz5iQuC6nKTMqTDWuoznxdor+hHAUXk0PnFssMMwhaTqwygQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E+uHM9ib; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E+uHM9ib;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3rfC5fvMz2yvC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:47:47 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QAFB1h1868640;
	Mon, 27 Apr 2026 04:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AwrkFtRE1229PVlMm
	fPTQSCJ3kikN1O8+74g//G/nHk=; b=E+uHM9ibWbEnZTcpkFM3fa6jxKzEnGgae
	tmH2hTp0MscvcgVT//+ONOtnEP1fGOGGxcIc4f+toefRzg5ntPGlIZ19l/fBdhwu
	aa0qVeVvC3fIRLDVVIFwmaR1KHKimYA2SCvyzuI+6M3Km1EUqQgUvICvdBQS+3Eu
	ZFCeCNv+fMl0vaa9wiNFz2SMzT5w7v7AwcKTZ5NO57qrddidLBo6tLhDzIM/VaJe
	tu93NkHGMg+WncEqnz+DVNzMsf+7jhg0xeDPeUjNBZbbttQNhcLb8ci5xm+SCdBx
	zQsAVN+Cv4iNKUBNIgMiaKxB+hZp309dHmAxSHtD/QH+qiVe0Zyjw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1je72e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R4cqqI019179;
	Mon, 27 Apr 2026 04:47:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy3euc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R4lcsA15466770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 04:47:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 896C52004B;
	Mon, 27 Apr 2026 04:47:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDB9120040;
	Mon, 27 Apr 2026 04:47:36 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com (unknown [9.123.5.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 04:47:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org
Subject: [PATCH v2 3/4] powerpc/perf: Use cpumask_intersects api for checking disable path
Date: Mon, 27 Apr 2026 10:17:14 +0530
Message-ID: <20260427044715.559137-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA0OCBTYWx0ZWRfX8yoTcmjqXRD1
 7oHorMT+g/pPcsRyXA0E6EWqHQf0ERzdj2wr8nOyZIiristvc5veGcwq2/2phj1RZHAIMupb3AT
 T9TuU20fCRu4ioPumdB8ZecToA2ZNl3xX6dMckInrK8iR+kztZwInspogxqB35DYCKhZxktcVkL
 Pup+cJkh/IE4ZXpVpVZVM3pzBg2mvM+PRtqJE/iB0vQh2m1iC2rFX7Qhw5Ple5Dq0cG9rHy+j5O
 NEJQoueafAqgJgKX9Y2yFNmzCGNv0JFUIRmR8OE4JEJ7HEa7LcGAOGjlpAJ74ggCtVbhF4cAvKd
 bkOtfLucj0O/9o6OwIeHnzFt/J/c2WF07wQSgUw/ZTiKrvR97nzU0+U5d/DVkM+xfqqNzDBaYsQ
 1xyvnS03zjJU5uK3qcIIvHzzvrU0x2sO8lIr1fT6e5+JOb+D/5aMdSXer8XZDcSEB9gVpyL5NPc
 MBmbO9wRCKt3+xljODg==
X-Proofpoint-GUID: c-4pnE-KqL5cD9Mfnncxa5T1iT8Tsbtd
X-Proofpoint-ORIG-GUID: oe5is6RcB1_lAwEYSIuPMTvT2NfoBLQ2
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69eeea6f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=sK8o6yvm1_ZMHGIy4kUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270048

First online CPU in the node disables the nest counters by
making an OPAL call. Any other CPU in that node, will bail out.

Instead of using a temporary mask to find out if any cpu in the
node is visited or not, it is better to use the cpumask_intersects
api to achieve the same.

Similarly a temporary cpumask is used to check if a core is already part
of core_imc_cpumask. Use the same cpumask_intersects api there.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index c1563b4eaa94..e3822f36c419 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -421,7 +421,6 @@ static int ppc_nest_imc_cpu_offline(unsigned int cpu)
 static int ppc_nest_imc_cpu_online(unsigned int cpu)
 {
 	const struct cpumask *l_cpumask;
-	static struct cpumask tmp_mask;
 	int res;
 
 	/* Get the cpumask of this node */
@@ -431,7 +430,7 @@ static int ppc_nest_imc_cpu_online(unsigned int cpu)
 	 * If this is not the first online CPU on this node, then
 	 * just return.
 	 */
-	if (cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask))
+	if (cpumask_intersects(l_cpumask, &nest_imc_cpumask))
 		return 0;
 
 	/*
@@ -647,14 +646,13 @@ static bool is_core_imc_mem_inited(int cpu)
 static int ppc_core_imc_cpu_online(unsigned int cpu)
 {
 	const struct cpumask *l_cpumask;
-	static struct cpumask tmp_mask;
 	int ret = 0;
 
 	/* Get the cpumask for this core */
 	l_cpumask = cpu_sibling_mask(cpu);
 
 	/* If a cpu for this core is already set, then, don't do anything */
-	if (cpumask_and(&tmp_mask, l_cpumask, &core_imc_cpumask))
+	if (cpumask_intersects(l_cpumask, &core_imc_cpumask))
 		return 0;
 
 	if (!is_core_imc_mem_inited(cpu)) {
-- 
2.47.3


