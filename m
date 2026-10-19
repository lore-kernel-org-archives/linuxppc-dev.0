Return-Path: <linuxppc-dev+bounces-29700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C5DCCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:19:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Wk55ZDHz2yql;
	Mon, 19 Oct 2026 21:19:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405165;
	cv=none; b=Z8pL3z3EhBssg+7T6dWlRT5EBtK4N3+twwAiCfFyesGlnquPJPAWkZO/JT4kkvfoEA85GjOlGexZPgcybJOipYtv5dkRWT94WKJ7M/gFNoazwgXQDiQF8rK5+hl/6YuNjY3xU7j1oPMLGoHbYLY95tplY+cti0ZCmrb7C6Hxbh5ccGQTtcxKxkzjJuGa09dr5oX9ftWFm/DPaSaXq2CCX10VOwrZhJzF47vn9Q7Lv7rB75OS7m1/sBcXR187/0DnKDwUMrYqtuZtcAV4xE/QXw4VJPUTlE9Mleu2k691Zl+Ti6s5RbpOGHNLnIcj/6gvbU0AKsSUFbOmlfMb+V30oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405165; c=relaxed/relaxed;
	bh=8M/8L9Fspxh82Qlo49v8hfqRQF4M7+HVyHXIr/e50gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx3fIxY+7FTst+x7qBf1y87KoEnlCMtS4vIqMcbk4cYkOhUcka1iC9/WNE0XqPU47EZCCCG8ilrNfB5LfgksqIjmEFS1Nbz96O+YQSwalI5qvufwx3t6N7BtzU03/tQDW9+gffJmwQ7UbRdo5zkv/1GkLu2ARuMlB0zIpP37NgyQ+IxV8obTGhtjBPZvNDbmkbn1FMo/BgEMsflG34hJRwfPZfOhsauNakWX65NcQ2x+qILWv1gBFSg8Z2dzAe3wmquggPJ8L/g0eaBX/Lyckz68DRUeNBMG4TCexUyHnf0COei1spv7/Tqo67eRUVAGKf4OKJbF7kd0/mrisBYvdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fjhHp4vp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fjhHp4vp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Wk50JPyz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:19:24 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iFmh2173756;
	Mon, 19 Oct 2026 10:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8M/8L9Fspxh82Qlo4
	9v8hfqRQF4M7+HVyHXIr/e50gU=; b=fjhHp4vpdqKHEaqrVD7nC9AJIQTncDx9I
	n4CSsq4LYnLy3wgEMAiNBH58XkH0QA7JsheIW6m4FtU+5XGUomRiyZWKW1oipWXQ
	TGBW+2IgJfUxmTPOaIW9oMPXkwOg+wRRawK1UEErZMTSIf5XBM1Btyf7yvMMbZmj
	YB6163BvaX1cCRSxkJ3K6XMAlcWbggkQyx74y1tgkhmQA9gWBpl2qbFujSWd/TTT
	HDbZ3YzsMMt+w1aFIh5BoNELZcCNQKv6S1QYA+hu+T1wP/bFfEQ9Ta6afJ4E0ARz
	0speJS63YZZi+qdIgBoxZFniKafuN6xfO8DcxHHpwSkiRJKuyQSdg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepswhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Z1RS2651719;
	Mon, 19 Oct 2026 10:19:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgw1wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:19:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAJ9lO49348942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:19:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873482005A;
	Mon, 19 Oct 2026 10:19:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC1B420065;
	Mon, 19 Oct 2026 10:19:05 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:19:05 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v5 5/5] powerpc/powernv/eeh: Map generic EEH error types to OPAL
Date: Mon, 19 Oct 2026 15:48:13 +0530
Message-ID: <20261019101813.45085-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfXyIm/YYwk53Pw
 5MCnSpdirhXk2L2YXQMwKblizFj9vlcuRGx8/16T7ERNyB7bfNawh163wpUNZHQLrtsiZKllDbs
 yFkAVdHoV/hjbzSddnqgczUPWMwugqM=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad5eea2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=hwQQl9zN6LhoDLuWKpsA:9
X-Proofpoint-ORIG-GUID: mJmEn-HrFNpEnuryDSTyYqgv6bT2RN7u
X-Proofpoint-GUID: dgluXBycCRAVsJ7LQ2WdHFQYNRdZW_MH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfXy6+B/7SExiD5
 J5cPzqpMZRBNEEL+8RxToRYVwlTpTahmmmJZLTRlIR1uwe1CJi4pR519H79vGSYxh49bzUBgTAj
 dgkwGuP2BbWXMBW/2M5XT/tLIUBCMk1OZHhZOPR6KElU/dF02G1OSpJL/3UWtorfN1ojqRE4Xpo
 A3ql2QsVxL0Mnfi/rCWChJc7cZwmApKMXml5xBGEsh54DFcSh3Q4SLsrM8bCPqNt+HABqjo22DV
 8d1qPaUUtQmb1gA5BtAAzYUhxcYrnC1OQM54ZdIo0Pxhsi3fcPeALAcguVNfv+JyvT2ehnjerLH
 KQD14TEuAton0xtSSu14ixTmUzHY+j9HMVkRU4Nllt79aLUDj9zc/OSyo5dXKLMQxkqM+ag1gs6
 ZznuKcagobtBg31MdoR9ggVzBP2G+ZReseRXscCfg2xok18T0MLHclF0rF8OnBsrK0WmuK+GkGu
 Er6wUl3dq2EftzIxYHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190040

eeh_pe_inject_err() is called with generic EEH error types defined in
the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64).  The
PowerNV backend previously compared these generic values directly against
OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).

This is fragile: it relies on the generic EEH ABI values being
numerically identical to OPAL-specific values, and would silently
misbehave if they ever diverged.

Add an explicit mapping in pnv_eeh_err_inject() that translates:
  EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
  EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64

Return -ERANGE for unsupported error types, preserving the behavior
of the original code.  Decouples the VFIO/EEH interface from OPAL
implementation details.

No change to existing userspace ABI or PowerNV behavior.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..01dae760cecb 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
+	int opal_err_type;
 	s64 rc;
 
-	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
-	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
-		pr_warn("%s: Invalid error type %d\n",
-			__func__, type);
+	/*
+	 * eeh_pe_inject_err() receives generic EEH error types from the
+	 * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
+	 * these generic values being numerically identical to OPAL firmware
+	 * values.  Translate to OPAL-specific types before calling firmware.
+	 */
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
+		break;
+	case EEH_ERR_TYPE_64:
+		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
+		break;
+	default:
+		pr_warn("%s: Invalid error type %d\n", __func__, type);
 		return -ERANGE;
 	}
 
@@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 
 	/* Do error injection */
 	rc = opal_pci_err_inject(phb->opal_id, pe->addr,
-				 type, func, addr, mask);
+				 opal_err_type, func, addr, mask);
 	if (rc != OPAL_SUCCESS) {
 		pr_warn("%s: Failure %lld injecting error "
 			"%d-%d to PHB#%x-PE#%x\n",
-- 
2.54.0


