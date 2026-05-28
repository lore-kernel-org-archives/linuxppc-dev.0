Return-Path: <linuxppc-dev+bounces-21632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61DCCD6E49
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 13:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR6Zk05rkz2xMW;
	Thu, 28 May 2026 23:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779974493;
	cv=fail; b=CvN3EiWxtfM/M4P5CBlaDG76aT3PEUMOks4xrc4SMNpaSlotjkwzFocIzr6rv6OAoqfJzAEgw0Cr9A6NUUFuN/GQd3LESNhI8Pz4zK7thqN+6jSSqFUxx01wzmShw7fAd7VdIcQepBR1rUirK/s1+SYTYpMbQbY1m5sbcZ+olpznO6u6YQgtwT9FaE0qxTDYVtPwBmmiDFwanERctHu6J8G77ImFz3Zm1LSsLzWCl1v4kP/uxkL55F16xqcY6mONepYR/DRfQ5omP1gRDgsRTceVMCV5OlO40h9gOogmP5iySPceGWIQENknWBxSMucAKppeGRS5FgpcNf/0fyf4Vg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779974493; c=relaxed/relaxed;
	bh=WiDiTbF5TR01HI8Wd+cNO9z9tYsbFFUlg0WL7R9n6P4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9dNGBFp0ZcSSPvcmHoMm8F2AbPNIxpDjESUiovXthd/q7VpXU4DiQBppX9Ur+D3NZOt3cy0Xfd4SkCCrsQe4ya5lQSc9lu+e615TjpxFOjDZTJLtYFK8Q6RvBy+S5s/IHCjfWI9pwNJGaypkgOthLnZo9gF7Bvway17JAuPxgYtF00xhDLt0RDEYEKonlwNecz2AfOeMeVOJk45afH/T/Py1RyKaGgkPYUYjeFLDZq4lkXjlda1KiCZClndcP7nwMU5BIg7Lvl4JxaZlhjmgoIQzUyEGBGgRqlLyVgk2mgTSohDpgVqJZgWVJMhX4yBTY6uIJbP5pwZIdc4RmKRYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jn65ytxK; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jn65ytxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR6Zd6RNlz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 23:21:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779974490; x=1811510490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWWs9fa/B6cLXm+aM8MaQOOBKBakkKCt+v2h4OGxtsI=;
  b=Jn65ytxKXVhdHZ11ufGyjXNqAZfdtVwmdEYqWmKg7+zcpxRHkjUGKn0f
   tDqcUMy8oANoheKIE9ZXleSuouj/68BP0KMzWhUpiOgq4XF5WYJ9gAZP7
   W0FhZu8f3wzNIoBRKoL24ApJpdr9LenC7vNQ80h44LVJPMAPGUFh3VLrB
   e8oPsczSreyQvS9Hx6PuVxmZysDy10U4NUs/qs0fy3GFfBNOnEKRAeh17
   t/WrRxFbNoWnMlnEJJJlYYHpcTSUh8eUjG6/ZuuQu9TMXJbnZvrIrTwlr
   Pim45He35GOuykuxjTVsVGt783I8K/g9C8Yv3EM0o5Lpm2ZUC8d6yfp3J
   g==;
