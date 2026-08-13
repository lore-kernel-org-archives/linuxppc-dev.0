Return-Path: <linuxppc-dev+bounces-25807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B787C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 07:48:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLHXH5Hh0z2yNj;
	Thu, 13 Aug 2026 17:47:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786607279;
	cv=fail; b=VolbqEJwQkr9vQx5e6weiKTFjDtu63zKJOd0tUqgiZ8DqBbbcgl60IvfN+e2p7NxfPSSaQ2H9YeCYy5lpccXfRm/i9VXqOHYLIBHrTkejlerJdSKPLwKSar2U+/qeyfT+kzbg4rxBeIox4lTO9j9mOAQJvy4Rm6UufXTVgw560/WTKgUnMQrgndcFcsHiaI8RVMMam7kLysQBZYYhLRTUksTbbBlPOqkcKcwbJQiE/vZKynXcG5D15BiEZDjZkaOjxQl1xan30pFw8KTnjPFJbtNUSGwc7Gy9Jss7E7QaP8ipgHe/n7Moe0dMl9XYpmbYAfvXTi6r+10q8dUOvSv5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786607279; c=relaxed/relaxed;
	bh=F0BmmIQ6BNyVdAzouHBo3tUjV3siNfvPbjC1wo9bMOQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RF6c9yI+06fat6j6nXMZYCTQ9ZlDDrmZfbymglp8ddWMLVPOojZ5VWIyWQpfTmo6D8bnsxGjKlXFv+U0+rvjXVlrGsk8hvVFJWlOuv1JiSGh6MRNch7zeYdpLVJtnJJs9nPr+Vgy/Dcl19MytOiIa/qD19uTM7CeEqY1+SC2pJFfRZarH1nQvUyIY4Z0quMKQXewY9i4FevAeaCnUVS/stpXobH/4YvgicE0mS8FADHPTV36A4uIohKvJ6oZ2zVXtvdQNYaCLhXRwi+0m0VLXnSynzQMCVdhrFqAxsUsiFOpQvcsiA6Q0PpyNGKfrL2iO8ztiJFVaVe4CY8+kCCE+g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Epova0EW; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Epova0EW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLHXB48ncz2yKD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 17:47:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786607276; x=1818143276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iSeO8C8Z3BAF3B62ldaVKRb0XtJICBG5YERVIK0v37w=;
  b=Epova0EWPzdCxTaIumuJ5MPGy2IeJPUBIi7QbUSEjUUgdecUepfg1jHh
   16vbd6ctxSdl37/BZ7ICC97F6BkiPSEKKk9uV2z0rYmgA+CiXUwELcgwj
   HPgRsGZHS+fJ7HR1jilJI4vMKxNmfGgtWQm+a3iaXUd1m41ZA4S82YtUp
   H9pjY8pS8l166GdO8R+jqayPqpBxl/TewQmUHeZHtPiSDiyZMB3WSPHaW
   e6TwqkqCVjn0LR7ZW37OMYoMWejR3XaMaQ+0kM62OHHbBL6aPXlpHcppi
   FA06i0HeS0Kn9viVbXz8A4eWxYb13e01Edq/M2vZw22FuWuuQzdHh1lwv
   w==;
