Return-Path: <linuxppc-dev+bounces-19471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55587FD5F6E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97X2VY6z2ymg;
	Wed, 08 Apr 2026 14:29:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622552;
	cv=none; b=VbrL3J+lGgTXyeiembNLDdLWiP5F+dlVsOFq5BHkGeDLwm/xZ/dErcrCrgFtnW2SfCR7Rx47HAP1w5btyB7FAzZSknJy0fztIBP3VZC/Hd+Zwosje0VtV6nmmj8QAwzQI6hXIpE386LS3V0BVS8HsXIEPh7edUyg+z0D+IobCHaUGbj3Kj9fbMm6Q0UbI4iPAw6HQrsHjRfMmiTeEzpbIiF9bz8DPIDCPfDsvmwDKNAwCwLrxkm+jHGx/MPyj6CV5hneeI+lQBJxjJwJKqziAGpoNSmLFZVr4ZImw+gn156F3ogYOe5GHFz81CD0vIPDjrNIcRWNtiOroWjCOAJeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622552; c=relaxed/relaxed;
	bh=3AzCOHsYNKyH9qBJXwXqtvSxmNefomSdS5U2Rg9n+rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AP63m4lCRRFCg+ZhBgLwjy+5Nr4R7ttWTJo3FzWPdc66pnl2gvgBS4U6pAjzHbXljpnJSAOAeSTc9qm0JLauloACsAk7zD/pMES5G5mSviCz9xSsKbGhFVmB1rb0UH63SJ/2zPZVdGPSCZL3HTwgtOQcbnQOSPzJq7KjFL9Hvl9EDOn3rHz8v4gF2pssIqFPOQuE+FTP8ZKefRTkUI6obRN2eH32otGESM7Z5PF4UP+sp6bMJzgNP19boDaqPEBpK8iOvt3m2L8Enl7GlDI3svvWucCGQ6cZ8bQx2BKKqtux8dy6QNFYDmHuNokrfpfneKdyYeWSTu3mGAyQ57glsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S0qZJuYs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S0qZJuYs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97W4hzqz2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:11 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DfQFb2302393;
	Wed, 8 Apr 2026 04:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3AzCOH
	sYNKyH9qBJXwXqtvSxmNefomSdS5U2Rg9n+rE=; b=S0qZJuYs4WxctEZMgZt/lL
	RsCkmM40BDu6FDSCwXNKolD9bI24SPcnbPNuu49x9G0PtlABO5u8sH5Z0QCUHl4H
	g2J4Za15v9X+OHsHRKG23+CNBGkm69RE2wUvJIO4vFuUyx/+ytInFmRXq2Dv+eJR
	dR2ulRY70tvPAH/iqKy6RX44qc01WnGgfyDJyQZ0MLDjtL8856L+kuoflepdtIdL
	gg1gucLWPd6xVk9fEt33z7MqIJIyTuQNqS/BINvX+RxMGXj0JPqG7MCWS9q0HLwJ
	xK/nI43uZ26zAzShRCHCk8nJH61qgo4Y6eU2ReruOlmwNNrKOk5zDfxubIYDQqPw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe787-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380McEl007898;
	Wed, 8 Apr 2026 04:28:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2dyxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384So7P26018124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A118F20043;
	Wed,  8 Apr 2026 04:28:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C3E20040;
	Wed,  8 Apr 2026 04:28:48 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:48 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: agust@denx.de, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        jirislaby@kernel.org, tglx@kernel.org, Chen Ni <nichen@iscas.ac.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/52xx/media5200: Consolidate chained IRQ handler install/remove
Date: Wed,  8 Apr 2026 09:58:47 +0530
Message-ID: <177562236423.1381144.15627905558376011563.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260119060450.889119-1-nichen@iscas.ac.cn>
References: <20260119060450.889119-1-nichen@iscas.ac.cn>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX4T86GR+O2dP3
 8jsEjAnZJZ8ZZx/luN0VgeGBldNdaAmxXSUnHRRxDmGXdatZ+ewDD/a8FT47+mE2icBiNTFhOjR
 qPeqKipHmNHWHv+g4i3p9z27pQq0FIZng0hJgPI3noI3EhtuCpCCMP47rAELSI5drrChhC2ZIGW
 1KqOTzkOm4KfuL8s45NVD0tZNN0uQ3eRPP3jEn4I0lnAawQBjkrK6EXZIyAs92brkHqhPU0dN62
 FikjfRmJfPwILdYTFVbmz6CuOTMsaMuU/C5ooh7rlKZxAkaGAAboi1tgWIcBj/xyV7zBkHs8WIq
 WNnjiKZ31KsRCelc3qkCdgbrrOfgyKvA8JIUOXbeauObKNqDA/JpD22NLkMo2Nzc7tJSIuzxUk3
 43+kSirEV4eLQQGEYURicof22r2iG6cjKwU6oYLxdF6IB3jBeA2XfN93hWiHgPmjlGHMnf1UHNo
 +6STG4vAiry76fJwB4A==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d986 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=INnRM6tJwyZGxOc-LzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Qf6ndw1EpXrRN0Zr2T2oYVNqWs3AxnyP
X-Proofpoint-GUID: FrKjR5_lYmowgkSmJbNsdD-r_D-qh0YF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Mon, 19 Jan 2026 14:04:50 +0800, Chen Ni wrote:
> The driver currently sets the handler data and the chained handler in
> two separate steps. This creates a theoretical race window where an
> interrupt could fire after the handler is set but before the data is
> assigned, leading to a NULL pointer dereference.
> 
> Replace the two calls with irq_set_chained_handler_and_data() to set
> both the handler and its data atomically under the irq_desc->lock.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/52xx/media5200: Consolidate chained IRQ handler install/remove
      https://git.kernel.org/powerpc/c/1ef8cf10cdbe79823fd6de0f0b93ca996045d1cc

cheers

