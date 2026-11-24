Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F6606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zjFWyegi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYq5R40gzz2xNC;
	Wed, 25 Nov 2026 04:08:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795540107;
	cv=pass; b=GEazduhvrgAxbRj9VLTl8lff83Two+5QPUVtsNtEG3ZRdgQkbnrqgPB9rjmpkppVR5/fWFXuZIdRprgjXXBm8XSUiJdAHo61q6/eOAs5q7UbgfFyP3q1ytl1tcTMmVyt9OH0YX1XsVF9PsQsikS2PXVm2aAFLYpr07oPD4ggBy21kp8veoe3u641YJennZOWfYEocGlrxPndKvQZNGg2F9PSGmWYPCkVgGfY1mPGGWGL6Q4Yr9L2Ag9c3HPCTzuc50WdNF77SIQpciM8R7YMrKNwR0rnuB/F+9Laiip88MaVIRj3PEr3pL9ZZrkFby9J8n5j7iEoaUMa4LlVJyNvyA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795540107; c=relaxed/relaxed;
	bh=vOXannmByq7XTgA1j99gncFiEQ72VFlKNmu9jDmrUg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KFF6MX7d03/hea36YwPjhl1TKnguJA7QtiYy7PL0CY818qGjHuR2TGySeGr+k5+s8aAjaF5heukcm6popwRoAc7wIMdGD0i9CWALW2luxwpix4rURgwHrl0aGNmTejtraV/3kiik1zfvZ4WAFl94c5luQN0bqVcp/vOoMYki7wt42pK2evQuC20dU66yQ+wXoIpkgyX6qotYvqwwQEdqqT+wUB4WRkkX6fUMrxFBUBNhBE2zUEyeK4yqZ1TJQdRu2lmjjCwHL4F5Of1bs9nKX4vrrxycPlQSxWrKq6kPMsemGa4BH/lUuqrBvDLLAfHDyaQWGAQ3wkPj2LvIblQqDA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zjFWyegi; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=yazen.ghannam@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zjFWyegi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=yazen.ghannam@amd.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYq5N3lXlz2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 04:08:23 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxm7g6TI4ORhxqwF4E0PzWGEl7tvg4tbFYhSBMWtyktCVe1F/IMrrAF/3cd15fTMSxy4BWKtLBlnMnTjtfCej6RTUl5HZOiFpmHYLsmv1fmOvFTCA3znFt/ETC8Tu6mnTtrDIqHPpFwza+R5NNmwDGsFaYoOXS8R2JVfecctpa/sPi+0npB/s0PfV8JYcOlZuGhbuesCoh0OEZ8il1QJeFErKSgEQyuNTr/FH/2m2h0OMTnFX1UwbcyZ6pyrqnFbRZYRVIMZe/66rPu438KwDPZkWUSXJA1k0tVjXIxwBxTjWlJsdffYXGp7Ystr0kM96ojekOECNpRK8svOrAF2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOXannmByq7XTgA1j99gncFiEQ72VFlKNmu9jDmrUg8=;
 b=R0Bq8P63vDkyFyWy2WtlOU6enjj6KRaZO4lDaDM8lpuoV5dqLAVkcj/Kjy43PIyu5yQSZgmQm3O+B0k0FE835zw3ZJGFYfNXVnqBl+1i4L7+sh372DaefMDkJLiKRByb9wlYCoNrB20J6HEtW30iYZEseV/7FBHexIJTDz0iLCHlDKqE2EfcI6qja2a9eZEXQl08fhnHKAQCR9i79qL3D+pbFZwtFf2AxY2ZSYLQuuO65PQ56YBE54Tiiy/mEIpzZg+kQKD6q5dT6zosndHlxaCEKTjQZSaSnHWTrKfhgjch/xnSWJ7pSRh50MP5JQ3AdSIWJmznw0+rFJblNBF14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOXannmByq7XTgA1j99gncFiEQ72VFlKNmu9jDmrUg8=;
 b=zjFWyegi2luSaM2mcAZUIk0SpylEqYFcUjXp+0TNAzTFTyHl4FPxBzv5IcmHZ5aOJvPkKJmJLDbSC1YRgF7ryXqvCfzpCLikEiBrX+PieLB2iElpdW2NZkNOcTghRMFAgUz6YOgGBf9VJTBCmf7S5XUMOgK9hMW4LIc//IUwIUI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by BL4PR12MB9533.namprd12.prod.outlook.com
 (2603:10b6:208:58f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 17:08:04 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 17:08:01 +0000
Date: Tue, 24 Nov 2026 12:07:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Radu Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 00/19] ACPI: APEI: Share CPER reporting between GHES
 and extlog
