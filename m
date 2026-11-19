Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6C60A6F56
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k/q9UDVZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNXc0G96z30FB;
	Thu, 19 Nov 2026 14:01:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057295;
	cv=pass; b=PKSE6P76kReJYcT4naEnbOxwyUh3T40VFdPns5L0rryLVr2bz414MuTY1rpGCIloOk7IkgRxy5rqQYYTgMkGtbappqTwzgweKYy1qFRs1HBzhqzu1FhUUjmqpWUrJa2NvQS6UMMAPn/CJylGF29V7S+I2oucZOs50KR5UAoRiiRuJ9nJfb5N0Lu6DcYi4qfhpyy4mIFutbOEaK6CFNEN2T1DTlnxEBT6UANYgwjq+oFlMJQYU2zgfocANBNDfz5pACCyd69rop9IU8K/QTT1f3lW7jQcDVt6CR7ClyobW7F9C4DGNJg3Jj3LKapU/wxwrG1EW1Db8SAu0QxlJQCKIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057295; c=relaxed/relaxed;
	bh=GUpbm2phvfXGVpyGYIr4BX8LSMx1Z4v5GdlpdQ4RbYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEjx5P09G7YpajbbZwzS6EuuUVujbP2M0hSEomXsDky4VykoNavfGllj3EkrFol05vvLu+ZwUS+1iwS+L0eX+00EMwPO2YUEyk1C1qgozpXwuoKyhrl2yNXXL3U7Z0GwSz+kzPITwjEdzmA2tcqlYrVpk6cITJOIldY7Pm77HO8QfJJYGUvT6oiC2FeGJixCKlb0yKgp+iSDTCVg2potVT1vrI9I5pU1U0p8ee3m/IG5Vr6rvEcpxQgfU12ACvw8peljQvayzVk/qESgr7K0HE5C6Gt8oaz5W/9uq5OQQ1wOGgrly2AamTxcmmKROiGn+gY2qlxd1soLtX/n3hL5ZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k/q9UDVZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k/q9UDVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNXb1wHTz30Tm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIMF7Tc/NNnYg7RIcTYPDXT/1zivbOivoovDOlbPnF7Yad6mP0HJzu+41QY0Uu+Wc49JBAWyN6R1vamxZbPkv3Bw7UnaOWAFfZQ61uXf9E/1w+HcbRJu4LIkcOLqORGNlUiEtJj7HfBW/4HdfZHhQmVtbO+4gY0gndfLirnsInNzrXtL0TLRjfBzBpPuz3ncIKKp8vxaE/JaVogK9KxRvhAF6cAs8MJgi+SfHRWrEwLxNym5unFt0/bNY6HgKWeWOgvMVD/FtgnjgD1ZBzs7pjGMOoSNtgsbIbUx+zjBYYUgcYF7YL4kJxhqNNuoJthkFro1WiLue2ME0LmiMY6Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUpbm2phvfXGVpyGYIr4BX8LSMx1Z4v5GdlpdQ4RbYw=;
 b=w9/d2NmdTRIjR/Eat1I5/1TYytZ1c57ANbgMfGnDdbJOlOMaG3g4taIa6ic1WdWzF5UAjqREgCIPoWicZQhAlcPRXZZHyn0lNoMxd6yrKdpz5P5p9wGRFnDaDVnU3Ec4rzUJrAWJHVGkBn7Bs1yj+/GywqXKm65gHT2UovIdeBmplbhm6olHat3h79uXP7AKUvgfIY3XX31ypnrFhiFjHR8cNhJyDruw5t2cTDgkYtRtS+3jMwMhp64bn0s/wb+fE1YklC++FWfeuAFwAMP1iybUYD11oGHAmgb9xGdqACsNrjDu3jECyn/MlMSXYH7wOEfV55KmnB/j6dgAnp39MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUpbm2phvfXGVpyGYIr4BX8LSMx1Z4v5GdlpdQ4RbYw=;
 b=k/q9UDVZ51i0ZkvZpxebz3FlFayL3xG50E3KbjirOxQFg7otEL71Ige+7qsNjvcDOIV9VzJbFh41S7ruJZwfl2yhU9T0YoTHiYWKJiHizHgpHE6sf/eIbue+hCYVRo7HMQrUyxTTzKcA+OGlFEmK3yZOIx0SPhyL0TacCo7dlGf+3kA8lc8MRRsNUnUQX+9qV+Za8bJ0a1KNatbSV0VL6GJhOBIzcQ9EA/mRuGL+iHC1VinQRN9kKZWbBUwI5Q6lBZQX237m4DUKH5mzehM6DXzV03ZEGps6DHLiHFcit5uu6q1coQp2YVFDNHshvTsP6kasB3e593laFeGIxpTL9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:01:20 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:01:20 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 net-next 7/9] net: dsa: netc: enable ingress port filtering lookup by default
