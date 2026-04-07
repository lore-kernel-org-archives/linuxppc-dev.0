Return-Path: <linuxppc-dev+bounces-19444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4472EFEEF49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:45:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqprp68qCz2yZ3;
	Wed, 08 Apr 2026 00:45:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775573114;
	cv=pass; b=Yx1YgM7q1FCWmY1gGvOLhadJIy9MRpjOW1WdZ/h1PwCzZIUfA2me1uUm2kJxkRHImUe59i/d7pH3DqM31RJZ1dTPCcdq24s6UbYdlP1v7aIRd99KHyBoucZwkG7cDB2FY1Lr41APniFAmB+KcJgwf143xXkkdygPV0o0TiQNSgBjDEM5f7VpQu/F5WKJVaYpSLB8nLfNWzZhrmBIpiD0hx6CUfIIKhTlrEPlzQrrRkRklggR4cSXnNSGtfRhkQBsafM1T/9LFEitkO/m5IzO7k6n1aTHYVJjJKsxTKWQz1bnBPW5CeGCcWNo3mW6kH+LUnnv453a6MUtPQmFHMJcXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775573114; c=relaxed/relaxed;
	bh=0AyxYpaTmDQUl5fMruHff6ifX3Oan0fPaFJ4TlPicfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6J75mCO4CFuxNOOSv4FuLMvg2y2c3xP1n0FOEDTtiiI4y6Vzi/rxNUwqGFKMtVgfdcu0q071sWu4CbnWOeRBS6xdpS4i+S6+oJf7/n2Y/dKYR3IZur8XqdknCK0xW9uums39TtvQ16lSrvbWlnOwTFBATL8TnVt0M421FF9NmpnjWn0w9VRZnxbtoai9bUU9ijvYYnHLwbX8/fTTym9MgTwvJAsQPGOE3hSCADR0tiOMAw318s05LdjM/upcF4MTe1qxt8HhOPvvNkF1I4KUX2b4zDWar1kKhXyhP3r3A5Zzmf3iW/RP04o9U4v2BUObLlgacDrpM5FAvbZPhHO6Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pZ5gg2ri; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pZ5gg2ri;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqprp0J7cz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:45:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf1gSbAJfcNsMUqMRyJwKvyIp3zd4/3PKwXglvgkMJxBlz5as42HeWzAVJIN+S9pifgfLz5BcJbjhnVrZIuMjy6+nycaw/E5RaCdeU3mGte2PsJrEgnx8s9BEtsAa/klyxyWOK//NtQxH587d3Wr+bfN6NwTv0vavuKChH4cruenOLWD/iwqm965kpnQkIIMbjrzAeS20zckQ1QFBgpv4O6MuzkVi0pW9CsyeZ5jw+xnAm2/mvgWUhmR54yKYBV8FFWfFFlmYiXbLoK9pSGx23uZpdHEyrboeHvGF7CyU27NOJ4tXzSnB/F6Jn7NdzzmShyqcjQReBQDkSZtfyuEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AyxYpaTmDQUl5fMruHff6ifX3Oan0fPaFJ4TlPicfQ=;
 b=eeH8dqqTquMkViBW6vKMw4RJBYrdcDUp3YiCvseMlJYRILbXm5twhp8GBu8a2oz+9Infg7722WrfjDEOV9gG9s/PyDv/r/bAdBTCSV0fzg7d+I7DlDV5sAlqB2I998Kzw95xSUrhp1QC8Ks/lanKIHZMfZOMRuXLSB+xCKtdkMEqYySvQPWXTWb3D0siSLMFT/hjj6AqSISJDRXVS3WqRJwT2DPcUUS7Yj+Myz3kKNbsn9nkSp6moQnkDNBW600x1A9ZB9R23/sRo7tH6v/RGKrRclXG7r5Ug+6WYSHpDNrsMqtwmNLmjlt8+Lzxnm/R+2BOUppD1QMAuGd/7zAH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AyxYpaTmDQUl5fMruHff6ifX3Oan0fPaFJ4TlPicfQ=;
 b=pZ5gg2riVF/gFRTi1MeawKtW19uoJqZkH0ueiUEF2IW+aDHGGlqiqI+rhock/U/TVbbYgnI9MFZUSBuzm2j5gcOmxfx7XXNYAVS8oBJzdPIM9cThXsQqAl+JTvQI2LMltbTsPzXi0ht6jd/4YsdcEaXdGpV/I/Fz4PmlcFUusTyXraoGZCF9HHb+u9b2uY0NP66DT1tcyU+MALebMtOohBnJPuDHxQwh1NY+CTq+gc2EbpP7/4R0R2/eh70tfIZGkOVKUQQoVeID+EBCnAEZYdxJUPhicUipKaUYMNLeVpzbyLhCg2h8MNkvHBsuRaWT0A11ahYKSNAGr1sDE+9BuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:44:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 14:44:47 +0000
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
Subject: Re: [PATCH v4 07/15] selftests/mm: free dynamically allocated
 PMD-sized buffers in split_huge_page_test
