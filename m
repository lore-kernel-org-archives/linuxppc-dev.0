Return-Path: <linuxppc-dev+bounces-27264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879FBC88E72
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 15:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk8jM6bxRz3048;
	Tue, 15 Sep 2026 01:49:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789400983;
	cv=pass; b=fq3yMV18TNH4Q4FYBC8FyrgRwolnLA0TF85TB0U2sUx3TLwf003I17H9UK9yf07OhFsjGqJHuBN9YmhDN7BgPNWSC+DQh7ATLXw6/XPLGpEsmWdlFlJhioPS0XVrMC9gPD/Za0zNbbshiYW9kZ7czwXBIPOmD111zbwZXe6fR+la7wSNqgzlhPFsbr6X9aLMCa3YaKbjVdcYAW4GAfjG9DbKzo1p3Z+mO5lelLYKCqhx1Db43L0aVQvZ8X/qV5cRbrWnyAybbvfGJrJ76i1wQ+X/u1LbO6cqO+Fkm9nWaoGfhIWN1HqONJEIJfIFES6wf5sahQ6YhfphpYDbY3SOpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789400983; c=relaxed/relaxed;
	bh=kyGt1+d6cxEAPy2BYn/gK6FUbFRsxKznDwnZl+tOdLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dJoKWPyS2Iu7Qjse4+jwneRP2rG1ccJtLsmn7WVsdleCz/LwVZbLBEXqK+Ve+rPdweiy8pPscvJoZc5ct9GMf3N7fLHop6C9i3BncaZRsIjDX/a7qzgIXyso3FD+vXMwIKskiZYEEqB93Mp9Bp2iitG+p0gleKETAFa5zD367jBP3xjO3otUlSzvc+x/ukUF+K5+XN4vYAgTqGDwYk+MVVwglEPq48sD1LLLFmn5jX55mBocTFaC6Y1BsFkM9ztR5lrgbp9EYoshk6kjNh5icowB/WkX/9pGseQS9oalsuPYpLP1lzKFWEQcSfgXi06rV8I05eMKBQMsUQTCvvZZ9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f/ZB4Lis; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f/ZB4Lis;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk8jL41YCz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 01:49:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZU98Up8oPoh591fpB8hwxpXIvIvwr+DvA8iebAldyKpdPZF41IgENqOEHkrzlwp2odPddF8hadBJTC35cjZjkKNU3X1jrqqQfytTgZcabqNu2wHLoTR2Ettx0q8aWYEcwZRSXk5T1liiBPepgAYfgMFA9x+qfGqdM3d0eoFScxGVRZ2aiIUlBsAH2znpRU3WsaXedvncc7IpV2dni5Z/b7olbsTqktWm4EGknCIyo2qkv5TdJJyahhswDj7uT39qG6A999XVjea7O3huo8pUK06DrL6VuKvzdZhzRwPB6lgOAXEpIug9MOEAgZ35rBHk61VB/vb2DQMgep9G8dnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyGt1+d6cxEAPy2BYn/gK6FUbFRsxKznDwnZl+tOdLk=;
 b=IH47Sk80bHPyXKRprnS3WT4BU0RKsD04Bwo+CwsmDEPRRfE3otJnpjxpBIHhQojboAaFSm13ygxeRCSMESGXEpyBhX3jS8Yx5ufmd5D+80DalyT/7hJK2LLLOdd0PULc5t8U3btUZ81Kybo2PY3xeWpe0pBFPQxYDrthDmbBngpK5iSmgzMWqS9CYCkin2r8ddTgklkPF3keZ2cAsTY3UfdMQ+FeLqPmfkGAVXIfze+9ljp7JZdQY+rFBr5EJn70EKM3Zqsc+Md3W1zEak1t02Rmw1lYcDFnC6pqKtdsL3LjVDzgfRsgIFM7Py5XJ/Vc64TtZhyPOWfJLYT09x3Eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyGt1+d6cxEAPy2BYn/gK6FUbFRsxKznDwnZl+tOdLk=;
 b=f/ZB4Lis3AQLRL/u6TYleIwp6TIaQhSwUVgyThAEC96LephTyx7WUTz62pksUHxDhpUZ4lbk2FQ+aenMDPHUMQltP+k7OIX/rny7sz2zmvI8DeSs9srFFOUBVTHFiuIwJaidL9WA7huR7SPdRBfG92VWVTHLiJsFAQOYiH4qS+XjBgamzUyvatN4M8iAgCvdHVAiXeEjsX06AfSKcs7PfxHH+8Zt8m6mPBj1nQM7MwV03OD6/SkvbXxIjickfNkGclxGTAV0OIkbkimqE9HDYmojJZljALPUo9Dg0FcBKw7yYyi98cJu7OdkOv3t36hDj92C3kSZayCvQaH0ddc/Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 14 Sep
 2026 15:49:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:49:14 +0000
