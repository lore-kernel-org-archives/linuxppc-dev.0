Return-Path: <linuxppc-dev+bounces-24713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D29C4453C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 05:47:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Krb290dz2xrL;
	Thu, 23 Jul 2026 15:47:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784785631;
	cv=pass; b=FMVVZ7OmfPxu6+SmfQxXi8C4p9BrveNbo8pbgCJ8JmzZMc3x/va08+ouqA/TRFKl6kp4SgtnMGznfEM5Twndd1aaSu8Om04O5he0qg7AWNBPvX3H0V10CsihfeZhpzi/3t9813MEgsS8QZkpJOIIdIt/go9MIrHhssJkU2ufocmmdf4cxsr83sS/AQ0gkRvlb1lJkKleWCqaQQ5Pmg6dKWq4bKWTm8ZuW2iiHeXySoMAuvpnZNCLg559dDVa4wIqmIEDhPjUtViVD4r4KxUn+GfDDPBUMqGmQDCt38x3JDAsRz+QeA0+ez2fL0tB20ba359scNIV4aOtuGYneJPQmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784785631; c=relaxed/relaxed;
	bh=v3/jUe+w412BzrWS09WX5IqsJMvfWtznT1Sgwqck5L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3nFu+0QMpbpG8B7vkREUFDERfap7U9qvq+W2sHxF/rBlg5pKXCnLllu+mpqgOluZU7AdkP6YX3XbZfSU0SWjByB4iSAG5YPMrql8aUfd+JukSuMd6gtsnkHjtPFOEaMp8INi2QzeB0T2bE6Ndn1oqn0+T/CijQl0blaimuzX/kiY9raXsR8mKvf5pY5ZAmOQ1ywZe6+HmDAX3HK3bQ7o4cLxF71eMFI7nRwUTFrJTxG3+7IX09ID2XFWDOd2NkNhOPltV3ToqmMeh50c/P134cSD7XdcafV5qIaOSMMFnEOvHHxIM5Ma1KiVo8rVAt4qbKd9iJ6I7AsJkph5acqgg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e2pM2q4H; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=icheng@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e2pM2q4H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=icheng@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5KrY5WtNz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 15:47:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krdzc6lE3USZgZRjz8XrurCTgkb0P5hvGPYispZZAsvHoM8BZi7eVTfSOvARE85BiGBhaPZ7KfivHxDRnYE0FpDGirPrLl4yBKQJgdkw6QquXzkob79YmJkZhC6IYcl/9PyYTxm1ggvmerleUMqVVsoyxUKlrY9P3cy37wuUtEY+9B/ZHwejkDc4hB+Kio7c9asxbPSlH4p2oz23+4DrsApHPxmQUQyadKXhUgXBwr74Eey1nso3bjeU8u/5ju/3xrcAVlzBowHLQ4gQ2owNVd/uoy5+Jqi0hP2PtZ/UxDKle2JAM2QtXvZN923mCevceRqlzheomIQvtaVd8/6PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3/jUe+w412BzrWS09WX5IqsJMvfWtznT1Sgwqck5L0=;
 b=L5G9FLxAjpNS2a0nBzlMACa9NrZEmbr4G53Vqd0xuk1Nh4BHcO9CyB7NmHy8VX+91V9LA3n+XOOYo9DTCSQ5WvB7NI0HLHOkMUKgVsQzCDEiF5Tc1m9XlkbrO2if2n4iq8S8gpn7Dxm2hXKTANEhXWhX6wFpEZPR2tCUn56HfUJZ1zH3Qek2GuY8NIhlRcWknWuLu0xV1Y16G8PRpFgX10E5YMUJJ52aOvrvAY/W96HCn3+k5sdL11IKOGmtd9FdiY2DxWrt0UeojIZh2PfTp5lyyqvxYEgPv2xdQHKt44xxA6Nso0cwrK1PQrSWwCfDDqG7qhqcFMmhwDRcWhhaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3/jUe+w412BzrWS09WX5IqsJMvfWtznT1Sgwqck5L0=;
 b=e2pM2q4HRaIajLt1mL1FYmUABazI8FJvqy3JIA0NgdXXl0bpoP1f82BdXJ2C+RwmBliaz/q5N26efGe2sEkFsE8NeI+X0jZvtUMaPnnA83a++rmnjssLzJm4OM1ekbh7cEdu+IqnCdjK75TB9732hngW32w+LArfKCmtzOcrMr3lzGczB7E5kcEqSUenoHtIYYPClZJRJgs/eNfEzRSRidkA3kSyNtDrhGNqE7Vo8LOo5KNwgST5gC4V7yBgQt7zEnUDoZUUTSzSBnKdiiJULhQnk9bYc4VkziF3VU6afdPiM0lkWxlCTl+WWi+e73gfk4sh1Ke05ny/tN7jVnI2OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 05:46:35 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 05:46:33 +0000
