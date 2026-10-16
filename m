Return-Path: <linuxppc-dev+bounces-29593-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8630CCA462
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 09:51:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5gFT1Zzrz2yVM;
	Fri, 16 Oct 2026 20:51:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=67.231.152.168 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792144301;
	cv=pass; b=OKFo51LNrfAz9/f6xmU4fEulX1O/tOAtCN5t/xkqHikFU2v4CXsFJq8GkT9dlPod+xFP9H16QZpZGvrWIcBaU4R3mDmtMSm/dh+B3xHZ+gXi6zL9KD9lzke2eZwikRP4ql49tsbPLhZLJlWjc1OBY4yEyqpLDJRqmdsGJnLshF0mhVK34YUXsCkbhzp+Bebdt1N9Xx/Keigv20vA6BSQY3RvbSLIUWV4CBVBgUTRiED1Y5hx0J5sQ/DQNeNoSgBvGYGXrGkN77tSJKVtyjd6nN0YtYxajx43lso2VWlS30BsUt1fnzgTEfitZ47p5FLX/gm8xY2VuHaezwbSDzAGNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792144301; c=relaxed/relaxed;
	bh=nZXiGlWdDFGO0cC6N4MG6NRpfeJx2kG0/b8ROZ4+Y8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDApcClNZz0pI2KhOVP2Wqxsbb/fI2nCZ0t39PnusrUA3rqs4WOYjA/shdTj9i77i3NuwF74d1807DSUiH6dbREx7QnF9rs7QNJLVxVcbL1PmFIlLPRfhIUc1NayOlOqCZ7VDVbM1pXnSS+G1ICcR3o5d0SeRYrlz29ILGOriF/PGkWLpQ5Sl8LoKZDTG3l2z3bkBod6S19gHZQ7lmHnecItF7AjeTuGS6aKJ5/MMdtqM9iQnkKXQNF3ZQzIksgfLypdb6S5oqC2sYiXTG7N9DIwlX0SMZ8UzFRlqgmb0ebVHf2FotzjZokfCFmnuh8uSXvsHTq/z/49W4nkrZipLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=dWIA+cT9; dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=sPFl3/Jr; dkim-atps=neutral; spf=pass (client-ip=67.231.152.168; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=1749a0af03=ckeepax@opensource.cirrus.com; receiver=lists.ozlabs.org) smtp.mailfrom=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=dWIA+cT9;
	dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=sPFl3/Jr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.cirrus.com (client-ip=67.231.152.168; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=1749a0af03=ckeepax@opensource.cirrus.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1863 seconds by postgrey-1.37 at boromir; Fri, 16 Oct 2026 20:51:39 AEDT
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5gFR5CHqz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 20:51:38 +1100 (AEDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7kQNs978390;
	Fri, 16 Oct 2026 04:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=nZXiGlWdDFGO0cC6N4
	MG6NRpfeJx2kG0/b8ROZ4+Y8Q=; b=dWIA+cT9cIdrgGf+sdMrfpf9sf9FTSV5GA
	7acETkgjzmKBciOz9DDn9BsuUb80+gjfJmay8P8JXq7ysfHbVZOglNaVYESCvmmz
	weCuNRDXY2ciewY+8Ea8NJDA+Lk5o8ga2p3ur3Hz1j5gXuR+mM051vBRGTkGauwx
	3MA1W1ag34aMzHgCSJVio38+9ZhSEHxEc0+p/8bbdxtZhBGovb0v54kXrDr2t0wL
	xtFaqJfNUt1yYRON78gBjbuV0/xOY74mjDLaUGVBX2swsutlN8F/B8jNnVBvDVdE
	wLVHrnOr6HwpVkAdpCiRfB0iu0oOFAAipmgVkA97etC4uk2sa9mA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022081.outbound.protection.outlook.com [52.101.43.81])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hayq6hjsj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 04:19:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+C6LnzBWHt9SiqzhmTbXpBtJtamjeLogW8rpd2ac+IRfvfL/S+Tb5H4jTXJ7relmRceLsIWRN9+tFAI8Rtd6g8ip9B5PV2OlTJRzECt1sBiT/BgS2gRYfdQ4+5njQs/GNnKW3xgUwHlQ8NXRWaSFQePvwo5r/aQ2kBS/QfMRk99qBd2q1EiZwcQfXdM7bChDRZ0JNeF8IlfmPYrbUPDUO29TJnwjZIhIfGsm+YfNdW2AUs+xxlrcs9pUjAcRi5CHRG5A+d9g6WR/NA2mOiL/9yogchZiiSmFF3k/onZ7ZD47E3Y5YFizfgY0pRXbo46I85/6xezdXNM6Bvnv1RyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZXiGlWdDFGO0cC6N4MG6NRpfeJx2kG0/b8ROZ4+Y8Q=;
 b=xOHvuNU02w+akVJR4BV7Q5Gb4d8KS+zkZ6IGrLOy/wDzUg0hbcTON2iM8i+CIwIKQhl5GVSoov4Y6WHxMFN7IorLj0TCACmsGlHIiOCCwT/k2SXEPWPOiKJKFj9o5n4tHTfuVBWD6CgM+UKhY234VGxLKTHg7VxmYtE5VNSoRW4uc5H/E488oGHS4+QoHRilsY+6vyiMIxb1Wj6G0DzX+5y4p7sHr4D9Lr7/ax1v9VWOLt1YyLxn6S7Vr8XFQpUsBQwuncRZTA/8LsRGRhxCmq9arOIpPGcef1Qth4TAhcDiy76t8HYQ/coSRSKK2h2diU9VIk8euw+1BItDCOC0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=amd.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZXiGlWdDFGO0cC6N4MG6NRpfeJx2kG0/b8ROZ4+Y8Q=;
 b=sPFl3/JrQ2Byh2FntkMCf2rsqY5c3ks11KSibOAKnSueJkMyF34J2ayJ+BX+COubq4I+T53UcMYioSh526/zISfMuhUhrLddSR/j4nCODsRP87vjWSw/snNnrTRh3meg3CiXpDdfDzJt1GfJYug9a97vk9BdOjuuXDtLn5KX8/g=
Received: from CH2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:610:53::33)
 by PH7PR19MB6780.namprd19.prod.outlook.com (2603:10b6:510:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 09:19:30 +0000
Received: from CH01EPF000BE94E.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::6b) by CH2PR17CA0023.outlook.office365.com
 (2603:10b6:610:53::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:19:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH01EPF000BE94E.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 16 Oct 2026 09:19:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CA1F8406540;
	Fri, 16 Oct 2026 09:19:28 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A077F82024C;
	Fri, 16 Oct 2026 09:19:28 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:19:27 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: phucduc.bui@gmail.com
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrei Simion <andrei.simion@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
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
        Heiko Stuebner <heiko@sntech.de>, Kees Cook <kees@kernel.org>,
        Syed Saba Kareem <syed.sabakareem@amd.com>,
        wangdicheng <wangdicheng@kylinos.cn>,
        Chris Bainbridge <chris.bainbridge@gmail.com>,
        Linus Walleij <linusw@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        u.kleine-koenig@baylibre.com, Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Hemanth Selam <hemanth.selam@gmail.com>,
        Md Shofiqul Islam <shofiqtest@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zain Aboobacker <zainaboobacker33@gmail.com>,
        Sang-Heon Jeon <ekffu200098@gmail.com>, Bo Shen <voice.shen@atmel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] ASoC: codecs: Explain DAI startup return value
 handling
