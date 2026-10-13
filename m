Return-Path: <linuxppc-dev+bounces-29349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C8CC6B03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 10:06:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3qk129R9z3br5;
	Tue, 13 Oct 2026 21:06:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791885993;
	cv=fail; b=jS+L6ym3sljjTZsw9ShHnwxm40ds7900/lALXupKzx3J3j/zDcgZPyGyySHbjJa1aWebFEMyBh3XaRPWOidiu9EQUu+UUfQN89jIC/34Nw6rli3K6H0YUium6K8XbGU+HUGZZKGLSQWRzUwboVTKrkJXJ94HdQ64VkOmicuClYV93bqdZ1OD8oKBNPIXnGXuDpmBkny6CxhS3D8v8A0dd0/qlG2/HW4OsiNWgbGRYmh7qATHLvXV/zFk+boHN5hBh/a/aEQJFjZbx14wcsBrpFCf61C5cs6ItSDQEqV4fUdszbTDjyUHfcq0I1IDfwZbNV6389Y7LokJ+S3p9K5Ycw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791885993; c=relaxed/relaxed;
	bh=5sGTvwVEnSGxNJGDvEtHk3FXU1u313FxewTkK52IO80=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PpMi8KFhxl8ZmF7rpSKVV1pUdkiB9hpOB8q1XI6yKg2teLGauYn8zUnJRCwu3xqqorGbmrcOPf0fPjooGX81eMj8puZCkcIddS4ccGIvu4oHgU2lTOqtOSxlG5ebuUGAsORbFCGZhmKUfrAiHxplKN/Hc68sPW5YhPvKoG0qKyhWi020mdX2K1j5GPK5R/wwoer0i/dyW4g8bTLw6kZaBQsRHHLtS+uLYYT2ZxoQhbiUEXRefCtEciBHhZMIrjx7+myRc0YABjdxvioqYwYAicvAXsN9LU8Op2a1NmdpasAN3a0qJnN3dnGOziKOHMqy1G809d+ntowb+JzQLkIewg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E+YWAz/J; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E+YWAz/J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 13 Oct 2026 21:06:31 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3qjz526Yz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 21:06:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791885993; x=1823421993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cS5FO8Rcc+HZSklSWi/LaVB62r0Y5y+eDGYzfG00O14=;
  b=E+YWAz/J8ywNL2D9YhnYpzFRvnXwCWruxfFr4OvtyENBgG4w5AzLwWSb
   H0qp6fp9gXjrU2qoNDVkQYoPCxKs0T9S2dL5wnBLwsU8M4jJlmirzOn2U
   dZmMkIVLHPjhJV3QxNYEa372fM9pNbrAqgMMhtICEXdSVAELSd+7gVk5i
   WQA1Uuj34jvX2WQzFRaEKqus5BQVg4rL4yRThVxjBIyBKaGpDSL39jVMx
   4q7Q18HMERCQ9RooEOFydhOuTvkkFzst5IfN4ABWKe6ShKjF8tnrstcFN
   0gVPuZL7bGdLm8Y5UfWpBKWx38VuYkVIij+qcFh06TQctZEZkGS/KhnY5
   Q==;
X-CSE-ConnectionGUID: xD9mhZfOQ/2sWsBYn/M+Rw==
X-CSE-MsgGUID: 2EHbuHMsTpqlTkyvzJrRdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="509157"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="509157"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:05:23 -0700
X-CSE-ConnectionGUID: maRVwQvISVyM4za8N7tgpw==
X-CSE-MsgGUID: KjKhRdvZTvqoEqepjr8vrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2899114"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:05:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 03:05:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 03:05:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 03:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdds/KTe1Rlj9Ni4AVWaWJr5/tMPMJHUE8tJXM81ttZwY/Gste3hUoWg28Bvd6T/Teo/Yy6jV46Pti1dKCYElJTkXIKVySTWrXOvz6njlA/TrHMR6hbP7X816elkLMjCUHWFQi7po8mWYuhxcBDXqTCvfP9+gnZ39976Tb/98gwhuaQtyDNhrS1mOptx6NKTeMZOCQpkVPcDrUA0TqBQzl7Ir/QSLCThThfsduVHg6Ydl1dNFujg/WnZfhqPyxs3Fr/ZIFKK41MlhP8wlXuEoub6ceYGSuscsll+xW9fgvKk6dOc/TWVzMzliFtQuL8BOn9V7JYkz5AyH3t/8AEkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sGTvwVEnSGxNJGDvEtHk3FXU1u313FxewTkK52IO80=;
 b=dBMEx5vdgdPWsF30WHT/xhvepPs9II9CPPKcHmrDWpsbm8KiWsgO76eT2kqF/c/fpi7Urfl/+hYui42P0Cy0Z3rlZzPmKp9Y5mMs4p4PQZdvAcr4dWykLgQI5CStt9oDOEdWlkxBIN2mxtK8YP2dyATI8WDg6Iv6EtELN12TguTwOD69QEDecNiEBFsiUE2dtHJ5qIfJK4PPX0HvpbUhhHnD3xDojJ9k/+eowMwSKcap3G5zTAhxXYt4PZoPURby7TEwkPoOcJpsvHP4fOD0wk2KDZVKPAzi/IV5AG/uJNJ9Cro7TJEKlVNzFiEp9cXlOkkjfUngDAutv7pzQgGXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 10:05:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 10:05:19 +0000
