Return-Path: <linuxppc-dev+bounces-25628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDD0C5AD48
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:19:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5nx1p6kz2yqf;
	Sat, 08 Aug 2026 13:18:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159125;
	cv=pass; b=BLF1aXBKnOk4JE5Lds8LfllqnLpEOay0VGNGM2RPOwVsV41FG9b5o8n9m12/WcSxFx+aBd1H19TruloTy2KwTiAiJleqQjh3db8ib5F/BkLKNCfdMgt199DTp9NXADdCIntSUXgvtjziahwkrIktFn/GadAwxB6OgjRd5zaaKF0PBbOEHZs43EKtopTlARG7MUR3L+TKBs0SoWpLtuE//UHzaiF+LYPEkUS24iUJ99BGd3sUeQZ14SxY3u7zvAeZZBZSfBg2bIzgEJ6yIyDXiODZlZV/4DAFl78fOC+aFNYJ4Bxl7qP4DNV7N+JzJOZSZnydsjr8c+YS1G0+6IJn4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159125; c=relaxed/relaxed;
	bh=KAVtJNH9g3NEaMcKUjtyx9tvn31sm62l19+8ELLY41M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sq0Meco4mXZLgFqCB++s683F2Nn4fv32TmBKlFiMfXFhrKRbaI7vjnZNrijzKlSGayg/RLdzRScvZnCi+aj3/RsHctpsvcvQkjUYpSbUKjGAyomTuM7u2FiI69+3SD+AGQ8++Rb2HTLHMXwHDbdOGxoFx99io3lRx3ILxQOPcaCRvwgCoghRE3F4aLTtcL2+i3B0i5r3ojKchPjOGhxEVZ+AxZiFtYsO7WIP7U+pFfbuQ4ro4ecL17oL1247nv9EKJVi9S0dGtnIH2Q/aGpKlf4372SW0XvM4c3+5KaXs5GLia3faOTUgZpcoItXnroVm0kCh7y0S/kTTqakqG6AUw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SylLgCBL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SylLgCBL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5nw2hdGz2yrM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:18:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRi/OnBLZ2vbJDgaM93Ugw1k0oaLv93MTlLinyminC4VtE31EWlrnOoaYlcByVo9mr1bfzBn21EPMmo8GRqWVME1QlxEtMrZiGRU7kNEAi2Guaeg8Z8GHxa3i4Of/3cYyzWxRoG6MkUk4Dbyi7Wh8mP1skA0t46Ek6+qDWbkYvefBQM5CMcfQWTnxpYeYA+x7pQWUbYey3wQ+4+cMuIlT3CiQzmjJBUuMbGy2wnHBQoQO7mnx6ZnO98fAvbfF5U4p6CiHtv4rBfKf2q4gOV8Gdrg+4GR9XMIH5nQfbBzINOQOFvRp36JLDKxu2uricYwTwdxlQJDnMqomFA/gchCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAVtJNH9g3NEaMcKUjtyx9tvn31sm62l19+8ELLY41M=;
 b=VTowS9Qg3EsoIHyrxYHGzFne3qQfK2RR7U0Q33EYfvzE8ofXOkWpbVbZNRcpjhPQP9Kf0VSlcgcJ0wFfdrhs3K1P8Lk1bQzXYyRlT2NJaVHKSfg13LroGc3Xz7p0p0hiJFkUe8x3+5Ej85nQbc82Ys4S1o2UkQ2Hnlf5WuVpvhlfbkT49/kWYogiQOudBoB9zuHf2NHz+SjxuFrXMqbj20xtIo6rYAyhR/uDmq6ZIXqMvNO8qgT2mIv0ZdPci8Nnj4ImKUDPL/F8mQhn6rZ+c+l6ZdmCqrTjp54JQMZZ6yLVLjZ8F+PMnfrzxlX5tILUgWKh4od02rRdXyqgMrEJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAVtJNH9g3NEaMcKUjtyx9tvn31sm62l19+8ELLY41M=;
 b=SylLgCBL7bEcthnakf/DN5tCgucnmK+hClqISRqfJCKuYqSDUQ8RsSmttIN67Sb3/22dxvhrQk0NI8A1lB3I2rpexjmiPoy7YKqJ6GPoK/dS/NSrbzKm3K+fRbwj1qQrvSQPyfm4HE1DqY0bHOXtLdt4c+dUftNPN7jrDAvOVUxJWZIFek+xKwkIlV1c+JuaMArCk4WJ6IBFFEhx+zGEQOXUCaX7XLOX55fVjpWz9FHjSafThl0jSSnmvoD8YSCppXlsfkoCx4XuXihPz2I6X8pRxZmiJ9P0BAmaAgdipnXghhJMrXlZ0yeKSiditL4xEG/Ek5rIrX8fPWQooKwqtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:32 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:32 +0000
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
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 3/7] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Sat,  8 Aug 2026 11:21:42 +0800
Message-Id: <20260808032146.2335723-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c430058-82ff-4d99-6b00-08def4fbb9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	oCoohc6QSUl9P9TMacz8luviTlMPL4zma0b94zORoffAFeybCdE/HmI+v1dhrQqgpjCyeqf5sWNhRvebcUXUEnASxOZX4TnVdrjJIZmc5G/n7FW7jnBbm8UGiJ1FqANbSF7FWSGHqznzPGYgzZSxwa+rGwgT1Gig/+g1YYbObBCBL8YEZ93Xx+bYz9KA1pfXNOmvciiPmUAVod9eHnvyRUs9iDmPgJ0jIRKSfsef+xk+m8uMRjXAkRS7aSfyPKFtE+PgBONj26jf+1O2DTwU6lgaSMZ+1xhyVdhGbIcXsLJ7Sa4ftymcclRP0wxB6f0DBh6DU/bL/5tlNZOz0AFUrP/Zi3lXVCIRnquA023t01MH1l9uwvEOFmyg9wmewuFNFMCVuVvRX0TqckASIRUpxn50x+wsTTMfcCENnwcOdtPM38bgRXMXAW8yyfa0Sge2mAqDd3v6T2ijkuYzAgPBEVnUJU9oBSVdvOgVLPaERODQmALdgO1UKZTS2f8n2Vm8sIxY28a2o4OF45uFS2EbyCtxI5v8v59vn2LhzeInQVKsZOaEqknRjfMqQTy7Y4sYMykvV0YV+ggpXTaAMFflQAMeH5EQdzkO1UC3IPIh2CvFnoLfEmwN7BiF/Vzyv20jgzm0mvfvxfwJBvXJugZwXTZWxUWKQwAzulolLNoT0y4Ny36qDJdGkCeM7WhKmBPX+AjoaPhg/6A/yiAl8K/kOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAuEYpmCc5sKTtc/w7Am4giqkz4+EK3i0ZvBxMuG5iUSHwUp2jpJIg1MD+jQ?=
 =?us-ascii?Q?CexCID8yhiYyupAxxXGI1XWnNmtFC4DVfK85wjijj1rg1qcWMdGMLW6Mzx+4?=
 =?us-ascii?Q?II1o+ArrPr1FOO6OB2Y86PJ4m1g9Bk1QE2k0vhj731dcnpQWNsqHTSGbq551?=
 =?us-ascii?Q?qP8sU36EPpdoXTVDXniv2oxnxvzpg0FczlwKqP7t7e+pQnhDyGUk+Fi9tflw?=
 =?us-ascii?Q?j9w1cs6smr3pqeJxwSayuzvuw9Oozl+4igLgE0/rQ7Yd0zQmkEiizNgfGotF?=
 =?us-ascii?Q?ayFQrqtzkxtmF44RBqXxL8HLb7qJZLezxWhuIGVngE0sVJ7fEqgQoYTalfm5?=
 =?us-ascii?Q?xSpa0NMOSsBQpBE3Q59pXOzRRWVIhLphn7Du7oNlTVxpqRzzpTAdzDSQ7zj7?=
 =?us-ascii?Q?iTFuw9Lp0qEO+Kx6jix5ypFvVFQfkizYJEtXzRlXsQ39R779SzeoDmbcvkuX?=
 =?us-ascii?Q?TfXcPKyaq9f/CSSr8vnaqmzSapTxOhlj3BiK2RrkV3eF1WUffOjHbcSBXWxa?=
 =?us-ascii?Q?HjhLQc1Z4ylXDfZ2OEaW2Q0GP1CdJDqv6Zgjh7C6IBWMQ6GanZJKvYua3Bm+?=
 =?us-ascii?Q?4dNMZd1M3XEXH7mG1c3AEFhovT5ClHisfyqua10kkIWuFuQIRm0R34i672PN?=
 =?us-ascii?Q?hQEvg9aHxfoXDFhhqpw2AyXQNktZZi/cDT8I0OpJnKCNaSG8sWkIRx/ylz+A?=
 =?us-ascii?Q?trVbgq64Igcecd2ou69L0D9vJ/E9yXx5DWKpzTWP8xezRbuWi8afYbLk6ajf?=
 =?us-ascii?Q?x5R/hpwTMFikXIbhHbcl6Qv0yI7AShlyhlplLaQa3jwst/W0eyoYdjJ30f2e?=
 =?us-ascii?Q?L8BQIs0GMyv1FQ3qLMlVh3rHbsMLRL+x7dIVXNlDjNzNmYbwfaFVzknu9jtC?=
 =?us-ascii?Q?ombFRcbT12Hpb6Qicau5rPK9dEjj5G3DHvRu06dGLB6iwI57OgOd2/NDCjGT?=
 =?us-ascii?Q?Ggw9kYBRlKiA54X2M8wjBVn4To1PzmAhFViOrR/TtGKPsoB8BaBJs06Id6W8?=
 =?us-ascii?Q?8uCGVQTQZxiItYCxxZOvTvCPNWx9YfOep1a41ilCHhDzhsYja15pCrF5WZmz?=
 =?us-ascii?Q?pfgf5zhjm6I3Lqt3w+veH8i7pp36M/6D5615xEn92vAYbeflOqAMHyl7gqJm?=
 =?us-ascii?Q?LmOIVBq4jDhXEjr3xWYbDk7LAYtnSZnq5LzmRy5/bbblc+DVJOiPNiiiBSHx?=
 =?us-ascii?Q?kE+1yxbaOiN5GWBZBRK+nLGkhA2E2wPxWDjQvisme9ncZCf6XeOhbn3e5ofx?=
 =?us-ascii?Q?li85PMcBo4lPtclMLxDVDsZLTZUfVjJPsxNk0HBuITA6mM6mFVegVPtql/UH?=
 =?us-ascii?Q?B3YzmOto/ed856yQ8/L81zDtjPSx/LOK8Kf2KgxTpAqby6QV9mpuuz23/jE4?=
 =?us-ascii?Q?CHL7OD/bu279sCmqaGPCUnkCv36c92iQYfEj+Y3bHLMr9wjp8m1U9eqf+YLt?=
 =?us-ascii?Q?xEy92ZPHQNWozHWCrzDc0bYXYdnbKe9l3tKCOXAyha7fIErrmk6u5+6iQ+CH?=
 =?us-ascii?Q?NW24MFIPEs6wIiTsK+4TH3beBhom9GMSoZwHNASPVMzn/rvaHhZUfmvGciDr?=
 =?us-ascii?Q?dKeQfkDGtAPqNtTGrqztOfStIfhe+RIEQRWtwpx5MS9kd9Y96l5HFenOaP7I?=
 =?us-ascii?Q?RZjKUzxKTV75wGiiTunzBcUq0T2MeiqcUj1NTAt/KvQ9y29Muz69eNS88JY5?=
 =?us-ascii?Q?wQotRm2aPwCOS3dJTvHg/1/LQgsdddvMGXq/+YeCdtDSGe/cGR6H6QPPT2G6?=
 =?us-ascii?Q?CA3ZF9WB4adMEBlVdl33662+jcEMRbb8J65JFLhopVTafiGhFG4o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c430058-82ff-4d99-6b00-08def4fbb9e4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:32.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DyFcU0hEP2qW3+DJO6wn0Ms7qaDBdZFxzNM4rCPe7oOqJwQLG88fJaZtXPuBaV+Xslql9QnhaXhFPF5d+1PZ8mIHLkIO1a0aodKPEqhXXuQDWDdM/cPUBPlDJL64RVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Wei Fang <wei.fang@nxp.com>

