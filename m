Return-Path: <linuxppc-dev+bounces-24034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBD0C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:23:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxmZR37yFz2xdb;
	Sat, 11 Jul 2026 08:23:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783681830;
	cv=pass; b=Ki9DKUVPScHAqFDMFoErWdPpeaKh7CHIaodAwBRRGh42JBXswCnKN7qfTCK4KMNambQs8SNZFS6FEO3ixt+V+AvsLZTZzdt1EUU4kihRlauwzOxN5Srgzx4WDuTYRN0wG8Dri9JmPT7BYqgQPQeRkIkDF8VP1L8mfHh9/omVCC3IvGL0CwlJ0QyRSU+AM15ryJGD7tW2Q75b7Xzg7SudNZmNrR2sLi4R95H/ompL1SsRRjLdYtiNZZEfPZ0RuxmZvJyet+rvYeNuzLezzIKg5KwHnd0inUJmBREmCPntgvarjoGYACxP4urFcMo1O1COVVNK6uP2UKcTixNxpScvPA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783681830; c=relaxed/relaxed;
	bh=V2xv23EY5AA2K6KVfThpTJW9Y0BVZzifa+8vTrgpQ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1V0zFSernrJwEpZ0Wn/u4gjbynp0Yqr1axZmNJUWBb2x6yjQVa5IUa901s5Tg8IN/tGaRZJAcdc2fYM8qCQo5QgMoRt/bLyZRfUzYxBdCAK8LxF+u7SqKFvnnsLx0Gy6EI1l+WLzuQo+PP4afOzXVkGAEeGLZXUsjUqAMVrF0fziSIerXVhc6McG/EOeqVWsjb/CFQ8gxC6gNKcK1hnOYYSIVXQhJPF3F0FDeJ3wWY5csIT/UMhRtF2gOrmi30r0sbRZpdXEq3FV50cRW/laOoezOAL7+NEfIpv9IN2i558TOFPRaK/4vVJ0jbHS/yHH8C2sd3cHsmpnWQcWC6bfA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=BPWGwkK3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=BPWGwkK3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxTdf4Whdz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 21:10:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVa9vs5JH2xnvwks15gP3jXiT6p2VF2jeqBItt05JgOXXMH3s83N5fAEVSjIFGsewz6yIbpoCXaoNVMQStRA6ANq1iXBHA5OuhP0w3hwO0T230Ct2USIoEr8DhdXujuoP8siY3v/6Owc5s2RUIE/IfQ1BJ7D417MwzM/oR4uRdsu3aXtngB1vcYo+PHxQabnLMK4bsFfr2YXjAsUQjUtxvQ/GOUgawp3YlRi3eQXr8tdTqRy+DbLgBXrRviBH+xeV5NazvAyY0v/55l+0DZHMK9CU6R4oFjRkGZap5whydjaD1pU2LJPe553PvIBxGtJ0+KsyKVpagcAaNNwriIvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2xv23EY5AA2K6KVfThpTJW9Y0BVZzifa+8vTrgpQ2E=;
 b=h1pAh9aOz8ZLHpn3yxhJh3gk7mSZ5kZbJj4zEehvHPa+vraNdQd4BuynNOJMEPoMEpoU2J+z7W+9rm4zZEiSokGMFNjv7N8HMMAVbAwbTT3vt21k+C+EHMT9P+9n+fHKrvDMmY84TyKtaByt5S3sjPVyYZtipu+0GAz0477t9HYNwFYd+x+eZTkperKrGoZJDwlWOiwTuOlurcZJU1UyLXwCmxay+etCdZJ18uepk24s5CRK0CDdcLeR4dMuTIyUJGUd+fL8lBARgf7EBfsa8rCecb5/uVaSVaUwng2eeZDfiLp3Dl3QIEEbrVjLeK5pehLjXIjuRSRp8yvZXSrCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2xv23EY5AA2K6KVfThpTJW9Y0BVZzifa+8vTrgpQ2E=;
 b=BPWGwkK3K3+vNtPk29OaBH6SuCb6ip0WECqQ5lPYe3u8ssJ0k6+hk9KJdua4ZbCdUu7uvJ3kKB3trKpBlKK+hP6FVF9hI96W3EoUJsnlBTtNzR9Cm+TaH+x4EwuK24BsUo6rqfrb9JP0fO2f+VPbbloucKRy/YgkfqJhuQRs00Y7sbM8sxuN3QmfKzRPmifRYyOkF5M6AgOzc0Mu8qp88S9vQZd27P6RidGADPTt9DsUnkySlTvbFN67rjMW2clnGmTe9+5gSV7+ki2MSfqN+QgkcRVuSvKLNTb0aDx80Iq22SkbNkR06Pt4q5IpY4hy/25T7GNRYio8YJDea3Js1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9021.apcprd06.prod.outlook.com (2603:1096:101:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:10:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 11:10:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org (open list:QORIQ DPAA2 FSL-MC BUS DRIVER),
	linux-kernel@vger.kernel.org (open list:QORIQ DPAA2 FSL-MC BUS DRIVER)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/2] bus: fsl-mc: Remove redundant dev_err()
