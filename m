Return-Path: <linuxppc-dev+bounces-19443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93BBFEEF49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpkb2YMSz2yZ3;
	Wed, 08 Apr 2026 00:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572791;
	cv=pass; b=DtDLztZIw8xGrT+khD2gb4BSdxK+/TRa90zKNenoFhhdzN2xpKh/LIyorwFC9QbtKGdKmzjpF1tVjxcrIjIeVZh6HSDTjsQZ5DvB5IXp4kmQqIBjmMqLZmuxWkcOpiYgZtbNU7oH5DhiLJoL944vz66n3D9zXGfJ9UmI2hACI8MNzkGCcyRCejocak7HqBU2kjmVBupW1Oi8Do4ACu+8QUZRmxtqTTFPxj67tkrO2kh/GBt4m2jd1tHvzec5Eq2cblVUN+FwejOJwVORNY2l0o1XmKbCN45K0hP8+9zYs5Xu18w0S2YJ4Ntmk2mb+I3VjMsj6ZRFNTzHrEQEUeBgjg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572791; c=relaxed/relaxed;
	bh=ep7XrGFkSSwAm3joBDycHvYbHpXjybtbHQjlrPzNbT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1pR+wrLok79yaP5YSLhQgN5LLDmd+hZPQfxUgqtGSgpAEc1bjcOSipZxTMp1lRtfeHAi1Gsm/gAeNUnAvtChOUu4u7eHYXFbpYpQ6HU/e7gDJOH6dWNyFFe2BMnffUrWsEoXO22+OzQACHj2/pzGPpA3/UxtIih6hTx3x1tTJRk9LxKCswroIHCdxei9Tgz/LT1ttRCLPG+uY7n0gyi63mesbiIrXZHdGIA7y9RiM2mMI2NL8wXnIARh1ltSL1YfzQ7vtsTHwQCMHiAhomYfVre4+KKftehvjhKSr33zV/TH7EZHZabv5Ms0WlrfGc363tUgjjPGLmpGCJc6rxKPA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BRSJiHu7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BRSJiHu7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpkZ5Lltz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:39:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BELobtBkyWf/75ss3VbnIVKoezHR/Noi1RsLfeD1oiylLMxB9dHFyryKKnSXCjSU7UIZs/0OgVc8jaWQBHcK7rPEzitIhYjgyiVc97+nCnXHKlSJH6oR7Jycw6ES0dlmgwTusS3L7Nf6wtbEUqM4zgqJnggttjy+lic5N3PybF+9YmxSMgyHCeMwoigaRA2Eu1B/ByvFQ+YPBVHGTzATSyidP1osb9HTPIMLTW5WGGifSrI57em+vJTxWimtG+NAO+S7qHtSHbO6OpDsTijZwDqAWwzt0p+rC/MS/qp2SJmJV+0dcAoRGhZD4nA2BQEvd2Solz920AJIXH1xiSRRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep7XrGFkSSwAm3joBDycHvYbHpXjybtbHQjlrPzNbT8=;
 b=UrfD3BaHABjT2GNWE9VnD0ulhWVSsOG+S7yUlAMLejl62/1pYxA44ceC75GnsIWxHWkX5CtUtI8804H9ZRP8panjpMz0tfXlN5p1n13bUF1Q6Q7/czn0ClaH0n4D6fKGse+28Bsk7vQvEhOaNwFGMtvxX82XVnSHLDxnQ/jyLGPvlh4kj/bebwfzqQxgnJIPDnQNuH9YxzqioRF51fLKy+Eb/kBRHxfkPe+1Zo2fsgd/5EpSoWCAqhoqbeUH6gX0KypSmxjU1lkF670ab3Nh1xtbSlgWCSklpfIOceL7njZjUpko0/AqegHnGTfXyGKJkvmC0W8Y2tiqyHR4lNz/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep7XrGFkSSwAm3joBDycHvYbHpXjybtbHQjlrPzNbT8=;
 b=BRSJiHu7WiN1FDXSLxT2kyoF0XcsS+zGrd8+9luINBy2Vp6LU3Od9WYgAFe8aFoQWOS8LE/ThFfJ7quRxEc2t6OtfamOl796R6QiSaezTqLhzs8yowIrDJqVgEqUbflkJs0LFzSyKx8VLz34+IDsDTnH6yUPw9W0gi9PRoxYDm91sly5xdFdO0Ow6sRUawbRjriXXA3qDLFIjxL/7WODVCN2IOAkx21hwH4RNTOBTTFr7w6sGaTe/lbKFuQce207cUYdnugFxTiAbJlOiVUwN3+9weP0e1EobmGmxcCehmoJwspsE7cg08+ntDstHEuogr3ztX1r0E1a6iZfg3wn3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 14:39:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 14:39:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Miaohe Lin <linmiaohe@huawei.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 03/15] selftests/mm: restore default nr_hugepages value
 via EXIT trap in hugetlb_reparenting_test.sh
