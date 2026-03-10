Return-Path: <linuxppc-dev+bounces-17958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D0CEB104A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:41:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVmn199sz2yFY;
	Tue, 10 Mar 2026 21:41:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773139305;
	cv=pass; b=fgCE19igoeH6d0LcOuDyYTYYfiJ187OiyyL1dF95Pktrheb5EQ5KJ8VD9UOH+bWD3LmI7IIbbrHnrtRC+sobpVObprw50qcgVZa0ai9xAbQHS1xx+C9RLHjcVf37RAivLB3WdnO3ueH9zmB95D/4PmEDwdVtP9TIn4RroD27BC0vViadLlR+69V2letBJb6GWT+2l5G7Hz3LEQSLrxI+XkSJWHWHwfYMPnYMNVUCbmj6Q96SbYd6Jc9Ub2qkhe2L7UMPxzJyKq3SetQ3Q9orN84hCYzhxah3HAvEPHhphQ+pmoGdPY9zbhbFUCU50PEmrg46xwkbvZHJDcOKp0nYJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773139305; c=relaxed/relaxed;
	bh=bC1g5V1knsd+6TigkKWA7GrUPBXlK08jLmYX1yVGaSo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HedZLNwIlxx71Sv5UPon8yoZ1Z6FycaRaEPxODOfbpLGJcd673IEmo9TCXl6hm7wFepkdVawAo/IGu+JwYRCzxBYdOzE/ZQ58uv07HwZpHi10S9CLcoC4387jE3HTKCDOVagXxJ8IKfu+uw6OC160Q4JqJPEDXZmZLTZp6hZeIhzC+sT/N7MS5rJeL6gEBOpOOTIylOV7504OG7gGU76SCQpe1xp1FbSQ046yq50EHAcBRAA9dwLWaYG3uEpcdLx35/OgSx9QC3FUOHyUKt3tw+Oted0U/R61hEJL4ZS6BAsCUe4LX5pym/rx7hqrM6jsCQ0NwQyJGsK7VoMFqM+Sg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nxbTGjx4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nxbTGjx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVmm16mNz3cBP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:41:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4T0fNGxSeHRrXeOfKrS2I4kkBy3Hel1xFOLCWO7WyyazmA1BCf1OfSJUddy0y2tOuDbdtqmOv4LHsO46GdXOvLkJHObkWGhlmI8HSeMp2/vXED+dqYxWM18GG09gbZ3fstbeVe8U78u5TQlkTdtsmh8zywNpQc/SySg/JrKUG8gSV7QZSogRWZCg26xbESr5xOUGgH9tnG/WAW0UD2Da7NAk+pOi2/0uC0Fsmc8wCeEInfYRGVmqLix/2E2kFDKk+Nm1W8FqW1OBGR+96XWoN9dsmyDJz4IVscfqYQBwDlS3SMVoEyUsP2GiejycOZA/oPeMTJck66M7Xx/8Jm0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC1g5V1knsd+6TigkKWA7GrUPBXlK08jLmYX1yVGaSo=;
 b=FGUxo+r+nl4PXWJzFk7rJK2qivaYh6QTwyGJ0P14YcEq4qpnO9p9ffWAZ9kwzvIxTw5fLHETPfEwVPeWGM8ItEqL8mCa6n5Iop6P32OmspgDAxMiiv3/kvb4eMkdjm2NffwfrEGwkaZvqbEHyap89bbmSibvDUx22ABzsQ4DDuKDijEd4xHUOLBuco4uULkkb+R4QktFiZnPXpasZtKZOOULHeZdbvTcW/QoY8mOLIBpVaXLPlqqz1UV/pkWuRDAf+NPoMaJUdyu8WWQ0Oa72pz2ussabtopNUNM6XnO8Sr7sGZT2MW9MnMssz7v3Wz/kbmaluvnYYkJtQ9bX6r8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC1g5V1knsd+6TigkKWA7GrUPBXlK08jLmYX1yVGaSo=;
 b=nxbTGjx42mFqL3A1oG5FBDY0roPY8gYI3w6TVHhfBJ2u0MWsF2PFB7Oyx5mtKqXpJyKxDA3ljQkJbMBpqNZxLjYQVGLBLtQSHiPzNvYCDVERme5cV7ogq4Ff0LmF03B/Y3IafYhVdO/75dLtqPsD6GbEEczMtcnv7ib7mUjJzajUOL8A478mP5RDkgN8WC1KVKeXXn8Xd6qZp/Kj3ontsTuBGDxxVEo6JDY/SyCmSxMjhsaL983vFIjo+vXDCQHykD763xk6r3d+fQDpDSW9g8nGAKFZS/WCYDKF5hGIDTIrckDGAvdMCstg4M3Fm5H5ObN6wvg1qrPVZym9NFiXQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:41:20 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 10:41:20 +0000
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
Subject: [PATCH v6 1/3] ASoC: fsl_utils: Add snd_kcontrol functions for specific cases
Date: Tue, 10 Mar 2026 18:42:33 +0800
Message-Id: <20260310104235.1234569-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
References: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9a8691-2831-4aab-549e-08de7e919121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	k2q30Jg5xo/un0UdvlFfuelcvHg1nFQM5diPClFr3OsA43s31H8DvV7FoRBFc6Lih2hewNpLjFkdGA9G6LkS8Z5VNRzjTLG9PUwWJiw4V/uMApuSIVVirvD8aFuJhts+UhcqHP+2+mF0CRoknqzkM04jpN8vS1/jC2ys9QUH8ziA7d9qmXOwR8Dhy6NJJ0CDXybRiLzYmCgfLy8xgkJtlnjw34ikodPaXlnzv6jwlNr3WnXNYin4G6ZzUA+GgMQDlAw5JBHJA4ixytkwJ2fMfTjRyVqpf7GQA5r/FtMjlSHxTeFg/wWaMdSP2Gfjongmts6cukPw6K5tvoMnmU3C0jYlEZejnJxZ2Nk5BugUW9GvuKCwC3ckluec/8dvmUZni0wl69CTSWMHHgwyOfMNSsxm7drdJPoznR95Ou2CgIhCJ5BaomvPPBz4nNuvOld5i7LieqYyNaz6a1NUUDdw71o7+rCDpwNXHq50W0R42aCO7xBfpOhBau0YKsMm5cBBH7/UU3bRryfo9vBa9H0uvL6ddk/0tS38MKtpb8d/Qtko1+Bw1fZW8KVfqBvLNi7eVpMh32wNEYgqXQBVCnV+bKlKcj6CXE0g1WYMq/yXuEmTcMyzaZf1p6OZWpJIt1eh+GP7D3YfPM4GI4nOLNXVRcx7BUMZcfoCsGPnwNMQULnG12MRuOsOL510hlrBjAdtPMLjWBl6NK3rWiYOPxhxdbXZDfuLjbDjFtzDXRAmA4N7dUn4CL8jE6+u6JdM3ZJi4vOgeSxbMFI4xF4KJw+JRSKsr4BYSV0iGEm/B0rgDUvMhpwPWcWnbuAjUXiHojYG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iHYbAJs+wpmc7sawIeSuryapsumU1TPcqfC+13zRLe0fXbUQiOvLKX2j9j9x?=
 =?us-ascii?Q?hTNweNvMy+MPXbFcxsLxAcV8aM7dORJPieo/UR7eZ2BlJqdspUpO461pZRyx?=
 =?us-ascii?Q?mZ214qLDUzK8khDt3N00nEWLut7aGW79HBt2bYuDTIjmhuZ8kpO+84kLsAGu?=
 =?us-ascii?Q?OMClDhXG7/56koHgHea5jp3jvB7rDfdHKTJLryHY0fZVF7bCbMU+31o/JqCb?=
 =?us-ascii?Q?jb6KqMqWE9q4Bt1cPmF3rolwPPn6bvEJLt29GpodB9WMQahsd96nlKmr1KMa?=
 =?us-ascii?Q?VJwOCyvxsK69vkTlX0FHAQ9G+TiTbiXUpzJe7ArztImWDPZjorlF8wefDI7w?=
 =?us-ascii?Q?i3sGswlIzg7NlVnvy9vtrLSAKEDK6K9cQ/sD6lSUmTTe2i1WlPgQZmERWom0?=
 =?us-ascii?Q?acfXZ2YZPKxg3Si42ENmfWtEVL0mW6oTeE8Hx3UNCbVVnmayj1Xhsn24oQV/?=
 =?us-ascii?Q?5FV4huaw4t2p3utcmcHdBXd1OdNFhKP5bdwISu5bC17YscgYbc4Xrpr8UcMx?=
 =?us-ascii?Q?GHFC3f75aYOwyREHHRZdxtTnKVvtfT5N4CLwMU/sfMOTvcReSZLYnxlTQxMF?=
 =?us-ascii?Q?qldiAZOXyb1IDUvnsyTmjnNSZ+u1JWagLv2dsceBFJiKS1SBO3QBQY1kHWRo?=
 =?us-ascii?Q?Ve+m2L0C7wyOGzYvxLvIsbflyozXOOXf30KXYnvcLzUWghUMzRzbZPREuJJI?=
 =?us-ascii?Q?HHyfaYTzoAgwJhkZrfBGW0Muopi+qfJTb8FvMU0mdLHUyEIHJgoeUKVdTNUU?=
 =?us-ascii?Q?2G4f1TilQJp0h4Qc+qT9N4bp7xv5w2g4l99+CrHkizxNk91JgVdOtZ2ErPgh?=
 =?us-ascii?Q?tIHpgSpyN6w25V6I3QDkRYd050BTadgjR0yUrXFhC7r8WlvVuDTX9bSmmyru?=
 =?us-ascii?Q?J5zVwbtF7V6kuJL6kparw8Cepl/kkHeMAZpY5kMy9AJX0ixFD88SNoQVFTZY?=
 =?us-ascii?Q?Eoo97U8f8BE74TutIUgakVnxzKDwaKe4XA6neAksePYrnSRdjodunm6Ampt6?=
 =?us-ascii?Q?G204B+7sBEr/IC/zG16fniK7Uftp97s0g12uOlDyaNZ9p/m1rS/RKJb4Nh5o?=
 =?us-ascii?Q?/VGIwQrqQmkzI9Yxj/E59ecSpKouh8oiVAfEM7VYrNdHaE7bQtq1OShOEtUq?=
 =?us-ascii?Q?2165n0GSvemW+xZ2b6HrR0Z8GzBGUS3M4p86lHYzc4KYDf+eudn0iPhGdhaQ?=
 =?us-ascii?Q?LWx3tHai7mg8/mqytpsuwAILj+ja7uQ2YyHoPJBz0Dsz0zZf+WC3pQspeCth?=
 =?us-ascii?Q?4fD9C+CWiwW2hloCj76QWOw/VdMtAUmxCaR2+sSFr7lpITaYhQQv8Ok7O4/w?=
 =?us-ascii?Q?ENn207H5h1VmrYr1ms3o2cjwiYsvH1OdWXfPu5+MU0NCAghz9EVKSoYiWDG/?=
 =?us-ascii?Q?ViH62wmcp2vBL1iRa12fvLDdvK5R9exlkjYaVJF6yEYmFT+iHdwPux1+Fjga?=
 =?us-ascii?Q?Dx3Q2EmwkXpqP1NBXzlzQUy/0ggfoFZp3K0Uar/CitCE1nXNoGy6nZ8bCKeu?=
 =?us-ascii?Q?xr82QqBWj43fM9Dw/n/R5OjbQIe8rgmmxMDzoCnMGw7AJM15FpzdJz0iB1A+?=
 =?us-ascii?Q?b5qyytoots9WQa6KKcaRwyV4nEvGFIYWgmacp7odyhkNk1q+k5neXqH8yRBw?=
 =?us-ascii?Q?02bKaS0QJ/M1lCnraG+tWE1cL/CFGkCA/kH6d3U5xlWa6RCo7aAnjfOOUBOZ?=
 =?us-ascii?Q?TlDjZWGubM4MsDJWX9oP+UBDLkJGB70UEu/CM37deah2p01X7zqml53N+PON?=
 =?us-ascii?Q?SB2VaUckkA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9a8691-2831-4aab-549e-08de7e919121
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:41:20.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB611/HhxzP/8UAlBihJbrSFpAO+57PNyPEFJ3NDuh/bouvd8b6thkz/Pg2dMkjfbAHGzLyvLh1JETJDPo7FoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

