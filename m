Return-Path: <linuxppc-dev+bounces-24550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BFFC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 22:28:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3wCL0r4mz2xLg;
	Tue, 21 Jul 2026 08:28:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784586510;
	cv=pass; b=R/FQhoMmru9Ob/kveDWF4n8oPSSviX3BR01dL/2aOMdrMX6BCyKom+O/DMcAlqr+6kzlC8mS2IZB/n/e9BWYaFKYNRAEOXaoR6v0vi68PEEPpHTP0K7r0RFY720deerMOFuza8XqSutVVeaSF59SRDZ7sVHb7pllueV7GBbW4efpOaLEMQ/ggmPwkA41kApKm5vi8yJZ6GjsjIEoNmw6GHlT7ZT9yPdQxkqxbgcufmGH7AKLU0j1SNX/Wb4C+xRgHTn8ISwMRE3XleKeenyu5Vntt+aLt4FCSxUNYICnCVQc5/pqo3HzWIwDwRiWfcGn/ehM76posVqYVihCBL4Jwg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784586510; c=relaxed/relaxed;
	bh=1uyhxatsas+zavPIJ1WiBCuFq2i5CaOFhGniGzyNiwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUfcqpNa3VDaBg4ljuLHN+Yl55EthKPbLjQ/KZ4RKrxnpCrq1craIlpQlNn6GC83CztRd40ArPRLzkvQHPhUcE3tjvht5RZSXUAy4eAVjKJ70oAw64oWOLsxEDzS8/25vPPk5hW6cH8P7Cfxu5D2qvOGxduiDpV8I+ZswKf2JYaQjw2VarXNat0W8M5h9/9wTsEUZiLW8dIkgXWdf4HUk4pN9wCp/MTxBfXL9eL3yh6yO7hS+6ztGA1BWR3U+78ikW+rWgpxfCECjPVRVZaexVaC3oi788fpYG61m9JwiTPXy3mxTuQnzvvC8FpizspmSo4tXxUsFFqdz/HcfV+bkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MTdlmWD7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MTdlmWD7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3wCG6snlz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 08:28:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loWkVuTow8zEGJ37Al/Roy4arZ5SII9k5mnmhKrGeklWQw/dG7KuhkGwiVssHS5IZnbadnGB8fHiq954IrRGmXD/ykccMs7hryRLGRNQjfSw3CcEftWDdfllKzTHDk1zTNWZMCszLHlCoagWCXZ/0tRCuEDorZhrolbZ8obRcjFdYx1GfolCWBBQqfHVpQaYmy+CRk1zT2Mv3ET0JK51c081tBepZM008+u5ul6FsMkqKzwhdmLiJFqGsNvOsDvpBzEk9uaN83ZBHHKWQ3S1374O2DAoLpurllnVG30QGQo7XEuXlnJqdtaZqPqLb/EjJCl20of9kvoj3kehGIdKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uyhxatsas+zavPIJ1WiBCuFq2i5CaOFhGniGzyNiwc=;
 b=a3tCrZQtNosaQW1c+k0XZNGvtA0uEakP8vuktVlUzbR+8a9EdyYMR9AWXhd3nrPRbKExlu7Cjf2PsmgiME5Mbyx0yhfXsh8iMogGJMHkrsSzk/sAkUkL+FCGihBWdj7LRlKbt72MxzHtsbkk8mo9y4cteR6F/95NWyBKnZv01UpUNFQqIpqQmJ5DkIbEm/ciex4FtqXElwxnirc0F7oL3SkILA+H2UMpRE1SUMO7lM5uFJVv+r5FqobC527hKdIyC7IEtRTLnRcNKd/ue5IFoCro6YwBj/wTodHKX3zCswDegLA+v9gRc6cJYWdPO8sjhnznL62hjQJugssuoVLDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uyhxatsas+zavPIJ1WiBCuFq2i5CaOFhGniGzyNiwc=;
 b=MTdlmWD7bmBc6jlsZZ5VBwTgfZLbblo+eexe0w6/uGljSkxSPA2ujLEsV7hnqyhNqFcAbRrp88VJUmFFJ+6cDYtvhJZ48opOG+eM9Cd6/ACB4g2leq16vcTDexBO+S5i3blmXohvRCtzxmhrdP/UAsvvlZMCr6RbSHPVot3BHYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:27:56 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:27:55 +0000
