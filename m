Return-Path: <linuxppc-dev+bounces-24615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC07FC4452D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 21:00:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4VBt55H8z2yb9;
	Wed, 22 Jul 2026 07:00:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784667606;
	cv=pass; b=F1owmJbuZAiDPh54cgm2v5K0E7tWT0kSFqIFpeQYZ+H1Km78DWANQaaIE8y8PU7uaiKxfrSnaMWJ4rH8EIm7kP1+vw3MiMH4MBPJ1VNgs6wn3n5FMoYoWSZeDhlHqX0tv7XJgF0B32BXOxIq5GsROaJ4Gqa9EZoa3fky/a3m0ntcEf9Yy4ceg+35MzjG2Fi7c0hcuQQmiKr5HeH8IVp0LFmLg2nu7keoje9svVcHoKH7H9ALHa6qxP+M/H80xNd/h0M757I8nk1ZfyKHw2TV0ZiYnbfYvPkKksnzYmoUmeR4BUI++q4SOqSWch1r2dVv1B4REvXt+PiaWVzKx5a2jQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784667606; c=relaxed/relaxed;
	bh=wB53e5x2wgeqj9sBbbnGjtfJi2sYLQhdyQHwQjlNJDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPRSKA+4ffw9h0IMGgUQe11I19+oRJ6wXbnrQuKsyNEIAhYTV0/EpccXutzqcq8QUsP/wJtWqZ3xezXOpbF8WvRubwnh7iykNhG00k7+kqy1KriWJsKW27BMZj9iTefQZHtDwWUcNWifG0ucaYpyST+KeZRZfyy70zp1SvRXE+nB4CodglBSalOIIDifrkdPHVzaVteSqi9ZRx9S/l++VTtLv4L5KYMpyHhH1tLBWMjFVSZ7TrR0rCWolh9OPgVa7q7ReiLOz0qY26YwcYVXGmOd4bvAuV65/dyLgfsZuPMQd7U+WBrrrZxkfXYOrrwp/8iKy9Amz+NfGJMfQzm2qQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xkaiAZ4M; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xkaiAZ4M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4VBq42Dlz2y8g
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 07:00:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvf65H8acdmx6b67UQwNQY3ZIJJyx+5YYmAoOmdy8/C5n3szi5dOAx3V66cF6cGpzW2v9gqVWLXtnM6F054xJExO+gEocQBWnBbdnbSiJaUOtv/LjW+f45RIiAc0LfwgYW5RK6Wi5xRFIM3t8GRH7nE3Wx5Ncem5UhZ5IV4Fi0QhEwVjEcJ56TfyOLTtRw4z2M+sPaYEXwvDLT1W+DzIaXbSuYC91mH2m3KXiJiR6ubgcTPPzrbFjsswSBaWPCGVNviDRmN0XL0v4kJgkLpgP21b3C14AZT1mXQYdyM0kkqwio6VFZdcR0JvGMseZsxgK6oZH71K//6KQOeTOMtJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB53e5x2wgeqj9sBbbnGjtfJi2sYLQhdyQHwQjlNJDo=;
 b=bV94U9StCpU/39QcAILKU27CKhMV+NChLKnxiGFJH09g2LhJj83ikzmIpkFeq9NaQSnZoyRjCWhoOv2t/K14IvSp9fbaJ0kuKxCnJv33UcYRcuLHg4LN/gCJTi+i/1THQ/6nh38tn5yADaLQQfYoLIk4Ixc7h4sL8E5fuV7Yl03zWKxJmFYY8UKt8BwBpzcmWBZw/ibo8yyvTBtIndLcO4QNZcpRsUQFROZWAPhNHpLVlOWhddYxkywCPLuL2HHoH/Iplo8mzlHVI7HP9b2HTfXYTkypSIZxt3HjaWu0l/aoBG3/sTqX+HuWZyaBo3W3WHyyF0rqIMRLZ1vz7vZlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB53e5x2wgeqj9sBbbnGjtfJi2sYLQhdyQHwQjlNJDo=;
 b=xkaiAZ4MytmHVxpk5bPjvfkm5Y63YxzEl7ICWv38MwG5vcyxwX1GIWy1EqzrbAEVy8J2j+Xb3m9H0VxUZepWB71klP31XqzxHqtaLC/U7BJDMeBn5MWqdsRqMltu/PdlFRPWLvYBpx02Ncmx6W/4BWWIDEomb45a/Odb2eeqT2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Tue, 21 Jul 2026 20:59:35 +0000
