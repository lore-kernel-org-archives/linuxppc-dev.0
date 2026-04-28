Return-Path: <linuxppc-dev+bounces-20245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6693FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 16:41:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4mRZ0t4Mz2xQD;
	Wed, 29 Apr 2026 02:41:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777394506;
	cv=pass; b=oulFQzdu5fDXzIJd2acgVCU4ZbwQKUcawNIxcOlmYUwISxpFDXSzxHLVYSCkSzLP/9E2B8BtWQ3iN+vpkdY4+rSfkNLX1U/tqOtZvFisd2lvUepl8A0MaOoArJfgvcR+iFJdlGUQawOVJZKZLzHbi/zxnDk7f924GXj/n+Och1tjdm+602tKLXrnkl3wMIW9ZVX3y3/WgBHXimJrXWktypsX510zIvjeBLE+pdPz1fBp3TdG4XK9kKJ1Trh2nr4Su4gGv2FrYspYvz3pmz2V1RBHkeuOoZimKMv0Hjbin4s7xaCC/XZ+yAcWTplum+azuNkCAljvS7TnQqo0j3vW1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777394506; c=relaxed/relaxed;
	bh=kYgXzHE2SiHUlWgo88524pqO5AUy9d9QfaH/oW+m+Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBREazM2y3xvNjw6sPYe25lp7B0eDhdDukH8AI0TAVS48/W1PooCCrJYdUf8BLBrrL+vqcbc5jPzHadLUtYA6q/iLs/PUJ0qWFS7/A+DKB+cQz25i6baLn2A9recduq/BnRP5mgUEb4kE9dxddDQVOfjaHA0ZN4fZoW5+OacIXoco6XGmJOXq3FNK/9Ei69Ajn5BIJA5U09I1T19DjbwFwcmunanaUlkkzttOSPZvONphQKVXNoTW0npOAKP83fC8xr6PHiGZz6bZBrehG+prDi/wJupLc2XLimM5rFcDJmqzrxJeZlWFLxS0w6HMaSGhJ7QdB+GgKZkkLoM/vdrrw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fw71wSM1; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fw71wSM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4mRX37hJz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 02:41:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2XXS5QXs9Qb/1KnY/9ETlH8LngDAMOIGlBtGhyIty5kg53oIfZEdwER8QWR4NV2wBTGawg9hPJm4N/HErN6Yf7B2F19FpmsvCzGOnx++ZSURP8Apgp0Zp2LkWgSXBjWx0AnT4JLI3b+XTsiJoZgjJ3y97+iuxAB7to8qhPnemUgvelktPREihcPUscVp7Y2yzqK+coX/aFuY/AS+Ym5rSGklvyenFslisnUGbKN/LsQDsYsQd2xzaqlDNcn7RjARsM3MFGJk1ynNMCb2SAF7Seh5sy+RyBHK6rUcRyhvk0haCzAz5ccNHDIWmcvkW8xnYWCAaoLICG0E7qVUJ+aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYgXzHE2SiHUlWgo88524pqO5AUy9d9QfaH/oW+m+Ps=;
 b=DEdappOcCVC+g5jgUIbmHzWFsCYYsboNlJ3srOf/J/WjOvub7y02h4kR5yED3vlcOhIdA1eqGE+Y3slG3sOCpi1Uj5oA5Oit/f8K8bfxMrQCSAZwv3UyqCGKf72jDqwncdE4c1ewp+GGMN7+bFk5sFipfkV2xOBs9+Xc1L2H+4/CzkqHu/wb0QDW8dOvIliJl7YRMsOcVNRT9bdCsCqq2JVaUeoEc44GsHrFK8o3LDjkWHZjkA2zwP6NzUL/Bb3uak1jBQsvCtiCWazBq/LyFJDM6IpwG5TCdRTToKy1U0sbjI8/O7TmweL90n/e1q+CuLXQvbsWhAMCNWeKxxdHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYgXzHE2SiHUlWgo88524pqO5AUy9d9QfaH/oW+m+Ps=;
 b=Fw71wSM1TKYo6GP8ludwhpV+JKc3vqvwdR8cysDmByQSNXV4gThMHbj6m5d+jC1tO2agtYUM98y6dZ2/vXTOqjnNp8Y5WSv3VXU/GLwMSDrs1W7cp92lW6a3dtGKdV3w3cDx7mpZs6cXRUFWpDHzVTjvYuIdUYD6SU0YrIt3QfEKbCYD6+0DgBIRkJJ8CuLB/r9/v8JB5Kz+oF1Ms5kr9NMFRUtAzr+8zk2PnagjODzrvQEigyhX495kdq0QcC8grXjch6QYg6uS3LJ9NPhRg1hfsi0YthG/vQWkfh2+cxN3P7ASKkd9rVvVe4Stao7ilFGwFVAH4Dnsr5doY5jODg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 16:41:18 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:41:17 +0000