Message-ID: <62c40932-0f9c-4a67-8ff6-4bc7ba24f40e@amd.com>
Date: Mon, 20 Jul 2026 17:27:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cxl: Device protocol AER injection
To: Jonathan Cameron <jic23@kernel.org>,
 Ashok Raj <ashok.raj@oss.qualcomm.com>
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
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20260717225700.3543801-1-terry.bowman@amd.com>
 <20260720220430.30b7e3ef@jic23-huawei>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260720220430.30b7e3ef@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::16) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e179110-a377-4ccb-8d54-08dee6ae2536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|4143699003|3023799007|10067099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	M6rnGsQfitxbCXtww/4sxIly6lRyysRxp1VjD/asWnSf3EPrzvrnz00n48cEPjiPk72lC5oxy88enGIc1029GyWWzcA6eWMyOFyGw+RH3pcOMlTxQo9ULMZXXZr1g2hy34My8yQtmyHgyo6igYyQZJo2fAWwQsbn/iSMnKPxw5QKJNPdvHiz5q0vPTmTaXJ1i8iZ/bxbCuAshkqFmB/25qW2oAtmIxG3Q7aOez1xtXvEGl6p9Ke3mIT/84mYAB71Q2ZHtlEnznME9uRKPTTtRlGF8e3RJHhiMGfu7u0Gc4CiPrxalEkcuel+h1Hw1snETQgc/mADKsZKyDs/0LPZMKyFW1vE+8V6hxkLmauqjWUYfvGszhcQtR6KX3i6HhHYgf4BVNqZIubhyRtb0p7fCn+JUW6c3yLeBqxVXjMdJK9IuchHW0Q3wyTMQjSpS+kl1SQZvtnFywyKjX3INpWr6Cx+YNVCv6It6k8G2j2o0eRsJTkwPc/+Kk3HccOR1B+0s/j8cT3QC7AWgcIaGv6N+cUoC9+7Naji08x67R7OM4i1n1la4zOEDzZHTnsHQmNYJr9Qa0NOrHn0t3bcYZIsWZJkA1oZmtxMNMSEK4pZ+dTqYlc/q0FAiBYlcWUDQFgRn8Km5GP6X7TM0SLE+5L/MQ2x2nSs9iCEPQ8+NoqqSro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkQwdGNGa2dqWWE5R3ZZQWZHN0pnOU5DbEtBQ01TZ0NNRmxpZzRvSE9CSHM4?=
 =?utf-8?B?YlhNaEJhcEFrU0VndGdqbmZEUjdhTnRKazJxUFNhV1FjT1lkUWtvUEV5YllO?=
 =?utf-8?B?T1N6YUk2ejBCTmdYU2JEdEtvZHI2NExSc05FSkZHeHkyeG56N0N5T0I1MjFF?=
 =?utf-8?B?OHhROWszOEk4cDVZRDYyaHI4NHFFL3loY0NrRVkzZFBReElmajZiMHNSUC9G?=
 =?utf-8?B?WjhEQ21QTERqclJLZGVBazE4OUozdDMwc0Fzd2hGdkhDdEVFaHh1a3JkSVdu?=
 =?utf-8?B?K0J0MVpqdTd4SmpIaXk0RjlsTGxwaVdyYlltR3lpeHZoYWZCamRuUXNSREcx?=
 =?utf-8?B?YWtRc2ZHRkxEM05CR01aR2RHQzhHekxvdEJPRzJTeW95U0drcTJXK0prYTJR?=
 =?utf-8?B?WEp0VzJPbkJDcVFNVjZKS2ZaRld0ckovbEUxUTk1c3c2RDFXMG9USW1TVm1r?=
 =?utf-8?B?TmRHY0w3TStINmlXbXAyeWdROGxDRm9pUEw2alB1MXpnOXZqUm5rbWF1RDV4?=
 =?utf-8?B?MDFOVEt3bGU2cXhXSzkySWpPaHF1Ym9xWmdKZHhFV0lidXhrakdaN1pHcCtr?=
 =?utf-8?B?LzljMklzZGNZTHRXSHhYcTQ3a0NXenIwRzY3M2tzN3BMbXBGSzg4THBpRnMz?=
 =?utf-8?B?SXVCN0RiL1h1YXdwcWdlM29qNjZjcjBFaGRsV29RRG1HcnNBbWJGeVdZRldh?=
 =?utf-8?B?YTdHc25SSEVJV2wxR09UNU05b0JNYWdoQzRoWWsrazdhTktPY3puWEx5MnZ6?=
 =?utf-8?B?NjZlUm1LSE1Sb3dNMjVHSmZ4a0hPeE5yL1RKc0l4S1JFYTZRV1pZd2FTQi8r?=
 =?utf-8?B?QllJaW1NODFtamlaOU1iUUNZUUprNTNhelppOEh4bjE0OEhXQVgwOEtKYTN5?=
 =?utf-8?B?dW12Vkxuc0JkVG01TDhnZ282YlJnaHZySTdGMkZOY2NzNkMrL3FVNkhOMmFB?=
 =?utf-8?B?RysxaXc4eGhkU0FYYnBwL0lUVlVZdXpLeFJTTm55d0oyS0hDeURpQ0twU1hn?=
 =?utf-8?B?VlFFUkdCSkVtNTRGTnVRMlJBb0xudGp2ZEltdEk5THZrTHJaWVhXZ0xJVjlk?=
 =?utf-8?B?TUVkeW9CNHhmYmc2KzRXNERMK2NjRi8ramZMU2xQT2ZJT1BvUDFYb2t4QmVB?=
 =?utf-8?B?RU1iYWkzV2JMS0RjdFZQaEhxaklDTnIwQXFyZ0FUV3lqM1o1RkhtQnRSVlQ5?=
 =?utf-8?B?UEUzV1lQdC9xRXhWVUF4SFJoaVlEZitRSG9OQ3hJVFQ2UXVib25vN0RsTW8r?=
 =?utf-8?B?K1N5S1VZai9tMGJFRWdGS2Uwd3ZNM2REeTl2dTlRb2tReTdPYlA2SUI1SlVp?=
 =?utf-8?B?Wkw4RXVWaHFXeW1VcS9vdGUvcWE2c3N4enV6cWxublRCK0FnRDhHdEpwbC9n?=
 =?utf-8?B?cnV0QWZQR1hzUzlFRkZGL2NBSnlXc05iYnI5aFpRMXo3c0dBWjB3TVlEeGZX?=
 =?utf-8?B?a3J2RC8yUFZQMlc5T3BBNkZsdVlRZVN0Y2thVGFUS3psNlNMU0VRT2I0MmUr?=
 =?utf-8?B?Rjhwb0N6WEhyd2szNUpjeVJYa2I0eUtzL1RNY0dybm5Vc3VCaktLODZXdUcy?=
 =?utf-8?B?K2NDVlUxSnF4c2hmREZNOHZERlQyZ2t5YzdQYXhXZ0JvUXE3K29aZnNRSlcy?=
 =?utf-8?B?djI3eUhuYlNlVlRTaTk2NWxPK09sL28xK04za0Q2MWRwM05JSkhkQld4R05t?=
 =?utf-8?B?dmZXdWRBV0FKNEZELy9ZS2hXOThMWnUzUTRSeUc4WXUzc0g2MU53U2FpUkdM?=
 =?utf-8?B?K1ZwRnYrL09MZmlERzBwZXBReXNzdjBQaXhxN2oyeXgxdUtnNmkxSUdZc3ZF?=
 =?utf-8?B?Vk1zUW5EbG14VVNva1VmK2xSOE5KdDJKbmQyblUreXd5a1JNWEpSNkxCQmNn?=
 =?utf-8?B?VWtDNWxPK2o2WVcvVjNVdzBOVnBWeXBPQ3d3Umk3bFEzNHEzM1RIbmhsMjN3?=
 =?utf-8?B?Y3pUUlZqbWd4YW5aa2xuTWdlSFo3ak5FemxjU0VvUDFIdnlNYzkrTTVPYjBU?=
 =?utf-8?B?N3hVUy9uZ045bmZZUS9nVlJtNUxaRXFEVGZPTnpKMCtBUm5WUEwzaVlJWmNH?=
 =?utf-8?B?anphRks0MEhudnlTVVBFZHhSZ3ZidkYxYVFseCtkc3JTUGdoaVZTZFdHa1lG?=
 =?utf-8?B?WjExTHMvVkRyRzFPOXVoV0QrWkRlMDJ1QkNpR3ZiWER0Q3h0T2prenRxalBq?=
 =?utf-8?B?YjRkblV4cWx6ZlhOYzZIMm5xbVpBUWVuamhQZ0dEbTdZcWVLbERWd1B2RFd4?=
 =?utf-8?B?aDJhN25NeFJ1bEhQRndvdE1lK2ZsUGNEczNybDVWbmhnRm5aOXZGNS9nRlFD?=
 =?utf-8?B?N1FGNVF4QWRFWXBkdFJvZ0dLSHVBalVQMFFMeldJMjRyVllaVVllZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e179110-a377-4ccb-8d54-08dee6ae2536
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 22:27:55.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiRAjgO4czuXuj6e0mBPabTCoNadJXCVQ2r6r6An19GaM9r3c6oDP6S8w+cGT/0UAbaG2SICDi6gQI4SE3lcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