Message-ID: <51744944-51c2-4989-8ca8-41a8c53ed1e2@intel.com>
Date: Tue, 13 Oct 2026 18:05:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
To: Tim Chen <tim.c.chen@linux.intel.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>
CC: <christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>,
	<ritesh.list@gmail.com>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>,
	<vincent.guittot@linaro.org>, <srikar@linux.ibm.com>, <npiggin@gmail.com>,
	<mpe@ellerman.id.au>, <maddy@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<peterz@infradead.org>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0042.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::9) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f00e8ef-5230-4b88-e2b8-08df29117cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: WKf+XX3pRkxWHbPVqVTDfDtOnrDvya2JDgwbztVC4c1I+AZ7/Ju8ZXOA/7LpNd0nS+wPEWptVKIj8O5f4iR8RKglIkLQtgTUPpdzEnFGw396sqjCagXEx7NL+GMHQFIZWwRKywNOpJ7HTBcsfDlBaq4mDS+wS3unEm7HRbP3CeSYYAEACsz0LGBhsgss+0uJ3mXk4s995SsZ5Oj+4GlwhpTEZs+tU3ZLCpKCA01NDmKXqAP9fEF71vogdxwkeqh56417QGLc5pkjQ7ibsWGGgrDIcWmaK0JDydjTOfTzguKlu4lrNdHggc1pQ4GIaPMIMmFX5hT90FX1XBIooW7mP8H1vnGVq2ur7ziaMpdyP9D2Jo+6l9axfQi729n7c7aXE4pQJvZ7sPTsdN+243JbOZqrrFacBn1EnAbUZAGqxQ1v3403WWDjh1mFOTofln+TjcJuuoZGfQ801ZJzC+FauRrB6VQM4Iiqb2C4eZiSC9jR02X7LVsK6N1w+Pol6TmxKXXb+9pWGEr+skwOH/x9ff4F2b8C4DiOZLo8GB1JpnY86z6TLU8pYn1xOWXboCZvJV2jZHHZpj795P2DUI0QwrzGyeIEJaN0PnZ+ycfUEZwRozsN95qNEn/+CCSMVVzaSRugQVn8qiWwca9QiFnfMIS8ZWElQc3zW5jwqTfVRvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdKMTlla2NYUFJKemlwcFQ2MHRGMlFCbnF0UW5SbDcxYlBWWFFxbkJvQnBZ?=
 =?utf-8?B?RXUvR0Zwb3Y3SkY5SHorVEdYNVFacmdWa1NkYmJwQnFBSEtUdzFZVXhQYU1T?=
 =?utf-8?B?ZjRTZlIxY0FUVWFuRnpid0RMUjFtMDZzdzV5cExJK0tDdFVhQUR6N2RIdGdx?=
 =?utf-8?B?dVBmU1QzSW9VcTh6NWp3Ymx4cGJOZHVrbmlFL0wvV0hmdWI2bll5UEZHRG5t?=
 =?utf-8?B?QlBqd0JlamErZnZrY0hzWGhyZllZMnBVT0pCZy9pcmF0UXFLeUZFNUlsN1hE?=
 =?utf-8?B?eWRnVnlpU3dxUytZM3lTL3dBby8rOVRXU2JEcWovV0ZyajErcDRoQi9LSVh0?=
 =?utf-8?B?cHZyc25IQWZYaGN3R21OVTFYTEkrK2VTb092Z3pQd0pySFl5dXlBbWh5bUhE?=
 =?utf-8?B?Wm95cFlGWDZ2c0FlTHVySkFIWmZkOXQxVHR5RzBYcjJkMzVpVFpvalQ5MnNO?=
 =?utf-8?B?dUdjY1dTK3oxbWYvWnF2S3R3TW5tRXBZNVpPM0tXaWtyMnVNUVFpL3huV1BZ?=
 =?utf-8?B?UytSOHA0QmNNN1ZNanMzeFZYTlY4Y2xsSll2Y0ppSE81c2hyYWlyZEhFekhF?=
 =?utf-8?B?eFUyWllCRGw5K3YrUVdsUTlsOHFaMytwWXJobFVXVUdadmhOZU9EcG9KYTBw?=
 =?utf-8?B?SjRELzhQeTNQd0xhZndQSSt5WXJ6bHh5MWMzQk9mQVk2VVQvMDN2SjN3UDRS?=
 =?utf-8?B?SGdMV05QNm96Ym9LeUpNTUpLajl3WHd5MXp0dFJ0M0NaMDV0V2hZTXRVclJL?=
 =?utf-8?B?bkFTaWdsMlc3UnV3NDYxVlhRS0hWajZSbjY0OEVYRW1oOTNsNzRGY3FKU3VQ?=
 =?utf-8?B?V3loRWprM1FUN0VTTFEvQi80dU1SR1hCYTg0OGpleW9vQU8vbzd6V0tUTC96?=
 =?utf-8?B?bk80T0hQVnBkUTNKeElvY0FEYStkTy9GZUVLK1N5YkZGUGVJR1NEN0tvUDNC?=
 =?utf-8?B?ajlrMVQrTFZLKzE2alo2aXNmK3ZhR2RIcWZ1MWtKSXNQTUZFQmFJdXhvZzd1?=
 =?utf-8?B?SUVrdU1OamprNUpmZW15UFAzNHZ1TjZId3pzQStubll0ZERGQ0R4Vm8rTzJN?=
 =?utf-8?B?NGdoWjZrZlF0clRFOEYxNTZxN21UUnlNbHlRWFJyc2phcGp4d1ZWVjJuWDRh?=
 =?utf-8?B?ckduQ1Z0UHg3ekd6Y2s4WjVydkpIYSt5TGgraWhXNmRMNHBpTnRXeDI4SEtn?=
 =?utf-8?B?cGo5TGpnbE8yTmRpZHlQWmU2MEFRVXNmWkNXSEViOU9ZSlVvaXBhbzRCaFAy?=
 =?utf-8?B?bUUzUXlUWnFKRTJzVTdqcllIQjhhMnRrcTQrT0M3VnROSldBdTZpS1VNNjdS?=
 =?utf-8?B?VTNPaERMd3hubXJBZzU5djVRLzNML0xKb3U0Z01MdmdueGs1ZXl3bmloLyt1?=
 =?utf-8?B?R1QyY3VoeUE3YXdPQzNYU0srcmpvbk5zMmNYekNIVEJsTm5ucGp1MHdPdGox?=
 =?utf-8?B?MFdtMnZSOHIxL0s0eEo2YS9JWHdOKy9HMzZGdjdwM2JjMzJDK0JUY1NXRmtn?=
 =?utf-8?B?RFZ3RmNuQWk0bG54eXFsNGNMc0hmakFVRGhCRERXL21jOVNOaWlEWTdBVjdH?=
 =?utf-8?B?NzMvU05hUGZwRjlrTmQxbnI1ajAvRUd4MTl4T1JSTVZ1RERxWXVRbHZPQ1hZ?=
 =?utf-8?B?MTd1SE5FbW1JaTBpUXJFNWROWTczQTZ5ZEtmVEFwaUhMb05EekxkUDNQMG1F?=
 =?utf-8?B?c29WdTBYL1BGSU95L3dHK2cxbWlLbGhONHUxakdqblB3UTNEZVNnb0M5cUI0?=
 =?utf-8?B?T0NOcE9GZjdhK3QwUHErcXprMEE4L1JmVkNUaHB2RU44bkcwR2d1UThlL3l5?=
 =?utf-8?B?YlhNWERzdFlwb01qRVczNG1CdDdJVlo2dUJhY1p0ZHhwdDlOdUdYYXNnQ3hk?=
 =?utf-8?B?VXVCK1c0ckU0Vk05Vmd2YVJ0M2ltRjUrZFpOR25BaTBVckdNeVYvbW5sUW1C?=
 =?utf-8?B?TncvZCswKytNcVpyNks3NWx4bHFoenh1TEVOSGhicXpWYklSUk1OMllSb3k3?=
 =?utf-8?B?WHBrMTRITlNnbGNZbHBoMTBxazRhMVdXUVZlek9tQzM4clFFYjVOOGl3T1pD?=
 =?utf-8?B?UkhRbWJMWmMvQlgvM1NSRzMyZHZHNmNZTU55ZEl4MWlscnZ0Tkpld1M5RXh3?=
 =?utf-8?B?ZFFRMk5oVkN0dmRFU3BUb1crd1k3NzEwYkZPWW9zNDFLMzFGQndJdHNweUhp?=
 =?utf-8?B?SXdiWWJVVlVhRVZPaGs0eHhSYjBZUDh5ZE4vQnNNRG1WUUhDUGhoWXJsK0Fm?=
 =?utf-8?B?RkMvRFVLcVcvbVFOTlBKN2RwT2t6VFRvRXV5d2g3WW85cFdRaWg0N25QWkJh?=
 =?utf-8?B?WjlNa0xXVVdQWEVuU0w1T1dJd0YyQnhvc09uc2pXL24reXBYVXdldz09?=
