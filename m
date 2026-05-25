Return-Path: <linuxppc-dev+bounces-21476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113ABCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 15:36:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPKjK3p37z2xfB;
	Tue, 26 May 2026 01:36:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779723365;
	cv=fail; b=b7VJtUQ3H771v+jNvVxu7EIEYvyAhilJ44u9GOOlT6FgcXc+aXnl9e0yFJV6ARxqjia8xoIDFjkqtXnCfGmcwpOz6wDHeuAAur/k02GiNXzJG02Hmrtn6JXjnOu8HTkRdQukejbfZrM3yN+2dInFb3mtZzm0JHOYqjpXt/2ovHRpjMjdJCH8x75khmhYN5HeFaOh8euwFDcfyjV3lKselwi5zKa8aRui+yU2OVfpOuWisYqvM+7TaWyvvz+fmYsdcqWa2t8cMZT0GqRTyxfXYjgtY7KdMheoKqRz6N1rQ6SJfKXC2pPmLiDFVMvNoBdnrHpj01GCmsXmDw75txM3kg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779723365; c=relaxed/relaxed;
	bh=gBnWiFJuCxdCDnHg1Cn5T4TYsRjzp6hMlRraSL9gQvI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DahajqiyVZXza2Qc272RiBkDZGiPKTpgB1xy+OVTKp5KhEgN/0keAEkM7UmOvh6wxLj0QfYV1LfAa7D6pXN1xGyeULdD17VPwTgAC1MJZf2slRVdM468OFrLvfQHdJ4wM3bAQN89GqkwqmQ0379YSE0EhpS5o34zkDzIrZ9daMJJuZnfBBY57EBkGp+Cgn72hnvIt3q5jza4UuamXJPy3ytSuFGfU/uzQWpOQkx0ZISl/Mk5YaevKXY8bHqyCfFA41Vf+T0QUl/iGGGTtFYWiXa1iwXfBpfzReyt2DAOSXj/wa1S26NBN34zxsu++QeoTpRDDg6SnZ3IlXcn5JVZDg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ggx7dZ6N; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ggx7dZ6N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPKjG1404z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 01:36:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779723362; x=1811259362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tz3ThWVIc0adzdkot9uRgWaRTeTLETlWY7MrsWUK/Ac=;
  b=Ggx7dZ6NmPrt+73MfkwI5YYsf0bxyPXKUkk8+hELGpfEX8i4ZwpEbQZ/
   M7PtIF4ien6wYMoOkPEo2qXXaPGqAmBOCeDmJs4POk9ni5NXkfeDbPEnO
   OzAurZR1lt299lOPAD+B/M4FePyADO6C+LL65VK1MRd6qyB5F34D0YCSB
   rH46PFAv7INMTnamVVEWgBcd+lpJqewSRW0+S3VGKmGq7rp2uaee+9lQy
   OASpCst3ex4H50MS4aHWvbutrJ7ZcG8+/ONVw9UtoJ3+po6zVa/kADiZq
   8XgHAkV5f2+4QEwL2UCUcnOJZpkbRYjGrqw7UWhSQUiiMHEMLCWhLAg24
   g==;
X-CSE-ConnectionGUID: EbEPs2OSTBCXiu0NUBs2mg==
X-CSE-MsgGUID: v+ZoOwT6RI+c0A4Jt2Ur0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="79690518"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="79690518"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 08:35:55 -0700
X-CSE-ConnectionGUID: GqVvqA11S+CX1m3eTw6WRg==
X-CSE-MsgGUID: CxiHdi22SfCp7Q/qKhO3+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="246597132"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 08:35:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 08:35:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 08:35:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 08:35:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR4h6yT438h+T5PudEs//RBYne+UK0QWJ7OrmqSKmn4pKi7MsxVNuHdcGJgXDEf7ayzLWlvmXCXZelK+cNA/yiHdAL4P1u5xDubFqZdQVubj18cY/JZRjnk94PtdAsdkYcpY98y8KqvoEys+v28S8VqxN8YJQk2LE5G7mg4LCEJ30OUVPAAlUkea51ykfl7KfJE2tdxF0hirNgsCnc4hH61lj33+rzLIlmhvmlMrZiY4gdGgOGfW71D9Qq5CA9RaI9MsKIZSanjjmP4fpOoYVSKKcDhAiydmi8r6y4FK0qECxW2q6O2YhWPucyx91Ext4rZrXfruyp5WIS3dFRr5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBnWiFJuCxdCDnHg1Cn5T4TYsRjzp6hMlRraSL9gQvI=;
 b=Z/c91XNtGL6sYVseokJMsiUXG8S/D5pHrJ8X/zxHuuBw7DmyTV/975TPbumYWhBiIocUcmRmfvn31Rx/atKQ66sdekQxhurmkHKea/MLQWglpWWqL+eCI4/By6HrvHMnOptFpUQ57/Sa2Ozi332nXxc1cLCFRlGgQCgOwC20WtKqqpOoVgvUnd8917clp8cVtKWB4LWbVCbmE86fTVEnSUYluKn/SM9ahegmt76dVu/657riGx2G1bEU2eip9X0XBZCTfs2MjUwvshBBN3gXVe6tuVInkFrHgJeMUJZf18/r1J24dlEkx5+hLT2jMLpaMTKWxenBSv95lwChxXGLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 15:35:53 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 15:35:53 +0000