Message-ID: <20261124170723.GE2156781@yaz-khff2.amd.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-ClientProxiedBy: BN0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:408:e7::23) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4dff34-0f7d-4bec-d156-08df4a4d7ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|11063799006|56012099006|261022075727099003|261009223027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102130727099003|261102123227099003|261021121427099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MkaQIRmfk9FLCLWlUBTpKANE91A3eUmEDIMbI7hRL6bLSiWpcMbFriquAZzyXi4/IQVA3RYJssAr3ZzIEgXqPNi4TAMEm+2ziLqBrR7uerWoLBmNzDzONMgADV09+z94Z+A95mvb/tkFAVdEeLQeYH/P8PPfEwzCe/eB547y1/Zhn0hkBpakY8xIEhte87dcoC6TI1pMJTUvj24gYT86n0QHoHIs4GD7dm8OrHFHlwXMW/zGoVp6jiK0uP5tEwT6iyyO00c5u+4IHabbJldY9VrdeI8bFayeONRc+3W3iIOa+FSXOZGao3Et1dz+uHmlz95K1b3dOUZRuw6hW7so7AdY4vFdozJS0I8fBjups7ZtRoActrxQKQqmlju0BGdugtts7jpqvpQDp+Xs9c7k/9cFij7hHBNGLj1ZRUHHRhUTxBC8sSV5O2jvCe2EE9bBY26UbLOTV0U8ncwFkJtggr4cPxBrvTJeaHZ9nKmKQY92EVLdKLcJhXD3trykOPsjRydqimoSBoRxa6NE9qQMZWS5+P5RZo2sfXNk20FIPEmVD+fEx13FI65xOdxptCtfOh6jBHJ3/+XvhK3NExPvT9iyUhWLpy6M3uJBztxVzOcg7KthepRdJgUR58aTe/zB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102130727099003)(261102123227099003)(261021121427099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TubCYjtRARUH1vAk+g6pfNTGEkV44LD06ZodbaaqCpoWq3cV46kfyM0xZv6B?=
 =?us-ascii?Q?8Km1kgjUlxi4HRMNXEzkMfazvk60vDqxYqETRMi5PUbzrUY/H0hxd0P8CaeA?=
 =?us-ascii?Q?9YNTw4t+25w9tjkWtau86pI5f7LFxUOs0CB6xLayEBEKVkhjKNke0wqcuIEE?=
 =?us-ascii?Q?nMi8Io7nyASFMe8mUk8ahaiZel1ZzEIZw6VcU8fNar7X5DWSKus0Ge8rEus8?=
 =?us-ascii?Q?hdaN3J1yZIyBxDzZ2y4xrnzUeBrfnb9hSK4t7DlpoGrTEaeiH6JWWfe8dTw3?=
 =?us-ascii?Q?4GH1WHPZenr8aHT0DeD/t8VXPYJiJKI05J58TKqq1B5sBppXYKMK3Ma9i2uB?=
 =?us-ascii?Q?HCYepLNrT6fuqwyb9D6cRAD6VQRmn+N/oWWJ6W91j2fmhl3HjyMdln7xnOSV?=
 =?us-ascii?Q?XyDxkcISvw10gUrheqUv0tyhCxQMLp7HUZANJ9CqbNEaEvtH4Rm+vxr7FvlD?=
 =?us-ascii?Q?qY6DJGmpu8WFR3FU/mTYE6LkoN9TIZMv0lDI51fRgqMde8WKLqZUE6d+c5VX?=
 =?us-ascii?Q?wvT3H+sxH+6dxX5/Xnm1fwau71lsovB3uW9GBYp09JnTDqW59GiCXOuMVXvA?=
 =?us-ascii?Q?eBTptVciFjq9XaiIIrFac641N63Gve6aHfXfwlfPMUs1PFqFbaUSNdC+RGcS?=
 =?us-ascii?Q?BkZTNpbbY04N9HMVIKwLOQbM9ac94GlEp9N0IsHHor98+XMaHVtcWT4Erf0D?=
 =?us-ascii?Q?3VNAJQrln5CNHQERttAA4ovyg9UwSj9k5VJn6IhglXM6CEZhkCO2iWnhNUef?=
 =?us-ascii?Q?d8KEC9TW6AOcQXDRXAaejoizvVYTV/nKFRkyhelpLSMgxZUjCZvkkgGg7Dzi?=
 =?us-ascii?Q?fqRnwFURwdTRUsZ0LodT9RV1d4zZDaBY2Ki4FCWXeeL5TF/O04jmJlg/zmfq?=
 =?us-ascii?Q?YZhhFzRs11/V8mJvW8ZiTK8YuuiEF39kQljjfayqLJ+aZddkrAagTyZpt0zy?=
 =?us-ascii?Q?BfxqG+QfqU177yHt1rOX575pRTfjTp0XeZDKoo9Znj9qSX0c+spofyCCHBEw?=
 =?us-ascii?Q?dkr780zD1HpCLHs9KHSebAYQO5RBrFnq/jh6W4KWywjcnOACAV0+is3Etwlq?=
 =?us-ascii?Q?xKS7IXUh4XdypPJb6/b3vIMZ1yljKTOwtyepyR3qCZF1rZShyfVHzL5UfRSO?=
 =?us-ascii?Q?l7ALx260xaWnlDNbXb8YTMbLDlzaQF9wfCHt/J39tWLZ09hE3+3TmwWY9eYK?=
 =?us-ascii?Q?XZH4ZFPgbhFD/GKvjHpncgND4rJvKZ3FYET4hwZnIMnQZSUoUfZMvrQwYRdv?=
 =?us-ascii?Q?D/kY0WBfWY4w29boIZKKdNO/g4FvNkk+9m7He+PohUKqevWogWhKKJcerplc?=
 =?us-ascii?Q?zcmhreCxFdECS3eo5mr9xzysiIMx1G94XnC8O5AiEGmnMoLPYMHZaT13BiC1?=
 =?us-ascii?Q?AXOZmrpCVWi/HryAMqd9ed1vONGJG88w4vKMviY2K2M/jQy8p7neBi5CmKTv?=
 =?us-ascii?Q?uE23W58XIsG8VNlP00i6N0GqTqWV1Gvt3E1U2i1t9ewAqfvUGl2VqSd/kl7+?=
 =?us-ascii?Q?1ny87Cl6evpW8BtdD0janNoJN8L/xhshlZKXeQX6hrwMxZxVX/NVQpvzF8vk?=
 =?us-ascii?Q?vmgTvkyCdzeVCMHecnTPUt/+VTnF1G95Y6ktzvx8UJ/bE1EUV4n9Sv3GuiBA?=
 =?us-ascii?Q?WvdR4+GeJFYjUStLZTMCRT+hCqVapUULwqgL42nKjbZM1u+JmGvwApZIBQZa?=
 =?us-ascii?Q?/0A0kiKG+A0i+9uQFQSJ+xsaoy05l0lnZxpol/UWKwykO0AK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4dff34-0f7d-4bec-d156-08df4a4d7ec9
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 17:08:01.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWpExnu1JdAgf29lcaRYiJGyqIO1eVCtRUcq8EDA5Vf0U/GqasvEhIUBMXpTr27rap6c/3oLlhVzI/XN1Z2LGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 12:10:10PM +0100, Pierre Gondois wrote:
> Hello,
> 
> This patchset should be applied on top of [1].
> 
> GHES and acpi_extlog handle many of the same CPER sections, but have
> separate implementations that do not always report errors in the same
> way. This series brings that code together so both paths can use the
> same reporting helpers.
> 
> Most of the patches prepare for that move. MCE reporting for Memory
> Error Section 2 is also added. In the MCE extended-log policy, tracing
> and PCIe/CXL handling no longer depend on whether a RAS daemon is
> registered. Only fatal CPER records are printed to the console, as
> briefly suggested at [2]. For nonfatal records,
> users need tracing enabled or a subsystem handler that reports the error.
> 
> With the common helper, GHES can emit memory trace events even without
> an EDAC driver registered. CXL media records that cannot be queued are
> reported through the nonstandard trace event instead of being dropped.
> 
> [1] https://lore.kernel.org/lkml/20261113132600.3355836-1-pierre.gondois@arm.com/
> [2] https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/
> 

[...]

> 
> Pierre Gondois (19):
>   x86/APEI: Extract common CPER memory error reporting helper
>   x86/APEI: Report Memory Error Section 2 through MCE

These should use the "x86/mce/apei" prefix.

>   ras: Bound CPER FRU strings in trace events

ras -> RAS following other commits in this subsystem.

>   ACPI: APEI: Use empty FRU values if valid bit is absent
>   PCI/AER: Embed aer_capability_regs copy in struct aer_recover_entry
>   ACPI: APEI: Remove aer allocation in ghes_handle_aer()
>   ACPI: extlog: Provide HEST generic data to extlog_print_pcie()
>   ACPI: extlog: Align extlog_print_pcie() and ghes_handle_aer()
>   ACPI: extlog: Report errors independently of RAS consumers
>   ACPI: extlog: Simplify fatal record printing
>   RAS: Remove unused ras_userspace_consumers()
>   ACPI: extlog: Extract CPER reporting from acpi_extlog
>   ACPI: APEI: Share helpers with the common CPER reporter
>   ACPI: APEI: Return status from cxl_cper_post_event()
>   ACPI: APEI: Extend common CPER reporting for GHES section types
>   ACPI: extlog: Report error severity using GHES bindings in MCE
>   ACPI: APEI: Share the extlog PCIe handler with GHES
>   ACPI: APEI: Route GHES section reporting through extlog
>   PCI/ERR: Avoid NULL bridge pointer
> 

There have already been a few comments on putting fixes at the beginning
of the series.

Like in the other thread, I asked an LLM assistant about patch
re-ordering (copied below). Of course, these are mostly suggestions
beside the "fixes first" convention.

"v4" is the latest Memory Error Section 2 series.
https://lore.kernel.org/all/20261113132600.3355836-1-pierre.gondois@arm.com/

Thanks,
Yazen

=== PROPOSED PATCH ORDER ===
Rules: fixes first with Fixes: and Cc: stable, independent of the
feature (Boris, "Fixes go *first*",
<20261124043051.GNawUS-yBnVpnuUVhH@fat_crate.local>). Then prep with no
behavior change, then the feature. One maintainer tree per patch. New
helpers land once in final form. Policy changes under objection go last
so they can be dropped. Numbers in [] are the v1 patch numbers.

A. Fixes, posted first and separately (by tree)
  A1 [19] PCI/ERR (or PCI/AER): avoid NULL bridge in firmware-first
     recovery. PCI tree, Cc: stable. Reachable on mainline through GHES.
     The Fixes: tag must go back further than 0791721d8007, which only
     renamed dev to bridge. The code before it already dereferenced
     pci_upstream_bridge(dev). Kuppuswamy's !pci_is_pcie() check in
     aer_recover_work_func()
     <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com> keeps the
     native AER/DPC/EDR path untouched.
  A2 [3]  ras: Bound CPER FRU strings in trace events. Out-of-bounds read
     in existing events. Needs Fixes: and Cc: stable. Could also join
     v4's group A.
  A3 [4]  ACPI: APEI: Use empty FRU values if valid bit is absent.
     Existing GHES bug, needs Fixes:.
  A4 [16] ACPI: extlog: pass GHES severity to log_non_standard_event().
     Fixes: a2995f7dab51. ghes_severity() is static inline in ghes.c on
     mainline (base ghes.c:325), so the fix first needs the part of [13]
     that moves it to apei-internal.h. Drop "MCE" from the subject. This
     also removes the severity mismatch [15] currently introduces.

B. x86 MCE Section 2 reporting (tip/x86), own series on top of v4
  B1 [2, part] x86/mce: apei_mce_report_mem_error() prototype rename
     corrected -> severity (Cameron <20261118185721.11639b38@jic23-hlaptop>)
  B2 [1] x86/APEI: Extract common CPER memory error reporting helper
  B3 [2, rest] x86/APEI: Report Memory Error Section 2 through MCE
  This brings back the arch_apei_report_mem_error() path v4 dropped
  after v3 and gives GHES Section 2 an MCE-log path on x86. v4's cover
  letter should say it follows separately.

C. Unification (ACPI tree, PCI ack for C2)
  Prep, no behavior change:
  C1 [7]    extlog_print_pcie() takes the HEST generic data
  C2 [5+6]  PCI/AER: aer_recover_queue() copies the registers, GHES drops
            the pool allocation. Squashed. Lukas's size objection
            <avw-NChMgIjwFuv1@wunner.de> settled here.
  C3 [14]   cxl_cper_post_event() returns bool
  C4 [12a]  pure move into drivers/acpi/apei/extlog.c, old names and
            err_seq kept (Cameron <20261118200417.42034547@jic23-hlaptop>)
  C5 [12b]  atomic seqno, reason stated
  C6 [12c]  mem helpers, FRU computed once
  C7 [12d]  tracepoint Kconfig relaxation, CONFIG_RAS guards, drop the
            stale EXPORT_TRACEPOINT_SYMBOL_GPLs in drivers/ras/ras.c
  C8 [13]   share helpers with the common reporter (rest after A4)
  Behavior changes:
  C9  [8]   extlog queues PCIe errors for AER recovery. The message must
            say eMCA records now trigger pcie_do_recovery().
  C10 [15a] accept legacy 73-byte memory sections, with a reason and an
            FW_WARN on short sections to match GHES
  C11 [15b] ARM processor and CXL media in the common reporter. The
            message must state the CXL trace fallback when no consumer
            is registered.
  C12 [17]  share the extlog PCIe handler with GHES
  C13 [18]  route GHES section reporting through extlog. Justify the
            reporting-before-handling order and the double
            mc_event/extlog_mem_event.
  (C14) v4 08/12 extlog Mem2 trace event could land here, directly in the
        common reporter, instead of being added in v4 and then moved.

D. Policy, last and droppable (Boris
   <20261124050045.GOawUZ_S5imwUOyh8B@fat_crate.local>)
  D1 [9]  report independently of RAS consumers. Must deal with the
          suppressed MCE fallback print for non-fatal records.
  D2 [10] simplify fatal record printing
  D3 [11] deprecate ras_userspace_consumers() with a warning instead of
          removing it

Dependencies checked in the code:
  - C4 does not need D1. Patch 12's acpi_extlog.c hunk only swaps the
    section loop for acpi_extlog_report(tmp). With the daemon gate kept,
    extlog_print() calls it after the gate.
  - C9 needs C2. extlog passes a stack-local aer_regs, which is safe
    only once aer_recover_queue() copies the registers.
  - C9 needs A1. Otherwise [8] adds a second path to the NULL deref.
  - C11 needs C3 and C8. C12 needs C1, C2 and C9. C13 needs C11 and C12.
  - A4 needs ghes_severity() visible to acpi_extlog.c.
Not built in this order. The 12a-d and 15a/b splits need rework by the
author.