Date: Thu, 19 Nov 2026 11:05:32 +0800
Message-Id: <20261119030534.1892935-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: 177aff59-855e-4e62-9414-08df45e96312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GYsc1Nw74SXUJXmhBAisRI2naMsOu8Q4YMCUTnPmDLjICpT1Dk3cY4bvAzN3B/gUjUlz6mqAjr+lPFRWg9SseKeyXBbQ9GsJKkFthIon/KUva2xrSKPFGlzWYRYkpDYTWsM+oo1ZlCx9VYNcWv3QBEba86h9zOHNJ56VSopCCXdgwqK4AVSoPsSH5c1/BjjWcF7bv/deItSXd6Npef5C9qLxECkdOs7gnlLh5lMowxkgxnvfXYNW6gFsCJYmJNWvnXX4h2zmEUlgR/3Xfr3B2Lp6NopJP/TSmEEynFBd0W23DTUHxH5UReFR0HMn1lXhJfZaRroBmgLaABW7NN61szsIXDK460V0VFUp3eZUnkHKFSwhwQQqRhXB7S6JNBdAmYCBPbwMurmmm6kjvW7R7zL4YDglCEBeSK6BHspCF3LG2uZ3qOXqjJhYkcPbjHzykz+r3+H0Ec22EcIYQPoHW+s2cwFyj1MLQYlMMyHq29Ceu/67E3gYEmD8SykRO9PtCQdTkRZEFVa7cbAUKJr5aYAGOnl8FeONlw/QoW1ZUUphi1orPSeJehq+qbJA4ihoO7dxUxEZuVHlm13oTFAgFg5y6JAT4DsX84/9b4oxDMxxtvy3xwQ1fF1AbULZtXtJ3F+TC2HxOmdzybZkINZZbZAmV6JKTstETdd/kpwPEMDBe5yV8/ivznUTmGrHa/93SVQSq6dYfv8EgdZuNZ4K3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aZxi4twSSWRlaXOWGYjBRdavUg7EnZoGmx+332BBTN202GMZt9fFjoeFkcO6?=
 =?us-ascii?Q?K/AlSOtcMdUdtkCqNetlk1gd79f9tYjDGjAPb6+IqP/gQE1Xp3P5DWVq0nDr?=
 =?us-ascii?Q?Rq+m+CG4OyMeAyKpLtj1tLTjs4I8uBu87xulE84o5rTJRGhVi7hFmK1AMhto?=
 =?us-ascii?Q?4HWGW6T+iDYFMPsT2VirEBkyN+6GooHptM+DO2KjeCBsTT2K01JNUfY9cG0y?=
 =?us-ascii?Q?1KK+EDcT4lJoWB0WjE9naeyYj0YMPiNl9oeTqJI2YN/KiR0qBVjnw/jDwYHg?=
 =?us-ascii?Q?tEIsGcZ0RcCBGVAyRGEtaiG2qYBRh6nzuNgJ/DUE2j+ucBrO1KF568Cfa+B4?=
 =?us-ascii?Q?lWkUr9zxJS0rcnieMYIHVIQrTHazn6Gv703hdu4gYEHHQ62IPMl7Agtde2pl?=
 =?us-ascii?Q?k0OzP2t0bI/FfoZ29tpsbs+1JVukhn2Ehh3t3F7/LD4THggAs3zejIzQ5yD2?=
 =?us-ascii?Q?dktP06nXGIYS8LnLLVK3hz1uTGR1qkg8Ux23wjNX0Wo8hbugJfbRKdWmn0O5?=
 =?us-ascii?Q?UnPuUZHdZr7Bh4abFSigntfB5e34EhpOkOYsR50ODHuTr8JkRuGDV40ZxGSG?=
 =?us-ascii?Q?3qYa59yDUOEiFGIS54Rmv7BJe6vo2R8M+R+HkYnamqmkiY7klIofnZ/Vng8c?=
 =?us-ascii?Q?vTp9Lxzz6+eFpt5O67rmQajbvk4rjVk12RtjCaEF33c3De3m3Sm7Il+MDFlp?=
 =?us-ascii?Q?ELJ04V7bPylNa9s25jTLg1djMHtBwRlYDwgB/vv5UJy5ijRUgReNhX7fQTS2?=
 =?us-ascii?Q?pJSLCd9Tux1ROB0eYinMUuWkOKJsWnh0ncNsf/fCwd/jvIxq8Fs6lVbTyB3c?=
 =?us-ascii?Q?N3lerHO2SefEowjZfo6+pMhsgkOCzbxPKibhQKXGdcT0oDCCLk1GWU2lXggT?=
 =?us-ascii?Q?nTHfqEgJE1fa8hetUBDSSuVO4ayCnF7XzRnU4rYdfIrOy95wTRSUl1DFYfh3?=
 =?us-ascii?Q?JJsdjXzjAqfBjy0sKAOTS7bPNjUPm35tLZeNIo3xS8PgxfypQUB+nqY+Mddn?=
 =?us-ascii?Q?VlIPf8QX2j1aXZUgk30ERRhCKKc5lDj7j3t9/G7hbBFI8xYw3zNyAtQm6BEB?=
 =?us-ascii?Q?Qm3IXprcJyuHzKo6ZrBlF5ofKZDjq2ZBcP97ynK+YwmSuJ0ITPcnzlhugMel?=
 =?us-ascii?Q?XXcZ/PrqMSzPT/qH9ahZd7aVoRZ19+szTWvDD6ArIPO2zwXG83LZGywC5bSL?=
 =?us-ascii?Q?5EaTv5WwlNPr/m9vS6RNvFoJ+Xwa+OUyDWfg+grULQlxhpFJK89Rgvwyckft?=
 =?us-ascii?Q?b9CQ89youjvdtjzxBk4Ej2eiHg0y6MqTy8J6dBej8wGKJlVo74pfswHmmaTK?=
 =?us-ascii?Q?IWBjsshkqg7eO9MP19i3Hz/zoFEhs2awrv6P0x5ui3NbNmCo55WBOJPGDuOL?=
 =?us-ascii?Q?2HkA47sW68aK41fBgS+T7r9Vt0dqGcZtcRzniGpFxcbMOMRPkgNM5OJssnrP?=
 =?us-ascii?Q?q4u7sbws5PzhllbTptJOgtDGPoM8gC5ENxxfq3Zp+n0nZ4neIjFqzaxMJ/g/?=
 =?us-ascii?Q?vqfuiF3HHqe61cqvZlUnjM4E39ZkRF47DIucIS3Zefsewbw/taIOWrpgioi8?=
 =?us-ascii?Q?MErbwImymWx04/wpOkg7DZZOGHhVlOdyBp/h8ZvcSpy+B7IjjJBhB+V1kjsP?=
 =?us-ascii?Q?+rSfPIiKpUf086rrkGr9NHQTY853TZn/oAfK+80P2B6xVIiJ5x0+t5H7Xyzc?=
 =?us-ascii?Q?X4RWJ+4D1btJl/UJnxFfr+33xIony3vIMkM54r04zqzN6w4c12mJiL0ajHUT?=
 =?us-ascii?Q?G/YjX+bUcvn1qLkFbsx0bQCJT5/Jv2+EfPG8eOthd6oz0CaEBzD8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177aff59-855e-4e62-9414-08df45e96312
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:01:20.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikaZXutK1E4/DirlrK4y7yki5vKo5jP0XkfWN/XpC8HO0TcxU9G5zC8zqo7CXypaigvpU/cZYgJUrGz5lNiAi5vQISokqfV0sNJ5UWdbuvy94VsrPVCqJKnLbNGCg3dh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The ingress port filtering lookup function involves performing a lookup
against the ingress port filter table (IPFT). If the frame matches an
entry, subsequent frame processing functions will perform corresponding
operations based on the parameters specified in that entry. If no entry
matches the frame, the frame is allowed in, and passed to the next frame
processing function.

