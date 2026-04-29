Return-Path: <linuxppc-dev+bounces-20265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13556FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5CSG23Bpz2yty;
	Wed, 29 Apr 2026 19:58:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777456734;
	cv=pass; b=du3+iSHC0bayPudHeIkBFeFo2v+sLMoFIkbvPW2TQdaY4TgNRymw9LOrgkIaTKUTVTFUrzIvYWPXfCBgYlo8DFsnQmB5pwiXBt9OJA1O11MdBbkYvD0FTz4azuo36WLuGxNvxs6EiQ32DzoPtJQBeOBop3OFA8BHZxGSGvF3xtusR82R8s3D48E7mOMtGQ2byKxJQqgBP7PsShrBkbWkqwGImBRa67n1rw5zNp/mj0e8XVxecMNtn2EF9/HxoHg+IwtI/eAlEnWpO1jQeuEw+nqfrMjU4+d+ZcbAFkAYh9bxpwI/aq5o/a91t5JD3oTN8YvA5UmaBj3BsHgF+CfLQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777456734; c=relaxed/relaxed;
	bh=K9dLxSF8vWSwDKZjOpV6UUS3KQuTRkuRsAXWgr0KuTA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X405E9x0tm8xjuSstf/KSlCkqcE0P+I8KiTq7skgS9Pum210em/7iZMTY/MLCpzaycpnRadSO9m5dhpkaz0Ll3AaLwsYtmg9G8k1pkYWXzsnG15zs8jF0Ux+w0F8bNE0OEVR2kzSuCZ5+0T3ZKpA2dh7XRGq7bB2Zxi0Jmx9auAFRcSl9AlEpXIti6bT8sWNOVrHxMkNE95uxy6Qy+4dNFd4cVQN6f4hfMqF3GbVpGkJHYMXoIPl9NfzUpatpyylMHOVDaV2U2A6NUQxYkchYGTu/UAZK1wd6CI5+ozcx0J0r4DasD9Hfqu5wnJw5ImEb91Aws3pPkKOgulqCjW9pQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cqXSf6Pv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cqXSf6Pv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5CSF3383z2yrt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 19:58:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui6jw9rFeukYAJ3Lh64vz0k0ELBBkv/pV5xN1DAA/Pt5cpftOuN4nU/eeQz29VqdfsQUIPzFBk/6wOyKSapNQiJQAOUV0GEy9EVzsoW8RGI7ELoo8VHjf8frc+8kwCnXA84HpuNl5zvpvYcM8GTPiqfxFcPRT2oMWVgjpEBE+5m+PQ0tMEVpcSC+lgAj2xY5a04c+xKoAchR8MaBEd0y+Kk6wfMgt2mYBvoHRfBd9xBBtZRggsLpL4bODLMYs9ygqUZdfF5YSRnhrtawyOMtwZ2xkLlC4KHP/SgUETTmLEviDvwzop/eQxI2ptrQnEFUCw9ns7FDb6XBkmRqRHsKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9dLxSF8vWSwDKZjOpV6UUS3KQuTRkuRsAXWgr0KuTA=;
 b=eT9eSzQiSOubd4oqOTuAmnyp9xq3QQ9aJ7dZtDnduzk4D2/5O9srMvNBln3eHhzyDFI4Jy9G/tbnuSpG5+b+1ODotc9lX7lp0pPYesZWJqXwyTcbPEYlCjP4aY3Ji6ZBd6zOyAwC3HlNHaN1ATYogmfF4Ie3mmnmJuxznd/Qz1W+1PJ3lZwtiMRnnG4fO+yg7F31vNJYExySh7BKI17VYEEgDD+GmHaXpw0gu8bAxhAUgQp6po/+bGoIS2p8cc8rHOO2OunuQVC9duOiK4Q0LkpM+nFyMamKj6p8+/mzY0dljNDw/IrIeWu5eQg9GDj36R6EqsAMU0YNz9QzChCBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9dLxSF8vWSwDKZjOpV6UUS3KQuTRkuRsAXWgr0KuTA=;
 b=cqXSf6PvBl0VcCkjaMGjwdeZ+RfNpQiMCs/lioM2XpqZy6awiMpGwjdySfuwJ3vQ0LTiY9GtDn3UOedyGM7mB516BVDs0wb6R/MJcAtDRKfjvhqCuAYZGsguneC3m4C8Ev5Scr1RcXIIGy2W5DwvCtK3fwigw98x3L6F0qHV7VQ6sNCLstnH5exVJXK6K1NfZPzcFOoJCPpMo2XE+g1ZfWCW45Y0KxJf91AS2RbgVDVU+GaeT1Fb91wUUF4LiE9K+2Hs5FYRJfMxxBHi5X2DhPAKDcX6mb08aYk+bjJ7X6kicnbY6ePNMPN51hyDhoTWesFsxI6kTQJYAOSpDvssrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:58:36 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:58:36 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
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
Subject: [PATCH v2 2/5] ASoC: fsl-asoc-card: enable ignore_pmdown_time for ASRC case
Date: Wed, 29 Apr 2026 18:00:24 +0800
Message-Id: <20260429100028.2739711-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
References: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d257dfd-1fc4-465e-fa01-08dea5d5e14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	92Z2ma0rzJJ90iGh3mVayuzUPL7j/8iL+kEgbvwtNBzmHm/3vNuc24nRNGiSy3HPpKwMERHTZxk6sZKEHny2O9Wj7QjsQYMvPXCR0ZdEnReRb74la1TY6U+xeRkxldPSRZCT85PmifZVjUJ6vkiMacQYHfE2bRW7DZNw6OfHT+xtbAF1RnUe+wvsNRYb8QYAmk9pzaHCWulbwKoTeUfVTnImrkQKWeLBai5pMkM/0Wi+rafNYb1hrF5cj9OxiWAoY9boXMHZeWZWmzMAqQSXGPw1KRGojQ0wOevf9pobSbt60ULxdO+Aq7WeIyn7Y4nWFzKfOp3pSFysyJEpl6Cx/ZfuIBt73e48zAqNCdmgfdRh0kCgWtTzlmWp8SB08JWB+apv0zlg9BqxcTVDa8UBg7cFQB6XQuVa+T9+6hhS9NrXWBdUP98PyxGYrZjKiiqDwqk8LpBp4Y3Upm6Q/JRH0sczAoMjy6jW48s02Z4J5jtHUvAKzloo7Zolqqrmw7csZvGy+0yfpcV3+sRXrk16Tw1jsYiOmWwfmpMzhZO6Grfx/7wzS8rDqyOuuYC6c/7Ioyk0OJbzpd9P0w3DLWZLf2s3WxcOIDSfU6TsJwYwzRAbMmEik/o5zWWPddNuxED3turz+fSWvUUX5M7D2Pl+eKwhF2cRYRf5GNiVSEwriXkgoaezyY4jPBWLgLUw6AF8JN9yUKDZEXTE3JIuXGvvkL50gdzCVRo4oGOWHvrhMQH76HCzPGCggIaFNAtYp2gaCvjIWnN1/UaTT7hMetOkLKQ5X+I2nL36hmrnNfBo5wcOCJOoFP1Vw8MF6idVfZb9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFndVpNSUVlbEN1aVlBODdKOUxGQ0ZzQisrY0lkUkRIOXpGMDhsRXdaWWJF?=
 =?utf-8?B?b2pvNysvbEJBbWh0VlRJaW51bFEyWnYySDlzUEZ2OFMrSWdURUdWS0tqKzdL?=
 =?utf-8?B?SkdTTnJrRHhVa3BQeEVGNGZVRVluQ2dmNEpKekYrc0tIWFd2TVpsaHpCNENi?=
 =?utf-8?B?NTRJeE1oVmpmYkQwWi9HZUhYLzd2ZUV4N2Q2eGEyMlpHTk1WdEZDY2VHcGNs?=
 =?utf-8?B?NGpWYkN2bXgxKzBLclF3dkZHNEU3a2IvbDJENkRjbW9pUG9telhKUThURGQ4?=
 =?utf-8?B?YVV0akFNbFU4MlRtamJFZzErb1k4NGZZaGtQWWIvK2RSdTN5SzJ0Q01HSWpO?=
 =?utf-8?B?c2VZNVppQjcxcitjbDV2NzlZcUVxaGVDTzBmNFZMSXJZYmcyUkVWMmhacHly?=
 =?utf-8?B?SUx6Qm9ud0NrbHhwTVkxaUpZeTY1YmdFcG40d08zbVpRUnplN0VIL3RYWW1O?=
 =?utf-8?B?S25wcWlsRUZwMEhqNjRRR0w3Vi9KSlB0Kzdobi9aQjA1R3hxdHFoT1AxWWc0?=
 =?utf-8?B?UnhWbTJOcGZxMUJ5N3JXQnFmS3NDZGFpVDJOSWxlZ2hyYy9QdXQxZG9LL2F2?=
 =?utf-8?B?RUtwdlBwTzZwOUVUejdRby9wckdnWlNHeFFjcUhxZHhZWFpqdXBlR2Nsa01h?=
 =?utf-8?B?Snd3UDduMWRiZXQ4ejJJalRjWnd6QmJXa25UV1FkRHlOUmZZSVNBNTJzSndG?=
 =?utf-8?B?alpMeUI3Ny9uaHpTNnIxcThib1I2N3ZkVTJ3UGlRb1YwMWpXbVdMVWdvRnRh?=
 =?utf-8?B?K0kxWStzRytqNytMNW9CWkwrSWtldGZaWXZma1krOTgxNGVZcFV3UGhNNzcz?=
 =?utf-8?B?OVJZQVRJZFJCVnRMWUtRVmhJUkh4UDJ0VWNuTWZGWEQyZ2VTVENZN1Rjc2h3?=
 =?utf-8?B?TnFVV2FLVWpKbVdkRFplV2VzL2RpL1ZBWHB6MkdRR0VESW9CMzhZQXZFd2VL?=
 =?utf-8?B?L0czVWt3VVpnN0p5VXZ4M0FSMmdhNURtNjNTV3RPVVBBR2VzeW43OVFobmN1?=
 =?utf-8?B?MjVHc1lnekd2dEN3Y1hzWCswK3NYR29FRldjcFc2UHZxTnRCSzUrQ0FEMHpM?=
 =?utf-8?B?WGFPRkJtYzlkK0YxcjU2T3VscDJzNzZlWHRyWmJpQWVPdVlaelFkdHhOVU91?=
 =?utf-8?B?bUg5enk2MU5yOW1UeGlWQjF2N0VJWDBmZm5WalVZOGJ0Wm5KVTNjMENicXpr?=
 =?utf-8?B?cUV3YzVDS1pEQUZUM3RQSzJiVjJDSzJhVHpxVHVBUCtZU0dOcTMyY2hQUllv?=
 =?utf-8?B?Z3N3OWFBMlZmUHAweVYzWGczSy9ZTjdaZE5XSzhkSjRPL3J6eXRLMDlhWll5?=
 =?utf-8?B?eEFyc0dRampXRmI4bU1SWUcySktkVFRmMzhoNVNQcVVjNzUyOFlTeDBPYS8y?=
 =?utf-8?B?YTczV0tBRVRvZlJyZmppSXgzbUl4dUZsMlBwdE9aZS9DUHBXalhOaUhLejNq?=
 =?utf-8?B?Ry9pdmQ1akRQTUhueXRRb0grTERpOVFSRy9qL3pWRTNrMnFSMklQYW1LU0JC?=
 =?utf-8?B?bFdNdGdFZEdobWs1ZzhwZ25GVzNQYjREYzFTV1JBbDd3Y1pFTngxNFI3YklO?=
 =?utf-8?B?dWR3QnBzZmFpT3M4TnQyRmkwdU1jMTlnZVUxZ0t5QnQ2c1laZEl3Y0FqNkVU?=
 =?utf-8?B?ZitTdkRST3cxZTcxc20wVXJ5K21xbUJrYlluZGdPMTJZSlF5bnJWRTVtUE9l?=
 =?utf-8?B?RTUxVWRDNG9kQmdGcHN4dnQrYWNZRko0emk4TlB5dkdFazhFeDlrT0hpK0RB?=
 =?utf-8?B?Z2dmUnZtZ1VEWFJTbGduQWp5QzRGSkc4R0ZDTk1XR0pMb1IzR1haaXNESDdH?=
 =?utf-8?B?emFQakNhdWRsYzNTL3JJcHkvREFrUjRaQjA2Y29xK21sZFp1ZnpVdDBRMTNj?=
 =?utf-8?B?MGNaeFkwNmdNbE1NczVEcXp1b0R3bjdDdlZkZHEraWh4STBJMm1FQTBOcHp5?=
 =?utf-8?B?SlBSZWpxc3o1LysrSWp5N1lXMEdVTGJCRzZFK1loMXVwK1FEUkFvYzZQeDZx?=
 =?utf-8?B?YWZydUxYSVdTMUM2OTZzYUt2eG0yWmwzbnBHeVVWOHFWUkFHUFgrUm1ocktU?=
 =?utf-8?B?K1Z1OWJyajhNd2wzVlcrakxESG5HckQ2VnM0Wm9vTjFYdmI3T1l1K1M2eVlX?=
 =?utf-8?B?RmZxcWhTdU9tOUw3QjhuVlJ5SHplZ0o2SFFSQ2ttZzBlWmdialJ1NHlod1Ev?=
 =?utf-8?B?TWpReVVZY2NvZE9Jci9KbTdiZ1pJdWpSNkxsU2JzS0dHYnN6cG5BZlYxUDVS?=
 =?utf-8?B?YVkvSFVacy9EczF3K0xmM0o2WEI4MmdjYVlaVURrMWN6N0xLd2J6UGlRZGJr?=
 =?utf-8?B?eDFMeDZrYzdmQ29UbktPTmFSNHJOZ3JvbTdRUnI2ZEQ1aEgySkErQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d257dfd-1fc4-465e-fa01-08dea5d5e14a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:58:36.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhmRSr3ZbqjbBIiS0a3kg/8H7tF6xwpSHnuh4WNsnvX9m9w2qmB2em51t7mrVjhQH5lZZ9e500HK5E/4mWrevg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

