Return-Path: <linuxppc-dev+bounces-27676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4226DC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:25:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPKW1yB3z30Vs;
	Fri, 18 Sep 2026 17:25:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716319;
	cv=pass; b=b8uPy4STYekkXwg5YjT/HoKGHwVYJ1KhrCM0YY1Mmu30FP0ynQaP7/s+cmkk6LvS/i4jkwx3T4inZSqkPyS5XAnocaBic0HfUHnlwYEq+OHnZIhKZhpOMZGQQDOE4crXuP/KaQQ7vi9V5uqlpQ3ME78nN32qH3cI8Wz92I0YD86KdK3NGmlJj9AaMqRG3vUbpiqtJu1H/PsyNr4if2hPiKCC2Tgr8XSEfYbyifgng4fC3tiP1/X8rFCb7SWMvQs42QAZXpxqn0V4v8qrqBubd2azWQOPyB2TR/3is/Lvfts2PlbyAgeNISxJFjICo9rpzHRGTGsV5su2+k6+cq7z7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716319; c=relaxed/relaxed;
	bh=xBNu4d4lW8JNdOMXyOlzIZh3nYkLcbs2j9n9UXCwh8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4wLOw08Bb4iPIcHGbX15uIQ1KzGoDmOz+CU8ySpsRUuLIaCt43afX420dKDEO/A3NeURn2gATzfdNApHnuIfFUEUU1rmPvzYRJ+gOZLaY4eKez3v7Eg1Zb37ZhawXk3Hg5xH44SlXBMJx9wYDRh761f5aLZhc1w54zX2B+o4oYzyiQDDv7D01WtTcsUaoU5+/r4zY63ql3UnA/OyhnHxB4E9WAaoSNDMmlmYHB6ZQBYf6pHZyQonPc3jDQmBh5/0jg2Si3NJTvGNtJ10gWqcBdojTDPtfHag6tocuOWiurJM8QJUIjkI15bDLCOMY/ueEZW06IWDVBCvPJ3O8m9Tw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wr+nGMW/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wr+nGMW/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPKV3QLqz30gY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1o+ThfwUQ5d8vyY8+/5W0whlEvCyuP4fBMbrKEr76Tm/hQ3tHrr8kkob3STwXu2wb253VkXKXJZZVmwFVd3NA/8TmDOpe3wbpDF3PoB7aLi3JtAajV5LZDiZea+Gqc2MxCaKKo73rAm1lET/0jVKwJbWCDqpNhgaU6QfALoXdFk5wmKh4ucn+D1sftTJbmzLa38Cl2KoIQrQyXxHQbTA16kCpZWwcf2VtxicDuEZUJ/IwYxFJQotdVhLRzxru7iZcBdVITlMAywC9zoTjO1VdrmzSmhcGn18ojZbA+pbORdD9O9qXCQcuUJmOGkwhS7g5uKnqCgshvrQetjxAaHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBNu4d4lW8JNdOMXyOlzIZh3nYkLcbs2j9n9UXCwh8w=;
 b=FUA9phsU47KXa3U2GbMB7gRXZylI+3818234Rt0TtkXE8haRvHM9EMPwP77pT42Kwvh04qXzggSM2T9bph8JbITcLD5xa04AiT9T9RHc4ypbb66DbfiwkbLlwtdNo2f5pT5/fck9VFgmfqPE+swQgQl5qQBnHPGTW+SxeRno7dso11WNI1VJlugrNjbCe64Bx1YNA65RUscNkh0CJONdipSViLNCxhOvTi6la4/9Qbocuh5a3YmCaB7TkWZ1w/bxOgEjJFr920/HgK/L19xL4pVKiuze7cYqYY8irmxlFsldgZ8TH5qIsc0p35YBg+4BNF3WaHCP42tMFKK0Vs4LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBNu4d4lW8JNdOMXyOlzIZh3nYkLcbs2j9n9UXCwh8w=;
 b=wr+nGMW/2fwDfsMkNud/Sm5tyg5oxz/7LZcxWInuXtjyQj2kCFIL+7vU6vVAZk/eH5nVgDbboQjv8eqO3Rk+7t+s46gSBTR1z0U+/gKLQrQkkicI3aUJM1M/Lz2LuoODZRWN9I7PNO2OhW3xdvXOGVoPzvQ9YiMLmFH1wHejtFJ0Tloz2tctkT5JtiAv6EzYmoeqEHf2vt+nUkBdwHWu7fv4z/fg1YTU+t7q/6qW0GlxYGnCdAJSea/P9NG5GEmlw2oHnzNUd3u6yFVSX4gHdbzlFt5ol1zEdUIfwkyrxBY/ZxwtAz8PnV3Jplx/FlHRgjrvdbEVECOVjxBXIU+A/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:25:15 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:25:15 +0000
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
Subject: [PATCH v4 net-next 5/8] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
Date: Fri, 18 Sep 2026 15:28:49 +0800
Message-Id: <20260918072852.501420-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0046.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 34814992-1f69-4665-cf54-08df1555fbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y8vEG3b1YS+nlNFSLj3Y28Ny1cx4DaeFboxFSFl1XuIzOzw/YAeRPjXWkgWU0dwNTS1oRPBeI8SgH01z9sXLfommJM/mcWcMZ/Qw+PC5omJ8jxLmpdArs5Vb6chKUxEDkpQuv2jppCKOovZeRnE3irhImYdq66bN4kWTusY+JjaftFXE59YLzHunwrPYUE+5/6LW00qFl3ZfCS3h8S406F8vsQzNQDfPIz4aOjoAiX46uNeL0laxZDSqy0QR9fRde/Vtwu6A4KUKH12h7pNdNdVnycwxEdBNy3ldB1yDFqkofbL+MkSubBkii8BZQmdH+G7k0MPtWLndjpCGTbeW7tzPq1YkgFY/qgQ/u0y21sxk8BKfQwYz2ARdOYQXq22Fin5myHIXGtU7THMFByx4JksTdXlpeNk01ZgcB3Jk65nzC0wERQVu4t+4W8Kbw4nrAPwD5F90ezCH3VuZckJQcJj3FPjMnmGp4k3jDJnkpk7gL0Kvo4KONBcrmI3gML41/2Br9jcJYhbTOvLTFaW0/ODKrAHiWw+oacxjTD4K+VoB1mIFEpUsnOyNvjYoGvu5kfMtQRgLHiQX4Vs+UIT7VzMSPFTQAn+DohJdQlzg1j86m7QolC5YOI5QC+DE6uSL0+KHTTwQceqsntJWmo49jal6SBI7+afB/nYHPClxgagBqWFng7PypMMONXnQDyKgT+u7kxR353zuiZo2N3CtPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXGswaLhaJdjMDTR7h5d8C9qP1lzSYVT9oKdja7GnwcfjhYtC27wGmIoAbkg?=
 =?us-ascii?Q?dIVlbuoxbYgoiwTjat7BIqoE8cXxYpJL1v3XbHYpmUaLIv2MxmGGiR2CD4mL?=
 =?us-ascii?Q?e6Gu8W5IjZwimQ0mT1p7bahNRQlnAvljLuJHOkfMgv2Y/hO+DhJctKe5ll1r?=
 =?us-ascii?Q?Uz2+FTJOiv2VLt6X2dkEYTL46XmBT6riRkcstOcMz+se1nnFSA0s+EhPJvqE?=
 =?us-ascii?Q?B/f5J3giZMp6L9uujT6/mbxff3x6rZVtUEVWNBLjEd6GhyBzLaXiLfMQxMeV?=
 =?us-ascii?Q?zJv1rIVgHfgx+PLCIip/OniUQZdZ+TbTC9YpMzf9ftKCOBpXum4gn4KGLSgi?=
 =?us-ascii?Q?raJ9idHb7RluYVN7ndUYQli868BlBPg7UpjI1Mv0d3afiyR6H/k+Z3FELp1B?=
 =?us-ascii?Q?GZKnacnMY5CHzm6bLT75b0CYWy+KxjVuiFb4qu7rtbLAxUjG4nDgRa004GP/?=
 =?us-ascii?Q?DW6Rw1w4PDtChS/tDCTw2WvXA2utmR1YOsN8p4FNMY0Ez7zaQM8+8U3+krBU?=
 =?us-ascii?Q?+FhtyEghijzN9caP1gHiPooZ6KEa+OESN/41j3jaIJqDpFPkVpyHHcrfH63j?=
 =?us-ascii?Q?PH77tSGbGpd+KaE6zYVQMppRfTvfddZVsPaaqeF0hMAr+m78NdMQp/+U0E60?=
 =?us-ascii?Q?szDS8G+odJjTUqFsMW13kAnpXqFJ9OfxBdokiZlBZRo3AtinJ4K3YKw2ZsHv?=
 =?us-ascii?Q?Zq6K1dQYlgjaSzAlPL0dqRXJqbbG8HnoKRmFnd/QUxcgxmGMAQYU0HQlnPdN?=
 =?us-ascii?Q?a5uFUXXQJLGxKT2TV4764vbWGSm+VIivEJO2M1Dj4vjY0kZt9+uxa4NuXriJ?=
 =?us-ascii?Q?/rTVKfAoxBs3KnlpgrrU5283XWkoQIVZDMXD5ZmOZSEF8ELVCoWsM5sQxsOt?=
 =?us-ascii?Q?aLdJSNdnOILbD72cYbxUkqjDLXYUQ6OqIaLMK8oqsj07qbWcRzEM4Cs3YtX8?=
 =?us-ascii?Q?MWVYeWuHuEK/QRHUEZ0Cd7tRkgS+rrqNln0oorbUCVJvSqtfb/Y0OM8d1TXK?=
 =?us-ascii?Q?zuhM4T2nyK8ntcMZ8awbzc+2AxCAR+TGTvUB5ZtQ+EaSSMSIIuKs0LKfqh8x?=
 =?us-ascii?Q?uiBH+1BaOEKo7Duz0kGukJ1dC4y/ZodRlf+5zPETVJwAXcv++HqLy/sg9q22?=
 =?us-ascii?Q?KLrUla7zm4z0YMHTpbP5CsqHIsvad9iThLlBFLQHAaQJsPlOw7Gf0TbEIkRZ?=
 =?us-ascii?Q?txUMM9F4FCUbhsAeQvP2UO2lX+w0rHSBo5VQoRQ0IMMVxPJtzFjhWe/ub7E3?=
 =?us-ascii?Q?Zgn/pU87onhYE3DNKFou+zMVz6GqdqP/GZZx45kr5+udHXXpx3YNvYUvsGEF?=
 =?us-ascii?Q?VAqvrvww4SpwwUY5WQM/LRnVGOi96MVI9E3x+iZJbXApXeTCx4lG3PZ6wwsQ?=
 =?us-ascii?Q?U34jNDEzw0XwNxIWBjXmwwseK58MBBQERxJExnm++759RfVlxPBv5IuRN1Uh?=
 =?us-ascii?Q?hxGyftlZJJPokZ50+HEnkc1aLFh5v80y/YYocqzg6wRIEONDoc753jyfhIJH?=
 =?us-ascii?Q?TxoAMfBEf+ZWuKBb1HBcIQmmOVMEOdbuoyxM0ZFdfi/KjZHZo/BYlP18DTg/?=
 =?us-ascii?Q?ogy91OQnAnHJGIaNzarVD03RuyZ5nH6qpwcayTku9qHtN0YzwRAW/Wbn/C1L?=
 =?us-ascii?Q?+BOXARaqkd9UtT2hbajjrV5B/RFGbl7vcV/i6GcFLIMz4HqbdrdMFbzAzcpr?=
 =?us-ascii?Q?ovEwKfWsIKkWH1qNbC/SmGTx/3oThUSLlLkebzzUwZ1tTCJvFNn6k9Ff2Lfk?=
 =?us-ascii?Q?eg/2HJ0093GahYEH+4KoWi+b/Ko7+Wkd7tmzgwJeEN5nXVDiC4oQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34814992-1f69-4665-cf54-08df1555fbc2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:25:15.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiMLR+HAzt7R9C+RuvJ5wSaclMDYW39aKo7NPQ5aZL6+SSSeLFCv/z8IONZlj2C2ewVPnfCdJXy/9L5reN+fqIT5jfvBVt83JuvMlEflWIEvzDw5qnN7rcaCZ2Qoh1Pl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

