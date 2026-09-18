Return-Path: <linuxppc-dev+bounces-27740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D809CC982D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 13:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmZ0g6g98z2y7r;
	Fri, 18 Sep 2026 23:56:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789739779;
	cv=pass; b=Aw7ATK6c6euqL1d/SqkvxC7s2xQeJb8HvEZPGpVlWg/8bF4sJ7R+e9oUuNNU+zaR1J7svB41a4WtgxDixmDQDtbsh/7FrmutnhWjVzm22tmXo3D7eWaf5lYzG1RL/EJWrlWlcDL20bgE2qShZBs5RqX4NvB+QwXUHVRfstx6KFuFKwr7eun5vH/kKo2MqiYmgdHkQG4JOIAC6ikKRCSceEn2B+HeQ1PGlFzyewRFT7xzEOkyFsQQ5PAd2FTFLkBvsCkbp2RRPp4/7ndsoM9U0P8MzfQLvuFU1KhogQYP8Pzu7S5nhrims8FfdMl6xkvkMdvXy5tW9Dco2KyKK7Tqmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789739779; c=relaxed/relaxed;
	bh=SNcal95Wlx6oG4k/wphCkyThDopgfzgyp+w9HY5kWts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvOj9cmnWrH78A2rnmXZ8R1GBrFzqu7PN2RysBxgliAe77JZBYyfBC32DsYiKi0UDT7PIMIkb00gtnQ1Md8IHB6HHawRS1Awi8zL3GD2C9gcHRcs8C8Wej+vO1iW7uTWHGIwKN19q/oT1On6AJrUeDnKTFoLgw7g0DiVodYYcLDWL1ko8xo7pnwSP8DT1qGEuHNvcUml0q8nuAfk+WTFWC8hykZd7FmhUOcWMZlL57Y9mBPRJA8Vb1JT3lLtwiKdKu4AAbvY+QN6ufyOytLx5QxUYJYkLt8PQHp5VsoYfZKOM3esIe5G/wQs4eCJUQXat4ZydV9VMDHTAQvLyAbUmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=M94vuEmq; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=M94vuEmq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmZ0f6Dqxz2y22
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 23:56:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fg2ZxMur0dDlGi/FQLqauZk4T8L5zSDR2InuW3+3TqcMyqQTX1XGWF61kHjQXivo2lido3FqfiiL6fSU4SPJtI+ydsTK3ZXc3Qj/InepgnESDxTn+2kJzXnwq4L+coKO2bYS3HLlqWAdLIi3ZhmiBRsS2bmM++poPwT+owFrAQC1WzNZ3Cq2x17y7EcWn2IKxMyrhWmpNFMWcN+zI1VGvalufaQcfVptekL8qjkb1J7SDx1fG73Cn2d4OTDgomvqgPIz8ESa+S7FvnIOgGb7+wn2S3vuAnb93i2GuV0bsat+ddz19oh8NLF996AswHGYQqz3ZhsafCpJEV5bcr4Utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNcal95Wlx6oG4k/wphCkyThDopgfzgyp+w9HY5kWts=;
 b=PfR2h4dvi533JQaWrMWbsvBtfTyKih+RHdJoG6kRqsM2p/RjLjD3gfiFWkpCiE2gE+N0UOswJQPVTnt/0XrBU/YAHHYmDPg6IX/+qhlJmcOcG+fADVdGAhIvI3gkC+No+2Q3lh/hwk+llsASn1MZ5Y2NvH99kjIG6OEYoygO3/spqgI4XdGNo23X6Wmmjx7MZnGSkjTpAWFtXFaYp7fqmP5LXuW/Ei9whBrZ6qOSTEYiJ4uMbn+DZLm4hMceQuoskfSDy7ZU+iMhaEcXXrWP/+ecXCctytBhn6Qcm3HWBrgfsJugKV1DLWO9CTfto9gFvdw6TT+zB3H8le717jYYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNcal95Wlx6oG4k/wphCkyThDopgfzgyp+w9HY5kWts=;
 b=M94vuEmqDFiwPRiZkVcVhIB1BTwFvZ2gJvCAFDK1NjS8dOUU2K8OaSceIg9Bv0jLI8XUL1kf3T5cV+wO4uGtg6/JehYSg38S3h7H+nOEC0/5Z7OPETBBKxqsBMPfjW0/DdjC54Q3ZXbHJqiCQp0ZxgdUbSSWycwsZs3FMjIPU2M5FESzwbck5E7UNjd7XjfTac19O/iabhBOBX/mW5s61BeaulLQ2R3Xvl2cAqSgV5rRAhJUY+YUMxsbwGuCaZFjh8kJOD9QlQOf/FsTMJ1OTcyeIZi7d25J7aVXpJn0NvzJ1wJCkZkGpbLN7/f0K4EpA7pmldjQEBj1gx8U50lySw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BESPR04MB292108.eurprd04.prod.outlook.com (2603:10a6:b10:12c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:55:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:55:52 +0000
Date: Fri, 18 Sep 2026 08:55:38 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 5/7] ASoC: fsl_asrc: Replace
 dma_request_slave_channel() by dma_request_chan()
