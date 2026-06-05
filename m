Return-Path: <linuxppc-dev+bounces-22142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730F9CD6E7B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:42:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXGf20qtVz2xdb;
	Sat, 06 Jun 2026 08:42:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780698619;
	cv=pass; b=VDys5YtHgeS6WBRY2ltHR/4Z2J4VpgcvgCByfkI2r4x4UKoSQCWd1d1AoJet0NXbtlVmtFjxT/A+xGdovNAPkztGIWrOl2wbGXdGeD2LSt5mF8p5zsqxfPJefVJEJvxgwUrTFL/LNHtfeVefrmvRKfnQtVg3G1y+qIVSsH3XBcq4sL/1lMqHSf6sLubHS7K8XtXfUcCCbOYl8esBZZIijFtuLq1ist7sKvwpKrc+KLnso0mB3M8bW/Py7QFjpcaFm0LUKsUJoTGXv0g/eEYBfllweAcc7CCBpXhV8HM7pfclrSV3rjNAYvoee9kVhU4sjDyMxn2EgMbDvI2GTg16Zw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780698619; c=relaxed/relaxed;
	bh=p2wYVXIP5U+enmHv2WuXz/IsMKBIz/LFwcs5c+wSJkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JHXMZzyefMCEDCOLCmrMCv42bzo1/FOKBkjFsgEjbyg4UV298MJNujFWe9t+tKds44AIbg04E1cjcrlusisjij3xBebvShwOo2r9Vx4R4Z7QULleW47obDqpBbzARt/ZZrzINp06yPFR7Ezzyy95JnCOjv6B1zIdKRZ1dUUTzOcHzNrElwSR2tZZ+G1S5qJOm/7U+c0fwPEm3vTR7c2yr+liXTHrOeDyg/PCBkrn6603nMG99/+3rcUQmZU8Wbf36j2gP8EBJzaAPfVKaAjImZA619eqFrbmcihJOVdtgs0qvpK0UwhN7eFD0JmGSWCysNc3Fdx/eV9BlxMSOmiWyQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m5EL2715; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m5EL2715;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXGNB10rsz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:30:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAaCz3kfJUQaZbo1aWy2MOb71hexbO7NRZhtVBngIbl9ZQnZCxtfElZi7r22gUOn4h3NOY6DbBNDroS7lkMmwudmB+UaCd4/l4SWFt6uMFbYlSFqOHkpafBP5SUzoanLrbpgZ7Gc99sznsPnv958XQXnIu4zDh0Xccn0dITYS5V4zbF3tainXGHjQEgW2SrH/6gNBBK8Q+y9UQLx+NgsfpkGDPCSmt0LdTrxQrwIq1+/iaenYit7lPzYU9wsZASiKviOGLKS8RsyqCGn3eZL15QCyj2D+84lyHHKxMuvmJObGU8ywWA2LAEw0hQWlpTAlgSg40pxoq1Mg6hZSmKDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2wYVXIP5U+enmHv2WuXz/IsMKBIz/LFwcs5c+wSJkQ=;
 b=vi1MwZp5pCDHYcQB7u0oH9989TPGe+I/40SyxfyVr5fjzenVqW9OH15Juwgl4VW8QXwPCVX/PxKiZsA/ZUfPH1PcgdBKLeVR3v0dsO8aW/I5EsSSgOOgLV5Lxsd0mCGQ8ImuT5gd8JrAinC7+Fm6t2SObookjZSEP26nGaGW7NoLZIcCCRtl1RR8cB8pH+wY4nHz+6Bv6MVnLpPwwB1k1sUbr+Vj+83+HCLBqdoUNlSBaS+j9/FwHKhIdvm12gs8wafY+vhzkeRUln2lnGL+g9xgME6tmZOWgmixkn0rbPvEHYe0xpQszGz7asa9oqfAkSCfhbf/sjOBM2PK+Im9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2wYVXIP5U+enmHv2WuXz/IsMKBIz/LFwcs5c+wSJkQ=;
 b=m5EL2715HPT7Agm7c4QqvIyxpUXMwyx/2P3AheGbOKHsQX7e5wbr2XXuARYgMwRZWx5uSgX0D0RAwtg3UJjNng96BmL2UM6KVGyByGVCBkd2+uFk2IQqpsINm6ZZ2GcEYenF9HwBjzchEpwmREewOnA7Ar5x/DkGDWT8CDjIhgU8BUijXwq8y7GeloJzuSw2Ny1Y5ekFPe239hkoioUn4vAZQfstlhfwOkT9Vi4lXr8psMMjCSRXM4j7jyb1XF1EPjPgA34qDIIxA8QP2fTjP1FVy1dhs9fZD8jrQgeCKdlkLJrEUps4lDTrvV76/QihlPLzzCXtruy1XF73AtJ5aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10463.eurprd04.prod.outlook.com (2603:10a6:800:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 22:29:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:29:49 +0000
Date: Fri, 5 Jun 2026 17:29:40 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH 01/10] dmaengine: fsldma: kill tasklet before removing
 channel
