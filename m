Return-Path: <linuxppc-dev+bounces-27222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6C8C88E75
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:23:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk6pP34qsz2yd7;
	Tue, 15 Sep 2026 00:23:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789395837;
	cv=pass; b=cj8bZ0v+/I5tWuRa/8WjzUbCfbqufYiQ4wNBSo01woMGWMnay7Pr3MatSbeyJnEbiVR7KIC6tGSXaxxLD5nDIBNzI9kTAgQ9jOPVtMmfjIJXA4w1X1jSKZyyGiY4hrreKOeaK31sShRYIgnRbL4M26NYvM/S7l65uwAr4v54Azfc293Nm7GoK8MgTlMWBJSWPSJ9fXkR+6rqLZchI4IQjFwtjEsZX0nTaFuPYIX0RUNFhzjlrQvfNc2UuPFqjOrlCFtPP6nWVHqU5cnE4t/+fArbXIr82XEYEhzl5yIu8olQ5yLgF9bnmszXdq/puasLCuZoX1zy6j/dWDliswXVWg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789395837; c=relaxed/relaxed;
	bh=AxY9y3EQEIjKYAmPGHB2pQQqgQdeImm4yoZg62jB/x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fGsIEabz6BEqCG8KupptuFACUtfmJ1PpVB6vRMOIlQ6QNWckgjqo9+m0I7ijYtg4XXyJvEhkT1Mu9Cdl88BbAl2+oEneNkrgqoT3377z+Gcypmw1ZTBHORmvjTjIuZw1jpkABYvr0mGporz6VJSDASVFvpORmLRan5GTj+CO4sb0rA9Xd1zsdbeqVnsRkoBYCMjiWMsB7ets66ZhzG68LPHlyw9KpwNq8Uakb5u4rLgd6hJZluytUDu9BmBWymduPOe11sTFmOFgF3WNa5R2fZjNqbY4k6915PwEu2M/o0A7S1o0U3AJ29CO3NNuIdKrMTGD9Roh7Yzwri5GRYQToA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G+bau7qm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=G+bau7qm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk6pN2VtQz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 00:23:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OywDmd9uij8nh43ls8GfvXltaBj7Fgw/ym4c6jyqFNwkW42sYOinajPf/5ogSYcYE94b3daxK+99J1ivwCWB/9rD3xAK/CXBEwhsMFixv3ZmSc/TEA8mGcwJjF+w8RZsgetogDgQhhvl6gvu3ch+U2+L4dwUS8zPsJ6N32uLdH8SHf/ogAee+pUhTsrVHUfev9B6VUbMfU2ennjQbwSkRU4Iuh5rYVlNGxrOokJgU1NWNpUEm2v+7RkskaXwlQhPasWoN9Br9B2+4s2VSeVzJ+NaDBii1giAV358UrxhdBwt1ZQysk80NweJbq7XjaRnjn7/OAy4ThM+tdKr9zpslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxY9y3EQEIjKYAmPGHB2pQQqgQdeImm4yoZg62jB/x4=;
 b=nPd4JXUd0ZsHqDAgtDapMM375NKDcJXQHWqTvvNbfuJ/5kBdk2yacUeX5m3J3nHwZ1K6Xlb7XqMVU1EPD75XcbbJUkSXweJp5nz4mZzugZyALq0gaNXDntM6MiyP+pmjpUdYBx/ws4P8VJ0t66+gmuojdduPmrTpDNjMmZ/IjlHZukHO8H+AAZfTlTAVtN/Ax5DQwmqkbKRyyZo2MF2QF83de3aKR6jpkkuKcLaAINS+OTIlUc0wY0r5RQ78sNXph8uuxvdPW6N6IbJXVXUTaeMcIusRHDbc8JUzVLhfXyUrB+NBbAA4q+j52+vowLAwkpoWCViHHqmAXZmHzeERdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxY9y3EQEIjKYAmPGHB2pQQqgQdeImm4yoZg62jB/x4=;
 b=G+bau7qm90qwrqsKcojDVet4x9Te93qrPnJDyUizHwRo5BpcdEFm6W/To5U/gHK+gB9BDzfiXgKaUPo6pEHAm6a+M2j4MJ53yG3ZRW+yqWRRXdkbzlc9Gz6LRcft3nqqZ/yXRgarPcokeSZdRSCj0mjG2elKdjzF8ZX2TNXI+0GzuqOPrbvx2S2j6AymIzjNny4ixyJvtjLQHze3stMdNsdfWcoGBAw7L9SKmBlSpTTusw0pSG6GeRI0i00bRdJ6rVdjFKgyJ+fwoyjdgcAwzO3id7c02hQSsTYKYdY6HOen6tirFPAIOl6ENOIIgLTT+F0q1m/kJpitMNcODz/HiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8540.eurprd04.prod.outlook.com (2603:10a6:20b:437::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:23:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:23:32 +0000
Date: Mon, 14 Sep 2026 09:23:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2] dmaengine: bestcomm: make gen_bd init helpers static
Message-ID: <aqgDWhGqkYki03F2@SMW015318>
References: <20260913194804.39939-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913194804.39939-1-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 207d4fdd-aace-4b6d-620c-08df126bc126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|19092799006|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AG/wtdGvgB8tfGQgXkmwcgyegXQkdaiavFSBT5gHVWSvBXZTb6dZbFg+5lAcVa0Oe3LgOtdIYo5P55rDSX8aNf7f0XYViZC+olEHKTcz0LbuGFw9ofW7a26YwSvImKsYxwRIujEKFZHh2y/qUDxW94Woq87na8clhH+yCXiZ6iCnPu7iBpnqAuQmwJjeOA/MDsSTNyAT8xDKwS6xvQ7s4sCZdOLR7Wj8veI40OR2tWJ38SrhfFXZ0Rjy6437fdJUSatzomA0vWxbcUaa+DYZgBYNCqM4ny9ZdLl8gH2rvC+NVMyIRFdPioBI+sGn+fcvI40AfMhSsfS2pXmFUJGDu5hcT/CbH8QJkG9fsEei8UQX5HyvRpspN5DZDBWfB9PwDt+ufEBh46TZB0dXgnXS1hirHUJB7JNsX0WjL1Md5THtv71wpnlfVCMSqAeNaj563YpcUZUweu2Ba8zwsQzs2rHVvDuetyyouDQ9UwQX773FYqI1WpdaCy4fXD+cH8ybgyGKRh0TIHomsmdHmRSRm+tvWjf3z5AkU2Nh0vpkAASTgQ8TuzBssUsJVcOLGx5fnbE6aApU+/wzKpJvWZO2ZUsh5hfgX3XESKkQHp4U0Q53eB8K0CW+JW9ew3YpKDL4BLJxfWhQDHTGDGnERHpBKoqlalH2DoYl8yskz4iuGpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJY9r7zUDs5pl3zyrG1Bwcg27eGp69wTgUw9fhxhpnAH5As9pRjkjfYtyhi7?=
 =?us-ascii?Q?PZjbWw5uZSSInMgrmdfZGhz5K12iwL4kP9cK3+1aNPCrC4vDDWdqY0XmlLGJ?=
 =?us-ascii?Q?CVxOA5iWrhPwhMWaDdsnZFB2/Lh/pt0j5o2+4ai3gEtd2DDnSeS3JrOgwjyp?=
 =?us-ascii?Q?kOOqqCOJ+xM6i2yOvl5GYvo2fKoWHg83WGxMQv+TKjpmCxEJqxxSxL5ag/OD?=
 =?us-ascii?Q?6MsfDPGoxco5HVw3C/bIW2/p4jza0g9lXUATnjfHul6BxCRd+tbzMqwdvm0F?=
 =?us-ascii?Q?465b3S+/rwg6t5CWxjaXXqD9LRaXkEDS3x/bFiVXS3y8hIt6TAJGh1hwAGf1?=
 =?us-ascii?Q?IMUU6pbpV85w+gw6ELsuKkStvqy+t2/uDfPVsLy63+V2VcrdaWa/3ZozExy0?=
 =?us-ascii?Q?qva33q4+l/XGIoyA1OlMUBBhsJtAj8JIkzSsKrtn4Xhl5nkVKYveDGL1uBM3?=
 =?us-ascii?Q?F0RY3BONNHRHg9ouYxmHoJPNAJjt66UWIiAwZp3oQelI9e26Zq+Y/9ytwHL8?=
 =?us-ascii?Q?6pYI8HEO+KkyShA+hS53Os4LwVev6p6qFWN6bxKlI+5GMuIYz3ln3xhR0YUj?=
 =?us-ascii?Q?88QSGpNN3pD0/joU/fMwItBJWJDbtS05dKzvsLiykTka3ooaj5E0W5PiL4da?=
 =?us-ascii?Q?Zgol9QCH6LyjB+v2tBaOQOuOyqCJ+5DX5OdXHtHuwOulXYjQNM6DL2Jpi3H3?=
 =?us-ascii?Q?fvnslciXy9Ez2Wjw4wY/xBwbdl07YIJRHyubZjg7oJ7aLT92Ly7cfuwHykft?=
 =?us-ascii?Q?aVh6N+QdOFOsb9PUwvDqkuRQwVewV/Mu7PSAF6ItgqN8XRThlisy6Um/QPiR?=
 =?us-ascii?Q?pleTmj92VxYecCcXF0T1tKLlI562s4CPd4ZSlqbhlEGBSV6g3rqiVit0PH9y?=
 =?us-ascii?Q?zY1UKLo/hgpbJ3Y7E2nTGPK/jvDNSobctRSF/2c7LE2qEu9x72MBevfqOO83?=
 =?us-ascii?Q?AZg9+xIZzBt4kapKN0c4b2hJnn4UeXQjanukDxeYmZum+DZJBr6D4xvFIZDS?=
 =?us-ascii?Q?4H7kSjmL7SO+a7h2/TjwM/KSoaRYUxs5SHvFTS2Ys1aIzxNHm5LkI8m6VVUH?=
 =?us-ascii?Q?ZuwPsEhjj5vsKV7gbnPRCLZcx/cMHuB/OZf0Qe/JgeJcfEzuZIA0dh47zome?=
 =?us-ascii?Q?9rTAOBjZLqWom3aotCX0qfBbJVzPT/civps4BJc7uJMLGgq/6wOuNhHsAPlE?=
 =?us-ascii?Q?BWqBM3QlzRf2bayq+hfUupYijk1eVO+tkhlxem1S8a/2ZT0ScXRWd80lAoPT?=
 =?us-ascii?Q?a7JDhhAeLKx9IC/qxrgFfUx/wvc7auW5GUX/QmFklvlgpu6frh/ZHeZPa9ut?=
 =?us-ascii?Q?gqNYtPA/7b3dK1fvHqmvI5yHpLu3wsPA0A7YWE4EwJx1q/6v6lqF9TywSUd2?=
 =?us-ascii?Q?Q1P4Uh+Fld/9IWMtJEYEgnZTWw8sF7vgd1lTJnPZCnJoFpPqs0Ujr/Kn9jOZ?=
 =?us-ascii?Q?dXtYCQBH7ydiQM3jQhU8bd+Z6q7egOf7MAWotQNEN2f5NHvEO0WIUlACE+vk?=
 =?us-ascii?Q?FG9BtO5XTXU3VrB5MXOd9qQwiC4fP9f0fiLHiaAZ4L7+dhgppvUDdI4hD0DI?=
 =?us-ascii?Q?eFBwOe8wdjD+PQFSQETNVRkD+1u3pxDWCrf7IXV+f0SuXMQG2WVQGzgpoV02?=
 =?us-ascii?Q?fl/4lJTxnSPK/Ik1BExm4e7TvV7GvCPsy1f1kjfyblAbONYKcP4LBjoMFUgx?=
 =?us-ascii?Q?yHXUQabtvrqUdF51zzvxhb1wSskJY3f9k3Fqfo+4jqWb5Ds0ZZvcf5WOgFK5?=
 =?us-ascii?Q?KzhHzctYoDEeaXU/8MYe1u0LL54wCNF7iV1iD6AUAvkY0ukLWOBl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207d4fdd-aace-4b6d-620c-08df126bc126
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:23:32.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOg9A71/jX/NUKRP+iPbj2s6l7Zcai2i3gWeCuNR1soaLJ9tb+mPs8BUg/gbuonPHwf8vqfmxstH1uP7zFo6W8I1U56jcrbvWYP46Tj6aog2mK30PcZE7wkv56WRs55c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8540

