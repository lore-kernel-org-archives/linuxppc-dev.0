Return-Path: <linuxppc-dev+bounces-20477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92712FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 13:29:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8zrk00lCz2xfB;
	Tue, 05 May 2026 23:29:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777987781;
	cv=fail; b=CpxkmXZ5d11wmq9Iaux8a7JbcWyFmEn+oBxiWaoQUqsmgC9iZ04Cayzpz238oZb09uT104Vuc/XCnHGX6wgHXBFNRSzZVGvyLNOx8E6CmTsnToIkq7eYQDAUVK+T/CPe+vwg2K//i7rJCmmh+of7exee/Y1evmvvv/VkeTS+IJha3ALNq2qSKLt4h4SVpTCA19wuaKObfTR6MGJMNWsis++inHyKakA/mQmTpE5SK795nceFyXyW59Z+BNG40vnEMFglQZ2mf8/+ySeC73VlIkw3w0wd7UHHFh3r4ydUY2QnFiaXTw8xEaeE73G7kOUxXeHx/KecDixX9Zn8Rk4kbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777987781; c=relaxed/relaxed;
	bh=EVEUxdI/Ok1Ee9jYfHIjshAE1IaLS3vba1geUEceans=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNuHIouCHCDZy83xL4/CWUGLCM55q5WLIAHk75nV5KXQ9v63NW3a6GlJLfTduQnJi1HAl/RmxsTh6zXGrPvLreUFTA3ki+yj/CLhtaon7CSXFvMN8IMUPNSkM7KruJPdgmPtSveI+30GM0mUSnTYg6gA3VaY+UTQF8u1iTNkK2pZGEGREb7RE9YcVBMGmTsHEGlASe7RxY40hfHbl7yY/9fjVTxC0qHrHI/FMEtqjOD2paUYSdf66UoAg5X4J2zrH5YUXCps8Ivc26VOeljvEzdZp/mx/ezRRDlUXt+52DNmFcGYMVaBzy1mDkzHkZhwV5aidEslNgkcswfPZpoD7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1tdzyCl; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1tdzyCl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8zrb6Kqdz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 23:29:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777987776; x=1809523776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4L9EsvQSZw7MtRAjDz1hIqCVJ7kNiFNl7EIld49jeOc=;
  b=K1tdzyCl6mFoCQHTlqIvxAvGg6cmC4soMmB5/tFYmxGQKOlMTfWv3lIb
   MdCjA5ERtN/E6ZAeczOkEIgBSeZN2euGULN68++JgaP5YDUdHT+VVRllh
   S1Ck+wHdOkfNDdaiTXNW+tpn5eM0ijA7DTiiaPzubjWfzyy8o7jVuZEJM
   M2Qc+yml9nRAf88lm8qU98932Zg4yRpVKuVOxXe7WlAlFYHrGkV2gvXnu
   WBzIMrt09uVNHPIgd9z0nYdXSiLS3v3PKK8ZYel1zucxI93FhDFdOHz94
   u79l/A9Z0n2F4wGW9828770/4mB4ECxWob3QtCXGsn4vUgtIjFmENJ2sY
   g==;
X-CSE-ConnectionGUID: TicJQfRrRtOiAnkmJAXBxQ==
X-CSE-MsgGUID: JVSmjS3xTvuhRbgC/TtZjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79047351"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="79047351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:29:28 -0700
X-CSE-ConnectionGUID: x2vRv5G7SfqFzPzFKwDOTg==
X-CSE-MsgGUID: 4P06mt/bRVugU24gVQxsUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259162973"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:29:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 06:29:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 06:29:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 06:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAyNXqaiueFJjXk1SOvmLzXcOhtrlGrCqEcN7WLr1n4gwuPk1rIjUjzYZKsWKn5BtotigOwN8FzPRJM/LTDxNCpE1wm7aZetQoGIQU5IHWjZ1OIiw0ICDqPPeGRtuRRs20FI7WhtWYzJFW/DBR3CTsLZHo0KmV9MlAD0LfA5zurbou6gyqci3Aei+nQGEX+D45fuOpvs2Uvv19KlhwrgXV29sb21O7FBpJe6DGdGnFNbkcLKr2oEEBS1/+FCpOpy6fx+5gfZ88EwjztXdrhk5+X5AOuAHP0fEvrmQlF++FJMzLuhfWur1s46oe78zuy6NPoYPcpW++r9H4398u8jBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVEUxdI/Ok1Ee9jYfHIjshAE1IaLS3vba1geUEceans=;
 b=T4mJv3NgluOVyu66QfpVNMTBSguBcocZp8YbblSGEkaXmH/pbeJ80yuWA3yN/YWa6J82SrI19hqIxeNobqxiSz9xexSMYZwIS7/0txr7nuJqnbERl6enyS2yXP9GHZWPux82WemK1PLQelhpI9UUZ0Bs8+mMzO32o8y1bP0C1m3o3Bl1SiA0evLULNdZgH8F+7kk9tBZrJA0AdeYAtRD0Fe1SN2osZ6zzRSCcQRBvYPY71BtDtqVVegRJxOIPy0L9iLcHgOR+9w14CAoFE7li7CPiO5DGt63J1fSHmnSXidyOWgr+6sRYIfnYYveRznVENN7uBL7hXKRFwaR81iFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 13:29:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 13:29:23 +0000
