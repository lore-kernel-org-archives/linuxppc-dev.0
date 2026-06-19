Return-Path: <linuxppc-dev+bounces-22833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A56CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2n4QP3z3bqs;
	Sat, 20 Jun 2026 08:00:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906401;
	cv=none; b=VNhHgVnlbVA1rI+scYIJKL0XKE2Y/Le5dxO8PEPtjDRu8dbfpbIiln/z/VWlgu62EPrIIzASXnSidmXR7OJWtCv5ngVKOb1/6v7Np1ETnozs+xt//Foy3SsOnpN97vtXuFpz2ND7YhJ9Mk95svSu78SyCC443TsXQqBW8/ajy92dn9izM/Z8UaMICojItugSlHMpxhg1chgPBalvg5LaAPfTxUIhN04MhG7elLPWHyEnU9oMLBCAGdDey1nCVnBjmAgCB/wXsxrLy35YKRkDe03AoRF3tvegPh6FgWHxQbt28Xi+NMW2BzyqlDlmtTTBsgrf28qgBcg6tCPZGfKCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906401; c=relaxed/relaxed;
	bh=3bbdnGJ7I7BnUNBUNgIKTcohPRf6DpGUxEmEmgqlaiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URVYV6wv4s45isUqPxrVmzjH0ufb6stIqpGhB9IRiXdlRpGYpecwOKBro6XSJUnkL1vNBuEJT52ON4wiovLEXpgaKAvgvdIGmCWrv2LyG10YzenCWkNt+ui5ZiUtzt2LiifOqt9tVSsLBUKiZIjwwKP7EYBI7eq21AfaWm4WdYMAPkQGznB05ZBiGy/U/p0SifS1WlFIc+A3g9QuHPdMTZ1PYp3QRuW0wmy3SwBdsAKUNu0ExlbTTamgkq8efnjpUHSfta5A8LZvqG4+F8KLVzL3H80ai7SlV5hWEN0zo+HmOsmSaXTy1eKqgOzFniC1B8TTDSgXXb1WheMoN502tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fL38MuVX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fL38MuVX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2m5TG5z3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmX8f3363088;
	Fri, 19 Jun 2026 21:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3bbdnG
	J7I7BnUNBUNgIKTcohPRf6DpGUxEmEmgqlaiY=; b=fL38MuVXHX1N3fQ9EFUSKB
	Pbek3kK64FlaSej0LbyEJy5Hxd2juLFA6sUzPst4h8BT151CrqykiRIo06OOn0nC
	mt++49vF8Mmo1t527/1N67VnYo+ThhirVA3FLXevgMhII/vxtbnVm5+WptjAFPwE
	znREvoRiwRjTR55srdCY9AS/v3jboGlr8Oi5WWf2gA83L8LMUR4a8W5AKb0BRw0T
	6Bj8QFb8CKeJw89shxzQKj2UqNKQyUWWXMVe9ZN4Hc27hoNW2LcyPWYBeKxjPVEq
	uySsBKKlqi2o4EgWLgnH2XQFnNZ68/hOINHvs9tJrhzpxLWIm6KwNErrex2JDi0g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfgqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnafc026087;
	Fri, 19 Jun 2026 21:59:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172as9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxjE442467678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6BBB20040;
	Fri, 19 Jun 2026 21:59:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F6E62004B;
	Fri, 19 Jun 2026 21:59:43 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:43 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add missing model properties to PowerPC DTs
Date: Sat, 20 Jun 2026 03:29:24 +0530
Message-ID: <178190618779.653308.915690556470586356.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260313-ppc-model-v1-0-bf19b3d1b65d@posteo.net>
References: <20260313-ppc-model-v1-0-bf19b3d1b65d@posteo.net>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX1ZVqHVwIFKOO
 8LNUCqlF7bvaACPE7xkhxaGg4t3uHODoaeeJMMxWZ9Q2BRiRdgBLMSwFq50mv5H2UUgcBQP1ZOw
 y/0RYxOny+i1cqFWbLCP3WVcVRnL6ywrJkuMhozVCnQGhaAXZt1RbAZXQv6lCzMORyJt4pMDksn
 l/923+0IBBYOUvLW+mxZvGVE4+qXeblC6FmN0rFx+k9nofAJ1l2qICiWxSkxuooxtv635QcuZED
 fl007DXQ2SXOww4SYmeS4sds3YVd3SvFfq72pjOHZtiK1Xwji4nun1PSmPJAAQSx89ADI4NJxLV
 lnxrtRQdVliKiKMKi80YDWP2/bi6QZVinhJXUo/JRjW39IytGqNH324kZO18TAj1fcLz8iDDA1v
 cdHmc0FcB/tJLIOVBanjIWZTBIs05JtxQqdLV/nfTaVHSW4wmvoSjdYkF6gk0XRswA+K9TcAMWO
 r8MZBZIjsc1R3p+2rMg==
X-Proofpoint-GUID: 0v2-9zPx--cCSXKp2_K6ORc9vLIuwBOx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXwafsOa7BveEP
 fAKTbeDzrXFEMwDnI9N7LKshehVRSUIGw5x+J/vlzUhcNqeOi3R9Kxa1GrsmgEbPclXE3qElTfr
 S7/3xjjCvqY2yVUYyOf5+L7UCW/08RY=
X-Proofpoint-ORIG-GUID: 3pgbGjrn1UcjsLTlT_r6vcQTrf1z1Gui
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a35bbd4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QcKy4yMqzQW6tn8UXNQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Fri, 13 Mar 2026 11:14:22 +0100, J. Neuschäfer wrote:
> The devicetree spec requires a /model property, but many of the powerpc
> devicetrees don't have one. This series is an attempt to fix it.
> 
> One practical advantage is that scripts/make_fit.py will no longer throw
> an error when invoked with the powerpc DTs.
> 
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: dts: mpc8315erdb: Add missing model property
      https://git.kernel.org/powerpc/c/d16cb0a9a42f7478c039ecaeba241872bc0b567a
[2/2] powerpc: dts: Add missing model properties
      https://git.kernel.org/powerpc/c/ec07a2f1d337dd5a816431724a876026296369a8

cheers

