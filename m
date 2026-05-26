Return-Path: <linuxppc-dev+bounces-21493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E748CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 04:08:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPfPR5mLfz2xjQ;
	Tue, 26 May 2026 14:08:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779768507;
	cv=fail; b=BdVWHNrXGevtK1DUIHN3/TgH5a4H9NRmqp5pIs9dqyuIsBo32BxSEo2kUbmX/s70Fr/Iju807nEdg1H/oG2Ve0giNG/eyBkyq9ftzwo6gGI8HJEz/9j+/qoowE9OJTpAumPirlZK5/jRCWD8LMA5kUSpJwdU01IEbX2ZFQihhvsRGhXFzquOXB5sGG1MgGaFJl9SYg9pagTEKn3hmbEKpAtvlOmN/zEfAL4u3+2OWiLvoCbmfhydRzjNiStJrTDzAh5oOQSXy3f4PEQ7O5iUtVQ+U5fcKATUn+VsS4LcPf8dHysQGWmv+OciSagsUYl78Mlyi/FAfcmTm76mkOMqRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779768507; c=relaxed/relaxed;
	bh=H1wa/vOc37DuGUGcMX8xXDFEBv19tC9EHFAG1im1KrM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aOBg+HZ5VrLrIdWvvLoZAe4QMrxmMOoGvpP0cNyVx+/zL+1cVS1a2zSVP4VdFpmSc4p4vEIRLKLMnCt58TBITbtsxNb8vrok+NcE8mbtYJDySCazjJZa5PalgR0d+HQm5OZKMl4Xe1R1d68zx5xrrU5s8LIwwlHc93cVToO7trpd71JbHlTze91i97TKofnmczMB8uqjRSkdqgtfVX5rnsfrXBBKybtPQqBOr+600aNvOsDQ4T8k4zrcTNxwl2fx/dd/18wgnH1GzgZm2FYqSQ+ejJwTaNRRA53QyDfD9Po2/6UEIrIPiZO74Me5uOVotnaX1I4Dbnd9UFypTwAokA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d5zsihCa; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d5zsihCa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPfPM5d1Mz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 14:08:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779768505; x=1811304505;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1kFMe3YmsaqPrLLEVBhp6uZ5e12JmM0AUMQ92ELeOrI=;
  b=d5zsihCa3n4iZhd0OpbuptxytHlY03wSIo4g76mwNxcJ+V6I0ZzyGrns
   1PpeF69G/cXCoUT8rR0QT+6aD6b+duI86rqvx9SIbdetuT4aZSQ2bO2wb
   S7jp0u2WwRXl94jDuvAyTXB+6yb5XIZsEmyqKl9Es5SDylvy0m7J1+lqO
   L8eW+tk3ZgUBthtpgjfFHRu+B61KzwVkTHba4At6RzVqeEaVC46OLQx6L
   bHIX27Vwzri4yLZdyjnmvb/th8YSzC0HFsS1QNmdA2I6J74y3x4kAn7wr
   4LJMyB29ekPXwZY0uAFT2hVVLP9Vt7oKu6yb56SbRtvRNwWvemhMySYIl
   g==;
