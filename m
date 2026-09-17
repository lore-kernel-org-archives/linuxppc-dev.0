Return-Path: <linuxppc-dev+bounces-27537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C4BC982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 03:25:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlh3l3L0Rz2xyk;
	Thu, 17 Sep 2026 13:25:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789615555;
	cv=pass; b=Tn20TCwNG+OvOdn+17TgJBO8hDLqPqqgLSVbkLNkO3SCJ4dZwVYa/0/r+pYuETcR5nGcEoI64cDoO6ns3Txjb74z/oVbrpdtf5llwMJWcOjaRlWTWOuO75phhqRPbTCo7GPPBtkk/6ryuLsjAbN7rCarxjnLKu4D1VYxVedtXVtI3L1Iu4qsrCsRVgvkRr5VCV8NwGp9heSngGu5zW8rQxw3XvOEdm4d2WQC5nyYZrZBdkrIMIFHy0WQMKOP4oxUEn1uXijt2hWCqrDBprMdVbXub67PX8NOFMjXKkwZ5Rf9I5/A4uHzo5AP3v0wofNlt7cLBH2xWS/FLA5gYtlU0A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789615555; c=relaxed/relaxed;
	bh=yM5lfL+Ye2Dmrrr3sf3/fTciotYK/DdIvPzXeJbkbmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7/PGg3YX1eOc7K0L6HFYMS3spJsUncT+DqxTVeWuoZkktQQs2jYNLP3djgBOWFSuT/5pnNl7P6fFQVIia3O3/UkuYA0YBpjoaelFEC45in2p0wU0PZ/1MsTpbDaSHtY9IGDgu6TlnkU47j2ccCegp4HbFNYk9x5mHm31p9RGR2SpSOoLwRL8vndVDvjOSMoNgSAFE3eHqjqsSMGnFL+HVKrBPlqZjWbFz9hDaF2BeI3SdSBhOHxX1bwlo9+97Rzl4t0IPF0Lv141/FDT3xQ3RPviGgYUnklb7FKoB+3iLhNSUeoJNXDtNedOBu+JwSO07QrLSaPcRD0P2nRIOaRTg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kaFXoUYO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kaFXoUYO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlh3k0130z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 13:25:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrKrHD5B+5esH7xsi99XCNBNnpkFaAm2gBMsLmm03OeningNVav0Od8OeoGKH0302MWotqHpQSPHqfFjbfRt1gtB3ofcy1VYYQJf2r9V+pDzJ8ac+GMyprUabV/VCfVb0AxYrYJYZ5+tIHctnfhp6ue0P8xhV9VvKJnw1L4U8kuR4kjJ8tytOuu+sjQcDlBDJpX28VhH6eFn/IYEuged4CjfI7cHm0G8SE/Uk+l3nGnMZl96NbIROekKTRYk3ubtYxeg6+l2ouMqee291a3tyIT2+PP97Vd8SPZwm95l46y1jeUyeFMlhJ454fpv+zKKFR9b22TWI9F6+0eXg/5qmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM5lfL+Ye2Dmrrr3sf3/fTciotYK/DdIvPzXeJbkbmk=;
 b=vJO1kevxxOHA6XTGEuz8jwsX+1wEwSxnNQpyhfzGNrCeAO5vEwPeujIex+2MD0vUrGffPYlijgcMEqWKeQTT2jRYJh/KDy7UiIBcyYyAqmzAmzMh9+oKr87E4ke1RKNrTbQuPyZesCijocYJ0gIITkYhGtF4DRZR/FahSGtqlaYQJsk4mUD2XylySE48tbyUo4X8za0putNtKHVKapcyl2pHXErq8kSUKaU/j15onwlQZW0KOJF9N5no5t8RbYf59kRhbSg/w06TJG1czi+YYLucYKIybARozbqzlho7P0DWxl4n+Ee2nQrxYlwEn0TRuGG2r+B2PaZv2/ut2nEZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM5lfL+Ye2Dmrrr3sf3/fTciotYK/DdIvPzXeJbkbmk=;
 b=kaFXoUYOw2nzcpXyHpM1Y5qEB+aSBzkiGhKj1zgl9So/4RPCPy24a6gfEATctCRmlohAkZ16CnVyUPDc1UGQp6My4OsCNxSvsRH2oOocpTkEyYXM/8PpdaVrCU9FsmwNU86Kq+3DnZ4bWqgsqHBNzzF24Ene4uU0Gz316wm2eclaaEutKxoanEKxHwszhhH5PROfCUsHOZMoRjXy+TASFEYNcU1GvK6ykeCxC0aU4BAbUG8EG3A+xa49jV4pfpuCOvlca/DrvTi0MZDUFUxlSgey4ow/kXzTXFXr3a95G7SQaW3RMtNreAfpAKIY5cDB7HiH+FkETIKFATNaY7yRYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 03:25:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 03:25:28 +0000
