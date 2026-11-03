Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AA606EE8E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JaaFRmwb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX4B1ccpz3c7S;
	Tue, 03 Nov 2026 13:06:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671578;
	cv=pass; b=do2yMGc9w1gb7RIL+Kvf6RQC4+9tAvKMKjv3HZ8Cd/XF6vr809T59FuDK9KVDdf4Qgra6Po+N7i0ZQzFTZvkBui43+11KHE0ix3eMmZOl4o/Nm071dXMelIooNhOCOtlOqXxFBiavguuqM1FwbMLDpeNWC7nf0GSiaNiqwBdEoQjA0+suey7NcaKlRzrmualUo6mtT583Sosgt4YjdiTBm2f/Xg2iRwzqMrsR3CzLbgkO16PKgh2bYXXBOrGwmW6jY3BJnND6WbW2oN9wE9iKDMUVaY9eN+bfjwFMy2GcGa9Zqsd1h0eJAGcSmfZovaf+aFzQZpYIfjBfBVxLzMJ0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671578; c=relaxed/relaxed;
	bh=WwlXh3LktFHI7zSBsD/SZac3qhtr52wShddo+pQGDSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dklfSK8HLLQiyC0f7eKo4wQIZuMGRnxIetH/nzDTzc6yAiwOc/+K6GU51X4VFmcQjCDGhlODNVoqipmWMcd8nLySOp2VtXLwVN2mjIxKOlxJw29yBk832DD/t0lPtYG4t94nCqWyh6Z3s1UovIEeAYLLIxugQTmc11MlBQh5VjgmvefBwgRiMn7a45Dw9vp2qzQzbwbzFRjdiLUeLH+KkFeBRsLMxTbjwnbwL4b/KxuKPZfagHHV5F+Y5UD1YloP2n9qo03tzg7NCmCdE4FPqTUkxMnhNLGfTVIO/6IyxQJvqz76JhS96GTIMInJ7sZkZGETF/tRYDbt9TbG2jFJlA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JaaFRmwb; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JaaFRmwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX4915lJz3c2K
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnO626ai7GZXjUXRoaG3n7YOdAJoRynQwQZHHWr4u/gZQuYh4sHh5hIFEidIKxMncMtagwi6XG/WV1ueQgjsOSDEAKZwB6F3DJwBUGZORkXCSGl7JYWvE9NQTTS2NmirABKz1lCiQ4+mNc/idZ/1QxUyXaPr5RQ3lK2PGSp5IcS+hlbfNv7zCdD2IHwfZfH3Bh36bU36q2RrUcaAmDh0yej1Iuqwuy0OhE5MZohSdejMpJKjuilfLsCfKQiZYynWQY/q7gL+hwJBOet4BhS4BPpjvgTDybo17l9Ck6Fq8e7DDAqi1gMwa7v8ocZChD3KEXuc2O6w5DJS/RaokYEQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwlXh3LktFHI7zSBsD/SZac3qhtr52wShddo+pQGDSs=;
 b=U4cuakCgOP2xZkCcHR/e/H7+Ge/dLd3UZDZLlkBARqUgZM5DSAEdsbP60mN518AQAwf1DhBndLMo9avY4n8EmSWoar+/fCa5MNkBpei38iiHedXPpdKGpiZGt6D9KXCQw5ZdGPT8i0kiWZIDxFcxQxao23PiWTcUuMWJHL5NGOYCw5/RkO+bURUMUJblSj5r1/A3kEtunkSeebsU11i+RiebL4NuQY9gMrWso1HMPhdUeQ6G4UwuX9F1ijNJbhfh/mwI50B4k7/4jzc1YSqLRUw1umsxKaI1bQ4Wdg7xTPzmn/rZlIU0Bh0qxkvTZR7mM/gMtt0/+svvChM1Y5e1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwlXh3LktFHI7zSBsD/SZac3qhtr52wShddo+pQGDSs=;
 b=JaaFRmwbRE2tx0T+rUeeDxtFm63ZJ3kXT7Oc+5jZTE6Ko9/1+zybSzS461uwwlNKEQxOVcT083tn1+0biSQgTzMOGVzwSmtGkHT1rx5mv8bFbLPj3q80OPi1+s5aPk0pqiJWyHZJu1WVbuLI3uqpUE0PCU+rdbCU76ODBM5h1sa/OeLoE7P2bTwFg2LWYeANKl329p03ujvxAuAqd6BTzMf7nI30070bSwZ82DLJIXmNhzUYSIzO5hReT88zvJhbnBcwrpS843pN7psamoCfVZTdrl84/d6YoZQqehPtXgacaOEnYE09sZGtIhBES6qSAp/XzUT4JU7fHHX1kVfm1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:05:55 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:05:55 +0000
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
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 1/9] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Tue,  3 Nov 2026 10:10:16 +0800
Message-Id: <20261103021024.3121936-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0162.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM7PR04MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d010c8-f80b-4d8f-fc75-08df394efe93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	HEFR6NHDGh5bq71Nj55jodOZWs0VzVucL1zmBiASWlbGgJ5xAAXZ8Me2eSR/mJAIWtXTClGLHrNztWFp0NwbaFhDbJ3S53D8oEThGmSnB/WKgkErocLfyrKvjJPeBuV/FRdK3EIiqTWtvP4iL+xpE7+GYHLiKUozWi3lNc/oq8Hqu5+qDDJTaob0c72QJMUZ1eFCSgbQvWBS9tFysDUY/tog/FGIhrKV9MQ9h5m8s7GP/PKIEbrw6zO1canp7A+uiS/h6hI8WHLXS3Rb4brC8BSc5ixJS0ei31sfsuLNmjBJdJim8K9Ktiy+AMBf0EiT/4svdYnu7MzuhgB29hNvTZiH3uiVQF7KN1pYqQ5L/zB02Q6IdslYEkPzJQWvK/545bA0sIF+JdQVA/HWymfnDe9Gi1VHh3Y8NRbxPvZ/i/iUCMjnDo/MV1DR+e8bK9eG2sNORw4UkcWvcLeNGpRnzJP3P2CPrj71FI87RvEKRxaWk9TCYBRqdkzSIydvQTYznncUHJTRGc0Kdi4NN5fVyJKMBt9imrEI3aCxA7Xy/ZHZQ5oy76NMhhKzJaSckDcRffPNnBMtp8BoesAtZ6HslC+mjaWl6SMl8aO6zCOTjKEin2GQGVd+eO5IMoGfk5p3hpO2qskkL9Nj7EVe5F6enFKfReRojNAELR8eIBXBncYs3ap/EzJCp4wAc7pn78CTmko499tKaTf0XOqjB5PRXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vgpxSKzEMmxYmQYCOxoSrRbHyNko+8pnfiw7kCZGJNfrJFq4uMRoBO0nVCa?=
 =?us-ascii?Q?o4gO9S6s9S5czSN/zf6aRam92lpmbzPMzr3oT/y89+3SL7+MwE8bC4pd3NeB?=
 =?us-ascii?Q?dOXyapnqcNR88VYuudkr1SUFmB2grezP6I+e9yPudoPsY4Pwy66rpSQsf88k?=
 =?us-ascii?Q?fp51/mcNQ6eLDNXv9OFYHIjw/AlSRSLTdZwHDOSn6LJ9OvjwfaFcikseRtSd?=
 =?us-ascii?Q?DBcC+3y3OCjtg01yxUBaTQLUng0hJum/oGytNUlXIl9ASqr9JWCOLPdxX3fn?=
 =?us-ascii?Q?IRBA2lwwjfVgaxpi5z9q4yT8Kc3fU5Tqe5m3U6alp0BO+NamMkSA6ZgatLqB?=
 =?us-ascii?Q?GPMsbzjqYYEGH6SNB4o7W3XwdnohOe1AEOLE0ZmYlTVOcwRI8XONQLb3iNwP?=
 =?us-ascii?Q?lMjaPFiL5FQCcP/ZtbcT7psgFa8waq5/NNKfjb++v/voTsR70Cdi9jHXuNbC?=
 =?us-ascii?Q?mhxPG/HI3m3HQ7CgzqnXSPJTBhN7GTOmx7hk/Aku3rT16e0nYMJSOQUoJzjO?=
 =?us-ascii?Q?pR4E026SRLoNfHsANQyhpWVGJ7TAziG5nWydd9jD8mWWAF4wMR/wR3SX4wbH?=
 =?us-ascii?Q?M4eweGoHSCgByrDWLQLcw124EFclX2XSDb1EbwgCbZ0Iv8df37cLhDqxrGAM?=
 =?us-ascii?Q?d60K+VrVnRWNYcHISSsHO3W0ZDXabcCS7NDT3p+TCH28s0DzbKdEbib6WRRS?=
 =?us-ascii?Q?33+/hMUqS+XW0GAkc32HC4MRIGxOLYQ6ThgiyjATmcINENxJ7GeKz7W7OgwF?=
 =?us-ascii?Q?2n9sdxytkAfzx1OF+/5PI1EFNkIysbI+kGAuziVavUP5DgdcMM4ZtFUCw2ZB?=
 =?us-ascii?Q?pNynxi59h5hA30WQV2fw+Qv9Rx9Jha5RRaOuOBV8+dU0DQJ7DxhFfdtq0EkV?=
 =?us-ascii?Q?EQVKv2C4Lwxr0v2VmtRQOwX0By2mNyrvc0fvW8GiMk1XX6h4snjVF/6HtYbJ?=
 =?us-ascii?Q?OretOt2c0WtfJk1zoHQ04v/FOAiTjE5hAb6SmfqXeqUXzqAlFLSpodWGwquf?=
 =?us-ascii?Q?/ZaBdsMlru8027CE0jkuGDAipyA5qw6Sq4c2SMrclSJXqaR7cJjLR8qFMtgT?=
 =?us-ascii?Q?596txP5+i6J0HYB4MwoQmi/NFc7PE3Xk1gBX0zgxQ8AF6jngyXlnQvCvVLl4?=
 =?us-ascii?Q?WD7XqZQ7I7isSasCYwVbOoPuyjwe+4ZPetxEpqWEO88O5TrngsptyeCFhXWl?=
 =?us-ascii?Q?ZSb/KedOizwjO4aR3WtpKGL3P8Y/aFBmHzm0M/Md0/pJVqhQ8rv8zBUiljPA?=
 =?us-ascii?Q?DUaH46LkOA93hN9fIqWlEuQWz7b8jdebxVd/DyptgUHIWSXnBovyNQ4xjH8I?=
 =?us-ascii?Q?CwPqtcEMVBYxu28/83AgzLRmH1B450UsCzumO86s7lwXIJCZ5WWWfEX1DBxo?=
 =?us-ascii?Q?uux7W72YCCMmi7x8Q/CEmwX74r/kiVAid0ZgnXhsXd7qCXt2YuQUklh6I6kF?=
 =?us-ascii?Q?yZBgLxKiy3xbgya7yHjD6lHv0QeSiBmFObm6hX/ossGnCO3c7cUv73Cqr6au?=
 =?us-ascii?Q?aqkOY0emGHI1a7VFyLbYkM2H0RTWyZUvau1ssoDEEELWqrRDjfGBy6xX/O1c?=
 =?us-ascii?Q?YsIC1dRQhS8LutG1h+D/4RpFhYgWyPLX0rlr1i9h5rNo35o3NpfRLd0fRhzy?=
 =?us-ascii?Q?IEmfPOdqzF/xgjkpLxQdnvU54LldOH4gqhbKoljhNKYcHwNRKfZ+e14pMKt0?=
 =?us-ascii?Q?nbxiQL58mR9dkzhgcXl9wpFtnl2nzho3UJs0r58XECccTcWhg0EDj84YbIde?=
 =?us-ascii?Q?ppCDo3eRh4RVbOFCmt9mbgLgwFxF7VFfgqNVSLz2eDpHjVARwZdy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d010c8-f80b-4d8f-fc75-08df394efe93
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:05:55.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6dXmmnjUMXleSZ9Kz9iZnh4U+sZfVe4nkX/gZRcE2o/7x40TjTcxiFbneuhHXCpzl5e8UA9Vx48EePGco1+M28wLSIDtZh6OEYpHQgT0VGs5YZ3+p7a/TIZoPd9D44g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded 64-bit register read/write sequences with
ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
them throughout the driver. This reduces boilerplate and makes the intent
of each operation clearer.

