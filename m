Return-Path: <linuxppc-dev+bounces-18964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BC710F3DFC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2026 20:28:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjpx85JMQz2ySc;
	Sun, 29 Mar 2026 07:28:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774729692;
	cv=pass; b=SVlW6re14RS9IfcKWyz6dP5+lS0yCjCc21qxsdDY+1KfjJo2bdV4QXSRq5ci/xcsJp18eFDHOr9buB7dEBY2Tbjq3z1X1hxqA/kt/t5NRK5kFzWVhBnh3O1zs7dg7RA+IfW8tK8mzQ5FyPGOUUIQGXJbkXhBvHZCVRDmQ28TYGxXzwy3jbuFvJ0KILghFis/TLxZmtplqxE5hULIdbe2SyWRC3yB8suiGMn1puoZy9X4BpRTP29JO1K/Eh4siHfXQ7JoyFOmtqh/147GS/f1PAilH5xasLRW5B7AaDQWpZkjjZ2WA6xD8IivvpLYG6rim6jEJJpQcSLp3ukNlcobiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774729692; c=relaxed/relaxed;
	bh=L8aekTJ0he1Llm+d9fS2uEH3oCAzAopBHvlmRtfDapw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h+94ySXNFF91sRpvdQ025tNF6HC+YLQIAXuBWO84mUf/nHM6yE32dtMngYuV7X9RUsLR/djMsed/C7w9yvzl02KhZuoM2xCk8MA7H7JDbSbM5Vg4rKg9AsCVJ6usYUtGCFU3tchMWUdcLTmtjuOrIwMEx8Q8BTR9XcHDjI7Rn9QVU+L0FEY+gQnOc4lFVgN77cq86OY7R6jksVek9nipnW8d1I2S5Wt6uH6fvE+E2GGD3ujRhUzjMsnQsdEoOYwlAXG9GD/wy3dNpvm7Ei49z61xNWBfxcc1DTId0h4u3DfWle7gO1FwCuo5uKieq+7AA+8upBwu/QeBgl8oEGThlw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nCVWHLW+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nCVWHLW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjpx73FX0z2ySY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 07:28:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFSKoh2jCqmxregr1Qvnogk2Hp6wgWFpwi+Md9xcoZSxbXA/0qnAMI/9DPQj9WZa3IyEk2LmglpRslMhmvTgoPX/3Ae+0fd4Jf5ZYI5qpYp7k/Q90+my1O144S+0tzZ7bp4JhHazzaIlOW8JGSKuMsEq4040x109b8ppHNt+oJW3hWN+tqxs2wfP+ySAFbncpYWl9yXXg26VB1FGnrpbyHv9YOBMy5uDMbLIrpVIUctd2m1tbDf7AYlXlRdYLAT9jIB04Sl0WQAP9GoKDX5vPB/HrWmOVIIXKRMYHCN0f0jMME6kXpTPgN/ManYxTN0VARK/lP59QgR5fbb7ZcHkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8aekTJ0he1Llm+d9fS2uEH3oCAzAopBHvlmRtfDapw=;
 b=USGz8k/mSSkeCUW0P+/ZmRoGUKx2kqOb0+Q1q3nGZla+GUlcKU0G3FPVH7GxI4covvraJM8UQzXzKHg/jxHbCaCa8BQcCFbSOrDGjvuejWftawfGtt/J1KTek1Qt95EnaSYhhUmY67hgMvNX8MaDWz4kYrY+x0XQRitr+CyLz/tpF2PA9Il9TTNE94exa1TLQNyM8/aKCiTbIynOWJSJdBqF9l1ufwH7ciGbeBHGJ08rmIZF5DiWvGq1wcFH1LMnWKP0wl+V4AQIri0yJizAwLoE/4VnHn0/krfIkCVaF+WiZj2hetp4AUF3ls2NnQIAHznxYq19R/VVaTVxO0c3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8aekTJ0he1Llm+d9fS2uEH3oCAzAopBHvlmRtfDapw=;
 b=nCVWHLW+z27EsTVO5OZtRSJSQL8mFdw+od2RFlWE+djc2P7KaHLnQucfaPMWgjTFeIw7PasGPFP/7AVnPEd7NMoLx4jEbvyPf/JBckFj64AU1zgic5Umwi2bW+mdxBddHp7PYozoEJK9tyYE+Nxc6jH738aoCBjiVz5uHlNIyXP+nQpDXA3QEtZRhYCP2IfcXqC+nc2yRwRey4dSPflgg35bqcURg1tS4846L29fHgZNKZ/VylXC2Zufnsn4cAPmlVQb/60Pwsib6KCYfyLIlLlqNAJ/m5BHqNhkcReYuoSlEBOKiGzZ1h6jQEMyfG4hAReQb/OywBz2Fe+fHqlUAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Sat, 28 Mar
 2026 20:27:41 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Sat, 28 Mar 2026
 20:27:40 +0000