Date: Fri, 10 Jul 2026 19:09:26 +0800
Message-Id: <20260710110930.462109-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710110930.462109-1-panchuang@vivo.com>
References: <20260710110930.462109-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a85ede-0acb-4fb4-9baf-08dede73cad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	dyLBB1RryrTejVaF6qiRLK+76t1ZBwRg9fAlvQfWBKvl5IStkZuxmljPmsFQ7NKdXPn+U8z7zd6QoHVzox/Thjr5reAMWiEg3BOk0dfOVJZ3BmY7isPs8VZd6BI6GaE5INDtqdk3Gjls4cmRdrf+uRmWEVfy0FYAWEJ1FGbxAx5MZqEsSDE+b77QHf67BgRfKAh84+pYlKPxR0g5NNK9oLRZGD3byJe5GQn3wKsnXFxNsHU2JIRXrCt89upEcODZrVa5KCUnZ9gfMAjfLwRhbE15F+r2DmHV9N5Xpf9DSXp4rTrhi1T9bhRfDeMEz7Ejr5mBT+Vb3bvSc/IIeSGpbRAHFx1f+BGlD2Jm9/66hFHdiK49ta/dQnzOxb46OQbTA7ajwAF0blAgLj+cIMGR5G6bONmuHyX0fhR2/FkCOemCWwPvw28Cl6+aV743MxHA7cZT5NaXbY2LCyQwQPofT1/eLIjhzlAbl5rI3mKxhSxsY9BwOrqpt3dJd7sGE1A5p8Lms+DwyLoXb7939Vok3FWmv3i6S3YnZu28zadX0yWBA4XPHCPvNzvJdK5MmJM6GXDNf/tn1ruapv+IlCbbCGbd7fSHtWEOgMQEE1rUGzkTN10linPJCfjUMIFjup8umCxkl0+PQ5SFtr5jvNGa4GaQONOQhuR5M0ZefnNPcm8Kfc8cpHr9k3pDF81Ard+6/8AIRY3HBej5u/DXx9oOwowSlPotTpbvaP0XEkUPrs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRXS6/oFgWSj3WCqAvQQdBkffvxBPxXcfKb5x6050CJcCLHj+2mttXp5MipZ?=
 =?us-ascii?Q?kU5bNzrs8pUDRqA570cjchclxZQl2Rl1EtEpmJFny9E9d9rf2IuOrE9tsz8n?=
 =?us-ascii?Q?IX13YHgSXFHDOjrrRSRequ4gS4NzLGSLACjSKKWymK8AD9nWpyLPWs5enEWO?=
 =?us-ascii?Q?sSHf/bfR3eL6a30U9B4OKrNKauMfEsSA0Vs5V/jOvilGlatM0cXOuVTYKkO4?=
 =?us-ascii?Q?RqGo206QThHBl8d1HEegqG5n5xzy7OxyBxGN6VJH0eGoWxP6si6IS621upuZ?=
 =?us-ascii?Q?vARXdjEBRm/a2PMDLp1twm0pxXIAMj+hAN3DRi1xknKpKEOE8tGxMK9j7Ie9?=
 =?us-ascii?Q?r4PvyZe7WmMkjtIYdw/r6gytCvJRwTbE7+R4rwI7ZYeXEPsMGr7EfT9wbx0z?=
 =?us-ascii?Q?oaqQTw77a9Zx8Ql4fTsDBm7C+osr3Mdw4py1SaLDdncpyROHbbUwUD7mvPqy?=
 =?us-ascii?Q?0U5gzAm5HypBWRzQ4idRMAGHsmzDTnAS36sP59lMg9UCOdB8bLvp2ZswskYY?=
 =?us-ascii?Q?2SN6RW0W5nPCLxU/A1BySaqRdG3pA6hI2sK4DMjnqILgFJI/Orb9B/mpxvd5?=
 =?us-ascii?Q?5tj50G+d4zp3HCYKfS6CdpS20JFfYvJh6cBKifCFsseOjeyHNhch6YK5+grk?=
 =?us-ascii?Q?cbKc5WOEblxCDhzaerPyOVpfkzvJhPq2n91gHlfBt8HYFPNCuYmdpZD398kj?=
 =?us-ascii?Q?zv1spPprNi4sK3l9n9RaOsQjXpzD0nJjczOrcvLWOi8mKtK7QRAqqH+Ad/Cb?=
 =?us-ascii?Q?YpgwgunlUKAyEyP6GcEI/K0hFHWYSbK2Rx9o7VyUqMDvmTO7XuVQgXU/5yqf?=
 =?us-ascii?Q?TImo3nQT/1/qsNu3MVBUbZ+4N8YEfCfJuiFO4QMyzPpq+FzblE8E4bSe1b0D?=
 =?us-ascii?Q?OPaR1ToGaqbxkCfE/cXo8ssQXLZstv5WggYILQq62MQ+T7d7eAbwA+wuKa4/?=
 =?us-ascii?Q?cQImBjSdxEoXw7z7etQGYnu8FTKG2q924SRmkWqwOWkiBSHZH23xo7oI2Ci9?=
 =?us-ascii?Q?vGVZNcOnnmTaSEGrKJ8JSEIrVdJa/3JqqKL8MWOQPB+wXw+USpaP2K6HYSsu?=
 =?us-ascii?Q?NqEiZGbj8KUXSJ9E9weNAsSxZZWADyDQ/CSs8C+MvAw0/gdvYt3zot4lkPsE?=
 =?us-ascii?Q?NJCrL2l/vE0mqGk/1g66dxdZrzJseRvPKylztY944NJnzVB6kkL+krWC/aLD?=
 =?us-ascii?Q?LAFypcYedjbp6CSUOgh6GR7MLIzKgGHYOBO02HsgTQ1eomLdcVcTnF9JF8Ot?=
 =?us-ascii?Q?TA2NamOovnYkYXaxqUXVYJc2klkfwgdylOkPASwdU9IBoPUixH1e4q/EyK1y?=
 =?us-ascii?Q?Jznc5WTpuFB4R0I7gWLAJybE69ALkxvwnHX/DVG/RIVKmLay26xcZ2pvJLkM?=
 =?us-ascii?Q?p4qVB0gN8O9uKypFRIzU2zFbefPIPt5i0fYhn2i3awFIfTvBdZbmn1t8Ai0O?=
 =?us-ascii?Q?qtCQ7KX2GTZVA2IlloSZZPIgAirZvyHEhLGsiMaDYYyGYunXRqoJ336u0On8?=
 =?us-ascii?Q?89pQZbgZsY74K4aavuTWFvNv9Bj7qUl8rB5TKRHDOW74cWJRZTKbbWZbcM8j?=
 =?us-ascii?Q?PJ8p5NGY2B0N3lR+MFZZzwyEh9NI9Qi726PmiSuYpVB4qcpbvmNpxbpb18P8?=
 =?us-ascii?Q?7fNuStK7dlblHSIuG5ahWBpeaBezW5oHR/FIrszKRRvxtuE5uLf0YWGvRz7J?=
 =?us-ascii?Q?N4zSrV9Npedeq3v4rHZQCK/dOqU3TsVRgodUVIPclBYrj7M4SDnz5NciSL36?=
 =?us-ascii?Q?MudVFGGDnA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a85ede-0acb-4fb4-9baf-08dede73cad7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:10:04.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy+ZKDofBJHJ4iYRod9YRTGGK7H2Wopdh0d6GR5i3jLyTcb7POOPIYssPATbhk4qw4VsZiTOTSyRvUEZuOAYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9021

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index a85706826fa0..a81188cb06f2 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -521,12 +521,8 @@ static int register_dprc_irq_handler(struct fsl_mc_device *mc_dev)
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					  dev_name(&mc_dev->dev),
 					  &mc_dev->dev);
-	if (error < 0) {
-		dev_err(&mc_dev->dev,
-			"devm_request_threaded_irq() failed: %d\n",
-			error);
+	if (error < 0)
 		return error;
-	}
 
 	return 0;
 }
-- 
2.34.1