Message-ID: <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
Date: Mon, 25 May 2026 23:35:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Peter Zijlstra" <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::17) To DM4PR11MB6020.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW6PR11MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecbf4d7-efb2-4ae7-b813-08deba734e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|56012099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: RpUUDXX76oRgpYH+wvpt2iDgjgOSDpSp1Tw+CGWHsMLxUe37GUJ3Oq/OZl+PT4sNl8t9FhnvTa5S9sHw0EfRDUzv1ql6luvdis5GggrNvUKisDbM5whCJe9dpH7uE4WT1sGWpyiP+Ovzm4ktGUky/mNFkeTysiqeiCjqOlSDb21MW64oKdpcxZo0Er1n9yGCn39zMZr0KjFHN9iq/Sh8NReUouLwdjFPF9Vk2MvLyGA6uI5aSCvGLpvKX65Lvy8maeQ78iyPcXx7RrJzdK/hvW/nBNqgeRaiw4GteGDrhhMS8fam+Y7hndHCZgbqLKaoUBvtumyo5gt139gC/qjBF9D99YFSfLjd4Oh7Mcr2fTiTci5wyb7xr/yYAnueHzvumDNtxMJFBUda5dH7K9rbZ04b/Gfv7oRwPr9awRrWe+RD09Iq/8LYgE3HmZvdLD/2Nc29U8lL9sl0ByrYly8Mwi2CI7R+43uqP3+G4/sKfy+aBYGZousCWzNSLQQ/Wm8ZMcezGXR9AZ7Ww3JlzJ67rtYfVe/5JvXNxvLMVgjBZMnrKKXfLgi/JupAqUS+ccQWdOl0KDAzqJgvkgdfmwiTF8pT7FjEU+RbLhuTKD0TlF3riUYNsqIabGUum7yEHEK7Dbeke8SmJKWPL6M3kpJA7rx7PYMzAhGTA7douBNiNqUoW1xeo/OQa5Gngp0qcIzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9JZWpSQk80Mko3MHVJZnVxSmUwbkV0MUlXS0hvazdCVHZ5RURRSkIrS0cy?=
 =?utf-8?B?VjBaaytUeFJCWHpkSXZWVVdtaVFYSjAvOUs3WE11QlErQW55eHNrbSs1Wjcv?=
 =?utf-8?B?Z05DOVJlZXJIbHAyRkJjUWkyZkg4TkxCdzViNk9Fd25XRzl0WWtyZklQdE1a?=
 =?utf-8?B?Smo1US9MbDM0M2pYM2hHMk1RVEdiOEdud25oNzhPS2tHbmRkMkNlZWpGdVda?=
 =?utf-8?B?NkhubCtRV1dqM251SzFQV0lwUk5YeWdyVE5LN2FpSCtkbk9iYWFoUHZjS2FX?=
 =?utf-8?B?ckZadVNWY0FBQ2xPMnRjbWlMWllVRVI3TWdMb0FhZkVVbGhEYVNFNHR1MExZ?=
 =?utf-8?B?U3BaRDBqVVhOamJrSFM3SWhBRkVocWtBeUorQTFVdUVpMHUxckFhcXpSRmpD?=
 =?utf-8?B?Zis0encwMWdiVU9nL3BwMWhnaW0rWk45a3V1MDBoN3ZBUjMzeUtEaDEvSmh0?=
 =?utf-8?B?aUw4NmZhTXhXcW1jM0ZJbmNMRnM3czFPR0grV0gzNFVudEErQ1kvMjc2SlRE?=
 =?utf-8?B?Skk3Zzg2MER2cHlJMDA1VmZpbWdDclpuV090ZG5tTndpazBQQXpQSUxKS1g5?=
 =?utf-8?B?UUNzNzZKcUNoL0xqaDVqN0gwd0RabU43Mi9BNDJOQjZvN2U5RmE5aHlZT0Z3?=
 =?utf-8?B?aVV5bVRtbkxzQU1jSkFrbVAwdE0wSXpVUnJJdXVreElkRWFLb3ozSHcxcC9q?=
 =?utf-8?B?d3Nxb05CbUExUTgvTVFZVUFsUU9mc2pnZldqdjB2ZXdVMFg4ZUc5VSsvaCtJ?=
 =?utf-8?B?TlNoUjh3TnJqUnpFQTQ1cHhENjRrNitqZ3RHU2NjNXZBbDF3T1pQZjNkTEZB?=
 =?utf-8?B?WFAzSWhSYkZueTBvRkdaT1pETzYrallBU0kvMXFHWThoWm83UkdLL1lkd2tM?=
 =?utf-8?B?dm1LRXZLOGdQVGo1MWJVMnFrNWErNDlpRCtBS29hcGN2L2ozUWRHWkxpcERn?=
 =?utf-8?B?UFIzUzIvYUQvZ2NvRzJTdmQzZGp1ME1OMkdFQ0VZdGcyMVN6MUdWaTdqRHJk?=
 =?utf-8?B?emxaWXZFaU5IbkppQkNtQzA5QVB0L3d3d3EyNThTYllJczI3OEZUdDhJOCt2?=
 =?utf-8?B?d2pmRWR0YkQzSnlGYVI2WHoxNVFUYk9ES2hJSHhtbzJsMC9JS1ZoQ1RVdEhs?=
 =?utf-8?B?Y1pqWXhmNTRtSTNxZGV5UUEyZmllMFc4dnpldmpTM21HNm9ubzhrWGRac05n?=
 =?utf-8?B?cDNFTGhRZmM1VHZRV1ZwbHRZTXdTWG1UVXVlU1QvdkZQRXFnVXo0aDVCV3ly?=
 =?utf-8?B?QVpVRU5aTmRvaTFSLzdGUG5UekJOMDBQbnl2bUJqOXh0VnhyMlBEaWh1b25l?=
 =?utf-8?B?UEhCS2Q3QVRoMWZhSElhajJxYTUwOXo3a0RlSzFsdWtNY1ZibklhQkcwczZo?=
 =?utf-8?B?WVArK25Lb0ZJV3V6K0pyOSt2SU1LRy9vMEhSbDNxYm5pM0dtczNML3c5RnlV?=
 =?utf-8?B?L1Iwb2RwaEszanhCelNFV3FRclU1MlNFdEx4ckFqTXVrOVdhbUhLcTVhOTRm?=
 =?utf-8?B?TTFXNXRlS093MEk2NUlXUGovMGZUY29Kd0pSeWZKVytnMStxUVhXRDRmWUVi?=
 =?utf-8?B?eW9ndHN0MFZPemNOY1U3NWg3ZGZTdHRWRUVBMnp2cmgzTzRWY2JTSnp5Qm5h?=
 =?utf-8?B?ZGNHS1V1dERndHgxYnRyOEQ2N2xUbFE1WWZxM0lZNkM1OTlqb0pwL2lTWlp2?=
 =?utf-8?B?aUluMDlxSzF6L0w5ekNqdWRCNyt5alBMMUhiSFhaSEQ0UzRlempGWWhSbmlO?=
 =?utf-8?B?ZUdVNjVISGhlUEgrQlBhVTAyV1NVMVFPUUpoR2VBcElIRnNrbXdwcjY2M3hH?=
 =?utf-8?B?dnVkRFZLMnR4MUJWSXlKdTZVQURxS2NJMWU0Z0FDMFpyRHFQcDVlSExHMDZX?=
 =?utf-8?B?V0dSY1o1Wlo1S0phYnBFeXhYc1BqaE1JcG1lZU81azU1OHAvbGxiNUFVdnBP?=
 =?utf-8?B?VTUxeFptT2JnK2pUUVg4b2lxMUY3K2ZlUmMrMjB1V1hLM09YSEJEY1NVN3JL?=
 =?utf-8?B?dnppZHhuWEtPT1haVC9OSENlS3lCaFZGTDZYY1BHdFQ2UkJEZE91T0RzZDNE?=
 =?utf-8?B?YWlNQ1RtZDlxU1NlR3NGRG51RFdvV2RyTlVTbFNZVk9JNkhjcGlYRFNFbi9X?=
 =?utf-8?B?TXdwU2VVaTVmcXZTd1FDZmhyOE9qZG1CZkhxOCtCL2llZURZVzV4VkNES0Ns?=
 =?utf-8?B?dEFhSkVhNytjbCtJbWhhOUhBdlZ5d3ZsMlVpVVVnamlndFlWN2pwRUUyY1Q2?=
 =?utf-8?B?eUxhR0NDNVB2eWQyaUVLQ2RNZWQwZUtxU1hRNkVjR0tNVGZkV0tWMW5oL0hI?=
 =?utf-8?B?VXlxK3VLY1BMR2FVbWFCeDZUSWZOazh3QzdrSzU5OE9xRGhNdHh0Zz09?=