X-Exchange-RoutingPolicyChecked: XV6O/332L0stTQvVNzPGkrcqoGdB4aOok7wy0pg+fYuYdFgHTCKPTKVEa2MgZxbxAS202t3pG2NII4wZdxyilDYYyqzxry85M9N1A7k+NisKkYsCqeloDjmrjSjIO/98kWBaciwI0NngZ23W2Ch6E8vs1CWym8Nwdpei9PHNDiMM/q2RgX9EqgqWuQu16Fmp60/xkOa3ECLT9yArYBwXNIA0/a7dNqHBjxPgeR/Vl+ID+nIo+kMPCoPyWhePSizdylQ9s21tUmGnQ5/sK/y/I4XtPNUYZjlSS+D2JXe+hsipi/eZBLO6eiMvb9oczUl6QLICJuhrduF8SRMLROHX0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f00e8ef-5230-4b88-e2b8-08df29117cba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:05:19.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orANKaI37F+lD82DbRwxOGHeNc7mAVzQD3fS+Jt36rGZHgDIjI7C3r+SrQOw5J/KRxKZmr6d2jqwCCCPsvG2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

On 10/13/2026 5:15 AM, Tim Chen wrote:
> On Mon, 2026-10-12 at 15:50 +0530, Shrikanth Hegde wrote:

