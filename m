Return-Path: <linuxppc-dev+bounces-27983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24816C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:29:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqTB31SBbz2ydN;
	Wed, 23 Sep 2026 17:29:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790148571;
	cv=pass; b=a1JOokCiZCet+tFkW1XHGUBTz9OLW8WemSTXogNsBBWx4ZWsJvbbh+kb/kDF+AXLzzIAC/RZkcnVHzF6CgzRNlOa4LNVtFl1DijVvq4V33yN731G4HSdGCOTT5sR0oBsQ+vR9YedYWX/puBjQpmiQtf/2UdhrnIpj0N3lIu1WHN9TMGHH1XxBso7/I5v6qIYpWLo4sNjhXpc3m0GQklFlKKNOd3032QIx9Jz1ZqhuLSwJxLP6wolvldLsZdav1mQC2/0adpQgfp0qNp/8oey3VJQadtnIa5fDulhQnm9hQMvUCxhh+nH5EqBxQDC3h/PPlE+0axmwlrY6tx0l7Q+0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790148571; c=relaxed/relaxed;
	bh=vdbG7NS2UUbrSfU7IzJGME+yOM9w0zAihcXyOin1D3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hw0ApBlTdwVMpxam+WtMaNMFX5q59qYFa5XbOFw+5IvugpK6oLhiZhF9FR7ludh7WVLJhvhIdxNiW1Tur/2ImyDABU8ioyDIC9xCvk0GaQvvfgkhs8zA10WK1RByeQk0oJ9/KwNhvwb31NBDDlGTHIu6cusaSeM/dDmsEdWAaEO8YggHnPi+CmD5kblzWqTKBm3T1EcdzhlNGvTbGrl4BEnfy/poXHigpsZA37EzovL0cajmxRqS83dQSpJJAW45qTmcFMyqm1v4KmVp/H8tkGnhEseY+c8y9y3eB7ZWh2pnUgYRBK8nPTruFlzng4ne+oa2q8Aixl/AYUCA8N77Aw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Fj2Vidr3; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Fj2Vidr3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqTB206HMz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 17:29:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwPDEkoDLGq3iAWtMdUQdEZfbAqXIZxyqwCbq7JeMbBau2hoJA+S6nTg4WjiZ+hhCy9WqoDgizjm8t/g/lTTRI5JMRaorEYNPdN+3XYsjZiH0mRgyqGH3FdfIJ42RRSEQVC+kRkM3odNLs5+YvcgRRDXaRPuC9ZyFcg8kKPUZ/tFSPMVvx/+eSq/0C0dTJJltUlqoL8kgIw/0S96CLTovhDKYhu03I3D3jWOzjbLPLxxodNlthrFtHjfMAYanawTV8OZiZO3niRdZY9M/yY4UTPB+WEoNdq+NE4uVqBvDM4Dedod2JJDSW1to0ZP2OV+0lACR7i5Bh+ZHCI08Bu/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdbG7NS2UUbrSfU7IzJGME+yOM9w0zAihcXyOin1D3k=;
 b=Py/gXELZZPujb8WvyOSojJi/IfEUcIQYK4UDNihNr9uT8WnuBG5wOCjAHmoDIsEdfx6JLShMq8wR98XiIdrR8SJC3XxutEr3FcCmPjbWDD95V0tYvGcxyCo5vjx2wv1TjeHM0upPcKlRBR3fRUIcokPWoY1p3aQh0WE7eq7U6eqN4Qk/JfCReUWULlDRBpezriSnbE+IOT/XHqmqQNhPo8q2oNaFK5r5bEr3dLnsM3iwWu8eECkj6ruS0BheQmOoG01aHJ/bcGFbPY7BW5nU7gQZEtkXK1Yjwi5nCpOVjbSRdJ0Nh9MHeom1jZqt9w1r5m83XtEmBPwwJzLPaMizRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdbG7NS2UUbrSfU7IzJGME+yOM9w0zAihcXyOin1D3k=;
 b=Fj2Vidr3Y74FUDXfvhcERSBJ+q8bf5CeWmeq/4xhK1NsZORa3uWisQkRMDuwz/0AwJ+tepkvZV0MyHtsprFYOepWdhTespgrSQO9nuJfmJF/h+cf4vTXIrjUEf2LbSX+n+wyTFUM6UvTdzpGVxFZDV5pt0Lsr8E6n+pv+4CiHan7+zIL+kYok4cU/53mAyRjB+D3i98/FKVH7BSB3RdjzS71zh+KNITj1cpH0svl2SccnOkTZbdyKv/UIu5HIJqc7SerRZN7nwD7INg3qa/To2y7H3zi0Wg5JrOCowWXoSqS5BoQvcT/h9axjhhii+X9UW6P2CMEQ3LUBh/uxjGqiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by AMDPR04MB11297.eurprd04.prod.outlook.com
 (2603:10a6:20b:6cb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 07:29:02 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 07:29:01 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@oss.nxp.com
Cc: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: use regmap_write_bits to update clock source registers
Date: Wed, 23 Sep 2026 16:28:54 +0900
Message-ID: <20260923072854.4096310-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260916094043.1496709-1-shengjiu.wang@oss.nxp.com>
References: <20260916094043.1496709-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0155.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::15) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|AMDPR04MB11297:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b12cab-9b24-4c69-e7f2-08df1944569e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|366016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I59VNcIYA9Smn/nYo2rx3jEOpxpqrdBXZVWMy8R/rHH3Cfb2/r3DjlVirqkMpmcczXxxAvrfCTzxHxp9l3McklJoiR7yeAx9sCBt2MrWs4kotO60E6syGmP0UjqvqSV8eN0rlyLWZIt7aboA4FWLPsMv1DubNeHNLflYbclo86QCNkZG+i4DWFOGYPHV8CGN6FAiltLOqCXkcSxyffMavI6uDpdLZY9/08Sug3GplEsW1lAJRTk63iQK6pD4kvEX7zovsGylLNJhpe65XsjdzbwRTTVVDTFpl9MjCFW7iuQw+mfNgLBF+7mnzOOXuyBIL1HluLNPo+3IkFx3QDkMaMmju2NDJvP0BiT6wCvtYP7Ixm+MKaWC20azNG2liswCHkBb1EgKOabCzpTAdnxVXDKuOzW3WblCsfQHfB5ySZWzHuW+aB8xYqaXXn/FJQ0diNyq1hXBii02+3zyvDV9NzNg/8Djh4hPxVfi5ZD7Yf5nMfgZUFm2dKZw8HIoWLN5psPaXxwi4iTlHAjmR+1ubl3IDW/HuFijojQ97EPPN4eiE3xSqHmOK+uRThFruwdKfY/lu1LNq4JHQFmGavG1uT9CMpd9SD/BpbpwJcet7Z0yDVfrnOpZKQ22d4pZDrNNJjxy7PeYYEks9OquXP8LPdvqozCUUGnrGM5eRor4sxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHBn/Y205wKLBHb0pm8v8Ty5vUNesL+drqyrLob63A/SmsVqGJ6UJBNvb27n?=
 =?us-ascii?Q?PyfETArzYBkjMUbCn8Iz1Q7PinYJUIAUpn8msPN0Z2IgdhL2pawVdg8wI/e8?=
 =?us-ascii?Q?stccFjQ11OUdniFfHT9iMe6CcD7GlELrfJ0JEMdWwuFjQuy2WCSBC6bYkcf6?=
 =?us-ascii?Q?km2kkyDRohU7QxuDBir9wgVQ6+lc+BC551kf5hw8dZ28EiTCHjJERhrCN1x3?=
 =?us-ascii?Q?VxN5HPgnZ6LY2SXkqQ/PKf+N9oPCdn+KCEX7uRSDR304dpzpMrUJ8O9euTai?=
 =?us-ascii?Q?1ra1H8YqjiSpaRov/AZkedQ5XhRmFYpwaeWxUuqwIHjVC2GxwDHLo4Pp8J0P?=
 =?us-ascii?Q?JorqIMa4Gyw8atpk9D44YlP+tbanr/nwCGxmTgisfLv0W0F3WJ+irLwFHn6B?=
 =?us-ascii?Q?3z0ZpDwTpen/9L3X6FzySM5voP2RCK0ISAp1st80zJQo5lrWI/J3jXyXocXL?=
 =?us-ascii?Q?rMkYBWG/sBT6LTfKlJFNgrl/TQyolmwZx0LuEB72Ou10neA/7WQEHYB586IF?=
 =?us-ascii?Q?Ok9ayEJlBeQ8J3j/X/U682cZpOF7tpTB46PUXADq1uQiixIQ1sdRNQTVxeB2?=
 =?us-ascii?Q?ZgJkSe7Q+fC+KpMYqgwA3S6/QIMDDIvWnpPANhQ+AQgn2bSdOcnu6DxVUVEQ?=
 =?us-ascii?Q?1HIRr5Vkh2u+LiIQlPYuurLJhV0nCBe+NFto04i3qTIxygMfnoXVWfI7TMSf?=
 =?us-ascii?Q?L1qEDoOC1hRSOlSEISvOQhZd9yU4z/Mi2O5M1twmD66r2+SJHYgcLAITDvZ3?=
 =?us-ascii?Q?CGs8Qo3HsNofh7avhI+ruMQwMLu9JUhFe+FOeNbBzp9T1EkNYCrn8AKcrLvt?=
 =?us-ascii?Q?0MNquty7ie9LE3jOEw61K7yys/ux0GuJau/y7DXiVG2kUwJGUXP6cu722Sqf?=
 =?us-ascii?Q?Fxe8Q/S+mhIJCO52zVFan3IjhyUZXJAPRUB1Gn8iUwSGJKg+SL0nbq6EXaPg?=
 =?us-ascii?Q?R4Dddahu/5Y9y60pawy9rZDvHJSpsOrc3D0fz/XYkkgqYHhbUILFbYD9m5zA?=
 =?us-ascii?Q?C4Gbc62y3T5N/0q2HMGaoO4gBrQ+vx5nUuu7JzY0Ifs8mZlYPqYPweYbNkja?=
 =?us-ascii?Q?T6QCpQKeBviJ3kFfQw8G6Zet6/PGkdpxxY8QXiOMp0cpKeGpB7zcLqLDV45q?=
 =?us-ascii?Q?U9Kch0OW2+yWd6uxwqdH81cMQe3nGWtq4Qp64lyy359I/fSuqwzf6AnpNGx8?=
 =?us-ascii?Q?T6ApNZVFLDysGfI+BkLSOwEkDyZ9byNwKuvNHEnqSmNUU4PfPw07KpFM0NlY?=
 =?us-ascii?Q?/B/0fulCnYJVCh+K3Q1qhW/mcGGH+vjyJ0V2q3tQTNJoCJGSbIYz/2r0dgaf?=
 =?us-ascii?Q?71a8pxPez999+kkhPjHu7hHnD+lSqndQdi0nw5PC8kkNK9Tw0M7lGUiSqH6f?=
 =?us-ascii?Q?Ok9cn31ylGlkfgZS8xlSSGHdyUH5K1daUYXnNrz0htNoBIOXE1J3uHZEZ3t9?=
 =?us-ascii?Q?Zfv5WSINj9+TorpNNL9swiSdFfUATXwQ03fX1tpLMNrftbFXEOuY84qpSYBb?=
 =?us-ascii?Q?709IaB60dhsO+YpoPe3O2BYmwgEp9kNeZUSvUbw2OaHkRdx5oBPYXg8vzamY?=
 =?us-ascii?Q?WhfzZZ3g0WVgokDiaWOV7GLUxQb7rEY/izkI+uHzorLSX/2XWUs0RvKK4Jq1?=
 =?us-ascii?Q?JngWi2HOIREhdhHzeVVN2OL9v+ixtZIADqZVAAOLIv6notoo4qzQvNaWbayW?=
 =?us-ascii?Q?5nYgkVdyac1qgqwDEXJ+Y8YWjllQBoPdxftNAyAjze+NyR8rvzWfKmcjn0M5?=
 =?us-ascii?Q?+ORNNp9T6asrb0RUF3E6wpMY6yc1vtZ7oPFqg5i81y9j+wdBdSiW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b12cab-9b24-4c69-e7f2-08df1944569e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:29:01.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtefip+5A5O9toE+IUrcFLfiZxB7Du5yRylWgAPPFkxOcJU8uq3lr1nrIN2VfmcFdAcBfFErfDgQQevTzsWnWQqjqcExXX7cETQhd9QcJaVfbOOY/rzZ3nD6AE5SvT9H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11297

From: Chancel Liu <chancel.liu@nxp.com>

After a warm reboot the REG_ASRCSR register may not be in its hardware
reset state. regmap caches the register value as 0 (the assumed default),
so when the desired clock source index is also 0, regmap_update_bits()
skips the actual hardware write because it believes the register already
holds the correct value. This leaves a stale clock source in the hardware.

Replace regmap_update_bits() with regmap_write_bits() so that the masked
fields are always written to hardware regardless of the cached value.

Fixes: 3117bb3109dc ("ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Chancel Liu <chancel.liu@nxp.com>

Regards,
Chancel Liu