X-Exchange-RoutingPolicyChecked: qusz8LY4WkXh4BoD0+m7PduI8QlswkGXGyegHxCRn6kR9nrot9JzKmPtmanrs4HzDqYZV9EUxmYQDfhiQz4bw4zxKtEkNwl9t0cEip9EstB5TPziwe137vN00Df9UYVuiARpE4bTcJ+a0rX/pK26AbAD7VZEH7czILNhx1NiZTU1mo8e8nq5ly1aLY7c580IUZGiFp4GWb6gawwbIZKJBKlUPwVQICKuEA2RZTeQz6jI1KFkEl18Xzn2LuLqkj4be/o+WNCY1pqLG/zJQmzrhNJS3hg7MH1a4Htex520IPwfbBdhHxG/cfvOvqW2bNC3pCg0bvNdE7MFjZS10hWJiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecbf4d7-efb2-4ae7-b813-08deba734e3b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 15:35:53.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qf/jeAzAtJiwlXv0ug2u+Ly7UGE/1OoYKjgAS6zwTtFtn2JzESIU8Ly9qE/uHe12S5dLU3mdvUmXY7tTsjxlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
X-OriginatorOrg: intel.com

Hi Venkat,

On 5/25/2026 10:07 PM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am seeing an early boot kernel panic due to NULL pointer dereference 
> on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> 