On Sun, Sep 13, 2026 at 12:48:04PM -0700, Rosen Penev wrote:
> bcom_gen_bd_rx_init() and bcom_gen_bd_tx_init() are only called from
> the PSC wrapper functions in gen_bd.c, so make them static, drop
> their now-unneeded exports, and remove the corresponding header
> declarations.
>
> These had use before commit 7d3ee229ea51
> ("powerpc: Drop MPC5200 LocalPlus bus FIFO driver")
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  v2: mention driver removal that made them unused.
>  drivers/dma/bestcomm/gen_bd.c       | 6 ++----
>  include/linux/fsl/bestcomm/gen_bd.h | 8 --------
>  2 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
> index 61b5746e1a97..b5093f7445cb 100644
> --- a/drivers/dma/bestcomm/gen_bd.c
> +++ b/drivers/dma/bestcomm/gen_bd.c
> @@ -81,7 +81,7 @@ struct bcom_gen_bd_priv {
>  /* Task support code                                                        */
>  /* ======================================================================== */
>
> -struct bcom_task *
> +static struct bcom_task *
>  bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
>  			int initiator, int ipr, int maxbufsize)
>  {
> @@ -108,7 +108,6 @@ bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
>
>  	return tsk;
>  }
> -EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_init);
>
>  int
>  bcom_gen_bd_rx_reset(struct bcom_task *tsk)
> @@ -166,7 +165,7 @@ bcom_gen_bd_rx_release(struct bcom_task *tsk)
>  EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_release);
>
>
> -extern struct bcom_task *
> +static struct bcom_task *
>  bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
>  			int initiator, int ipr)
>  {
> @@ -192,7 +191,6 @@ bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
>
>  	return tsk;
>  }
> -EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_init);
>
>  int
>  bcom_gen_bd_tx_reset(struct bcom_task *tsk)
> diff --git a/include/linux/fsl/bestcomm/gen_bd.h b/include/linux/fsl/bestcomm/gen_bd.h
> index aeb312a1cd00..7253d308d77a 100644
> --- a/include/linux/fsl/bestcomm/gen_bd.h
> +++ b/include/linux/fsl/bestcomm/gen_bd.h
> @@ -16,10 +16,6 @@ struct bcom_gen_bd {
>  };
>
>
> -extern struct bcom_task *
> -bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
> -			int initiator, int ipr, int maxbufsize);
> -
>  extern int
>  bcom_gen_bd_rx_reset(struct bcom_task *tsk);
>
> @@ -27,10 +23,6 @@ extern void
>  bcom_gen_bd_rx_release(struct bcom_task *tsk);
>
>
> -extern struct bcom_task *
> -bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
> -			int initiator, int ipr);
> -
>  extern int
>  bcom_gen_bd_tx_reset(struct bcom_task *tsk);
>
> --
> 2.55.0
>