Date: Tue, 07 Apr 2026 10:39:23 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <001A7094-E5F3-4AAD-B2C7-B68FD675DEC4@nvidia.com>
In-Reply-To: <e148e4232d4b802795751a7766fcce8884c6e3c7.1775466329.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
 <e148e4232d4b802795751a7766fcce8884c6e3c7.1775466329.git.sayalip@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0394.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 7538971d-4d65-4284-edac-08de94b37780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2/+fGqVtWgPyEIshyQcPjlIwzLFDzTrEqm9BmwI4PybgHsIxdw5fwi+mbUz7rxRnpFoJyAVX68/lhn1OmWmzm6Wh6G4ae8sMJIw07invFXWXmenuh0QjRDpDIv8Jmya/zfC9pm2/UpvSnlYzWsPVIR4drgiaJWslum2fgAfPqe+Ve1MayRe4IFF4GBXgPRW03ZuSksXpuqC89X86l6T+ACxpJU3qjiypEg/gB1zz4aZrEPW3ZXdXFJNW41el324YkJJD8JGdAdXCB8IZUKiXfsgYzUh41bL+E5jclrxzQgFTLuR64JC4CA3O51PZyAVD/Wd5t9uEwUy9pnuLFcp6KTGXPYuVINgsR5pxWoP19nCIpdU8fGHlmDqt7uzO7h/pidC1YjIApZtou2BAdM6DMzRToQ+EIjbKirFOXUF3LJ2VxBun4A4VZaZZCdRmtszBmhdvJJ5Wu2zoD3/PmJ73ZfyISrVNR1PJAsp1asP7XdkacheRZX2BA7CNTMKSGvNRtj13O6SIocs3ITR3RMmbl4R/k+V8lt0BN6p/KuxDP9C6H0fmOjotVw8dOObLr6BNdctZYqZTmJqloc4AcZ2nOKX/UvULxZFWIpwcfiPx940TycEV5muSqa3hB0f8tvcUHO+uZ9Qo1+UMNMvM3Eb+23A68+NrGNMBb5RV0TXMwBLSa9fhxj7EFIjInXyqVSBoaxNPk0Pi6GMZlXyBNvESIIHuxfWiN3nKZG0iv5/vcKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2dGF9c3qylPS/UazGMMRW8uJ1sphHuoqtb+F/fo+MEswMezmyfdcKzzjkN8?=
 =?us-ascii?Q?vQRr70dnqaxOmP+e04YP6QY6xd/aOqM/Pk7F77nNF8aVCGoIG16hGfXNIsNr?=
 =?us-ascii?Q?F9iguR9PcX9Rj4UmjxOmTB5x3GXMQOknNf65Q64RQIZW54NWTQ1dtA5GzCjF?=
 =?us-ascii?Q?bub+e4/zLndaMockfADa8GIRaZblK/UtE+466lumb/iclgxLSZlyJAs5Ny3j?=
 =?us-ascii?Q?3HohaHLprxmci9eZVzT3E9CxpDFKF3xl3p8F951d7cYvunHnNDLCNSl6paE7?=
 =?us-ascii?Q?LH/dBTATClUdUMso0+scpvo+7t5Mco7TAOiV+MUsu4Da7XLMI3quRJqTOW1G?=
 =?us-ascii?Q?r7bCtionaRG/ejSTWSlGgOnukfbFZAL8dJjlhf5xUnI151O/0sK21KZRTjQU?=
 =?us-ascii?Q?rzPGlO5uO762MNv7z/+MxKh/huFKemiOh4X7eLpRD5CF74TQDt6h+N2cFP+W?=
 =?us-ascii?Q?WhFV6BU8vIdexuy6AsdephN551IkDJIEVQZU+N098aY6Yf6htonCw/yMy4XR?=
 =?us-ascii?Q?KOgkxde0KsXij2NpJoPZ+2CxeTiio9n9B7baEEnuTyhMnFQHiBOuFIdqQuiC?=
 =?us-ascii?Q?+n9D1thtlIAJTaYeSAkDBIBBKg4DBg1yW5HDBJUyAXrdqf5RxkqTdisQ3yEb?=
 =?us-ascii?Q?Lh33gkRgyfuuvnNWxtoQcmdfayrqnuwqdHpOoLqHKMqZU4XKG9AcO98PvO83?=
 =?us-ascii?Q?npaSqGfxj+ZJtnm6GjWh3vmeP/2tthUzs0bINITu0LdgXJr95UPeOz1kJ3xE?=
 =?us-ascii?Q?dxgtjbA5Ub3834+0e+zzXstjpouo/DofzcTDtDU1lCIxrjnsOk19citG5+nf?=
 =?us-ascii?Q?g81yxVHzpFe9Q4jksptj2GNqecaDZkSYAbeDJy5SVTjfUbEL4AJKmlZSqyKE?=
 =?us-ascii?Q?ScsWQaQxBbutU8tZAqTG/rWIJk4w4Z0nl+USy0gD2HZ1PEUGzRCaJt6wWoUj?=
 =?us-ascii?Q?+YxXEFklIJa1jpXz3VLEVCdJBwC6662/LGdZwFVsFoOrSd4kSBXwk1E4MtWn?=
 =?us-ascii?Q?XXUS/OevfxmaAD76gpFYPMNMb3ZNaXtwdSOkvy0r7ncTLASH/O47vIgGa+g/?=
 =?us-ascii?Q?dSkW+TgeL8YtM1zZmA9I5W6Y5igJ8ROxT6soFbubX7X3xrP1xNPsJFICy6gd?=
 =?us-ascii?Q?uPdfeM2eSTYkm5xDB/INxbgrXq0DMi0de/CTAT6D1CwQwYhNgu7nStf4a3Mw?=
 =?us-ascii?Q?nCp642Tke6K0eQafyTzKp7gFAA9eBRp46IkIhFLNklHgkHrbF+/EvayTxV32?=
 =?us-ascii?Q?vsDBfR9Q8uwhAgQDbHOkrMtVgX2EZjhHS2DH6jOfkjdRBBD7UyCToaquWGXx?=
 =?us-ascii?Q?z5UwNuV1GySZyIYj1YQJMTcTBNUzQ0JyqOUCL/zwtCidq9RW2e81Mp6nsTqG?=
 =?us-ascii?Q?I0/14dR+BL9n7qGXmbhDlona2DfA+z/7n2ZzwaxbK4mHlisOSx7eCZyHamiv?=
 =?us-ascii?Q?GBHscUMu7tFTiQpKAYyaM56OsCrhPk12dXJOdx2X+rotO7jMzp8hO+4AhETp?=
 =?us-ascii?Q?lPuRUfOkFj//QSGigtjE7lRD1dA2104kfXfStNkrkIsMGpeEB7bGUifl+IJi?=
 =?us-ascii?Q?XT7dvjxlggbL0Q+1vFrTplD2nC+pHWwofW4RCiKEmewQOooOtOTxgBumXhkg?=
 =?us-ascii?Q?XwBtUyR973f26iO5/agNE2k8jW6uLGOitQL45KHzXrHZEdvo8kcEus0BRIWK?=
 =?us-ascii?Q?yUD2zj6Sf3OLPGFkwfYW/rBELqtJf339ZuMKKfmeZuXkCc/k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7538971d-4d65-4284-edac-08de94b37780
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:39:25.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWqhgkPp1ISa13V/lznrsQ6hHlPbj8GcpGpYoCglD6F12hYtIbSCpQVjZWygbzHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

On 6 Apr 2026, at 5:19, Sayali Patil wrote:

> The test modifies nr_hugepages during execution and restores it from
> cleanup() and again reconfigure it setup, which is invoked multiple
> times across test flow. This can lead to repeated
> allocation/freeing of hugepages.
>
> With set -e, failures in cleanup (e.g., rmdir/umount) can also
> cause early exit before restoring the original value at the end.
>
> Move restoration to a single EXIT trap so the original value is
> restored reliably on all exit paths while avoiding repeated churn.
>
> Fixes: 585a9145886a ("selftests/mm: restore default nr_hugepages value =
during cleanup in hugetlb_reparenting_test.sh")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

