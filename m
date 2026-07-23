Return-Path: <linuxppc-dev+bounces-24710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D12C44524
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 04:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Hb82wc6z2yVZ;
	Thu, 23 Jul 2026 14:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784779524;
	cv=pass; b=HRhG8+ZuhW/skqiP4flqt9sl2An6j5+Im/uY2266X6nr4DD9T5yp3WI+no/AzZbROZAVQRgbDdAc9ixSTky85h+Q532WdeXjKOhIoe09bP+lpdFAv5qYUlYA8kuN/InFCAx7IyG/HIdPk9MVSv2UkmtXml8egZVWmWOK3ooO8CqMiz1cGHBgiLNojZWsVdOTNgxiAej8i+S7R5Hh3sP5N2oECnzZo2XqsuOHvSnhMXE9XKOhG4RcpBfPWOHyrk4b3AAK6mlD9eDBaq6gpAbHoYaQTVrc1UcMmQxSEpBmmpDK8flepDXY8Ah8Nub8+/dF25SqO9FzlnmadizuMkxqTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784779524; c=relaxed/relaxed;
	bh=v4y7MkA7Q91Jm+1qdQGIIYW7VbIM1C36VBdb/C98rYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TQ5sI+BPzIpdTzYzgzZ/VLYnTviRLbO6wc/PXlTYDAwlDNysVs9e4UtPzYacFyJjpqS6MsqDmmVfejA2xYTsaB16EJO10CjRe75uU7ie4ozxMd9Tuvj5DrNA9PV+fBvf3CheXbkIp+aOFAlo85l+Y6PJoq92Qdx1dJsO9RWfh5xZUGw+SPdHd8zc5WCvWL1XZ8GyHg1z03NtZPcpJHhCp5ZKllCGTXuP1cq+uiSvvLk5ZBoyEaaAnssG0AspMvc+kfoBvsW5JgUmrVn+DIf5wl+XdZjS59JLnMV/CgA10wsfB3oOKRJ0pVgqgvjS0eA5477Nv1zC+INgyAk868yq0Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fqRQeuL/; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=icheng@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fqRQeuL/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=icheng@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Hb70PrSz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 14:05:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dS8qSQ4V1uqLEimi/XBmCy+jtyiZI8nnFXYKFx83gJFH/fGq1QohdRxto0DdUWUt6JB0dZODX2T/EfVFZSL8YNNbHmXCSHVikN1YcC0FWlhxf9JuQrfSUZxtRw4ggWMfWaMMDQEoeUWb+UrURDnYtD/tZFizTq622JCFjb5U2Th3NvHbEkpzzVfBLkFG9c/Plm5EqcMJjnazIUwkFgc7DxYBmkANoyvllOiUxsKsx55YH2eoyKA3CAIZk8+tMTlMF9Tkdl5DnC9+nivtVanT1uymJxfZyP/C34apIrP2O9zLuHdirh7o0vETnp+9tb0qhICvl2f57bJu12wu+YHyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4y7MkA7Q91Jm+1qdQGIIYW7VbIM1C36VBdb/C98rYE=;
 b=huqsVk9tjq6/uuvQ/g65T7h/RFxW8/nB0PDGURdNiYhJ7BxgKB9toYi2hjyVrpukBrQhQIerjynAgmSRAXj5fEDR5eclLku4Xh/AiYEnF+kr8Sbp12Ph/KX4rDE7gfyBrIkbJTeFuXOLTk7iBkdA9uLQ+JFQOdadd1bqZ4ghyv3QpYv7wc7hlm47ORwtCdjd3hszQe9cjVliQ2yEbGKqQDKCmwkCAJbaD/PO50MwVkPr/s4hyIhGWyGtG1GFi2Uf2tyIRq/W7Wu3ck/QpH4NMNziHCip6JjHaY7cMr0QfmGNl/qjdb9MC9bB4O9y3/uAIgbGzl86ndW8POusdQdaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4y7MkA7Q91Jm+1qdQGIIYW7VbIM1C36VBdb/C98rYE=;
 b=fqRQeuL/H5PO5nFXSijovmDWhDK7hgl6othWYLBCMfI6XC83qmbYcq9S6UuDHVaKBJJL0WBTAn6W9IEC4ycBBM9RkKqIk2j3rgc0EW3Jpf9YgpJgHJK5/OcFobmJKrIzbmdwu/BXUKg5GRNDxamq1J5QZJcRBX8gBiKre+KBSd0Onuolx3o3fAdN28pX/ySpAKAw4eAp2d77akgC0Rf8A9l4u8xZbRJRQaHEyIn63ZdY7ruPUekTov+fxx1QUqwlwcHRaahrNJhnInbBORL6HX+AQPwYGdEbg4n7thuwDg2+VBPUYRe1/FFh++MJ15Lx74FZZaKPSFt1bzRiLLEFGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 04:04:57 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 04:04:57 +0000
