Return-Path: <linuxppc-dev+bounces-22443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF23CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 02:13:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbR4k2TKqz3c2C;
	Thu, 11 Jun 2026 12:12:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781143974;
	cv=pass; b=ky24UY7CGZZ0so9E5By1UMAL7qGJPQ5Ajg0haMGl/wmxWCqccUHDMVYsRG4Lif+YjaDr/YDuv1ctmnEfBUfwHMhn2T3mFucbLhKpBtixxZ2VSJSdI3ZGjIG3dVbgqgmcdurz7Q1llO2qQKqksYYBSGlAz59Q4G4Q4One9Kqu/Mb0YOD/+ffhJKccgOhBHawBOvH/+1gdAl0ZJsyhoOyG7OO7Ifq/Rpb5tDtKRr/4mAQv0GqcNGktTy95T3+I5Sn60ecuR9YQHfJg5gtBxYqcejoRCVzXgu+MRIPL4OwwEaLgOqJUrhrBqHvmygO4tIexzcQ5bHEBRPQ+hGm2Sgx7SQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781143974; c=relaxed/relaxed;
	bh=GYratbSc6Zqs9qQS9yjjla+jEybP/5Kl0fr8P+NNkB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4+5/uV63UYHdDPnV2DIkjsDvVaGtDXtI1xaWf+bfJ58M5RtfWN/JwynP2Gu8hruOVorILAqmB2vAae8oAuqgJsW7WAc543cnolF+sigI6CIesUaYZaa02b9V0cU0q76i2m0MZcSzaQc+lJJuNXWJqFwbLP8OkxGof0pPtvkcmsAVfKOaetuJucroA4F/MeWu5ZpR5Q0tliIHpy1y0Eexvu5dw5R1BR9fvWe9/V9YCLJHH5iCjPCEMNtQtwmjJPTV1lnYV3k5Ompbv+n1Zgo0lw0ThuSKBCXhkcJXriCxaSB8bcvdn2FlsZbMbZgZoGjVukuvmOvme1QnRW1tr5VjA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=INK/C1ew; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=INK/C1ew;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbR4h5xd2z3c01
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 12:12:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdNA13RB4TzsIgXvnBu9oKkjSZz4+NX4ac4YrYY5JFwLyIvlEikJxU6lQFDAOo3ZYCEJc9RNo2brgMqW4Hb1Zj613PAAwjhGn+0tjxRZ2SdHIlZGI+bfIrs3u/kfysK/Wpmg4u4q4SbMu9WLnu11VGITr1plkOUSB63TojVHgq8kz7GKu3s1hsgVqEFhTLWxVmSRikTn1Ns0cmZtJu2X+6a3jmO34uJnJqjNnl9zNsCwBzbZI8+CCXnLNw7T1QPCBq8NGcnt9VTlngqiZEcC8aSqsxoC/vsWWBUsMH8YQtsB3E5jMxMb31IAbFDzSt91GJ8VuuMe16ZJyEOla5NrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYratbSc6Zqs9qQS9yjjla+jEybP/5Kl0fr8P+NNkB0=;
 b=RkXiRJF8Nol7Zx6Vpyag5Uw/9Rn2XyWBe72oNUm0HqoahiMDw7Fvb2oYw0NNBc5gV3r3RFNbewmHDRjaJfNaMJ+5huMepywA1qiHBcaZOOyxs4gj6i9RpMdY8usqk813/OHvREcpVVhsp5cn1nfuugatFmfZsC0sJqpAWyt0UYBe9aO5lYntJB8IfdOJ7uOl0zK+StgLExfp1oHBn2X/K+eRbqXXxFVbQw0n0I/zqalS4qhZMQO4xBSDk8QXE8iXfWV4dN10YxRUrAkQmjg0w94cK9cu+xeRZJ2x20KDKfRBNafT8XxTx5RjlK/D6fsHXCYFd+j7/MtlBuuE1Xikow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYratbSc6Zqs9qQS9yjjla+jEybP/5Kl0fr8P+NNkB0=;
 b=INK/C1ewjUarIcl1VANQ6wYIy5AjTfSN3C+irMOT1jIhZzO6KktZJKxbmFBUEf4L9Nk0KbkgrfYABwsBbsID0zJtOSC74g5a3uazZhsa06TlhY1Z71LVQ3Bd05vIOg2qoNEUV0GAy0WAKnNb73lQYmw2fR8qN6Xr+8j8pzT+8PhXMaltkBmcrSz0R7oiSCz/G1rs2oqSFjdNAGIL0yoVt7lHtngczctl5CD3JZ34e+87AUM912y4ohN3Cn8gmHK0+KBOjeKwaWI3pLugWSUuhjlZ44S88CKovadEo5XZQ4s4+xF7WMWK5ZL/sT6tjeoKBbglSpO0Ig1IRW05mVlYzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:35 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 7/9] net: dsa: netc: add VLAN filter table and egress treatment management