Date: Wed, 16 Sep 2026 22:25:12 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2] dmaengine: bestcomm: use platform machinery to get irq
Message-ID: <aqtdmOzJSIawqKQq@SMW015318>
References: <20260916224156.276511-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916224156.276511-1-rosenp@gmail.com>
X-ClientProxiedBy: PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b26c908-dc0b-4e66-6202-08df146b5216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|23010399003|1800799024|18002099003|10067099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	o/EN7N7M7DvoZ0dFxQ3DoYV1grZdS5gGCM3Kq6c0wYRH+C7nGuweOpxO46dCbN6s0mEKXKlh8atimA7RSr4jhoWU8Zy7Fo77MNNciBJdlnT5eMzi8NS7XMo5YkaE3rX2fabUlnFq2uyNk2pYmsu6DYMFvKmkvWSYp5BXh1Rqq9y/ujcWi6PCb1CQ9FYE8D49W0hlNDY/89Cfznh0RYrJdAWpmwE7AlPqceUZBOn6hkmifE9DMP8avQ/9LQUt7o4wDtIb7pr6ysqjGYN7XNloW5Nl74+D/2g/5zhPToMDTQtz0aXmLUb/h0+kxvsEoDepE+LC9DehPNiJPLojQp+LUn0l/keYyRQIsP5nUNvO8OWqprVEPqT4rY+VQyc/CtL5NqJjvmNw9ATWNH1S0CaG9LHQIKv5EdNv0WnXtafVVNfjnpR53inypncqrjKeWSa+L2CtH3MXrtCH7p0rtqWtToICyDMepYyVPwVIo88IseZF6qix8ghMgli/SxlTBnq7disHbR2tdCIjk6nzqM2AcNX3CV4auUAgW8Sd9hJ2K+4N+kPSzrSGqSLnyft5n43504R7/wIUQv20Vlee9e+fn1qI7OrFIoAXPX0rXJ+AVFXTh8qzSkvMfn3NY1CRwZ0Kkui+icyG2cDLiAuBnHu1Ti7zM05zo3kqoiyY1tXe9w8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7z0A8MTYhfyZSupEX0SF9bek15F0BcTZ0076ZcuGr3r6MDa24dNk+AMyqbdF?=
 =?us-ascii?Q?Mh0B/5oaVkYJeBKGP4zswA8TJY+kRI0sjSK2QLnCJTDtwDErfeeNzwLn+TvV?=
 =?us-ascii?Q?Sj5OFvFmZLPGpVaEXEpIIJv9Pn8x/FHK2RGPylC1DU1+xp5TBXyCGAMojXLY?=
 =?us-ascii?Q?m07OK7sQDg2R2X/Dj2CQ7DV7tzDhUoLGlmyi9nIgcjfheJIbNvAyhH1LL/8w?=
 =?us-ascii?Q?8bhPrur99Jcm86iL0gjH7g3AyGYf46IL6RdQGC3n6ju3Ur7Qv70k1+8nKN97?=
 =?us-ascii?Q?bvIk2tEmzTovHKAalruafGy8a351lWzmzFECvqLTgQONfYT2teXpD93v4JCi?=
 =?us-ascii?Q?kp+2Xqp3adn3bko+Jx3qcMpScILuzvCr6pnmCso+d61bkqXtCzhXgQ2EASsj?=
 =?us-ascii?Q?SZjyfEzu70bg2xriFVRLf/uJIh9LJFXWB4hDr9LcUfY/cQIhzBmc78lIjU3w?=
 =?us-ascii?Q?d38+l71S1OZ9mkk4BM9EhBO2OahkIpGOcXl84hHDK3t8yEeB7D12U7TjwTOv?=
 =?us-ascii?Q?jA/ROyx4Z2OMOqq+G6ZwgYurBWEfhmFTnLLt/SJNEgkk651/Vct+G9Xxfm4Z?=
 =?us-ascii?Q?7xW1btXoBEmrD0n0DoGTgiAaQyPq7WxM7wDssy8FSBQurhqvPs4aieuhx+n8?=
 =?us-ascii?Q?kVtHTFO2k1kf6K6vGs/PPhTFe1B3jiHs+uzYTUuKNjUPI/x+2XWhpbAcQJvx?=
 =?us-ascii?Q?3wtAH6N/Mt1JrJaOLnnjVhV80CpnogcF3VZkaGzvGdi13ee5ATAnHkrvOBj5?=
 =?us-ascii?Q?tq68TBYeOrDk0kt/VnHKg7HD6+mGI8jASZ+NEylfr148nXQUyHkXBIpARENe?=
 =?us-ascii?Q?6bVmvJi5mQltFYsoWDLeRs/68juG1kUKsMq9kTmt/hRNI/ELQtveD0cVu5vX?=
 =?us-ascii?Q?XLm66t/lQErCaL3caN+kEDmtKaaSkAgrKGjqPimppvOAJQBNrd6imm7Csy+5?=
 =?us-ascii?Q?0cbrA5ntsgzEeR2b6Vzqcve24MdEwSOBjJJvDPOX0M1pOIVUiKEAyy7nnUDr?=
 =?us-ascii?Q?hXVxVk+kU91JOMRtL6sWVxBXwL9FHhxKfSqz4Una4IdTq88T0/FFgNSrQzPh?=
 =?us-ascii?Q?oCWPV2+BXzO9/QhbUlL5/VZrlkwg9S2uW2b1Z8aBzNOI5UxCZriynB+rGDHl?=
 =?us-ascii?Q?mctCpNh06QxTlf7XMP7ejBwSRSqnjLvif+82nqIHj9b8qRcNUoi5jLP+ya5f?=
 =?us-ascii?Q?w3SHrsP6KRrrbnd6krUCIgRAk2HuF3xlqPqfpd5QmxVmky4Og1PfXnErNN9r?=
 =?us-ascii?Q?vSP/4N2s160iZVyrPfV8f8L4qXrctJTU3v1VCvmYWZ64bKyFbP3M5VwkUDlo?=
 =?us-ascii?Q?fCmI/Mb5eBIgfuQicrQpxaQPnss2AaDmF2U673tdWdXGg9/zphbKpoKSPCx1?=
 =?us-ascii?Q?Q79gVa4ptbUxe8Y+fvQcSVvbsGXVC/q1H8Iwgm+KzZU9pRIaAqDPfnIUr/4q?=
 =?us-ascii?Q?sbRHcCsQAiPdctXHQYjcuiCM7wZAPoqjTAJRKAt8axmRWK8dZ2NdO8AS62EM?=
 =?us-ascii?Q?6kOAzp6YJ/LMlo9gNP1vm0ZLvpAJih2cyZohX5hfsc1vHf3NdUInmDrS1aF7?=
 =?us-ascii?Q?JfZJs+Ohssgr22HRb4d+itbiKXLvnJDzs2G6RtsVV+++LK5ROBSVsWw5YLgy?=
 =?us-ascii?Q?5rsL2d+JbpaW0fs9FFBvqavyOTCI1TCRcL5bqF2QwCWQGBubeHeoqXIMBrD+?=
 =?us-ascii?Q?p0RR/5YmrCu+hVj0HQoVRSO0XMyzUz8IKm/Ec5e3jl2opjfXox9dSVXnbnXi?=
 =?us-ascii?Q?o8/knAJ+IzxMT7HWb9Yc7OEEWzW8jaCV8dHUQBmSoATrcKzG/VC2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b26c908-dc0b-4e66-6202-08df146b5216
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 03:25:28.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZTP9r3ba+AwW8Qev5KCYw2X5999P33AbofPHGvkbx1/nW4i4ShXMIm9Ev7sWMPmgEQwqekykKgf3Y8GWuYu0n6Qf9pr0fwhljqc/r6IuA9V4+zuKKL7bwQv3enM7QB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