The NETC Switch does not have its own time registers and must obtain
the current PTP time from the NETC Timer bound to it. Since the two
are separate PCIe functions with independent drivers, add
netc_timer_get_current_time() to the Timer driver and export it via
EXPORT_SYMBOL_GPL().

The function takes the Timer's pci_dev pointer, acquires the per-device
spinlock to protect against concurrent register access, and reads
TMR_CUR_TIME via netc_timer_cur_time_read(). It returns 0 if the Timer
driver has not yet probed or has already been removed, allowing the
caller to handle the unavailable case gracefully.

Hold the device lock around pci_get_drvdata() and the register read to
serialize against concurrent driver unbind. The remove() callback runs
under the same device lock, so this guarantees that priv and the MMIO
mapping remain valid for the entire duration of the read.

Move spin_lock_init() from netc_timer_probe() into netc_timer_pci_probe(),
before pci_set_drvdata(), so that the spinlock is fully initialized before
the driver data becomes visible to other drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c          | 43 ++++++++++++++++++++++++++++++++-
 include/linux/fsl/netc_global.h | 10 ++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index d33c49c86ac4..27f85818d6a8 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -165,6 +165,47 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
+/**
+ * netc_timer_get_current_time - read the current PTP time from the NETC Timer
+ * @pdev: PCI device of the NETC Timer
+ *
+ * Reads the 64-bit current time register (TMR_CUR_TIME) from the NETC Timer
+ * device associated with @pdev. Returns 0 if the Timer driver has not yet
+ * probed or has already been removed.
+ *
+ * Context: Process context only. Acquires the device mutex via device_lock(),
+ *          which may sleep. Must not be called from atomic context, softirq,
+ *          BH, or while holding a spinlock.
+ *
+ * Return: Current PTP time in nanoseconds, or 0 if the timer is unavailable.
+ */
+u64 netc_timer_get_current_time(struct pci_dev *pdev)
+{
+	struct netc_timer *priv;
+	unsigned long flags;
+	u64 cur_time = 0;
+
+	/* Serialize against driver unbind: the remove() callback runs under
+	 * the device lock, so holding it here ensures that priv remains valid
+	 * for the entire duration of the register read.
+	 */
+	device_lock(&pdev->dev);
+
+	priv = pci_get_drvdata(pdev);
+	if (!priv)
+		goto unlock_device;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	cur_time = netc_timer_cur_time_read(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+unlock_device:
+	device_unlock(&pdev->dev);
+
+	return cur_time;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
+
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
@@ -795,6 +836,7 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 		goto release_mem_regions;
 	}
 
+	spin_lock_init(&priv->lock);
 	pci_set_drvdata(pdev, priv);
 
 	return 0;
@@ -965,7 +1007,6 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
 	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
-	spin_lock_init(&priv->lock);
 	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
 		 pci_name(pdev));
 
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index 5b8ff528d369..ace0bcde1e2c 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -6,6 +6,7 @@
 
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -22,4 +23,13 @@ static inline u64 netc_read64(void __iomem *reg)
 	return ioread64(reg);
 }
 
+#if IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER)
+u64 netc_timer_get_current_time(struct pci_dev *timer_dev);
+#else
+static inline u64 netc_timer_get_current_time(struct pci_dev *timer_dev)
+{
+	return 0;
+}
+#endif
+
 #endif
-- 
2.34.1


