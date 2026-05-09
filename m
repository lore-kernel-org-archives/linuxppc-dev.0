Return-Path: <linuxppc-dev+bounces-20646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A529CD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:29:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMfg1xMLz2yFd;
	Sat, 09 May 2026 20:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322555;
	cv=pass; b=nE90dX4SMBHWSrz8jH0Ta2QvHmWmHntgv9H1LwvqLP/zANW5x6LT1SVjLBZofrR4dKjRFJ5YcpQEf5ex1DD1ZeQ5Kq3uGSGPv+wad4Pn67+NN8x25Py/JRZ+c0u2ClpZzdQ1s3aYRbo8/V1kSr9g0wwtBsdsomSKKKCU+2U0WYcEnxFqqdVb6Q4rFwpS9JKRu7SRh+y+sn2IrR2GB03odvo8pLXldxLcZfD1RNzfswW2n5VY8J/ICfJEGcdePlk8GxA4dk0TRfE5yiowoh6B0NYzGHeaD3sjDWft/dr/Z3wIpRMmGJa9YHA2GyDbKX9L1VjA0oKePCKdRJmo7AiWuw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322555; c=relaxed/relaxed;
	bh=zO+fb4x+LHGlideuC5OOBuR8kYy6MWxycLAp/d+NM8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZyPWQ9pyJ9lxNbItFguB9Vxwxzto5XCHSyeXjmUqFo966BvswtZ3jY1PfKwjOiOr91ZieP2SrpNqnrr3YzOzP4wiCxSYCMKPT+zkQbR2PA4/KQyK7fEonDOPdaMndaeVkLyUgkJ4s1ihSjCVWyD6Sc2WDWQXavPLEpLKfxzYHCV654cYdY1QKmcsId2ADSQXEkOkduHWneIy/bPR2qbQZma4CjctnnkaFDk2pjaa/4IK3+ICsMoLXdQx1Hl0glwn1ayD8nm+hMfCD0Q/RZldB4llBrHbB/Ca4wW/CZ8vlFyW9sETOVJ1kpqYHbCzoP100MpnfWydsuOf3lCjjE0eNg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Z25/9O+/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Z25/9O+/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMff0Mp3z2yqL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:29:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2IBDJ9m3/GnhYVXM6n/qxWDvW6WIIneJZTbLUvVttA7ZOfDgAtvCoF/rCHX2P6poGqY/SDRWGTESvu/q1fRH2WFXkHok00seg6NN9At2Fx+XZ5NOxq/9ShLdZ8KaPU5f7oHcySFCBhn3tKjgtamfFJ4T+U0VeFY5gJ41RziGNjgHb/LwveDoBTkDc/5HQHrRpwqQa8DHjF/2nD3Eg4pMWLeuE7W5YMluiWVMiCjEvDW+XFF6cD2GAES+XrxQN+3hYCpa0qYvkTMdVdS5lYbdsxBfO3mXdxWKTY3gNUWw5h2zivLqSZyHw8skMfssSNJOEPYN9vpWSaweMkuF2fVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO+fb4x+LHGlideuC5OOBuR8kYy6MWxycLAp/d+NM8c=;
 b=TnlwyajHBrh6RWo00840LY/SY4VjRkmTvUk4pX0WmkS1M8oJ8QzdCT0tGThpIuOEUtcOBqeguSfpIdKs1O819y9yY827p3g25NDHnztYVZqAj30mJ7X0/ZYEfcWvBqydGesV9yDXhVWSnCTJUrddC7wpz31eiUaNVLT6NdS0uxsSmKQyrbTSbtQKZE6t/mQtq+YLR6/SutHwQ0aCmU6ZZswoXtNf8RaY5lzAKCjRwccmxvczbcV7W11V+Yn4MYNlqFyXtPZJOuhiZKI6AQvHuMUnZU1mln8BQq7+VvfAu1YX7dmDkJhIT2mNnSBzJLbMSPKIt8d0NOUgZWTwuLjt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO+fb4x+LHGlideuC5OOBuR8kYy6MWxycLAp/d+NM8c=;
 b=Z25/9O+/NgNwUuykF7Vu02sUO9xRknkVW+CLzKQZ9iabDvii444IqqEJveN2hbz/h+Lvg/bghZYsYhmNGXVCTChdnXkXgkokioJhisPdJYjIjCHRx5Mc+ddrWcMyCqr71y9SHZQCbEQimR4jPxflx8CX3kOgh9AhOuIIdxjs6JWyO7LtjAn8HF+99yhV/Xef3DN6SfWPGGMNqYGtAqT+QvttlDZPpFmCk2bZjz61OSMBoPvpnMmAAyT3mEeMq2u7m3HbrbGerlofwJx2pPf84NLI1D6spmgKtiojL5+W+DVDLjWohFYADvEFB1NQH14MfXjqG5JMsw+EhPxlmj+m3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:29:11 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:29:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 13/15] net: dsa: netc: initialize buffer pool table and implement flow-control
