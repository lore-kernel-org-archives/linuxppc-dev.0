Return-Path: <linuxppc-dev+bounces-16643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1635DECD9B7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:47:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6cRL2gWPz30Sv;
	Fri, 06 Feb 2026 12:47:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770342462;
	cv=pass; b=Sg7QnvSdKKwDQRDVcHazl/5PbxHSnj49p1G18EEh52IFpuBCikMYlGwBAi/Nf29NgQNquHTtDo2b10Che9u9qdcVVFpzqv+AkGa/SqSFtZysPM/SjoSVQPJPflFOyqy6iVpq1JfdxC/Q63Ta1ND7NcWmB5EjJJjOzgw+7YOtIyBqeEciWVJwOPF4JEkdSj8JniYUjMghOA1aqSYy3E0GXFBRAQSJkrieCOt+p1qijVuSzcS5rYh9aMnra6UO1qFkVFrDMf9LNc4mdDeO3EUtrkKO6SnipIXxh7kBm5tvoPiOivQZQ559TEVZoDDGSYezq8SD3lWTf2378ViuNhO9/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770342462; c=relaxed/relaxed;
	bh=nNXdQu7qKQibZxnaHuOS3FriVHNa4qDe1PvKS2UOwyg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXF7tsEgjkKuIXSR22m5dFT/NENKA9lBJlNozipS2rtfJ0wG0GlqQjocRqxgB/HHkN6drUAlTYOBJq7arSXt/0eWlRuL2UecPdWvN5CQihV6uSLNHCz/fQPmwvYl6/dLKlFunFfsToQwzHG6fcF/cyZKw9TTXZTg4QkWDTpziI72ar1N0pAtfwJd4zDUIBehGlmIP4BM92B1bs0sJsyDEIq+xg6YH+BPIVK1lrMTU90ZYu8At0rp49bv1U9l4swNEGlsUCprpJo+D1cjMyJAz1n1KArDcr91Ew2dA1eVuJQbHCp/duoLWT+M8Edn8womFbqvICtGdcYEqFPu4b63qg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cLYqyQid; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cLYqyQid;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6cRK4wy4z30FF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 12:47:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVpZsGeXpcv0JrSkmRiZJFryey0wLms4ALf/AjcA4aKra9myymGT/h9TD+Nbdk7hQo2CzodMSECxxLaJBpyvANPTsY7zTzuSUmp/1z839/G97dkuAMfCg4zuHUpYgP3C1p2Vq904SlyXt/VH6EONJOMHb5puhgLEcj7wcxOu4WW7WFexdGTFOAP1ZNq/otCET1UTEJgOCJejn9A+tAJmHVVGHitUH2nnAgUpKGOkxL1ILswdj3scLlrRmXyw9VoeIsa0Gpiz1ziVFv5/SaWyCRIUd7sfgyOyU0YIZQSRyxr+mKfqer5KOmf8gva7oMIkKuzFDzGICQK2mKUmP1A3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNXdQu7qKQibZxnaHuOS3FriVHNa4qDe1PvKS2UOwyg=;
 b=HpcIEauc/syGDbjyMa+y+g4mJ9kgs8NwCw3RQG/8hvHUukdehBKtg0qP/W4B3atLARQS1m8UxJF92Ox8CPr40GoUBG2gJpuRX4rBPLUrEZRhrYaaLwrPeEYUlp2k5WAOQujoXoGxS+VVdbtwIy/goQt98xDlOZKxI4JcnhK/JZM7nWLl12W4xi+SsaMa+MtK+JbVGuyysy0jvzhshPxHl4VxWYjrVpxFNkyn4zu99E0AWRYgTvCYtgKQ9/IVFsQcTymtg+794IzFarm06sG3ki8mpN4cYUcsBoGSOnDcEd6BTTgw7NBSG5zEtA5QPDuJRHw5NVQM9WPIeDDToIVbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNXdQu7qKQibZxnaHuOS3FriVHNa4qDe1PvKS2UOwyg=;
 b=cLYqyQidJbGo+4KJKg4FtCCEpcHTAxnw04WMkGWpmHZIKMW1v4gdQhRHns4hROxBbI/X3n1vFADacy9T0K7s705sDvsvyk6uwoYu2eRe7fBJZvUQ8ukVHPddse6paPAC/YSexY4VpYWEw1BT6Mweg4XSMXK1sh4m15NrUqp5ua94Gn2jxEfwOivU+m9mfO9HRQ0uuMTrnFv/GMj1O022MLRrB6fSIC78YvnLGWrYhrraswmCXvMskuq8SulquWQhXmLqDd5A7eggPIy2iI7ppnNCi+8emUtbt4XQXRGu0LIaI8TJxE7UCoiJmsiYFWWWD0ntdBvI9MnfRyLEidsuVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by VI0PR04MB12210.eurprd04.prod.outlook.com (2603:10a6:800:335::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 01:47:14 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%7]) with mapi id 15.20.9564.014; Fri, 6 Feb 2026
 01:47:14 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/4] ASoC: dt-bindings: fsl,imx-asrc: Add support for i.MX952 platform