Date: Tue, 28 Apr 2026 12:41:11 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org, chleroy@kernel.org
Subject: Re: [PATCH v2 0/4] powerpc: A few misc cpumask changes
Message-ID: <afDi32Ce_1HHjeTC@yury>
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
X-ClientProxiedBy: DM6PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:5:334::32) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a5e28f-7545-448c-f6d5-08dea544f84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BQx2NOpDydu+pwjL2OtGifdPd/WpUYFdTTvY7YxQ56VkskkFk5Za0YnylyTTaXjQphAUKhsyV4fRytIcmF2BUBm/4WamOVzCdQQke9AmpaMMlgmrJ72YhBYuZkwBAknKLPtoY+coxiFyMkosEuaqOaCtWBONWUpixfotsrBCJksE5DaPaoR5W9UshvlcDaQp1lrQ2PQ72wyS2qLCztjXPVE0EAfvA451SlqXJrnQ0gNmZDM72YB3BMSGhF5rN/WMdiqkbIQqdzz3PYiROcQePcyoTwZt005WoLuImLHw3EnQFqMLZgOKklzGRuTLBdnGHekU9toYu/rX2EciLpk7zTbQIXaZM5UHeA5LqZHVdl6q/xxz8npt2s+Kt0AiGGN/mqXIdcRBRg8d7d+vgti+yfobPGt6LxHQ94C0dBULS7KEXR1l5LRGeta4/ahtzqjoo7TahQHVnHNLBIEtRt+4RZF4BPofPrxkCM10IGp0l6iKFGb2UQQMM3sgMtJ6rDnMxSaqtMbiX403w+SHMa2z3qbfIdu7PcSKcm96Rn0NfFDCxJmMARl0zLNtrmx7Ai7Ocp9g/axS0BAdYYkT6aeDVEJOb/JDSeQPB+OM9IiZJDbi51JS9eN11cAjc/eja/TBflZGOQni85JeZjVoGTFOE3p7fRXq2fh2ILR/opNgejxYXMGOve7P6dxlLN3xVq+oHiv9Hv50U7WiuXBdnMzjFL2Mk3ib2fxcKtEHazVmBM0Xoe5CgGr0u3UCc0DGItNH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NumzZ9YtygvD0EtdJfC4LULJ731QM0LVwznGKpSeRIBYwVm874NPFqVcpt4m?=
 =?us-ascii?Q?bu4f7u2cYpgnb8tpgsOiR4sLtx/KxqIsPkX7WzcWGlnh+lY7IMWo5IWYYB1S?=
 =?us-ascii?Q?BW/oiWfPUNz0mx0pkORvOqu8MCgOj8fqLzioU2c7mbqamiutJnsvKXBiKdG9?=
 =?us-ascii?Q?alT8Lt3KbVZ21CyPG2WRKr3sTJN5y/PFtI9MmJakO6B+e9T4LaHHY34NPjin?=
 =?us-ascii?Q?+0GLStrF12kS4FX1VTIon/UkIpl/9pStCfO6q2HKBSUVf/gL2Jn/8BpskwwW?=
 =?us-ascii?Q?9PpDaEOsmw8UbCDKEV3CEvjPTa66u3CZCBUPiFoVLApyMkLRzi2F2fK9gpCO?=
 =?us-ascii?Q?XfeNTcfMFnc+Uum69dAC46pmu9XZfA803J3LX471iH7WDmNndPJy0zkcqys0?=
 =?us-ascii?Q?RbiQQ4gf61JWIN/dhSiDwYXP2z4sQlg2f33JJPfgbqwhL05JmbKP4+FI9M89?=
 =?us-ascii?Q?AJ9fTp5CC4BzeZkrZoqg2v1mRles22VeR2zr6JMfJeluAidkq9zuKwLfXdJC?=
 =?us-ascii?Q?zMm+9vRSfe2jNBGY32ZjJ+Duazt+0lOyobzIisi5Ccyl5PQTt7ngKqKQV6u1?=
 =?us-ascii?Q?W42AeProOrBRfMyC6qD4tosLnv2aXQ7SKFvNvLUhFdgIEsAW+61vNQ4lyE7g?=
 =?us-ascii?Q?mcrIxR0IM0Xpfwkg+LUmOzO0r66A2VKP2Lz4+1qvXQ2cCr8NKUeynTJAEpVp?=
 =?us-ascii?Q?ECih00AWfXizXAXQ9mTbC4BvRLIwuUtW8hdWzH+AcHRNa4S05LlRjTIYZPr9?=
 =?us-ascii?Q?Pb+Uym/zLt90XHZMZEYdsJTgVjYK68MIZJjtXzgp0N7RFXMYH66we3v6QIJk?=
 =?us-ascii?Q?Yy78sazW9MIRgRsSlqEjP1c8/1fT63aITfh1r24FljBwLA9FUTjTl0hdzZ95?=
 =?us-ascii?Q?SOF7wDHAsUJE07bqO+4NRSqz/DKk55DLKvMPuzOf1QyD/Mb1FSJsRGxfL0EO?=
 =?us-ascii?Q?hugxGLhQzXWyowu191DvQU4IXFGlmdQF6t6xiNhCtThShtI0OCbp5zcafjzm?=
 =?us-ascii?Q?e22BcBJG1V57Z5eOQJye8DCuxMhYl7BYnPsF/TtcOuT3e14REctNGizz7DpZ?=
 =?us-ascii?Q?UjwwRWpjQG8wj0T9rhd54iSii5s0iAO4SASonp8zfJZH8+cOAVM4KiCz++di?=
 =?us-ascii?Q?8Cy3lbS+GY/j1GiAV5TExAnMZFa1T5I01c/licAoSR9vS2tqDO5Dxj6ThWgK?=
 =?us-ascii?Q?XuWWHR7hpeyKLcCB8sjwfVxImd8z6HEdAjJNYey7d1PnP0kFK0/xFotVjEJD?=
 =?us-ascii?Q?zkQwTQ26z8W2WZSoXiBdzW6DG6/B8WE5xvB2sy0JdkSJb5+npFN2tDdXNyca?=
 =?us-ascii?Q?YdmSXEo3tQYwR6TpTxze/SfVeOkoyObHDlRI+X2hNF/VMAfV75CI5Ik9PaMH?=
 =?us-ascii?Q?68UVmh3uedh2zVVKKKrxzQvytKfS6b7rfa5VE6TS1Ry6+pU8AKcswIIRFz4W?=
 =?us-ascii?Q?TTamPxCnh17QeibNo4yn19/zoseKc4mBeA9/Ir1Lmsoc31b6J1p94Kz/RY9X?=
 =?us-ascii?Q?zlbBaN2kkrZx6mBJBDGCsGCYSr2OnriH8hJQBnGVuZ/+MqvrIXPoiBbdXmnv?=
 =?us-ascii?Q?rJJx95hBam3sQgB0IkE2WNG2ojBRks7NLRNb8bOsXExCFLBqa6CMaOXW8rOt?=
 =?us-ascii?Q?r79uf9lJPE44i9L/5rKcf2I3ou2sKP63+OT4DiCdRou70f0ZTbU+0xb+AbU3?=
 =?us-ascii?Q?Bday1aWkhZTd2B6NGaBBwltRHudYTUqnMmNdBO4LdNGBl2W5D+t63KKYvZ7L?=
 =?us-ascii?Q?5x5YQ8c/VRvaMwb+ypsFWBQSpIwle0M6K5intPEmSIAt5tYQhw8i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a5e28f-7545-448c-f6d5-08dea544f84c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:41:17.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMD8i3GN3VabSgBtQAsPO6kVbo6bxnwXIhPNlW6ajayPCePasaC8dRSRIRexEYEW2ruOYaeI2mMVSpiHDVDtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278