X-CSE-ConnectionGUID: OBJDAASzSsquLLZ0XahjYg==
X-CSE-MsgGUID: Xr2rf5hFT16NEG9uiJVJdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98689699"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="98689699"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:47:48 -0700
X-CSE-ConnectionGUID: 7PR+juPzR2GNA7eFLfSssQ==
X-CSE-MsgGUID: MvaelfsdRMKwcbxdrNBlAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="259617964"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:47:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 00:47:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 00:47:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 00:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B13hyKj12I3Ftwbyy23nqcH5zkIRYnHM1K2xAvQElIKyYfsgHZZpPYygKv3aWZ0OolwUUxaWKQwqdssGDlVUKT6e4bTMCMoOTd2Fg04nHYPjBgz4c23i4QXTDeB9wPej/dLmnGY2g2MEh2Qg52AZu82Gxog8cDs0eZP81oJEMRD4+0u0yreNYn4IY81yASKkXNx/y+qbc8H/4xM0aBJ080oPs2f930Raa7f+tGSTV/6NT0YGFeANgTmXxUTCSItL1GCDBpVz76m2/oyh/BXYiLtpqEJDYOgXhhQ/BqN5JmpJ8e7lV23cIeufIDGfwC6vNTt6b4eFg8fqWPehjHExdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0BmmIQ6BNyVdAzouHBo3tUjV3siNfvPbjC1wo9bMOQ=;
 b=mW2le2/rE5O7UCj2ZhXbHElavyZqJ6zmRJ5akQX+I4oV84ZD60axiBq6oMtcNN3y3oNaeHlVLJ6yH//ERO4TEC79TRO0y3+yXfNYuRFnJKt1JPurQpxDcZQdT/ueWdjY/x4OnBj1bvpYhDWb4ocuGgqdJmLWTmj+ylOQoMKl194mOGgRbvJKD9iZPVfV0Op1nHB/Ta/fpOxo+jXeUNECVAYkI4vcJvTop1dfzS+bPTvgcDWxNeevBJEduEZQTh77VpIFGVOHq+4P1vhhuoHFHsutPNY0ewgrC7c3NdZ+sh8t+ThZ21W+PNhKsQJ+lL14eCiXvPIVcjr0gcPb4s/Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 07:47:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:47:43 +0000