ntmp_ipft_delete_entry() may fail, but the driver ignored its return
value, so a failed deletion left the IPFT entry untracked and
impossible to clean up later. This is harmless today because the port
also disables its ingress port filter table lookup, so the leftover
entry is never matched. However, IPFT is going to serve other features,
such as trapping PTP packets and flow policing, for which disabling the
lookup of the whole port is no longer an option. Note that the operation
to disable IPFT lookup in netc_port_remove_host_flood() will be removed
in a subsequent patch.

Propagate the error to the callers and only update the driver state
once the entry has really been deleted. Since IPFT does not support
in-place updates to the KEYE element, netc_port_set_host_flood() now
deletes the old entry before adding the new one, instead of adding the
new entry first and deleting the old one afterwards. Otherwise, if the
deletion of the old entry failed, each port would have to track two or
more host flood rules, which complicates the logic for little benefit.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 76 +++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index c590931a4e1b..082ed9405868 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1706,14 +1706,8 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	u32 cfg;
 	int err;
 
-	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
-		np->uc = false;
-		np->mc = false;
-
+	if (!uc && !mc)
 		return 0;
-	}
 
 	host_flood = kzalloc_obj(*host_flood);
 	if (!host_flood)
@@ -1761,32 +1755,31 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
+static int netc_port_remove_host_flood(struct netc_port *np)
 {
 	struct netc_switch *priv = np->switch_priv;
-	bool disable_host_flood = false;
+	u32 entry_id = np->ipft_hf_eid;
+	int err;
 
 	if (entry_id == NTMP_NULL_ENTRY_ID)
-		return;
+		return 0;
 
-	if (np->ipft_hf_eid == entry_id)
-		disable_host_flood = true;
+	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	if (err)
+		return err;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+	np->uc = false;
+	np->mc = false;
+	netc_port_wr(np, NETC_PIPFCR, 0);
 
-	if (disable_host_flood) {
-		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
-		np->uc = false;
-		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
-	}
+	return 0;
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1794,7 +1787,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->ipft_hf_eid);
+		if (!netc_port_remove_host_flood(np))
+			return;
+
+		dev_err(ds->dev,
+			"Failed to delete host flood rule on bridge port %d\n",
+			port);
 
 		return;
 	}
