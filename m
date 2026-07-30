Return-Path: <linuxppc-dev+bounces-25138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16955C5516D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 21:05:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB1vF3sdsz2yYd;
	Fri, 31 Jul 2026 07:05:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785445545;
	cv=pass; b=MwbpEo6G5rf/AM4R1wMS+Y/+eKsyzjNc+fPovgJRe1bAvbNU8tGPKCG38lOptF2c0s22BU5fvyxYMO57qAk9bjdXXUgBGtzKj33Dl9ycIif4GAVyKS8UbhNAKv4zfjvrNO2u4zBS1bmMawpIM7VqzgvYBcbge0Mzum13r4P9INTOHJ/5cCUMqmxk9s2l70siLXu5oZFGXiHnUdvOCEJ6PZRg3bGEM5Gi33PbY7r5ivCAMHW51yeZjyC2JZk2mP+Aa1xc8V2L0cH+ag0W3vVTErA7bpqftTW/sELRD2jUgA2dZ9lO5HfpBIPYQNbA0S8gD4v+og0eaHxzm/1+iav82A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785445545; c=relaxed/relaxed;
	bh=fP/tawnqcMvDolJUYihmY0R6sPFMX1yqtxwSlIbOMYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1yc8cvC4p0bLFg3kkAVCRmgWBU/zjm6+GNeMggTvTAVADCnMFO4EY6DQrxV9L5eWw/gf0MWVkzMlDdY5NjtSNBTnW790+VKBhqULpdirTJPLhUyOBs4+tS6jnTW4LbjbawWiS+HEjGdZdCnepiTj7oiIvxP7YGVSbSq2rzROquXjuUa1AMeV+dN+63RdkmaAeKsvvYgnqHW1Q81BxnIZKLVOC1OlUtz8g5TmtlkPPI0pxOVncL36mpL+8HebIk9u2fqEtjOVqgRNaaehUbeIhZS6gx5t5rH1DLt9ng2pS+kESP7awYJs3mspx+sIq0vwdt8rG3s7VaBTMzpLz/2Eg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bJ01/SLX; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bJ01/SLX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB1v93BjGz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 07:05:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3oQ68r/UK4get82mM0qewRqa1cwFdIYh21c7TvP9RJVfpn2oIlEwxU1aG5tUY8wSqJUQiFhxY7Okka82TL9CuyqgVY6CyZsNh8P3whVMlyfHwwzu1zbcmgSDyJe9hHCcnTOYXQL6go367TFYXI4HUXM8tsFrcRJs/WLJDTrSYVWX+7wwNDOFlFMXo49zDK9QaKv149Qy7PBbllogulk3kiMzWd6fzEktDB7DoUHPJErDgnHgA6/mLbYigocQzEzHDgjWs6Sl59ADr55hWL6WpxmwXliUuvM6XTm4S2NUQPxud9OVw2H+gpMZIUANPRZVGWOSncTkUZhNiB4oX+LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP/tawnqcMvDolJUYihmY0R6sPFMX1yqtxwSlIbOMYk=;
 b=eSov1BY3R38ELJd54jXwt2S2VvqmQWsdtC4A1Y3KDmPBqYrgPpKCNlsvwJ0Kh/GLwOSQeVZ6CmodBmPRr776DApl+T2SztakHPNYNyKXaoyX+H1kZJ055R2RX/iPViRcLIzSK6LTZhwJq0qFtfA2Df09NZ/c1h74Tgcn5SSvQ5rfA0NhgUDHnIP4ZWchPn0g4NrMwX4CbMVHnuXhPcXw7xJHcXa9FTFrsVqHojZwFaDbxCb4tagWxJ0ECbajRLuR65t7/qBKooSlxcQpa1GDWp5gYTvAAepV/9usRd0K26jEaVzCYcEwKuj7eZ6YI01wQhgdPtgaOncTQJgIomL+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP/tawnqcMvDolJUYihmY0R6sPFMX1yqtxwSlIbOMYk=;
 b=bJ01/SLX70pYDcmisUzjreWNai1ECOcg7yJTyqGFax8i0pDO+PXEvwVQagy58qRagberdI2pk1dI7oiKuGthBu+h1kAnjyiOIg2xpHxwDvtBZg5aCcDn3F/0pIO+nOqlcKwPy9XrNZ9S/csiAtiRleAk4AXEjoNmCviqgOlJIawH2dfj/kpFnDqZFh6tw5hgDJBW69M0i56b4543J4f0EhqBYF+JKvTEBZJCxo8zKJ8aSYuSFN4Fl9rbsEobp5/InKB0syEDg5Ctqn3zchYGHYTp4RqjtaI1lP1AXrk+ANPT+qcQmPyUfcRbyaFoMjAzW//NOqwNiASwWXhYVm06jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:05:16 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 21:05:16 +0000