Message-ID: <ecbfbe14-5202-4efe-b829-1eb2590cceaf@intel.com>
Date: Thu, 13 Aug 2026 10:47:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
To: Athira Rajeev <atrajeev@linux.ibm.com>
CC: <acme@kernel.org>, <jolsa@kernel.org>, <maddy@linux.ibm.com>,
	<irogers@google.com>, <namhyung@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <tejas05@linux.ibm.com>,
	<tshah@linux.ibm.com>, <venkat88@linux.ibm.com>, <usha.r2@ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-5-atrajeev@linux.ibm.com>
 <a6424439-d42e-4f62-92ee-525c7f2d4277@intel.com>
 <00D2E602-E43D-4D23-9304-133263424B3B@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <00D2E602-E43D-4D23-9304-133263424B3B@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DSWPR11MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: b0303865-b216-41fa-5ff0-08def90f288e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|4143699003|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: jz5TK7R/uXCfR2BeHHgG6Ooph/E6rDit5xov3zdJ1bVE2IT3ILjbXWxzg3BoFn1HPuXmokFYu3TUgPm1l74hy6HswOM33AaQHxhbGiU6AJMbHS2mVbPlRXoPwCmqOrO9SFopp/S78/HYpEcGmY5M2TrBp7pYUdz0mOQwkbd79fykwfdQUggP0ylYnEqL0SAkFoHsXsBFVWQhV7wdjHP99Zh12KbIq3jTmYbaGlN3MkKaT2usFkfRw1drQbc81xn9yzK1qjQ1OBZXMhburtlAwdtwVPYKkpE/IpLM95HxxZf21YXQc9TuLbVIEhOma0rpVEAN4RZyOOQSvhSb2eRcrctR21/lQ9p6l8oyndgVjDcs+wR1S1oJV93RA9dgctnhftIKtqjHUKh4ddxZnpAzkm4TAQN+yjFcqqQQOf/vlPZ8Kv/D23JjReZfKKP7a9KklQvQ29YlXQooQkyk0cDKjomfRIf7MmdqGAg8DufK3oTKjcB9HjiPNuaGVpwXEiQKAwmoBm0Eqn9d9NnnYd8BXUSrzy3z9fZXjQgfTmVKvVLofOqGf1bRugyQWNtTls5CN8ciBPhpsgymqZ3BxGMDiKPYWp73EyvfVcj9lE/w1Q8Zmn/yASUZZebVvH4MI3fxTOtLSCOdBB9077DUDfk4iPHQ6lhQppF0hFiTjXaXOkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VtU2VxK0N5MHhQT0JIbUkxQVRLdTF5QzVUZjVqVHRVeklReUlVK2pjVEZs?=
 =?utf-8?B?VkZWd0JXOEpWMkIvVjhsNEtrYXJRWFJadElQMzdQYUJpb0FxcTFDeUR2MXZU?=
 =?utf-8?B?SWROVmdBOU5zSWRFZDhkTzdwZEZWYmZCSXBCeWVXalRTbEFHREJrN0RVTjM5?=
 =?utf-8?B?aTZFcE1MdHNBRE9raURteGxOS1o1RWNlK1hCRlZmcXBUZXdBKzJIcEJPWkh3?=
 =?utf-8?B?ZllkYzcyQ2ZMK1RQaVVoK0ZjZloraUFiaStIdHM4Q3dENk9uZGhTRmJadVhR?=
 =?utf-8?B?dERla1pXVjJDS25FSmVQK2ZDb1dIbkwvOCtmejZ4VHA4bmRUK3F6WGFzeGc2?=
 =?utf-8?B?ZXlGaHBmV2dVMHBRRzlBeUFTR1Rtb1JnNWhzY0w0Tzlaa213cjk0ai8reHpU?=
 =?utf-8?B?YWIwYm1PdFdSVXFEZnNuTUlJMm5ocVZLa3R5VWVhQmFRZWtWOTZZSi9XWW85?=
 =?utf-8?B?UTliOFZ1R3pUVGZYQllmYnFsdzdKaXZVcC9WODNEamhyY3ZsNk9HamVmemFp?=
 =?utf-8?B?NE5WcXplK01LRjdxc1NiZ0FOQURWdnpVVE1oM2xncHN3KzhhMnFKZWVzZzd0?=
 =?utf-8?B?N2Vyd0I0LzVlaW81czgyT1hYenNEUkNBL3hlNHBHLzl0NndtcW5nb2R6RGY0?=
 =?utf-8?B?YmdzakFQWUVGeEtxcmZQU01RV05hUDE5VHFtQ1ZsWHZmQzB4ckFGcTlKUldD?=
 =?utf-8?B?SjYrbHo1UnNweFFTaWZKTEFzMFdpSSsreksvdWFjUFA0aENmUG1MT1hIYWE0?=
 =?utf-8?B?T2Fwb3VIaWhNbzF5WHVmaDhnaHJaZzhWamNVcm5SY0RHY1VLUmtPSTFwSHNJ?=
 =?utf-8?B?dklVci9pS0laVUhSMFBmOFVqeGljL2w5ei9BWEpoRVU0bkV5bzhJYjYwVThD?=
 =?utf-8?B?aytWWTZqUGxNYnVGZHZQMC9ZbEE4dWs5Mkc5eWsveURla1R5Rmd0bnQrcUVG?=
 =?utf-8?B?bkNiUUpmUG9MbGw2ak55WncwUzJ5cGpuait2TFpTYUREU2Rpa1BUbytqTzFC?=
 =?utf-8?B?cDlFbDhHbmU4K2hwSzl3RjA0Zm5oUWxNdjUxZXRCQVFHZGpQODlLa0VXUXhM?=
 =?utf-8?B?RDhwZ1ZjVy9SdEpBMUhLamQ2OS9MbzRIOTNDK1NZUlQ0ZXBGRnNoREhNRk02?=
 =?utf-8?B?cFdaU25nWHE3TC82anBvNE5nN1lxVUJFWXRhY2pPblFGVkxsVUZHdDBEbGFC?=
 =?utf-8?B?T3BuT09ZdWpacHpiVS9Dc3B4Q1lTbDRnUTV1ZkcvQ2xacjB4SjM5RzNLRU5J?=
 =?utf-8?B?UFkrc3kzemJBY1dCZ3pFMTdvRlJSSDNXYzd0K0c3c1diR3NUVXdHbTBSSjBh?=
 =?utf-8?B?Z1VORGc1RWw3VUd5ZHE5dzJlY1hVa2xZcWlqNytNK085SDZGbnE2TTNPNkdL?=
 =?utf-8?B?dEpkbTJWbVhzMEJxTlNBOVlZOGJ1UGMwWk9tTUhFYUVFMkREMytSZkg2SGhs?=
 =?utf-8?B?OFdFYkRYSXREYTJZZ1JDNHlqZ3c2TXl4RXNTRHhYTTVSYzZXclQ0dFJFR2U1?=
 =?utf-8?B?YTc0bmVmcDZHeWlVbG00ZnQ0djRrSEFScithdTFnNVEzR3FPcjc5aGFxVThp?=
 =?utf-8?B?ZnBRbE92NkRxVTY1Wk5Yem9hMVh1U212UHlZOUQwUkROdU5wRyt1R3RSVy8x?=
 =?utf-8?B?NERtNXFIZ0lhMEN4TGF5eFZ2aUVOaXR3MU1aMjZoVUxjNkwvVnkzY21ud1VP?=
 =?utf-8?B?RW1CcnVWVVBSWjhZSHRoelhjU2hYMFd2ODNkaVMrZnkzdFJ5VkNtQzdLYS9h?=
 =?utf-8?B?NExlZXpVSDdxa1ROU1JaeFdNMVExUVM5eXJubGI5am02c3pocmdsMDJiOVV2?=
 =?utf-8?B?NituVTVkelVjUGhzeHdvbTByQ0p2Y1dpajVySi90d045MkJIQVRjSnZ3eTJM?=
 =?utf-8?B?RFNwRXVLaUdZLy82QTZIVzhsbmswRkdpWnZJMGExclNTbGl6dlhLY2NRT1hq?=
 =?utf-8?B?RXp1YVV6VjVnNXoyY1B3QmpmWVRDamhBa21RMHFTYnhWaEdDaFEySk1OUGk1?=
 =?utf-8?B?ZEd4SXoxVE1nY0FjbzNJeHY4TnRRY2t3UkxJOHIwNzdhSlBCY0hkSDU4OXla?=
 =?utf-8?B?YVB4UE5lT0F1R3hqQU0xQnlGYnhvUUdIa0VlYmpwamF1Ti9aM0wwUVpRN1lQ?=
 =?utf-8?B?WmpmaW1tdUJNQk5hMFBOWkxGdnNCNUd5aWhmZ2Rob1JiMnhQZVpuMUxPWEU0?=
 =?utf-8?B?TzFRSXo5MlNXc3pRUEVJOS9iYm94NXEwVjVvcnJpNWZXWGpBMklVdTYwaTUy?=
 =?utf-8?B?SW01dEhZK0UyblRpc2xISWVYbXlERkNtNkhwdDU1VzRvSkZGcWp1YklBMDE4?=
 =?utf-8?B?eldZUktiS1N2K1U3b2JwcHVSbnJJMEl3enBtd2lab252ZkVESEh3amVQNG11?=
 =?utf-8?Q?n2f0E3x5NnZ6fXJw=3D?=