Date: Tue, 07 Apr 2026 10:44:25 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <FAA98235-2499-4769-A4B8-18C5054D1885@nvidia.com>
In-Reply-To: <a61c264c824d140a948db64b2e1036bc4229d163.1775466330.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
 <a61c264c824d140a948db64b2e1036bc4229d163.1775466330.git.sayalip@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0129.namprd02.prod.outlook.com
 (2603:10b6:208:35::34) To DS7PR12MB9473.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aade34-07b6-4ec1-0d2c-08de94b42bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aEY5j8AzzwLKbBFsupHGHY2iumiipxF6OXYws6e0GuH926pPSk8UCAUD3/JciPvdz3/vjJBy8n6nmao9C4PMsfZQXtH8RaSUPKgcXG16Bbb+NC+KmlmeSp8wBrkVFCog0Mvw2cmVQpgfAIVWIhbdduTq6ZjfSv8PnpPLl2k1Ys//Q1ezp0ZKnGiJGrSxeZoOBlRejRAJuCHZVpBkbyrEBgNhfj2pvAxIjmhwFZ/ev4Fw6F2qOmGfvDWlTxXCObsxMTawPCwV2PWSCIa4GeP+hAqnDrmpr7prMS7ztGufSegRuMZcl6xXvkheUU4ivkORH1KThpYZ9XU5EGEaZdwLmgUn/WTr8BHOfQEkXqaDVsKEdjQzEDDk9RUO/Z5xujygyZwXCcr8pTexC/ZFoKzHIye7M+n3FfOQbmEq26IVyJ8VcNxhvpVJMfip27A31NVMsuESJxOHmSegNuBvMAlMi9Z9/9ErgkQBKCPPsLmmV5xo1JrlAlo2LfMxeut5NSXuUWmtStgfw0w2ELScHV+g3AYh8LpYzxm2YvU/mZEUUDihQIhAFkZnkqQQxlQaiIZTvMOEoJ+3YRGxg2XJKLa261crHTM37TQEiO1MlaPXF0m+/RcxluXywgdns8wG9WMQGsIVTmEOmbR8egp+2/cZoTo1Oy1kNzOFS3sS/lh/15ubm2TJbONVZFJ/+qEvfmV4/DBUDuNXsa4c+meCk9502uRoKeVXcAl5ScW6hLPmzQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obe+T0kh1n4MxRF9jOfUDDyNBO1s8Wfl5j5a13g1TRxKPV0VmHWQFiqYRZeA?=
 =?us-ascii?Q?40I4JHxdF/0PGIYMIEMR6dQdSYM0zfpvLkSX+O7IHcSxlW0+A6P1t+vLQcJx?=
 =?us-ascii?Q?U675alGGBRCiOI5s0kKpvUuhxhwzZbb2fZnHLiKENJMF9mJOEBpiKqojLJiD?=
 =?us-ascii?Q?CW4jOSfV4M2vslwe4VrhpwoLaqoiN3Dfo6Et7JPuULFKVfqbd4Z2qP1pB21N?=
 =?us-ascii?Q?C/KNwjq27cmRPIqBLh8NIIzUbdZN5qLa7HqT/umetb7Ani3QEBfYL8hsDvGM?=
 =?us-ascii?Q?8utgdFMZIOItD76Wt6si2SaTQYWbHwlr9tJTkS47dVz6aawsygTtWCc1zbIt?=
 =?us-ascii?Q?3ZW0YgaEVEq908zXb3LoUCjGEFTN4IlahCcaOQ9d4a3yyO1Bt9NZwj4GwzXh?=
 =?us-ascii?Q?xPcfiWvj+FDW3JYMQ9EfTecXWFhTfuyFbs+j4ytRs9dM50wsL6FgVX+V/V0t?=
 =?us-ascii?Q?3pDs03pEMvzIOHO21/THhmjQsEumchr4DXoJu9drSxZZTKZbt8qDh/vy17kC?=
 =?us-ascii?Q?BxxBQGxMpMPh3Q3y+KikNzZP7aYaanKZo1GhFgmomlmzGsUxYRyHts7hns+t?=
 =?us-ascii?Q?h0J8++CiNcTDvCttjSRaPmQP99ayeoTqsT2c07mtHshOmWE+W0olbIAvUvaO?=
 =?us-ascii?Q?rd4jR+sjEXEHvJvQEXGfv5obcKU3OYNPDvp2SrIRHm4ZzJCcElpUk+uWoVBB?=
 =?us-ascii?Q?8AewvqVoVtNa+vMbl5V+xJcr+W1fMK5GhjX82uTdF/AfoUfBVmhGfOz6w7Xv?=
 =?us-ascii?Q?Vhc8PcY+VixmX95UO6D9Woz9N1IKvMH/Z6usMjkB6qGPcT4AI1Y21qEEqFTH?=
 =?us-ascii?Q?l4I10ayaIW8FYOTDQqY3Cq59a3BDIDnEAqMgCjJyFJ26nx0TKOV11EChJovA?=
 =?us-ascii?Q?22yiTqzVCFKQFmkdfu15rK0Ne40KU/u/GZeZ/o6XklbIwkkKDYjrhr5lo42x?=
 =?us-ascii?Q?5e10i/ERr1VQElVCvvYByO/98ZwwaPry/1ywstItIpDpv6xtknbg9vsRsE6r?=
 =?us-ascii?Q?/44HAb/UCbfp2aeexh/nGfuK3s7wMpVc0vz0rG5wP9iUxw9zty/HUFSbozYy?=
 =?us-ascii?Q?rZNWQRMioHssbktl7iUbskHAqD+nxMfK34Ul5S/e/7d7VKy3bWrOgHcQEBDE?=
 =?us-ascii?Q?FLdqp769Lmb055zaAPl06KtMnZNBrRMERfRlzlXN+d34rspq7mxA+8OZYbAA?=
 =?us-ascii?Q?lkmlakOaTwzOlR5s0ESfLJ/Sbjx2HHPuNsVGqRGaoMYJM9zBPUsvpSBp9DeY?=
 =?us-ascii?Q?nO8VjKPPWTkwCsRApuQxWBJzwzhntruKQg97cjuaY8k/CUaRzWFSbaupI0oS?=
 =?us-ascii?Q?xSvcXfH/LHnnr5IMwKidgrfjk+3qMJJDdiBG9SYbIY/J+sAzwQ/KWTIz93Qh?=
 =?us-ascii?Q?IWJL1MHbAG9th6vEPqvFsODrrSOIFbKmKpIvuwSkk2OCygagHoA7iz5TKKeX?=
 =?us-ascii?Q?6HgNVZ4niFgkR6EiUZVvgC1H97bMvFSnRpzrSfVboWUgNe9V8TKvS1/RZrXU?=
 =?us-ascii?Q?2Q4o5vDGbT7pHRbCo4F3vNWlbQnlkge1sdLw0LBJ9xB2MbQJxktl3k7y6lZM?=
 =?us-ascii?Q?op66yavjBUvU/np2wShp9nXWYt5v9BDxQ0BtcxnaoR4x7X+A79lPhzBoQLAT?=
 =?us-ascii?Q?HQp44DlOU7NpN7vbT6jCxVVLGnkyuHyXdWcvT6X9wOFPVNcyCpS3X98cnEV6?=
 =?us-ascii?Q?xbkdMj0y2ggUr7S/7SNgXHODiWa08w82NcNeEKQW0m2m5L7R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aade34-07b6-4ec1-0d2c-08de94b42bb9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:44:28.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edku6T+V8zr+Ly4Tp+2Nl+wx5mKlegeBMcpUyQUy0tf51lVXAm9FeppT+sdlbRB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055

On 6 Apr 2026, at 5:19, Sayali Patil wrote:

> Dynamically allocated buffers of PMD size for file-backed
> THP operations (file_buf1 and file_buf2) were not freed on
> the success path and some failure paths. Since the
> function is called repeatedly in a loop for each split order,
> this can cause significant memory leaks.
>
> On architectures with large PMD sizes, repeated leaks
> could exhaust system memory and trigger the OOM killer
> during test execution.
>
> Ensure all allocated buffers are freed to maintain
> stable repeated test runs.
>
> Fixes: 035a112e5fd5 ("selftests/mm: make file-backed THP split work by =
writing PMD size data")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  .../selftests/mm/split_huge_page_test.c       | 22 ++++++++++++++-----=

>  1 file changed, 16 insertions(+), 6 deletions(-)
>
Thank you for fixing it.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