Received: from DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e]) by DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 20:59:33 +0000
Message-ID: <d68019bc-dbd7-4990-9fee-d12276bee531@amd.com>
Date: Tue, 21 Jul 2026 15:59:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL AER
 trace events
To: Jonathan Cameron <jic23@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-acpi@vger.kernel.org,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-11-terry.bowman@amd.com>
 <20260721010050.7b5654fb@jic23-huawei>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260721010050.7b5654fb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::21) To DS2PR12MB9749.namprd12.prod.outlook.com
 (2603:10b6:8:2b9::14)
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
X-MS-TrafficTypeDiagnostic: DS2PR12MB9749:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c70a75-7630-4aa8-d6c8-08dee76af73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|4143699003|3023799007|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eZO2NDZAJ0+jUlWGgKyTYfr5NH+g8+Np5gzOtzSI4rMCV7I0d0PyGwbEGLJrp7QYHCgzm85VJXxaJxHSUzsiZI0CB4+0sGr3gI3O8Up88UNSnLMmtTd3ZVY7CcogBrAgpfGGzml9hxagEcQ10Dy5dvQRIHTTf2iDVj16+IQlZ08U7HaIiAC5aON2o8FHH9eIfmfyaBeFWFjJU47k81+1eKdwSz23BA6gQn+WPoM0ndrcAB/wsCnrZ9UYcFWTFCjSdIwyLsdoYZKZ8sv2GKhDxQ42L3jpy+TM5bqHOp9znGOPcFHTKHQgoroXSUTgwJVs+5oDFYzV6yqruuSAtf1mN7V7rA3P01JFX87OgYpUdKHDu9oti7RkYk6zqYwfDRNIqgClOprcbppsSa/NQ4doGYRhKTnmyKZgihteDb75yBRspPx0LrzPFPNttVFEVhK5MRytAASP2xnX43RD2p3Kz/Eb2ch2DAKA+sVFwUQbKGDiC2zdGaGIHbJRSHSJNx1T9zq0ANaVG9JPisbwITYT0VDdHT26hy9sALLFVqEIcU2M7kf8NEdTPUqvuvLYe6QzfYXIbwXX7DXUwDf7EaeFynSn2eVS7mQDlmZiePbgzMFUFIMA4C8yPxrdjbvfhf9mmLJhZ7YLDefnm4YxJlQqN8kO4F08o28GIcdmAjFvCEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9749.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(3023799007)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ByYlBYbHpXV1RZc1E2UTdqWCtDVk9LR3UzaFFwMWRvN243N3BYTUg5bHhM?=
 =?utf-8?B?VnMrSk1wVVplbTl6WHZwVVNKbTRja1hBZEZFaTBXaXY3Yjhzc3VtaGRsV2Vx?=
 =?utf-8?B?cEZPQmVIQWlVSXladS9DMjhXWFZkMDRtR0g1UzFNWDVQT0k0RXBWSlhjc1dW?=
 =?utf-8?B?UnFnblhVL2QxWHY5MWJyanpTSGJCb1k3dkxHZms0Ulg5ZVRmY2prWXRLMHdr?=
 =?utf-8?B?WlhaTlB4cE5lSWNGYm5oc2VYMFNoajB0NXBVT2NKdW0xSnJjcTlTVEp6MWh0?=
 =?utf-8?B?U1FYRzNabVJNQXFJdXNwd0M0NEhMNElqSFVBdEpzaWdSV0pzcEpZMVBORERa?=
 =?utf-8?B?Uy9xRTBCWW5FMnhMYUhCdXRLRTVpWVF5eG14aFo2TithUlMrS1dmVHFGbmxC?=
 =?utf-8?B?aGR0RmxlQjNyTGNNRm9yNy82LzR2WTdQVG41ckxsT0k5bXhWNzRVVE5OcVlT?=
 =?utf-8?B?YkZkYzlqL01yQ3M2K3Bxb2hZejIySitjQXJoVGg0bG85RktWWG1YaG5mcEV4?=
 =?utf-8?B?NnhHUFdMRTBOM0tNbGVLZWN5ZjNSNzZjZEJqM25YSFNvTU5RUXI2djlvQTFF?=
 =?utf-8?B?eFVmSzF0SWdrazlIakdnMFhIZmk0UkRaWU1QbzJLSG1pVVJLN2RsL3dwZGJp?=
 =?utf-8?B?RCtkNHo3V2prZFJzZGNEay90NmxCMWNUZDhwMmFtakl2RTVJNEwzZlFiRXZp?=
 =?utf-8?B?VzlibWFuZGE5aFBnc0syYkdVSkFvaWJIaExjeXByRG9paHZmcHF5Mlcrd2hx?=
 =?utf-8?B?K1ZOWVJrZDNaTFQrTHFpQnZIVDZUcVdhT3ZpVm96cXcyeHhKVm1nUFVXZWkx?=
 =?utf-8?B?MGFreEVDMG9mT1A4bGM5Wk1ZbHJoRDFjZzNyQ0NjMkV2RW1uR2tGYnMyVnRQ?=
 =?utf-8?B?dFcwUFZBUTNhTnRJRUVIZWVlbTFZU3hKaXorUmU5WU8vaUhyMVh0ajV6UHVR?=
 =?utf-8?B?WlVGQkc3VVlhRlVHOHl3dnhxYUtWWkhtYVdQOEZibnMwSEp2S0FBQ213S0VH?=
 =?utf-8?B?TjlLbHd0SHlkc2NXK29YWWhoNnpjNXlZNGxaTmtGQTg0eUpOcUg3ell0MGRK?=
 =?utf-8?B?Sk5LdGFsenFoZzljZWtScHVBVnArTndpVlU5MTFaYitJZ0NEVUN2MHdmV2Qr?=
 =?utf-8?B?Mm82ckZpb3JXWlh6ZUFtZTd3K2NleDM0V285S1NRMWY3aDc4b0RNbnUyLzg5?=
 =?utf-8?B?M1VHTkhhcE1TeTZ4MHRlaGdUUmcvQmZIQXJSQ2J5K1ROTXlEdHpWa0I4N3Qy?=
 =?utf-8?B?bGVZOStLQXRydStlWjc3blAxVzU5NUI3S0p2Vm16VUd6ZmhTM1Vadjd2N2t2?=
 =?utf-8?B?U0hXNy80ZTBsYklKTithN1VMNDhvL29rRUoraEJpZE9SMEJ3UlJTVTh3UUVN?=
 =?utf-8?B?M0FlOHVRalZLMzViWUJPTWw1MVlPaGVFYU0zSDRZbzRhY0RocmYwL0ZBeGt2?=
 =?utf-8?B?dzZuUWNrejRyM1E1YkZuNThIa1ArRGVSZ1c3R3NFVytPY2RQdDNiM2tFWG5n?=
 =?utf-8?B?MURYQmxIMWZERlMreWhYU3dLYmFaSkxpZ2F0UkI0emx2MmQvNWpZV3V0enhm?=
 =?utf-8?B?eUowa1orUkRDeC91dmRLUnpVdytwd0xjNUtXWS9UZ2xxejVmWTZVNVkzRGVG?=
 =?utf-8?B?Y0NSRnJ3MFoxbmdXZFJYbitGbklRMndVUElRVHBJbnRrZjVWZDFBd3pyVFdI?=
 =?utf-8?B?VHRwUmg2SmVCMTNvVWpBZjNiYkVZczJjNTVlbklJOW03VHR3NUJVOHB2UGFZ?=
 =?utf-8?B?UU4vUnlUYVZwQWRXem15NFhJRmdHd1gvbGpPUm1JaGpUR2ZUOUVoNFZKNEMr?=
 =?utf-8?B?UHBSZ2JCNUhya2NoWkwxUlFGTDRoUjk1d1I0WnRSTzdMZHJ5SHpwWVliRG96?=
 =?utf-8?B?Q3U5RlJCVkU4ei9sQ1Avd3BjL1lDVXh3RkdvUEJpbmZlUWgzN2xsSG5MN04v?=
 =?utf-8?B?dEZldUpQNlVIa3Bwa3hVTXNBdytLd3RFYW1aNE9IY2taTUw2VExTL2I1QjBj?=
 =?utf-8?B?ZWxYSDFLKzJYL3BNWWhmcGFjTEZ5RHNpUW5jRlcvY3R5emdjOXEyVVJuQ29m?=
 =?utf-8?B?S2p1MnVJRjJScEk5TWc3bVByTXNQMVNvYWM4ZWtSRWhYODZGQzJFN3NLQ3RT?=
 =?utf-8?B?TEFHdFpiOWllWFZ3RzFsdEpRY1U4aXV0VFhEUjVqZlhFUnpoTmNVY1Z2Vnd3?=
 =?utf-8?B?S0h6MldKbFhFd3Y2V2E1dTVYb2d0ZzE1eUZxeHZYMjJzdGozQy9EVE1Vajd0?=
 =?utf-8?B?S2N5dWpYVVYrb0tsV1ZpaVdLZGtOZ1BhS3dneG9IL0RGajRjdC8xWmY2MXdJ?=
 =?utf-8?Q?7PkAZY/zIliwjWlMPI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c70a75-7630-4aa8-d6c8-08dee76af73d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9749.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 20:59:33.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US4SMnzXenJKUOE4D/ni4IznbEHNy0s+nj/NyGCKHkaviOM8qOxdCoHWMmQwuxKeDpMwsf1jIUb8W0S+Zq/PMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

