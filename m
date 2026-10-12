Return-Path: <linuxppc-dev+bounces-29245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20271CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:55:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWs25NPz30VF;
	Mon, 12 Oct 2026 20:55:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798937;
	cv=pass; b=MYAGnbodURdQCdG/BmOeRxxkHwrrrLrQU0JjP9MlABPTZBpj5lOZmJycDWYxyYi7JTkC1BezZWiDY2bz0C6kZCqtLnCW7YcylYygPOy/Qv8bKFdjirl0Kta6Me4e1QfxDC6YdKOBwIs9wU/pwhWp62sKsedeg2fY6YfJlXjzVfrZ6R6e1MxGToyFPnlyEKYQieirUrbV7lsfEC5n+lBc2+AvKoq4a7u09kMJCDBpyIvFpWXqXBiqYmfbs9M9pCDvjk5S6a94rpXmWmIyMDRCNoEG4Lwm5REHYvbYEE3HN7VOtXaLgKTQ45RxWtsXD3fkxS+sbmdWFZsBsqjZRixEXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798937; c=relaxed/relaxed;
	bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxGsfQ7eXSWfshsFgqfX9LmesAr6Mot9MJZb8CGiJOHMW4feNITdobKQc5QxFwT2+tTA66DRwROhjXDRcVTYWWRO0whuUnNqc1nJHTPf7R4d3o5JtXs8MnsT1KXs0VcoQIoCAI9BOwhtD3tk7QKphXSGv4VSCqRSezaAx4at056zBiFUFWL9/TpgfeiPw1sudoHZqdWMzj1VQifbgssGvhPZlqvOdBN74uM37ntw+0D6c4Qa0aRsyiveLzKCj9sYi27ke273iCpaZx1RtITdBLSV2J+nmQBEq5wedELhZhbIeydjabKf2WdHhYSy+rB6MYJl5HLB/T0eTjfMQPW2NQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YZ8g9Mfv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YZ8g9Mfv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWr22YHz3brP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:36 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCVzyufeYaEM+Eusb8a7qDDFqxQNp7b6JGQinnS/DNTlVvyFuVnuKZr/bE2+dz8fp2R7TqBY/aTkPoMQK938Z7YRn17E9qEnRFCMWHOrZzZx2VNqfz1p/nTKVRpfKzjvfEyBgSTr8FHjU8QutJTngLyqtOY1NgH9iAxMdGRIAQtL2zvvybhubtyeunnVl6i+1NdgkGylIAno3Zcm6oajS4G/YikPjx2Esb2U9tGb/LWHw8UbwHdD1y2qOO/31TAGsuwGmkCGMU73dLyjyWUcCKasCKz/DCDrO3bOeHki3vdzgggDRnbZ2wq1UeiGlUTazSOfeJPxmIl31wNo4/+Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
 b=R8BBnku7UXMsCYevWSdFzKv6LiS5Gk/rEfx2z9q2Kp+zgs+bfo1EtIL9v1Z8huzh9nJKZI6TNdtUGcm6R1NM9shF2j7KeygNUPCj8wPAd3NbqGyMXVALFN9gTRsQV9vjNkmIY0e7nVqhCoanrYYmtYU4V3f61IU3dth2LmUhGJHjChnNEer+CX2k9Fbq59Br9D5UENZ+yHlpa6jbP+QAE7fvlkUbyXycdnODTNMy4MCkeFDZ/LCD7qJgvMCzV4iD+oy03P7FbMdhE6a7YQ8fFvezGOjabPxrgwTrNF2SMpPddB1EV2O/puYIZpX0jDQ9HSnsoFhvXTfbHPJ98Lun1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
 b=YZ8g9MfvgTTylp5mXeMVN7TLfCbmqEjeQCjYP6G+wUeQyv0kd4QyTESeA4d3CSdlofFsmIwQt8LnBAzoOdnivDfiS92N7XjcfF+7EaxNWZBA33+M7T6cbevBDCFQNJNfIWi6rMTSGQP0CImYah23eR1BlOaMMc8xPYNpz6nI+lOm4RXoEWQosjAwf3fyu0s+zC0yduO5LkIvmNaJT2bIYbVlxoZaoEbIQQGCQQCN2d185TyELhtAlX4kWj6qU0UqyQNJmFWDyWQizoQCU0SvTdF/9swpWdzIUvj2R2RCj0M6dyphrVNDTybG7jyddiy5UxYuCNCctBBXdXxTcVJfWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:55:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:12 +0000
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
Subject: [PATCH v5 net-next 3/9] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Mon, 12 Oct 2026 17:59:18 +0800
Message-Id: <20261012095924.1129312-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: ae28432f-52d0-4758-b723-08df2846e84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|10067099003|3023799007|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dOBt+1XrMsC+lYPJFtEcl/9IknRatboWr8SosC24YS8KYnbGSrRkylsMgENIvR/FBqhWjx1eb1Wu2u+i+YCjsrHS+lOLJLCJrpvhDd3kge2ztBqolZWMnO3H4LPD7NpdZ4KfuajUaP6iFs+hIMdeNfBAzaGQlQ52j/BAiAvdkm9fqESJxbPHmlfv7IZjid8kjBko1MPS8na18RqQFT2TQUVNbPr1sdx4yiPOB30jLbvDWs6oXsrNaQzJXkQlvKFntFjImlrCeEpc3Mo1orYySkvo/cSnnJ+F//sJn1eCYITAjTyvDfItKw7hN9ONKZRRq3jyWRhHc90912DkMWzsonD+OjmMrISXNjtKvHPqJjWoJPF81wMIb7d6Ok/DbhRqfeY3cR6TzPkyoEGDDFZIzTtbvwfSwEdWsHCmrSPdqzn58XmjJYHY9+xF8fD12hjvR+1gc+rquDHi+gLqlHUx9dVqcMOZGRRzYvgezaaVLF5ND0KaN1fiaPQx7SyUm4cDmnaMkV8B6guJ6+w2WgVEPGkrel5/ueLXx2rBvPFBSLc+vSzR8LKHrrBlSmZXLgriXiNzALg/BW5hLi9VqGwcwwrih5CrEx5AZEcTHlLu/7Ywnm8v5hA3zV+GZKiHootxtSKT0AtnIa2N4mU8qYoX/K1jL3VxUadfgUoTCZAfEtbiOAUdXlvvzMarEwgnI6qH0O3sqQEeN/rrk9ZVN5tSAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNy7VqY/FqYDdRKb3AhQLCnBTlhA9hFi/5R01j/BzswwJmxwzIdGHN3qIFIf?=
 =?us-ascii?Q?/ygiX3sIEenGG8t+G2w1xuoDeIT6RXNzTvvoEZsw18NN8auNJ7VMiWh4mECq?=
 =?us-ascii?Q?MMgYCi/MipLlRXoLmyYGX1z06KkECzYDYYmawIaYERd5mXcWwzdXxLjJgMpQ?=
 =?us-ascii?Q?YJwcDZVcTy0PjQmcZAFIty4HJfWI5/zUpgMKp8q9pvuVBWpjGkjuDyFyiUS7?=
 =?us-ascii?Q?5kuRiqqlAUHKU4nGc4COT7Mp4GtyeBvvBbvmzYbIg7yofzTcKGMNXOMW7aai?=
 =?us-ascii?Q?DCwtMrmIDpH3klwvIo6VTI+LpZhrFVetBUJskJQRzEzR8MjW4LIk0OSpIyoa?=
 =?us-ascii?Q?uqrNsXi8K0jVgqKXY8wgdiqdhs83W+c55A8G6QX8gm5LjER1bHNCf8M9hfTX?=
 =?us-ascii?Q?D5uKuofNazR72mw0su5QOnGKz9Y73V9li656SYgr70hAKls8KsGxXHS1DxL0?=
 =?us-ascii?Q?cHPe/6sRSAau+55EEP6Ef+jqf6Prdkv7B1HR59fqx1OtVlIcp+vJV+vF7hvz?=
 =?us-ascii?Q?uY063LGUaRPkAbTyaOgCRXuFnhLHGpOcz3oC75dX3/akfc4Z0Df3Fn6DXziI?=
 =?us-ascii?Q?dN6cdh8wg6ydUKWT9n1jbUSXRl8vJDFK0rb/2sVY9nBE62sQCE6XQL3dErgZ?=
 =?us-ascii?Q?4Z7gFYXNlC1TOBcfLEZ+LbHH8Y7MkowYGG2GPQ05UXQ8DpX32aLlResoL/kd?=
 =?us-ascii?Q?O4cHYl7QPe6+eCLkVneuKWZBX3WhU28BrlqvPLD9qmOzqypaFy/5t4Pu0xL8?=
 =?us-ascii?Q?7zj4Al/H3Yl/i/HW92v50lyv4hfqIVZxjixC0JXIIdYrnN49/U5HMj2Tf0AC?=
 =?us-ascii?Q?mqST0N3f2ktkRODmZWa/cSXMr0ny2DCwQCVbnWsmA6zYX+TRhJTBEl2G4ZP6?=
 =?us-ascii?Q?nqNnOFn+tNXxzMFRddHjtsIpXszXESDH/ZXU/d0tKEmMv4RLQX149DiSgUFA?=
 =?us-ascii?Q?ojRWWsBeLq4UDyVFQgx4pd3hqXtT0NSeesGzFtnoM0E/TTpgJy+XXcEQeXHN?=
 =?us-ascii?Q?8TcVuSTOCa2yaVQIHoNrpGQsRz0MzquzFce2MGOwo5l9RoIgQ89BEdj70+Qf?=
 =?us-ascii?Q?7DZcD3BjoZsGIamuy03mYTsxPdv9jIKscGM/ySg+DDX6iAxbiK8baHw/PaTC?=
 =?us-ascii?Q?AE849xa1e5yH1fuY3UKjcSALa8U4j95riFlf70iMc8Z/JjiR3wunjWa32XCA?=
 =?us-ascii?Q?a3ayj0buTYxZhraCq5EwwjZbWEzx6EGXxOyuOKcuOi+tufU9H2SYNeVN34Dy?=
 =?us-ascii?Q?UXjbGYHlY4SQ8rs1VstPsak567t26Z5mBCwVwYtJjadvoDK3EMN5z/QuAnQb?=
 =?us-ascii?Q?Iof2ShaNSS2aE1wfMUS2LjAKPHLubZqZZyK+VQgK42YflAPq8Wvo62NO5zVr?=
 =?us-ascii?Q?HvQ3GNCSIlsTJNOu0fS84Y984CaB/Q+OhVeFkydVy8mQUkyRmNwQ97dxsmH1?=
 =?us-ascii?Q?8/BmB53e6HyovBBnlLM45fXDBaB60lNmsBy9xajcEv9oQ1Qqp/ecXbYQwu2C?=
 =?us-ascii?Q?qqFw59Rn6A+pKFjdSG3+ZAvdZW11Y8F3dJychfVGD9xL+BlXTdVITmcvU66X?=
 =?us-ascii?Q?Ti6gQHfGGrY2e+dRpYBvWbAuzo8fRjCLvGn0lzedztAlCDilFE1jnjK5p+9j?=
 =?us-ascii?Q?tTRHybGdBpL79vJNmmb6qdRKfaNCGWFypimihM1UQlxO8LbdG2nnEf2Dg7yf?=
 =?us-ascii?Q?pR9g85G54i7EQMgvBGu0oHvTJh/F68TfhDVmUmSqqVTC2e7hvi4kw6K6Y/4/?=
 =?us-ascii?Q?QD83nGV1o3tKCUy+ywrKjoTqFIeX5hY6P/7kh2eHNQzo8Jg2grEV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae28432f-52d0-4758-b723-08df2846e84a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:12.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENyjpKdCrYiDVaGFgdINA8qGaifA+NtuY7u69AyBHkhHkvpYXxJn4Ec1eMMXdasdI4HujduQWfEfC0uw2MDF2JR6O14ESq0nZXSYFfPiM/PoSQtJjM6qlitvpTCM0j2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

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