Message-ID: <0a14487f-38d4-41cc-9e75-79f19a594e08@intel.com>
Date: Tue, 5 May 2026 16:29:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <mpetlan@redhat.com>, <tmricht@linux.ibm.com>,
	<maddy@linux.ibm.com>, <irogers@google.com>, <namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <Tejas.Manhas1@ibm.com>,
	<Tanushree.Shah@ibm.com>, <shivani@linux.ibm.com>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
 <20260504151321.12346-2-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260504151321.12346-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::26) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PPF0BAC23327:EE_
X-MS-Office365-Filtering-Correlation-Id: c6380022-46ed-42c4-68ec-08deaaaa5223
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 015/6NplYK/PRNd2I/8wJNiezOQE0SkujfkzPq87VN4e/zjIJneqp8enfvFD3ULn/q1ntKIiFN/x6jPRovFrLzP1CvjQuCJoT+BCNFMzH3DtabkGKt8W1QO+RIQ+Zhtrg2jRI23iIuvdg8kGnQLPix7cbu/hI00lsK/gr+MK1lrecQu38nH/5N8N9LOOIPs2/ez5/ZBvNOMzUNrb/+JXZo+1vns+gOOyaVtoWeBbOdAeyFVJR/aWJ4o5aMDaP4Jw0Rzl2ADlXhJayg+/dq8gQP6x5iUGDtAtWJ081uv33n5b6FQ7FfzClUIHPnnrFnlhPXw3iaxb5ab+X0Tlsm+s7xEFBpjGzJAlLkz58h2AGVO3jYrn2ac0TCMKfOM/hymNAoV1Jh2lUaAYReHaeFiyh+lulVtzdu8P1wXwtjYNLcZMpwVmGVhJjuUbiuCVSVqoUW1bPOKheWa+rzvE0/D5KXRK4nlkJJ1oEAHkbRg5xXb8y6WCpPBYstR4cR/9nBlbqZaVvy9TDBEjdY+RP8D54xlzguBu3MfAV0CSziRvjfJ4UfeqkuJjj8/2lR3GNoh8TbV3n/FVRHhpUUcOXcP4uJDoiiaL6K2oemi/b5SzxhDZMH58bwbTJxYat6Uy6JjP1Iemu16h5NwNJsiiAuUbjSDf01H0MkRJV9EyzBH35i4O8DWpl4+Wrj+hzRvqvMVA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09YUmJPY3g4K1FXeXhaWkxPVHpOZnp2TU5GSnZwZlc1Z3VaMkV3RWE4OVpl?=
 =?utf-8?B?eUMweGtMak1hVFNINkRVVU8wbU5aZnllcmxoUGxvTDNFQ2JxdVhWeENkdXRp?=
 =?utf-8?B?akRqY1N2N3VFN2I3cXpFWXAvaUkrWXFBdDlHT1pWRW5pbFBOOWZPVmN2VHpl?=
 =?utf-8?B?OXkrOXNMTlR3RlhpWnZtTXdIeENyWTNCTnVVMFRVSll0V295UmdNNWtvdGl6?=
 =?utf-8?B?RUZLTlJsUnZsSWtxOW1XRnU5U2g3b1BjckpaWXl6RFNrRFkrYzA3RmhIeEta?=
 =?utf-8?B?SVpQdklta2VPUkdVam1vWllIZkJDcnBSZmJDUUtIQnZWUyt4c3hiU2J1RnZM?=
 =?utf-8?B?dUJ4d0UxSWRreTg3VHIzKzMzTE1SNnNkUXVvTkFhcENDQ2pIRlozVWxJdkM3?=
 =?utf-8?B?alpxYzN4OXVVVlRoQWQ5blVwbjFOdXNPbytieDMySjEwM25jeDVkRzM2cGdS?=
 =?utf-8?B?U05LNlpGZ211dGhIL2gvTytFbmpVejVDbUd0MDlycDVnbVVuM3lZbEROeFNm?=
 =?utf-8?B?SFpKWDBpSk1iQStaL2dqdmZRazdZeTBwWjZCQ2gzVFQ1QmRwckdlTW9URG1q?=
 =?utf-8?B?QithSFBKaTEwcDB3czBqYWhaM0E2Z1hkdW5lSWJubEtadVBnM2kvWXZXUm96?=
 =?utf-8?B?SWNjV1VQVS80UDdSUjJQa2U4eTRYQ3hnWmRLRWZJdHhaOFdGTkdHa3BRWE1J?=
 =?utf-8?B?TUwxaHdXYm83K2JXUDMrcTliMm9ObmRLSWdYRlRvbDFjZnJLajVHSkowdDQy?=
 =?utf-8?B?bEt5a1U5VzlGdzVrNUhxTGpBbVZLU1hSMHFJelcyTUtQRkozQnRzN0FpWWJz?=
 =?utf-8?B?REJrSG5lMXBHT0FzMkd5V2dyZ0pZZk52TkZicEhNR3J4c0IwNVBHK3QwOVY3?=
 =?utf-8?B?SFRQMlU3R1dzUGYxWm1vd3NNNzNMeXd2QzcraDFPclZva29WdHNSV1RjenBE?=
 =?utf-8?B?YmVidE9QMDVldXJBZVJpKzE4eHRxOEorWUNuRlhyM1NUSThwT05VajVrTzRB?=
 =?utf-8?B?aXV4ZWlzR1lNM2hDeFNuMEduV2pKM1Ribzlxa2dPbDRDMkhVcWRieWdTbmFt?=
 =?utf-8?B?MUdvbjNBaExvd01TclVIYlBIRVF3ZG03MlUwSHFlV05EUENNU0NTUjJyQWx3?=
 =?utf-8?B?M0JjZ2ZwdCt0OFhucjhldUxPckw5dHB2dXVEMlo1dEFzdWNEOFUzcHpmaTlG?=
 =?utf-8?B?WGt4YkxIV1FsUHN0Z05GcVVnU2IyQlZPOG1pRFRNQ0NIZloyd0JTUWN0c2Nz?=
 =?utf-8?B?RXVRd1Q5a0R6dmNzNWRsOTk3RjNzTjMxNWczZzhVd2ZyWXBZVk9WZjVySTZC?=
 =?utf-8?B?N2dHOFJzbGFwREY4Mm0vZ01LaDNmS2pyZlVtYk9RQndtT1VpOGswc0lFWnQx?=
 =?utf-8?B?ZlFWaENFa1FNTkp2NW1naWJZQ0pud085K3RkY0VqMkJ2VDRMckp6WFJaak9C?=
 =?utf-8?B?amlFaFk3bEc5M1gyTkJ3dFcxbTEzcFNNTHh3QzJhazZJblViNEhYVms4VUJj?=
 =?utf-8?B?SHhCdUtheHdNZnlDc3piRkl2RG55Y1lXRzNsNm5XUWJlQmkwbFNZZGZGS0tN?=
 =?utf-8?B?TVF3R3l6cXNmKzRnTlZUeHp5dVBpazZ4M25qZVZKeElFL2JrZmhscEd0clVL?=
 =?utf-8?B?OVJyZTFVR3loUk9yM1orTkdZSkhGU2wxRmJYRVJtYWJTcVJLY3hZMGhVS1Nx?=
 =?utf-8?B?UVhiZTEza0w5VEptdlR2OU14Y0VaVU9lVDI4SEdBekVwMEVTRjVnOWtBdFlW?=
 =?utf-8?B?amRuMmI2UndsWGJYdk1BdmdtYmk0SjErMUNxN3ZnZXJmVjRKL2Qrc2JOdDNL?=
 =?utf-8?B?cm5GTFNFODlCNEgrMUFDeVdxbnBOU2RYOTdncGpVSkhweFllT0hEY3d3RTAx?=
 =?utf-8?B?c05ubXJSZTlhbmRPWGFuNWh0ZnpHamFtN2ZSdXdRWFBjWlV2WmxYZzdqbDlG?=
 =?utf-8?B?ZitsWjdPRFZaMkF2M0VFNWZlU3ZjbCtGZFlNc3NVeC9GdE1LRGx0SnE4MS9F?=
 =?utf-8?B?dXZPOUJVaGJBK21xM2VVcVBtYzI2c2dIcS91WS9rTVUycmthUEdnZ05SQnFk?=
 =?utf-8?B?M1ZseFFOQ0taSXBCdGtZOUU3WWEyd0U5dEJVY2h1bkViSk5hQ2FmanNLVnZy?=
 =?utf-8?B?Si9jVmMvaGEzWnBlN1JyUFBNd3huZmVIRThybHdPczJWeUtNZ0R1MzhVcXBS?=
 =?utf-8?B?b2wzZ2VjN1dHZDEvUmdsc3RDZkdtRmswTCtSVTR1a1l5UHkwaWRZTTZHMENs?=
 =?utf-8?B?RVgzL3lKNnRsK2VZc1VEYUZDOTcxb3pCd2FYZlgyeWIzSmhmTXpmaGxTWGNO?=
 =?utf-8?B?K0xGZEF5K0dVUzNQQmliTlZPOXlPOFBRNWVTMVJMNHJEclFNbk9FcUdlYUFK?=
 =?utf-8?Q?2SKEgMiAkGbcH+wA=3D?=
