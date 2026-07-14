Return-Path: <linuxppc-dev+bounces-24195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDE2C44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 08:50:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gztLg74s2z2y8p;
	Tue, 14 Jul 2026 18:50:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=67.231.149.25 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784019051;
	cv=pass; b=bhMiwYcDbtNg3XYIDsB1DCl2HkJziNh1TLgB71OouYCLaky445D0RFBTFtwR2pCG3SjU6wSRglD14K/S88rgK3eevo/U/w9HGbKJHyPIqG3YBBxU3HqfPzbGEajjY8TnzRZC9Zv8kLaTUFDuOh++WRkE9R6m4Oo8Ix1ZdMcJ6JsoQIfAd2YmXIRdBUmzWWG722B3tKxhtz16pRoencweQ+UEgBk5i+tIbTpDreGjd4XSnIW4aaZgSTB8hilJx03swPheknwFM13DkTzCHwh1kpMjkeZSTQRB1kkD2hkPQdkQ80XqfRYrYaWAGj1vibHt7HnlpyM8M4YVU+zK0plmcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784019051; c=relaxed/relaxed;
	bh=17Do1Y+rEqiXh8mfvRHy6sXjikGKouXkkDLogryq/c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPeQew+dgYQPWv6JoZWPmYyxiO3jNSAK4mP41hOwM1NlTKy0x0n5a87AHGQym8fUtjYpGByMGU0Th5WZrdWtqW10OSgft2p4yEXDR8hJwUATBPxiVf+sfZ0B9LuQCb+pG77+bdQXz+4sWNGi1keXlRLrWi21k5hgauDNmqMeBPBTo7KCXXfvlYlk9QH4sPnyRMkH2/BNrCdOvgg/5P8wljFZQSKTGwKXiE3sfqUpzFj+QyDy3Mb7cWeNi+0PZU2VlnSH3x2N6fU2SzjA4gdg4Qg4ISUSrSRT/w8NaiWaXaTop119zppMA64W/Vv6knI58dzZqLeX9eT8zsRJWr7rCw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=jM1VVFGS; dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=orPNw11t; dkim-atps=neutral; spf=pass (client-ip=67.231.149.25; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=86555fa6f5=ckeepax@opensource.cirrus.com; receiver=lists.ozlabs.org) smtp.mailfrom=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=jM1VVFGS;
	dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=orPNw11t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.cirrus.com (client-ip=67.231.149.25; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=86555fa6f5=ckeepax@opensource.cirrus.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 524 seconds by postgrey-1.37 at boromir; Tue, 14 Jul 2026 18:50:51 AEST
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gztLg1VGzz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 18:50:50 +1000 (AEST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E4voJA2160427;
	Tue, 14 Jul 2026 03:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=17Do1Y+rEqiXh8mfvR
	Hy6sXjikGKouXkkDLogryq/c4=; b=jM1VVFGSVte8HjK8m1yXgQpnDuWYQuCMBl
	8wBkSC8za/M6LiQfcZkx9o64SXDf4852HVwCVyB8Xa3SU5tRj0rZWLzRZHOfez3w
	BkoQ1U9L/tvEsL8D/b1e4n88LY6Yg6eNKLyuvTbMRvMCCBvnVZ9CUK/H6qq7nE9A
	B8GkbI8rmvZGQsFPVCxOFqf6nch332S6lHlOO+u8yPEsj/PZRzBIl/sTzNIcXemL
	8UgyL9D/hEsGn3LaBXCjbaUVi3e1TIZVbIuJnAV66YKx7MaSBs6TmDXScB3tVRmd
	07camJ+XY8PaDwRvHWCC36nsgqf370BFM3GULcwhSOQiX1UHtu9g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020103.outbound.protection.outlook.com [52.101.201.103])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fbk7vugxh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 03:41:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aODV41x5mUsbbHFlg2582+24Kuh6bo1bMEEwqljTKkYZ2IJQcUVZYOLXJARzdrTrhwsBijfK1OgcQjLTSSPI+D2bRywOfB/ajR5/S4CUdc8t9nhIyg5EnjZHMFPLpXRlSVxL+YiIHjIkSeQQNwDBLIUTJZ2gIncGFeyaYfDBxPnhETOd8ccRL/3P5vROIFYtGS83gUqfZ7c+KJi/ay+RtTYiPU2NZ1vX+FobRRWGGZN2Ijw/qXdJ370f11CXSvc47Cvkp9MHXtWyFxUcWF90q47e961cGVTwlBx8P9WhN1b9x9F2vCqCeZBiXPaikCzcUGyCIPlLX2ouUO/ITUGkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Do1Y+rEqiXh8mfvRHy6sXjikGKouXkkDLogryq/c4=;
 b=jPxCSyAOIdydTwE2n/jzi3Gd/I+HoziHb6pW1NM60bMSs2wSFvo8+ht9OztTik6DhlAGLy8RQ1uNTbLybLJVm7bXyV9jY4VInPq2MaY3GfNH3BiPUktq5vy2DBTyIuOHWE5rv59SsZ1Fu5N2s0WSz5rIPFNhIIbEq93JTwleKCX6COM4F6OcrAB//c1wulgKHBfBJcHBp+rT0+JMHSfQM0yZIGu/Nh3LSzUs77bI7KPtPzRdKXhfJPEH37BMtJnycJMRvU55j5LHlVe2/sNUG1jDCJ6Xut44r1vXgvLJc+t+WVu1eYacQiER8x4uassipo1bGkUC3YW1r1uSEJs6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17Do1Y+rEqiXh8mfvRHy6sXjikGKouXkkDLogryq/c4=;
 b=orPNw11tTGZ8kkMTqYS1EEDWNt0hNRTan+gPmT2WlCGSe+7AOlk85Ev07JEOeWtoCF+Gk7M3o4DExGqmfnYKsjSB9cbiElsvTzlOWUSHQwpaUJjNBk8d9LFsmjVKPRg//tJH+r8fjzsI996eYYkkZUI6DDi8YXzv+OXvt4yu5EQ=
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by BY5PR19MB4097.namprd19.prod.outlook.com (2603:10b6:a03:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 08:41:44 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::7b) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 08:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Tue, 14 Jul 2026 08:41:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9F222406541;
	Tue, 14 Jul 2026 08:41:40 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8D45282025A;
	Tue, 14 Jul 2026 08:41:40 +0000 (UTC)
Date: Tue, 14 Jul 2026 09:41:39 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        patches@opensource.cirrus.com, Srinivas Kandagatla <srini@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/14] ASoC: wm8904: don't use "/**" for non-kernel-doc
 comments