Message-ID: <atHsH/hROH3ZLB9/@opensource.cirrus.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
 <20261016040946.521195-5-phucduc.bui@gmail.com>
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
In-Reply-To: <20261016040946.521195-5-phucduc.bui@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94E:EE_|PH7PR19MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a80738-fa1a-4f53-12b3-08df2b66957e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|61400799027|23010399003|82310400026|36860700016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	KjRfL3CfSwVz2rjLtieUYlspkfyiRvQ1WDfEhgKRWvaPq4H9q1BTf0cgezzkOXgq1S5JCSdjvbs7MbXRJzZCr6Je32cgAaZN7PVJg1/PylLDqF2kCPy1T4eaDUbWRO5oIi68pD3BNRSrPCgqQzsUHz0o3ujVNmvTOCsUNb4vyn8rSzN3hWUIApzo1KzESpDeHHqUpTgTWt9QokUPy+nfDrDK1+/oN8iwuB51ghg/FAloVIA2Yx4X3IMa9RhCb3ExL3HBqarb/2Bf90gLMgvDlQn0jy2X4SPePRfrc3MxsCYRIZKihI9fmXmp4Z0JSDm3AEK2q7xbwt3AxVugtG25RfkUnyIf0JYhqsrYwC3SsapG0YuBz9a0FIo2UCKMubl1koBxMltFg3wIr8Z3OwrBHH9m8zfUlm2cOyvAQ5UHhPq2815nG5i1TKhY2pl9/qnPa8ir0c1PXdsu8YH6iY88E0KdzgvFEaza1k//MvmgflY02/da3lMurJlKfGJB9G2ii0qjpSK1hgle1ndFctDUsaW9iA9ccdrXzkjgf60+0DPQ7SqmrdK8VFxr7O4Y8Tz+EAMhQXN7mOQMsNB/Un6B5Um1aAy5VyYEKjwJy7uRePnrb6gQCzh76yfcuwxvueIcU83wLY6AziLxVNaxfQV/JeOm7hgNvhGEWK7E4uN1NLdNtEzjmppSyiPYTC0jpH7AM7DPUja7Q8qOgVKUhkIxNg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(61400799027)(23010399003)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OVV0HCsHQqHf+cmQN1jWpD46GKE9ZKXj5K8Dw+BjXmWaMOTRFEJosg6UHwGaUNgBvhvU9ArN16OWaeW+tgLew18Twl79GU+Cq6UcecMgKYx4/+QYzfv8kRC+og58F+sg8Gaq5sl/v2rReiGKF1xyIKG+w4U396EJFY5z0x4o5WTy4HMKFKqdmIzl8IQZBI/rlB5OywNs6009QZW93ivTxgUPGEMvQ87Y99zbuNZ+1sIyxzrgylhUKTNUAbEXjrb2iOD7kPUG+5YiAbCpuIVScZOF8x63FlaJ3kP6jrj4Dw9gCoNS0koSQ4oLdtUQ9BOjjOzB+v/rm644T7Qr3SWcoiyqwKwrUTU3PGpjk87QnRiyssGuxEJ9Y6jt6buvsqS23T01OZDWHabxxPpQxAbTafGgBA4+QyxoECp5HaPgN5FBo9xZaI3/vvp2PqoVHsIy
X-Exchange-RoutingPolicyChecked:
	GTnxfprXOYdrESJUMuhwAFynyEr4bpHlONTldlU1V6urFosYcW6kBPjpcfALTcQ3PwPp1LEj+7p9hN9EH5pK97QUl5vuRaKX1DNbq2VR0BIVKjVe6BUaNrNedYZwHYxgXn1ocdtYMF0osJbYftpc32sJYsA1wUC9BQMxHSefoGV0mGNjJpSIEYNj61nNIjUpTPaepOwCRmFe+yic8VQOnVnO9d7OtUiKvPTmmZfskYzGfPtoQg6JLREfkFBF0KkTnwdqHyu07k9rRA1bi7aIfN4pqRPZjRMxkNnJ7GXn08on8buG3UUHbD5Hoci2CUQMMSFa1L5dW6VVd9KmfwCgog==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:19:30.2505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a80738-fa1a-4f53-12b3-08df2b66957e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH01EPF000BE94E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6780
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX3dvDztCoZQTb
 si6vAWnkqDw/o0y35CjI5+jBViSBAVugXgzQz3jG7111yln1qnWd8BVo5gDaJZZeKJwAweXvvV8
 UhQc10Tg1osZehPxLNZ8AhMqzdiij94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXwbcponBJqNBo
 jvLIAGwiemafMiNkM4OjkFJ5Hh3zFsuKCAWYg7VkUYAE20SahIw8mWFlN5EFSAF4BHUU97nCQvs
 06otA5YOd8GnkPLbZ4QS7l0zh2p7EntfcuP9RbHv2kk9yxqPu6PsJbRLVHDwjRoR5Gd9JNNmVcB
 NpMp0ipvjvI0X9t3b9o6fdVwjevq+uQJnLXcVyPbN4W1+Rr4N0j3IQwITr6DYeoBL2mrSsi6QKb
 TGYfB70KQgtXtLscnpFJB1LPVRdTT7I2Wu0oR4ArbsRVBNkki2eNFpe0XVPSGaQbxCKc9MhxipZ
 9WoyK8rzcGmMDuv7Ob+4iwTfkxGnq5l9yPcVdCfgKtH2hGQkIBizarM6BpqZqnCQVSmc0BV7V8N
 EfsxqUtqWymIU1luacrIGsYOX4/1c83n4SG90YkUlWk0ZlTb4zuBC2vOkOKJAotOj3DLKDX/Ljw
 Xz8VEKHrxbsqzgMg3DA==
X-Proofpoint-GUID: fpQxPtWixqWOGLkIlaGJbsnQgF0B9u-6
X-Proofpoint-ORIG-GUID: fpQxPtWixqWOGLkIlaGJbsnQgF0B9u-6
X-Authority-Analysis: v=2.4 cv=UuX2pOwB c=1 sm=1 tr=0 ts=6ad1ec27 cx=c_pps
 a=hO11pga2tcgH964FPuxqBw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=nCq7GpDsCjV_zRYe78AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 16, 2026 at 11:09:39AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Add comments explaining why the .startup() callbacks must return
> 0 on success to ensure the DAI is correctly marked as started
> and prevent future changes from reintroducing the issue.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