The high-half register defines (NETC_TMR_*_H) are kept to document the
register map; they are not used directly since netc_timer_rd/wr64()
address the 64-bit register pair via the low-half offset, relying on the
hardware layout where H is always at L + 4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/ptp/ptp_netc.c | 72 ++++++++++++------------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 19ca99d80e95..376b3b0d1a38 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -127,6 +127,17 @@ struct netc_timer {
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+
+/* The 64-bit timer registers consist of a low (L) and high (H) register pair.
+ * Hardware requires a strict access order: for writes, TMR_xxx_L must be
+ * written first, which latches the value into a shadow register; the write
+ * to TMR_xxx_H then atomically transfers both shadow registers into the live
+ * counter. For reads, TMR_xxx_L must be read first to capture a coherent
+ * snapshot. iowrite64_lo_hi() and ioread64_lo_hi() enforce this L-before-H
+ * ordering.
+ */
+#define netc_timer_rd64(p, o)		ioread64_lo_hi((p)->base + (o))
+#define netc_timer_wr64(p, o, v)	iowrite64_lo_hi(v, (p)->base + (o))
 #define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
 
 static const char *const timer_clk_src[] = {
@@ -136,66 +147,28 @@ static const char *const timer_clk_src[] = {
 
 static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
 {
-	u32 tmr_cnt_h = upper_32_bits(ns);
-	u32 tmr_cnt_l = lower_32_bits(ns);
-
-	/* Writes to the TMR_CNT_L register copies the written value
-	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
-	 * register copies the values written into the shadow TMR_CNT_H
-	 * register. Contents of the shadow registers are copied into
-	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
-	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
-	 * register first. Other H/L registers should have the same
-	 * behavior.
-	 */
-	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
-	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+	netc_timer_wr64(priv, NETC_TMR_CNT_L, ns);
 }
 
 static u64 netc_timer_offset_read(struct netc_timer *priv)
 {
-	u32 tmr_off_l, tmr_off_h;
-	u64 offset;
-
-	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
-	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
-	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
-
-	return offset;
+	return netc_timer_rd64(priv, NETC_TMR_OFF_L);
 }
 
 static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
 {
-	u32 tmr_off_h = upper_32_bits(offset);
-	u32 tmr_off_l = lower_32_bits(offset);
-
-	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
-	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+	netc_timer_wr64(priv, NETC_TMR_OFF_L, offset);
 }
 
 static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 {
-	u32 time_h, time_l;
-	u64 ns;
-
-	/* The user should read NETC_TMR_CUR_TIME_L first to
-	 * get correct current time.
-	 */
-	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
-	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
-	ns = (u64)time_h << 32 | time_l;
-
-	return ns;
+	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
-	u32 alarm_h = upper_32_bits(alarm);
-	u32 alarm_l = lower_32_bits(alarm);
-
-	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
-	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+	netc_timer_wr64(priv, NETC_TMR_ALARM_L(index), alarm);
 }
 
 static u32 netc_timer_get_integral_period(struct netc_timer *priv)
@@ -500,22 +473,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
 					 bool update_event)
 {
 	struct ptp_clock_event event;
-	u32 etts_l = 0, etts_h = 0;
+	u64 etts = 0;
 
-	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
-		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
-		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
-	}
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
+		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
 
 	/* Invalid time stamp */
-	if (!etts_l && !etts_h)
+	if (!etts)
 		return;
 
 	if (update_event) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = index;
-		event.timestamp = (u64)etts_h << 32;
-		event.timestamp |= etts_l;
+		event.timestamp = etts;
 		ptp_clock_event(priv->clock, &event);
 	}
 }
-- 
2.34.1