On 7/20/2026 4:04 PM, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 17:57:00 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> This patch is intended to provide a method of testing the recently submitted
>> cxl series "cxl: Enable CXL PCIe Port Protocol Error handling and logging" found
>> here:
>>
>> https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com/T/#md90ec1fdd1b374bf1e32e7736e2b3e34b328c701
> 
> Hi Terry,
> 
> https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com
> 
> Works fine.  Generally you can crop that end bit off the links.
> 

Good to know. I'll use that going forward.

>>
>> The changes in this patch will allow CXL RAS protocol testing by injecting
>> AER errors using AER EINJ. The RAS register block status is updated
>> using a central function to augment RAS register block returned by
>> to_ras_base(). This supports all CXL devices including Root Ports,
>> Upstream Switch Ports, Downstream Switch Ports, Endpoints, and RCH
>> Downstream Ports.
> 
> Why is this an RFC rather than a final proposal?  There should always
> be something to give the reviewer that info in the patch description.
> I'd actually be tempted to throw a cover letter in to have somewhere
> out of the way to put that information.
> 
> Is it simply because it only makes sense once the other seris lands. 
> 

The immediate priority was providing a testing procedure for the v18 series.
I wasn't sure how the design would be received. For instance, the to_einj_ras_base() 
could be moved into cxl-test as a to_ras_base() mock implemented function or 
it could remain in ras.c (or maybe even ras_einj.c) outside of cxl-mock. I'm 
looking forward to Alison's review and comments. 