In the future, the IPFT will be used to filter PTP frames and support tc
flower. Tracking in software whether any IPFT entry exists for a port in
order to decide whether to enable the ingress port filtering lookup would
increase code complexity unnecessarily. Since enabling the lookup when
the IPFT is empty has no effect on RX frames, enable the ingress port
filtering lookup unconditionally during driver initialization to simplify
code logic.

The only concern is that when deleting an IPFT entry fails, the hardware
will continue filtering RX frames based on that entry. However, we have
no choice. We cannot disable ingress port filter lookup because this
would deactivate other IPFT entries, which is obviously not what we want.
Moreover, deletion failures are almost impossible under normal
circumstances, and we don't need to be bothered by this minor issue.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index e1ec7aecab0f9..d7e96cb8d263d 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -618,6 +618,12 @@ static void netc_port_fixed_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
 
+	/* Enable ingress port filter table lookup, if no match is found,
+	 * the frame is allowed and passed to the next frame processing
+	 * function.
+	 */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
 	/* Set the quanta value of TX PAUSE frame */
 	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
 
@@ -1865,8 +1871,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	np->uc = uc;
 	np->mc = mc;
 	np->ipft_hf_eid = host_flood->entry_id;
-	/* Enable ingress port filter table lookup */
-	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
 free_host_flood:
 	kfree(host_flood);
@@ -1895,7 +1899,6 @@ static int netc_port_remove_host_flood(struct netc_port *np)
 	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 	np->uc = false;
 	np->mc = false;
-	netc_port_wr(np, NETC_PIPFCR, 0);
 
 	return 0;
 }
-- 
2.34.1