Date: Thu, 30 Jul 2026 18:05:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 15/23] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
Message-ID: <amu8iiOBR5YspzfI@nvidia.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-16-aneesh.kumar@kernel.org>
 <ami9CIGanuQX3lxb@google.com>
 <yq5a33x2go23.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a33x2go23.fsf@kernel.org>
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 81eb01ee-6a22-4efa-7e32-08deee7e410d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|56012099006|4143699003|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bEie4YF39BMPCD+6svrPbTaL0BaSqYGoBP8SC80KeANY60rbIdEIn4TYM9KnIDG3y/y8i6P9WGOGzeC8aZgWmQ2jk0UVPqJzjkYomUXzBrSzihqrBmwHtyBmzOR+72esWxWAoyfCmw6vz5BUwganjpTTf3Tm5G4+dfBCdVDKPSoZ4g1H1uNZAWhIyR4T5t4YQRnOJYXzigylOTr1aRuYTn6E/pIPjyb74Uc7HLdAXW9ewRqTS+8tAdOKIJSKfATmFMNcZXy5hJIAIZ+2FWiDsVFH4AI6vlZQY9ky0kWlaUePjZih2+JriZzNedClHNLOQzaGXqa2d8iDbJTTuoSg3z2rL/PajG7xawIz1RFQwddyL1iPFHV/zF7CxPql32n0ct54X8zRJkQiCbHciMJ87EVwjz66wRIc+suPC0L7jldwP3MkHQs+oKsCTw7LOAktV5rmO2UQHAPn3ad7qbBWrDm0YZxbI+r9V60ayThK97EM0uYpS2ZxHLlwLRliJQkY3SYOMm00IFQctmZj/Jckf4BXMln8u8p4XpctiaOJ6Kp3SF7jeJ2VEq0CU9alNQ9rCM7UEfDbo63FyBDWxk2RmohlFmXS8zN0HAuKRMbmFwAUgiXiWJlV/93hSaNXwjhSeyzx10vy3IRP5guybYPVMu89YXHfDOKyB4uxsJ46sNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgcwd4SPDJiAMmLE5rq7qpg5+zS3l8ygwKzLXcb03srwU62dhbRWmvKv+cYz?=
 =?us-ascii?Q?nCM712X4wFSu6KCvXptVtKR3mVjwfYn6YWSo72P5Jowz+d1RlLZHP2ulo+lK?=
 =?us-ascii?Q?IVwPPJ1L/8blxas0Lh0XfVkF1pvKt0fXtc092PXw9UTDmUo4BO97hPmvEJaj?=
 =?us-ascii?Q?Wy92us4SFglw4kTgFkbBsAZUMl06MHhyXRMMMX5AQWtVvuyuxKPQahEWPby1?=
 =?us-ascii?Q?j7Lgyx5fIkBc28WjvgI+IWCBs+oIjXCLpKmZJjt6qjCBWfmc2ttvbTqofQFr?=
 =?us-ascii?Q?rGUfrRuCAR3WCRtHifGGxEnnDyfyXqf/EL1V10Gx+0aDA5qL23KHdchKtd9j?=
 =?us-ascii?Q?/30O3+QtttnUu3f827kCvNfyJsmuFZg2AbaO3NWyEEIEfFCvg7DAYe5rtOr+?=
 =?us-ascii?Q?GIeQ320yVrVJMy3GnQzUljqaiQEzi9yXwrYDqWPjluRR8ZTBuxCVpJcWY8M1?=
 =?us-ascii?Q?Lo8iZEOi6IbuO1ZjUNLdnYc19Vc1UFltOrDtq4NhRNBQ8o9s+6PvNwBaeEaW?=
 =?us-ascii?Q?AY5guiysCoA8oTMqrv1T3m+Gwb+guy1D9iYEoHTfsq2Be3K46kTq/0JZWMk8?=
 =?us-ascii?Q?BsXq4KfaPSqRTthHyonTbGPCOfoWrWkuDJmLf9aji/cO9P2ZmkxlNM0JK5JL?=
 =?us-ascii?Q?BByq2BobzK+eZaCRwiu+OXm+nISmKKIgaVQQBOZsTO0NozvrjB5o4ajoZSPk?=
 =?us-ascii?Q?cBOs8uQOlqQVKFssl3qwvNXzEvxZSYlmVRUh2H6E77/cC5qZruR/LG6vo+NP?=
 =?us-ascii?Q?jmv0z4aqspgM0XsRNqw2a448bbf+oqReUzzdLcseCyztEqM4UW+ixIVrs/sS?=
 =?us-ascii?Q?4q/qzcO0DHIE6+5TFkA9YN9kam7dx7bM7eouGDRuTanLga4umoR6RcjaG8EN?=
 =?us-ascii?Q?74dFJvi56pGNIUNASrw5Q5kiK3szFqDca6yNcAifT08oO7QWl9awGNp5GY6L?=
 =?us-ascii?Q?Kn7k+SNHnJFE6vPiG5gcvQQZTTilNlfmfWQOvt/ZOUGnT/bKnderBIPLxXrx?=
 =?us-ascii?Q?tTe8OnNvFNXN5UGmUrQUHX/nvdEzaKVflreg9RCQG/T4tiVFm3JmIS1OtmwX?=
 =?us-ascii?Q?iWb0hMT8eygyVdYWu/uJARJ6k33qPBjpHjexhHFvlAZiCxi7Qq+F+bEhjTRu?=
 =?us-ascii?Q?BB2ErkIUCtKkfvU01Agt4nW6jL/tbIAa0RJz/3olzSSBOdIQ1xZez9M1TfUw?=
 =?us-ascii?Q?KdUeH46NKc8l+kyA4GBPWY/yGlwEDTXRPxOz7FAfl37pzgxln4lp9N0Jx79D?=
 =?us-ascii?Q?UYA6tLCI9c6TIkQB7FrPAAhq+phSGfd+aXVjt1OWR+iEt3ZnpMSPNnylDLp5?=
 =?us-ascii?Q?xKuq9e0PDcsOjbk2zCpV2r28uxPyXyyxEoN74ZvAyGsaYPXaVvOYkQN+JVKN?=
 =?us-ascii?Q?pb0mp7VfAgJnOZ7e00U7h6FnhdkCm8kqegudB14tNjxrWI6bB2RNuz+ITaRk?=
 =?us-ascii?Q?CSJZ2xDXM/VbVvEsPNR1h91yxVqap3DB79nj6zPYYsZCwLwz2FXkuKwCsM0L?=
 =?us-ascii?Q?CdzKEpoOtKsB1WFdo4RZZJPZ8m7n0690sxp7VZEEXHFIJFx54HYE9XTP/Gl8?=
 =?us-ascii?Q?q4vxT6HmBnNexunKSFyFv8/hH5/pg8VfaREBLvfEGv13CD1+7p8AX8Sdz1ak?=
 =?us-ascii?Q?WfcxkQ8jAzvdL6JoTzMYl3WrxPURPk3xQSZllUggMN+gypCg0EDrafBWZHTQ?=
 =?us-ascii?Q?Q31i40V87qIlanqJDeK9S1tdoIgyxtmUbf096axJKLy/hOaX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eb01ee-6a22-4efa-7e32-08deee7e410d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:05:15.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TgSSlFZ+GG5NyHGxa4z9KuvQ+BdXqxoFl130lSXeL4MBISZOAOdTE3DePxVAkOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On Wed, Jul 29, 2026 at 02:39:08PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> >>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
> >> -		bool is_ram)
> >> +		bool is_ram, unsigned long attrs)
> >>  {
> >>  	dma_addr_t end = addr + size - 1;
> >>  
> >>  	if (addr == DMA_MAPPING_ERROR)
> >>  		return false;
> >> +	/*
> >> +	 * The DMA address was derived from encrypted RAM, but this device
> >> +	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
> >> +	 * so the caller can fall back to a suitable SWIOTLB pool.
> >> +	 */
> >> +	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> >> +		return false;
> >> +
> >
> > I guess it does not make sense to check the other way? I'd be worried if
> > some a confidential device uses shared memory which might leak info.
> >
> 
> From the perspective of the dma_capable() check, this should be allowed;
> that is, a trusted device is permitted to access shared memory.

Right, we have use cases that require confidential devices to use
shared memory we cannot block it at the DMA layer.

It would be a reasonable DMA debugging to block shared memory without
the DMA ATTR CC SHARED.

Jason