Message-ID: <aq1C2qwGmBitdO5P@SMW015318>
References: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
 <20260918113727.1898998-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918113727.1898998-6-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: CYXPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:930:cf::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BESPR04MB292108:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1aec15-1f36-40d1-52ee-08df158c8d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|19092799006|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	I4kY96eEJtCCitwXnRXCp8gomZ8qDEizS9msKDspVUzjcJ3dMxMa3w5QDIWgg+EAckzH5yG1ZCZUeWjXCh/dOactA7aOjxcPu8g9n+BZne9jN5MXbVr0LlvbdUcgIU+9OBhujyuqCBMy+MJ4B/L0McSMH/1dv26Ei54wCP4lehx1SODmZalq7MNfuk5iOPu3GwA1z3ibrbhrPWVMNp3ddQF6f8wq6xjxEW5izbxZoZbZHo4VOZ/uOTVwkEdRdZ710HpkqCZdfvGU4JEpIINFQuj+bzaRPJUZpRCAgIJOdaoXwvsuvo+fAH7GpQ0VBbq2nX+eHLC9dRRIlU1SAGJDwhQ5eE7sObp8G0AD72knpkj9jV7q4sVU9ofPyitVcmIDQHIAdBhxH56MHidfRP9neMfgSqWCb2Dtjwc5EF+VWZR4oTMYNuNQXetKZfRaRIC4yXYLOnvdxnkdv5jNMODOdJ6JcZWaJdC+hXt62Uqj53O6V1jzeP/zpYkDJzTB2LJPBPCdxB8YCK+JJwwUbLdcbbKlkLH4kjAREWFYsPxtAsEMiP4h1EGFk+cMIPpM3ruwbg2Io/LLJHUrVZ+SC5bag5yHlVd53lpk9kARAb+QaAof18nbvAO4TPrnFl/Pr4vbfINax8Dko9gWD6rEYQfxcZCo9VvjlGE+DvqRtvr3JOyNLFUDiHAY2AAlEFQXnG3LcKDphhmPx+KnesR/EkN7apmdDqBIrSIRCb0bl4IYVyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(19092799006)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNVsEWJBCVKfzA3UAGKeILDIA2ljSYyB4vL83zXk+EcXL1J0J7OaKNwIDT7r?=
 =?us-ascii?Q?hV8toMmlGeHZWPSxq3fYjJQJ8JV6FtowUC/ZVBuT/WRLeXa7qz8PrKzXrhnr?=
 =?us-ascii?Q?CS1DBhhpIsQC6reJJmh3R1iBMyQV9x+/O0ZaKb3u169JNg8qx3mBEaWq2P2M?=
 =?us-ascii?Q?TBbcGhRXkWoL9MaDWcFImXj9yvBKbxahfmMzmwT+Sb5QHdHVixB7KoFCSx1v?=
 =?us-ascii?Q?AeHdpnNupMHlxCzsWLmPZsWEJjnx0rxEOVplym7K7Euwd7BzzfBTLqJmCEJe?=
 =?us-ascii?Q?YhFH4BvUGrWqqb7OWKvKzMnZK7siTPaXVtzpQ3iOcdCvFcowX6GqKxiGM/ea?=
 =?us-ascii?Q?sLs+3OuKB05HDZztPqtNl+qcfG22c/k+t4WNYVYNk5jkXV2fVzWEo/05icNf?=
 =?us-ascii?Q?bxtiWLINS8BVOfGWgekZmniHPjlmjf5VqeXs3cqm+I/eE54FgF/TiGFdpMOA?=
 =?us-ascii?Q?c1y0GPBYks2SYuqzq7mWA2WO0WoU3R7CQK8e0qvuQmk2rJjqtfK/11+VELjR?=
 =?us-ascii?Q?gxY1ZVDNkRLKjs03z7xl9ABCPnq+FitQVKQbcUiT3MCFojZpiXvyvgHd4+Q4?=
 =?us-ascii?Q?Xqai5LLPJf53rJeVLKBSMll9hp232GFf0lzcgV/CxL12t5S3sctKMSHvRWZg?=
 =?us-ascii?Q?+pb2C00fKlcyN4DMy54t/biTBzRCVMLwuqeivztMRzKqLQqinrZkZlYiDu93?=
 =?us-ascii?Q?DTvNLQ+vxg7CXXVbfI/4jBylHlzxAIb34CwX72d4dsy/Qyc4KYHKkRVxtn5G?=
 =?us-ascii?Q?ym+lG09hCKDzEtL0wvpFvGffQwJRlkDs27G2DilgSnG9d/kqXK0V5ix15h/A?=
 =?us-ascii?Q?ezypSITsUHt/JI1gREfXoM+eGUPZqE3VB2xFbnsU52afVwcTGaZeVQt6JjGF?=
 =?us-ascii?Q?kdvPKBspDyqoVPLRvbDWtSK4KMPhG/LutKffuYpDQuokOe4qauP5eVSNWIlH?=
 =?us-ascii?Q?xuU7su7nU2xFI83cvB7S0f10pNdsgBRvrFAi1nIPe3WEa3AqPzCl0NuThP1x?=
 =?us-ascii?Q?gZeW/BeVa/DucHdnauVrXCp4xu8g0/Em+QSjGYsCi3iwb6aeEv+58qImd386?=
 =?us-ascii?Q?eXoRKCy5JxptIM0vlzzGAk/PlAXSxabsrIOmhWa+4pVtPMaQo0kjadv8vb0e?=
 =?us-ascii?Q?clmfOfEDqeHvzJ/KLAc8NdGyaPRPJLJCzNhnpWw3P+7PEKKXLXShwnilCp8Y?=
 =?us-ascii?Q?hL9IONExtrKAX1WMVmuIHES6xM3grRZtbEoutobJbEKj9zy2QadcoPHVek1c?=
 =?us-ascii?Q?P4grVSXFTrDuOrfX8yR9+4zCI2sEPALwZuJ75VhbQJxEczWTa24N1uikgaVQ?=
 =?us-ascii?Q?8Iw1ThOKzQ28vuqO7cXwgXoa9nUTbV680SSHjYjd7dF78s98/E9H8nGONTlH?=
 =?us-ascii?Q?6zhWD7CuHPM/JHKD1tmUvH4zf3HaXnxvdJuFXZao1W4xJfZsYRiruadG19QA?=
 =?us-ascii?Q?HDJPJLg3ADZA6SYj7eP3y/4/FkGq0hgk9Ep/wzUOrOyIUvBLwe1hqJS9OS9s?=
 =?us-ascii?Q?P18uwcGkTUN9zlQjs8ruFcBqwC+IohDdyA9nGp24Sv7sOoLSIK6CJkWJZpMm?=
 =?us-ascii?Q?4eyeXUSBeo1F11IxXaroJmbBjxKkjDBjbd61nPFQT+YqRKJmACVg1ywiN1ac?=
 =?us-ascii?Q?zY6Y1MSJWMKx29GnvqXiLJGrkuIHsi05hzZgyBp6OoXKxpRuw91E02p2ENtf?=
 =?us-ascii?Q?Pbq8BpFSWjE9uqW1+p1mRepbgdGoZzsozNIiMKk7yO+KnUYNexCxGO9B9ArA?=
 =?us-ascii?Q?PKF2jvdRus+Xe//jaU8BmZ+8cRePT+auVPvcwuhx9sjcsy7hNAtA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1aec15-1f36-40d1-52ee-08df158c8d25
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:55:51.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/dL+7GgfrNhKfqoEt/BvtQs+dFjqWX2d0T4AJlhp1BrLlR+wvD0SJL6LhJK0zd34yNGhwC9IbrqmBw4RaoaKQIQCJ+6cc3gYlCd9T3x8CjCyV2ecH0aY3Rc1+SA6ptz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB292108

On Fri, Sep 18, 2026 at 01:34:09PM +0200, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated. With this, propagate all possible errors
> to the caller.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