Date: Thu, 23 Jul 2026 13:46:29 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Terry Bowman <terry.bowman@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len Brown <lenb@kernel.org>, 
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
	Vishal Verma <vishal.l.verma@intel.com>, Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v18 05/13] PCI/AER: Introduce AER-CXL protocol error kfifo
Message-ID: <amGpjXNJbiJX5HTg@MWDK4CY14F>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-6-terry.bowman@amd.com>
 <20260720234106.27e7857d@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720234106.27e7857d@jic23-huawei>
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bacddb-cd55-40a2-469f-08dee87dc0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	11gV/1czXQmSpYmKCpF8Zn6eX7t/mSG7bGgSO+WaisogTnQjr29vqMX7VOu2w9WTQtuJOUdWTrhOF2aoQ64MwVjhuLJkeuuGMCU1K9tVGUGbZkX53JoUG7GQK0ruo/QH3zVA5Oq7s68ncbDZOtR6qnZGFphzEIiVgYq9dycSwfjW73FFwBBtkz4jNMwj/lKxhTEkw/r/KXPgmHPhoVAZvuxOlC4nmB7uMFmJm+IGRVFmqTgf+L/rPQ2FuoZOyc6WAXaf2TltG2wF/Qy2zp6WobeFHPhaDOsLlasE9ZlTMnNF1cYN/4D3E+yy2GDgT2FakuQhYbQkeRLoZBl6i32pgqY4ma4jLlcKdq8PVAEKgywMqQvWBOPq/jY5ptp6bmUXrDk6D0HP3gHjtc6aVxiGEvTae8CcCH7eVlJPfU2QzcoVh4WzxAOK8iOu1ibftneiuLm5oJY4v0owLrAUGmvhkn01A+FOK9aP9FJWYil0URR7aZkl5DLnF2P/Wh80S+D3uiOlqEdvvIUeDRWbMMA+oeB1DEbeGTlNiKlurRP3ZpNgwwAFWcMGGNvmcuGotYWi5FxYSJQRfgXDYjgZGrpcrnUZw9Jwhmg4QmW2Z0C44cNaCXKXeeOIiYiviXtQQoZS3GLGYzruUKRDJcA84sYhmdyvJZMmM8I1ppLTSF/tPdU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHuTwGMI7p35yszAnm1uNetiAKa1VjH5l2reEX7x8dBuyszKub/4jckKyRgS?=
 =?us-ascii?Q?kwvUNgNv+b64StCvMKIeJyzcaCzpc0L0fLFuZGTLXUFV+g4tvnZ30bekD/H4?=
 =?us-ascii?Q?/Z5HjhgAy7ScMFQjzDHnEjD79icwwgzD5+yDJfOytMU5ZHjGxL0/LSVZyNDg?=
 =?us-ascii?Q?fH3/p/U8HI8LvsV44KDCdI5fnRMzBhb8934l9+fQTDI/tq4qyMgH1a6dpzBW?=
 =?us-ascii?Q?6ccd6f/oYmeICYscFcAwRFe93iBeZ00HxDvA2he9czkgODTZjBems22ZSDPL?=
 =?us-ascii?Q?tCUD+XjEp6HDF+Vioo/sFKUIDpK8QgiOLJ9wGeF9OXltyN7hysrufSoR8cFF?=
 =?us-ascii?Q?O+XDaa4/rsS9ucB81B4PbRK0HdktTp0TNafMfX1RqqlQYsJn7nhdCwpAE5BQ?=
 =?us-ascii?Q?6e5cInsDyFt7HANgIJCRk5y8OhxKeLNo9JoWbZdGt14QeEN5RQX/M/6t3QlU?=
 =?us-ascii?Q?pmtmmCKDF85n+KgA8gFc9+KmEDhkvbI0E8aa3Xv0jI63suWJvfMs874J7mQz?=
 =?us-ascii?Q?adwb8DNc2U0wCIhd0ca3m15yQwq9LtAKqrvvxyiOljYtRpUbVB5VH+78SnjY?=
 =?us-ascii?Q?1gizU7JdXn2NXliW2okDm85aMsDB6lbLCACBYhKh26KVWlRpq1qYPrC8+dux?=
 =?us-ascii?Q?MAtctFTLtr1NvBLt6VgVQorMlXUdHHabwfjgA56+/D/qklRshIVqxmbXZb68?=
 =?us-ascii?Q?Fd27deI/MsDcuF+JpgrCIbx+4qHhbcXhi/IIPem+msSX0vlGg/e7FWiUkwYc?=
 =?us-ascii?Q?BSNW0fdB83UL96mqJfpH/w1cdyEiLIER13nmx6wASQqb/O2ZeNM7Sdw434Fl?=
 =?us-ascii?Q?r3MAjamQmRQrAz3N8MMYIdOz+3HyLFO7LgFx/f8fwZo7u438kW9GxXJgkE0H?=
 =?us-ascii?Q?eMwwyZikeZgOzcNBckLyoAbZ3SOar9uRFVRe1gZYxAyoMhKzavmi9rAk5xDb?=
 =?us-ascii?Q?iW5YlMvc+VzP++2ydENg+sFnIJ+e5DI0RPXkib5laMXdieqUu+KsqmLLZy90?=
 =?us-ascii?Q?PWFQRAwK/gOBCqW8CISruFFl+RmKgQpGluw6Jl2ssvxVmCkz5yx55d4ZNrjC?=
 =?us-ascii?Q?xh04lHDGjFsS9kLUl25i6U4IySLNopTjPJmwgI6N+zKbxl3sX3ZMVcCculFl?=
 =?us-ascii?Q?gLE4CPVTc3Y54JxZMFw8TcJxlo3nVqwIuld2R6tRQsZkfk5FK17xN58FzxYu?=
 =?us-ascii?Q?Ag5ILMr4b9M60IC538LJ/WMJ+vI9xPTmb0wWqsMEtAaQQZWPZf1mBkrwnMmX?=
 =?us-ascii?Q?FhawsW9B2jcM/oEj+qC0YRFzRSWHwKCbsOOGHB+EpjpQfsbDs0us8mjmXILk?=
 =?us-ascii?Q?Q3noHbNBa7AZAUjYUjtNLM6Powm7n9NxGkq7ru/N9ciD6wH/yZQRIduwuEjz?=
 =?us-ascii?Q?1W+cQZFZ0ws1sN0+RFSKN/ipuTRGK33eGDa4pd9QF+z/Ad5x2Y5AzldCAI/A?=
 =?us-ascii?Q?CZbN6nlTZe6kFENHcV5hKcaMgCNZ/6SR0RW1dS75WHEBL5Ky4jPF5bKoWCLJ?=
 =?us-ascii?Q?1nw7yoDSjV+Kaxta7DB0sVm7C9KK4XNpOnLT1R4aLU0MlOc8izL5nt13biYm?=
 =?us-ascii?Q?CWAouRs+Qg3wKHxG1i6KX51oQWCaZRKoI9WlqEvCw1ucQorUY0EhtEEbWJZm?=
 =?us-ascii?Q?3vdzuKTWgbHn+/TkKDNneKGqoQ1agQd8kUGD+3KfYvlkhPXphtHMCcA/9zKY?=
 =?us-ascii?Q?qHOMlGn1q06oURpgubnmwOAB5GEqkX+SX3aZ5mMO/BFoelVSA0YIQu5X83u9?=
 =?us-ascii?Q?gmk+eEwYDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bacddb-cd55-40a2-469f-08dee87dc0ba
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:46:33.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X209uk4pmH9Npe6hkoPIegVDd5b128gjsOyq0hVHZKLHsuT3FlJHrDXXTiLpWDxoWSydK9kXOROA0l/xg6tPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