Date: Mon, 14 Sep 2026 10:49:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] dmaengine: fsldma: convert to
 platform_get_irq_optional()
Message-ID: <aqgXcd3Ru9xvek-8@SMW015318>
References: <20260911220439.177474-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911220439.177474-1-rosenp@gmail.com>
X-ClientProxiedBy: PH7PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:510:324::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d088b-1cef-430a-7296-08df1277ba0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|22082099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1Lg3EEcDZgKLASpxtTnHXuvKpJ6wix3OHnOZYiaMQLyBBi5OkgGiK3AFvaUl6rtFRliGeBBaHOO0mCAiEmeEtscsPsPhTfUK9DkYa8TYy5uZkDF0blVyK9Jhzb/y+0mO6+YM7PEFyTyLkZJXysMeXRs9/Vudad/ez76CIQhAfbcgUvjRhmIDXPUHYzeESXZ0KsrwFNeTwF656Oc/jmh8QXAPNMi4Rukw9V70e/3Q6UJC6qlX7rTuYevDFgNZ0Nufc6qKcMR71/d6dIKnZtCW5isLOsPGg/Qf90WExlHM4ZIo+lgHzRG6/cBbHUP5YEDWWjEBBa8i92o4cYB8ZwSTNZexP1cLdI9OOOjfy/hZf92pOxuWuqaBvsh7FIEZvMv4Fav6cWljII/7Y2BaGd4ot6Sa0kC9ghMi9qibZ7cpqbCnOUkc9/JE3GojO7cUfMZdE8b/CwpIiFst3WoTKysI7s1JV/ENGcsdBxUez6XzMAa4qpO4tkNnZSq6jwmWn99t6pfkWmR8Dac7/kT9FNEca9noW9TEwcvAESYorc8Sec+78xGr14x8AidR7/UUHi1mdVadwTpPXMxfihtZxbT3pGxTvnb1neW6dnvebPVw68pG0wAKspTb8+lohMFGU9VcPdJT8itJdBotYHD2oticJqzbF3CI31CWhFaOFd8H6tA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(22082099003)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jNqVOBwWkOX9v0JwH/02o6I/EIrkvA44aBNLfmQR5vUqx+G5Q7owXegknxeh?=
 =?us-ascii?Q?tXt8sesmCFKCaZcD8r4pHGZ1KB1IW294QIlb0rITkH9vXGT6IzVmfW9oHM12?=
 =?us-ascii?Q?l8FARsioMCsOFJ+vdK8aGEgf4eNgxDO8//6NE2sePfOwS0KPex4O1FWsbxoC?=
 =?us-ascii?Q?a7eY2c4lEmEUyU8OIHnbLaaJNtDjJUfrlv1x/2XDKRE/82Gue/4sI08L5IgE?=
 =?us-ascii?Q?XqFBN1GMzEnYwcStjun1+fsZiUhxIeAmqaTmMyPjZ02Kmaqx/sQ8u1CYUg0Z?=
 =?us-ascii?Q?RYM899B51XDdmFUMvlSpmUXLa7yxZzRgscYLzQNpyn6Q8jmQfqtGB8RzlmdF?=
 =?us-ascii?Q?FfW1D4+Z+g4SQt2vNALSfFzY0i5iiAATvu71PqtMLNewK82wRRNM7sEb2ITk?=
 =?us-ascii?Q?CWdT26zfHdPLszbxTf/em4KeV61UMqazPSuQc4aMqtlbKHHaf1vzOORTkkIM?=
 =?us-ascii?Q?pDsUsLLYxawW9Q61fEdB9kP+wvNncMxwVHJeJzI+vVIioTB9oli1YnIMYL/M?=
 =?us-ascii?Q?9gbnRzezloho/aHPpG4BZdHce+Zs0npgHzlbsJl2bomPdC6XH7h7Sy3eKbNx?=
 =?us-ascii?Q?kYs6zQdnhYrN56n4ihmHzzZWc1KhG9FQOI3sbsCicYrekYUHq5GEJYCtek48?=
 =?us-ascii?Q?/FpRDhdRXWTElVz5LSHL6U2r+1zTL2FIpWa+JnHnfDLcvHJlRkKubsbjZCGe?=
 =?us-ascii?Q?oOZ8N/izzvp/xZDOS1BQSVERxL8fQxIIHqelzzBCTFzqdNKAAmCuHjZc+3h3?=
 =?us-ascii?Q?Upi1Yh5H+/zLTHBMIFXiIunO+nwibzKAuQHhVjQTW/D3R7ME+rt0FzLGpSmZ?=
 =?us-ascii?Q?vU3+Qjs21ODqoDS6gL152cSr3Af7cagY5jx0jS/lpIn6+9EUpAwrQWjoOQmJ?=
 =?us-ascii?Q?eeFBsAX833LkpikbkWVEi81PAIQ4vitfDiDhwqJyhcRP4rEWQvJBMRN7jcFu?=
 =?us-ascii?Q?gQN7MgjQ2E4krogMQ/PJQxQkeDugCrQwC8Hu10EvWayw27TJU++l55DS+OoP?=
 =?us-ascii?Q?FIdRsuWHb9XXQS2Gf0691H8nOwcwYIcaNJNXZxZr1fNWshEHiYSmONeE61Op?=
 =?us-ascii?Q?sMo+P+CcCyMJbcfOQ5ive+RQmoO/rjVkCuIzEMSTB8++/7qwBgxdk3dJJK4I?=
 =?us-ascii?Q?4ZCmMBpgvMmFl8GNZhdOGox/VXcC7RqLc6AguY/gLhCgDGZNkL+x0OyRQN4+?=
 =?us-ascii?Q?k1r8oJn8PH7FAeavBafpJ6msMKKbhY9sVEoeCBmx8L81KZphOc4UImb90n+f?=
 =?us-ascii?Q?94mTh7pjXeHHWU4vZHxFG6qBXBhNRcxd0HKAjnk2LhrOwnyEw5DMe+uEuoZ8?=
 =?us-ascii?Q?xaZSZzx1dcbKBJFJ9UbwowoYWFRoLJ7g0KQk+0BOzInrGHsvx1lQf3/lOONA?=
 =?us-ascii?Q?oqiHYpZxjyWa691MOwlb8r0GGiggG8tMlyL5X0Pkzw6xwh/Paj5VVlHchf8h?=
 =?us-ascii?Q?kNpymZfMKI6YQ1pFvJV63u9smnB9jCHjAOvFx0UWEpXCwf+dWQPK0Icmgcu/?=
 =?us-ascii?Q?72yUFpYHbitVOypviQ/MT2vKYmiFhTGbbUrE9UJdgVjwj3DSbt3UtX3j7Jgl?=
 =?us-ascii?Q?edWFg5fBzelDHIBVevvnhI38P+wWFQzoNIXBKAGN4c9Rk0OsXJHmtp/llFxT?=
 =?us-ascii?Q?sWrlqht4vuDZVa5NgjkoT0BibNr/E89Pktx1HLq+HfW93zwB05MckWftRinH?=
 =?us-ascii?Q?m68i3INm5SJx8uKagfRAFGaVxkxrKcHTXxzl+2+M36sfOE62hzf8oOO4+bCP?=
 =?us-ascii?Q?V4wW/4LMSVI5U3msf16P8HUzSu4XDlJzXntOGwoo8cBTunxTxKGE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d088b-1cef-430a-7296-08df1277ba0c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:49:14.5098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GP2tiyKXQXzB7WzQXg46CdPo2jvuE3N0b6chRXZLkehbMJtZCIYVTFCjn0oYK+ylKYVeWiEsd8z2gIIgM5Ia3ZyHxjOAkKBgu+mY200k0jzVK8pDNhQkZgQUILtqN2QF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077