X-CSE-ConnectionGUID: nOs9oRWIR/uv1cIla0KVVQ==
X-CSE-MsgGUID: T61gct4tTyKJxubYSUa6WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80631951"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80631951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 21:08:18 -0700
X-CSE-ConnectionGUID: lJOEFnVZTnG/Hl3X8WK1Ag==
X-CSE-MsgGUID: 7Zb6FksMTTmp3YEKRwzcaQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 21:08:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 21:08:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 21:08:16 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 21:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIxmVrtNzdWc0poz959rOUeF9RwOYIJIZGWKk4OtRkQu1uHsgHtJvkTTmqXvJQOn0lWHJq/gL4xwwQ7r3v/xVGqq3yqf358HMCDEvaFezHpZFk0UnvpTifNGmsLBbckLlJtflleVAFDyIvxkdVcNBPLFRsq1mYhRH3aZgumrpPetHv2jClxEBHyF7UI4wIEYwuX333qSxvJnf6UWLa/YkhkJ3lse9WY7Tgk/Ze4Iq2Kk/mUN5zLfqVQJHURy198vEPOMXqiSRC29KSJzxIb75MKl0XOU8jO5ra3ripvppwCHThDSuO8ZE/mlJ64cxh0VbmyaJJFbeIX2ubSP3BvTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1wa/vOc37DuGUGcMX8xXDFEBv19tC9EHFAG1im1KrM=;
 b=bhS9EvDodUa8LggKGmLSYc3XZst+TMHVn6RJhw1ij4gem3fTnt4z42YVBI1BbWnL5dAfkVOQ1MjDpySO8mFKKbAd1ZVzLpRIbEpO7V9HURA0bB8a4BkDuAi+utbF9Sb8Hm2Hi0tkIOCDHymNeZ+S0OpTNEWyqnP5+FahrR2O6/KRLjAW0wCjQtTwyGBqQKfW88dS8+F0qYRmNk1LhBh4xKXiC5IBEDegUdQ1RvQIDAhOGAW+Gy36uqf7OubQJev8tpVy0pIYYlPo9GHLVDawKdhNsxXFOLcR2H7kt5e12ExAt+wT/toXNnVASaBZxAmPhXdsoJMIOR421x2rVwahLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 04:08:13 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 04:08:13 +0000
