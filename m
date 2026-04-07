Return-Path: <linuxppc-dev+bounces-19442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373ADFEEF49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:38:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpjX6Gh2z2yZ3;
	Wed, 08 Apr 2026 00:38:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572736;
	cv=pass; b=S+gecIdy+opRpYUAQLGoxShn0q4GlwzqTLV54wHGBRvw7QhViZJ8RkgnC8ROVFanxkqH3fCWR7MrS7I5xp1bOVVqEjuzdUpxUlbF5qVjY3Z7kbyhCU6FztRjq3cwsaqX+bE1ky7U+SEo7QyloCvVC5FPL5IwiUVmSgalWPX8LqOEwmflN8Uh0eDAFAoUj27eQcMsA7syvmj/fOjj3MNb/xdBPo9gfuDAKcpjWDdVt/kwowrl8lSfCVo9tR8mFlUkba+MO2TsBznbofYe3JiJDi5xTcdELaokBbIxodqM1T+xCpSQorG9eTgdBhfu0cE9KJJZhGZ3m9hh9Lm6/dUyBw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572736; c=relaxed/relaxed;
	bh=MXtb8TmgIeZIhWzztiRTjlQ+qZS0IJ8tknx1GzcSouk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YpsH2FJ+qVNPkqKsSS3F3GaZ27zdlFqBtnhch6FWAosnIIiYw/Atew0pK83vDIuLtTe3GBLlcQYFzKhYTEd3AXCToBxz7h8WjmdTQl1OkyAjbBQ95YkY8gRIUEgbafCDjtSR9LUDdDMbKAoG0uLNClfiLUzhwHnLbs5KcSQznbtgNN6RnMvnkOJWdn02Ce479xALqULx9eHvrSw3jkcwECZS5E/UVmLAsd0BGGBMNRHtmAuMgrFpVi8k8ikDTETH5x9WOIsIp8lSR4si0GH03MKIor+ILuspeNitCHnsUhISIAj9atICxeXIt90o4FHNPTyxKOacPFheDEGsI4hEJw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q+mA41HE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q+mA41HE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpjW2Ylmz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:38:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLGEfKZ6H4MzZZMFVE+JtL89wpto7kWw9uYU8KVVB3CSI0Gr86tl3lOM0war4khmfdNjWrZvDq331WFWqjlodLpH++YXxalyPGmcN2ZrzhpXMpP8W1DduVXPi8RXPh8wUMD7FsPJNTq7XB9XcUAje/WJthKvS6T7lxQ8lXGWxOuydlPX/I4tD4magtOjoL95xhb5W8pzr2MRAOWG5JZb7QWXlhMKksv7HiMxghlAACADlL42BvGQIZF1uG8NTO64d3W7n/OcjTdXXSQNzoxDNL3O+l5iehm+YSQHyEP+sthGxxHxyDzWUnpWVvFTCWxNK6tKr53dEfnWlu12+xAu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXtb8TmgIeZIhWzztiRTjlQ+qZS0IJ8tknx1GzcSouk=;
 b=OxEoblBmh9v+Wn6qYzHO/Q7cQAmdF2EAgzzWNGABN6/XL1iQXv0+LYrkNZC2zi/VngW5T4pDrCjo/fDD5U8fl2FpM+O0y3y6WjaYIP541sP2eMKBwDhnu1S09ur5U3uxsmlFSxJf0IFqJAqA2uzpMKENEr0J5OfROB5YbB0EHj0f/c8DCL4UkCjGHfzpAvO6zB0tb/N3t5d4GAFI3wh3x1AfB3nYvrCjFQQgv9luDNbzNedwFjKpcFgwANItVCboPp2jMVNYG9RQ0iTkCUFOeIUXXrikS53PWhfsRTYR+x6AP1CbDQPO0F2Eg+bFc/090e734ymLv4o4l+Q+OVcUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXtb8TmgIeZIhWzztiRTjlQ+qZS0IJ8tknx1GzcSouk=;
 b=q+mA41HE1AswFjfMit4qEAqfJMlXS4spyCz8KZwQJFXG1SUkUIQFzsHEI2STek+nuhJObmjUyKktJTXQJMWl90WKHqfnpZe6nRYQ00WJoS0gx/npYvgjzKvs7iL3Ax09Sw7xgXN5omGRX2ujo1lEXVHlRET8HIeK8w431q68UMPOgs+98ygldzplsq1tjQDnGm5n9YJxLBQXntTGobUNaMmV5wTKM2TrhauRc3EIAQRmps97vtBvOaelGaEgWxMl6C2tfUoD+yboYIftoT0am1uczbS4pHK2RtJjHhth4EevCDX8sZ1Qi3/Etul2DWTNH7z7wQmob5A8vbsvBwwG1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 14:38:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 14:38:22 +0000
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
Subject: Re: [PATCH v4 01/15] selftests/mm: restore default nr_hugepages value
 via EXIT trap in charge_reserved_hugetlb.sh