My preference is to introduce core/ras_einj,c and add these changes. This 
would be to isolate all the changes except for: cxl_ras_einj_init(), cxl_ras_einj_exit(), 
and to_einj_ras_base(). I've started moving forward with making these changes 
knowing the direction could change once this receives more reviews.

Also worth discussing is the commandline takes multiple parameters for
a single sysfs file which I know isn't acceptable by everyone. I personally 
like the interface as-is because its simpler to use in comparison to multiple 
files that must be set individually.

>>
>> Add debugfs-based CXL protocol error injection for testing CXL RAS
>> error handling paths. Injects CXL RAS protocol errors using AER internal
>> error inject interface via /sys/kernel/debug/cxl/aer_einj_inject.
>>
>> RAS CXL status is set using to_ras_base() function override when kernel config
>> CONFIG_CXL_PROTO_AER_EINJ is enabled.
>>
>> Usage:
>>   echo "DDDD:BB:DD.F [UCE|CE] AER_STATUS RAS_STATUS [RCH]" > \
>>       /sys/kernel/debug/cxl/aer_einj_inject
>>
>> Move struct aer_error_inj and aer_inject() to linux/aer.h so CXL
>> can invoke AER injection directly. Export aer_inject() with
>> EXPORT_SYMBOL_GPL.
>>
>> Make cxl_debugfs non-static in port.c and declare it extern in
>> core.h so the debugfs file can be created under the existing CXL
>> debugfs root.
>>
>> Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> +CC Ashok,
> 
> Various thing inline.  Mostly this review is a bit superficial as I'd like
> ideally to see a cleaner separation of this at level of files etc.
> 
> Thanks,
> 
> Jonathan
>> ---
>>  drivers/cxl/Kconfig           |  13 +++
>>  drivers/cxl/core/core.h       |  21 ++++
>>  drivers/cxl/core/port.c       |   2 +-
>>  drivers/cxl/core/ras.c        | 208 ++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/ras_rch.c    |  12 ++
>>  drivers/pci/pcie/aer_inject.c |  29 ++---
>>  include/linux/aer.h           |  15 +++
>>  7 files changed, 281 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 80aeb0d556bd7..ef449228b2549 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -238,6 +238,19 @@ config CXL_RAS
>>  	def_bool y
>>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
>>  
>> +config CXL_PROTO_AER_EINJ
>> +	bool "CXL: RAS Protocol Error Injection using AER EINJ"
>> +	depends on CXL_RAS
>> +	depends on PCIEAER_INJECT
> 
> Do we think anyone who has CXL and PCIEAER_INJECT support will want
> to carefully not build this?  I'm just wondering if we can avoid asking
> the question and base the built or not on the combination of those.
> 