Message-ID: <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
Date: Tue, 26 May 2026 12:08:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: Srikar Dronamraju <srikar@linux.ibm.com>
CC: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, "Ritesh
 Harjani" <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Peter Zijlstra" <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <ahUQE-AgvOAQV_mI@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <ahUQE-AgvOAQV_mI@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To DM4PR11MB6020.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB4831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1471d8-e491-4e13-1526-08debadc67e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: wDR3QuWrCMI/LXp4H3pU0Scc18DQiAEbBKSmT6qirzIv0MHrWzYMMbFwh6geoFYt0p0aj0bzEGHc4YNlxa1XtFDyW0DzdcGb/hHbEEalcLfJvyG2j2fZHrrp7ryFbMc5vX69Alch0pAaUk4dQOFcqWv7fF8F40EA7PSwoEb0F3nX59raa/vbiYOlry1TT93hL4eS3F6FtXoPe/CJCpZkdP348W8n+zrQ8fe2yeBd3Yl+2up02v5+IulRuxj1Pbo7mf0LhFWsjyt6ERlLZKGX6J9zBEz/YNDJCeM6sk/r5yjB41GRG5H5tb9PCvOZ8quzy8Jyqi0SEZJW9pO/6s3sakYlFjjzt/3Y2LAdKEIbvYaq9wrdYcqhWAgl11rpgvGddA0YXiKCXq43DCWcvNqLr6aKJaw1szyPO8AWUzzJLUS+ex5cwgEShAanUB9QC3WmFXdqLsajCw0RWAiPbBb0IodwHBzDoJjTYsrJluE4kvOAiGceQH35z8vIhpKt5ofX6tgROC4VMWeXnH0+fvDXiR+ThAxOex0PDUVlU24AkBuoPctBQu6QLD3X0mIuRACpPM6H9kRCsjZ37Ez4iDzqtq5vNxwmvoL8pjMXg+mlFwKtFFg0ydeY6NPht3RtW+3lScQ4L6REvgz9/UEg8gl3bB+R/j99rYKFY0th4vhbVs33uwzrxgd6LHz5jfux17MaqibRnGzKd1iTJ2GzWGdR8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjYxeWdlSWEyaGh5NWtDbDdRS0NXUndYamdtNjdzY1FULzFTWGpYdUV3cERs?=
 =?utf-8?B?ajdWWFVKTFUwL3dmeXlNN21RWHZ1cVFXRVFmengyWldiWkxqNk56c1Y1djk5?=
 =?utf-8?B?N0hnU29MQnkyRStpRXJPTWVZQmhJL0IrbmNwMDUrd2VXb3dZYThFS2NwQVpM?=
 =?utf-8?B?S2tiRGdYbUppMjh2dkFRTHFFQmUvZ0haL1JQcFFCV2ljbXlrenB0eHBCZlRt?=
 =?utf-8?B?UWpzbEloTldLemY1RUhDc2J5K3RUZ2NjMDZkVC9VdXMzVlpuQjhQd1JqZ3lJ?=
 =?utf-8?B?eDZDcWhHNUVQNTFjVEl4cld5b3NGV3cxSmFjTHNVekUzQ2dkQTF3a2lES244?=
 =?utf-8?B?dXVrRG5GdmhLSEc0Q0IrcEVMWUs0d1g3RlNrT1cvU0RjaVRqYmVGei9LYkhU?=
 =?utf-8?B?MFB6UkRQVVdpV0NqeUh5UnYwRnZHbm5JVHEvQVNUVVh0Z1ZReUpLRTBFQmtl?=
 =?utf-8?B?SjEwSHpSUVVzNVZ6R0ZDb0tndDZIeU84MXQ3T2lNVU4wL1BLMlFvYitHWUpK?=
 =?utf-8?B?ZDVHV0RqVFF5TUVGYXozS2pnYnhVRkV1NzlIeXUxL0xOR1ZyaDJoY0hEdEcz?=
 =?utf-8?B?RWU2NTl1bkE3aWVSeDZQRXF6NC90MGJTS25aRGlvS0tjNm1YdVRlVmxzY0R6?=
 =?utf-8?B?aDUxSVN1QmxpSVk1K2hXQWo0dFlINlc0eDA3aW9kakFDeTJRV2wwY0hwUGpj?=
 =?utf-8?B?b3FOdHZHNldLUFV2SSs1dktrKzFGWXBZckJKWDFPQlpRVitwSGt5WjVUZmEw?=
 =?utf-8?B?K3ZLVkY2TXRsVC9pU1hNRHZhZ3gvekMzd0lsZXdsM3E0MHJGMS82ZUJLOVNY?=
 =?utf-8?B?NGN3RWpKY3l2MEFNeXFKTDAxeklEMlpJOW12VFJoTTM0U3V6T0VNLzUxdTdq?=
 =?utf-8?B?ZFkvWWh5M3pSeHp1Z0R0NldqYlBmYTRCNnBmeFRENE0wbWNIZUZmendmbmZR?=
 =?utf-8?B?L2VTamV5d1ZaNExSczFFaGVYa0d2bzZxNzRTWnpVMGlpU0pCTVZNVEhjYmhj?=
 =?utf-8?B?NkQ0TWJyY1Brb0pPbGVmY045RmZ0YkxOaURya1R5eVRrY2JnWHZ4UDBmY1RJ?=
 =?utf-8?B?VDFiK3dNUXZxcFh3UHArbXovZEVPcnU3SFhJa2crd2NETEF5WmdzR3VJSVR6?=
 =?utf-8?B?SUhsODVGNHB6dTBXTDNMS1VkcHdnbkxKTm1HUW9QTzc0OVcwT3Iya1RmNis1?=
 =?utf-8?B?SEx2QjB2UEcxY0E4L2dvclIvVmM0NExKWUtYMTlqWExWVkR3dDI0cWMyNDUw?=
 =?utf-8?B?UzFRWTVOS0Jyck5SVHcxNW1CZ0Q4M3owREw1elMrME9vMzZ3ZmQ3Z3g1anY3?=
 =?utf-8?B?Ymp0dHV3cDAyaU5jT3JGOVZOVUhnQTdDZWZoYzNxODU4K3dPV05rRWdMTTNa?=
 =?utf-8?B?Q3MyM2VsTGwrUGhqNDVhMjdjR2w0MTRxM1YzMjh5SnNLSEtoV1NuRzl3bWRr?=
 =?utf-8?B?ZTRyNzlVUjl2cFNlbWtib1RCRWlPcW04QXNDN05CSW9sVm1QdElpYmsrZ21m?=
 =?utf-8?B?STNBRGQ5NmxSL29uNmtSUTFDY0dNOG1xZGhYNmlqeGtGOC9Sa2xGZkZEZ1Y1?=
 =?utf-8?B?OEp6MElxSGZlZjkwM0dDZjM5d01sRGFjNHZMWW5DSGFjR1FGNnJUb3FqY2Rk?=
 =?utf-8?B?QS9RVU16Ym0vaGFBdUY5SHYwaU5COVMxcmFITWNYTStjY2kySkozUWp6SkJ2?=
 =?utf-8?B?dEthQzd2ZzVqd2w3ZTFrYXRCdWxrUFpnOGh2a2NUOFpSTk5zbHFtLzNvK1ox?=
 =?utf-8?B?T0dWNmhCak9renFjOCt2WnpDcXlWVjdLbEJNUUhFYWpQNzlkZG9xczhCS1FU?=
 =?utf-8?B?eHNqbFlJZzY1Mm5LWHRQTWl6eU54MjBNMnZuU0FIMlhqMytOeG9FVXNzSmg0?=
 =?utf-8?B?VklnOFhJQWhMMDAxSW9FMXVuUFZpMUpkek5vVE84aEFockhaTDZQNDB4ck9i?=
 =?utf-8?B?RjJHbklDV3NEcGt6WWhVZ2c1Uk55S0l5VlBnV2gybXpvR1dIVEZSRzBhQjFM?=
 =?utf-8?B?OFlqK1RVZjB3WWc1REpHeWJUeVFnZUNXSlo5MDVpZkQ2dGp5K3p3cEFjMWlF?=
 =?utf-8?B?SlpJcDhSVlBvREd6UnJHOWVJZlZGeCt4aksycTVJdzhnTXdUSk9xMzJ4aHlL?=
 =?utf-8?B?eGFtd1h1VXUyaHg5aVdoR0FQR0VaTVZYTis1UTZaMU94R0I2ZmtzUENyNTV3?=
 =?utf-8?B?V3RWWU9JcjQ2ZmtJWm4xdU5Wa3JoaVVyU2EyZHZFdjlYU3hyQ2dqUGhjdVVX?=
 =?utf-8?B?SndKTDZZR3ZZT2JxWHZlczEzeEdZTStVSFZjN0M4bUJoVGlwNUplWkU5aHRi?=
 =?utf-8?B?Y0ZLMGoyR05wSW5oZXVIekVHdkV1SUoyNEFmY2Y0cC9VRWtSTllVUT09?=
