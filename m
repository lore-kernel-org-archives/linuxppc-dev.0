Return-Path: <linuxppc-dev+bounces-18001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BAAFD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:15:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTs6vHRz3cDf;
	Wed, 11 Mar 2026 13:15:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195313;
	cv=none; b=KXibyCz6S36aVZcSg4OHYodUQ2+AHhIGFswSZwESRywViMZz2yur2dfx0kj96s8ePmh/zK8iMRnlJb2LPyH6liPc/Fvrbvexq3agUxunhpKBCtTP9V06INfph+UR94XXcaCXD/bZnKr7MCb4/mNviaBDxhQDMiRLM5WnXeqFn58r1OaJti4TD6v+R0/07bdYuOZjWWUxAnuBqXnxzfdq6rhprkX+9y1c9/6LhkFCYm4OsWrgKrKUBjJUKJyXO2OsEfzXw2pusBZi2CMm8zB2jiJok56qDAWIMeqM1PrpLimfrr4rU+bcnPAhOL60vPVLBpnNGeg0wjbZRpUrW1suQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195313; c=relaxed/relaxed;
	bh=yjz7WzmU8TUkp1ee1VfM+E9FEHj26j3WmKlu5uBuY7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grPFZlsNMCSCxb4I3IitAAL6kgQH7vEp9wJTPMxoWg7YIcaCF/yfYQtE1vLknMjh3q9OvlkrKjft6YIghMCmMIf9d85MzcAaedObrWzj3ElelMrdQ+CKL+OB3r0Wd1NYWWyi1dcjn5K1+PwsPtsoSctwxZeyzU9YjoFQo91fmjtDDXsLUaMILFWXB9fUj8BN2Lyv5XScHs3U3f4Hh7BkkAA1J1jGYHkbSjBWZGYKWE0MCbbHyftaHpYVZAmAKNiy3X7dfVsVV+LKKOiT5uBEsSBU/2pFtWrxN3mb28cfuKoZxC0A9hUR9j8v4jHGpHwhJtN7iWUBoKc7TcTPIKfIrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aNTniOIk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aNTniOIk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTs0sQDz3c9r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:15:12 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ALUx5Z1445721;
	Wed, 11 Mar 2026 02:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yjz7Wz
	mU8TUkp1ee1VfM+E9FEHj26j3WmKlu5uBuY7A=; b=aNTniOIkByCxHhXAAZ+0XW
	NPzHW2qKf0OJkPIcoW08nIsQEOJ+a9ddYPWdkO8FW4RsBgd5+KiPPu7wxJQO/psZ
	CGbRpzsZd5ocAIdTHg5GUL0dkYj2aRqCUmUZ8xtVeMPUby22d8dT080MtjxiaCpP
	PjkJpIMiaRL26mfuee8+EvJH26eKN8TxsNbA4NxxyuCw7IDuT1eYZFy284B0aMPv
	waF12z33SXI/B21KlKNLIJSBg31EZuUO8UaWIx0JL1FBe+MI9pqiz6XnCMUXy6ZP
	cAvkixVDG05y05tH5XckywHZ0EBCKo3Hli8x203pIwu+GF5O1hOaPBgWrrT6wggg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mnasc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B1dPuR021521;
	Wed, 11 Mar 2026 02:14:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsurts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2EApi57540876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32E3A20067;
	Wed, 11 Mar 2026 02:14:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39DC820063;
	Wed, 11 Mar 2026 02:14:07 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:06 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Holger Brunck <holger.brunck@keymile.com>, Heiko Schocher <hs@denx.de>,
        Kumar Gala <galak@kernel.crashing.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: 83xx: km83xx: Fix keymile vendor prefix
Date: Wed, 11 Mar 2026 07:44:06 +0530
Message-ID: <177319508348.269267.15813399622869081719.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-keymile-v1-1-463a11e71702@posteo.net>
References: <20260303-keymile-v1-1-463a11e71702@posteo.net>
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
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b0cff5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=ulc3_ZQOeZhq4n8l7tAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX9zZ24upbaIon
 OfLiaTP9XS5R6dGWDZWaUs1uLDEPUagBTqAJICPjKpWxlzwvKUYEvFC+97S8ng1pWGyWpwCYMNN
 qjQo9WVy6Bn5LcaiVpQzlcle7B2rUsLTX1vlKxVdD8Ey73WXnY4Cyq3blUDsbTyiR3extT/66v0
 AVE9hudQpH+V9DtNTt+bC9xcj1KUUsUmxlyrneR5X+0V5c85L0fMIh1vwSV8zKDA6B5GB8seHoM
 F/Ly+tKE7QgtGEP9Uq8Ai2V03LbzCzfMnFTQ/FwMZyk/IfWBInkpi3bQ/n6Z93UYuK0P2GNNdFk
 RdikSoHpW0DjhqmDqPp21KSRYQMqlvsl3n6igQnw9MzjeG1dJeRKwnAtrCt/GKUGK0EsJGdqX6D
 S8UnhrLcafXG1mcWgyF80J6Ni+a3JRQB0o+c5EX+GZ8pgO7AVZTk+i1jHezXGhZeEkGpBJr533A
 5AqG/i1dE56vAK2eQug==
X-Proofpoint-GUID: MRKfPSTf2IKokYZWLaB3ubJy9lmE-3o4
X-Proofpoint-ORIG-GUID: dhonU6ZHfAeFoOrf0MNqRkYqDR_eAq-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 03 Mar 2026 16:31:42 +0100, J. Neuschäfer wrote:
> When kmeter.c was refactored into km83xx.c in 2011, the "keymile" vendor
> prefix was changed to upper-case "Keymile". The devicetree at
> arch/powerpc/boot/dts/kmeter1.dts never underwent the same change,
> suggesting that this was simply a mistake.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc: 83xx: km83xx: Fix keymile vendor prefix
      https://git.kernel.org/powerpc/c/691417ffe7821721e0a28bd25ad8c0dc0d4ae4ad

cheers