Date: Thu, 11 Jun 2026 10:14:56 +0800
Message-Id: <20260611021458.2629145-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac93255-a809-496b-f5af-08dec75ee6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|6133799003|22082099003|18002099003|921020|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	3NJfZiS2N8U9uqA3HcB22gV2/Zg/e2jGyEn2AOQmTczB+e3e+NGHToL4FFMu7hBJ22FL695P/aM66nIXAhSJQMPFbyjflIYUQHh9XDJqbrxfNM6t2OeYw3axJ21GJS/LDIInv2BWzxs6y/p7o8gl31j4Sy+gbdT1nuXmFG4ypaNumhWehcP7z7Z9U8xIhHqyUix3zrBt655IEZ3Ly2pu16b1JGgcmRneny2YWye9+Lx5jNuPsuWF4ffJAKeDM0cUNdBHoYotVUhMWmM8OiZBdPqbu0lhoCLNEvXit6CtojvSkuSeuacfe9lHPS/bhI9AkzycO1P6HLvxRY9Jmc2JkKHARasge9YkdYFC6zHHRMXDV9gHdMyjdvnXTCUYcGPsUdmoEy2dByg4Goo8eKDPuQfewV5Ve+juDVrHBa+R2kzIXw1epeObJD/hCRovSFU+AbcRzZ3cGwa1tmrMoE99iPPOpZgF8zOMsHOuE/0F9eXNoDd7e7z/ZKaiLrV8JVcwPYQvFy+g7TP6uSRfv7PBhAxrwjZAphuX+PR9xEi0mLdPJ4LWKnqYzxtYxTLvuChMdXF4/JyY+SKR5v0/bPHPXxQIjhB0/nkIXzB6xOqCy4CV5tFRpday6VdQ4EHM8pwCCQNBlaykfyl39FkeiShBkFo6751L2iQz44UzQq2h24hI+LV6fsoEhXQxn49xtFTKXysKk44gmV0mxmrzN+vDo3bKNcIlxov7kUqz+XJ8mog=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(6133799003)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UmBn19oYkPZ0xDG5jnTfIT9ZweSevec0pG9Qvhl4u98X8C9FU+b+JzV9QXtq?=
 =?us-ascii?Q?Qv/F/a9jw4C8FIGZdlNws1GkbpxDTejSKMHnX+QJHXaY79M4wFe6gg66IrXC?=
 =?us-ascii?Q?hRJrKUP2ZwrcR1o4rX8Yxs0gHPhR9bts2Bb37H97cpxrw+KCBYGo0/OjBzFJ?=
 =?us-ascii?Q?no7XehslbyYxKsLeavy7RtVOFIBWTV/DcGTD+WZlKTuEhD34JHBMNA8QLKsd?=
 =?us-ascii?Q?xKLUFMLmAP4N8VfqDWKJXnrzT3NGktMDhNDOA7HIPmtNC0K88og5BC1Bxaku?=
 =?us-ascii?Q?sbHzqsiRw0TprHnOLvNH9ugEGGtMIAf6dy+d+ODALcySoffWbrNIpH0GMBtK?=
 =?us-ascii?Q?+feTAcKpIAVD+ESxZ8seUMm0e578isR/ipaWzcc9BXmjBvw+YuWqQQzu/d+4?=
 =?us-ascii?Q?b117wIK8EPj4NW3Ip7xAZ1ZgdJc30o+0gVwzFS1ZYbg/T8P1OqZrnYbwT4Bj?=
 =?us-ascii?Q?TwftgMV6jnjN8LqNJgBTQQxPyGH1C98Sl4n4lZyvIUrvYEEd7F3QoPjkdFwr?=
 =?us-ascii?Q?9t6GiDV1DaCNIXIjNqiIRX6f5KUxf8qELa94kng2s33vJQkkwVAUCIpgF7L1?=
 =?us-ascii?Q?ZRAIm79Ahfwox4jYf82H7byf+vhhXmnKiiwkBymnn6xfglfyTHVMPY0HcaPO?=
 =?us-ascii?Q?zPYbpW/D+aD01lkJURm4YHbRlmJIY8itxgclCBVYimeG7I+096pGAI6D02Io?=
 =?us-ascii?Q?RARE9p6Lcu/sJ7zVLp8I5nF3cNp0ZE29e3GrY3gO6WIM5/USoKHicycELdFW?=
 =?us-ascii?Q?NOIf99zLEjCclQ6LfQH7ouuYdzpNBvxfLTSyKh6k5Ic3rYNQNOoL6SaWThbY?=
 =?us-ascii?Q?uvZKscx/usRKPDSUzN5vZ+uLtrpLkkTfR159Z+gXu4z3zrkTUf8nXlhyIEJm?=
 =?us-ascii?Q?ZJCxkbFDOZe9/bo/E5LJ5mq94VcbLxAqSbpKUQ8Iu3xcfzIpdMyjXXWfhyQ1?=
 =?us-ascii?Q?v3qF2lfg8JcFsiV195AP1vpBx/a82ou/E9VbbVc1QRDfkWvqDgxtrqQ/aDDO?=
 =?us-ascii?Q?QgIXcGOiYOLn+3eGoXhOX4udzv0ikLcdvifsAhZ3TH3r1U4CfCokuXOGK6cs?=
 =?us-ascii?Q?sCf7X+5pIt6+ATwFSMo4FO1U6OQJLwvSW/J81BQfCBmaijzXs5h3yuDTo1ij?=
 =?us-ascii?Q?C6iIQf7oQGvVdrMXhLjm645X6z/2wokLDTd4h0yu4hK+Hfo7HszLCa0vawAj?=
 =?us-ascii?Q?85gl9xidGfsswVcZ2CKRQaQ03R/93apR8zJsrMi/wZauDz5fJ9umNGuripUz?=
 =?us-ascii?Q?VIdApr40ls8nQWJ85lx/zNDH0gKC5K/ZxJUvLW+Xy3ipQMBkWpJaICLjeAVH?=
 =?us-ascii?Q?0zB4tHP3r+CA8ykIamNmIPFgMdIN2BKhtvdVFK6iJWU4+u75yMovDnBkpu65?=
 =?us-ascii?Q?GRAfe81lU5ZxsLdlv1bQxOBqW8V0Iz8UM9WIxi0FCwASlMYGYHRZ4qFck05S?=
 =?us-ascii?Q?D/KraTfACuYdM7elxwuBlEeZHXfbQHJKqSNdtQu5gxkqWXuM/xoCWti2QYyO?=
 =?us-ascii?Q?Kh0wlVIIRSDZZh1Uk2CUf8xsMdtfo2il7UP1ogtI2W1H/SqcdMaTFL3fJ/QL?=
 =?us-ascii?Q?xPU68+/YVVYoKhZIekYBiseZ6GjTVkRJPPPAA0ufsEsLQkdjn8mOHvds6eRc?=
 =?us-ascii?Q?7gjUz/PxUUS0mHX3TBVK8mIV/BcqC0TiSEGheNA4VpX2mjb9Hzj3SKOP8YDu?=
 =?us-ascii?Q?NImqmcSw1lvSkxqTYrWpigWR6oaF6cSQGne6PkUL1YicP8zC/+56Oet5s2CH?=
 =?us-ascii?Q?k1r9mobJFM/B8m+EcS3aKrYqyTqoMRFRh7b+cGYj1vYhsXUmFPqe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac93255-a809-496b-f5af-08dec75ee6f3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:35.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oERKutz6AwVwxv63THINgUqySCP1k1rtJ+xelwHnLLCh0vsMF/5jF8gvvrexZ91lZW57fjIiuCt1GJG+2mRtU5fGt0+Sf6KVzKRc0F8awaY/f+FEmku7/sMNmB1vIFbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824