Problem:
When switching from ASRC path (hw:0,1) to direct path (hw:0,0),
audio stops after 5 seconds due to DAPM powering down shared widgets.

Scenario:
1. Play on hw:0,1 (ASRC): ASRC-Playback → CPU-Playback → Codec
2. Stop playback
3. Play on hw:0,0 (Direct): CPU-Playback → Codec
4. After 5s: No sound (DAPM powered down CPU-Playback)

Root Cause:
DAPM sees ASRC-Playback disconnected and powers down the entire
path including CPU-Playback, even though CPU-Playback is still
needed for the direct path.

Solution:
Enable ignore_pmdown_time for DPCM links to prevent premature
widget power-down when switching between paths.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 41cd2fc2ea56..e08e135886f7 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -990,6 +990,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (asrc_pdev) {
 		/* DPCM DAI Links only if ASRC exists */
 		priv->dai_link[1].dpcm_merged_chan = 1;
+		priv->dai_link[1].ignore_pmdown_time = 1;
 		priv->dai_link[1].cpus->of_node = asrc_np;
 		priv->dai_link[1].platforms->of_node = asrc_np;
 		for_each_link_codecs((&(priv->dai_link[2])), codec_idx, codec_comp) {
@@ -999,6 +1000,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		}
 		priv->dai_link[2].cpus->of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
+		priv->dai_link[2].ignore_pmdown_time = 1;
 		priv->card.num_links = 3;
 
 		ret = of_property_read_u32(asrc_np, "fsl,asrc-rate",
-- 
2.34.1