X-Exchange-RoutingPolicyChecked: rJsJoSQ2IugclAOKuKkWMGO63kQx1Z5FAWTFqtGNHW146Jij2AP5p8BuL8tL28cjKqxI0ZnPnefA+gt9V45m5v42HVhDF9P5cTRUVD3Sb41bjjjkvfKMIPtyp45bRdLFuKWApEhjA5aZ6I4s5ubiKVjq7o8uR6h/ySCXlXYlAqeD6Omf7KF5jlT3wUOQwldRIo5PrlhjdzZE2tJTV/XpY1Kgxjd2eSFpsMM/8WSgXQxgM9Ys5CZ8meOppolYY/JVnjJqZzfqBEy0Xh4HWjJ409uIRuwapdFrOJdGLiP12Grmhyb/jPXJzKO6z1rxGwHKJmd7LiwilGAXlkGJTmSqBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1471d8-e491-4e13-1526-08debadc67e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 04:08:13.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSpRjzeq9xiWHIOlVPm8107PZI8tOBzZ9ZH9zv5LK9ZiAhiEG6qfmFQXfwdaPS9CAnHOg78HBkPau8rHh+ghSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com

Hi Venkat,

On 5/26/2026 11:14 AM, Srikar Dronamraju wrote:
> * Chen, Yu C <yu.c.chen@intel.com> [2026-05-25 23:35:45]:
> 
>> Hi Venkat,
>>
>> On 5/25/2026 10:07 PM, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>> I am seeing an early boot kernel panic due to NULL pointer dereference
>>> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
>>
>> It seems that cpumask_first(llc_mask(i)) is accessing
>> NULL cpu_coregroup_mask():
> 
>> has_coregroup_support() is false, thus cpu_coregroup_map
>> is never allocated in smp_prepare_cpus().
>> This machine is a "shared system" VM. We should probably
>> let the LLC id generation fall back to using L2 id if
>> cpu_coregroup_mask is unavailable (which restores the
>> behavior before this patch). I'm wondering if the following
>> change would help(need IBM friends' help on this):
> 
> Power9 and below systems, dont have coregroup.
> Its not because of shared LPAR. But its true for dedicated LPARs too.
> Only Power10 and above systems have hemisphere where we add MC/coregroup
> support.
>

OK, thanks for the correction. Are you saying coregroup_enabled is false
on Power9 and older hardware, and set to true on Power10? Power10 has a
corresponding device-tree property, which is parsed to enable hemisphere
support in find_possible_nodes(). This is why has_coregroup_support()
returns true for Power10.

>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 3467f86fd78f..cf6c2e4190ab 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1042,11 +1042,6 @@ static const struct cpumask
>> *tl_smallcore_smt_mask(struct sched_domain_topology_
>>   }
>>   #endif
>>
>> -struct cpumask *cpu_coregroup_mask(int cpu)
>> -{
>> -       return per_cpu(cpu_coregroup_map, cpu);
>> -}
>> -
>>   static bool has_coregroup_support(void)
>>   {
>>          /* Coregroup identification not available on shared systems */
>> @@ -1056,6 +1051,14 @@ static bool has_coregroup_support(void)
>>          return coregroup_enabled;
>>   }
>>
>> +struct cpumask *cpu_coregroup_mask(int cpu)
>> +{
>> +       if (!has_coregroup_support())
>> +               return cpu_l2_cache_mask(cpu);
>> +
>> +       return per_cpu(cpu_coregroup_map, cpu);
>> +}
>> +
> 
> While this is a work-around for the problem in Power9
> It will hurt Power10 and Power11 systems.
> As has been alluded by Prateek, MC is not LLC on Power.

Could you please elaborate on the cache topology?
Specifically, could you clarify what the LLC is for Power9
and Power10 respectively? Is it always the L2 cache?

I have checked the IBM documentation available at:
https://hc32.hotchips.org/assets/program/conference/day1/HotChips2020_Server_Processors_IBM_Starke_POWER10_v33.pdf
According to the document, a hemisphere corresponds to a 64MB
L3 cache shared by 8 cores. Since the MC domain spans a single
hemisphere, I wonder why the SD_SHARE_LLC flag is not enabled
for the MC domain?

> So by using llc_mask as cpu_coregroup_mask() we run the trouble of assuming
> MC to be similar to LLC. So it will impact Power 10/11 Systems.
> 
> In commit b5ea300a17e3 sched/cache: Make LLC id continuous, we define
> #define llc_mask(cpu) cpu_coregroup_mask(cpu)
> 
> defining it llc_mask to cpu_coregroup_mask means MC should be LLC.
> This is not true for some architectures atleast on Power.
> 

OK.

> So shouldn't it be using
> #define llc_mask(cpu) per_cpu(sd_llc, cpu)
> 
> This should work for systems where LLC is sub-coregroup, coregroup (or super
> coregroup: Lets say some archs want LLC at PKG and cluster at coregroup).
> 
> if we do that, I dont think we even need the else case where we say
> #define llc_mask(cpu) cpumask_of(cpu)
> 

I suppose you are referring to
sched_domain_span(per_cpu(sd_llc, cpu)).

Indeed, deriving the LLC from the SD_SHARE_LLC level offers
better scalability. However, this approach would involve scheduler
domains, which can be truncated by cpuset partitions - a scenario we
prefer to avoid.

thanks,
Chenyu