[ ... ]

>>
>> Tim, Chenyu, Peter,
>> Are there any selftest or patches which is used for
>> functional validation of cache aware scheduling?
> 
> We haven't created one. We validate mostly with workloads such as
> hackbench, schbench and yogini (which can vary the number of threads
> over time and track CPU assignment). I agree they are not ideal for
> functional checks of the load balance path.
> 
>> per-LLC occupancy in /proc/{PID}/schedstat may not tell the full
>> story when there are multiple processes and multiple LLC's.
>>
>> Atleast for functional verification, we might need one if there is
>> not one already. The reason being,
>> - At present, we may need a custom workload. hackbench/schbench are
>>    wakeup intensive and typically bail out even before load balance.
>> - stress-ng is per process. So doesn't get cache aware scheduling.
>> - A selftest could spwan specific number of threads till llc size etc
>>    and ensure packing happens till core_count(llc_size) by default.
>>    This could also be used for tunable verfifications.
>> - Provide an ability to observe how much of the workload was contained
>>    within the LLC due to cache aware scheduling or number of load
>>    balances stopped due to preferred llc.
> 
> A selftest would be great and much welcomed.
> 

Yes, that would be very useful. For functional testing, previously we
asked AI to generate a trial test script to launch a random number of
while(1) tests and watch their occupancy on each LLC.

thanks,
Chenyu


