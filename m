Return-Path: <linuxppc-dev+bounces-22500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C310CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:29:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmmJ1SZzz3brB;
	Fri, 12 Jun 2026 01:29:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781191792;
	cv=pass; b=XDPK1TP3QR7046s0Yk/kDB43SECKVP6wrDEWqARA+kY5xbTUjTgmcZKdhR9HSGMISm740oi3nZOILXYIEuqnRV/V5aize6GE8PTdcUb/OP6md0bO1soHFEM3LYHypoSeGS+JwVBPZEx9xxqKCJxy6u1awknLnurd9AkmcbabvBUGStJ5O1kk0oaytdQ97NKGTaasfYxmfCy+/9aEFKWhsc0fovW6qKP3beafK/Qs4GBZt/wNeYoIb5mPUXSHNK45WWD+mcDSgQBGkZiY5l24HDeIOHSfYcARXGK8h+t+ELD01PeiYRU7t/DxRFcHoSZKlT1FYVFiu8vvmLil1Mt0lQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781191792; c=relaxed/relaxed;
	bh=xE3jig+kS53Yem4o6yCp0NUu5n3XAC0goptZsTjuXkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CclKswTR1xR6+09+/+OUJ1znwia+gZY3/Xnx4dQP0rc2F352L5YO2ti5kOm0JFsW9e7dSuU07z7rZPpL75jLY0TB24exLbGh5sEwKG2ZfAowmeRw0c7fFW5JyhAZGswxN2lVNoXKQg9axpxIbUHWQEAhPpYg4z9K94o7w7lOEvtmMJcKLsouRin+ETWGoxd/p3W1m/PLsJ3tjf2rCpzJ1Fh03p9asnZVZyHW9raGotH8uVrCzh4Gbwmu9rGqGzo5N/MNr8qEC5N7Vfg9I220u4xG6vTfh3poTUetA4x+VOjo6VSoBm2Yx/glH0jObZhG8z6PO42SHZ1rUw78YhVRSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tzKk47e1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tzKk47e1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmmH3gTCz3br5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:29:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVh393DiYiBjGd7xiwcMYlbYH0izZDlnq/DMPnoOWXHDBj3s53uhbY/q4Kqcso4fweJ8D0QaJGMDN2fIxxgNHOzoZmaTCFNmznz1mQ4YlbN3jy+2gmRAFnO1zIv/vhLzOyUtpwHeV5dKnxebOYBre3vERplqtBxtfb71Gn7aRpKav6i4bwa+IsomzE0Pb+dKnzbIcTKdOagFfbZy7hFR2RPiYxKaTw/cCRzDlxuQtUGoE+M/r2Ng+DXGDAN6Bd6xmTrLwx8D3STIcDpDXL/U/u21N5+ED67sELxnDE/7KjxiajfNZ9CuMzKMlCiHk/MPd7Uh3WuRwHsEcYtEWz24Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE3jig+kS53Yem4o6yCp0NUu5n3XAC0goptZsTjuXkw=;
 b=CARl5KDeECVJ3sKUZ4Cg+FQuiSweQTZ8gDwqlQ+l25S4Tadj8E620KWeF/6zU+y4l3kWYc1I0EzaA//3hUwZmKXR7mRigdpmla6nrp+4Hw15Ur9UpxTbTvmDmgcoH5w9dq6ktq7ydukZw4pYZnFRb982xljXO+xT+jUCjVGXOKmx9EKLeTH92/g3Ht3N1QymMQAm4U0llq1vDiXqySCDNRYVRfVr0uRC5uM4eC2/s3bxfgFBi6uKrbjC6Y+b0NhCjFsg+VB7qETlaYLQeDGOcr6nrETLuYVF1jR4vetfPjEDWHLJ96qCS1TJCZjKNO7hAUAgx8/a1TOLjiNEe5JiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE3jig+kS53Yem4o6yCp0NUu5n3XAC0goptZsTjuXkw=;
 b=tzKk47e1w8omzeY42CW7FCjsoJupGI1hNzKHMHW7FnHMArZHMf9joDytXqOcPhCLdO7uS7a+h0q2InYDs/A7bNSomBlKp0hgYeuEH/XrvxvMNHJwbQJbj/S4eKKlWAxRHRyB8iyCNzWjN0eTtobWAbVvmi+WX2UO5PiqkkQ/llqQmXMWLOveaxEg5Nhv0dY3OPkzcyCngcfZij3ijTx2/pBHHkn5TphMg0cXVHxceTmDzPwWGeLUBJp/X5iJ/QAg5k2jqKopvixeacg3dr8E9hCFEGXv7BsaefsETdEf969u5pB4x+pT8ezuS3YfTI0h+fS4SjwLlk3EcfL0RydyCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10639.eurprd04.prod.outlook.com (2603:10a6:800:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 15:29:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:29:28 +0000
Date: Thu, 11 Jun 2026 11:29:21 -0400
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
Subject: Re: [PATCHv4 05/15] dmaengine: fsldma: check
 dma_async_device_register() return value
Message-ID: <airUUY4NT0hYSr-b@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-6-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-6-rosenp@gmail.com>
X-ClientProxiedBy: SA0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:130::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10639:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3348da-f719-4d6e-89a1-08dec7ce39be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|19092799006|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CHMTDhUu8VNTKGRQDhcYS8Gqc5D9AFKr9wcq+xxBet/mqh2Sfi/X0fekKfnAdae+dzw1mWZ+1GMJ73s2x0nQ1w19qt50c5z9OTmEe8aj+hPPg2NongJem00gwGSWaWJD3pqm2+MXyRbo492uAjdJO6T/w/ElsVnTqXNF428Nq18A38p4rpkM7+fsqWPiON/l8jAGdOGnddBeJrbl8VYWp81LA36b2FZGoksfQR+YdcNJaQ0K3NIwM+8xR4H/9yODF5duLolwjmB0jTKbISvPt78qWbE2A69Vhr58zTtgu969qkV+lBIAH7pXpU8793xwiG/lpIVeSkURz9dtFUx/bSLAWK/JlD0J3WLsXBC0/RyIEHTom8NVDKyfccQ56uOI98V1Sv2o28M0oFkWAYPtj2boIAphs8vQI8xZXjVd3Qc+Y1rIjECYuncleE0NwOeUsXmF2qU/KBucLUC0dltP6KJBueGn8i5w59obH7scioMRlGS/vJizMwaQnCbN0On34GDLhzHeWCizYUA3+/FKXs0upSdJVypc3qJu7EOTVkJxeCzqJs/uzRf9os/VCWHQx19wbymR8j127cXQcNeL9Xa0oFfoqGg2cKicOFdJIQezYD2VbQVIJZtij5VuzxXBuJ+DRyTgLfy6ygaPsSosHyzsnsvhWVAHeks4EQL3n7g3dn+ikYQUXmxF45gh+JN1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(19092799006)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aSvFeKfz4oZb71Tx4ncKasQvN2RundjYG9cZEJns6c6czqXBqyvaJwkTZ01G?=
 =?us-ascii?Q?B9tSC31+r1/tF0HkAjCQVRApzhxGTatu8Gdqz6yWvzc33uRP1uNIEy4bjXDS?=
 =?us-ascii?Q?COo/8OhdEHaxHxbKx1lxpatCDyyHIzXNefyxQ5/rtIrSrPhyUEziaAnuSg6h?=
 =?us-ascii?Q?8MylPkJCiQincbuTn2waMbnsETXjvC31kIdexeAN+Bj0dFLtPeJ6vZE7+FKC?=
 =?us-ascii?Q?DHhIJ5HS1DM313m+hJaLVxMt9/UmhIGyWi0nFWk+v6qlKtabixEhejt+B5rc?=
 =?us-ascii?Q?OWTpq5F3sIBDLAfzo151+QiuHU0+CA6cuveHp1F4DrlQPA5+TWv+O+NiLQ5h?=
 =?us-ascii?Q?tUY7kmslEqbHZDi01RgclK2U/9LmFHpxOPz7NasQvzl+gqCT9yifrxzGbm8P?=
 =?us-ascii?Q?c6rIcwcXDYVSU0P+2/gaL5zRtCguuw4syFt69HDrX8ZKY/F1Eef7VSHxty9Y?=
 =?us-ascii?Q?RohygKcTmCayIUiIh6D1SrMI8Bq7jqcC6EygMUiKjmYSvDZxAdiruHd3G2Ca?=
 =?us-ascii?Q?yjBgan2DZesTSoywCb1Amwvt9dMc2v//Vqf+WHnwAbzY05yiiDp4rwEY7zq/?=
 =?us-ascii?Q?BailObEaUXHVUAzJFRwLXRo/qsIcXqJJnYXCdwtGhMxwt4sx2rGDZybSe88C?=
 =?us-ascii?Q?Yy8HBYdbHnoz+9uuypNzmvo4Uzz7Pf/BsSd7a6DNzWN8GiY/wJ70cJyRyMFd?=
 =?us-ascii?Q?S0dYIvHL08jo4gRobfRQzpUZX7PxCWKgqR5nhlXNsePwtKNNH/ui1CXh25UK?=
 =?us-ascii?Q?nv7lQ/0ZrfckwRj0jKA99i34Ee8WtBLn42ErwNDtpshLUFH3/ZQIElIHwmPr?=
 =?us-ascii?Q?48a7Ev+EiAei8InOPhcDZZzZ3c0p1pIIcqvWwIW4qVAfgp57phcf4xXZqHsY?=
 =?us-ascii?Q?Teq4jB0U47gTauisKbYX4y1UM6leIyP3jas3FhQwshaO/QYwc95Q6w3A7acl?=
 =?us-ascii?Q?CosD0f5UlEttJ+Xb31BycN7KvBLBmPEdQSGL2HOoVW9PMjSwKtncSMAC+z0D?=
 =?us-ascii?Q?0iRd7KMrDIDT8VAhAgMv5EepVqkeFh9CG9jCPJ7/lscvQauIqpLdAlAS0xup?=
 =?us-ascii?Q?kAQkXs5DqnhJxvGtiGcU2VvTyQL9cvtn9QP5a/Sur2z2EVVeCKkNgBoWkQd3?=
 =?us-ascii?Q?pfWkQZk9mvoe/u5ZzHq0fo8MzScIMOSe/NRIiE99Kx9FN6wI+rb7+FonbZoF?=
 =?us-ascii?Q?R8WSI0x/5TaGcgaXg8rkXnPO7aOPUkvbiKvc8mGPAJWhwtkEUDf1P3SIZ5OU?=
 =?us-ascii?Q?wGK8gQU38iLINhKvr2ArCiw9vmVlQzgV8cfoG726LDCyp3VfQmHNl3R8XGbn?=
 =?us-ascii?Q?xezaJHx7DSdzz/TFpRS/batNkccwK1RKriUAzzc92hYOsjXUnhBo+rNgx1YD?=
 =?us-ascii?Q?eLBtS2Mm6y2yGOxDe6imOOimAGkRA9Y4en900P8Fj5d+sqfY5yw4k/qwy1Ic?=
 =?us-ascii?Q?pmo0TNCsRkZJip5yPZG4zTmFyILSdikY6jR2N04TyfkjkxpqLKIZsGOI2LnB?=
 =?us-ascii?Q?1BLKBzm4E5Y0m+WOBpPFLwTjFCKeT1RhqbEgPyEykI4/VP4wf4YP3LxsjE9A?=
 =?us-ascii?Q?2FzkfcsXuKvkRyD038T6KxIhfk80VxMMrNNQUPuZB9YkFFZQ3BKvMPr8GOEL?=
 =?us-ascii?Q?XUL3y8W6MK7JaC6z9QWHvuGIRRRA8ztHBDZAwATzhaEITOlfhdttwGMIUBse?=
 =?us-ascii?Q?v1IwHr1dSJ+CABBjgwXAcWA1ZTlv7gw7z8kXrGVC8EJNoMjkvz/wa46ihopZ?=
 =?us-ascii?Q?p+XZlKMb4FrCeuwOpTJM2p9Phw8nBNJXjBtDDUn5M7pMMbCu0cZv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3348da-f719-4d6e-89a1-08dec7ce39be
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:29:28.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rJ5IQmD5TyYtgapoE3ZCATgwLu74BfzJvCBPM5yO2pujsyZWA8N8DbH0GJI6LJU0Y7uS1QeoZrycgdqqyHBg/7lLbo01LA/nDIE5NoQnwGTp+NNMtQQ2ibT0ZM0ZOYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10639

On Wed, Jun 10, 2026 at 08:52:35PM -0700, Rosen Penev wrote:
> Check the return value of dma_async_device_register() in the probe
> path and propagate errors instead of silently returning success.
> Previously, a registration failure would cause a NULL pointer
> dereference in list_del_rcu() during remove when
> dma_async_device_unregister() tried to remove the device's
> global_node from a list it was never added to.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Suggest change to dmaenginem_async_device_register() directly

Frank

>  drivers/dma/fsldma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 43d817f6ded1..3009e1531292 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1303,7 +1303,11 @@ static int fsldma_of_probe(struct platform_device *op)
>  		goto out_free_fdev;
>  	}
>
> -	dma_async_device_register(&fdev->common);
> +	err = dma_async_device_register(&fdev->common);
> +	if (err) {
> +		dev_err(fdev->dev, "unable to register DMA device\n");
> +		goto out_free_fdev;
> +	}
>  	return 0;
>
>  out_free_fdev:
> --
> 2.54.0
>