Good question: How do we incorporate this with the existing CXL EINJ 
functionality making them complementary and consistant? The existing 
EINJ is true ACPI injection but only supports RPs. The ACPI EINJ callouts 
are currrently in core/port.c. We should consider moving it into a common file 
such as core/ras_einj.c. With that move it will help force us merge the interfaces
where/if possible and at least give central location for error RAS injection.
I think folding the AER injection into PCIEAER_INJECT kernel config is 
reasonable but looking for others feedback.

>> +	help
>> +	  Enable debugfs-based CXL protocol error injection. Writes to
>> +	  /sys/kernel/debug/cxl/aer_einj_inject inject CXL RAS protocol
>> +	  errors using the AER internal error inject interface.
>> +
>> +	  This is a debug/test facility. Say N for production kernels.
>> +
>> +	  If unsure say N.
> 
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index a55a4e409feda..91910d2bb5d39 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
> ...
> 
>> @@ -244,4 +247,22 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  
>>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>  					   struct cxl_dport *dport);
>> +
>> +#ifdef CONFIG_CXL_PROTO_AER_EINJ
> 
> Do we need the ifdefs?  If the option isn't built none of this should get
> used.  So small benefit.
> 

Youre right. You pointed that trick/pattern out before and results in less 
unneeded code. I'll make that change.