X-Exchange-RoutingPolicyChecked: imGnUvglCa7y/jqqZY6+ak/uxgN//v205juT2D6FziFEMJcAbEMUfJfxIkbLb6ZEomELUlllROKa8KaJwijOqtNi9jo+/E7z24ssp+fh32vJ4qW3zdKzyMuwqa1g1Mn+ZtSS32AlVgvCJgtcmBU/N7e4NL7PWp6LIwfs9Qu8ptoIoldSIIAy8ndtSiE3KixyruR50GfCSOYxfB6BZ/qXv+ZMV8KvPcST5mACJluccjyurXymrAdrdh4amuk5j9cK03GYD8Wqxpj/B/imV3Lc492htK6jtTKcoXZHA2l6Hn4TptmK4eftbSlg8htoqGD1pyrFwJHxvKPac7stb7EsvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0303865-b216-41fa-5ff0-08def90f288e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:47:43.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWnBB4LtwP2vXbb5LvqU15QJtQnrE18rP8Fw2eu3ZrF6bwIZwiYPhZU+McHEN2fuJ5iow9ZDwPi4WiwFqh+CSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9715
X-OriginatorOrg: intel.com

On 13/08/2026 10:36, Athira Rajeev wrote:
> 
> 
>> On 13 Aug 2026, at 11:52 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 07/08/2026 17:41, Athira Rajeev wrote:
>>> Implement the arch_perf_record__need_read() architecture-specific hook
>>> for powerpc in arch/powerpc/util/evsel.c.
>>>
>>> The HTM kernel driver sets event->count to the number of records still
>>> staged in its internal buffers (total_size / record_size), and to 0
>>> once the stream is exhausted.  This hook reads that count for every open
>>> htm evsel via perf_evsel__read() and accumulates the values into
>>> total_pending_records.  A non-zero total means at least one HTM target
>>> still has records pending; the recording loop added in the previous
>>> patch will perform another mmap-read pass.
>>>
>>> The drain uses a two-layer safety check: event->count detects records
>>> staged by the driver, and record__bytes_written() in the drain loop
>>> confirms data was actually moved into perf.data.  This combination
>>> handles the case where the driver count is briefly stale while hardware
>>> is still flushing.
>>>
>>> The implementation scans the evlist using evsel__pmu_name() to identify
>>> HTM events by their kernel-assigned PMU name rather than the
>>> user-visible event name, preventing false matches.  It iterates the fd/
>>> sample-id xyarray, and skips any evsel whose fd and sample-id arrays are
>>> mismatched to avoid reading stale state.  When the accumulated record
>>> count reaches zero the hook returns 0 and the recording loop proceeds to
>>> disable and close the events.
>>
>> This looks like the proposed driver:
>>
>> https://lore.kernel.org/all/20260701083806.79358-1-atrajeev@linux.ibm.com/
> 
> Hi Adrian,
> Thank you for the review.
> 
> Could you please help clarify which specific aspect of the driver breaks the perf ABI? Is it the sysfs format ABI where encoding raw hardware topology identifiers (nodeindex, nodalchipindex, coreindexonchip) are used as perf_event_attr.config bit fields?
> I am trying to confirm so that I get your feedback correctly for reworking on changes.