On Fri, Sep 11, 2026 at 03:04:39PM -0700, Rosen Penev wrote:
> Replace the per-controller irq_of_parse_and_map() call with
> platform_get_irq_optional(). The controller IRQ is optional when absent
> and the driver falls back to per-channel IRQs. The corresponding
> irq_dispose_mapping() calls in the probe error path and remove function
> are removed.
>
> Moved before anything else in order to handle -EPROBE_DEFER and to avoid
> doing extra work. Simplifies the if statements as well.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  v3: fix build error from the move
>  v2: move to the front of probe.
>  drivers/dma/fsldma.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index fb19c60540be..6db2c4d284c9 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1224,8 +1224,13 @@ static int fsldma_of_probe(struct platform_device *op)
>  	struct fsldma_device *fdev;
>  	struct device_node *child;
>  	unsigned int i;
> +	int irq;
>  	int err;
>
> +	irq = platform_get_irq_optional(op, 0);
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +
>  	fdev = kzalloc_obj(*fdev);
>  	if (!fdev) {
>  		err = -ENOMEM;
> @@ -1246,7 +1251,9 @@ static int fsldma_of_probe(struct platform_device *op)
>  	}
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
> -	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
> +	fdev->irq = irq;
> +	if (fdev->irq < 0)
> +		fdev->irq = 0;
>
>  	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
> @@ -1308,7 +1315,6 @@ static int fsldma_of_probe(struct platform_device *op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}
> -	irq_dispose_mapping(fdev->irq);
>  	iounmap(fdev->regs);
>  out_free:
>  	kfree(fdev);
> @@ -1330,7 +1336,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}
> -	irq_dispose_mapping(fdev->irq);
>
>  	iounmap(fdev->regs);
>  	kfree(fdev);
> --
> 2.55.0
>