On Wed, Sep 16, 2026 at 03:41:56PM -0700, Rosen Penev wrote:
> platform_get_irq() avoids having to explicitly map and dispose of an irq
> by having the platform_device machinery take care of it.
>
> This requires replacing the device_node with a platform_device in the
> bcom_eng struct so that platform_get_irq() can use it.
>
> Conveniently, this also allows getting rid of of_node_get and
> of_node_put as the platform_device machinery also handles that.
>
> Replace the open-coded resource lookup, request_mem_region, ioremap and
> the manual iounmap/release_mem_region cleanup in probe/remove with the
> managed devm_platform_get_and_ioremap_resource() helper. This removes the

update commit message, no devm_platform_get_and_ioremap_resource() in patch.

> now-unused error-unmap/release paths and simplifies the driver.
>
> Adjust the goto labels in bcom_task_alloc to match what is being freed.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: resend.

If resend, don't pump version.

Frank
>  drivers/dma/bestcomm/bestcomm.c            | 47 ++++++++--------------
>  include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
>  2 files changed, 18 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
> index 241a91936fe8..1006030ff167 100644
> --- a/drivers/dma/bestcomm/bestcomm.c
> +++ b/drivers/dma/bestcomm/bestcomm.c
> @@ -47,6 +47,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>  {
>  	int i, tasknum = -1;
>  	struct bcom_task *tsk;
> +	int irq;
>
>  	/* Don't try to do anything if bestcomm init failed */
>  	if (!bcom_eng)
> @@ -67,30 +68,32 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>  	if (tasknum < 0)
>  		return NULL;
>
> +	irq = platform_get_irq(bcom_eng->pdev, tasknum);
> +	if (irq < 0)
> +		goto err1;
> +
>  	/* Allocate our structure */
>  	tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
>  	if (!tsk)
> -		goto error;
> +		goto err1;
>
>  	tsk->tasknum = tasknum;
>  	if (priv_size)
>  		tsk->priv = (void*)tsk + sizeof(struct bcom_task);
>
>  	/* Get IRQ of that task */
> -	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
> -	if (!tsk->irq)
> -		goto error;
> +	tsk->irq = irq;
>
>  	/* Init the BDs, if needed */
>  	if (bd_count) {
>  		tsk->cookie = kmalloc_array(bd_count, sizeof(void *),
>  					    GFP_KERNEL);
>  		if (!tsk->cookie)
> -			goto error;
> +			goto err2;
>
>  		tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
>  		if (!tsk->bd)
> -			goto error;
> +			goto err3;
>  		memset_io(tsk->bd, 0x00, bd_count * bd_size);
>
>  		tsk->num_bd = bd_count;
> @@ -99,17 +102,12 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>
>  	return tsk;
>
> -error:
> -	if (tsk) {
> -		if (tsk->irq)
> -			irq_dispose_mapping(tsk->irq);
> -		bcom_sram_free(tsk->bd);
> -		kfree(tsk->cookie);
> -		kfree(tsk);
> -	}
> -
> +err3:
> +	kfree(tsk->cookie);
> +err2:
> +	kfree(tsk);
> +err1:
>  	bcom_eng->tdt[tasknum].stop = 0;
> -

avoid unnecesary change.

>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(bcom_task_alloc);
> @@ -125,7 +123,6 @@ bcom_task_free(struct bcom_task *tsk)
>  	bcom_eng->tdt[tsk->tasknum].stop  = 0;
>
>  	/* Free everything */
> -	irq_dispose_mapping(tsk->irq);
>  	bcom_sram_free(tsk->bd);
>  	kfree(tsk->cookie);
>  	kfree(tsk);
> @@ -377,16 +374,12 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
>
> -	/* Get the bestcomm node */
> -	of_node_get(op->dev.of_node);
> -
>  	/* Prepare SRAM */
>  	ofn_sram = of_find_matching_node(NULL, mpc52xx_sram_ids);
>  	if (!ofn_sram) {
>  		printk(KERN_ERR DRIVER_NAME ": "
>  			"No SRAM found in device tree\n");
> -		rv = -ENODEV;
> -		goto error_ofput;
> +		return -ENODEV;
>  	}
>  	rv = bcom_sram_init(ofn_sram, DRIVER_NAME);
>  	of_node_put(ofn_sram);
> @@ -394,7 +387,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	if (rv) {
>  		printk(KERN_ERR DRIVER_NAME ": "
>  			"Error in SRAM init\n");
> -		goto error_ofput;
> +		return rv;
>  	}
>
>  	/* Get a clean struct */
> @@ -405,8 +398,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	}
>
>  	/* Save the node */
> -	bcom_eng->ofnode = op->dev.of_node;
> -
> +	bcom_eng->pdev = op;
>  	bcom_eng->regs = regs;
>  	bcom_eng->regs_base = res_bcom->start;
>
> @@ -426,8 +418,6 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	kfree(bcom_eng);
>  	bcom_eng = NULL;
>  	bcom_sram_cleanup();
> -error_ofput:
> -	of_node_put(op->dev.of_node);
>
>  	printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
>
> @@ -443,9 +433,6 @@ static void mpc52xx_bcom_remove(struct platform_device *op)
>  	/* Cleanup SRAM */
>  	bcom_sram_cleanup();
>
> -	/* Release the node */
> -	of_node_put(bcom_eng->ofnode);
> -
>  	/* Release memory */
>  	kfree(bcom_eng);
>  	bcom_eng = NULL;
> diff --git a/include/linux/fsl/bestcomm/bestcomm_priv.h b/include/linux/fsl/bestcomm/bestcomm_priv.h
> index 3b52f3ffbdf8..cddde7c74cb5 100644
> --- a/include/linux/fsl/bestcomm/bestcomm_priv.h
> +++ b/include/linux/fsl/bestcomm/bestcomm_priv.h
> @@ -66,7 +66,7 @@ struct bcom_tdt {
>   * This holds all info needed globaly to handle the engine
>   */
>  struct bcom_engine {
> -	struct device_node		*ofnode;
> +	struct platform_device		*pdev;
>  	struct mpc52xx_sdma __iomem     *regs;
>  	phys_addr_t                      regs_base;
>
> --
> 2.55.0
>

