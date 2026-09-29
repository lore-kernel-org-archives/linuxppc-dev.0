Return-Path: <linuxppc-dev+bounces-28493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6A6CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:58:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvJBb07SHz30PJ;
	Tue, 29 Sep 2026 22:58:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790686694;
	cv=none; b=GcJceQ9CtxsIP7gFkfsZZblXUfO5I41RvshsnccdG/GQwjlQti4gO/bCRwjafafg1ua7PIcgITUhXyRYov6ePujK9xahSeEIVrJYWY1hzAIwCheZq8vxAFzLYB2aRWSBwVh6Dph9oJ+bOFJFN+l5GdyBbljyOMocHm7t3OuyHBoofWSKi/tm7lK7qDe9z4Tr92QhiZjIaqf+H3X1lenVzi8F357wPK0g28+gHJwJMmUivKXSOfDrJ2EuGI7+hP0dYvXRBBtG2kVBtMDUd+5F9H7+D0uzOMLoUT8HD9krdrB/LZNW3GwwO0RXbC8GaLI2GUAGNAQLPcOaO/lfiDsLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790686694; c=relaxed/relaxed;
	bh=WfMzLb3xmoX/qM5N4JkCxfOBjTh3ejV7Lqwy5CF+kZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNScm02et6mfpIrDdm+j165gP5WXxnQMNxz1ziIijAkHtiafe6GmusWU17Oto1BwFnxF2pNit8INfGY7zJcCHF4WUQ3KFP5Fs9BKdfrF2k9/tj0kqs2E67f3AbX60u3OTuNvMTqDIWoI/JhLESeQsltT6L9jNQV0qGcFs8PRbmdtVQHmqkKy3jCSxoSsQKQQeddNrpPuD/YCzb5Ozz///IYkTdFd2zk4Aw3eIHgwXxPHsTiF4fZulf9y4ZtSOtQhGqXSTjnwVydNFsDAPvTnwVgzUIuOw5yDi20WwCpgHbiyirEAHln9SA0KXgxEvJRsK3RrXZY5va1dFLv1DBqA7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sFCGAeFL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sFCGAeFL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvJBZ0bBfz2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 22:58:13 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5dil2783702;
	Tue, 29 Sep 2026 11:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WfMzLb
	3xmoX/qM5N4JkCxfOBjTh3ejV7Lqwy5CF+kZ8=; b=sFCGAeFLRpQEvreI3C5jLB
	FqrY2ttx8Ry32vFZ1/ZaM8CQLVXJjYWDfr7QDu3dy46t1LR+JIFqw6VGVWn47lXv
	aa8HqzpKnJx1myDe08IRYPqUOh9NV+ybu9BvN/AUDCp2ffAGsTjrZ+boGz+kbKpT
	7JPbYwMW6+M1d3QyyFhSoqD/SHyNFOqzgKw6MeGfUkNFdaNwICb8ZdtwkdOKSa3w
	ivSumKGLJrxC2uzT/qtQ9FNpcem4p4vTm2AF64mAUf5tx5oIBLD8dIYmO6XqwWSa
	5anTUgXUvKdy3WXip5bZMxyVB+8ByeUjEF3WRNJyaYH612KPMlKw0RMzj2TGo2Nw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe63qj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:31:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAldvk1667746;
	Tue, 29 Sep 2026 11:31:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhhe23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:31:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBV3Iv44564884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:31:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E55922004D;
	Tue, 29 Sep 2026 11:31:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B87220040;
	Tue, 29 Sep 2026 11:31:00 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:59 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Christophe Leroy <chleroy@kernel.org>, Link Mauve <linkmauve@linkmauve.fr>
Cc: techflashYT <officialTechflashYT@gmail.com>, Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
Date: Tue, 29 Sep 2026 17:00:58 +0530
Message-ID: <179066556646.265207.12358872627744720045.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730065007.964703-1-linkmauve@linkmauve.fr>
References: <20260730065007.964703-1-linkmauve@linkmauve.fr>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abba179 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=BrOgvOr2DgzzvcNUf_gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX1J/3wy5pqsho
 oKa33lSa5Ua0c0Idau0qsDeJevlU1Jaj77iXyfshEVtPc73yeAodNk3Zne1d51JOjqLkHRDwqgD
 X4J3fN/F/SSj3A45zkneJACOejRZ+u8=
X-Proofpoint-ORIG-GUID: u5rUQlonc9xSVu3Zs2KuLMYp6V1x0TpV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX+5VRA2cMJhds
 v7dZxA+xQ++tusEnCBEpKDGOIkvTxSMug2JXuEmoLKRJ6cLPR6ti40mT9YHPffpiziRB2FcSInr
 7JNpCnXpbzmGsWkMeZy5JuJl0E9r/lYRAOE2rHpe5WDr29ks+vTeyAdTne6HRkG5KlW8TitRH7E
 eLewXszSGCrs1fMTpX1sSr0d6r56JFYg2JZzIZTzLLD35EahkitqmlOWMtRJ/zIlq5ekn32IjuJ
 nDY7NOVUUlKDrtsc+31ZuCeQdxxacpGB/mueGT7qGV6r5DAJmHpNgCibKcp73+dsu9qAs9k3uFZ
 ONAF56XDQ7jKQB30DCLetokMhhkZpf30XjVPXfcy2pjZ2DbAxQZPZXL53/e01bXPVfH5OVL4W6v
 16C2iqbF1RI297mKucUqWPSqSwtDkUxEt7o1cBMOv8KIAVJREaOJbcoxUN5dIpb1TyNddsVHHWQ
 VB9lRJQa8Powi3NTkDA==
X-Proofpoint-GUID: UA37yFkuzZKRx-JPVidfRlPI5fGM9Zux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Thu, 30 Jul 2026 08:50:04 +0200, Link Mauve wrote:
> Two local variables were only set but never read on 32-bit PowerPC,
> which causes an error during compilation with W=1.
> 
> This series first makes the 64-bit guards consistent by converting all
> uses of __powerpc64__ to use CONFIG_PPC64 instead, and then guard the
> two variables rc and suffix behind CONFIG_PPC64 checks.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/sstep: Consistently use one define to check arch bit width
      https://git.kernel.org/powerpc/c/a3b88f816f1b87c6dbcbb858d153adb82fec2e15
[2/2] powerpc/sstep: Don’t define variables we won’t be using
      https://git.kernel.org/powerpc/c/16736e0587530a2ad074ef716a6a2f1d45f63827

cheers

