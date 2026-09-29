Return-Path: <linuxppc-dev+bounces-28499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D76CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvKt66RMSz30Vv;
	Wed, 30 Sep 2026 00:14:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790691246;
	cv=none; b=MdLLrkPWrV/zR4i5Xtyr0w091tl3QmvoXcQugt2TakHKrgKSGwuwBbGjBbT9i0NtZRFCmmXxAZYoPleFqXtZeMy5ynZkMjIr52Dnk0sq9uzYlUQ51fvXv9Rg99SdCdjqV7cBBKpl+qhuxyYtB8rErrQphhQy0FU0ZjblwPf8hp8R2ifRiZY7cYZkaYmJB8reNSDvqcTbQzE9HZ7qgLayBKpQFCuhQuUCvxBy3MQVDKmkfAQUcgFTCoXLwIXqIGKpdjbeQa9KErFsK6X3c++LMQ2OTkDZrDpV/wnQWpuvocz1g9raWeQe60hSEkVB4DIkdToHxgdA7EljxmpZMs6UgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790691246; c=relaxed/relaxed;
	bh=pGMMFhGtLkbpTo5BkkjAp7rmRhjpzIdbQsitzbW4W9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Te9O+qrQakfxMV115UI0a6ANEr7/S1m/a3zDplfezCDAaa/FYjY53CU97SQJM/s9BorL+Gj8vcitev8UQ4sJB8dxXVnSjfUdH2y2XoESyvdU9qy6yk4XtJYBr23i8rRzDlCbYEbGcdJNGp7/oI3TzPK4YAIBLqV0a25sDxGMJoGgNofg2GtZzZ1S/SA5SCigcfS8557LVinF25ip6d4QI5C5HfowMlDkiSyIjwJyhrF1wORuonjQZp4yWsm1WDr6zbn38YYCdmQE0qTdB8T/ANWhSXFdNVFd5n4nwAChqN7Arsmdytcydhu3qboTJnkWhgLBEwctQkjIBqAAyS0fYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O6zFNuYv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O6zFNuYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvKt61CqBz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 00:14:05 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB6XTq3838338;
	Tue, 29 Sep 2026 11:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pGMMFh
	GtLkbpTo5BkkjAp7rmRhjpzIdbQsitzbW4W9s=; b=O6zFNuYvBpQMkE6qkzsHwX
	oqZ/+VPm0vjOgYD0Hz82m+GWTGbS0lNWZX94vyYPmJIurU9l/dByUxs5uFiS8jWq
	FbeLJvl/dxG+Z/Z5t7Sf760ct9Gxm0p7wetCH26C+gfdkTKAxd1iHn2zf+4F4vGA
	xKvakCd9dlvhieAZalISdCjodgkE/G/nSjEh5Vi8ar8b3zp6+kt5GxXL4OJTfPJJ
	FtUje250Ftab9+JUSJ/uX3WHsdG1Lp9aydo/NNceWnNlTcU7yZFfl3cfPc5u4SgA
	41aOXJY4e68UkspPbL7eqx/CI8iBUKN5W3td8xiYEINstxt1q3Ji2nwD70Bz2/ww
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk6bhv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAllpa1647352;
	Tue, 29 Sep 2026 11:30:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y98h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBUgr646334394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:30:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0336220040;
	Tue, 29 Sep 2026 11:30:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101AA20043;
	Tue, 29 Sep 2026 11:30:39 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Thorsten Blum <blum@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Simplify control flow in ps3_{virq,irq_plug}_setup()
Date: Tue, 29 Sep 2026 17:00:37 +0530
Message-ID: <179066556652.265207.13341414387667650453.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914215900.84712-2-blum@kernel.org>
References: <20260914215900.84712-2-blum@kernel.org>
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
X-Proofpoint-ORIG-GUID: F02PVFWzm4BdsmXK6AmM9hVjBTSTjdWy
X-Proofpoint-GUID: -2P3pPcoE22_OH_xwNSLumhBlyAJFXLQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX26B3NI9LRGED
 XOzcrQlRNormMfrn/ql4vQ90gRbE+Oj5mY2OGTL3c4XUJmRMGAFrZ0i8dPehPXO4YDv6IcFJi/y
 V9CWRmaqyN6LqHArGSUnfHiWWs+5H5Y=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abba164 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=d86c0OqMtwPQ0Kf90R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX+JFDL/y8Dd2C
 WyN5UfLvSV+tIxS8qp6qyJk6UOnkonhlAoCSfY1RySdK6EFb5fKA4zZ6c13Rqrv7PXeECADH3ki
 7tb9/HOfzavWv1v8c9OlYeRF12WJBi66RWPIEI1luXhIsSebedUqxBCQpWsUuBzhkTMgFRaAlZA
 Fu4tbeStWwqRxuBs2LeQA7Alij0d+RWi/LvL+pqe2gtdDxhld75y/GCM84lguZHPxEAJUGCOeAj
 f/zr3mA7LhmrGopNZsEczv8+BTHHlQlZ891J13ShH+VGNdbIXbFk28qEdqS2/DoeiMbxLgFowy0
 ZLTMZQ1d9/Ssj+xN9k/x8DikNWaeQKv11qO4o6dwBjXA47WU3zyQr46mxJmgLcJhSkjqGZvLj9Z
 lB28Lz8/R7F9jHQU/Fx0LNVOTfaxIkmlBx0FwlnNszULWOzaY7RKPwnILMuzDD4TpmEEPa94YJN
 p6yQ8e6XrD/UP+dGIFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Mon, 14 Sep 2026 23:59:00 +0200, Thorsten Blum wrote:
> In ps3_virq_setup() and ps3_irq_plug_setup(), remove the goto statements
> and handle errors directly.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/ps3: Simplify control flow in ps3_{virq,irq_plug}_setup()
      https://git.kernel.org/powerpc/c/4d9f2ca2e37ce7fe7567761b2392748456e1ce43

cheers

