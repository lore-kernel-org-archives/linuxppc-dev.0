Return-Path: <linuxppc-dev+bounces-21870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5DDCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:06:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV61152W9z2yth;
	Tue, 02 Jun 2026 20:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780382958;
	cv=none; b=ckTVWfblozr4Y8pbMV38Fotikjw90HC2BmOwh9PDKgNbxW2/Ti0onz3gQGjxXcjlt3zvM2XSuoYSteNcXmaDCib/NhcFXVLaYE9imv6wd6RKXj9RGp97vYbRoYTQgDysa0ZtRQMCXQDyIs8RaqDvTIBJWOMJrpBuAwsYdfn10995qhT8vmNbP8XRHRQKbxgL7SqHO5uYONzslYf3utTG8ZaZOvqYy01dMWIlCfulx29DqWWLgEjYX76I3pQGX4VnTSgbZ+81NVBkmoEj3Mjncm2YFGXnRhOfL2hw3GG9gitk2afJ+hO2KnHu/GnjKpXTJFsNKUqDxNPU+W73Tggg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780382958; c=relaxed/relaxed;
	bh=UodIreQE8qHt8550xsUq5VuxDg0b0zqTfU62eY5ynhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyemUhb++NgUdx1llE2TxUsmm6SyYOjmZsbUO59aAoD6fX1WG+VRV/QN9VgUKlsZhSyVX3WzPgNPZds9FhGQzfoI3QuZOYtwYWMmwXY57sTFWOHQoc509fXZ5x7KlhQUNxRPWnta6xOeSEBSSgTezJ/CCXYn/ZbqEYC2r+++WGws3Z4CGgF7PmYYO9PZfUXt+l6Akk14YeAy9VwQ1G4Duiu76NMTcZ94ZotPA9QjIt/c0C1QpcyzC+9NJ8l1/xcS2kzpScVnbefbVjAgso8oT5Wv8a7mQcMX+cOq2QS/wNpVREJOhjbo6bf0spg1x+GyWv5L423U/LuQ2eKsp9qiPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pTNOTXEj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pTNOTXEj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV1dn3WJRz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 16:49:17 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6521Ul003621258;
	Tue, 2 Jun 2026 06:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UodIreQE8qHt8550x
	sUq5VuxDg0b0zqTfU62eY5ynhw=; b=pTNOTXEjH1KlvqT7kVE4Tnlvp/6O2et9+
	0mB3tYPzOBpSJPLdBHhEDdRuXpXQ2i6BxEgxgTGEc1KCN/5fCaySfsUKY84iWsL9
	pXSetMIbVC9lSrovmC2C3qSOmXBzNT2ZekPjPOthb2XadjJpviGKBLQroxaLj9lY
	Ry74OAl90Zlwkhd3zKULktXSm1ap+PBj1Akshhg9AuLmuzOS3vFlPAOIl8mDPCUd
	S9slAqRBI6k0nbUqMC+Bll1o0TpDY6G4dWURu4zKkpTqKV24+l82bV1OiRJ1TTmc
	32QOFCyeMgxIdnvr54XwD17JR3sK8UR+mRAw9Q4tnE/piPrJ4kobw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd44nam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:49:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6526d8Qu017430;
	Tue, 2 Jun 2026 06:49:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy9nd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:49:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6526n3MC31523528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 06:49:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 416F520043;
	Tue,  2 Jun 2026 06:49:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C555D20040;
	Tue,  2 Jun 2026 06:49:00 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown [9.123.8.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 06:49:00 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests RFC PATCH 5/6] scripts/arch-run.bash: Fix run_panic() success exit status
Date: Tue,  2 Jun 2026 12:18:05 +0530
Message-ID: <20260602064806.3101025-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602064806.3101025-1-rathc@linux.ibm.com>
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OSBTYWx0ZWRfX8Po3dtJ3X560
 erZSE9xG1GmJqBastzP+dmz6DXPLko8cj8m5R6C5AKSg5e7uGnnJKYDkRPBxXtkU0QszglKjzLz
 U6uCw9J8/aS2EMORcI242ggVVDO7yXJJVkglXFD/hIKa9Hr8FUbbXXKtuBV+33lKhKegz6CqO7i
 JJpgw/UM+t4ivwaE9ob7pOwAZrVJnq6c/HMYvOxjJv8QN6raZlwyOa1uFf3HXtKtFZplvWPwQ4w
 MQ+3zK6J1K131PVzIqTErikKzvAgHj51lounGPJqlfK3HLTYGmjMxF4zqVbOrAgfmYka0iirkx0
 2Kmp7T0+dBhF73DLr3cCB5b7myYzuinFW0riUbLIYjdHwaTQ+RTprvcabbvF5qz7LmTvY7pnhS9
 8Rqf9OUj5sP8HVOZG/rmoVYoL2T+sYJVKr8vNP35/RLfizBYdef67ScUb0R2S75+n/U4aKZwAQK
 A3pPv4/jJM+nBFR62JQ==
X-Proofpoint-GUID: uKHPQekUyUHiCU4x0uyerSXI7ymcwzNb
X-Proofpoint-ORIG-GUID: KzcXKhbARev-gLOtSJNYyxFdPuLYQUCe
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1e7ce3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=9Q_qCks6ew66Kax-6aoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020059

From: Nicholas Piggin <npiggin@gmail.com>

run_qemu_status() looks for "EXIT: STATUS=%d" if the harness command
returned 1, to determine the final status of the test. In the case of
panic tests, QEMU should terminate before successful exit status is
known, so the run_panic() command must produce the "EXIT: STATUS" line.

With this change, running a panic test returns 0 on success (panic),
and the run_test.sh unit test correctly displays it as PASS rather than
FAIL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 scripts/arch-run.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 01cc1ff2..41a903e4 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -313,6 +313,7 @@ run_panic ()
 	else
 		# some QEMU versions report multiple panic events
 		echo "PASS: guest panicked"
+		echo "EXIT: STATUS=1"
 		ret=1
 	fi
 
-- 
2.53.0