There are some registers which are volatile, at pm runtime suspend state,
the regmap cache only is enabled, regmap will return -EBUSY when trying to
access these registers.

static int _regmap_read(struct regmap *map, unsigned int reg,
                        unsigned int *val)
{
        int ret;
        void *context = _regmap_map_get_context(map);

        if (!map->cache_bypass) {
                ret = regcache_read(map, reg, val);
                if (ret == 0)
                        return 0;
        }

        if (map->cache_only)
                return -EBUSY;

        if (!regmap_readable(map, reg))
                return -EIO;

When exporting these registers by amixer interface to user space, there
will be -EBUSY errors in mixer-test when the cpu dai is in idle. In order
to avoid such error, needs to define FSL own functions to take a pm
runtime reference before calling snd_soc_get_xr_sx(),
snd_soc_get_enum_double(), snd_soc_get_volsw(), and so on.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_utils.c | 131 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h |  48 ++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index d69a6b9795bf..7651c64bc837 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/pm_runtime.h>
 #include <sound/soc.h>
 
 #include "fsl_utils.h"
@@ -197,6 +198,136 @@ void fsl_asoc_constrain_rates(struct snd_pcm_hw_constraint_list *target_constr,
 }
 EXPORT_SYMBOL(fsl_asoc_constrain_rates);
 
+/*
+ * Below functions are used by mixer interface to avoid accessing registers
+ * which are volatile at pm runtime suspend state (cache_only is enabled).
+ */
+int fsl_asoc_get_xr_sx(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_get_xr_sx(kcontrol, ucontrol);
+
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_get_xr_sx);
+
+int fsl_asoc_put_xr_sx(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_put_xr_sx(kcontrol, ucontrol);
+	/*
+	 * As this function only used by the SNDRV_CTL_ELEM_ACCESS_VOLATILE
+	 * case. return 0 to avoid control event notification.
+	 */
+	if (ret > 0)
+		ret = 0;
+
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_put_xr_sx);
+
+int fsl_asoc_get_enum_double(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_get_enum_double(kcontrol, ucontrol);
+
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_get_enum_double);
+
+int fsl_asoc_put_enum_double(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_put_enum_double(kcontrol, ucontrol);
+	/*
+	 * As this function only used by the SNDRV_CTL_ELEM_ACCESS_VOLATILE
+	 * case. return 0 to avoid control event notification.
+	 */
+	if (ret > 0)
+		ret = 0;
+
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_put_enum_double);
+
+int fsl_asoc_get_volsw(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_get_volsw(kcontrol, ucontrol);
+
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_get_volsw);
+
+int fsl_asoc_put_volsw(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	/*
+	 * As this function only used by the SNDRV_CTL_ELEM_ACCESS_VOLATILE
+	 * case. return 0 to avoid control event notification.
+	 */
+	if (ret > 0)
+		ret = 0;
+
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_put_volsw);
+
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale ASoC utility code");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
index 21b25a11ecda..1aab0c1cee62 100644
--- a/sound/soc/fsl/fsl_utils.h
+++ b/sound/soc/fsl/fsl_utils.h
@@ -31,4 +31,52 @@ void fsl_asoc_constrain_rates(struct snd_pcm_hw_constraint_list *target_constr,
 			      const struct snd_pcm_hw_constraint_list *original_constr,
 			      struct clk *pll8k_clk, struct clk *pll11k_clk,
 			      struct clk *ext_clk, int *target_rates);
+
+/* Similar to SOC_SINGLE_XR_SX, but it is for read only registers. */
+#define FSL_ASOC_SINGLE_XR_SX_EXT_RO(xname, xregbase, xregcount, xnbits, \
+				xmin, xmax, xinvert, xhandler_get) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |		\
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,		\
+	.info = snd_soc_info_xr_sx, .get = xhandler_get, \
+	.private_value = (unsigned long)&(struct soc_mreg_control) \
+		{.regbase = xregbase, .regcount = xregcount, .nbits = xnbits, \
+		.invert = xinvert, .min = xmin, .max = xmax} }
+
+/* Similar to SOC_SINGLE_EXT, but it is for volatile register. */
+#define FSL_ASOC_SINGLE_EXT(xname, xreg, xshift, xmax, xinvert,\
+	 xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_VOLATILE |	\
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE,	\
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, 0, xmax, xinvert, 0) }
+
+#define FSL_ASOC_ENUM_EXT(xname, xenum, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_VOLATILE |	\
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE,	\
+	.info = snd_soc_info_enum_double, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&xenum }
+
+int fsl_asoc_get_xr_sx(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+
+int fsl_asoc_put_xr_sx(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+
+int fsl_asoc_get_enum_double(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol);
+
+int fsl_asoc_put_enum_double(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol);
+
+int fsl_asoc_get_volsw(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+
+int fsl_asoc_put_volsw(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+
 #endif /* _FSL_UTILS_H */
-- 
2.34.1