On Mon, Jul 20, 2026 at 11:41:06PM +0800, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 17:26:58 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> Hi Terry.
> 
> This is a rather length patch description.  Might be worth
> a parse to see if key details can be covered in something that folk
> are more likely to read!
> 
> > CXL VH RAS handling requires a path for the AER driver to hand off
> > CXL protocol errors to cxl_core for logging and recovery before PCIe
> > AER recovery tears down the device. Add
> > drivers/pci/pcie/aer_cxl_vh.c to implement this handoff via a kfifo-backed
> > work item.
> > 
> > Introduce is_aer_internal_error() to identify CXL protocol errors
> > from AER internal error status bits across both correctable and
> > uncorrectable severities.
> 
> Already existed. Just in a different location. 
> 
> > 
> > Introduce is_cxl_error() to gate the VH kfifo path.
> 
> Feels like to much detail to me given not really anything to say
> about it other than the obvious.
> 
> > 
> > Introduce struct cxl_proto_err_work_data to carry the error source
> > PCI device and severity through the kfifo. Encapsulate the kfifo,
> > per-producer spinlock, registration rwsem, and work pointer in struct
> > cxl_proto_err_kfifo. Initialize the embedded kfifo via INIT_KFIFO()
> 
> Can we cut this down a little where we don't use useful info. e.g.
> "Initialize the kfifo from a subsys_initcall() to it is ready before
> any producer or consumer runs."
> 
> > from a subsys_initcall so its metadata is populated before any
> > producer or consumer runs.
> > 
> 
> > Introduce cxl_forward_error() to enqueue a CXL protocol error. A
> > reference is taken on the PCI device; the consumer releases it via
> > for_each_cxl_proto_err(). On enqueue failure the reference is
> > released immediately, the error is dropped, and the consumer is
> > scheduled to drain existing entries.
> 
> We don't need to cover error paths in the patch description unless
> they are really complex and need explanation. Even then probably belongs
> more in comments.
> 
> Anyhow you get the idea..
> 
> > A subsequent patch wires
> > cxl_forward_error() into handle_error_source() where correctable and
> > uncorrectable status clearing is left to pci_aer_handle_error().
> > 
> > Introduce cxl_proto_err_flush() to synchronously wait for the
> > consumer worker to drain the kfifo. A subsequent patch wires this
> > into handle_error_source() for UCE events so the CXL plane completes
> > error handling and panic policy before pci_aer_handle_error() drives
> > PCIe recovery.
> > 
> > Introduce cxl_register_proto_err_work() and
> > cxl_unregister_proto_err_work() for cxl_core to register and
> > deregister its work handler. On unregistration, pending kfifo entries
> > are drained and their pdev references released before
> > cancel_work_sync() runs. Export these and for_each_cxl_proto_err()
> > via EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.
> > 
> > Protect the work pointer with a rwsem to correctly serialize
> > registration, deregistration, enqueue, and dequeue against concurrent
> > AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.
> > 
> > Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
> > the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
> > bridging code.
> 
> Various things inline.  The one potential thing I'd like to highlight is
> the loss of tracking assume panic isn't appropriate.  My paranoid hat
> says always go the other way.  If we don't know we didn't lose an
> uncorrectable error panic.  Maybe it's worth us considering when this
> might happen in a real system?
> 
> > 
> > Co-developed-by: Dan Williams <djbw@kernel.org>
> > Signed-off-by: Dan Williams <djbw@kernel.org>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > 
> > ---
> > 
> > Changes in v17->v18:
> > - Remove correctable status clear from cxl_forward_error(); the AER core
> >   clears all status bits via pci_aer_handle_error() info->status writeback
> > - Schedule consumer on kfifo overflow so existing entries can be drained
> > 
> > Changes in v16->v17:
> > - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
> > - Defer the handle_error_source() is_cxl_error() switch to the patch that
> >   registers the kfifo consumer to keep each commit bisect-safe.
> > - Rename rwsema to rwsem
> > - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
> > - Add work cancel function.
> > - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
> > - Add fifo_lock spinlock for concurrent producer serialisation
> > - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
> >   kfifo->mask, ->esize and ->data are set before first use.
> > - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
> >   device is acked for correctable events even when the consumer drops the
> >   event. Uncorrectable status is left for cxl_do_recovery() to clear after
> >   recovery completes, mirroring the AER core convention.
> > - WARN on double-registration in cxl_register_proto_err_work() to make an
> >   unintended second consumer visible at runtime.
> > - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
> >   in aer_cxl_vh.c
> > - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
> > - Update message
> > ---
> >  MAINTAINERS                   |   2 +
> >  drivers/pci/pcie/Makefile     |   1 +
> >  drivers/pci/pcie/aer.c        |  10 --
> >  drivers/pci/pcie/aer_cxl_vh.c | 221 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/pcie/portdrv.h    |   6 +
> >  include/linux/aer.h           |  24 ++++
> >  6 files changed, 254 insertions(+), 10 deletions(-)
> >  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> > 
> 
> 
> > diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> > new file mode 100644
> > index 0000000000000..93bed07936100
> > --- /dev/null
> > +++ b/drivers/pci/pcie/aer_cxl_vh.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
> > +
> > +#include <linux/aer.h>
> > +#include <linux/atomic.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/init.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/rwsem.h>
> 
> Check these.  I'd expect at least spinlock.h to meet the rough include what
> you use aim.
> 
> > +#include <linux/wait_bit.h>
> > +#include <linux/workqueue.h>
> > +#include "../pci.h"
> > +#include "portdrv.h"
> > +
> > +#define CXL_ERROR_SOURCES_MAX          128
> > +
> > +struct cxl_proto_err_kfifo {
> > +	struct work_struct *work;
> > +	void (*flush)(void);
> > +	struct rw_semaphore rwsem;
> > +	spinlock_t fifo_lock;
> 
> Ideally add a quick comment to every lock to say what data it covers.
> Kind of obvious for this one but in general it is good practice and
> reduces chance of later scope confusion.
> 
> > +	atomic_t flush_inflight;
> > +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> > +		      CXL_ERROR_SOURCES_MAX);
> > +};
> 
> > +/**
> > + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
> > + * @pdev: PCI device that reported the AER error
> > + * @info: AER error info containing severity and status
> > + *
> > + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
> > + * item and schedules the consumer workqueue. Takes a reference on @pdev
> > + * that the consumer releases after handling.
> > + *
> > + * Return: true if the caller must flush the kfifo before AER recovery,
> > + * false if no CXL error handling was initiated due to early return on
> > + * error.
> > + */
> > +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> > +{
> > +	struct cxl_proto_err_work_data wd = {
> > +		.severity = info->severity,
> > +		.pdev = pdev,
> > +	};
> > +
> > +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> > +
> > +	if (!cxl_proto_err_kfifo.work) {
> > +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
> > +		return false;
> > +	}
> > +
> > +	/*
> > +	 * Reference discipline: the AER caller (handle_error_source())
> > +	 * holds a ref on @pdev for the duration of this call and releases
> > +	 * it on return. Take a fresh ref here so the pdev stays live while
> > +	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
> > +	 * drops that ref after handling. On enqueue failure below, drop
> > +	 * the ref we just took to avoid a leak.
> 
> Most of this is useful. The what we do in error handling (given so local)
> probably not.
> 
> > +	 */
> > +	pci_dev_get(pdev);
> > +
> > +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
> > +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
> > +				 &cxl_proto_err_kfifo.fifo_lock)) {
> > +		/* Dropped; no panic - UCE unconfirmed without RAS read */
> 
> Hmm. That's interesting.  To me it fails the normal ras thing of assume
> the worst if we lost track. I'd panic. But I'm open to other views on this!
>

Hi Terry, Jonathan,

I aggree with this concern.

When FIFO is full, cxl_forward_error() drops the new entry regardless of severity
and returns true. For an UCE, the caller then flushes the worker, but the worker
can only process the older entries that are still in the FIFO.
The disgarded one is never read.

Coud the overflow path be made severity-aware so an UCE is never dropped ?
For example by processing it synchronously, or reserving space for UCEs ?

Dropping CE may be acceptable, but that's not the case for UCE.

--Richard

 
> > +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
> > +		pci_dev_put(pdev);
> > +		schedule_work(cxl_proto_err_kfifo.work);
> 
> Shared with below. Maybe just drop out of the if unless this gets more
> complex in later patches.
> 
> > +		return true;
> > +	}
> > +
> > +	schedule_work(cxl_proto_err_kfifo.work);
> > +	return true;
> > +}
> 
> 
> > +/**
> > + * for_each_cxl_proto_err - Call a function for each kfifo work item
> > + *
> > + * Single-consumer invariant: this function is only called from
> > + * cxl_proto_err_work_fn() via a single DECLARE_WORK.
> > + *
> > + * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
> > + * or cxl_unregister_proto_err_work().
> > + */
> > +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> > +			    cxl_proto_err_fn_t fn)
> > +{
> > +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> > +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> > +		fn(wd);
> 
> Like the earlier case I razed, I'd like a comment here to say where
> the reference we re releasing was taken.
> 
> > +		pci_dev_put(wd->pdev);
> > +	}
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
> > +
> > +/**
> > + * cxl_proto_err_flush - drain pending AER-CXL kfifo work synchronously
> > + *
> > + * Wait for the consumer worker to finish processing all entries
> > + * currently in the kfifo. Used by handle_error_source() for UCE so
> > + * the CXL plane can read CXL RAS, apply panic policy, and clear CXL
> > + * state before pci_aer_handle_error() drives PCIe recovery.
> > + *
> > + * Snapshots the flush callback under rwsem_read and releases the rwsem
> > + * before calling it.  This avoids holding rwsem_read across flush_work(),
> > + * which would deadlock via the rwsem HANDOFF mechanism when a concurrent
> > + * rwsem_write waiter (cxl_unregister_proto_err_work) blocks new readers
> > + * including the worker's for_each_cxl_proto_err() rwsem_read acquisition.
> > + *
> > + * The flush_inflight counter prevents cxl_core module unload while a
> > + * flush is in progress outside the rwsem. The counter is incremented
> > + * under rwsem_read (mutually exclusive with the rwsem_write in
> > + * cancel_cxl_proto_err() that NULLs the flush pointer) and decremented
> > + * after the flush completes. cxl_unregister_proto_err_work() waits for
> > + * the counter to reach zero before proceeding with cancel_work_sync().
> 
> I can't see it from just this patch so it might be useful to say if the
> counter is ever not equal to 1 or 0.  If it isn't can we make that explicit
> in the code?
> 
> > + *
> > + * For correctable events the consumer can run asynchronously; AER
> > + * does not need to call this helper for AER_CORRECTABLE.
> 
> For me this is both too much and likely to rot over time. Some stuff
> feels like it belongs with the flags it is talking about rather than here.
> 
> > + */
> > +void cxl_proto_err_flush(void)
> > +{
> > +	void (*flush)(void);
> > +
> > +	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
> > +		flush = cxl_proto_err_kfifo.flush;
> > +		if (flush)
> > +			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
> > +	}
> > +
> > +	if (flush) {
> > +		flush();
> > +		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
> > +			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
> > +	}
> > +}
> 
> 
> 

