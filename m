Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5A606A334
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KMDWqetN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX4D436Tz3cBW;
	Tue, 03 Nov 2026 13:06:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671580;
	cv=pass; b=Q34Nw7SLcVsqbBcQ88j2vIy9j0vFX9PY+VX8xU8hubbpgZAr2Sc53BzDc1EwcuxFBCmK8fevbN6mf6wGAx9NtkCAmeAUPkTOVTybO2G9acHuNw9I7KUmb15az38eZrU3azo82tu2lw8Oy15SHHrxiSHq6mYSZzFzw0erYebNiDa8V0Pg61dlVtYH68JXD+G6f0RSw0oaT9GX1+3Ogg69EWPZSpo/5zthYGHrWs1mLztB8o9VZN8zqa/PqAqeSm93l/oH0ZrmZshigS9ZQc9NqCmCtm78OgU1UVh25BjuCDONWXJHyafs1lTWq42D2LgEJOyuPN3tobnE1hx7PL8lsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671580; c=relaxed/relaxed;
	bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ibNKT+3iREmdBQaeiluRTq4zQeaScHaWCQWKUiX86D1WglDfnoS/93bteP6an1t0ul4AaS5GFv4C4IgG/vBNfNINJtM7Sq/qpCS6BLf7WKiK1MGv/wpVcuB25BesEWzHwzXO2aA0C3bgVOT/cEt/C56NNuXRsGm3VGou5H4tL1l0AvnGqW3McLO6l4yqW1JASgKm4nsUCfEFVrOq1bmx3MGf15hclDLrtLnUq+XcYr5IiV4b0F7SyY8HYUUQFkIJlJU7muhtPjRku/+/bWQji5+3QZs47+ESqOdb9eu9bs1f/Iga754RIouCDdIJt332xPma8YSXn5Va9q7qH7YuuQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KMDWqetN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KMDWqetN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX4C3lsRz3c9c
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3/STHAOV+87zpyf064RsjP1bmUGnPdtEA4obURMYfYx730w37W9W2enC5mr7fnuqh2BIaWSCQYYzVOlBo4c4FHq4rWT1rEt/YmeuZc5sSSsXEndTltiKKUMpy0qBR2qoNcIWPTiX8g6Me47mxXj29DSvYfNXr6+EUnFEwhPdnl/cJIwZ2tIyYfoj+yv9RdrwoeSFYbMYBNPusRQqV+UXWu720XzN1Fz8+tt19+/7NyyzBGf0g+mhNwY5XMemORHI6VT+vJAguv596/EAoQ7vdeHCk0JjE8w2hCn/u7e3no8tILqM48Z3H+w2O7o7hCFY5rsGHrJ3mYmdRLApdl42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
 b=y016hqKv5Bff/whqnWYEOFZab2Z3UmDfLkm2p77eQBzRM+PG6rbiGaTjNbZqrF1nxu5axp6IdQUxH33MHFkZR0FAOSaICK/Y8lTjMEk/v1h0XdvELNBHsW5JT3a3lJ43ldI2sodPqsa3ebdaIu08r90hKwZe+w+mrYrmWKSUvkNMx47O0a0Pv/NRA9oyks9HGz50EmG2ABO/YvJmMh3Z7lrQCMAUqn/bv+6cujA97VNd0MRNJIrdjKtMXv6N3uUmrp5vM7oop+N1r9h5elj6eskKSoXHM+J95DeD1U8h0rz0Isr5vF7gU2bxQsKaSBEyoWQJIWuNLLkFOYSkPRoZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
 b=KMDWqetN/mSH9VwWC5lmzXtia8dnmP6J5YGj0/5cRK9LZy+V1qyf1G/a/ymZewD4fPdsWXSbGsETxT7KPfp8QE97Y4oLEh9/gF91/j3dFh2Uwc7WguFla1hotmpYJvUGgxzDvF31DMC6+iUwVzGCXAkmV2MzhTWYDLuyOOR9+lZBgjmapfmAtYdadz35Ht0NWtEZSHgEizIM5CgDm940+1cdNE8mhI4DJ/PZtRi+kRQxF+MM3EFY7iEv64jhp8S2CvqwCtmzlNw2TteK9ChLg7RV7Vz1IUs7xlNyvM38eGIs3fcdrfIKWb4zOKEnpgAsJn82tUDpZ8x/dI1CICJzhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:06:08 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:06:08 +0000
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
Subject: [PATCH v6 net-next 3/9] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Tue,  3 Nov 2026 10:10:18 +0800
Message-Id: <20261103021024.3121936-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0334.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3e93365f-11ad-42f1-3d49-08df394f0667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003|6133799003|3023799007|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	tkZL2+SwBOXlRj32VkxOQEEgzYN5wTRkHJKe10S3F0Jlr7WEwREGxyZt1IEj6BApOmahz95zrKpsJVv01HDBtkGJ5/2gjsCjj4VspUA107X+oIshP1w8MdaRiI9yhij0OqVU4FMvfKsBVCIYKp/tm0IshzuuWrSt3287fk3adEeFbQeLT3SWEWrgmZMsebF/LplzoUXF9VrkoyrOsQjEXzYkPPN0quDZlgHJ3lP7n0TbefyqcDhth9LtGovdkUD3GU0HkM+0cuq7c4h6HRyVfF0oyPMHzPuRzcqPTJyo1IlXN/IcpTIrgHi236jy70dlAcFOfi0RRojZP82VdBNLaWda3AiSsn579oT4hCRPHKpYSofhhM92beO5WQeXS0hQLDL3YRCXL7WS3FFIl8IYEZEgb/EWNjnQ62ckUD+j7FKGxWuh3K1VJ+r+aWZHdmT1mJEEqLrWnwwb5k5QFWCtUBLUjVXX8WTzhqlWAkQ8ixrOrHeY6Bec4UM+VB2pVsB9z4B822J3eQYWLFJMdzJbR/1bDkPJg91RcyaGUTTqoneT58JEixAyho8mcgR91T19x2CVpz7OE0OeyqxhRgAE5cZ3uld4g1YvQAc+/YvDmMM1HG5se+LQp6NKCmDUbojEPpGvImcbma9fHMlSIYcsd5Vbd4o7ETyChM75rUgAwn6Vjuj84BaxFuiFZbSJvSbtOj0f38hvSEjveIAqeAMt8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003)(3023799007)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIFJkq20CnoAkgZzgu8oX0RPPdhj7djnpjqZ7FanORaocVt2sZvXUiEF5ae/?=
 =?us-ascii?Q?DU8CmwRDfs8Xe0LlVXx+8O6Q3tKRcsIGs/clheM5TRIMv67BsD4y7zZff68X?=
 =?us-ascii?Q?H8b43s97sIrEtXsgZDXNPlpaKkOVzOhb/KVGiN7dqD2iYPa51wxwuLKYHOnF?=
 =?us-ascii?Q?EHgqV9+D9tAYNgtw3Vr3ApPeRUy2NeB4VYpDUcziG/2plJgPS3Pm8rMWwkgb?=
 =?us-ascii?Q?a3/2AlfQzM3iXUJrcCy7+JhW//J1BrPMGG0urT88tnFjOgzCARYWD2eD7nU4?=
 =?us-ascii?Q?PnV7fTiPtPIlY5WNOfKqUd8ClXX5dfh+GE+ouuHqqVIfppgb7S0l1vk/JIZA?=
 =?us-ascii?Q?1IVVRwdN+WcFyqnyUlgFSRwX7NdekbHNzykfJ7iUDv04frRCPHJkNfeXDMx5?=
 =?us-ascii?Q?6z2ARPPIqmWNvsH4BoAnD1wH8bTMX9OWQgLmttsnRzaIbWYxnDi7hvxvEgGj?=
 =?us-ascii?Q?m9MDVaUgejZ7j6lL2EeMKEO25ANY7LLWWkAGkoakxSwhV+vxyW5ztYNq6dsN?=
 =?us-ascii?Q?C63PAHoKANWUseh8LSo7uZfwgxGaQLspU+eED2sA/ruRD+3Ao526Cc0NLkA4?=
 =?us-ascii?Q?BKL2MJcI+vEmQ1fos/lKA7YL3r0EYnAsATzps8EvHjo3pljyPdI7n42Kfwxc?=
 =?us-ascii?Q?crA2NMZjfcBuW0RQff1NfNEL4J4zKfoQc5z/1Q4WlqbA4ctru2+yX5pRlKda?=
 =?us-ascii?Q?i1H6vherWFTRULhvI1n1WxzY4VTgNYRfDuG9ndGmJK6MaFHGxfkuLojKaGvJ?=
 =?us-ascii?Q?Mf264cxSMmLJCpaIL9r8V/NLMrhAXoO2yKk8OWw8pDdK0gvu+uUl0kxHOq9/?=
 =?us-ascii?Q?22k84V/WPjtBZuUcR1TE5Oa3hz17IXIk+Lh28dsuCtF0cIOhOXOWLXRWOa3B?=
 =?us-ascii?Q?nVHHFDj6CE+1CIQ3HHDmBhdO3pxL8n5BzQx5iRXyEwwqj5t5kP1qN+2FGPxL?=
 =?us-ascii?Q?zm/IKING2VskK9EsbqONmUApc5jbK2o7W+BSc1l0ESg7bCjDscFVm/5DBXBg?=
 =?us-ascii?Q?oUnPRdJR99pU1Whw5+Y+CEI3/1GTX7Q/aWRPbxixvwbU2Vq40BTRXd8aF+ct?=
 =?us-ascii?Q?mfrsrZUPfW33v5IXu+ckCZQjmEGyKLpsP8tnM74A4inGFw/8d6gp5Fm+mp2s?=
 =?us-ascii?Q?0WUBQMHAC0RmSgs83C6ztDNVkxrDP9Y57jtUxDuhoEjInEyuG2ayTmK7PMys?=
 =?us-ascii?Q?TPxyr3YUZAztEePB3HplGm76KsEvaGev74OlmBwV2FOBchX9Q5qZA7Rzp5vD?=
 =?us-ascii?Q?mk4lnKMR2k+iM7jkp3Ozqthp840QdUhA85ifpgFMZ8wDTMx+fM1tbMA1CUee?=
 =?us-ascii?Q?6sNTqeqXsjMwQM6z8XVMsQz4iECyho7OgXtZHqQZTircne6m1H4qHZDGtuBC?=
 =?us-ascii?Q?OA6RwrQT++QRJxN6lKiyE/HGJILZ8L09u43XmuGK1+ClV1U1GO4dxoBKdss2?=
 =?us-ascii?Q?kFjGhtLwJFJhxBVW/0SC+HoM1kJ2hsJqJCjssLF+fcdGn9fIjwaA1Klc2RfT?=
 =?us-ascii?Q?qy5K00+CRkch1cQUN9UyltRRxh1jtdpyJ6aIPTcp7uTka7EF/oFqF82HxSxW?=
 =?us-ascii?Q?eyTlDOsGyVwijUpvatn2g0sbiNd/kZIqalVIDEkKmk0q73OYpSKfho4c+7pA?=
 =?us-ascii?Q?lJZXoTRhJ2aiwx8To75z+ycjemJU4Y6jM74HTOi1H4Fs7G9bq2W/HKjzhAb0?=
 =?us-ascii?Q?lzXxjzw7wDLI17BE5idXGT681s2HQMwCX5oIJzyx3/NHg9lYsw+ISa663i88?=
 =?us-ascii?Q?0VYPECVFLdauIzUrjO4GZ6wWYqDg7UkspmTKFrv1z5cXzRHWHNZ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e93365f-11ad-42f1-3d49-08df394f0667
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:06:08.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkGmsUZlJnrh+hjmJUuakN69mBGAZKBlixDDqktpQVWjVMld9qTeXx2aSOS8/kUhrOVOH6NC8/0m5K43Nv+cmmcXAKYjZyXgTPukdGHjdioyEaZl7P3/heYe13RW/mjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The NETC Switch does not have its own time registers and must obtain
the current PTP time from the NETC Timer bound to it. As they are
separate PCIe functions with independent drivers, add
netc_timer_get_current_time() to the Timer driver and export it so the
Switch driver can call it. There is only one switch in the NETC IP,
and it is the sole caller of this function. ENETC driver will not
use this function as it has its own time registers.

