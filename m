Return-Path: <linuxppc-dev+bounces-22501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9D4CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:31:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmpB6MpPz3br5;
	Fri, 12 Jun 2026 01:31:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781191890;
	cv=pass; b=Fr0oXYX4ELsDCQiAs+VCQVidcoO7KTmkGR+oTKp/JxfuuJV29nj6GM5MpbRf99gcEolv08vz/FxilBPqW/S4IcEf6azasiHn+MJuKzl+fP2dXnGNeir5b+e79riWnIfODp4dcbTMbzdsQRJtftAUg+4GqiwbsWXBt4m6gR3y+Zzpt1pG8SkutzzCTmOo02I67G2+f1AsW9zEy6lyzR/a2gwaEkrlOXehej0v+JIphe4UXqGVH1p/fEJlBSMXBIZhwxrgSpfk7ns5xGRsyWuLcPSzuEw8/LKsEZxSR0dmVW2PWraUishLuDNoh9cA7+NDUppKbyeEchhcj9H2TLdzeg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781191890; c=relaxed/relaxed;
	bh=wyVaFPrwteUDnfG1vmyOcwL6d49lTLfDtRkpCIyU04g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KQkS4YRWEq3rCH7scb3LEJt9RAvBe8qFPZBw7dHHdt+K9fK0KospOcYw/7dxnU9yUFq9BQPu8Ri7SiyJk3gks6wET/ETzHiD87Sm+vKUx59pqwRFESLu4x2WagUJ1Y0lYDc+dKpICr7VKGTxV9xMhoopolJ6cGfJEQziamfz3KPZ/7nKHdly0nvEM80cUNKrJqSyKNSb0mQgnE9kc83KB35e+Nw2yfac9ynjwlEPmnO4qxrYsk75sRIF8s/J1C9OkLqFi20lNRuPlFycX1ophiaEpAlb5S0N6J7b2J4/oEriQKViMgy273+nG6hAjBaVFvPKhRJNmtkOb9SEd64nTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Kuf5T7Ml; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Kuf5T7Ml;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmp90GJjz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:31:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlEeLgq1rFLY79iemhOjcluL0ndMmilYnxyr8qY1D5dYJNpNIErcByDkZPLGqiM2KNRS1Cla/5/wF7XvAmcuYBCB+cxpyOpVhQzRG1GzmJ6S4ZEJqrEaNFIzVffx5cRyHR4DSpxWYfaofnXBdhp9uc9aTI1WDG4PG26Vjxyjxc4QkYt7muA4krvG3eynbIF0iiSmzNRqPhGBmhelOBXPcmAiMGr7M1DwiaiPsoUBeaMzJ8AhWcUfFdnzGCWxf2Nfe3YQJ7lVP8oIxHi/gl0k58t9Da7IEG503GlX1pZZqfiRAZ8750GbN6o/4DXnqVnhrLJgzHBciSvcpnYOP3qIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyVaFPrwteUDnfG1vmyOcwL6d49lTLfDtRkpCIyU04g=;
 b=H5Q17G5okAzRGaDpoWJ783wfKi8+NRBV+FesbbOQ/I55LrR7tDPfigVtUWf/rc/E/ky4LEGG+ToX+TEM1dUbgODiW/JP7dp0qifeaxHBnchdHSlieHxvK5E74UPfzB5L/MnRrsZ9hGienzNS8aJpkY2vGtFKTJJo8f8BCvNE8moelmkiBhjo1wjreBkhicdkaOuOHbds+WV3m39oQanXk2F2XYGZNlr54lBlbDNVNa1IkvHldpfCBxjUc5PNIjFE2HBoyVjH0Pz6QWfq8g37zuTb+J3jQ5u/LfgNjCi9ZBZ8wSbDujLCq1lnB+OFr/pabs+y9u1sUkK6qcu3EI1lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyVaFPrwteUDnfG1vmyOcwL6d49lTLfDtRkpCIyU04g=;
 b=Kuf5T7Mlybwf7NWpPABxUZ3PB8HBa9Pp6u12OYqhPidqW+/liAWByS9894omKQ8XWSeWxeJUv8yb1EVCMjx/hYBYFDLoQEin66+XfsMAMSnUqtgP0pAqMRFGKPmLt+fEuQBgOL0/JtORmGxTRgOGkZ1/OSnFeluKOm/2GrythVGbWHv7fReQnAwYgJ2HyqsiFBrtX9wj4zPfoFOpK9RhK0kfRKeLdUOAnnuO9R2YObYupqFKH/jLYQu3L6W+/ingsBLW8A/vfDUQFPV5nek3T+rHliI+IYoLbGMPT/HJOTBoPIb3t6CFSsu5m+2EnGgx5aVsCHEe77w9Wod4BnWsDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8361.eurprd04.prod.outlook.com (2603:10a6:10:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 15:31:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:31:05 +0000
Date: Thu, 11 Jun 2026 11:30:58 -0400
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
Subject: Re: [PATCHv4 06/15] dmaengine: fsldma: fix probe error path not
 freeing IRQs
Message-ID: <airUshPd6FcXvQGs@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-7-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-7-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c0d8ac-46ba-4890-d2ad-08dec7ce73cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b0qWpjYygQVmyWijVPu1O9h6KwVYzGjJC8bNZb6CLWtPWyCVvAvlNYWJ3DfxOupuDMlnJx6Vj+dVQEDGZ65bep+FDKopHNNNh6QQs6FmieZjuNRFwuCWWHIACmoZfnYmramtmTbzsmwCQhBvEdOe7Yc546zqIdPDXMk1JUwRLo+v3t3sc3vopJS/rdI8sXKwIbuB/OooLyVa+4L/Jud0Hm2df2EqPkaGEAVwd4jZeAGNDjG7mqb2/d5kLGsGrluHk3d50FGclZFtV03iWzIwkLP6B/77Hq1n1I8EmJ/UJedGcK+5nYov4gRc2dpx1u3NioZTV2/9tuQvb285mGLF1FzMN1HGT2hRDASqR4rqoTz31z+yLZnzyniKZGBDCMom5W5GSLJYHaCGsxSzZQ6ANjN+FzrYgmAaA2quv2wjRX0afQOC22sy1jRQVzFa010x/A+vkj21H7bgLAYvM/9Wy73PSOgXyZRHLEpQ30IqygWgYzUN+ktRDsxiZh9Md+uA/JmZ4A1dEa88wQ5rkass7NAHsRDHjrXNeGChS7EV5Qj5SQzemLJMa3esd6kXK6reMOZ0pEua2ygCF4lZHOXiKauzpiIVoYUkhXrFb7oRYAsA16k9lqQuozpRjvEyU3MG50kcB5/5eXFGJ/aWC5Q2K4puM/umYhi5BDGdEnXeGOOdap5nWxY56yQ7NW1ZNC/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l8Uu8NHF2jbnPxajH5F7HKuH8h11+rIAfetOur0PbDoKK4+zSf4bp2g4SbcI?=
 =?us-ascii?Q?MIPLJxuPxbt/c2Kn/vwo4CzmMQSVcw5raUm89NEHwz364pfzTr7i/vfzJXbV?=
 =?us-ascii?Q?PVUWpx3AtmOwNN892lsqlWg2j7DLmlvn2/8tCHY+95aIy7z62cAvRYhWSFL0?=
 =?us-ascii?Q?Xeqp/WDnUC+dHhs9PQ5aYgSdOzMuWLje5Slh/zMjNNL0IB3vjOqvoxLcCKWk?=
 =?us-ascii?Q?u5f0psAoWRcPY/8fVa3CjT0/iw1CPNRKznDFZLPQJ/L+rPx5M+I3VWkDmTYL?=
 =?us-ascii?Q?4+QVdTeQR/0y2zE2TfUt4Qll9SCBwesAyCx/eHyvchNUpNRjhepC/KDeHYFP?=
 =?us-ascii?Q?gX7HRixupPm2G/lq9TaF/j87T4DSfKPP0mOUlZKAUoq/qPecGRjMxG/dD/dt?=
 =?us-ascii?Q?0y8JKlvBsQnvGpTGyHhjXLlC3HmBRyXMq+UjRgN+kxpzwFOrvz7urvQa6xak?=
 =?us-ascii?Q?vZCbTLhyl/1LBylQP7yUfM/6e0EMem9BZzLVQSdyeZAEY+mGCXQxnAwXAjBw?=
 =?us-ascii?Q?4DyFDf9nvNG735kibz8+p0fkb3Iyxe1pbu+WJsorqBbOWHeBqsiIdKakSy6l?=
 =?us-ascii?Q?6N8SsrFsa/3dOWWj6lMDTJAvmJRxz34eaTYxFC47yeRXu5RRRA0rEYC0kAGO?=
 =?us-ascii?Q?VaWLDGYWDucURdDwbyc1I1KU+guc8ouvglx83TZp2+M6XKlIsBgZpUTI1ZQ/?=
 =?us-ascii?Q?7o+RQUnxdTQLIwHGgDhYNrwpG2PxrP0X9TDcV8OUEeSfg3+fVwgDm4DhpepZ?=
 =?us-ascii?Q?aiSpMmCYKbVnGqR7nzVtinpTLMUXmEtVwXV2+JdRFtS4RBtkkbpBVWFwJzot?=
 =?us-ascii?Q?MzV3SJPP7AYwQWuxAb513JRPBLYDDynCfFNNFnF9lHYLX5a9RjeYyqt884qE?=
 =?us-ascii?Q?kSFi3U1YNyh+bMjnDfMzLPF3z8BUjjcnCxibgz4JV9zEHFBH/IRETP1Fkni+?=
 =?us-ascii?Q?2DUF1gy9vy3xbtIaF8/l+llmyERC1P+sIUfBAvu1NZfWruaXdHgpMJsR3VAC?=
 =?us-ascii?Q?K7T1JpSUjSng/aqTl0AseddPafEYeMs2ZhSVzCJ775ZH09iFg3hgARfWW61k?=
 =?us-ascii?Q?g7Oo/cFSk+vEI1K1UloLxWUHcWKgSa2b6I6xTrZA5iXvJ0+NyDhKMf3rAsW0?=
 =?us-ascii?Q?skHqk1fSIwuK/zCikB+/133L0MXHNMXlLjbNxZvdqQ64lcmbbsA0vZpY99FD?=
 =?us-ascii?Q?dEkT+tyXbjBputJTapowSBUIcGsfCS9faxisV3P9f41NPz8q93SQEiJ99tZC?=
 =?us-ascii?Q?Efw/mKTq75Wy1H2XGa6oHI3POj/6y5LCqy1OUtt2aM+U5BeyBxtuz+oLW/DE?=
 =?us-ascii?Q?/yu/7QPuHNTqdLHawi5nFJuNof/JeoWLJffNaD9e157vG7sBaIsvsslhvotz?=
 =?us-ascii?Q?wbSCqYTlLZPa4rQtw1AzLx87gF32yUkmgWS4lgQ7cT+agOwXdZf7+1D4BD4Z?=
 =?us-ascii?Q?DfM9HCULZiyM7gMmcWNa4USHD/MCVXMaLd6PcqcIBmhwiEDzo47kBYwoZF3p?=
 =?us-ascii?Q?k+xsKBstvWxgiOMeb6j1nYT1deD+TmqQ/PldmjEly7NCqvrDh+SBSR7uT5z7?=
 =?us-ascii?Q?19SbDThAbwD7C8AU8piz5b/Y8JNRF19QkUQXOIse2dwlYAlqWi0GoDmtMU7l?=
 =?us-ascii?Q?4bkzTVw1Nk0q9j7Gxt0RIUNKR+XrHka4V2JTcn/Yj/3bZfJNiERBlXvqqMmO?=
 =?us-ascii?Q?j4/HWs0BTusA5ktFncdRQDC9BjZy2Dr2c6xOKbOdgn/JEoyNOW/9mayg5aZ9?=
 =?us-ascii?Q?wWIKh9H7QGmgalRVhACqz1c1oRKNr/96o3uA0nVjuitus4ZrzXxu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c0d8ac-46ba-4890-d2ad-08dec7ce73cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:31:05.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hFIlMvBIG31k/oFeNWSBgzuS/jQYk81frKzY1Op4rCnnWJhnxUADQ0UW+ch1S+CvaOXaYwro+tcaZP6dsxIiH/+Ba1HhsDKCTaZZpXqffaeSND6dp64yuwfTOICjSeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8361

On Wed, Jun 10, 2026 at 08:52:36PM -0700, Rosen Penev wrote:
> If dma_async_device_register() fails after fsldma_request_irqs()
> succeeded, the error path jumped to out_free_fdev which only removed
> channels but never freed the already-registered IRQs.  A subsequent
> interrupt would access freed memory.
>
> Fix by adding an out_free_irqs label that calls fsldma_free_irqs()
> before falling through to the existing channel cleanup.

use devm_request_irq()

Frank

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 3009e1531292..4475d50a94f5 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1306,10 +1306,12 @@ static int fsldma_of_probe(struct platform_device *op)
>  	err = dma_async_device_register(&fdev->common);
>  	if (err) {
>  		dev_err(fdev->dev, "unable to register DMA device\n");
> -		goto out_free_fdev;
> +		goto out_free_irqs;
>  	}
>  	return 0;
>
> +out_free_irqs:
> +	fsldma_free_irqs(fdev);
>  out_free_fdev:
>  	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
>  		if (fdev->chan[i])
> --
> 2.54.0
>