Date: Sat,  9 May 2026 18:29:52 +0800
Message-Id: <20260509102954.4116624-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: e328ec83-db8f-4f1d-aa51-08deadb5cf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|18002099003|22082099003|921020|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	OApyxW6LMqI/DgNGmoMLwLv+AtRN97X/kTc10+/IfU0bGfm0o5ICkQvm75v7E7FwREYGNhcOKb8ndmNb2fVClmSAxj8NymI7dCQAz8+91ACjWfVws9JB9QG8ykSxlN4QbqSyZqMq8PpcTSlSjT4/aP9e71ek1n+07c8Ez2zZNlpbXANhG/tql2Ari4M66J/zFMQPe/jYZA9Dxh3F8nZ+/XuLUa3LkqMUnSX6C16vwEBxUV+6qWtSQd9U+Y7nELocPspaDMOt0XEVX6HcWOm1P7NZet4FZpXjtA0B7HtmMR9yY+oV0RSWluMTbvfulLQ/gzQpJav6LgpT9FYKPUEeXXIFhTh+P1sMZ4rUL+BduIUfiO0bk10/SWJ8BNzMNk9Jnqddy+A4Ynb8878OKlzaHe/+F/F7Mo+yEpYA7VvYxDBiqQEvlJvH+XLa4iMZ724VzvPP1CuevN8F1m5vgGTIShMAVDK6cwxW2IOrsQ1TR/B1pso9gQdzwFRa5vGJnfglrsnY74CCv79qMam/mBLEPEqjCNFKVjLCgpso4anrzXCICBHV20qeIGvtHPSo0rf+iFk6YrguEnIn9sOdpImiqV248eUIwjHFkMpqb6hLgRflY4hfP135a2khPcisYI0OHGW5YzRKvtgXZDsZrjgirSqzplnJWSIGGTfK5VfrIOot09f6Ryo30ptv1JocWH8cLzDbCVWVv+oqAV131uefcjhWhcOK02igXDOwDyjmjbQeR89ht5P0jDsfijLOuom6Ry/YYvUDugAnYCYs9vmWBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(921020)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVBVMElITVc0RTFVWFhta0E2MWhVeFpwUFNnZHdIN3RKVmVyVDJTNkxENEc0?=
 =?utf-8?B?NGhTdXNHYWxYMVF3VmFkZWlQOEkvdUR3ZENZcnNpaERseGhXSzAxcUFrS3J3?=
 =?utf-8?B?M3IwdEVuQk9Wa1VQa0lXQkdxZDQ5dkJoNHNJRzBoMjRPZWdKM04vM0NaTy9M?=
 =?utf-8?B?RDFXT0JJdTJKejQvaE40cERHY2FKRWJXcWx6eUhYMGtqWTA3N21sNWFaNjIy?=
 =?utf-8?B?QzVHLy96ZVB3RGRHV3RSUUFZZUxZMyt5NXlwYU1scUs3TlpBVFN1RXJ1dGww?=
 =?utf-8?B?aXlGbmhyMHc5SnhJMS9DaGZ5YUtQbkQ4bmI3NkF2UGxUeHlKa29zc3V4WVBn?=
 =?utf-8?B?aEFkdnVDOUdUVTU3V3lEckRjV1VnN0h5UkJUYzQ2ZjA3ZjNGTHlMdzJ5Z3dq?=
 =?utf-8?B?dEl1S1RiY093WmFhTEZncTBnL2hKdjQrTEVENExvU3FYNUp6S3E5dUo4WW1r?=
 =?utf-8?B?eHpXNzRNQnZjT3hwU1QxY2pCM3VoVTE2V2x5Um4wT3B3UUM2SEErMzM0SDA2?=
 =?utf-8?B?N3RzeFVCcGtjbGoxTlZnNUM4ck9aWitMR1ZBN0txdFpNSm12SmU3RVk1eWN2?=
 =?utf-8?B?elF1VVE3bnhhMUV0YXpnVDBxdlpsUmtSSlZkUEpUNUJJTFA1WklxaENUYnpo?=
 =?utf-8?B?UkcrdUJiRE5vWmdmMS81K2c1THBXdmx0WTFDdnNOK3IxOFRRKzR4RWFnb1Ri?=
 =?utf-8?B?YWtLTENwRitUK0tNWEJZQTdobXIxWm1kYnFta1hYQ0g4YmVoV0JYYmN2RTlx?=
 =?utf-8?B?UlVzSmJqR3BicGRiR1dDM1UvcElzdDRhU2ljWjRHbFRrTUJBVzRSUCtKcDN3?=
 =?utf-8?B?T0RvV1lrOXlVZTVQclk5L3pjYjRpT3pMalFPUUhYbEUrL3pXbUpMQWNUd3l3?=
 =?utf-8?B?MzBNQld6ZG5iakZXb3JVREVFWmtqOVA2VlZiRmVzMGl1RmNHSW9ncTVMZjRt?=
 =?utf-8?B?eXl2dklYSm45RUIyWG40YUxYdytZUm9WQ1plQjlBSHdVekRaRDh5NVVRNmlK?=
 =?utf-8?B?QkpKRzdEWmxCUWxUdmUxMEhlbTgyWVhIRmZCcG5NR3hOMHp6SVVaRVJTbVZT?=
 =?utf-8?B?VFg2ZWwwdEpaelVtOVZYZDRna1hOcTUvbzVUUTVSYlpjc3JTeWZ6eit6ZjhB?=
 =?utf-8?B?Y2ZRRXFlVFFDVUQwWkpuTk5nckUyVVpzbisyTjhDaHRYS0s4UGR6UlpnN1N1?=
 =?utf-8?B?SmdKWnpQZi9iZ2Mzd29HUWwyT3FjdFB4SlQ1c0xFTXcyaG55Y2g3TC9FbFZS?=
 =?utf-8?B?OSs1VmR3NXVsYVNxaUNOdmFvMEhJeEVEN09iOXVKdTVOdExpVG5wMFZCK3B6?=
 =?utf-8?B?WmY3a2RRdy8yR3pSTGhlNEw2S0JXZlp6enBlZFpNN2M2T1d5OHhVYTJWaHFQ?=
 =?utf-8?B?bHFWamRNZGRZRENSNHZ4S3ZrTnA0c0VvQjhxMmJnN1JEV3htbWU0dklGQmpM?=
 =?utf-8?B?dWxoNnRDV0N3VHRzMnNQTUlqWHhzcjVEZjZZVThxMjd4Q21remY4cXlGdlcr?=
 =?utf-8?B?ZHZzYjdEY3NvemhZRFRXUW9aenpHczNBODRYUWR3UUt1Qmt5bG5Md0VKcyt3?=
 =?utf-8?B?aThFTzdadkJBQlpuSUZIeVlxYnpFcnZQRDFnRU5QQmVIZENBUjU4Y1ZQaGlC?=
 =?utf-8?B?eVNkUlVMYm5FNUd5dVVIU3hmbFVFQkh4eWRzUitLM0dYSmxUTGNjOHQ3cDk5?=
 =?utf-8?B?ZDJuQVVQLzBjaDB5T3ZhV2tTbWMxWWt5SDFlRUUzSExJNFA0dDdJZGswR0dG?=
 =?utf-8?B?c1Jjbk4rZ204TTJnSk4ya3Mrd3IyMWJuTkloM0ErY2c5ZWR2dHErcU9DQnp0?=
 =?utf-8?B?WUhkZmZ2Z2NVWmdVQUFtbHpIenlIMDh5VU5WRGF4ajNYWCt0OTlaeGs4bWdO?=
 =?utf-8?B?c21ZWFVpcXNyUVp1UGxGbDFiQ1dRZ1F0ZmNlTXR6TUUyTmlWcXJ3ckR1WEsx?=
 =?utf-8?B?VkI0aXJuVUM4SW52cno2ZS8rS2UreXIzM2JvY2VSVUk1bStXUklCejM1VXFJ?=
 =?utf-8?B?emF5TW1UQnRqS1FrTmMweTZoOW1sWTJJWDFXeVYvdHhyUXpMc0VlWlZLTXJX?=
 =?utf-8?B?SWxwUnRMMUN1NEdmMVNJMEZycVZNaUJmbXhlTFdBYkJVcTBocE9sdWEweEM0?=
 =?utf-8?B?MUlwSU1WWWw3NXI4RG1meTIyalBvWXBlaXBWOWNsSFJCUVN6bFBlODhOVnFG?=
 =?utf-8?B?aUpCNG1iZmhUc1VOTzRGdmx3VFlQdzAwMjFDQlBEck9vZFVQWFRPQ3BHaGlT?=
 =?utf-8?B?eWIxQmtLVkNPSmNpVmM3dFFOQm96b3NPblNkaDJuWFBxZWxLcURwVGplZ2pF?=
 =?utf-8?Q?eFNDRHmTQNin8kQOiY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e328ec83-db8f-4f1d-aa51-08deadb5cf16
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:29:10.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zrnyvsg6Q5QIH31XisKdgdLxRrqQx8Hjtg7lxQiwToDjuB4IZL7lzehs2VPQTTHm6ABGjghGhi9tjEnNMofZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 128 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |   2 +-
 drivers/net/dsa/netc/netc_switch.h    |  19 ++++
 drivers/net/dsa/netc/netc_switch_hw.h |  10 ++
 4 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 3229b7107add..43486b464c17 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -208,6 +208,9 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 
 	val = netc_base_rd(regs, NETC_FDBHTCAPR);
 	priv->num_fdb_gmac = FIELD_GET(FDBHTCAPR_NUM_GMAC, val);