Date: Thu, 23 Jul 2026 12:04:51 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Alejandro Lucero <alucerop@amd.com>, Alison Schofield <alison.schofield@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming <ming.li@zohomail.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Message-ID: <amGQgQxa2P20wQ58@MWDK4CY14F>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717222706.3540281-2-terry.bowman@amd.com>
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cb60c2-a859-4cc7-e476-08dee86f8e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nXJGX1kQokdjlPR2doEIwJTAJX/fXWzwJ5kgLkLs56XvkXmJvKsENujHzmcwt5Sqyd/icIAqxvike0lN7NVIRWIzIp2S2OreZ+cWHKOCPxceWrwu9UG+ZDYCMC2kd1Pnef3+EQQWmydxIq9uCWOBhEKWxWl56gGiDfJ3CHO7qn2q/c0NeMUPay6zNZGCbt65IejwelOkW9kPW+RB3gfNcPhqoTQ//hXyNR+Vwa3yyjLdmMpCGgxIGPsZEFoVoNL8dcWj8Ey2XPwQUKkTKJbL4r3NIGh/fCBh1bXnMNbKkxBLNhrQzZhZbb2Rd8tQ78HUF4FmQaUqh1Pf5DZSJktDvAjmKuRvhbtJ7r27ZyWU9MWMbS4cw+2eKLcTFJs4tkCoKsdPvRcznyObQu3m3nsaOMbioGFjF3AmX4LeMUDAaYkHCsdu2RMmuDsXWAS8r63cuPm4SnRjUWEVIi3ofSm7ACMACmrKWl9y5aaaZl/YCajBw6fXvLltfsrIXnoTSf9LF/bMykic99CMGrrm7BsEbd7aK7NdYqMDYmpKu15CVDlLzXQzDFvf8vcrHMpYlSWkA6GeTAgwKOwevW5Au3/hWC34wfBrwRD4YzbuYuM0YVCYfd2cwJhQZD4OuJWHyBGpE46t5LQSpbwtNUDC7UQ616ds2wQfcPM7J86sEjvlxaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8FWlFnP5e4F3XIsrrVvYcxhCR75rBpo8ouSfyZt0LYVnmhzAR8SBTvHdmUWz?=
 =?us-ascii?Q?VrV2HEzVE99ypQ+7tlb4jsBnEa1iJZmLhf6w3MykR782mLq+fHLjY3JGpJlk?=
 =?us-ascii?Q?x4Xg2t3nU14QyoCvZxlz9Gk4N8rxb7f0KGct04P1VORzU1qpA8QxDbfjbCi1?=
 =?us-ascii?Q?fY7xf1ZHv23iJPL2Q2lEjrIHMPxcckF1tpgQ+2f+lX3CsmGhzlAP9MgqMaUB?=
 =?us-ascii?Q?p0k98/nMHqjVUZRj2dDDzLPdwUQCADGdftjQKCh8ie0CFEQF08wM+7yFW4gn?=
 =?us-ascii?Q?zM73EoD74tmmGWlSa7E4DmGuCZun8gtbzK8sx+/hMKtfeix6q/iGr2c6cWUF?=
 =?us-ascii?Q?fjvUcuF9EbmMZPoP1XDHDz7kP0ZuwYQKQ/H+2j7ZsVFORuOl4UOlMviSeiFc?=
 =?us-ascii?Q?aK8TmONMv/+cpTHJUWVgk9mExgI25mqqKtbakdkpEXRyzXJ3vVCSeJ21kr56?=
 =?us-ascii?Q?xjl1+6qoxeJAXm3qRe+9HmwSw/znire864zUnsv3AekR6v17K4qpz96YNkZW?=
 =?us-ascii?Q?1CnXLry3NsWuawzavu+Y2DtJclMQsgO5dcXHi6/W/QtPrTD8VZ2DRCgRN8dN?=
 =?us-ascii?Q?75FOEPmz2zd/jPs9a1DB77nzy4n57qxJSUJzdZV5Z9w7FHmqZkf9680Vp6eJ?=
 =?us-ascii?Q?27M1e90zhN6zraONK5S9u+f1BtPZmNJhEVdH5KYszZofMMCRUUbSm5IjwVSw?=
 =?us-ascii?Q?Xh9INwS0Vz8TgJyKF8qjTko0P4kBbTQJEAAJaMJ4PTaHwRrqJ11EzQNGvvVL?=
 =?us-ascii?Q?UgRgKlBBhXgMjlcldqJuPqznsu0rHo9pRBanPheSqmr4g+SrYcm11eEKjCTi?=
 =?us-ascii?Q?M+BFyJ14alVj8u39IjLoLQlKbHWpVFjoL810pnRQLE8RIoO8hSDoJ82Ujpp7?=
 =?us-ascii?Q?3DNz4ZfIohFzsue9VOuRIOtV6uQcYlIn8DTGG4IIMlyoEBR+uf8fQ4kiVONM?=
 =?us-ascii?Q?OKDQVkjC8B3cQvpgcPYRNFzsnGeN9bv2MnNW4qcCctSzef1WHXD1jsdAJcfG?=
 =?us-ascii?Q?IvZirxqbrJWQgnwsyUH4VvqZ7427Q6hddaVcLhWUTV3BBcwYQ3v/ZXHNo5ms?=
 =?us-ascii?Q?Q3GQqDPGpYL4Ln3GQygypwNNp0V7LMWA/pk4/Lla82f2UZd7qbZOEA0n0n0k?=
 =?us-ascii?Q?7RZtEJAPJjsT0t9mEqBbeSUYqqKJ9Nx73DaKdjN8182AZ1eklRFemXsgaT0y?=
 =?us-ascii?Q?rLCAtg//LCEC8C5Nx+RhI/QKIXGV8Q1RHW/LSFsXKa2CiVsWP164NIWk1W6q?=
 =?us-ascii?Q?Zs0t/9Dazq2e4qaQjk+tN3kxgSjY6hm2xHfQ0GZFKs/Q30X2wUgBAvTzRXBH?=
 =?us-ascii?Q?LdN/TFp9Z+7sLYmaJbv3MrY23gH9Csd4D3EliQOa09y64mqShJuy2mUskBm+?=
 =?us-ascii?Q?4V4x/i2XBM+xKLap3tvarwRp/rCD5nhFZdZ8ithUcsw7cVxQm5x1KmjEJKrl?=
 =?us-ascii?Q?BV/el66IJaA3+QeelM/Kwup9kjmo7oAM67OhcjS9CUwpF650YizXkwHaZC+A?=
 =?us-ascii?Q?ZboMCcQOAS4oBv/SvGYvXS4b0OK7rqePJNJuEukbxR+XgxWPr7b7Nn5HH2bA?=
 =?us-ascii?Q?090g7boWzGI1Xe2pPZJZh1hgxPiPMX2JXIBVrgrbKoVgHKSfUOfsb4ZrXqbn?=
 =?us-ascii?Q?4XWZEsfWRtqxgn5EuEe7EjdypXbggf/7inlh4kyZvaDEQojfcBtU7U29wtK/?=
 =?us-ascii?Q?/Rk9mhvJ658vm7E39MbWJS62VdydX1rU7YZ1LI3Ggx88obRfDUv0/c689uoU?=
 =?us-ascii?Q?PyHR2flCTw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cb60c2-a859-4cc7-e476-08dee86f8e6f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 04:04:57.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz740va/ISYZ+2J34Dt5IDQ8DTKtS4oLN3m8IgVSXrg2svjo5wjL1A3Z1VXNi55ENh1+ZQMGwrNgbBvOL4slhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

On Fri, Jul 17, 2026 at 05:26:54PM +0800, Terry Bowman wrote:
> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
> 
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).
> 
> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/ras_rch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..44b335d560708 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  				     int *severity)
>  {
>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &
> +		    aer_regs->uncor_severity)
>  			*severity = AER_FATAL;
>  		else
>  			*severity = AER_NONFATAL;

The logic looks correct to me, maybe the small tweak would be cleaner ?

"""
u32 status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
if (status) {
    *severity = (status & aer_regs->uncor_severity) ? AER_FATAL : AER_NONFATAL;
}
"""

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> -- 
> 2.34.1
> 
> 

