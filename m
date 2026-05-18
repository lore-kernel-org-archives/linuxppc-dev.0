Return-Path: <linuxppc-dev+bounces-21029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5557ECD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:09:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJm7M3ctMz3br7;
	Mon, 18 May 2026 15:09:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779080959;
	cv=none; b=JyoH23hPAPN/RYs4se3WyINdf+Pmr0WVqS9U5G9XQadinAW5JZx5MnaGxwayd8T2nXHuL33UP8GF7a5a/Yeb9IorPvYvvVti0oceYo2KwzI8cSHU7qOK4aV8mZrEPLByexG0T33nUf/pslv+Eo5ZgW9MK4maFSZsYkOSFRwV6691hNNX7OwzvGWY0zkZfpYBN+tzpYip0oGV/0lAN3StGPLVz7TdcWHY/p0TKuF+Cj7ALzbJhwpZUd/fbBtm9cPBcitoZU0RYQnlmZr3T1K/s8lqMc0BBWAE6jHnxJAiwEcuYAu1Cjm3yOJT9qhOfd1gw5Pf9fpWGt3cykS21Q62MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779080959; c=relaxed/relaxed;
	bh=tQawdGIr4hToOKuvyMmUEgu+J9Q/5uLFQGlnXpup290=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li+RJ73Wmbe4QM9SYKT+IxMuBhJny+7xPYuYQnmwT1MN+QDk1MkvqMhxW51qzN8Gi2Rx8BtDfLj/3WKyjQLjggl+ZVKxEuee2aR3japPix0Uz3TKgrxvaZqPShXsiC6asKLM8ylysMofFirRHU2jhj+j1CCXmhkhmXDhCKWQ5d1t8TtXWcHP25cu+Qk7JJx1O4N3elNchll8H4Uss8r9wkcDECADCDN7mfvGkrnOr5KyA0Pkn2c1MMD+5Z0dEQFrnhLaEr/UkGU4yLGTOZp7larZFaMKpBnJu1sC/Xi/5YA9r1aXJ6SvwqP+CyT4S8uAvyTyi6hNbrdSfPQI7YmIzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DtrYhqB9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DtrYhqB9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJm7L67Rfz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:09:18 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HLIFpU2070048;
	Mon, 18 May 2026 05:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tQawdGIr4hToOKuvy
	MmUEgu+J9Q/5uLFQGlnXpup290=; b=DtrYhqB9WxOeD9z1n00eNhdnZTc3afarM
	JjmQuBQwmFiKRq1UqwG0yuCKCutTToeyLB0CkGOL8PSVRhdqaLtUmZ+Dv1fbqSSl
	vqtw6LDammgu6kE1jFqpLHKiTSn+QEU3XDmq3VRfUnpJso9njLBlUlqZwPUpIc9I
	9cBpKp/dbe8o60FDnnn2j1bP0Wgm1NGJzsl3q5DtSmSKH8+sRWNLl+eWuhgCVWOo
	Pnqp+M/brXkrAPOsJfvhJEGerBidxQU3pTa9cGXx/hwgeybtGxp7OIbOMrDlCAxV
	JrGdtM9UL2iB2ZSJNZqQ9VzVSsZ1I337dOstxzRpOVnEt9kt2J3YA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h885un0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5944b024584;
	Mon, 18 May 2026 05:09:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxv02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I599e634013472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:09:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F662004B;
	Mon, 18 May 2026 05:09:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69ADE20049;
	Mon, 18 May 2026 05:09:06 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.124.214.53])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:09:06 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 2/3] powerpc/powernv: fix preempt count leak in pnv_kexec_wait_secondaries_down
Date: Mon, 18 May 2026 10:38:54 +0530
Message-ID: <20260518050855.1147242-3-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CiCmeEF6BZAC0CSoh_sFje-gfEyFPl3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0NiBTYWx0ZWRfXyf8M8/yJRPjb
 KRnjrQibKNjBnRMM22NIZ+YojoOI0Sr56KDmLYOPJYRfpNP18W68N/8fkRXiMGsFFe8+zn/A6uH
 Z20MvQ6CKSpdHiAz7P2p19o3jCx4AX1B6b1o72FyPMdg12K08LrhnlVEw586tgTuRvRtrFbaHgZ
 nUoHT7eitfttxjIJ+VJyp2VKb+Bkme7OBbUtzTXJ08X1x2lPQ/rr6ItC+UF21QPDXMINJ2ak/3h
 qu2h8O7/5EsIyAm+zs2bHl3KJxggbcX7Ov4kWRxoW2ztdOAB5q6cTeODAsn0TRzPUKz0bSdeYKx
 1Cmv15CukIldbIPX5WxiQY98KEiZQzFtLLe+8hWD2psPAKqB11eU2cZ1lOc6e74NXJpCT//vzob
 iymELWiFBQNJhfqbz8pBkB/R8RzgyjOYwgDvarBueRa4dDrJxQVgxfg7b5UDQU3FoLAgwRTR23G
 Z3kZzKPX/OXhPcsklcg==
X-Proofpoint-GUID: VdaoM-S7813Xeq8EZmREkRSikfHjV2aL
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0a9ef9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=AoYj4kKG8rnORiwU5IoA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180046

pnv_kexec_wait_secondaries_down() calls get_cpu() to obtain the current
CPU id but never calls the matching put_cpu(), leaking one
preempt_disable() nesting level on every invocation.

In practice the imbalance does not trigger a visible splat because the
kexec teardown path is a one-way trip: IRQs are already disabled, no
schedule() occurs after the leak, and default_machine_kexec() overwrites
preempt_count with HARDIRQ_OFFSET before jumping into kexec_sequence()
which never returns. However the bookkeeping is still wrong.

In the kexec teardown path IRQs are already disabled and the CPU is
pinned, so get_cpu()'s preempt_disable() side-effect is unnecessary.
Replace get_cpu() with raw_smp_processor_id() which returns the CPU id
without touching preempt_count.

Fixes: 298b34d7d578 ("powerpc/powernv: Fix kexec races going back to OPAL")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 4dbb47ddbdcc4..177da0defcb36 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -396,7 +396,7 @@ static void pnv_kexec_wait_secondaries_down(void)
 {
 	int my_cpu, i, notified = -1;
 
-	my_cpu = get_cpu();
+	my_cpu = raw_smp_processor_id();
 
 	for_each_online_cpu(i) {
 		uint8_t status;
-- 
2.54.0