Date: Sat, 28 Mar 2026 16:27:36 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org, chleroy@kernel.org
Subject: Re: [PATCH 2/2] powerpc: Few misc cpumask code refactors
Message-ID: <acgzqVOlH_RlY8D8@yury>
References: <20260327063129.127302-1-sshegde@linux.ibm.com>
 <20260327063129.127302-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327063129.127302-3-sshegde@linux.ibm.com>
X-ClientProxiedBy: CH2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:610:51::22) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9e3e4f-a15a-4c51-eee5-08de8d08747c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5fqx6TbTjIrEDx6VRNJUI0gQwcLLFuC0o8UPQc4ZkGzGaVLcaf/CMqrzJn7Q/7NonR5MyQgWGR3U867dqE40tXpsqTkv7clNlz6XryIE6SjxCBTuogVsesh43hzFvFdYqcMKS0xPDDgKUu3cmumUXadhExzpWNQmluSmFOXvStHdDR/MRVfBmFBrlkQvovSbWku84OPo0BVDo8dSfjtr43+SIRdRRx2pywidp0/snFGitmXSwU89Y+39fbE5J2w3kqSSCogGT4n8uRCp/373TTjqih89Xuciw0jh23H6UHs03EWzwzn+OjOewT1J/W9hYmFsX12rJfHM2EdG24bGBz5BynQ6MYgfWoARVFwbaihIfA7FhYVP8pbv29H05muOkUnCHeUtDnHLPSLNIQ0wiC/n2/Umb6+OGvUTLInNFGYCDEjmUCz8K1k2nzeouMYGZwNCqTMDna5+wVMgTXgoJ9yeBZICTQwe1sbnBIewC4XcljDwG7ZlI+6oBJ5SfM4FjUuRvELrB5wN3SvKTRMY2eW2LBmW8Da5otonmNognd1WtVjLK1XcYFpTZURuMrXqVphw640aMVSmZ15Lu9axfuCA+dS2YRAJ0oYIiyVzYvQvl+97GuwiPnoA0oaMo61UniNwjhMHMQ/2sSSAqy9pxPeWXLVRlGIT718wvpyqzr/r1qxtEUcPl77odQcZpXHto6fIYgAQ825GKpJ712tUZiYR7KTq5LjWMZsLaKLsBpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycFOGxg6C1yy7FGPLcK1QzITwRbrke7kGEgoxQdhgSS7CKcM8gsDfaUMJHUP?=
 =?us-ascii?Q?7iR7mvrw7mcYoz6q82fwpKairE2X59Y2Eg8AUmhsyTUdzrOJ3xBj50T/SBTE?=
 =?us-ascii?Q?CLMDsFAT5B/VQStHXFNx+VxJjjCiPtAhxxlu1gkeEGi+kkVELB9pjzuF9OWE?=
 =?us-ascii?Q?TMYadFs+6uI0OXtDkv5MpKDrILRnX8j6HMvbUcPkUASMU56LI9/h0vbNaX3H?=
 =?us-ascii?Q?3abY6zluNtge7XCpZ8+10/+7hJIcHAtVIEVFYqAL+UmHDR2J2fFS/RMQ7p1I?=
 =?us-ascii?Q?gwur6TXA059spdItJH23oWWxtQzoUDX/BuyZ1q4DZl5BT8DyS+4JLBvrclD5?=
 =?us-ascii?Q?7kHUZOidiVFGus5qTymQoiGJRjiginVtSYzSXrxa91bRv89+6hdhSBRRcNp/?=
 =?us-ascii?Q?Dn4q2XyUV6E/RZD6YRCn6+9IC1P+eiOQyUhftjej/FOuoxa9r+jYV9+LH6eQ?=
 =?us-ascii?Q?jYHECBxk2fGFDsnqsb5KFp5G2DRnSAG6rWTL861z9Dlz2xpkDwb2v1BYV9WO?=
 =?us-ascii?Q?zm0pbxszoxn7+oiMae3AYpyC72usoCKWPwQCIjyC6h+8fbwhNMX/DdpK/Kgh?=
 =?us-ascii?Q?WnJYjbUKwVC/vxviBXuH2waIh8nrbDm9ZNS4DJfjvQXTEmf+qA4+m7z2L3F1?=
 =?us-ascii?Q?cHdAQsFoE8Toe6V+p0nfwGQX7xG6AnbLoqGmmvm0qfkvIj74uOPUxM4arX6t?=
 =?us-ascii?Q?B46Qr+gE48Sy207UwDoGRMlqIwJklZCSy8wt40eR/6MdV22TXFxRs7zcPfPU?=
 =?us-ascii?Q?B64WjkQInt8gKVwCMbz67dT5kdBq20wAkS9i8bDvHOYYu9WClWWcC5R2hDJ3?=
 =?us-ascii?Q?HuUGCnmrNlO3x0EA5pXyILGBbKRZq77J2iNreg1jT1a+2agPd8Z3K0XAl+7H?=
 =?us-ascii?Q?+zHSJGw+gSRHNtJwcf66ghyAVOg33QTWS9InpfJqRYtEY5O2xJma39CwQxeJ?=
 =?us-ascii?Q?+SE496DY0/B5jpusZOdf/wFN/5faeZYjbGShzhuaBsPqrsfUiBMGbppBan1x?=
 =?us-ascii?Q?r7ez0zL1BhO/5Tide5OTq25CbWSfb8kJKqibzJbQnXrj8sJzzh1sA1kJS6jD?=
 =?us-ascii?Q?U7ik21UvXDFtlxBEPtu0+yJRFYD1pNhZk4XswhHC0++TYrhIbMn+RY/iLHlJ?=
 =?us-ascii?Q?Moc+5eYUeFSv7KEAxLrMezZ9++vQ0OzGfBLx1ZcUNomA86GobZKDe8NvTVuv?=
 =?us-ascii?Q?15STKrKfmKiWCjPn/wa5WblI1z3wO/Fm49tP0BY9gj0rQatrA2XaOHLnG77l?=
 =?us-ascii?Q?mibvSEWEA/FwJRLqmiqKOlAWnXB9p0tzfW3AcSbDgl2m1a2iWysjYriTwvGU?=
 =?us-ascii?Q?fpDnKluAXV5XaONki0IwOkaPGSDKI+vkFo5ij6ZpT7p1HFdq2KBZ6ckceoyX?=
 =?us-ascii?Q?USphrvqTpFTIy81UKe6zZNZajZTfu2BQ0CtCrJ+csjEI2TcUpopYB28wSyLu?=
 =?us-ascii?Q?YDyhyBH6cbCCGpNNiZh56v2CF8SNiKiOmFWIUTPiugi0up1mB+8CalCYHNO5?=
 =?us-ascii?Q?vpMfsTira+nVKhYUBUoVU+SdZ6cP/gffbCnWcTTxA16IC37HrRDJRhoIO/OU?=
 =?us-ascii?Q?FHBeS3Y2kWeiMfzRPX4xCp8ugJyUzimRf/I3bqcrroOtO40BHUPJcoPo+C+K?=
 =?us-ascii?Q?Bgu4Iplf5HDG11fOjD7mky4O7f6KYecVbGXJG5bVKwvZZPIXQvaOPbw8aEkN?=
 =?us-ascii?Q?4EXOavTrTfecue78w/n92DkUC2/g1lSca0SQQwGaloT1BRlPyVJh2vppXHB/?=
 =?us-ascii?Q?nMGBpr2EdU5mIPz7FDjDL1pRHfUFQa9PoEPpjGniUijGJVrIm8jt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9e3e4f-a15a-4c51-eee5-08de8d08747c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 20:27:40.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Xue0SlakWC63TfNQ+rVhgV9CGi9XMp2rbCkkXRhI9lCqt8FjY1uYlaxLwgxWUFvvIYsOy8kLOlD0gUh3mT96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296

