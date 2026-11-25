Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBC606A336
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gN4n1cuD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQlj6SSBz2yCQ;
	Thu, 26 Nov 2026 03:55:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795625713;
	cv=fail; b=kga1glv50byIcOgcwzsMPKUycEYGvy1QJdSrGSq9/Aa7ZfOsbUyKSsuxw2LaRwj1QCabCKRxodyY2szlnAVKj5uMZgVqBOFi3p7A7u6/bSL0anPxayjmvIxExmSFqC3g8UuzDsoAHjviTeiNuIGdD5MsYxU/vVooHgPnwNFQurrB0Vh/c/tqo1Z+hEErCaxgUqGlNGdtB8RzGcZCGorpH3yDBqdDjNlD0870AgsJqbwVYicexNMRM7q966w5ovXhS+nGBD+8XpSUir5prgR83d/tdq+XKTtfh3DHkb+WD4Zi0Uc0wfsK2T0Avr0XMWMmMvEBzapgiqSQHwujsEWwlg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795625713; c=relaxed/relaxed;
	bh=qiFmxAg7uvI2chrtozhWWUzKJEUCjS2xqjlFfyFOdh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oijHouszda3SE7bNGW12M6iIa2xMI8ybtTeuDHpIGNXnlbOwZ2ITQXL1ILXfKLfmwoLStywWfzvcmRSzwGAcASlFqMCJ7JjiNvd7gfFzfj/nlkFjtG/4bmB1mtVT9QvPd344sYRtTOaKgxyvzhF+ewmTdsypvqi3V7UfJxUxQFC+RM6E7YCtvGmeqzLRkcf6dzPSirYtkb1mg/tZOwQ23NKAcu2e/ohkvXruroQFyOxtO4agtNTLlWomgouefacQvE/Kif+se2WpX818wrQ+4uQt59iOrYyM2iaUwUyPgYSxKx1CRTVsdktPocTCeXvGc9u/XjGMESdg+792VeAmJg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=fail (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gN4n1cuD reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=yazen.ghannam@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gN4n1cuD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=yazen.ghannam@amd.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQlh0VlXz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:55:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltvW+GVBYEtfLcLj6hVa83+Fwwf/dBe3b7ANFGX6FftKEUcjNWZ5w3gjy/1lGQng4ikotujxCv8e2i2LkTOSsYabU3sIjNvS6VANeihhyvCVR3mHCJQ9CfkD1g9gtaoK5mjt4hPr50q9MPGVzED0M/91P3Lzk2BwvSwn6wJGeu2MBrFEhwet+uY9lnQz7rBNut+ImL80aO3/aNYslElqHjKn10dr0zwZBSEpEQDxmEQ2Cy+RSxmMCaQwYMXe3YgtWbd9Uv98k7vO0wN9wl/XOkW0dBEIVodSDX5hAgEibX3EF0Bzeq6AGpdYxVgAKTJhm3IeWZTNsLAFoejQGAxn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2BjKrDMr+a+QTobO6ygfTBY+FnJAXtW6hashTaGM/k=;
 b=tlwc+ScDYP4qh2M05g7PBxfSI1wi9WWnIhUfIvT+NEnXRAQZ8GgZ5ABrLtPYxcU8iCG4M1foS0b6mvCWQhstjLArDKrvaKwRLNTnxtNcFAlby/4gDY/Ol1ufP6ufo+6Asz0qUhFIjPhluuqymP7Auc5AQmPFwS48FL0kz0Yxyhweb1ceShmsFhZm/I5llfolRXvk03U/FiN34jTlwoQxFOpI9j0ZpDTDj/alsxnNKioQjgcQugO+bJu1NI3QQTANgETgzcYtMqU76RAKeMLlt+8xr/2Hvqlec8iEdWggosyHJWDczov6Ze3Xh+qy8Jab6RU2Dl0tZf6Bw8fT4akQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2BjKrDMr+a+QTobO6ygfTBY+FnJAXtW6hashTaGM/k=;
 b=gN4n1cuDryBEF6cJJVZG9x6whzqdI/LBjMHVHIRDJ3M/bldq6Tcsdo8mdG1Rr3Bb8jOY8b9PQLNePXx9ij5PSe4SqGws/Tqfe/93pSr36xmTwbs9iYNLGkDtC0ZVh8AK1meQSUnX1sSdi7ZaYgL5dar/KQ5zv1dXuYL7MmT1FFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by SA1PR12MB8096.namprd12.prod.outlook.com
 (2603:10b6:806:326::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 16:54:54 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:54:54 +0000
Date: Wed, 25 Nov 2026 11:54:41 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Ashok Raj <ashok.raj@oss.qualcomm.com>,
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
Message-ID: <20261125165441.GI2156781@yaz-khff2.amd.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
 <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
 <ba5f649c-f338-40d1-9e85-b666590835ca@arm.com>
 <20261124160027.GC2156781@yaz-khff2.amd.com>
 <92f3a4a7-a4be-40ce-b156-c3fbec150e58@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92f3a4a7-a4be-40ce-b156-c3fbec150e58@arm.com>
X-ClientProxiedBy: BN9PR03CA0703.namprd03.prod.outlook.com
 (2603:10b6:408:ef::18) To EAYPR12MB923140.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 67266ca9-94f1-4bdd-3d24-08df4b14d407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	p0sSF4ktlg+7C9sgZ4vIDuNJDhbKb9z6AQE3qhJofWeroY1FkCVae4KTTlNvhdrmJ0cHAmIE12Mn8DPeTa4GEAGChfGz5hT/uPlxnk6GDyYQGxvk5cWOznzSGixrHbRNiawxT1uXOszH9//+J3Nr7Rv0lzyhdRDG762KiUXbtRu4PIAwSyVK6yz4lBJn/j9nqYDmuyTSzYXwOkH8MOOwJoqn/WwZmYeoiP+bFJoaRunOQh77DPHHZNXDONMILLOOqun3iyH1daDre4hiTjVkgV3QkdTpU1D8IdDZ13GLp1rmvoM/PfJyBJ9bxBIpj3n4zWcQv583rt7LCQ2Zrb9sMM1+34QancqOos+wajKvOD6BGnscccmSKdjNj9r/qGmfKPKmciuKuy19u33PidVtFVBF4yuymAIPiilZSBzRDGJ6xan80gv7XRVxbBNRE64QOSKvYBuzobwculD7e/YEIoBpw/v5Hm3n9YAxXhIUIRZqPslAo5U/n5610H9CPr4KISAPyUBtpy/0F7iwoDxdQfO/oT4INZ4A/FmPB2VYeUeHncOYRWyu9IWRGJ8Ei0Ez+9EW9W+R6LV/BjQ0m4jJ1rw7y3F2k9194tc5d01+KluvNx5LlrFbQ74vgoRgK9/qKO91v2eCBDX+P3eYtef5M43yzmTpHQcGAI/YqB/dDDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?n3wqqvKlan+wesRdhFPnMYpTFm1qdRiWB5oM/U8aCoZBZM03p8ZIu/QAB+?=
 =?iso-8859-1?Q?ZveH4PpAQIxmbdY/7SRtw550khUiPgPEwzSyJKNW4SHNcjzidmp8VJdBDB?=
 =?iso-8859-1?Q?5nMg7SY0dqZsdwWllMcOYOSKHnfcp+I4y34HIsmMFHLVyvaFv1sSgCwZAv?=
 =?iso-8859-1?Q?8WqwKgTTbs7ZCXm7hZjRdSOhJDrpQuJJ2H5i1CGWMMHcbbvlEGCNRDgYNm?=
 =?iso-8859-1?Q?oW39ws6Vc4lOIuXpeOEI+xVeOB0gOPNvP+iMZnZvViJe8mrK8hPza0/GUU?=
 =?iso-8859-1?Q?Y3LDMkeTVn/VEamzaWqZROHA1qmfnlP4yzjXXIbn+1cUAmRKoDqrGbTinH?=
 =?iso-8859-1?Q?YHoD5PEPtlN1jJRc75LjO4Nj12I6nq3rV/gZNpQ/aCwvbMxfxVWMw2BiEV?=
 =?iso-8859-1?Q?lzoUxVeZmNVnWw9UxT0JEqkFbzyQAgOYGSGO3gaQ3aNpo6IOGvBGGT9TJS?=
 =?iso-8859-1?Q?GeSpMApOoLqrA4RfjerToWUjOH9RdB6Ek1TIOTdOu+Im4RAr5raw0yodcv?=
 =?iso-8859-1?Q?Rs2JfRFRx+p9ivrdUEef+Ga/9LPmbDORnjeWM8+m/8yxUXKR8gm9wvJTlt?=
 =?iso-8859-1?Q?mkvEF4B91u7NYPoOaHW+XzH5LxFJUWrzSAosbMSO7c/18EOMqf1TU/ZD8m?=
 =?iso-8859-1?Q?MGLhXoWbYinzRz8QWTlugm9HYMHVMsDCI8N1VoCj4XNA+Yv7clqPTFMjkI?=
 =?iso-8859-1?Q?ORnvM1qfO2XJJJe0tJkv/D/nDOgsFSTh5k5HK0irniQwOXQhck3afowoDx?=
 =?iso-8859-1?Q?zQU9gFSEHg1tD4H444eDEG7QD2zu58g47QsA6OZJgRAgWHKkQqEVhT7EJR?=
 =?iso-8859-1?Q?9wgICfjQlCaDq3iMkjdn0koPSK/i9NqUgsLcwRbAkoMe4CSmRyuZ5juQbl?=
 =?iso-8859-1?Q?5cQ/zYRjCR3mEhECsHQfoO6KVyGvUzZbEB7e1FOWkOETJwi7yUxCGSh3m8?=
 =?iso-8859-1?Q?f/sVXPJ+7A34kaG5WnV0CdTmjhfzTq45UDhAQ9m2dv9eRrp4kCzII77r45?=
 =?iso-8859-1?Q?efc16lYHLRH01g7nZPZeTL7mLNJjwcYeRlPZlVK9tDJYgeIhH9Q2lwZydd?=
 =?iso-8859-1?Q?u1Nw9pxjTJQBi0nB8e0Cmlr7+dm4s6p5qTrLqIVBdhpnp6O0XDE+feTDYK?=
 =?iso-8859-1?Q?fPHVUmnBa2aEKxIPvP45dyi+W/nmf0DUTjhoK9jNhMzltjMdEmPedXs8bi?=
 =?iso-8859-1?Q?5zriWTDLvFcVYzkcTI7Mur+S/wSZyQ1Fle/1zlrwHQfiGbyhf8enVaSm5L?=
 =?iso-8859-1?Q?gNeJLLAWJSbSDI7WcuurVxJzNfF5farZlC4fzitwOW51L1H08S0Pc1S1vg?=
 =?iso-8859-1?Q?9XC/RE78Rb5oovaTaRE6mCyWBdTsai/VcwjQbvtMvCimp9GaktswN6CkcO?=
 =?iso-8859-1?Q?vi9xSZOsq3ZHLyXgzZXqunwlgcLYCnTWEMfGRrXhnBTzFl0Y7PQG4i97Cw?=
 =?iso-8859-1?Q?KGRX3L3ZeFjMsHE+/wkNunfeayqKTbC5FZVbJ+C6dUvoHIieHuEX1n/Io3?=
 =?iso-8859-1?Q?QjA4eObUOZv/N/tSabacp5DPFb+qmQeOLEqMSeT1rvVbcWIW4SFWhLQGrL?=
 =?iso-8859-1?Q?3+bTdKe39RkQTOF6KKlLkZNp5F37w3VcKYnS0GXPPV97zUe3zWo8dLH8z3?=
 =?iso-8859-1?Q?86biaiWo8ObisXJSyIjWxhSW8KaMBjoy3BwDen2Pp4TiwxCxw+Ak0CuUNI?=
 =?iso-8859-1?Q?7Uz4evQZKY7Odl89vblSNweAhSz1dk5bN8cXkBFVNgT64PjFrFR7cp7tA5?=
 =?iso-8859-1?Q?cxJbBIfir7cbBlYuoHYQ8ELLjjukq5sT/YD/3drq/XhaF9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67266ca9-94f1-4bdd-3d24-08df4b14d407
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:54:53.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4eNZqaVsr984ciJKYLKPrxpSq65dDcMRcUyJr5CRvTFrPXE04+HfLt3PDL4yspGK0oKAIDubIJW67EzkFc51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 05:30:32PM +0100, Pierre Gondois wrote:
> 
> On 11/24/26 17:00, Yazen Ghannam wrote:
> > On Wed, Nov 18, 2026 at 04:11:48PM +0100, Pierre Gondois wrote:
> > > Hello Lukas, Kuppuswamy,
> > > 
> > > On 11/17/26 19:57, Kuppuswamy Sathyanarayanan wrote:
> > > > On 11/17/26 03:50, Lukas Wunner wrote:
> > > > > On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
> > > > > > Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
> > > > > > avoiding a NULL pointer dereference in pci_walk_bridge().
> > > > > How can that happen?  If it can happen (which I doubt), why isn't this
> > > > > patch tagged for stable?
> > > > One way I can see is a device without a PCIe capability on a root bus.
> > > > pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
> > > > pci_upstream_bridge() returns NULL. Native AER never gets there. Only
> > > > firmware-first can, through aer_recover_work_func(), and only if
> > > > firmware reports a PCIe error section for such a device. If that is
> > > > the case, skipping recovery for !pci_is_pcie(pdev) in
> > > > aer_recover_work_func() seems a better fit than a check in
> > > > pcie_do_recovery().
> > > > 
> > > > > Why is it at the end of this series?  Does the series somehow make it
> > > > > possible that there's no upstream bridge?  Which patch does that?
> > > > > If the preceding patches are not the cause of a potential NULL
> > > > > pointer deref, why isn't this patch submitted separately from the series?
> > > To test this serie, I generated and injected synthetic CPER records.
> > > The PCI device referenced in some synthetic CPER records did not
> > > actually exist. In such case, the kernel crashes due to a NULL
> > > pointer deferencement.
> > > 
> > > This use case is indeed slightly unsusual and unlikely to happen
> > > in the real world. The patch was still included in the serie.
> > > 
> > > Please let me know if the patch should be either dropped or better
> > > documented.
> > It would be good to include these details in the commit message.
> > 
> > Also, I agree it is fair to be prepared for, and gracefully handle,
> > unexpected data from firmware. A platform may report a CPER to OS with
> > the intention that the data is only for reporting purposes, not recovery
> > action.
> > 
> > **BUT**, we could argue this is a platform bug. CPER serverity is one
> > item used to decide if recovery should be attempted. The platform should
> > not report a severity that indicates recovery/action is needed while
> > giving bogus/incomplete data.
> > 
> > If the platform is intending to share data for reporting only, then the
> > CPER severity should be set appropriately.
> > 
> > Otherwise, this should be a big FW_BUG message "Platform reported
> > recoverable error for unknown device."
> 
> I'm not sure to understand. Are you saying that we should
> try to fetch/resolve the PCI bridge in pci_aer_handle_error()
> before calling pcie_do_recovery() ?
> 

I'm not sure where the best place is. Your patch adds a generic warning
in pcie_do_recovery(). It is not clear from this why the bridge is not
found. Is it because of a major hardware/topology issue or an
inconsistent error record?

To differentiate these two, you may need to do the check earlier. Or you
may need to pass in another piece of info indicating the source of the
report. Maybe a check for "native AER" is enough in this case.

Thanks,
Yazen