+
+	val = netc_base_rd(regs, NETC_BPCAPR);
+	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
 static int netc_init_all_ports(struct netc_switch *priv)
@@ -399,6 +402,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_THRESH(0), NETC_PAUSE_THRESH);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -618,6 +630,77 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
+static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
+{
+	u32 pbpmcr0 = lower_32_bits(mapping);
+	u32 pbpmcr1 = upper_32_bits(mapping);
+
+	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
+	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
+}
+
+static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
+{
+	int bp_per_port = priv->num_bp / priv->info->num_ports;
+	int q = NETC_IPV_NUM / bp_per_port;
+	int r = NETC_IPV_NUM % bp_per_port;
+	int num = q + r;
+
+	/* IPV-to–buffer-pool mapping per port:
+	 * Each port is allocated 'bp_per_port' buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first 'num' IPVs share the port's first buffer pool (index
+	 * 'base_id').
+	 * - After that, every 'q' IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * bp_per_port;
+		u32 bp_id = base_id;
+		u64 mapping = 0;
+
+		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
+			/* Update the buffer pool index */
+			if (ipv >= num)
+				bp_id = base_id + ((ipv - num) / q) + 1;
+
+			mapping |= (u64)bp_id << (ipv * 8);
+		}
+
+		netc_port_set_pbpmcr(priv->ports[i], mapping);
+	}
+}
+
+static int netc_switch_bpt_default_config(struct netc_switch *priv)
+{
+	if (priv->num_bp < priv->info->num_ports)
+		return -EINVAL;
+
+	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
+				      sizeof(struct bpt_cfge_data),
+				      GFP_KERNEL);
+	if (!priv->bpt_list)
+		return -ENOMEM;
+
+	/* Initialize the maximum threshold of each buffer pool entry */
+	for (int i = 0; i < priv->num_bp; i++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
+		int err;
+
+		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
+		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
+		if (err)
+			return err;
+	}
+
+	netc_ipv_to_buffer_pool_mapping(priv);
+
+	return 0;
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -647,6 +730,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1196,6 +1283,45 @@ static void netc_port_set_rmii_mii_mac(struct netc_port *np,
 	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[j];
+		struct bpt_cfge_data old_cfge = *cfge;
+
+		if (tx_pause) {
+			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
+			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
+			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
+						       BPT_FC_CFG_EN_BPFC);
+			cfge->fc_ports = cpu_to_le32(BIT(port));
+		} else {
+			cfge->fc_on_thresh = cpu_to_le16(0);
+			cfge->fc_off_thresh = cpu_to_le16(0);
+			cfge->fccfg_sbpen = 0;
+			cfge->fc_ports = cpu_to_le32(0);
+		}
+
+		if (ntmp_bpt_update_entry(&priv->ntmp, j, cfge)) {
+			*cfge = old_cfge;
+			dev_warn(priv->dev,
+				 "Failed to %s TX pause of buffer pool %d (swp%d)\n",
+				 tx_pause ? "enable" : "disable", j, port);
+		}
+	}
+}
+
+static void netc_port_set_rx_pause(struct netc_port *np, bool rx_pause)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_PAUSE_IGN,
+			  rx_pause ? 0 : PM_CMD_CFG_PAUSE_IGN);
+}
+
 static void netc_port_mac_rx_enable(struct netc_port *np)
 {
 	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
@@ -1297,6 +1423,8 @@ static void netc_mac_link_up(struct phylink_config *config,
 	    interface == PHY_INTERFACE_MODE_MII)
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
 }
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index bb4f92d238cb..34aeb6fceb3c 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -14,7 +14,7 @@ struct netc_switch_platform {
 static void imx94_switch_phylink_get_caps(int port,
 					  struct phylink_config *config)
 {
-	config->mac_capabilities = MAC_1000FD;
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_1000FD;
 
 	switch (port) {
 	case 0 ... 1:
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index cc278a862623..4a9bf69907e9 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -28,11 +28,27 @@
 
 #define NETC_TC_NUM			8
 #define NETC_CBDR_NUM			2
+#define NETC_IPV_NUM			8
 
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
 
+/* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
+ * Unit: Memory words (average of 20 bytes each)
+ * NETC_BP_THRESH = 0x334, MANT = 0x33, EXP = 4. Threshold: 816 words
+ * NETC_FC_THRESH_ON = 0x533, MANT = 0x53, EXP = 3. Threshold: 664 words
+ * NETC_FC_THRESH_OFF = 0x3c3, MANT = 0x3c, EXP = 3. Threshold: 480 words
+ */
+#define NETC_BP_THRESH			0x334
+#define NETC_FC_THRESH_ON		0x533
+#define NETC_FC_THRESH_OFF		0x3c3
+
+/* PAUSE quanta: 0xFFFF = 65535 quanta (each quanta = 512 bit times) */
+#define NETC_PAUSE_QUANTA		0xFFFF
+/* PAUSE refresh threshold: send refresh when timer reaches this value */
+#define NETC_PAUSE_THRESH		0xFF00
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -94,6 +110,9 @@ struct netc_switch {
 
 	/* Switch hardware capabilities */
 	u32 num_fdb_gmac;
+	u32 num_bp;
+
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index b04e9866d72a..caf5977c5100 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -12,6 +12,12 @@
 #define NETC_SWITCH_DEVICE_ID		0xeef2
 
 /* Definition of Switch base registers */
+#define NETC_BPCAPR			0x0008
+#define  BPCAPR_NUM_BP			GENMASK(7, 0)
+
+#define NETC_PBPMCR0			0x0400
+#define NETC_PBPMCR1			0x0404
+
 #define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
 #define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
 #define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
@@ -141,6 +147,7 @@ enum netc_stg_stage {
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
 #define  PM_CMD_CFG_TX_EN		BIT(0)
 #define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
 
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
@@ -149,6 +156,9 @@ enum netc_stg_stage {
 #define  PM_IEVENT_TX_EMPTY		BIT(5)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define NETC_PM_PAUSE_THRESH(a)		(0x1064 + (a) * 0x400)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1