On 7/20/2026 7:00 PM, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 17:27:03 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Dan Williams <djbw@kernel.org>
>>
>> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
>> trace events instead of a plain struct device * derived at the
>> caller. The trace event helpers then derive the right strings for
>> endpoints, switch ports, root ports, and RCH downstream ports
>> consistently across the CPER and native AER paths.
>>
>> The unified cxl_aer_* events keep "memdev" as the legacy field
>> (endpoint events populate it with the memdev name; non-endpoint
>> events emit memdev="") and add new "port" and "dport" string fields
>> populated for all CXL device classes. Updated userspace can key
>> off "port" and "dport" without a parallel set of events.
>>
>> Remove the separate cxl_port_aer_uncorrectable_error and
>> cxl_port_aer_correctable_error trace events. All CXL AER events now
>> use the unified cxl_aer_* events with port and dport fields.
>>
>> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
>> the unified trace helpers, replacing the per-port-type branching and
>> bus_find_device() memdev lookup.
>>
>> The TP_printk format string places "port=%s dport=%s" between
>> "memdev=%s" and "host=%s", changing the text-mode field order from
>> the pre-patch output. This does not affect consumers such as
>> rasdaemon that use libtraceevent to parse fields by name rather than
>> by fixed text position.
>>
>> For non-endpoint events (switch port, root port, RCH dport),
>> "memdev" is empty and "port"/"dport" carry the topology information.
>>
>> The serial number is retrieved via pci_get_dsn() which performs live
>> PCI configuration space reads. A following patch ("PCI: Cache PCI
>> DSN into pci_dev->dsn during probe") replaces these with a cached
>> serial number to avoid config space access in error handlers and panic
>> paths.
>>
>> Below are examples of the different CXL devices' error trace logs
>> after this patch:
>>
>>      ---------------------
>>      | CXL RP - 0C:00.0  |
>>      ---------------------
>>                |
>>      ---------------------
>>      | CXL USP - 0D:00.0 |
>>      ---------------------
>>                |
>>      --------------------
>>      | CXL DSP - 0E:00.0 |
>>      --------------------
>>                |
>>      ---------------------
>>      | CXL EP - 0F:00.0  |
>>      ---------------------
>>
>> Root Port:
>> cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
>>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
>>
>> cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
>>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
>>    first_error: 'Cache Address Parity Error'
>>
>> Upstream Switch Port:
>> cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
>>    serial=0: status: 'Memory Data ECC Error'
>>
>> UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
>> PCI AER callbacks that are not CXL aware.
>>
>> Downstream Switch Port:
>> cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
>>    host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'
>>
>> cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
>>    host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
>>    first_error: 'Cache Address Parity Error'
>>
>> Endpoint:
>> cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
>>    host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
>>    first_error: 'Cache Address Parity Error'
>>
>> cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
>>    serial=0: status: 'Memory Data ECC Error'
>>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
> 
> One question inline about reference counts for the port.
> 
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d5dc2c22565da..acf40b2396c3b 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> ...
>>  
>> @@ -109,47 +77,34 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
>>  
>>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>>  {
>> +	struct cxl_dport *dport;
>>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>>  				       data->prot_err.agent_addr.function);
>> -	struct pci_dev *pdev __free(pci_dev_put) =
>> -		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>> -					    data->prot_err.agent_addr.bus,
>> -					    devfn);
>> -	struct cxl_memdev *cxlmd;
>> -	int port_type;
>> -
>> -	if (!pdev)
>> -		return;
>> -
>> -	port_type = pci_pcie_type(pdev);
>> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>> -	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -	    port_type == PCI_EXP_TYPE_UPSTREAM) {
>> -		if (data->severity == AER_CORRECTABLE)
>> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
>> -		else
>> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
>> -
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
>> +		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
>> +	if (!pdev) {
>> +		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
>>  		return;
>>  	}
>>  
>> -	guard(device)(&pdev->dev);
>> -	if (!pdev->dev.driver) {
>> -		dev_warn_ratelimited(&pdev->dev,
>> -				     "Device is unbound, abort CPER error handling\n");
>> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
>> +	if (!port) {
>> +		dev_err_ratelimited(&pdev->dev,
>> +				    "Failed to find parent port device in CXL topology\n");
>>  		return;
>>  	}
>>  
>> -	struct device *mem_dev __free(put_device) = bus_find_device(
>> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
>> -	if (!mem_dev)
>> -		return;
>> +	guard(device)(&port->dev);
> 
> Don't we have a reference for this from find_cxl_port_by_dev()?
> 
> Superficially scope looks the same.
> 
> 

I somehow missed this yesterday. Yes, find_cxl_port_by_dev() ref increments. 

>> +
>> +	/* dport is NULL for Endpoint and Upstream Port devices */
>> +	dport = cxl_find_dport_by_dev(port, &pdev->dev);
>>  
>> -	cxlmd = to_cxl_memdev(mem_dev);
>>  	if (data->severity == AER_CORRECTABLE)
>> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>> +		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
>> +					     &data->ras_cap);
>>  	else
>> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>> +		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
>> +					       &data->ras_cap);
>>  }
>>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>>  
>> @@ -240,14 +195,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>>  		return;
>>  	}
>>  
>> -	if (cxl_handle_ras(port, dport, ras_base))
>> +	if (cxl_handle_ras(port, dport, ras_base, pci_get_dsn(pdev)))
>>  		panic("CXL cachemem error");
>>  
>>  	dev_dbg(&pdev->dev,
>>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>>  }
>>  
>> -void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base, u64 serial)
> That's over even the modern 100 char limit. Needs a line break.
>>  {
> 

Yup, I'll linewrap at 75-80. Thanks.

- Terry


