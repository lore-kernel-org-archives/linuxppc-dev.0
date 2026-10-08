Return-Path: <linuxppc-dev+bounces-29055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D54CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 11:01:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0n9m5ycfz30Wg;
	Thu, 08 Oct 2026 22:01:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=67.231.149.25 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791457292;
	cv=pass; b=h9XSVutt5J8PDmKS+tBT8zFq3O1CK2xFAS1vsLK7uVBss4mjiAVynIAhCmVebaZyeOVQA8mKBHrr8POM86aDqVfWtNlrPEetCtePQAbD2JSdRTVGrPH6z1LGEaJsTJP86AVEpBDCkiG9pIvuMI4UfDbfb6sJz+1V/knOHhLEmJHKlLSz7awRn8ZLxalCr+51jMlcylZZGjlMUOsF+Zc1vkYo6kGjb4m5zhylQPJQ5Z6k2DBGVj5i5PmtUfS94MpsNr4L+5IeRFHPT7weHej0Lqo17qBcIRyg0UqSTFDD2qYhaRKP2SaGP07+5XC3rruA2/evhcCnJEN2CSocrJW2dA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791457292; c=relaxed/relaxed;
	bh=A8bPMKXXoUVyRRMnKTARsrth0mIRixkcOPSVQZW2AV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS59ec42YiZZ+DZwFsHcUiDx8Cj+yhMLG+8XCvlYHxISadum0j6NFO2qhyyGxFTvg/WZBz75i2ldLVCDOPMf3bE25AEG0mAaY5mc02OpADLQWtpKW0bVENEdiRDMyvotjty/zGTt7i4G7MoPj/EA6QBAucFmNe3GVzUap8zcYbZViwjPB+pI3V6iQTAP3llOoaPGu+urkRowTL1zdjtbZ7xKq6sHjvLDA+3EZg8ybHUYYPtCai56TPIUU9fa1QuYpIKLSnKn+P5dxPq0htK4jIhS2N2tOfutrYqpRSou0uZAm+ArDjXvn16eXBk0ixo3mglZ9DISjix4fncwMIWQKw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=Y+wTAur2; dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=nYT29qJD; dkim-atps=neutral; spf=pass (client-ip=67.231.149.25; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=1741304ba8=rf@opensource.cirrus.com; receiver=lists.ozlabs.org) smtp.mailfrom=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=Y+wTAur2;
	dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=nYT29qJD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.cirrus.com (client-ip=67.231.149.25; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=1741304ba8=rf@opensource.cirrus.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 781 seconds by postgrey-1.37 at boromir; Thu, 08 Oct 2026 22:01:30 AEDT
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0n9k534Zz30Wd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 22:01:30 +1100 (AEDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6986hBB52833491;
	Thu, 8 Oct 2026 05:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=A8bPMKXXoUVyRRMnKTARsrth0mIRixkcOPSVQZW2AV8=; b=
	Y+wTAur259muS2CcVjSv+usgAF1Wxemv13sHYAM/udHJ1Q+eTwJ6nIq4/7FhTytG
	D57AKFtcfvI6yy17n+8gM1tzqIHh2N/GPpQPuN7ezW3Uy+MDqmduqBfp+BxHE0J3
	HbpcGwg8xFYAIMjFmPomI3In6C3T6Tcv+3BRrbTZjifiyAWELcERi/syIeM2lqJq
	+9ZaCc7AlHQfWxmJ/YjZdE2kmP1aaqQvHx2vKSJy3mFuJYFZAWBXDe1CgziHkDCM
	5gh9054pWC2t9f4ivyOf9EkVgdHgfHdCgY6EwxaHTFpxlhZDE1psbv1TlskCEuyj
	wxr121o7fNs5R74FH9if9Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021131.outbound.protection.outlook.com [40.93.194.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4h5xdagpmy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 05:47:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Wmr9aO5xzcUDP2/yW7nf2gPQ83lFyhyPhzK7gMugiAK17Bqo+xvo481qN9RkDXFPHVlQKiKSjBjTZQFfICX+G/2NTuwwiNJWOYXjpLI0q+X6nF6KO/x78VHqFaZelKpb8cpwfRLsmBflJWbXu+2txApr4T5JN/MHCayDBKO11OBqGHaTLebnRp9/IL2p0zBWouf0QiT2p+u5w3DTk4c7NKLWs1viPsEzM3/slvxR2nDJUMJ/YTCPx0Ey7XGPGXTwcYQHidLQDqNL5IqkR3oQDZvdmByIvF0y5ulX+VUWxY0P1yObBzt1Zu+OJTaleCLghI73kzNmpATew1US10yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8bPMKXXoUVyRRMnKTARsrth0mIRixkcOPSVQZW2AV8=;
 b=FSxnrGvaf9ZvCD1v58MMo5MR/ZMh9tS423YN4kXKniR5zSSaiGjMu9Vn1j3C8ldXDA+yQEuYRIIsPW5bPnSMF1cSYFNsthq/J2SArmlOnzxRrJnA0A/16kMCtKQFi5mGIcJNXBzaT3i0x2mzqIA/wYYxl+lxNLCb+89UCchETFOdCnvHn0bcbdLa0yiyo1cu/9yeMs3ptrAaXoAhVXw0zRzUmFh8PBsh6ybMHrvcYOoerU3E1OLteBnqBC81QUfYOLf9vuHhxRHXPcEZj1vJaZAPiQcu0YcXaaA4LNalGub3/juHvS8Y321nBO4IBDxT1K01ehDRR3TGzyVGA3I+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=amd.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8bPMKXXoUVyRRMnKTARsrth0mIRixkcOPSVQZW2AV8=;
 b=nYT29qJDNCPcUgiRVJxhf5iJ9/0om/uobx7I0aymKwOJfeDU9lSyvCkZQ7l3AxAkAGcBqeTMQpWjCsOd1PskRy8LxkKAxwzWzVGRVskA84pw/twImMvwvrZQW+PdAp9MuTxhHxYCSVgntVvHOdYr4+UlzLJyfrvzLoRAouuiMFw=
Received: from CH2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:610:5b::34)
 by SA0PR19MB4190.namprd19.prod.outlook.com (2603:10b6:806:87::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 10:47:22 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::7a) by CH2PR07CA0060.outlook.office365.com
 (2603:10b6:610:5b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 10:47:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.14
 via Frontend Transport; Thu, 8 Oct 2026 10:47:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E71CE406544;
	Thu,  8 Oct 2026 10:47:20 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B911B82024B;
	Thu,  8 Oct 2026 10:47:20 +0000 (UTC)
Message-ID: <fc7d2b73-e0a4-4a36-b6d4-8080ebb883f7@opensource.cirrus.com>
Date: Thu, 8 Oct 2026 11:47:20 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] ASoC: codecs: cs42l42: Ensure the DAI is marked as
 started on success
To: phucduc.bui@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrei Simion <andrei.simion@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>, Syed Saba Kareem <syed.sabakareem@amd.com>,
        wangdicheng <wangdicheng@kylinos.cn>,
        Chris Bainbridge <chris.bainbridge@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Neo Chang <YLCHANG2@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        u.kleine-koenig@baylibre.com, Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Hemanth Selam <hemanth.selam@gmail.com>,
        Md Shofiqul Islam <shofiqtest@gmail.com>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Zain Aboobacker <zainaboobacker33@gmail.com>,
        Sang-Heon Jeon <ekffu200098@gmail.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
        Bo Shen <voice.shen@atmel.com>, Vinod Koul <vkoul@kernel.org>,
        linux-sound@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com,
        linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
        linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
 <20261008103831.542533-11-phucduc.bui@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20261008103831.542533-11-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA0PR19MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: fee34c9c-3c0b-44c8-5d07-08df25298880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|7416014|376014|82310400026|23010399003|921020|4143699003|56012099006|11063799006|10067099003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nkFKTZiaaxNZ7xWIgXffBIJcYjXa3CmJE1Ub25UpI1q/MOPSqInEAbGS4ABjPPEtyme4YRxkOux8FNbjEJhS13ivLbdSKd5LZsksZsHYu1h9S3QLTCQakivs1s2KMWNk95Mg7TWgm67BGtdf8L7EUWuBFzh7RWwmbglXldIGCyPoQKaeDX9iEu23hATWL+mm9SKuaS97FEoBoL+6DuWlt4VmaMT8KlaVSgnMXknD7G8V8azgGibTtZgKPCRULThhdjsZJTcDGmdlXBAUjcuwnHcJstL/5xAPlCDQFuS8EUZDcwHfTOzMVKiuEKaz3U+y9BlNYDLTOodVewVMOVqsyPQhz82n5d6yk4FKX6L5tfh6tXGvUkKl9i1EtUMIHS40JhDnT74ieSORwof0SeLWM3UBr9/2WilnkxV4MVLqWqVYq3qzmNdYpRM2EshMqA3DBKHOdObyX40X1mgG/sYfbZHCr5SvhXMKJH2EzPJqrG1pglDYKKme2DmhRQK5veqoSzcoKebqBHMvc4XnEE9PMVtaJdTjSOrM0rIDwPGgnBVY0QAkltcrP2pr1APSwt4oSwyNls0qyXdkwKIIDcI41fBBtSFpml54CTxFFCzfSIzcPvXcnFJHcmTRkbqfHdtAngf8+6+AMLqibkA/7ednJ8+IQ4wO9R0gJ2SJR6NXOLHPFuiwGJ1MplA30GmJ/mOzjpJytwhkzVvSOMLLF1FLT7kirFc0EapDP5ghKyMvtXTWgCiEFNQQxZpLE0CGGZYC
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(7416014)(376014)(82310400026)(23010399003)(921020)(4143699003)(56012099006)(11063799006)(10067099003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PBe+T2ZEkoYeSHCWmlw0UQAiLGFHwVsI0xsuCNdDF3b/ZOrF1wS7uiavppTyYB9iKPJgDYaVEfEYfxx9RKJeo3AJ/ip/pgIdWVrHFrhRB3yQfrWIsEfJBhC6ZzQh0djfYIqA0vsMowM9kvWypomMiYDhr/gAaVKEaPGjrTWsIWshfTBswWbfpNSz3cpjPRnQEnWSe5e9MKvdCN2KAWaDR6rqviRp6+/NydXimS7mitPkXrR4wqUdEFpk/VkWc7XD6M5bjJN6bjKC+f0v3OBNRMw3j2wqv1sOaWnDXRFvsz/ThVrhf2a4/YUAF1L7jfr5FDPsXdOtoazxmZbwpfhUQh/eSlT3X+fxwlogTQV9Lis+UqnS5ggLdEFJjKBdZv5oEzQCQ4m9Qfox40f2sJAxejDqCLU3zClnhaNbdmi/hT/JncuPqNGOvIrd7HdO8iBB
X-Exchange-RoutingPolicyChecked:
	t/mJeDsSAX+hZb5eSoXHv38iF3dKjiMSkYdIORoHB2N8Xq2quy741cWD+OTZVi3HeNqU5Gpn4gsbPs2Etiix5szxge1KDtUvFx4dspVoGJWFFzmTHhRAUROBX0ja6w5ERyZ3SrAtba38NPk2VMVrwQ+fTDHqWyE5odUow+od5gSo+Wb4BOSzaiFb7O46toQxqhCXD8LXF1zyPULT9y3h7uC1A87QdDwW4/X+cXxAMvDId7BTMCkCAzavxmOsJ+F6kHb/1tYxPmzqDHsQO++HQMiAYqlkkoS8Dy/INTAEDRX4gTuw1XSvBMtwNZxxYbCunEFvX+9ZQBdSF+N27ZdKtA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:47:22.2052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee34c9c-3c0b-44c8-5d07-08df25298880
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4190
X-Proofpoint-GUID: Tu_XbspTBko2DPZX-MnYNNGMtZHGjeoS
X-Authority-Analysis: v=2.4 cv=es1KXYpX c=1 sm=1 tr=0 ts=6ac774be cx=c_pps
 a=p09nrIMaU8oQorgrX9pGYA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=a81USf9_NmXag9WO:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22
 a=Dj2-6B8FqX4mGL0U3gbX:22 a=pGLkceISAAAA:8 a=KS_8xAV4BarEr0G-hnMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Tu_XbspTBko2DPZX-MnYNNGMtZHGjeoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MiBTYWx0ZWRfXz8VyN0pPA5xb
 bJtsWc+nNmTUwfnM+CGMooVBxbYaQJV2M6Rivqy/qiloj8fVP6GwP1WX88t66ydSE4q5cKUheDr
 6HotsHS9kKl6eDUWSFCBhWV5pcg5jT5t4UDO8/SGjUyfR1okUz0oXZxkptzH53/hmPqZxvu+xb3
 5D7wYvoIUctOFkSdRIBwb0KW2YDuXsF8Vjb/zIRiXqkRJWzgdpJwfirg1yEuETy+Ga2dtU68bhL
 7vIwn83PUhhosxGlFQL2dWENDwakXbVAMFQ8sIgf6C9icl90lBRWUY7j3qfoLktqicHJVlK07Aj
 Z4M/JbhlK9jDYNp9DbG8LYeDC0Emn8+0V10oZjb+GSS8SGQqO/5Mft5Wu+HVBmSJbEIPzWhdQAd
 sYPQV+FBYB49ewjCZ8o7LSU/F4DwrZjk4SF0Y0m90DVbCWeDRYxxED8LDb3B1KhxeOU0rne64DQ
 lkFXLmMJqOY1VkUiblQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MiBTYWx0ZWRfX2NHUAcPhx5py
 dqIWgpQAJmTWo4FOVvF64U9bDz15m2iIOhpOk7OIHjmKi4WcjRWGgf394Dvgq9YTNhO3++eiEw0
 0vM4qZCE5kNWxnGMoGhvwxw4/GVOiHU=
X-Proofpoint-Spam-Reason: safe

On 08/10/2026 11:38 am, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> snd_pcm_hw_constraint_minmax() may return 1, which is then returned
> from cs42l42_dai_startup(). ASoC only marks the DAI as started when
> .startup() returns 0.
Is there any reason why we can't change ASoC to mark the DAI as started
if return is not an error?


int snd_soc_dai_startup(struct snd_soc_dai *dai,
			struct snd_pcm_substream *substream)
{
<SNIP>

	if (ret < 0)
		soc_dai_ret(dai, ret);

	soc_dai_mark_push(dai, substream, startup);

	return soc_dai_ret(dai, 0);
}