Thanks for the test.

> 
> Traces:
> 
> [    0.038567] Big cores detected but using small core scheduling
> [    0.038796] BUG: Kernel NULL pointer dereference at 0x00000000
> [    0.038804] Faulting instruction address: 0xc000000000e58504
> [    0.038812] Oops: Kernel access of bad area, sig: 11 [#1]
> [    0.038819] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
> [    0.038830] Modules linked in:
> [    0.038840] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0- 
> rc6+ #14 PREEMPTLAZY
> [    0.038851] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> [    0.039029] NIP [c000000000e58504] _find_first_bit+0x44/0x130
> [    0.039043] LR [c000000000e58500] _find_first_bit+0x40/0x130
> [    0.039076] [c0000000090e7bc0] [c00000000038b3b8] 
> build_sched_domains+0xad8/0xe50

It seems that cpumask_first(llc_mask(i)) is accessing
NULL cpu_coregroup_mask():
has_coregroup_support() is false, thus cpu_coregroup_map
is never allocated in smp_prepare_cpus().
This machine is a "shared system" VM. We should probably
let the LLC id generation fall back to using L2 id if
cpu_coregroup_mask is unavailable (which restores the
behavior before this patch). I'm wondering if the following
change would help(need IBM friends' help on this):

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3467f86fd78f..cf6c2e4190ab 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1042,11 +1042,6 @@ static const struct cpumask 
*tl_smallcore_smt_mask(struct sched_domain_topology_
  }
  #endif

-struct cpumask *cpu_coregroup_mask(int cpu)
-{
-       return per_cpu(cpu_coregroup_map, cpu);
-}
-
  static bool has_coregroup_support(void)
  {
         /* Coregroup identification not available on shared systems */
@@ -1056,6 +1051,14 @@ static bool has_coregroup_support(void)
         return coregroup_enabled;
  }

+struct cpumask *cpu_coregroup_mask(int cpu)
+{
+       if (!has_coregroup_support())
+               return cpu_l2_cache_mask(cpu);
+
+       return per_cpu(cpu_coregroup_map, cpu);
+}
+
  static int __init init_big_cores(void)
  {
         int cpu;