From: Wei Fang <wei.fang@nxp.com>

Implement the DSA .port_vlan_add and .port_vlan_del operations to enable
VLAN-aware bridge offloading on the NETC switch.

VLAN membership is maintained in the VLAN Filter Table (VFT). Adding the
first port to a VLAN creates a new VFT entry with hardware MAC learning
and flood-on-miss forwarding; subsequent ports update the existing
entry's membership bitmap. Removing the last port deletes the entry.

Egress tagging is handled through the Egress Treatment Table (ETT). Each
VLAN is allocated a group of ETT entries, one per available port. Ports
are assigned a sequential ett_offset during initialisation, used to
address each port's entry within the group. Untagged ports configure the
ETT to strip the outer VLAN tag; tagged ports pass frames through
unmodified. Each ETT group is optionally paired with an Egress Counter
Table (ECT) group for per-port frame counting, allocated on a best-effort
basis. When the egress rule of an ETT entry changes, the counter of the
corresponding ECT entry will be recounted to track the number of frames
that match the new egress rule.

A software shadow list serialised by vft_lock tracks active VLAN state
across both port membership and egress tagging. VID 0 is used for single
port mode and is ignored by both callbacks.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 439 +++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  24 ++
 include/linux/fsl/ntmp.h           |  15 +
 3 files changed, 478 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d4475ad7ed6c..9382e7b68e65 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -37,6 +37,27 @@ static void netc_destroy_fdb_list(struct netc_switch *priv)
 		netc_del_fdb_entry(entry);
 }
 
