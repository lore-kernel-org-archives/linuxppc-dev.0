Return-Path: <linuxppc-dev+bounces-22832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39935CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2d3QVdz3bqV;
	Sat, 20 Jun 2026 07:59:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906393;
	cv=none; b=OaqWQGPD2bH9NQT+UCA53w4DL8Fz6UywrpHJ/VG7mmeMka8wD7GbtpMYkSHLFoy1FpXIOJ7LFzPoDui1F9RU6B5kUX/1KhsGlr0MJvuTmMAvi4mR7PZP4WY459zlxx8oGFQwlQvpM8WHEHP9qEJIiAE9Ed6OCoYJuyqkeWTiicjZoWXSQ4myXUWjdO6gwsV0NGK//WfrSXlUj+qIITt0QMxKYmFr/bLSZ+JsVdUR1Dbylup+WPtPjXYXVXpXfFLfBYObfKFGN+Ysh3wDIikEclczVOhCQTYHq1ipplBPK4r/v3WppJWcW0LRxN9xef00KPBdsCuNt/qx3fuckuf1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906393; c=relaxed/relaxed;
	bh=zd/1ZTnKPOvboYbp7sjHLWr90vshkJ9O6iWaIK6Ooy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq6e+7RdPJBJaaENaSrIPQDysOW6WsSQ2mb0MCe6ou7VGSIpO4OvhjpuyBdav5au/JBJ8n5QZ4IJX14tMsLE+reDbCQpKfvId1koIPudLvVgzQfULm1mhOUYUWe4ZMWFkRY4B8N9kLf840YMoBSyqLt1VKbhAKpkPv4DRYMZhFS4x+irVtVa33QUoEjkCMKfAQKCmx6m/u+O6kCQq4xX2ZmOUaP4RjvPhMdNohP/B0xEWs1NoqsrdzTsvTxmP5PsMrG7SkMTUtp/EGwPw7hiIrkmxTJ8ReNqSaf5fZYtNT+oia68yAIEii5uwV808wBmc6dJGbtg9eXDyvl7jbrkmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hHDcCCuh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hHDcCCuh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2c6HDsz3bwd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 07:59:52 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLm9Ew3445032;
	Fri, 19 Jun 2026 21:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zd/1ZT
	nKPOvboYbp7sjHLWr90vshkJ9O6iWaIK6Ooy0=; b=hHDcCCuhXYPplBcu/kH2bN
	YWHWi6M0biTVBrYRz/L7PH1Ds8zFBOvbHca4Pnf0alZl4U9ta+AQ8U+gj3h1j83G
	Rb9EdFotdbeaDuTrSQlBO2hvVoGys2IZd0MwyY38Jdtls7eJRvY6bcYw0OLdNW4h
	62fx/bvuNrDkrBy8BCfOVV103hTDI7NsvFaiUcLCy14LspZ3rJ12ampyyu3eBBhg
	BzOcOHMFnMptytf0zrJEkzDVcLaWIsG0YCDSPsCl2y5WG+AZYkXhpiMR0r0IWqoc
	PJkE7wM0LlDUWcJjv0RM752QRIJbj1QWvYVFi6M1kkZlURSVszOXtiyGEHixsKYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw7rtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnafb026087;
	Fri, 19 Jun 2026 21:59:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172as9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxglt33292718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC6B20043;
	Fri, 19 Jun 2026 21:59:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A1520040;
	Fri, 19 Jun 2026 21:59:40 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:40 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] powerpc: Simplify access_ok()
Date: Sat, 20 Jun 2026 03:29:22 +0530
Message-ID: <178190618805.653308.12551444912564774900.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f496ba4f309a2fb9fd0d8811e941bbcaf5d196cf.1780482002.git.chleroy@kernel.org>
References: <f496ba4f309a2fb9fd0d8811e941bbcaf5d196cf.1780482002.git.chleroy@kernel.org>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX8RcglD+vKF3q
 sjAtmwmD4trUMgPIalLSht9Ackb7ZqhrWOayF8xlxAtd4UjR94Cod+JujFnsw5vLJyJ+ytrT9Fx
 z24M0Vajpi+BvJwP9701rK7T48FCfDc=
X-Proofpoint-GUID: irNjUhy_AJsla2rFQKd4wx8pqv3Nabj3
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a35bbd1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=-sEw7XWu115C6S5F2YoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: gwjUVZmBCqbWxZCr3YCsvWL90_zqn_zZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXyUBP82qLlio/
 q360e6db8wvWfAUud390pvciAP+zV3BRZItuQkAKZBLZ8FWHWMfz1+Q1zeUgquFO97EM3dPnAlC
 UJfbhZSE2A8KeAZ6iXoVJCg4vEQdfkg4oasroGqkjvLZOIfNKJRo8JXBaYbQ3CQZv8f4o0OTQVP
 Uzg6J0t8c2DmCVXzjN4R4Gp2onv93oEQFV8ODsQivYBw5aUW+2d4elZ8vwwnDa2hvUgP0LAqLBs
 0e6YKB+oTAHyOirC4vqnH1CO0f4f5aDRGOQBwqnEszHrinGC7A5ryE0WpUEVKHEd2hp/xO8dH6T
 pOSTuyiJntwbPvr4wYipup9TzBB6eVrKj06SeZDnHxq/eoW03yagvKOgO1Bea9cUwSA/63p5iNg
 atFu3JxIIwrATzvegdLFL1+YUXHlsX9ApGqWkYCiy8io0D5Sjtl2y+SwH2eLwaakgeAPmlPazEo
 O5iB5fABOVjEby9iLpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Wed, 03 Jun 2026 12:20:14 +0200, Christophe Leroy (CS GROUP) wrote:
> With the implementation of masked user access, we always have a memory
> gap between user memory space and kernel memory space, so use it to
> simplify access_ok() by relying on access fault in case of an access
> in the gap.
> 
> Most of the time the size is known at build time.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Simplify access_ok()
      https://git.kernel.org/powerpc/c/90b45dbf59d50e32c4f86072545ff44bec9cb28e

cheers