Date: Tue, 07 Apr 2026 10:38:19 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <EC8CD487-36EC-48FD-9F70-37E001F8A8AD@nvidia.com>
In-Reply-To: <8beb895ae46c3e817e80cdd5386933cdcf8e233f.1775466329.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
 <8beb895ae46c3e817e80cdd5386933cdcf8e233f.1775466329.git.sayalip@linux.ibm.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::29) To DS7PR12MB9473.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8017968a-f553-4e57-51fd-08de94b351aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i7cL1j0kSCHmby3G9+AhSGf1j8B106E4PDD1P96ZN7a5x7mJYVwfHqeO39+WsG3XX7WLgAGlBt5SGKqQF12zc4LdvW+aB9h02uIm1teVg5iGOeh3nalaVBpE4Gd998csrH9x0HHs4AvahACK26ltdZQfRQJEsVBg/a8NZQF4/uTQ4fBlH9nQuvYrKXwofaxzSDJ4qt3E8bU3TT4gKieUbDMBvGuTVE1mt6D++U1CSXkHD2BFFTA7d3IMGCoQUlIU+BFryzHofGGV3OcTxRtshybVzj+ClqbPx0t68qPmYR2i8qEihppuuVmjI9ENot8OyqNiQRUGVLl2cWnPpjIW5pm++g2ysSZs6SG4qTXaPzVVeT6bod8FNvTsBF8mjAN+Yj54mPq0rJMhmdwwlLgHydEdjUwLj+Bz8KR3hKSwNGWm2Nz0lsjmkr+KgEYcmeyaq9UnLlDN/WJrQvn/I/zfZQ/NmwCSdQOqJcGzvgcDJP9J+ECEIqIbOxRni101vctdhZ0CskuS9F1eD+mGZ2sU/QDjnGw03856vHVc1WPFS/Uji0qBsDuifwItw/XEW8PG08DOO0kfhS/OfVbCoRYYHD9eZ2zGHs6VKTRFXYBc8WTSb18BRCwxLvYPY72YwTt2RvzkqSZ5H9II7FAIYfU5W2W36nn8OLkhhU64qlxRqUbXMkTyyOMOp+3kEZrCeaxz+pIbFwlndC61siDU2MIMvYCXfnOqC1v6Qsa1wb+Qix8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1w3Qne7FKv8Z2ibgfV9CjTsbrMpbmMkwTDqJ47N5nNMk8y/JQNFL1V+j9NB?=
 =?us-ascii?Q?6TyiC9JMIPb5NXDUevSJmbUeqT+mHeRVsiktywtOE/Zl6O8kOeV8I03J2YGJ?=
 =?us-ascii?Q?gbkkICkpNRCbqkMRJKGY7CX2vNbzdAStxLzrMwT4bbQFieVLeu0weMF41l76?=
 =?us-ascii?Q?q6j6ZM6UH40+x0uTixl3T7rQmC8Xaq5qL9fIMKkjtueDFrNEamlQkPT4/+Uy?=
 =?us-ascii?Q?HEslFuef1tLuUEvWFX5K2QV1My4PuEnoIv7jyL3n9uzrRwz5Y3AmWyRZl370?=
 =?us-ascii?Q?JcCqww2Xclp7rCu9UU7b4LqJwqlb7IDZKF6/xgx5KO1rVTB82waFJYS1VaNm?=
 =?us-ascii?Q?TH+oQISQeGufgEkP3tG4IIN8cLqQxLJK6TRZiWaeqG9O01DcFjkLec0crdvL?=
 =?us-ascii?Q?dKG+1HI3LmCmI3ejCrjCmHylWb0L/kNN2XUJSCuQVFes9A0sIqLPS3zpWwby?=
 =?us-ascii?Q?lcD54oUHtoYdLxRh/00+eyQawiNw8MGupW+mDBwcfeYj3h5pqyGttSoZKhvu?=
 =?us-ascii?Q?m1+SPo99Zl6+i13rAtJMxmmieqSbsA/QsAe9K8C8OakXUAMRbHgeZawViC6l?=
 =?us-ascii?Q?IHpe5TSweVkAZ/KNxiDWRRXhdtsGFEe5pUGrHQfSNF5XPczZWNl9Smg9i/3K?=
 =?us-ascii?Q?firGydAgEhi1dmEsqKCsJ4ZM6efy4cJVAaeRp7z+EYQsU/DgDlLw9iE6xQi6?=
 =?us-ascii?Q?a2uVtlhAh2hCnDQMNW91YfexLSiH8/2bM5ZXvHlhWO0gywPROR9MAREMT/u9?=
 =?us-ascii?Q?0wMM06slmn2UvB6t453AOENhtmhRFrtp+UW8oCCkArFnThZC37Y1GBkwIQft?=
 =?us-ascii?Q?DWINkYdjCGZi5X+b2oFB3k/RfZVWVf+rPf9VwZWK5e+lSD+EuaHzbb3c6c4l?=
 =?us-ascii?Q?QBAXmtseB9p9YKi4B6O071IG5kKNlzCgmoxhCr5TN4/fq9M/bs7savQVKmIl?=
 =?us-ascii?Q?TnuUPKB5vyAjYwF4Nm54S9oV7Xd7yJnzTe8eRWAsrbbJTdVoUSGEA1vqaq2J?=
 =?us-ascii?Q?XxWg2BohnVZmutvk9/PMqqch5p7SNnPf/mF125dPffycsRxagCyMyXK7zjfV?=
 =?us-ascii?Q?Miyr12xqVR7WNTLqaWX+Cgj9jpFiEwVVkj+gM4B97fWsENqyFuF7ZEUslLFl?=
 =?us-ascii?Q?5ihUKCzPgeTfScSBckWfu9XDb/Wp7bUctPZ+AfhgItHxXtMBkcx8poweENw3?=
 =?us-ascii?Q?nkWIa6RBMCzyDg+Lgg0xSstncJGqcGMrUUvg6q/HI10TtBFe4bRygtS0DB9u?=
 =?us-ascii?Q?Ek661wi2tPju3udJ+U3OGLijbGAz8LmcbJECsnauceQgIzreEp+eT71LVvcU?=
 =?us-ascii?Q?aCs4R7MN0o00n4tCJiY5tNsJmjRfxGlemgPlyDiNRc0+0mLcoK6koU8Uitq6?=
 =?us-ascii?Q?9u8uma0BQL0VU1jaVyiSg3nIasjutdtPv8YHikgXsF8bULLjoeWbNmoHaNEu?=
 =?us-ascii?Q?RWrYDoFL9P6o2n5Ng7mgkmWqpDG7O3o3YQi1T6DRpV9OiMhm2Z7LsoNVco9h?=
 =?us-ascii?Q?JOiFObvlUIE6SmgfpruUXU9iZNgrfgVSHR1ik55R4XOvNesCzqSill7u+ghy?=
 =?us-ascii?Q?u6T5hlr0fdk1wVvWN21zYiJoAwgDvuwsxduhvYJWeqMgV+XHj8wad0BnydbH?=
 =?us-ascii?Q?fJKag5dK4Iclv89rEgT49yddmFqZUoGP+cotWzTCdFcYKse2ZYZqNoGgTl0W?=
 =?us-ascii?Q?te1Qmvp3FzT6dx0O7UkyFtVu61OvCYxgMeTEOzoCJC+bNNLT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8017968a-f553-4e57-51fd-08de94b351aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:38:22.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzT2UdpemdHtkK3I8/xA0AtNE/t21uhgRwxijdTwo1VytrxSqJRc5bswvvmVWTSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

On 6 Apr 2026, at 5:19, Sayali Patil wrote:

> cleanup() resets nr_hugepages to 0 on every invocation, while the test
> reconfigures it again in the next iteration. This leads to repeated
> allocation and freeing of large numbers of hugepages, especially when
> the original value is high.
>
> Additionally, with set -e, failures in earlier cleanup steps (e.g.,
> rmdir or umount returning EBUSY while background activity is still
> ongoing) can cause the script to exit before restoring the original
> value, leaving the system in a modified state.
>
> Use an EXIT trap to restore the original nr_hugepages once at
> script termination. This avoids unnecessary allocation churn and
> ensures the original value is reliably restored on all exit paths.
>
> Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