+static struct netc_vlan_entry *
+netc_lookup_vlan_entry(struct netc_switch *priv, u16 vid)
+{
+	struct netc_vlan_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->vlan_list, node)
+		if (entry->vid == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_vlan_list(struct netc_switch *priv)
+{
+	struct netc_vlan_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->vlan_list, node)
+		netc_del_vlan_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -222,6 +243,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	struct device *dev = priv->dev;
 	struct netc_port *np;
 	struct dsa_port *dp;
+	int ett_offset = 0;
 	int err;
 
 	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
@@ -251,6 +273,8 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	dsa_switch_for_each_available_port(dp, priv->ds) {
 		np = priv->ports[dp->index];
 		np->dp = dp;
+		np->ett_offset = ett_offset++;
+		priv->port_bitmap |= BIT(dp->index);
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
@@ -831,6 +855,8 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	INIT_HLIST_HEAD(&priv->vlan_list);
+	mutex_init(&priv->vft_lock);
 
 	netc_switch_fixed_config(priv);
 
@@ -858,6 +884,7 @@ static int netc_setup(struct dsa_switch *ds)
 	 * hardware state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
+	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
 
 	return err;
@@ -867,6 +894,8 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 {
 	netc_destroy_fdb_list(priv);
 	mutex_destroy(&priv->fdbt_lock);
+	netc_destroy_vlan_list(priv);
+	mutex_destroy(&priv->vft_lock);
 }
 
 static void netc_free_host_flood_rules(struct netc_switch *priv)
@@ -1025,6 +1054,385 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
 }
 
+static void netc_init_ett_cfge(struct ett_cfge_data *cfge,
+			       bool untagged, u32 ect_eid)
+{
+	u32 vuda_sqta = FMTEID_VUDA_SQTA;
+	u16 efm_cfg = 0;
+
+	if (ect_eid != NTMP_NULL_ENTRY_ID) {
+		/* Increase egress frame counter */
+		efm_cfg |= FIELD_PREP(ETT_ECA, ETT_ECA_INC);
+		cfge->ec_eid = cpu_to_le32(ect_eid);
+	}
+
+	/* If egress rule is VLAN untagged */
+	if (untagged) {
+		/* delete outer VLAN tag */
+		vuda_sqta |= FIELD_PREP(FMTEID_VUDA, FMTEID_VUDA_DEL_OTAG);
+		/* length change: twos-complement notation */
+		efm_cfg |= FIELD_PREP(ETT_EFM_LEN_CHANGE,
+				      ETT_FRM_LEN_DEL_VLAN);
+	}
+
+	cfge->efm_eid = cpu_to_le32(vuda_sqta);
+	cfge->efm_cfg = cpu_to_le16(efm_cfg);
+}
+
+static int netc_add_ett_entry(struct netc_switch *priv, bool untagged,
+			      u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct ett_cfge_data cfge = {};
+
+	netc_init_ett_cfge(&cfge, untagged, ect_eid);
+
+	return ntmp_ett_add_entry(ntmp, ett_eid, &cfge);
+}
+
+static int netc_update_ett_entry(struct netc_switch *priv, bool untagged,
+				 u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct ett_cfge_data cfge = {};
+
+	netc_init_ett_cfge(&cfge, untagged, ect_eid);
+
+	return ntmp_ett_update_entry(ntmp, ett_eid, &cfge);
+}
+
+static int netc_add_ett_group_entries(struct netc_switch *priv,
+				      u32 untagged_port_bitmap,
+				      u32 ett_base_eid,
+				      u32 ect_base_eid)
+{
+	struct netc_port **ports = priv->ports;
+	u32 ett_eid, ect_eid;
+	bool untagged;
+	int i, err;
+
+	for (i = 0; i < priv->info->num_ports; i++) {
+		if (!ports[i]->dp)
+			continue;
+
+		untagged = !!(untagged_port_bitmap & BIT(i));
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ect_eid = NTMP_NULL_ENTRY_ID;
+		if (ect_base_eid != NTMP_NULL_ENTRY_ID)
+			ect_eid = ect_base_eid + ports[i]->ett_offset;
+
+		err = netc_add_ett_entry(priv, untagged, ett_eid, ect_eid);
+		if (err)
+			goto clear_ett_entries;
+	}
+
+	return 0;
+
+clear_ett_entries:
+	while (--i >= 0) {
+		if (!ports[i]->dp)
+			continue;
+
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ntmp_ett_delete_entry(&priv->ntmp, ett_eid);
+	}
+
+	return err;
+}
+
+static int netc_add_vlan_egress_rule(struct netc_switch *priv,
+				     struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	u32 ett_eid, ett_gid, ect_gid;
+	int err;
+
+	/* Step 1: Find available egress counter table entries and update
+	 * these entries.
+	 */
+	ect_gid = ntmp_lookup_free_eid(ntmp->ect_gid_bitmap,
+				       ntmp->ect_bitmap_size);
+	if (ect_gid == NTMP_NULL_ENTRY_ID) {
+		dev_info(priv->dev,
+			 "No egress counter table entries available\n");
+	} else {
+		ect_eid = ect_gid * num_ports;
+		for (int i = 0; i < num_ports; i++)
+			/* There is no need to check the return value, the only
+			 * issue is that the entry's counter might be inaccurate,
+			 * but it will not affect the functionality, it is only
+			 * for future debugging.
+			 */
+			ntmp_ect_update_entry(ntmp, ect_eid + i);
+	}
+
+	/* Step 2: Find available egress treatment table entries and add
+	 * these entries.
+	 */
+	ett_gid = ntmp_lookup_free_eid(ntmp->ett_gid_bitmap,
+				       ntmp->ett_bitmap_size);
+	if (ett_gid == NTMP_NULL_ENTRY_ID) {
+		dev_err(priv->dev,
+			"No egress treatment table entries available\n");
+		err = -ENOSPC;
+		goto clear_ect_gid;
+	}
+
+	ett_eid = ett_gid * num_ports;
+	err = netc_add_ett_group_entries(priv, entry->untagged_port_bitmap,
+					 ett_eid, ect_eid);
+	if (err)
+		goto clear_ett_gid;
+
+	entry->cfge.et_eid = cpu_to_le32(ett_eid);
+	entry->ect_gid = ect_gid;
+
+	return 0;
+
+clear_ett_gid:
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+
+clear_ect_gid:
+	if (ect_gid != NTMP_NULL_ENTRY_ID)
+		ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, ect_gid);
+
+	return err;
+}
+
+static void netc_delete_vlan_egress_rule(struct netc_switch *priv,
+					 struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ett_eid, ett_gid;
+
+	ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ett_gid = ett_eid / num_ports;
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+	for (int i = 0; i < num_ports; i++)
+		ntmp_ett_delete_entry(ntmp, ett_eid + i);
+
+	if (entry->ect_gid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, entry->ect_gid);
+}
+
+static int netc_port_update_vlan_egress_rule(struct netc_port *np,
+					     struct netc_vlan_entry *entry)
+{
+	bool untagged = !!(entry->untagged_port_bitmap & BIT(np->dp->index));
+	u32 num_ports = netc_num_available_ports(np->switch_priv);
+	u32 ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	struct netc_switch *priv = np->switch_priv;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	int err;
+
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return 0;
+
+	if (entry->ect_gid != NTMP_NULL_ENTRY_ID)
+		/* Each ETT entry maps to an ECT entry if ect_gid is not NULL
+		 * entry ID. The offset of the ECT entry corresponding to the
+		 * port in the group is equal to ett_offset.
+		 */
+		ect_eid = entry->ect_gid * num_ports + np->ett_offset;
+
+	ett_eid += np->ett_offset;
+	err = netc_update_ett_entry(priv, untagged, ett_eid, ect_eid);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to update VLAN %u egress rule on port %d\n",
+			entry->vid, np->dp->index);
+		return err;
+	}
+
+	if (ect_eid != NTMP_NULL_ENTRY_ID)
+		ntmp_ect_update_entry(&priv->ntmp, ect_eid);
+
+	return 0;
+}
+
+static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	u32 index = np->dp->index;
+	u32 bitmap_stg;
+	int err;
+	u16 cfg;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->vid = vid;
+	entry->ect_gid = NTMP_NULL_ENTRY_ID;
+
+	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
+
+	cfge = &entry->cfge;
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->fid = cpu_to_le16(vid);
+	cfge->cfg = cpu_to_le16(cfg);
+	cfge->eta_port_bitmap = cpu_to_le32(priv->port_bitmap);
+
+	if (untagged)
+		entry->untagged_port_bitmap = BIT(index);
+
+	err = netc_add_vlan_egress_rule(priv, entry);
+	if (err)
+		goto free_vlan_entry;
+
+	err = ntmp_vft_add_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to add VLAN %u entry on port %d\n",
+			vid, index);
+		goto delete_vlan_egress_rule;
+	}
+
+	netc_add_vlan_entry(priv, entry);
+
+	return 0;
+
+delete_vlan_egress_rule:
+	netc_delete_vlan_egress_rule(priv, entry);
+free_vlan_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+					       int port, bool untagged)
+{
+	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
+
+	return old_untagged != untagged;
+}
+
+static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	bool changed;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry) {
+		err = netc_port_add_vlan_entry(np, vid, untagged);
+		goto unlock_vft;
+	}
+
+	/* Check whether the egress VLAN rule is changed */
+	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		err = netc_port_update_vlan_egress_rule(np, entry);
+		if (err) {
+			entry->untagged_port_bitmap ^= BIT(port);
+			goto unlock_vft;
+		}
+	}
+
+	cfge = &entry->cfge;
+	if (cfge->bitmap_stg & cpu_to_le32(BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to update VLAN %u entry on port %d\n",
+			vid, port);
+
+		goto restore_bitmap_stg;
+	}
+
+	mutex_unlock(&priv->vft_lock);
+
+	return 0;
+
+restore_bitmap_stg:
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		/* Recover the corresponding ETT entry. It doesn't matter
+		 * if it fails because the bit corresponding to the port
+		 * in the port bitmap of the VFT entry is not set. so the
+		 * frame will not match that ETT entry.
+		 */
+		if (netc_port_update_vlan_egress_rule(np, entry))
+			entry->untagged_port_bitmap ^= BIT(port);
+	}
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
+static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 vlan_port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry)
+		goto unlock_vft;
+
+	cfge = &entry->cfge;
+	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
+				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VLAN only belongs to the current port */
+	if (vlan_port_bitmap == BIT(port)) {
+		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
+		if (err)
+			goto unlock_vft;
+
+		netc_delete_vlan_egress_rule(priv, entry);
+		netc_del_vlan_entry(entry);
+
+		goto unlock_vft;
+	}
+
+	if (!(vlan_port_bitmap & BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+		goto unlock_vft;
+	}
+
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
 static int netc_port_enable(struct dsa_switch *ds, int port,
 			    struct phy_device *phy)
 {
@@ -1297,6 +1705,35 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_port_vlan_add(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan,
+			      struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	bool untagged;
+
+	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
+	 * (VID 0), so we need to ignore it.
+	 */
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+
+	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+}
+
+static int netc_port_vlan_del(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	return netc_port_del_vlan_entry(np, vlan->vid);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -1575,6 +2012,8 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_add			= netc_port_vlan_add,
+	.port_vlan_del			= netc_port_vlan_del,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4fbd12825b67..9ff334301fbc 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -74,6 +74,7 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+	int ett_offset;
 
 	u16 enable:1;
 	u16 uc:1;
@@ -94,6 +95,14 @@ struct netc_fdb_entry {
 	struct hlist_node node;
 };
 
+struct netc_vlan_entry {
+	u16 vid;
+	u32 ect_gid;
+	u32 untagged_port_bitmap;
+	struct vft_cfge_data cfge;
+	struct hlist_node node;
+};
+
 struct netc_port_stat {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
@@ -108,10 +117,13 @@ struct netc_switch {
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
 	struct netc_port **ports;
+	u32 port_bitmap; /* bitmap of available ports */
 
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct hlist_head vlan_list;
+	struct mutex vft_lock; /* VLAN filter table lock */
 
 	/* Switch hardware capabilities */
 	u32 htmcapr_num_words;
@@ -153,6 +165,18 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 	kfree(entry);
 }
 
+static inline void netc_add_vlan_entry(struct netc_switch *priv,
+				       struct netc_vlan_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->vlan_list);
+}
+
+static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 /* ethtool APIs */
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 4d329488763d..d3b6c476b91a 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -262,6 +262,21 @@ struct bpt_cfge_data {
 	__le32 fc_ports;
 };
 
+union ntmp_fmt_eid {
+	__le32 index;
+#define	FMTEID_INDEX		GENMASK(12, 0)
+	__le32 vuda_sqta;
+#define FMTEID_VUDA		GENMASK(1, 0)
+#define FMTEID_VUDA_DEL_OTAG	2
+#define FMTEID_SQTA		GENMASK(4, 2)
+#define FMTEID_SQTA_DEL		2
+#define FMTEID_VUDA_SQTA	BIT(13)
+	__le32 vara_vid;
+#define FMTEID_VID		GENMASK(11, 0)
+#define FMTEID_VARA		GENMASK(13, 12)
+#define FMTEID_VARA_VID		BIT(14)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
-- 
2.34.1


