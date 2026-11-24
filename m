Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CE606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XfE3/P80
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYnbg0djnz2y2b;
	Wed, 25 Nov 2026 03:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795536063;
	cv=fail; b=GnF/4sfSO4VNDTBPQmdLZaR9dRnZhyGalz5XIbQ1K3Ynbtx4YEPAXjw0EE/CX2e/NSysMcni/MXOddevc+yEffd0jQa0v6CfhqC43ymR7JaKh/UpMPFBKsVzA+gEzTFGUha8LItO5f+PiMZD0qkk3GSXMgsslE8Zj+iWzybprfCYPEpDW+AsDYWhZNpI9cNPvj/76aTysowDuQM/TPw7jRPfW+vc8d/J6sPAjCPWCKV6xy3ZGsxuZednH6OVNUgeV7tYQQIOjPKPSHV5hqO9HWrMJIuB20XvhzV+BqFS/omPQsdlLHr/M8uAxrib48fBM/s6BeOj7uRPOwbaE/j/FQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795536063; c=relaxed/relaxed;
	bh=rRBaB7WYu+ls0BKj3u0eSUgVkg2kIRpTcJ0/+N7ZGIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iX8tGWzKQSyJM4CwdFBCwftWuLx9rl33g74o3PHPsMDxNMClZ8L+MYgBNKuWC5tWSG0SaMT5GrevgoFxbi+gtu3YwueVGmWqAW7tILF+7mKEEcw8jBY1mibGPayDs0prOXqPsTXQP+jSADr8WtJuca/RvKAan29Ghcvw3XS4pRMesk94Ou6iWc2Fe6ZNTuXCUAsf1fPtSm+rQFzgPRyIt+BllNW1pDM5sl2VaSRJvW6b5CV5ZDyxYYlQZqPYHc3t/j9iLg66e8Zynz0jrFaKw9MWlCDjzo4+XA5Wh3Z9kyqu2Kd3Dl1N4eUWi57Zd//iRruiZ0GGaWYmnMwspEKmyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=fail (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XfE3/P80 reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=yazen.ghannam@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XfE3/P80;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=yazen.ghannam@amd.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYnbd32NWz2y2L
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:01:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI0LncNLndywASC/RuOhulJ+MjHU5gjyH7nROw0rfJgISEZ/chEpeP15J11lIolN48CfzrcezhdJrtJWzEniFfeDQK7pG5Pb1CmjppK7AtIncgUeEmbwXGsTEhiWxvCIuoTr/l5b1TPyzRojydo0QP/bh4tVlvIlXhdCfnJ9xHZv0r2qoNK1HMIegmkFxUQHJ5ZonHl3y00GCm6oSQzkHVNG+PIXIjb9bKLRqO5/r8KsCRSY52BEwpjRHeZ7psmANWPxFevY0xS4+EPFlXew5NTGgvwqZCi17em3YQMka1QrzdMqkudkQ9V3zEdrnWJiVjIgJSx2NA/62KaaP30UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulTQCfn4Zv2P3OBeSocDTu1CVER4kpZ8oR0dsYj4zdo=;
 b=T9NZjRTof0OWO0dZUnOhPPr1tebjSfucRsLvqg8ffvjWvCC91VFLma5mA6p+7Ke2kV3DYvlTPfOYsCmipyf+46xAD3iYlHMxj3CA+hzkUVKdVQQ6PKm08BZRdng14HJA87vE1B1uVRvBz9o9krAPdHjG2IVifRtKyT12XryxG6Hy1RjCRGXKQU7pWA1+9iXYKFB6yZG5ZNtXCNER+u8nS3ggd7GeY6EQ1s70T4VHr0NBXpFsp13KcDPOq0x/Ff39+IadYS5JfiYsDMV+lpaS5cSvmGLcPgjIen3LHZAOSVRscek4ekudcmv+TLc+OZ6B3NMsKOvmKkT6q8RHDpobQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulTQCfn4Zv2P3OBeSocDTu1CVER4kpZ8oR0dsYj4zdo=;
 b=XfE3/P80YmMUEQQ8hEoidIoAANdIgNhv0e1Ggdt5EE1EeUWAXOtqRDN9wfL20HOoCHASeeKQ7twHFi8bvrEv2Z/tQ88tt9BSJ5UrcI/vbJrnwKJqOKSglKEhOVfjMHmYdZ6MtziIgBznskZPLNzs3T/PxhIyq8L4MWSJw6HMV9s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by DS0PR12MB6534.namprd12.prod.outlook.com
 (2603:10b6:8:c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:00:40 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:00:39 +0000
Date: Tue, 24 Nov 2026 11:00:27 -0500
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
Message-ID: <20261124160027.GC2156781@yaz-khff2.amd.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
 <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
 <ba5f649c-f338-40d1-9e85-b666590835ca@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba5f649c-f338-40d1-9e85-b666590835ca@arm.com>
X-ClientProxiedBy: BN0PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:408:141::25) To EAYPR12MB923140.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 10951981-e8f7-4a18-f27d-08df4a441606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|261102123227099003|11063799006|4143699003|261022105027099003|261021121427099003|56012099006|261026140227099003|261009223027099003|261022075727099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lTDt9k94kj+0gcpec1YkFhkDl6ZTCCx3InHtFG8A5NyCSDaL+Ywmk/7hFZMKXNdzSMB2WZDDV/Q2fcuzVZcnbseCkX5wwh4y0wX5DwVDOe/iN0WIXrAAt+3BgfnfTbGGxX3MJx8cJjCHLTCCZqyEc8Ki6V5++9pVe1H3bigIO+IRzU35EMrDSPZL+zv4H18RSriHO8B48q+0tKnq9WEyHI/DvpJBtlRsIGEpOsV6zuseijP8peOF1cAQstkHaYgN0XVw5BfYbWKq5mLiIVITOIHwtmwhmv+D4sZ8PoHdlvefU4yPRInRNXDV+S+95lHn+1pV+UONDf7CWaH2Ap7KrbV4ZIzouW9laEynYFu4ynhwOEuE9AxTdOfWyQP5c9mvVxxjW6oQm05kECe23JBaEq00lS2BtUh1w3hc4SVTEt1kcyrnfEcOInmGcJwOEEk1+yI0Vxx02M0WFLKV9s/Gx6hOxkyQQvezT/9PBDJwHMD9vvevOS04Ga2j3lAR/XB0vepElSQzjZ99ZRFYUtrH8g8z/ZNYRySLo/8rlHT0zSSVM2XuVj2nt2/1a75msc2yAPfB102wRAlqoql1XLfxi06fZJFjMn+hsM05MYwN/PMEpc9f8Vp+zVdDi8WrVb3CilfpEmT97+AoxyaDLUMFa6Qeu0Dj2/JWRMnNTYVwiwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(261102123227099003)(11063799006)(4143699003)(261022105027099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003)(261022075727099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SK+RSzlCwDl6i6WXBsu92aQLO5owT6Cfna0JXAPBoEPKZNJHN/bA7xE8iD?=
 =?iso-8859-1?Q?DHGoPlU6WrYwIWZidGs5jq2cjKOsQMHzgjZdDEZ0i2XP/MtlKzw/hImcnA?=
 =?iso-8859-1?Q?7Gq8iqTx20aiOxiI+rc1FiIvUcaEBtB5t6sht7hkq0RRWQPfart/g9xjhT?=
 =?iso-8859-1?Q?N09c5AKRwdAw3QHwQZsipMODxzaFGRyyGNy3GQBIrUfvMoCtkzm5CPzPcr?=
 =?iso-8859-1?Q?1nRKjW5000F5B8HEtnGyjBTgk6FruZJG9UIcF7s7GX3KVTbOd7LDQB5Z9Q?=
 =?iso-8859-1?Q?ABZptiflALeLABTwzcV5bgl3RUvZzKdU2/6+t5nMgd0m1nsv/Lz5/GrQ+x?=
 =?iso-8859-1?Q?wbw9BqEry1/CzSsGB6/5kLGDtTdpO6BstLZENo9S4e/fDBtaNXFnt7RK4P?=
 =?iso-8859-1?Q?L3JXBng0T4W2EQyoOLxP06A+yqxM0Cl01ViQybYl1GsCDHmuMNuRukq45k?=
 =?iso-8859-1?Q?Xtw8rkjvRFSu3YcLNWs6d4VX0EgtkfZQ1o7RA9KKiFbJlsWYemVSJuMKmL?=
 =?iso-8859-1?Q?Kub4reKQvCtE5/ZHgCZkkHjyac1sBMU16ovB8HbEvzmi3yZFrOYKMyK1Bl?=
 =?iso-8859-1?Q?m5Ot83p3CXIS6M2CgYeHuqwQs7HwVHvpZ0GnY9LmOa0WSzeAae8i5g+QEl?=
 =?iso-8859-1?Q?Y7p4uh8n2fiPyjx8QMMlT3tjg5VtEso121MPqRvUovSDr+z23QetnbtXpY?=
 =?iso-8859-1?Q?yFyTvAsWAwvhZoI/KyaESfQuqGjOWhY6SpHKa18M77xbFxEZGnBttUZ3YB?=
 =?iso-8859-1?Q?rWRLCAVD+FGVrhqxwjh9To82tmRUoGp0lhBISoQnJ6Yr0mvVrJ1w95rMIE?=
 =?iso-8859-1?Q?cSGjr13Ci2To/RIqw0lMaaqoxLdUILZfdKbXJTmr90z63v7pjH+OSTl8T1?=
 =?iso-8859-1?Q?ge/W/xtT7eXcmBvHDZRWhNSEVa51r4UIKr+tVfMy84KJKO7isv0qFZtDZ8?=
 =?iso-8859-1?Q?99LqHlCXBTfDKmEa1FlGrh8KZMM3qndBqptskFHsWDpG28VyYKFfPEr7JL?=
 =?iso-8859-1?Q?5nhb7jgje9paiTLRUlMhUfxZ1GawtqD5JvZJqWq9GF+Jfro2f9ZINIa2IM?=
 =?iso-8859-1?Q?6h5rNva5R7x10Igglbepxk+inI9sFU4chRCuUvHk39cf24Vx61aFNf72V7?=
 =?iso-8859-1?Q?C+NxB8TBH5/Rscxv/yb8EdobW4D8vqy2ZQrDNWPP8P1a4sGWJwYJipW+E8?=
 =?iso-8859-1?Q?4Ney3qBK7UCC8f0dy92fG+7zGqtcmN+PTTZzoTV1qk9M4MyHxUHrdHDszX?=
 =?iso-8859-1?Q?FLepU8Fg5tQHSPYKIPfJMfwi3zbX2eAQ/AjVKYr5kt4GSHKs7c+trQRykK?=
 =?iso-8859-1?Q?OgQKU6LVQ82XOUi+SDMwRJSN5qvGNHtQvuuerNiuMvbjMyhLSaH6RxJSOk?=
 =?iso-8859-1?Q?vwSIRqqem7NMhz1p60KBAV5ZCwVwegRIWYuZ86UnDc/P9BDPs0KQABAKb4?=
 =?iso-8859-1?Q?w32c3F43lWcf0FnfZhc3nb6bmj2dv2wJI0kAk27MRPjj84He0FwThX6iP1?=
 =?iso-8859-1?Q?X2OPBtQa1FD/Uy+mrb3A2dcfKXGW4NP7ZNilF6ys5j1C7P6ytorYa/gMKz?=
 =?iso-8859-1?Q?iPcOTxJ7Si+zIlTKO4Ml6pypQbzzSeIEai/AT3sIb8n7rxiuk+sVSVlHUf?=
 =?iso-8859-1?Q?HOuvPeNr0qvPoBmFuvOXyCu0+j61I83wNSheEoL1Q7drEOXRoPikXW9C08?=
 =?iso-8859-1?Q?mtpi4b4YiTADeX+JKk0EVY7yygRFqYQcsG6on1ani9FnwKCxZn/v9+Wqyz?=
 =?iso-8859-1?Q?oV6m3PrflGfgS2cJKZ+hCJtYzp/+Mry5a38IQ5NTPz7xRS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10951981-e8f7-4a18-f27d-08df4a441606
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:00:39.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hJc2evLQHIgD6yOYb9YcUtWmUvUisLepy9gvVoeiipE5q29Z10xezRNiOcTELDa2Lssgo7sHy4T9sWUlbxamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 04:11:48PM +0100, Pierre Gondois wrote:
> Hello Lukas, Kuppuswamy,
> 
> On 11/17/26 19:57, Kuppuswamy Sathyanarayanan wrote:
> > 
> > On 11/17/26 03:50, Lukas Wunner wrote:
> > > On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
> > > > Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
> > > > avoiding a NULL pointer dereference in pci_walk_bridge().
> > > How can that happen?  If it can happen (which I doubt), why isn't this
> > > patch tagged for stable?
> > One way I can see is a device without a PCIe capability on a root bus.
> > pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
> > pci_upstream_bridge() returns NULL. Native AER never gets there. Only
> > firmware-first can, through aer_recover_work_func(), and only if
> > firmware reports a PCIe error section for such a device. If that is
> > the case, skipping recovery for !pci_is_pcie(pdev) in
> > aer_recover_work_func() seems a better fit than a check in
> > pcie_do_recovery().
> > 
> > > Why is it at the end of this series?  Does the series somehow make it
> > > possible that there's no upstream bridge?  Which patch does that?
> > > If the preceding patches are not the cause of a potential NULL
> > > pointer deref, why isn't this patch submitted separately from the series?
> 
> To test this serie, I generated and injected synthetic CPER records.
> The PCI device referenced in some synthetic CPER records did not
> actually exist. In such case, the kernel crashes due to a NULL
> pointer deferencement.
> 
> This use case is indeed slightly unsusual and unlikely to happen
> in the real world. The patch was still included in the serie.
> 
> Please let me know if the patch should be either dropped or better
> documented.

It would be good to include these details in the commit message.

Also, I agree it is fair to be prepared for, and gracefully handle,
unexpected data from firmware. A platform may report a CPER to OS with
the intention that the data is only for reporting purposes, not recovery
action. 

**BUT**, we could argue this is a platform bug. CPER serverity is one
item used to decide if recovery should be attempted. The platform should
not report a severity that indicates recovery/action is needed while
giving bogus/incomplete data.

If the platform is intending to share data for reporting only, then the
CPER severity should be set appropriately.

Otherwise, this should be a big FW_BUG message "Platform reported
recoverable error for unknown device."

Thanks,
Yazen

