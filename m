Return-Path: <linuxppc-dev+bounces-25239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98106C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6v54tnbz3bx1;
	Mon, 03 Aug 2026 16:57:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740273;
	cv=none; b=KPNPoMxd9g49Gs+OpX4n8xPMq/L2CC9QIpyWXJuu5xsQNigHKeyEZzQs0Gme+R3cX1YSkcJBJ7ReZnIAfoAatSF8V9ZOKYnXys17a1nzou3EwZu6IicmPpymqUgShlBEudHAl8s/Y6PtLEdhM1EnqBH7vur3GmVGj0p5vOiHxTyUVonlpAUhv3mB8LYFpkJLvP124y0uaj5T7D00CrmB8DdXwk9X8y/A3H1JsMOzwPG0WD1nXqIsSIdzyRIIKhDRrYnHAm1GXgN+W0pVilLshY+seZlp8G3QF/RMYIoJSiCZmwsus7EHJKFNe4ycnV0vin51/zeeLmfFZ2N13kTTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740273; c=relaxed/relaxed;
	bh=Mv0W6p2V7FZL92vMQhN0Vq8a970TPN97OztVo62cAcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsOT+cuzVKSXZ4wuRtZcH4Agm3pZB+Bk4Ohgc9ezuYGWijk0eU8LDajX2yevPxVxpPpbdVdI70BWzCONbrdDuzRurQj9zP1CT3zPAfCp1bBjRJMjP1ia0Gqu9vfgYhuQ/INPjt9iGI8stJMcN5qp7W+cQ4VVJBaIcS2eoMJg/O7yMlBH/uNLyvz+oD4VbTfqNIqBjCAaM4uTCa///oCz0llQYaXrj5VhzPBtTlFBg7+/w0II7fc2Cky8BL4D/nOULeHPGV42drJQDU3NJsC2NT+3Wf9utcgK4fzLU1xA1Od/LBBgPsy7kgBGqwve4ednW8YRbujjRG/WSt0RaldBKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ejYk5l2Y; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ejYk5l2Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6v46VCJz3brv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:52 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmpqF2566607;
	Mon, 3 Aug 2026 06:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mv0W6p
	2V7FZL92vMQhN0Vq8a970TPN97OztVo62cAcU=; b=ejYk5l2YVFQujEsSUCsMSU
	eHacJovIC+19w8Gpv8VpIT3M1qH2rRp4yhXIkp8sE+xt6QLmKqx07kUi3rG3x222
	yKvgY89z3X1mHsVGFCSNUtYChZNf4ynKWjO4S4wKkL+9dV5kItDnsQHghz7XnsuQ
	ONMdvAwWRw0ROjHK2NrEENfMBcCFf8lf22luQxZZIwJradygleH2tXpeXIXtRywQ
	mjDDySxF5Q2mWwkLa2PjSSDlJzN1uVudRSNgwlhjX0T3MXBZm3kO8do52E7yLmEs
	hx0EyslrTTENjJO8z9LO188lasnFRj5YxOh7RLZRH0QgTBFg2lX3nDUQKUL03hDg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqf8mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uEFh018622;
	Mon, 3 Aug 2026 06:57:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybvuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vT7s25362850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B0D52004B;
	Mon,  3 Aug 2026 06:57:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1AC620040;
	Mon,  3 Aug 2026 06:57:26 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:26 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sourabhjain@linux.ibm.com, rppt@kernel.org, baoquan.he@linux.dev,
        hbathini@linux.ibm.com, adityag@linux.ibm.com, ritesh.list@gmail.com,
        bauerman@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH v2 0/3] powerpc/kexec_file: Fix some bugs
Date: Mon,  3 Aug 2026 12:27:25 +0530
Message-ID: <178574013469.29744.18290968780763736823.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729012948.2797865-1-ruanjinjie@huawei.com>
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
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
X-Proofpoint-GUID: Jqmy3z3msL85Pg0d1XGE1mvgDQ6ergGJ
X-Proofpoint-ORIG-GUID: KmTcQjmGu3H3vTj_tT86yXSbk7PggNy2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX834835+uGElx
 OlrxeGfRNgDR3rZdgvYF70Nhx2GLWupPxxcyAqPRYwt3fLEGbhnZoGtJvlKr4IzSyvDDeVPOpCW
 Q3esHyVyVLZFAnAgznEbtrZd4ZqvWrE=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a703be0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=x1j0oFxk27fp37OsSCIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX6BzGSUm0p8F9
 MFj73MWmjAkXnHk9WcasILz4dW2ErG6+rGJTNaoKLDExB9Bc/SH1jPahgb7Zt156toSL5we80Vz
 nVsWHCh6B0oW2cPhwg/2n4asocF99lXng3KImODUMJ3yVqSpFV+6MAgz+JevsnyvZCexVs+Fnrx
 oUzP/r/hijYQwR/5ulPXSLUbtSy26w+kyJzUHppcfo5Xs59VCkV76YFgYMvVdAmCh6vsXDNjJId
 yZOQS491nQfFOkCmlv91iAmiKlfbjMOIT3SvlCXOke8dk+lRHp5H6GMtmmLd/tPG6QpV2mo42JX
 2wrRhVwSqNPJLXxEgXXFs33TG4FhPCXtIIPX5SXihefKpFsX/xZE2DgRjfYPmsKrTM5g+m6NQvP
 5Z3JNC6J43ADNiG2NdkAvZozO7V8inv7bpZnqQEiMevyxqNl0n7fknUXzvnZAfzvQxZkydkcp4y
 E0FVkdFPGtDINtF6D1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Wed, 29 Jul 2026 09:29:45 +0800, Jinjie Ruan wrote:
> Fix some powerpc bugs pointed out by Sashiko AI:
> - Memory leak
> - Null-ptr-def
> - Overlapping memory range truncation .
> 
> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
      https://git.kernel.org/powerpc/c/4cc4b586007fbbf8edba4f1d0849e9a06b0cf6c3
[2/3] powerpc/kexec_file: Fix null-ptr-def in extra size calculation
      https://git.kernel.org/powerpc/c/761eda315a6e1fda3e8e2185b28430771fb1ac29
[3/3] powerpc/kexec_file: Prevent kexec range truncation
      https://git.kernel.org/powerpc/c/fa40f9dbdd4af53e7445d9135b5b207eb8adf372

cheers