The Timer may be unbound while the Switch is calling this function,
which would free priv and unmap the MMIO region under an in-flight
read. To keep priv valid for the whole read, track each probed Timer
in a module-private list keyed by its pci_dev, and protect the lookup
and the register read with a global spinlock. A list hit proves the
pci_dev is bound to this driver, so priv is valid. remove() deletes
the entry under the same lock before tearing the device down, so no
read can observe a stale priv.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c          | 63 ++++++++++++++++++++++++++++++++-
 include/linux/fsl/netc_global.h | 10 ++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index aa9be8e2a630..c6170f407090 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NXP NETC V4 Timer driver
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/bitfield.h>
@@ -123,8 +123,12 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct list_head node;
 };
 
+static LIST_HEAD(netc_timer_list);
+static DEFINE_SPINLOCK(netc_timer_list_lock);
+
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
 
@@ -985,6 +989,10 @@ static int netc_timer_probe(struct pci_dev *pdev,
 
 	enable_irq(priv->irq);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_add(&priv->node, &netc_timer_list);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	return 0;
 
 free_msix_irq:
@@ -999,6 +1007,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_del(&priv->node);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	disable_irq(priv->irq);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
@@ -1021,5 +1033,54 @@ static struct pci_driver netc_timer_driver = {
 };
 module_pci_driver(netc_timer_driver);
 
+/**
+ * netc_timer_get_current_time - read the current PTP time from the NETC Timer
+ * @pdev: PCI device of the NETC Timer
+ * @ns: Output, the current PTP clock time in nanoseconds
+ *
+ * Read TMR_CUR_TIME from the NETC Timer bound to @pdev. The lookup and read
+ * run under netc_timer_list_lock, so the Timer cannot be unbound and its priv
+ * freed during the read. The caller must hold a reference on @pdev.
+ *
+ * Context: Process or softirq context. Must not be called from hardirq.
+ *
+ * Return: 0 on success, -ENODEV if the Timer is not present (not yet probed
+ *         or already removed).
+ */
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	struct netc_timer *priv = NULL;
+	struct netc_timer *tmp;
+	unsigned long flags;
+	int err = 0;
+
+	/* Serialize against driver unbind, so holding it here ensures that
+	 * priv remains valid for the entire duration of the register read.
+	 */
+	spin_lock_bh(&netc_timer_list_lock);
+
+	list_for_each_entry(tmp, &netc_timer_list, node) {
+		if (tmp->pdev == pdev) {
+			priv = tmp;
+			break;
+		}
+	}
+
+	if (!priv) {
+		err = -ENODEV;
+		goto netc_timer_list_unlock;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*ns = netc_timer_cur_time_read(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+netc_timer_list_unlock:
+	spin_unlock_bh(&netc_timer_list_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
+
 MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index 5b8ff528d369..d4a26c17f99a 100644
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
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns);
+#else
+static inline int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1