Date: Fri,  6 Feb 2026 09:48:02 +0800
Message-Id: <20260206014805.3897764-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260206014805.3897764-1-shengjiu.wang@nxp.com>
References: <20260206014805.3897764-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|VI0PR04MB12210:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fee8aa-975e-40bc-92c2-08de6521a6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nENX8HbkVUR4oC/YCVFuAPHHsZVn9gq667FpKoxsjCNjR2e7Ms4ACpqhJQ83?=
 =?us-ascii?Q?uuTi18FM2i25JnyGIjpLXFUooOHQZgfvnSZWt2VKMSBMkqpwWbk4InR6vuM9?=
 =?us-ascii?Q?ys8edmwf1oWT4YGdwKHNmrDEbucHQprdaDE/FnqhDQBw3+Cz5B7sn+rv2Ee+?=
 =?us-ascii?Q?0jQxVccblmN3pGOO2F8zcyeg28Acror/QylxAZKklUADXTgSbPBqixR7ZqlS?=
 =?us-ascii?Q?QrT6GvO0rD49qMy6m563Hr5qTG9tm1obv1tKYTsOZ4013IuGbcH4NoY00s4S?=
 =?us-ascii?Q?Jsol71uKGYYSqAnSdErNC2Y33smtx1xlxXjqxHfkhjj3kHCMwYQa+AFZACwK?=
 =?us-ascii?Q?N2INS29xbJAKkA9NXrZFt9lNcc+zc83VE+nFwmH0Y937Q6IGPV/gECR1NJSq?=
 =?us-ascii?Q?hKOTN39Xk3F3YcoVypbuvI2NTNfIpSwnsbH8m3CnzBVqK6VwiG/ev0w7tbd0?=
 =?us-ascii?Q?BFs94HMLVyRITYVm3rBtUX29m+NIH9y16ZKxfw0+xNejbkvhlSMyXWgI0SZ8?=
 =?us-ascii?Q?7vm2+CAinU5HZxAaggTA44+W4U72qR+BIqBYLMTEGPqhUmJLJKIVbXYyuk32?=
 =?us-ascii?Q?1gUYchD8dQ/laI4llNvTa34qDWPDaWgc5AXbNx5XgzWIOnTAfZdc3Eeh0jaa?=
 =?us-ascii?Q?QqQWSqwC+Q40uS0X4UUSLXhdE2oWxBJ32wmfp9vz+Ut8wiy6HSMQTnWCz46L?=
 =?us-ascii?Q?WY4xP7aAGJZldm6SeC9FTT90M0Wg3vbIVmOO7DEa6G2jKkBNBtSwZmx3EWH3?=
 =?us-ascii?Q?hO3xxYQoqAuxUOgpNCI1L0J0H4kWchJ8Agyq2KMFkCzobVlxaBEF+t8RD7uE?=
 =?us-ascii?Q?ySd6G4AHD7lXyRLpAejXX/oDZIyPANQqIj4k8DZe5LioCCHVUve68STTEiuE?=
 =?us-ascii?Q?dxY1TrmyGgNg3GTa0KLktojOanAWTXcM3qgXufnCzehXvad3Os4P0BTx8yE2?=
 =?us-ascii?Q?JJbu+cKzVia0hp5Re5r0M4vO4KmifoOEg/riU7V3gpmtc0SWXhVUKJDYNmH3?=
 =?us-ascii?Q?GaKWsJVab3mkGZxBZvLa8iWhytvI7prjWrAqDp99kARhGw3i32T8h51tCivl?=
 =?us-ascii?Q?K3pzwwapXjMoqYavwxGUy6NmuxkruU2AufGfjnHMXWygdpi1pOK0e5sIORBQ?=
 =?us-ascii?Q?XAEiIvStUtDF5xftcgJBcvcS404fQeUbnrbpL2UoF7OSMquMOWhhCDUoegYo?=
 =?us-ascii?Q?oqOj0UUUYehXGdc4mVkz/SoYgE3BdQtiy16fuvkF3txIEKTAO4U4uU/mFDhd?=
 =?us-ascii?Q?rWMlaaLglqDD1TGoiBMRRHempAC4VbSNBZfEvB2fm0g7ME+yhtP5xKaWwMI4?=
 =?us-ascii?Q?rJb4X7nGTzUMZ8ohMIZ8ouDR6P081PjkN8pNzzHNHuEV/Uv90blrYlHKbldM?=
 =?us-ascii?Q?zp3m++sQaTGfPqBlEvUWQohn7p2W237wBeifeV9UlYVpNAhMDfMCXPedibeb?=
 =?us-ascii?Q?QfONRpjxu63PVLhrp/FlKkgEBBeVFjed6vIoJWz6Hf41UGe4KvjxPUV+fhBO?=
 =?us-ascii?Q?Pi4rqozk12fVB5AqAXHIcThWViyK7RIR0jbqWxxIDGkGUQujWSwwvqH8rqCL?=
 =?us-ascii?Q?MHYRtTYYdYhSJckgXXOc/W1vVvMv1J5OK+qAAX1+VzyaZ2tRM9vO8FnEhu/4?=
 =?us-ascii?Q?BOCejB7K30GRMJ5s+GUsOjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/m7OAefHH55v//cz+19UxRdnpS2bDqhC/FGOdQDPiaE010bXQTBIoHgWZVmC?=
 =?us-ascii?Q?4sLGS+8HLuNfLaSjX4D5LY6n2a9QoWFemNoSFTfuVesmnEvPHJa7zkPGLkDk?=
 =?us-ascii?Q?7oxiSJhmmRODA11Pw6TfHZJBJi5hGHYtb1UDt1jOdkNCpSOf3edF7t9x9rsb?=
 =?us-ascii?Q?K99GHOBfn6A4fQ95xR5GBhZC16QzOwDICfWxXzU6dlLVzhqzyOf0gVDr6lX1?=
 =?us-ascii?Q?RJ5neED3/LVM1Q98I4qBtphRwhpnFMtiAvmj1bcnE5Z9KAZr7XF6A3zCeBP9?=
 =?us-ascii?Q?1vykut1t+DvMavpl7FFBrsO5OiKuCAxTaXL2+Jgv8kVUCKuSa75LTnfgBp6G?=
 =?us-ascii?Q?vO+4Ifu3/dKNPz/5IWuwlsupvoeTbR22a5/JqmKeAOPvdsmGseRxbzdAa3kY?=
 =?us-ascii?Q?DevVuGUtpugpnPmQrv4unPG2k7m5H0c+HhFgJ4BR0guJc/cncpWmPFyh80vB?=
 =?us-ascii?Q?tkkjNLK19ALZsxKbY5fLTaK+FZO66WN/KAj3Yfpycc9e+VXzq6fBWQ8mwGNN?=
 =?us-ascii?Q?DBASWj2ugTnazNb8HUVFvZ3yuQVgJdf2Lh+Xpsv4fssAimJOIgSaxZbkAL2G?=
 =?us-ascii?Q?BEn77RnMy3uzpLhxse5VIs6DKrmQF6LL3x+DIQKJqnlvweU2qA3Emls8UXSR?=
 =?us-ascii?Q?9tpfdN+dYOS4i4Pdr4TOAONZzABRiYLEWPfEvTA+kuFGmpMnrwUoz9ISuDbC?=
 =?us-ascii?Q?FJ++tXL9MCzPBVMw5fTbe/MjP/4K9+P6rP3hGOxFHsrz4Nf4PyyRALv3B3Gx?=
 =?us-ascii?Q?TOMhNSDXXquh4Et70fduz63CHbyNxZmH771zIy9PYE+5FzAfsCURujGM8slt?=
 =?us-ascii?Q?i5/rTq6JmZSP/iDZnHTE1a+4TaWeJTBalzehZnI2rYq0qmePYBKYdCUqgkpe?=
 =?us-ascii?Q?z6zWhk+wVOODSW1NXMFtYxjkOTy/037wK5Xa5JUsjppzKm/xmyjWOs/QpTqi?=
 =?us-ascii?Q?sZY1HdilryKPRKSnUvyrb7Y/ycY8ZRplQrF9JIJLZKvnTkP/wxJRxS6JO/ni?=
 =?us-ascii?Q?nfihdpJB2y2Ex3We7DCHdGv9N1yngSNYHf71nAE7n/6uCMaW2ywHBJ6nNMkd?=
 =?us-ascii?Q?Jp8c7fTQmxwxy3VPr2JpLH6NS5DCbAf6IU+VTwL3tV5GXnTE8+Rm8fmafyNW?=
 =?us-ascii?Q?1Q2ObMhUMzpjzn/qKBjdq1o3YfIyDLS5LCTm5sHRWDKLvADocXiA0rQGzPVw?=
 =?us-ascii?Q?OA05P/apPtbcJ7ff5JwioiKXh/I1lzn+66lyM6Mn5YrQi8s/Hj0iC/gLKhDC?=
 =?us-ascii?Q?E4OR5RItGhI6b2tQS4FmUY6WNrYT3ouh8cG4b05Rz0CsUqsGBfzzrLQQCymu?=
 =?us-ascii?Q?vWfKrI1bJMdJobMwnzrJXQzJy6UA24YRQ3x+45hEadGPRFNfMZv/jvkybXww?=
 =?us-ascii?Q?UqvEfBsc+eMkELqwHYGJ6ZafZEXfl8ichmY+INjROUJI5z2spr8LHBYVYWBL?=
 =?us-ascii?Q?hCF3LffyPn16hW0s8dVjPF2OvbtyTXj4ckXwUAQxU7O1HudHNV4PPgDDgLC2?=
 =?us-ascii?Q?kTK+X9acicRHlC2fCBzQ1WwZHlOPg4ZAj8rtFUKK5mCE06YwNgNoVZEE6EGa?=
 =?us-ascii?Q?JpVZ9QqePfjLDMvRCpq+oeoWmCwtiBQak2HhMjD68rXpUlip5wnc6LBxAONJ?=
 =?us-ascii?Q?V9BdXyAEEknHBpL6TRFiaGNE5OrVMxZBgWJoA6na0Q0DfkLDn5UszQ+XX064?=
 =?us-ascii?Q?TOtWhYFOGbpgZ0YyExNnf+CTnFDSkZiEqh2CvRVOBhjcxO4d10ZpxX0wRD0n?=
 =?us-ascii?Q?QgVMIiMKOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fee8aa-975e-40bc-92c2-08de6521a6de
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:47:14.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rLl7QRRmV+RM8+VO5nNzKwEhnZZKmHRtH/jdK/xuQWRV3IHZKKoNjbM0xxLTyYlY4oc3tFq4SUSaCzsfhdTMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12210

Add new compatible string 'fsl,imx952-asrc' for i.MX952 platform,
below are the differences that make this ASRC not fallback compatible
with other platforms.

1) There is a power domain on i.MX952 for the wakeupmix system where
ASRC is in. But it is enabled by default, ASRC device don't need
to enable it, so it is optional for i.MX952.
2) The clock sources of ASRC are different on i.MX952.
3) There is a limitation on i.MX952 that DMA request is not cleared at the
end of conversion with dma slave mode. Which causes sample is dropped from
the input fifo on the second time if DMA is triggered before the client
device and DMA may copy wrong data from output fifo as the output fifo is
not ready in the beginning. So there is specially handling in the driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index c9152bac7421..608defc93c1e 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -25,6 +25,7 @@ properties:
           - fsl,imx53-asrc
           - fsl,imx8qm-asrc
           - fsl,imx8qxp-asrc
+          - fsl,imx952-asrc
       - items:
           - enum:
               - fsl,imx6sx-asrc
-- 
2.34.1