>> +
>> +#define AER_REGISTER_SIZE 5
>> +#define RAS_REGISTER_SIZE (CXL_RAS_CAPABILITY_LENGTH / sizeof(u32))
>> +
>> +struct cxl_aer_einj {
>> +	int correctable;
>> +	bool is_rch;
>> +	struct mutex *lock;
>> +	struct device *dev;
>> +	u32 aer_registers[AER_REGISTER_SIZE];
>> +	u32 ras_registers[RAS_REGISTER_SIZE];
>> +};
>> +
>> +extern struct cxl_aer_einj cxl_aer_einj;
>> +#endif
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d77208af41e03..d41deea899d30 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -3,6 +3,7 @@
>>  
>>  #include <linux/pci.h>
>>  #include <linux/aer.h>
>> +#include <linux/debugfs.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>>  #include <cxlpci.h>
>> @@ -117,6 +118,195 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
>> +
> 
> Unless very strong reasons for it, generally don't do #if stuff in c files.
> Just have a separate c file for this.  Otherwise it hurts readability and
> we tend to loose the clean separation over time.  A file makes that less
> likely.
> 
Ok.
> 
>> +static DEFINE_MUTEX(cxl_aer_einj_mutex);
> 
> Needs a comment for what data it is protecting.
> 
>> +
>> +struct cxl_aer_einj cxl_aer_einj = {
>> +	.lock = &cxl_aer_einj_mutex,
>> +};
>> +
>> +static const char cxl_aer_einj_usage[] =
>> +	"ssss:bb:dd.f [UCE|CE] AER_STATUS RAS_STATUS [RCH]\n";
>> +
>> +static int cxl_aer_inject_error(struct pci_dev *pdev, bool correctable,
>> +				u32 aer_status, u32 ras_status)
>> +{
>> +	/* RCD errors are signaled as internal errors on the associated RCEC */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) {
>> +		if (!pdev->rcec)
>> +			return -ENODEV;
>> +		pdev = pdev->rcec;
>> +	}
>> +
>> +	struct aer_error_inj einj = {
>> +		.bus = pdev->bus->number,
>> +		.dev = PCI_SLOT(pdev->devfn),
>> +		.fn = PCI_FUNC(pdev->devfn),
>> +		.domain = pci_domain_nr(pdev->bus),
>> +	};
>> +	int ret;
>> +	int aer_offset;
>> +	int ras_offset;
>> +
>> +	if (correctable) {
>> +		einj.cor_status = aer_status | PCI_ERR_COR_INTERNAL;
>> +		aer_offset = PCI_ERR_COR_STATUS / sizeof(u32);
>> +		ras_offset = CXL_RAS_CORRECTABLE_STATUS_OFFSET / sizeof(u32);
> 
> Given these are offsets into cxl_aer_einj.aer_registers / ras_registers
> can we use sizeof(*cxl_aer_einj.aer_registers) etc
> 
We could but that assumes the CEs are book ending the register blocks. And this would 
be inconsistent with UCE case below, right? Tell me if I misunderstaood the question. 

>> +	} else {
>> +		einj.uncor_status = aer_status | PCI_ERR_UNC_INTN;
>> +		aer_offset = PCI_ERR_UNCOR_STATUS / sizeof(u32);
>> +		ras_offset = CXL_RAS_UNCORRECTABLE_STATUS_OFFSET / sizeof(u32);
>> +	}
>> +
>> +	cxl_aer_einj.correctable = correctable;
>> +	cxl_aer_einj.aer_registers[aer_offset] = aer_status;
>> +	cxl_aer_einj.ras_registers[ras_offset] = ras_status;
>> +
>> +	ret = aer_inject(&einj);
>> +	if (ret) {
>> +		pr_err("cxl-einj: aer_inject failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t cxl_aer_einj_write(struct file *file,
>> +				    const char __user *ubuf,
>> +				    size_t count, loff_t *ppos)
> 
> Might as well wrap to 80 chars and save a line.
> 
Ok
>> +{
> 
> ...
> 
>> +
>> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, &dport);
>> +	if (!port) {
>> +		dev_err(&pdev->dev, "cxl-einj: Failed to find CXL Port.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!to_ras_base(port, dport)) {
>> +		dev_err(&pdev->dev, "cxl-einj: RAS not initialized.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cxl_aer_einj.is_rch = (nargs == 5 && strcmp(topology, "RCH") == 0);
>> +	if (!cxl_aer_einj.is_rch)
>> +		pci_dev_get(pdev);
>> +	cxl_aer_einj.dev = cxl_aer_einj.is_rch ? pdev->dev.parent : &pdev->dev;
> 
> 	cxl_aer_einj.dev = cxl_aer_einj.is_rch ? pdev->dev.parent : pci_dev_get(&pdev->dev);
> 
> Or use an if else for both is_rch based choices.
> Lazy me wonders.... Can we just grab a reference to the dev.parent for is_rch and
> simplify the code?  We don't really need it I think but it is harmless.
> 
> 
Your change is cleaner and the parent ref increment doesnt hurt as you mentioned.

>> +	ret = cxl_aer_inject_error(pdev, strcmp(severity, "CE") == 0,
>> +				   aer_status, ras_status);
>> +	if (ret) {
>> +		if (!cxl_aer_einj.is_rch)
>> +			pci_dev_put(pdev);
>> +		cxl_aer_einj.dev = NULL;
>> +		pr_err("cxl-einj: injection failed for %s: %d\n", sbdf, ret);
>> +		return ret;
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t cxl_aer_einj_read(struct file *file, char __user *ubuf,
>> +				 size_t count, loff_t *ppos)
>> +{
>> +	return simple_read_from_buffer(ubuf, count, ppos,
>> +				       cxl_aer_einj_usage,
> 
> Probably wrap this to push that up a line.
> 

Ok

>> +				       sizeof(cxl_aer_einj_usage) - 1);
>> +}
> 
>> +
>> +static void __iomem *to_einj_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>> +{
>> +	if (dport) {
>> +		if (cxl_aer_einj.is_rch) {
>> +			if (cxl_aer_einj.dev == dport->dport_dev) {
>> +				cxl_aer_einj.dev = NULL;
>> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
> 
> Given the output of this is always force cast, maybe move that force up to the caller?
> 

I think that works if it remains an internal helper and isn't made a mock function to to_ras_base(). 
If to_einj_ras_base() is used as a mock than it would require changing the to_ras_base() 
as well. 

>> +			}
>> +		} else {
>> +			if (cxl_aer_einj.dev == dport->dport_dev) {
>> +				pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
> 
> Not locally obvious why a thing called to_einj_ras_base should put anything it didn't
> get.  I think this needs a restructure to more obviously be tidying up references
> that were held over the queue. At very leads needs a comment.
> /* Reference held from X no longer needed so drop */
> 

The ref was incremented in cxl_aer_einj_write() on invoking injection. The ref is 
decremented here after its usage. RCHs are excluded because they dont have a SBDF.

>> +				cxl_aer_einj.dev = NULL;
>> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
>> +			}
>> +		}
>> +	} else if (!cxl_aer_einj.is_rch) {
>> +		struct device *dev = is_cxl_endpoint(port) ?
>> +			port->uport_dev->parent : port->uport_dev;
>> +
>> +		if (dev_is_pci(dev) && cxl_aer_einj.dev == dev) {
>> +			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
>> +			cxl_aer_einj.dev = NULL;
>> +			return (__force void __iomem *)cxl_aer_einj.ras_registers;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +#endif
>> +
>>  static void cxl_unmask_proto_interrupts(struct device *dev)
>>  {
>>  	struct pci_dev *pdev;
>> @@ -238,6 +428,14 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>>  	if (!port)
>>  		return NULL;
>>  
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> 
> Wrap with
> 	if (IS_ENABLED()) to keep it visible to the compiler.
> 
Ok
>> +	if (cxl_aer_einj.dev) {
>> +		void __iomem *einj = to_einj_ras_base(port, dport);
>> +		if (einj)
>> +			return einj;
>> +	}
>> +#endif
>> +
>>  	if (dport)
>>  		return dport->regs.ras;
>>  
>> @@ -458,10 +656,20 @@ void cxl_ras_init(void)
>>  	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>>  	cxl_register_proto_err_work(&cxl_proto_err_work,
>>  				   cxl_proto_err_do_flush);
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
>> +	cxl_ras_create_debugfs(cxl_debugfs);
> stub that in a header.
> 

Actually, during rework today I moved it to cxl_ras_einj_init(),
a new function. Thoughts?

>> +#endif
>>  }
>>  
>>  void cxl_ras_exit(void)
>>  {
>>  	cxl_unregister_proto_err_work();
>>  	cxl_cper_unregister_prot_err_work();
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> 
> As below.  Use 
> 	if (IS_ENABLED())
> 
> and keep everything visible.
> 

Ok

>> +	if (cxl_aer_einj.dev) {
>> +		if (!cxl_aer_einj.is_rch)
>> +			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
>> +		cxl_aer_einj.dev = NULL;
>> +	}
>> +#endif
>>  }
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index 14bb3bdb2d092..5071cf86e4a68 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -110,6 +110,14 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>  	if (!dport)
>>  		return;
>>  
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
>> +	if (cxl_aer_einj.is_rch && cxl_aer_einj.dev) {
>> +		severity = cxl_aer_einj.correctable ?
>> +			AER_CORRECTABLE : AER_FATAL;
>> +		goto handle_ras;
>> +	}
> 
> Use instead
> 	if (IS_ENABLED(CONFIG_CXL_PROTO_AR_EINJ))
> 
> then compiler can see the code (but remove it) which means
> you don't need the dance around the label below.
> 
> In general follow this pattern anyway rather than #if 
> when you can.
> 

Got it.
>> +#endif
>> +
>>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>  		return;
>>  
>> @@ -117,6 +125,10 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>  		return;
>>  
>>  	pci_print_aer(pdev, severity, &aer_regs);
>> +
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
>> +handle_ras:
>> +#endif
>>  	if (severity == AER_CORRECTABLE)
>>  		cxl_handle_cor_ras(dport->port, dport,
>>  				   to_ras_base(port, dport), pdev->dsn);
>> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
>> index 09bfc7194ef31..b313adef680ae 100644
>> --- a/drivers/pci/pcie/aer_inject.c
>> +++ b/drivers/pci/pcie/aer_inject.c
>> @@ -14,6 +14,7 @@
>>  
>>  #define dev_fmt(fmt) "aer_inject: " fmt
>>  
>> +#include <linux/aer.h>
>>  #include <linux/module.h>
>>  #include <linux/init.h>
>>  #include <linux/interrupt.h>
>> @@ -31,19 +32,6 @@
>>  static bool aer_mask_override;
>>  module_param(aer_mask_override, bool, 0);
>>  
>> -struct aer_error_inj {
>> -	u8 bus;
>> -	u8 dev;
>> -	u8 fn;
>> -	u32 uncor_status;
>> -	u32 cor_status;
>> -	u32 header_log0;
>> -	u32 header_log1;
>> -	u32 header_log2;
>> -	u32 header_log3;
>> -	u32 domain;
>> -};
>> -
>>  struct aer_error {
>>  	struct list_head list;
>>  	u32 domain;
>> @@ -316,7 +304,7 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
>>  	return 0;
>>  }
>>  
>> -static int aer_inject(struct aer_error_inj *einj)
>> +int aer_inject(struct aer_error_inj *einj)
>>  {
>>  	struct aer_error *err, *rperr;
>>  	struct aer_error *err_alloc = NULL, *rperr_alloc = NULL;
>> @@ -332,10 +320,14 @@ static int aer_inject(struct aer_error_inj *einj)
>>  	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
>>  	if (!dev)
>>  		return -ENODEV;
>> -	rpdev = pcie_find_root_port(dev);
>> -	/* If Root Port not found, try to find an RCEC */
>> -	if (!rpdev)
>> -		rpdev = dev->rcec;
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) 
> 
> { }
> as the else is multiline (see coding standard)
> 

Ok

> Maybe need a comment for why it might be an RCEC for injection.
> Is this an RCH specific path where there is nothing else to target?
> 
>> +		rpdev = dev;
>> +	else {
>> +		rpdev = pcie_find_root_port(dev);
>> +		/* If Root Port not found, try to find an RCEC */
>> +		if (!rpdev)
>> +			rpdev = dev->rcec;
>> +	}
>>  	if (!rpdev) {
>>  		pci_err(dev, "Neither Root Port nor RCEC found\n");
>>  		ret = -ENODEV;
>> @@ -482,6 +474,7 @@ static int aer_inject(struct aer_error_inj *einj)
>>  	pci_dev_put(dev);
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(aer_inject);
> I wonder if we want to restrict this to specific modules?
> 
> One for Bjorn probably.
> 
Because right now it injects AER to any PCI device. 

Also, worth discussing is the commandline currently uses multiple parameters for
a single sysfs file. I mentioned this at the top.


Thanks for reviewing Jonathan.

-Terry

>>  
>>  static ssize_t aer_inject_write(struct file *filp, const char __user *ubuf,
>>  				size_t usize, loff_t *off)
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index b3657b80564b9..65c22ba597657 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -27,6 +27,21 @@
>>  struct pci_dev;
>>  struct work_struct;
>>  
>> +struct aer_error_inj {
>> +	u8 bus;
>> +	u8 dev;
>> +	u8 fn;
>> +	u32 uncor_status;
>> +	u32 cor_status;
>> +	u32 header_log0;
>> +	u32 header_log1;
>> +	u32 header_log2;
>> +	u32 header_log3;
>> +	u32 domain;
>> +};
>> +
>> +int aer_inject(struct aer_error_inj *einj);
>> +
>>  struct pcie_tlp_log {
>>  	union {
>>  		u32 dw[PCIE_STD_MAX_TLP_HEADERLOG];
> 