This "draining" and "read" usage looked unusual, so I asked AI:

  I have just applied the patches for powerpc htm kernel driver - they are now the last 5 patches committed. Examine the design in
  comparison to how other PMU drivers are implemented. Does it violate the kernel API for PMUs? 

It said yes.

> 
> Thanks,
> Athira
> 
>>
>> breaks the perf ABI.
>>
>> I am not going to review any more tools patches for now.
>>
>>>
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>> ---
>>> Changes in V5:
>>> - When an HTM evsel is a group sibling (evsel->core.leader !=
>>>  &evsel->core), read through its group leader's struct perf_evsel
>>>  instead of the sibling directly.  perf_evsel__read_size() uses
>>>  evsel->nr_members to compute the read buffer size; nr_members is 0
>>>  for siblings, so size=0 is passed to readn(), which returns <=0 and
>>>  leaves count.val=0, causing the drain loop to terminate prematurely.
>>>  Reading through the leader avoids the zero-size buffer and correctly
>>>  accumulates the leader's pending count.  HTM events are always
>>>  standalone or per-target leaders in practice; the leader redirect
>>>  handles any grouped configuration without losing counts.
>>>
>>> Changes in V4:
>>> - No changes from V3.
>>>
>>> Changes in V3:
>>> - Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, "htm")
>>> to identify HTM events, matching by kernel-assigned PMU name rather
>>> than user-visible event name.
>>> - Remove the redundant two-pass loop (first pass to set found_htm,
>>> second to accumulate counts); a single pass with evsel__pmu_name()
>>> is sufficient. if no HTM event exists total_pending_records stays 0
>>> and the function returns 0.
>>> - Remove the dead !strcmp(evsel->name, "dummy:u") check;
>>> - evsel__pmu_name() will never return "htm" for a dummy:u software
>>> event.
>>> - Rename total_pending_bytes -> total_pending_records to match what
>>> the driver actually reports (event->count = total_size / record_size,
>>> a record count, not a byte count).
>>> - Add #include <string.h> for musl compatibility (strcmp() without
>>> it warns on some toolchains).
>>>
>>> Changes in V2:
>>> - Implements the renamed arch_perf_record__need_read() hook (V1
>>>  implemented arch_record__collect_final_data()).
>>> - Skips evsels whose fd and sample-id xyarrays are mismatched, avoiding
>>>  stale-state reads.  V1 had no such guard.
>>> - evlist__enable cycling is removed; that responsibility now belongs to
>>>  the drain loop in builtin-record.c added in patch 3.
>>> - File location changed to arch/powerpc/util/evsel.c (V1 used
>>>  arch/powerpc/util/powerpc-htm.c).
>>> - Patch is now 4/6 instead of 4/9.
>>>
>>> tools/perf/arch/powerpc/util/evsel.c | 77 ++++++++++++++++++++++++++++
>>> 1 file changed, 77 insertions(+)
>>>
>>> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
>>> index 2f733cdc8dbb..2b7851c70677 100644
>>> --- a/tools/perf/arch/powerpc/util/evsel.c
>>> +++ b/tools/perf/arch/powerpc/util/evsel.c
>>> @@ -1,8 +1,85 @@
>>> // SPDX-License-Identifier: GPL-2.0
>>> #include <stdio.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +#include <linux/string.h>
>>> #include "util/evsel.h"
>>> +#include "util/record.h"
>>> +#include "util/evlist.h"
>>> +#include "util/debug.h"
>>> +#include <internal/xyarray.h>
>>> +#include <internal/lib.h>
>>>
>>> void arch_evsel__set_sample_weight(struct evsel *evsel)
>>> {
>>> evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>>> }
>>> +
>>> +/*
>>> + * powerpc implementation of arch_perf_record__need_read().
>>> + *
>>> + * Reads event->count for every open HTM evsel by issuing a direct
>>> + * read() on the event fd with a plain u64 buffer, bypassing the
>>> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM evsel is
>>> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on its attr;
>>> + * perf_evsel__read() would then call perf_evsel__read_group() which
>>> + * sizes the buffer by evsel->nr_members (0 for siblings), causing the
>>> + * kernel to return -ENOSPC.  Reading the fd directly with sizeof(u64)
>>> + * retrieves the HTM driver's plain pending-record count regardless of
>>> + * group membership.
>>> + *
>>> + * Returns: 1 if more data exists, 0 if collection is complete
>>> + */
>>> +int arch_perf_record__need_read(struct evlist *evlist)
>>> +{
>>> + struct evsel *evsel;
>>> + u64 total_pending_records = 0;
>>> + int x, y;
>>> +
>>> + /* there was an error during record__open */
>>> + if (!evlist)
>>> + return 0;
>>> +
>>> + /* Read HTM event counts to check if more data is available */
>>> + evlist__for_each_entry(evlist, evsel) {
>>> + struct perf_evsel *rd_evsel;
>>> + struct xyarray *xy;
>>> +
>>> + if (strcmp(evsel__pmu_name(evsel), "htm"))
>>> + continue;
>>> +
>>> + /*
>>> + * For group siblings nr_members == 0, which makes
>>> + * perf_evsel__read_size() return 0 and readn() fail.
>>> + * Read through the leader instead; perf_evsel__read_group()
>>> + * extracts the leader's own count from the group buffer.
>>> + */
>>> + if (evsel->core.leader != &evsel->core)
>>> + rd_evsel = evsel->core.leader;
>>> + else
>>> + rd_evsel = &evsel->core;
>>> +
>>> + xy = rd_evsel->sample_id;
>>> +
>>> + if (xy == NULL || rd_evsel->fd == NULL)
>>> + continue;
>>> +
>>> + if (xyarray__max_x(rd_evsel->fd) != xyarray__max_x(xy) ||
>>> +    xyarray__max_y(rd_evsel->fd) != xyarray__max_y(xy)) {
>>> + pr_debug("Unmatched FD vs sample ID array for HTM event\n");
>>> + continue;
>>> + }
>>> +
>>> + for (x = 0; x < xyarray__max_x(xy); x++) {
>>> + for (y = 0; y < xyarray__max_y(xy); y++) {
>>> + struct perf_counts_values count = { .val = 0 };
>>> +
>>> + if (perf_evsel__read(rd_evsel, x, y, &count) == 0)
>>> + total_pending_records += count.val;
>>> + }
>>> + }
>>> + }
>>> +
>>> + /* Collection is complete only when ALL hardware queues have no pending records */
>>> + return (total_pending_records > 0) ? 1 : 0;
>>> +}
>>
> 