Message-ID: <aiNN1NBWZHPBZ6V6@SMW015318>
References: <20260605220134.43295-1-rosenp@gmail.com>
 <20260605220134.43295-2-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605220134.43295-2-rosenp@gmail.com>
X-ClientProxiedBy: SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10463:EE_
X-MS-Office365-Filtering-Correlation-Id: 576a2472-3e45-4fcb-1457-08dec351f478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7gsErR9CnbUIdr4zsvosT4o3oNJRJmekGWWBD1O0TCj9wbnxizuxYTlchhLyn4u7RokSESRkAZ1P+LkQwCzNHH6XO3pJZi40xwnw+Ur+hBeRRgtPMKhJu2sSkpJSYk4c/BKDGUJU5X44ADwVc4NnFHtqke2YyXvWC51tOPa2jCovgO8BQCl+vtDYQcaiZN/oXARXwbfpLYoaAEt9TqTR5rfPbX9mvjd8qvroPQgQummpghjEM/ACtupqI/GTf67ROyYYCRNkO+K7OB050Ab6uv+kCAr0OeTPZqhbWEUK6MxuC6tb4+xdelOpBuMyiGXtAgTnflrxJMrkKsrrs1O0bTGAAlXoSFW9f+HMOBWwhQOdWdQpIAxU+sNruwz/SMtf+lip039d5UfNuy/ZLnZufvTpRd+jkXKAcyWc/XovKlQeemaupZZbCtFGpbm5B/isUeglQw0qrtVgxn7RtfDoq0DLKKncw5TDBS29UtIVIqQNk+Ilgkj0ILXG2eBZRmzoqWGKfCXkyN0t2SlaK/03soGAGqYbZMZaxhRII8VPfZcvoQAQ2uopDVrfHRDR9DwldohXTW3WEeE8bRi3NjOXNJPkcqCTDFXy2Hqo9U/gPil36Jb9JUyi9esEYENRUQCP2w1izhqEOUQFmqByYVe0k3ZkVVABBrq429/cIaO6izUw3UjSDgOXzsNjbSAQy0+T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0vQPKfCmy87gpmxBWk2czM25psW209aF9kzJKmVqGTFNp4/17fjGis8e7GV+?=
 =?us-ascii?Q?a2R4l2LTRcnXxFtYtWmmvo37TfR6I8AotORBYG3BN/EJa/tgrWI92eVTFWb4?=
 =?us-ascii?Q?bHdhHP8hpA82s0Hh2LuJihCCFRy8KiRsJJxos5PxRW4yX1qx0/ThMdBBJ5BS?=
 =?us-ascii?Q?vXi8IHKDJhbTiw/z+VhEbQ7hSEsU5K6Htgl7+Sm3bqAW4r3zZBowsfN8SMmI?=
 =?us-ascii?Q?vr+xnTg0u5JqnGbH1bAmvB/ovNs7Yupj+XLYLvKUFCuqsPnrDSYBbWZ2D08Q?=
 =?us-ascii?Q?KJsUC44d+qI6DWDt3pf5E1iUtAbcij0v5t1FLj1Z1+OUMWsKPV0G+Gybviug?=
 =?us-ascii?Q?B1joohTnJylhMtQQA5GbqwC4mGpWAGTvpbqFn6h1+XvjtmWwMMfkjLSZtaML?=
 =?us-ascii?Q?3kg5i5t1w+p/NtbQj7h8mvAaCinDecH5qV/16oFscf5QAV5gUbHAs4FnXnzQ?=
 =?us-ascii?Q?RdTb7ryWS+reZPsyHFI5izS0BflGBrqqSHslFtz5JZY+TWG74VZQXbuUI+rn?=
 =?us-ascii?Q?0ADJRlMAxc8Ed39n84SieyGHLKZeGdJSu05m6SyDChE/Kv81gpKd+ZeKm6WZ?=
 =?us-ascii?Q?TMGPDp5HXh2hC+iGuVyUiHKm1SYBO5R1rCZ24EQ7TsVoBVki3HXf24F6pnXe?=
 =?us-ascii?Q?vCboebznIWevCeuEfwQNgSPwBHmj6xGT7fKydxTX8BmSzd7OifKPNjuIX6QC?=
 =?us-ascii?Q?TZ3ZdWEg9gRihkfs94H/Qitk3Owje+jtA59FYKwHtA/AmVGtr0sqtd+M1mNP?=
 =?us-ascii?Q?yG8tyE1/q72Qv+v4hZ+4xUiNuVKP8RRgNPyElBRFsSgzLhIATr6weICN2Mu/?=
 =?us-ascii?Q?pIiteFWDzpd4BWztCCEBNa+4V03v0rCfmaci20c35ldfSNN1halDFk9afmlq?=
 =?us-ascii?Q?FRTRTW8+iYnLd+Khxjt05SyqKpV/nK6Bh0EYjw5sE/BOVdZBetjxfH7IVrZW?=
 =?us-ascii?Q?AuOyd5I+MKcyU7dQfPT6JckRKhLrlSgT8pNLGTclsDrPoV6VZC+JTx3Iq5iB?=
 =?us-ascii?Q?eU4fdDicDcn7u1R+ue4cGwAJvsLSJgrrCsklBRDoEoAS+PWkPiApOsSmiAzz?=
 =?us-ascii?Q?bJbr6X5mo/OVd5VzWiiTFZizBHQ18H3Zwt+jO6YmgimMO4jT+kA8xjUZ1h1v?=
 =?us-ascii?Q?eggn0cpPIuBDcOvH0Z0handKsx2orfJGNORPp+A2EsQqI1lRa5oJljAi6olZ?=
 =?us-ascii?Q?bT62GkFEGvFo94AMyIau9CfmPmZr/fX5EubGErAJELG0pEJJ6j9kcGKzsL3M?=
 =?us-ascii?Q?SpRlowZWZ1tG90YIBOy1g82XvwOLfrmcb3wR2dxv3vWvyDPNX+JNvMdKPDYU?=
 =?us-ascii?Q?UeHMccjSJmnhP1tQz+RC+w18sauGY7PwSUCstLwbmQbuwdrsMdEtmRqlg6CR?=
 =?us-ascii?Q?hJIkYE6qd5e5xjvsHsv6bjwiHgSUauRbR66BnzKIzbT4dMaizmpsuDPhJjSQ?=
 =?us-ascii?Q?b64Kojr/LACKMf98USRmYcmf4TbYYT97Cuooz+tWYEaoCLr5cqGSnuYnk4Iz?=
 =?us-ascii?Q?R3rZegdix+GR/rVziDC54QATpd6zPBfktuLeiwHqnWf4cSPuPfAhBbnwY1ym?=
 =?us-ascii?Q?GvLKKbczsd++EpPRkeQq6SaoDIlOPSQUnRlPseKQ9jNGvmORopalrjZHZGXN?=
 =?us-ascii?Q?m/EYgUIAdXQlseQsdnQhE64npy06aBDGoK2E84GNfMJn/1NcWSkhgZMf1iBH?=
 =?us-ascii?Q?scRUTWS6A0kBUf5fPfOVtLQ53VZUUoATIFeP52cKdeq1Ahusz1bE+BUo3dH6?=
 =?us-ascii?Q?rLWrwhetb4yMoZTK+fB4gVn7xsuZZsufJPWXG6qpjtVfzB/joqBz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a2472-3e45-4fcb-1457-08dec351f478
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:29:49.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 462/L4FaGghq+fzYiL5nX8MqO0unAcrUDtPqf4ZMPhrbuTiH/T0BmP5kjHKErye4ZGJ0IRRccLLc33OG/1LTW+zCGfyxRdOU9sYc8DU2W5f+DtD+p+PpoZwmKWg72kSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10463

On Fri, Jun 05, 2026 at 03:01:25PM -0700, Rosen Penev wrote:
>
> Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race
> where the tasklet, scheduled by the IRQ handler, runs after
> the channel has been torn down. With the recent devm conversions
> the channel struct is no longer freed in the remove path, so
> this is not a use-after-free crash fix, but rather correct
> shutdown sequencing to avoid the tasklet operating on a
> logically-removed channel.

Use below commit should be enough, needn't talk about use-after-free

Call tasklet_kill() in fsl_dma_chan_remove() to prevent a race where a
tasklet scheduled from the IRQ handler can run after the channel has been
torn down.

Frank

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd..0e2f84862261 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +       tasklet_kill(&chan->tasklet);
>         irq_dispose_mapping(chan->irq);
>         list_del(&chan->common.device_node);
>         iounmap(chan->regs);
> --
> 2.54.0
>