On Fri, Mar 27, 2026 at 12:01:29PM +0530, Shrikanth Hegde wrote:
> A few miscellanous changes in handling cpumask api's in the order
> they appear:
> 
> - cpumask_next(cpu, mask) >= nr_cpu_ids is used to determine if
>   cpu is the last CPU. 
> 
> - cpumask_next can take -1 as valid argument. So simplify cpuinfo
>   iterator. /proc/cpuinfo shows same info with patch.
> 
> - cpumask_weight can't be more than nr_cpu_ids. So remove the pointless
>   comparison.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 7 ++-----
>  arch/powerpc/sysdev/xive/common.c  | 7 +++----
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index b1761909c23f..47215eab296b 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -323,7 +323,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	seq_putc(m, '\n');
>  
>  	/* If this is the last cpu, print the summary */
> -	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
> +	if (cpu_id == cpumask_last(cpu_online_mask))
>  		show_cpuinfo_summary(m);
>  
>  	return 0;
> @@ -331,10 +331,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> -	if (*pos == 0)	/* just in case, cpu 0 is not the first */
> -		*pos = cpumask_first(cpu_online_mask);
> -	else
> -		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> +	*pos = cpumask_next(*pos - 1, cpu_online_mask);
>  	if ((*pos) < nr_cpu_ids)
>  		return (void *)(unsigned long)(*pos + 1);
>  	return NULL;
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index b6446abe29a6..91dd3b364d7d 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -548,11 +548,10 @@ static void xive_dec_target_count(int cpu)
>  static int xive_find_target_in_mask(const struct cpumask *mask,
>  				    unsigned int fuzz)
>  {
> -	int cpu, first, num, i;
> +	int cpu, first, i;
>  
> -	/* Pick up a starting point CPU in the mask based on  fuzz */
> -	num = min_t(int, cpumask_weight(mask), nr_cpu_ids);
> -	first = fuzz % num;
> +	/* Pick up a starting point CPU in the mask based on fuzz */
> +	first = fuzz % cpumask_weight(mask);

For this function I've got a deeper rework.

https://lore.kernel.org/all/20260319033647.881246-3-ynorov@nvidia.com/

For the rest:
Reviewed-by: Yury Norov <ynorov@nvidia.com>

>  
>  	/* Locate it */
>  	cpu = cpumask_first(mask);
> -- 
> 2.47.3

