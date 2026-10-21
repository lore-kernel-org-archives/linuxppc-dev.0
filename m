Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45E606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J3tkleFu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j91VC2z4pz2xH9;
	Thu, 22 Oct 2026 07:44:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792615459;
	cv=pass; b=gRb6GooInG8r+PXP4b2SZ2js+i4ymoeB95K1WY8AOe3DvFj+TfXAA+HBrlvhE+xNuDWLhUCWF/XtE6lSZJiBde8dARaw4Jsstglpys/xIxwlbGZW2fEBcIiI48QsKq0Rf+RqKmJBxb6Pi6g7zpnbn0I6bAWKpxhXfa3gLAlxyCgb4RTAdXFoMbiWK27Id8aJWPlbgrwfmlV6TqOHjM+xGLSNKWfrOX/UhzYDP2DLefuFq0kNZaaZxrA5y7HGYtfI17s3J991F6wjB/IErNKXOYjui0Nga/Ed0cdaZ9OyrVJ6DqHyYDOQxT/+2OZbCTldtfIv2PbyU1rAluEFUPxxNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792615459; c=relaxed/relaxed;
	bh=IBafTsMaKrnPdFDG4m2mW0OB5juuLYvt2UXcFHeIYPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHRMmHmaMzNVVQTifhBau4VeoKBIkJ3cenoeJZRGVNtcTvllaHIUmiyyBWoaMNQqmJZYxcia2+edw82EvBS3gPreQNAHGG3OQQqIosVZq+KAL5z2Vb7jLcf5mhkOhhqFvZ7yKYqeLsE9WJhflNm8rOvx0omUMuzwu0JXuTpgw/iYjDfGCXqA4K+GjI19WB/5fhRBFh/dcEgewVKeP4/foJ49K3PVFz5TxMn907XkUu70ZFOLk6AbQShR/1iqoosYB0Lpzsv8aVyyCupIhPF8l6H3FUolYLwMM9xJHlYopGFH2y3IC+11M5lmF9onHhimGNnXNCZWXMpUegJ2tOtS3g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J3tkleFu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J3tkleFu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j91VB1KBcz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 07:44:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCO4EykW/4S0Mh6MJjR9AChQY8RBkJirEyIdzBAEyFu4sJuR4Q1FfIvBLymhHWKK9h/2Z4nIZ3hvnLkUfa8hOZQxRePqugEnOX8+M/utzbvayWnYhilkaGGGjE09wzuOQ2Lugjv7mxm3UoGFeoeqkuSqg5hmda8kgSghW+sSlprE2Ng1pDL/D15roXImZ1ujMASH1dEbDf6hAI750eCQob+NiMatSNVB0Bnal1OUFmnMI8FqBs+0VTIRjWPRm+9Nkkna1n3TU1904mN2flvnI7MZnuQTt6B/pbuoaH7EIBJ99dsQwpC2GiW6xtjIUTjGaJJRPvTB/sRWLkJ9J9wNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBafTsMaKrnPdFDG4m2mW0OB5juuLYvt2UXcFHeIYPE=;
 b=MTziZx1mdYRkCjydee6Zb5iiGUY2oHpymxKUZ6DadLMqvdijCl7aVjA5NzcTTApR3X7Uvlotq7Qy2RJ+7Lk2Qz9QY9XPfJ4XGJ84yuhR5P+E8BDhsIGwBdmOAzF4TpQRGi4BMGc1ORa0jXmPDLfBSQUf03rNadBxm1E9QkcCZOIa4BTw5njxNrv4DzQf5HQa6qwgAlurtp9euxKht1r7fq8QoqKGHvztNF8Ob7aKGxKYe0QbtOYOi2t3Q4UiXf/GRLK7/YJV+r0EcySDvfjRN5jBI0fL9/smLvABF1psCJdtdBlkP1KgbWmJHpKQQIohvWFcCGLI+AQvMqBLP4ppYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBafTsMaKrnPdFDG4m2mW0OB5juuLYvt2UXcFHeIYPE=;
 b=J3tkleFuHjQqCDzNIQa7e4IjzcFqb0fxZ4WwdR10ScmzUw+/x5v7UWuFETRIwV+fcERkXOEWvnZ6xoPwNlAIuBjTwBAXOEacdGCxySY8fTj8cJfHCbEt6qEbE4qXWppyH0VFkESAemd16zuy2cqa5TJhM73LnocP5DIhqvTTX4Efewp35xoQU7UOABWYNjk3HRMP9dF0te9p7NscgUHmXYNKykSSq7hkA0cxJ35fecSN0gr/zQpaToTawYWxRuWFXCCNU+7FCTOnddSley+HJS+tSg6igg4LApCGY3hwtMpy3kUwQPrnxDtb/SeN/RPX+AGfMpuUV+ZUBMj56AnvDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 20:43:48 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 20:43:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org,
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Date: Wed, 21 Oct 2026 16:43:44 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <8C082879-C8F6-475D-9460-DF5E3CB629E4@nvidia.com>
In-Reply-To:
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
References:
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 2107c9c1-2894-4595-4d8c-08df2fb401fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lWgZJuW8Luv4UbklFmcCWS6C4R+aPtdlZnQ0jRrRaIusYP6ZtwCD3LOjNHWVI3GymaZ39TTDqzzGNTnqoEXhjXCTDZd3usm88xemeYRoi5iqXk/UEoBaRCLeKpNJDbRRmO/yeO3Jvp7tLheZ6au/A4a8PGkHBjYQmOPmwetYXt56MV0GK8hQVzJodCsQLjzZRnW02TnPjLU03jLaIBATZr7AoDttADVDI/UilEIJq95h0hWFu46iR8+mjJlcrve1b2/NR9ejGWcpnen2kbDzFbDPk586eP1clFIf7Mz0AXeE8s+G3rm0y8xR68Z+XoNf9ad+j68YYEZEEVl2GGL0IEkD+d/pnPlaa64ppS7cdC4bVfMijmEywNTr++BLGDW6wXxre6h9ICpWhTQNUARcs6fkJEnq1+RQIVOMIRUU1aQExCGJLfwg9wZ/xWlUH9UBJo5TyMMN6v1c0eEkAImuggnELN4Mkz5f1bi29FnHY40Ndv1ugxwTUTgiMwB9yOv+xm8RKZF9HKALrV72uC1iwzeyGdoLwhlDM5WpQw9+GMAAKUuogsZB5ffLylw40oG2dUQChFYa7F4pcVCga8pA5ldAF+4pXQoFF0LoPHCaCLpKr2dbd+SLCSmFRI8r8M8czPWBS5In8rnlDARTtq+F6znIl1uw0o5NTB0tXhDSy3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RyRauyaYq3cUmYhyTbPiaWRnTK4DvzDA6LfoMzn8OWOerVnJCiHnNfaQ7bgD?=
 =?us-ascii?Q?jH4IAnH8jCCfRAvLXI242sicwOj8/fvLYVpaR0RT5Tw0ufFBsB+j6wgI7OI2?=
 =?us-ascii?Q?jYvAdoeYNjouwxqh55ym6B3e+Cb+dSCF8H6OwIfdfv55l53JNF+3YhBbJ9RA?=
 =?us-ascii?Q?WG2ZtuVE10+345gKr3ZWLur4dey1IZOQeibVsJkVfkZNWicTP/jKAvFO9vBF?=
 =?us-ascii?Q?vvDqWW127TcBJrARpG+mbyrA5cbRPDqTwcrrUeKaiEpm8qbNQnneyELdxp2B?=
 =?us-ascii?Q?0sXNH/MoBqY3YQJfsYwTeiyNlZ1o9iwSQMaKrHXYh1jkCoH1ABoh2Y2le/qy?=
 =?us-ascii?Q?QGE54S24yHAYjLrkw645sMWcgd7jAfkMFpMyIu8HsaP1VYcLTF1LXOvHTZy1?=
 =?us-ascii?Q?nGnOaUAKpXJfMYiz1xnLF5sLFvUmYNnG0+tYHpKli/gVB1/1ZP48Hm/3z3kT?=
 =?us-ascii?Q?XcG57AMbgMghU4zUK+yxUqeg+Z/L6YEnaflAVJ4/Bx4Q2Q+kB7wfMvGJYCVO?=
 =?us-ascii?Q?lk4DbPkHGU3iP6CzDs7hubcIjZOlU6nWDa7ugUo5EouKSwabehVRe6W0KZqE?=
 =?us-ascii?Q?9ncGREbPQdu9GKKx/xuNKGYsMT2NXl5pIH6FNpWzkyI7/0jQl6TxxCKFuiKX?=
 =?us-ascii?Q?xkk0wGt5VKa6ydjnU8m1pO2QPJPl6Fvv+b/kSUQ3oY3k8kPjp8K/37GOzLNj?=
 =?us-ascii?Q?40RBxkTO2VKlNT+M+U9DCR3eqXSL5/e8BXMA8s1ibifkfjJNH3SVZYovgOS0?=
 =?us-ascii?Q?bMCqFU1iUeVCnpqkhXjaprKNI35sDL9EYQKIKzntPNri52ug/G1Ysnnht75+?=
 =?us-ascii?Q?sihyKkUuCugAU6o5rjwyxmvkTf+LlYcurhC2QaakRmY1S0+APlBHrVai/nSK?=
 =?us-ascii?Q?giWeYmUHDaq55uwFXUH0OgS6vd3WVf4pGe+EqO/dXJUVGkeDNGAW+NUy6oUA?=
 =?us-ascii?Q?8BZEl56Fxyj8froo3stIF2u4ELXe4peD1GQSvT641KM0QOKE+pT4dESjqST6?=
 =?us-ascii?Q?fF5cOyjTmhwBvd5CksUkuHfu/QU6YOeGmelz9V2E6T6W3CNQ9YHrQ1sO6+te?=
 =?us-ascii?Q?SVUDU1Lj6DHloLT2dh49Uc1eu1VzUdErfZ2TDOSw/Qz83LV8dL7BWWNiG8jp?=
 =?us-ascii?Q?tjLl6y6TYkDEVLQc21HwnUxVltH17s0yFmPjD1/zf1bdhDACictc6FWHNrH7?=
 =?us-ascii?Q?5HSMFwycpCKaV9HL4sv0OX2Q9v/+byguK3vohorsXm6CbqsmpcbuA4p8yhG8?=
 =?us-ascii?Q?QaKHPbAZbniApanMc3C0iJOPmXBLYNberlR5Xs3QGVX9Y1piDw21ALBB9jt2?=
 =?us-ascii?Q?UvsCMfMhQL9EMWBNpISBPklXKglK1K7bmmq9qpixjmNM/9nqub73fMalmn6f?=
 =?us-ascii?Q?qC6AkIrLt7z8ArA2RTgeEU2XW5Te4WAHyNirtVFBXTJATUCFSFtgXaiI7hZj?=
 =?us-ascii?Q?eIMxPf7x+4FIyV7i5RdJyx0FRZzwL0p6l/qEMYTzNOcSGl/+7oncy03/GIls?=
 =?us-ascii?Q?k8gzcZhEhQH3L3hCwgnOE0X/cnuqkevhYjA5CS3uX0wp04GAtB6pYEEsSrrS?=
 =?us-ascii?Q?lG+cSc4jrmq9F649SuDOwLpEPjmbKYNYcjqrS6621aVIig8JYdsQjDUNztsP?=
 =?us-ascii?Q?PpIHYBitUPMib9I1RDnr+IXw792Tb/liJ1ge+1oZ0NEwbDPDrJS9wVUMdN+B?=
 =?us-ascii?Q?QtIClHCuCcEpX/Gy6YRdyXrFpTFAlYf91WSfnnq5MMvQuWp6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2107c9c1-2894-4595-4d8c-08df2fb401fb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:43:48.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SJJ+lIpDshX+ZhMNynH1s0j+MRIHa+KRMIiS7mRPAWLORbt3VsS8lTLmIuRmBq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21 Oct 2026, at 16:36, Konstantin Khorenko wrote:

> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR=

> PTE mappings to the folio instead of one PMD mapping. Each unmap of the=



> PMD removes one PMD mapping:
>
> - the folio's mapcount never returns to zero, and removing the folio
>   from the page cache reports "Bad page cache", or hits a VM_BUG_ON
>   with CONFIG_DEBUG_VM;
> - the first unmap already counts as the last one and drops the
>   PMD-mapped statistics while the other mm still maps the folio;
> - the second one drives the entire mapcount below zero and drops them
>   again.

This chunk of text probably can go away, since no one is affected
by the code.

>
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
>
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_du=
p_file_rmap_[pte|ptes|pmd]()")
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  include/linux/rmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

The code change looks good to me. I also find this when I am working
on PG_folio. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