On Mon, Apr 27, 2026 at 10:17:11AM +0530, Shrikanth Hegde wrote:
> These are some miscellaneous code refactors around using cpumask
> APIs. They are mainly aimed at code simplification.

Reviewed-by: Yury Norov <ynorov@gmail.com>
 
> Changes since v1:
> - Dropped the changes done in xive_find_target_in_mask. Those changes are
>   done by Yury Norov already.
> - Collected the tags. Thanks to Yury Norov. 
> - Added new patch to use cpumask_intersects instead of using
>   temp_mask to achieve the same goal.
> - Added new patch to print the warning when target CPU not found
>   as discussed in [2]. This patch is kept separate since this adds
>   a new warning in case of failure. So one may perceive it as functional
>   change.
> 
> v1[1]: https://lore.kernel.org/all/20260327063129.127302-1-sshegde@linux.ibm.com/
> [2]:   https://lore.kernel.org/all/20260319033647.881246-1-ynorov@nvidia.com/
> 
> Based on tip/master at: (dffc5753ba4c "Merge branch into tip/master: 'timers/clocksource'")
> 
> Shrikanth Hegde (4):
>   powerpc: Use cpumask_next_wrap instead
>   powerpc: Simplify cpumask api usage for cpuinfo display
>   powerpc/perf: Use cpumask_intersects api for checking disable path
>   powerpc/xive: Add warning if target CPU not found
> 
>  arch/powerpc/kernel/irq.c             | 5 +----
>  arch/powerpc/kernel/setup-common.c    | 7 ++-----
>  arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
>  arch/powerpc/perf/imc-pmu.c           | 6 ++----
>  arch/powerpc/sysdev/xive/common.c     | 1 +
>  5 files changed, 7 insertions(+), 16 deletions(-)
> 
> -- 
> 2.47.3