Message-ID: <alX2Q0uMQNsfvjCt@opensource.cirrus.com>
References: <20260714014445.569992-1-rdunlap@infradead.org>
 <20260714014445.569992-15-rdunlap@infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714014445.569992-15-rdunlap@infradead.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|BY5PR19MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: e4887382-f423-4a7e-1424-08dee183ba69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|7416014|376014|36860700016|82310400026|6133799003|4143699003|16102099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tAx4lmdWalr+lz9oQatJl+SUV7VE7JFuBL6xoWEzD4ajKsg/CUOddEr2HZAIHoWwOSX/ztVcRjznXlwfW0XjEQksFY+NQzW75jh+TlOuQ9Cn1fvfEFhctxA7met1s+3Kj7UAzjCJ+7vaSWXtsV8GXWXf7m6ppmzO3rFV7dNF75ZSM+06FjRiL2gpcoVBNaWeU6R0lJNUvMoKjSa447HoTn0KpOdI+LAm3rpkxNbXMF1mD5iooAYjValwla0udingXeggMDQfaSP0I9HRlL2Op9/YYBv/qBpg1GbF5Ge8e3RR8I8K7y5W9rPW1XxwPmTP9BjVGBOP5o4wJtWGQVUOh2HZfCZIRWGWbkGnBbC27IaztBGyaW1RQfT28mifDR9i41+0LAgbulVc5PWH+vR6biRB1uvIj7MEvRWHwaW2UnJ8lKIjo4nh61WnUzu9LC/kxSMTUp4uTcuKhuLL25iEghTRsW2N+CkP2sAh9cGMWjev4wll8ieqjeCIdFt5/LlH8WAVUVcTHcIvIcn7V0S3UWzF+KfhwztpW7lJMBF3RyXbf0u8wW0bdHELuaCeqWbSuaQBS3v09VmMPU3XMRE9/GrOjgVSEr3TfLTR5aiaD6vjS7mQV557Ua9nR6XK2vYBtjFLbB9H4DPLgJOn9rWvTkL1oZX9vutXjCTgCajvVkhvKX7HPqf9gTcwsVq7J17TSa8G5m0iEqx7V5a/lf0g8g==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(7416014)(376014)(36860700016)(82310400026)(6133799003)(4143699003)(16102099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NKLhAAoYkeOF2SAMtGAJsmrTKMYuzS5mUZ1trAAedka78sam1YbqiLd3WQkGEts5zM1pSE+1BHGFf7yO8tJZpfnvUTyMUfT0VSnqi3xys+oE7yJ3EuiviGTjw5mGk23UIZ3dvCoiAuhhp81c/dSCPc+x5ytPBA22vWMYDjQKCKe9YU0XMSCWuYjTEGRit/W1FbBWS0cpMWTe9JsK9XSmc9fyCaJddnw5tsUHnwk+tBHOtdgPfgsmyinC/z3HSiNg4GDWokfuc4fZS9/22YUKW5O9AnIHEfYruvsRWI6vtWjYzvIA9z/WqU5W12ljV1BHyzhnUjq7Cr/ufDk+0fihKOecR10pbXUjdrn6R9WsVjIljSN9EGk3Ew1Ow/BInSsl10W2xs8K1vFkV3K8S8FDJMVkh4aLQrTTqy14fNoqcw/LPpW1ODQj89PaJNRvuULX
X-Exchange-RoutingPolicyChecked:
	IQPFkpFJOmiBw99cUjglf7oQZMValqUSuG9jKow+rSp0WMO1f4r3Uzuc1kH9qgsBEY+LQycNRdjKK9EYMvh1+ncUA3Ykk4XtFcRJKTECwsbTB+M/W08IsVLdwgzwvsSl+9OGi0RqEEbRcFGpoxAgxUEq6X/Unuo2iesFlsvxhBaM84N/Pe/I/YwFxR1A0Za3wKlPL/CDBJzDzaS66YAeA2fXj+QAgTebnspvJL47ohik9BF/qjsXUJfY/pPSfekWYOsOOypdsbKGCaom9UC58vGpFsU6bNtuERSAKdrz3WPNowb4RkHbEqtSv/re62TfV1XZblusiO1+/UJZEkiFNA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:41:41.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4887382-f423-4a7e-1424-08dee183ba69
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4097
X-Authority-Analysis: v=2.4 cv=V71NF+ni c=1 sm=1 tr=0 ts=6a55f64c cx=c_pps
 a=CFps2rDb9cXvy/q1LzOFGQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=JfrnYn6hAAAA:8 a=w1d2syhTAAAA:8 a=x0gKru99oAVqdSbF-1gA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: fvZmUNlEFMnyk6r1y58n_2M445linDOl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX+iOyt8F+qwqb
 SqJh2NeWOvt1ucaKDo2ZGdFI1uU1myRmV+57R/tQcLmp6Q5v0a5AmZLRfP15A2UOQvnp+adlXyM
 Viv7lRJfSDLzmo7IHSmh23ua0Jx5lIY=
X-Proofpoint-GUID: fvZmUNlEFMnyk6r1y58n_2M445linDOl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX2Eybs+IgzxZ3
 EmPcidtzunQeyZCS4FXxOTJOgshNQbJIHtcxqJn6QKCVqJTkc2Edr03/PUWI6viuWgNJ4uEDY47
 36B/X2TQzvS4YUNDOWjjjaEByAMqbKntg77qqJBOV/25rO8jT+dt4Xeuh1FdX//ls3TRLavsVDS
 31THh8hhp1s3fYjnLZr1xnHjPdZexrZO8PRKgjC6fr2IBpiyTlmJuhDCPESjTWXr9VLNhMz0bnL
 8XVqh8+SLgvGvtQbHzfq/M1t1+sYQ/dc7c6h/5cdqUEOLZhIBn98gEVfwzXl27VWTTQRiJVS7xF
 up5rfFwjLNPiRqPMX3JohXf61GQBDwqmkc5xFAwoVH7vKcLNZuUQWeGCZh1zCIkYu13URbTLFWr
 DT4B6ckXC80m8oAFviJU64syZKczIdNJSydZz3T85RER7xGfwgoEu/D8UEwNPd/bHx58QNxr02C
 Zp/Yl+WnBHIuh8BBkBw==
X-Proofpoint-Spam-Reason: safe

On Mon, Jul 13, 2026 at 06:44:45PM -0700, Randy Dunlap wrote:
> Modify these errant comments to use "/*" since they are not kernel-doc
> comments.
> 
> Warning: include/sound/wm8904.h:119 This comment starts with '/**', but isn't a kernel-doc comment.
>  * DRC configurations are specified with a label and a set of register
> Warning: ../include/sound/wm8904.h:134 This comment starts with '/**', but isn't a kernel-doc comment.
>  * ReTune Mobile configurations are specified with a label, sample
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