@@ -1803,19 +1801,24 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 		return;
 
 	/* IPFT does not support in-place updates to the KEYE element,
-	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry ID first.
+	 * we need to delete the old one and then add the new rule. If
+	 * the deletion fails, return immediately.
 	 */
-	old_entry_id = np->ipft_hf_eid;
-
-	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+	if (netc_port_remove_host_flood(np)) {
+		dev_err(ds->dev,
+			"Failed to delete old host flood rule on port %d\n",
 			port);
+
 		return;
 	}
 
-	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_entry_id);
+	/* Restoring the previous configuration is pointless because
+	 * .port_set_host_flood() returns void, so the upper layer cannot
+	 * detect the error and the RX flags have changed.
+	 */
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to add host flood rule on port %d\n", port);
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -1980,6 +1983,8 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
+	bool uc = np->uc;
+	bool mc = np->mc;
 	int err;
 
 	if (!bridge.num) {
@@ -1991,6 +1996,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = netc_port_remove_host_flood(np);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
+		return err;
+	}
+
 	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
 
 	if (br_vlan_enabled(bridge.dev))
@@ -2004,8 +2015,6 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->ipft_hf_eid);
-
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
 				      READ_ONCE(priv->fdbt_ageing_delay));
@@ -2015,6 +2024,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 disable_mlo:
 	netc_port_set_mlo(np, MLO_DISABLE);
 
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to restore host flood rule on port %u\n",
+			port);
+
 	return err;
 }
 
-- 
2.34.1