X-CSE-ConnectionGUID: s9XS3WJ3THCaIyQkjimvNw==
X-CSE-MsgGUID: QZfiCEPRTSqBjXMzzfi1iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="98232152"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="98232152"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:21:21 -0700
X-CSE-ConnectionGUID: LOccHZySQ0KIivSklHfnmw==
X-CSE-MsgGUID: GfDME2cATROoVyf0db3OIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="238360179"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:21:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:21:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 06:21:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:21:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cInnUiYzcCV8x96utF5dyRdM34y6NO3qhfzTYyCqLdIAGqR0abWpCkmLED2hX/NZ04xOd1WxaLHIVOf9duGo9nKwqtlKbxQsufVyYFRoxy9I0G8l5/HCNoZ3P6pGT+xAKON3N4XTzZKj8ds4EPA+stl4bWJQrMvf4KG/9aP99eZ+waSeogJfsvBnkJTgHRZez4+22VCEmv2lxasuk7lUTaPckdyGIKKT/9rgwbZV1XHF6s7BfJ7Bhn2h5aZFSdjD0CXP9wjrt2YLwtx5e4mPmNAokd2nW6HVCdJNvsX6FQLmjfsNH7cFFyjQOSu7DJTBzx7g8NlcUSrs09UnCL8Alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiDiTbF5TR01HI8Wd+cNO9z9tYsbFFUlg0WL7R9n6P4=;
 b=Dj2YtHphQqfvBwbVxQwX0y1iQRv5J6p/uQrv0XpmtR3IrboCz22OQLpGHjSKxg6eBeLnck037ma/8Ujplfbmy8iSuavBA71S+omqY/Ek1Gz6MuWQDbk9idl+4XV3jwCvH4FU4t/tL916uXJ92LiXWeLVo9aoH9DPt6HLt5etjcm5TJ4wcN1WhVnK3Wey534bBh1RF0zsiO1aGpvqPYPJOWvhqHD7r+kumJ6mfT2FRL9Ho/2rC4fnwJxKqqSF3vWyCBOX0Y8qwi4eOc6TxUSGZ+AcleBx5raNvLNwJLBuJtWV8CpqKulNOxHeWfKuQae8wyqH9e+yR4RELFTkCfL++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6558.namprd11.prod.outlook.com (2603:10b6:806:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 13:21:18 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:21:17 +0000
Message-ID: <8935ba3c-4ced-43ce-a5b7-c5df91b466d3@intel.com>
Date: Thu, 28 May 2026 21:21:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, <tim.c.chen@linux.intel.com>, "Srikar
 Dronamraju" <srikar@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, Venkat Rao Bagalkote
	<venkat88@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0032.apcprd04.prod.outlook.com
 (2603:1096:820:e::19) To DM4PR11MB6020.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 636cfe6c-9215-4c35-821b-08debcbc0023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XA/tmuot+sQZT1Gmf/UeDbEAIlAUc1+ZfUg7VBBbC5DZLr4WcG6hs9RH9CmbM7sXcTpqEeOh2sk6bOgt4JcftMSi1uV3K7gpd6Tym+x+3U7FXIp4XUh6nBS94HKOUN6d7y/qTO5qElOhmtEwUUbW9955K/+OnyInPfuw0nYYs654VXK4H5ZNFLLoBF2RW+OA71sQodyz9mYElnlZtA9QsbvNm1aG45t//vL/FRUe6tzIs7GPo6Qdj2M0aaB3i9URpe84hYViuHl+5SVJRX9FJbaXD3Lu41NvbWdIVQ9eTkMLESCJu+wt2cqd+bqn7kFinh5kjJCqQH+JIZli/nxhVHnHYr6+qfFRhVZjU0uRRbiFHSYdfBYWSX7evDAKz1IYwsp4wD7hszdTKbw+Ns/GsmNStNDWsOzOR7kuWpeUPw9JFAGqPZu73AGcYFHS61FvcJPCv28NJ7wKn3k7VlyHgs6HCwQ2MfI4zPBmOAWwLRZgjOIj+sgvQ5juanpkAok7pZz8i3cgJtCHAWIJS4J8Kek96mE+dmcXuoZJ+3nHNVodZwzpoeZzq8nl4opQa4XMcPQN8FgKnzcuHsNOB/wnMrDmPtBP7SNulFnSBBofNjdq0t1O9Fd6UYKxy1sq7gXdkJqdNznCODX7yQY1rNAXdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhCcUZ3aUJ0bXRlQnJOYVV5OWJzbTZKeDM0elBGWUJYSnVnVDV0RW1PK0Zy?=
 =?utf-8?B?ZzBscjB4SjQ0dHh1Q0pYVlNLeFNsd2JYZjZXbFZoblc1VHl0L1EzamlYeHBr?=
 =?utf-8?B?SGoxQmpad1lRWm9FUllzRjBnZFdFb2NmNTc5bHlJY09hSnVaSjBEczBNZ2Zo?=
 =?utf-8?B?cGpLb3BTUE9NWmMySmNGQkxiVnZOZE4wdG1jL1NybFdGQmUzaUZWdHFKSEhu?=
 =?utf-8?B?TEltRkNTVlBSQllrY0VzVEV4VklHYno5V1BWTVE5ZGU2aFE0a3dUS3ZJVjI5?=
 =?utf-8?B?U3VacWlPMUZKSlhaNlVzQWFNS2hOZmR3YXFlRTk2KzBZMGdUb3hJdklJN0V2?=
 =?utf-8?B?eWMySkR1OGtiWHN3UTZvQXFvdko1NjZDelQ0VGJaT1U4N0VKUlRpT3JJcnll?=
 =?utf-8?B?SkhzbXRGY0R1MUFpUnU4TGdZd2R0TlNNQ0xLaXdTc0FiQ3oyTU1SNVRpYms4?=
 =?utf-8?B?R2FZS3lRR3RvR002RGFwZzhVdHZtMDYzWDJVN1pGYzVnWjduOG1YeVVRUmJa?=
 =?utf-8?B?NURTd21KcU1VL0lvOVUyN0RXbjdjUTAvZER6Rno0QVF0QkNrbXIwYlBSUDVp?=
 =?utf-8?B?VkVxeXIyMVpCVnRsTU9yYmZRSS9mREhFcm9jVHFHb05pbFZHUXBOZitvYk5u?=
 =?utf-8?B?VG1HcEljMUJMUkpOSlZyU2hkYmpwbEFRSzRZcU1tQnl0N2RXUGlpS3JmM2sr?=
 =?utf-8?B?a0grdHBUYzk5QmlrRXlGUzJuWkRGTzI3dHN0d2pFL2YxSEp2VjdSTWhEbmpp?=
 =?utf-8?B?aDk1YS81SktsOTcwUEY3NEltdTJKbUNOODVrOE1FUGFMVGlqd1JDTGhhLzhn?=
 =?utf-8?B?enpjT0MvNHE2cjlRZVlQeEp5dWZSRU55RGsydDJPcjBjRkRzc0FTdlI1V1ZM?=
 =?utf-8?B?dW9BaXNBcmk2amdnVHpLOHZjOEZrNWM0NTRmaW9EWmtYenM1ZXB3ZjJORnMx?=
 =?utf-8?B?SHFxVnA5STBqNzBqQmx4WVRJNXVrTGtvQ3paK0xicnhXc0lXem5JcjZMTWNi?=
 =?utf-8?B?c201cjhFeW5rOFFPZWlTcjJ2WmFiSFpQN0pxMnk3MWc2citWbFRxMDhVUS8z?=
 =?utf-8?B?V1pBc2ZKSmZIQlZibGloU1haUUpXNjI4dFNJNmFzSWQrR1k4TlI4WUMyOFdI?=
 =?utf-8?B?UUpmSnRCbVdBSVV0cm93RkdrdnYwOUluNlZOc2VsbjRPK1dFcnZ5ZVFYTEx5?=
 =?utf-8?B?SDM0cDhscnppb1I2KytaSEZyZFVrUlBJemJPMkNtL2dQNGRaZmVNa2hvaGkx?=
 =?utf-8?B?bUY0S1B3SnFqdEFybWd3MDhJQUdYZmhVZ3ZWVDhMMFBwdGw0blJEaUtucEhZ?=
 =?utf-8?B?Nmt6dWkyZzQyRzdNbU5pRG56NGJ5bVp5S0pUczFzMlNUT0o4Mm1FeS9IYU5J?=
 =?utf-8?B?SnQ4ZmEvWlQxQ0x6cXVPTTgzUzZLMHcvWlgxdzFVNXZ0aHF2c2srTWg2SXJo?=
 =?utf-8?B?NEZnQ1QzaU5NRlZ0Y0h3bVJVY0IwbnovVHVTK3M2b09YU1NJUitnUUxsTU1H?=
 =?utf-8?B?VzFjWldwN1h6TnpOV0lZQ0N6T0oyYzduTCtJUEdGT3MydGJaNDR0WTNPQU5K?=
 =?utf-8?B?WjBGNjdJYm1nM1Q5RWVyUnJQV3g5ZXl6eXZTOXo2K3BOZlZ2U05OeHB0SWE5?=
 =?utf-8?B?T1dpTGVSMjRXTDBpWWFSbERnbE96ZndKQ29RK2ptWjFvMjVRWk4vVFNqK25B?=
 =?utf-8?B?dWVmeWgrWEdSRjg0VVFsQ0lnMzZteWtlSWo5YVNUenBWZGpwbzVBLzhMbHll?=
 =?utf-8?B?SEFEUnMzeWJzVkhtZUs0dWFXSUZ1RUQzVlhWVzl3Yi83aDFET1pmbXk5YVNp?=
 =?utf-8?B?WFJLUE9aSUt1NmtCNEtCellTT3ZnUUlUL0dHM0NSZjJlUDNWOGVHWWJIb2o4?=
 =?utf-8?B?QnUyRmFlVXdMbGFoYm5hZFpFd1dDSGVJb3lqaWRNU2piN2oybi84Q01RY041?=
 =?utf-8?B?RXA3RURKRFFNSmhCcEVVcTZodEZPT2taeGI1Z08vY0U2dk5LVW4vdGN0aXp3?=
 =?utf-8?B?KzJqb3hrSENyaXVEUWtVU1k2YTg0Z25JbFRBcXVJNVZlTE1ZczNQRTcwd21n?=
 =?utf-8?B?SGNobmdqUUZ4b3lFSXlWcEY2cE5SdG1lVXRlMFhibTJiWndSazkycC94YmxH?=
 =?utf-8?B?bDVsYng3TEc3WVE3UExkZG1uM0psV0NVT0xFanQ5SjFwMlVza1BabW1JZmM4?=
 =?utf-8?B?NitWZjVIakc4ZzNKZkt4R1dydkRnMGNDMDc5Q1dhSW9mTDBZbjVGN1hkcDZH?=
 =?utf-8?B?bTBPbCt5VHRKc0VJQ2tid2V0elpPY3R4NFdLeVhQTE1vN3BQdE5VbE1rS3NV?=
 =?utf-8?B?dXA1NkoyRFhmdHZLczg5RTlCay8yWVVtVDY1ZS9xU1Z6d0x5TFJDUT09?=
X-Exchange-RoutingPolicyChecked: C1WMtwBQViz27gXVOqope4k/YHTfUR4/j3Q9+W3w2aYrWGWPmkh5MPxAsJxCH9xZldpyuD/8hH30tJyBcfzNEjikKRTC8K3KsKBbQ6sGNK/4LY3Md8vqc8hol2Yu/W4sUYcnkiKogzYh0uyS0Qh4PNoouPSFhwQ8U6pcPYC9qqeleVCcYo0zKy4Cfyd25OWkF1IjdvkU22WjmhdkJ1HTJTn00x3i4ACAsOfX/Uzh+KVBCAixXiqwcURhqy9L3Qq1k42ptiWb7Mqx6OH1oxG5zWCpaL/u45Qpdp4jjJqxkbLkbNFlefC3WAcwXlXZwYnYv6kwLvA90WUjmtEgyDxxfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 636cfe6c-9215-4c35-821b-08debcbc0023
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:21:17.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QnLO8QmeeGpTLNGDALTKVVW3t7skmplMzU5+4tew9z7kzdETao9QiLCOaJFO7iY/GkaihhWlAt9T8u8Mo2pnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6558
X-OriginatorOrg: intel.com

Hi Shrikanth,

On 5/28/2026 7:27 PM, Shrikanth Hegde wrote:
> 
> 
>  From 10e9413cef063446d67dc02c2b44e1ea582e5d53 Mon Sep 17 00:00:00 2001
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Date: Thu, 28 May 2026 06:16:44 -0400
> Subject: [PATCH] topology: Provide arch_llc_mask for cache aware scheduling
> 
> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> 
> Stacktrace points to llc_mask being null.
> 
> NIP [c000000000e58504] _find_first_bit+0x44/0x130
> LR [c000000000e58500] _find_first_bit+0x40/0x130
> Call Trace:
> build_sched_domains+0xad8/0xe50
> sched_init_smp+0xa8/0x164
> kernel_init_freeable+0x250/0x370
> ret_from_kernel_user_thread+0x14/0x1c
> 
> On powerpc, cpu_coregroup_mask is available only when the underlying
> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
> coregroup isn;t supported. In such cases llc_mask was being referrenced
> when it was null leading to panic.
> 
> on powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain.
> 
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/ 
> all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Suggested-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

It looks good to me. Let's see if this resolves the issue for Venkat
and Ritesh. Feel free to send the formal version :)

Reviewed-by: Chen Yu <yu.c.chen@intel.com>


thanks,
Chenyu