X-Exchange-RoutingPolicyChecked: ADU8AlFroGxOQIvOfTxJJh+vI8ulwHt4sR92exNeoCeJsaltRgv0RO3/l49Jq7IgJjtS/NlLrsY3f5rko4R0DT+AHVR1w3PhX/kHrkmYBk0xfnTbodMmtlM1ABd+lHGcdkaiZwD7keTi0ex83/UgfQn47C98ZVSnVxRqInbZAlMGLjy6DaMrWkRuMCdSXfSYItAcQGRP7NHGje0BYAY30L8faqapszmopIMh2+0QlQ3ko02pgGkyrr14u7ZomKtwXFZZscwA9R7AoW0q/tMa5Ns7gJYnzqVaJNO3drNzRfbhburwZo6PhyG3B24izxkJxcoLgNQEcUKv0W4uylFMlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6380022-46ed-42c4-68ec-08deaaaa5223
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 13:29:23.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daydjfNCX4RFLCyztvkHzuxogcedldJ81E97tL9abipHMZJib1PPaLkQcv5H4XYO1FWUT3RMjEkgGfOR7pNSgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327
X-OriginatorOrg: intel.com

On 04/05/2026 18:13, Athira Rajeev wrote:
> Add documentation comment describing the parameters
> and return code for auxtrace_record__init() in util/auxtrace.c
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v4 > v5:
> Addressed review comment from Namhyung:
> - Used original placement for __maybe_unused as
> "struct evlist *evlist __maybe_unused"
> - Added return code expectation on success case
> 
> v3 -> v4:
> Addressed review comment from Sashiko:
> Update return value expectation for fail as
> non zero return err code.
> 
> v2 -> v3:
> Addressed review comment from Sashiko:
> Update return value expectation for success and fail
> correctly.
> 
>  tools/perf/util/auxtrace.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a224687ffbc1..a9f007d47c0b 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -896,6 +896,21 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
>  	return 0;
>  }
>  
> +/**
> + * auxtrace_record__init - Initialize an AUX area tracing record.
> + * @evlist: The list of events to check for AUX area tracing event.
> + * @err: Pointer to an integer to store return code.
> + *
> + * This function looks through the @evlist to determine which AUX area
> + * tracing hardware is being used and initializes the auxtrace_record
> + * structure.
> + *
> + * Return:
> + * a) A pointer to the struct auxtrace_record with @err = 0 on success.
> + * b) NULL with @err = 0 if no AUX area tracing event is found/supported
> + *    (not considered an error).
> + * c) NULL with non-zero @err on actual auxtrace_record__init failure.
> + */
>  struct auxtrace_record *__weak
>  auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
>  {


