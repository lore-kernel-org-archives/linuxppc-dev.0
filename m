Return-Path: <linuxppc-dev+bounces-21951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59F5CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:28:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVd6x6wpHz2yNn;
	Wed, 03 Jun 2026 16:28:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468089;
	cv=none; b=F1BDWZFvwag0nLiZG0rUCOLJBiJcCRUnuH49Zou8LLsxTyaneUCiLBUf/J+NY1FCWcpcaspvGD/4KR4yNRMkIhWaZro+JYtw1AJCuGMIYdZNaiX6Bqpjx+Q5amqKKAwUpEUHC3zzFo8cT4oByqfwlv/frccvEcOR8iPQC08yggLHFTfstONPS7lPPYAwNhxrbZsl9LJJkN91oLxD3Yx0eHYqey92in+Qo8OqkUEeRpRGXWvX7lriawgc7FD9iEqac+coewTisA92iMbtt8lojP6EQDD5v/6aukNjd7ZGOkNZbIuBbCHdDDiGY4/N7CHPF2nVaScuG3IiPgjID7dIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468089; c=relaxed/relaxed;
	bh=ePLCEtt8hffEw8/PqAMEo4hqUVnY6UPKSRDXJzbbNxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwoKQpWaqr/ZHELpXyTQWVBcZySLMhZrkq8qwW3W2XcyrmMWcaIn7ORfcrPWoGL/3tcIk/EgBhslFbYizBYWjtZeTyobLq+czKvuVLoAj2WHOaFrfwpTj7PT3enFLB3gqvjBClQGCV0CfDubcVVvDjjWopKz9SylbwNBkLN6+sw6VxF53M5xCUn/cV9VtKg+CHsQUZqtoNWyEl/t5JbxXmWE0HYqoMkQur7/x1Rw/4qdVY5FsWBO+sjKgoQDdAyhOL8BTxvyjEXunWGnxCKjl1ySR9gqZ+uSEQTyB5PWI2f+ycVOcgcX68fonEdSRnmV/6SOBOC7ubo3bqb3sKN3JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l4KG3PwA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l4KG3PwA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVd6x1qrwz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:28:08 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6532nbTL1611171;
	Wed, 3 Jun 2026 06:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ePLCEtt8hffEw8/Pq
	AMEo4hqUVnY6UPKSRDXJzbbNxY=; b=l4KG3PwAA9yZ0UBRQCZlxyEDLpjYxQJ+w
	5Vno5RcmLM/E+LPXCjc1s4P+gETybvY2WjvhXyiCfuBR8agcwNoyqRqrd0ngstfW
	b/Bwc1Iu3FuQt+srxHW5zTVRiziGwIPKPdpy+BM7pmugcuuktUAwmNTJJLYElTx9
	IOaBqT/TtyUELPT3/9hH3bXpvUmK6xvnIroVos3Ts203j5y8BL3y3Skd0Nzn4tvy
	hB+nh06kMg3/hkVgEarUB/9WYRYUFpHSGB4q+nw4D06bYYlAmLqIBJlQihyzMn+d
	57sA6Ip8jtuNZN8VoOImMRXvIMofiFltE9foG22Y6I7hJfAwhYT1w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq9f9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:28:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536OII7006341;
	Wed, 3 Jun 2026 06:28:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegpm8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:28:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536S1DP48234792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:28:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4388420043;
	Wed,  3 Jun 2026 06:28:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBF7220040;
	Wed,  3 Jun 2026 06:27:57 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.24.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:27:57 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 2/3] powerpc/powernv: fix preempt count leak in pnv_kexec_wait_secondaries_down
Date: Wed,  3 Jun 2026 11:57:42 +0530
Message-ID: <20260603062743.1152253-3-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
References: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uzqumJyjx6DjWfJ_Tpia6bzWjfJ3DUlu
X-Proofpoint-GUID: oB9ux16OQR66vHl4aa3r_uP1VSwNlxfM
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1fc976 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=AoYj4kKG8rnORiwU5IoA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX2mQdY2N2hD8j
 Wj7gYDCsuDGXNqNkmvkLih6OOw60WzsqC4TfHasNs7MCTXRCx4psSxERDQFcJLogSqfqoZPY/7s
 L7FIBzmsqFcUqijmx3hPEPUUAqTmxyvTLZaGJ+GgtYr0ZYNaU6F0eVS04GdHxP/YoPb2uUnSvdz
 wRUPdvN50NSJTxDsVZwIz9NRkMLRiW0EET3JJMsTX9bEem176Dwy+cxNnsaC2amF8b9SoXyLti5
 F6s79znHqImWkdnVj5Oe72PTYdxZZtR0iZ/RQXlAbsUMEMMAiO9NV+kBQubqxIDPUYq2NIfco7m
 TqdN5b9E9BH1wOLzqw/GS+hvJvIiPP1x8I1SrrBl2THPGHmawsV1k5ycp8CWlUB9zf/mjlk/WsD
 nMRPXqoNV5x28z2X79UfWHKLt7+d+JXpcPbz8LZ3DhwQTnZztkXEaJU0wpzAY1pKTYFT62z5O86
 eUonrD+tOqxQFDZwniA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

pnv_kexec_wait_secondaries_down() calls get_cpu() to obtain the current
CPU id but never calls the matching put_cpu(), leaking one
preempt_disable() nesting level on every invocation.

In practice the imbalance does not trigger a visible splat because the
kexec teardown path is a one-way trip: IRQs are already disabled, no
schedule() occurs after the leak, and default_machine_kexec() overwrites
preempt_count with HARDIRQ_OFFSET before jumping into kexec_sequence()
which never returns. However the bookkeeping is still wrong.

The function only needs the current CPU id, and this path runs with the
CPU pinned and IRQs disabled, so the preempt_disable() side-effect of
get_cpu() is unnecessary. Replace it with smp_processor_id(), which
returns the CPU id without touching preempt_count.

Fixes: 298b34d7d578 ("powerpc/powernv: Fix kexec races going back to OPAL")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 4dbb47ddbdcc..73193264cbe7 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -396,7 +396,7 @@ static void pnv_kexec_wait_secondaries_down(void)
 {
 	int my_cpu, i, notified = -1;
 
-	my_cpu = get_cpu();
+	my_cpu = smp_processor_id();
 
 	for_each_online_cpu(i) {
 		uint8_t status;
-- 
2.54.0


