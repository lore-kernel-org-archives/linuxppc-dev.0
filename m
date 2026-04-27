Return-Path: <linuxppc-dev+bounces-20145-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6E9FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 05:35:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3sj94GsYz2yLG;
	Mon, 27 Apr 2026 15:35:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777268125;
	cv=fail; b=Rp+cQB61ZoT3B4gFLPqwnOzNBcmOYRgWwsHRtUkn1eraV8bijYDNcwkvXIG3WRgAlJUmmBAHZssHsRnexpLyaYeNUdEHL5UKMCa138CDLbt1kr/VhbTrj0NZMQ5eKiURrp7uZv9rhRp6CuqGW1+RO/+VpRHGQ9rByiajfkeYsuTbTQKvuxUWDU0WhM4F+10QqCx/zDtgck/ir41km57WQP/yWyW+EQfCTvRVGDOm2lA2gB4Cy3Z7obcHa2//PZYYQvhTf5hShxFFDJqeAQ/PcHXu+A8d2g2pD3RVpfJ5v7Cu3XbggQ8mpCGmobrYvOjHafU+l934mnY4XhkYKMyp3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777268125; c=relaxed/relaxed;
	bh=VJmljEhWJLVtziBiJ4VVcU3g592qzJRgG/4coBwqnDY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hhycTfSkHX/OZbt9thLhTcX8dNlYFvde3jA8qyL9ys1wDwFkQyM3cStcdifUX8w5+1N6ebM6h8wCjj8/1syoKWbDtEXqYJSIBf3mUGirqvEJIJ2LtGnNb7DCVuDPcWR2ybbMAUBczMHIEu+QPhDXHEJa2lGxVp7qjUaJvOQFPToXlTjiPR4x+7/e1/jMt3itgfL/ZHUpO36CeuXhVpcaVg3EPtnd61d615GlMXBmCDaO8kA22vqwzmA8YW2ku7oKJvAhJeFfOFu66fmqLeltpVD/oHfLowRwVpybj/oh8GoyuL8etSTbGnzUNZVIpNd3Eooej23JxFfZM5REw5mQ0w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAdrPP35; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAdrPP35;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3sj60h3Wz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 15:35:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777268122; x=1808804122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ozE2gj8f8+W3qqqzoaibrIQnOnln+jv/o7/Tav1UM9Q=;
  b=hAdrPP35SFKyTMnBFB8PMyur4dLSLWOzW0oydXFTEMSqhRLkOateoCpI
   D5tIthRjaUrZAKtsJ33PygRX7SRuXNBhHw4GGielPmselYyEHrcRSM9TC
   gfIMlELXpaAFJGxbgYVkZqhvsKd5LNMC5IBAfrCB7QNjy5GmhocqrHvnz
   AD19DwbomyBj+T062/tNRf9RW7gSyWv0A3ce4EE1KUxnBte4+gheg04m7
   u04eOj9GCT3xPFgKrx21VP2lHFcQWLj/YxXzFqTTRTA/EfhJlLiJdnVpP
   3nSKJdstbrvtwhxl1yeVLaxkeAihNfkieP60vVK939bX9gVp7d66tfiNF
   Q==;
X-CSE-ConnectionGUID: wtBfg0vWRCeEjVypoy58Nw==
X-CSE-MsgGUID: kmvVxBxHRwmEnQs0wgWAZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77306756"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77306756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 22:35:15 -0700
X-CSE-ConnectionGUID: xefZ0jCFSFmjHvSJiiJG9g==
X-CSE-MsgGUID: 5etHSNQBQcGmyuiyt3X8qA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 22:35:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 26 Apr 2026 22:35:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 26 Apr 2026 22:35:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 26 Apr 2026 22:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqKmS55EwC73r0hO/4Et59FEw+568usZlXYvopVz6fDPQR8WLy38cXeqQJbAU8qyUwln0eToh1fBwiVU5tC1gZePchfub/k71awRoTDwjYt5lMGb0jgKfl+9deAbvFSo6CMyO5Jdp3DiaTxhGBl2av1CBmDRwgEJfBZ55jcreNg6u5nzIhDFWAsnUhu1jqSu8evCFbVLhxpHpbd1Grtv+ESvsvWe8318p/soLamdQM4hoXLSW3IXF3/AognCr10x1dGGlzw9DNopmLHvfX6ig6qDHgAXzPnlkOfUJOrl8EX+GPUyxInDlsTmAYIgMvBx1QEEVt1+upq6egFwAjT7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJmljEhWJLVtziBiJ4VVcU3g592qzJRgG/4coBwqnDY=;
 b=iHTWSiE4YT62FosPoH7I3UpHiGmi4cvVrMy62dszDZT6f3Gb6oXlYOxjnmunj/muJ13ZjTE2GYbXEGZQVGh3K6sHQv34fgvvmMt7DK94xIVc/3eqCHTFK5LqZrBLw2kY7YjCRexDtnHAqwYitPLOD8cir8gmRm/jAjXMxCwfDvyDLs5pThqOFdY9m1dQVt+JLV4Xe6GJzCoB0Ssp6aoxLau7EjrWvlrH7u6gdhkeuR7Jxkww+f6RWKPxrgXVS9p4D6wYwvQ7W5SGQmOJQy1NpbKxe4RlPxxVgJP4h+q1PmHjou0kX9xJo1/a9qkW4kT9wdXzOGEs+vYe5+hWH5Ok9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PR11MB9532.namprd11.prod.outlook.com (2603:10b6:8:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:35:11 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 05:35:10 +0000
Message-ID: <917067af-0d7b-4064-b54a-4b97eb7ca65c@intel.com>
Date: Mon, 27 Apr 2026 08:35:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <mpetlan@redhat.com>, <tmricht@linux.ibm.com>,
	<maddy@linux.ibm.com>, <irogers@google.com>, <namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <Tejas.Manhas1@ibm.com>,
	<Tanushree.Shah@ibm.com>, <Shivani.Nittor@ibm.com>
References: <20260426064301.90614-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260426064301.90614-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::33) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PR11MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: c53add0b-9379-4ffd-1b9a-08dea41ebfb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3YJJpMymqnYQhhopt/uvJMfKBxe6lGVBu0JtzUDbkcCsSEYqkMPjz4oJ/dYSUdm58mA7qgAUA0CartJHFkXGuZfmPm+v6lhu0SxvoR9ZGoDB1tLObZHRWh1sEtuhVoIOensD1Jrn16klKPPrHJXP9zN9UohrUah2QTF/4Kz5FegMVEYHkvax/inifJg9xIBD7aXWZS8AwJXBKCy647QQF0jTkML0VgLCFFuDfuA4TDV1YLUxE/9wrGKrizd570QhWp3bkCYGk5vyKMT5OO9f5yuPcu+zVxOfkirpl0/t0grAQK2gbUu7PCou08jdY+ct3IjR5RzVgTB54JHefA4CN8eD8BIb5hmfcOHTTcqV+L9KsUdapmy46yzPYu7w9ymbQESRWf4Xaaa5BFl4imEM3HOkzfHand3+B80glHCCCkMDJo/nnpCG9rtIN3MHhWJcEXFiEXVht3vFiqR75Annilj0bWzzEhx12GU68Ngy7LUvGTb8okRcoIF5+rxWYsZRhaF3h0id/PSM4F1OpP/So1H0Fl7DA9KV/jJe2Dmpgsahzbjn45JB/h4eUbv8N1qrcDz+mrMGePJc/XC8Tim05oUFYfaidAAaVn6WincJd8bRwmg5X0TSqd5QwIy3IiUOv9Hud5SCe2AWI/2DOOH4jOwzExGJJjzbLKjTu5jQX2vQOSre0majG/+6JWcMwtPYG5b6+gglxdk1+f0A3nYPNkZI0xIf6mD6nMQOA68aD4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJqcWU1U1hXQXRTUGk2dEl6dmxMdDhKK1RlSGZBelQ5UzBjZ0RQcXRMclRx?=
 =?utf-8?B?a2ljV0tIbmFzdlc2OXlKRXBMbzRSMFlpbmYzalA3UG9UenJsM1l2YktxTnR1?=
 =?utf-8?B?N3pQdWxrc1UyaXBoZ2lwUU1yeTVsektmWTA4a0J3Zkk1dk1TcWJ4WWx2cFd5?=
 =?utf-8?B?RmdiNTViMlA1WElSMXh3RHBmMlhQcm8vdXJNYllhdmVXTmJZb2J1R3dBdE91?=
 =?utf-8?B?QjRNeFcwNUhaaDFhL2M4RFVSZXlxK1N1NE1TNHNkdjlCZkdMN3VUZHcvRTBC?=
 =?utf-8?B?QXUzU3M5SEs4bUV1QUdKQnlDeFA4QWdzRlA4YnhDY1A4MnR3WTVzc0E2d0U1?=
 =?utf-8?B?T0dUYXVyNUp2U1h1OXNGNzQ5T2xYeTFWNnFIbVo3WFFxNkxCNzJ0cFV1SmNN?=
 =?utf-8?B?aWhYdFBGeU03SFdJN3I1MDlETVR6cHk4L0UycTlsL3h6Y3pienh0L1pCS0lB?=
 =?utf-8?B?QUxTT05Fa1pXL1RDM09ld2pqaHhLc3BpQnlwNkZGQmo1ZXNHQ0NUaHB0dldx?=
 =?utf-8?B?QTNFc08wdWRLWWhadzl5MTR4aTFyS3JpbkZ1VmVDQTdWQU0wczgwcnBwRHJK?=
 =?utf-8?B?QVowaXlGeXZlaldtSTVpMFhvZ1YyQlRHcSs2S3BFQ2RBV2lyRVI4OTIrSEp4?=
 =?utf-8?B?VlFKNHpEbWsvZGY3OVdTV1VaUnYwQWtmZ21IaEFaS2RMZk9LZUhoUHlxd0h1?=
 =?utf-8?B?a1luZGhxYmhkUjFlMStVQmViam0xaFZ6S2w3T3M5QXNwamxLd0pqR1BxWngy?=
 =?utf-8?B?akx5Qjh4S1d2a3ZEdHlXSWFrTTdEcFNBci81d2pRUXg2cGk5VS96K0F6Z081?=
 =?utf-8?B?UHhFdlhhRUNHaWhSTmNnY1ZYNjZONTBqN2sycUJ4bW5zejFMM3pvSGRlMzZV?=
 =?utf-8?B?aFlsRENBdlR0SGl1Mno0WENzOXhRYnJWOUZXU2dLYjdCK3JwVFJha0ZqeFpa?=
 =?utf-8?B?K0NhUHpIcHlQOStoRjRROUt1N0Vkay84R2ZqU0xIWjV2dFQ1VWZBUVFJbWRC?=
 =?utf-8?B?QlViejQ2UzZ2SEd4VDc5SHFLR2NWV0VLOXUxYnBUMU54cHhZRnlhaDRwbEpk?=
 =?utf-8?B?bDFSMUI0czNiTUM4aGp3M1g4dlVxaGZ2ditRRnhCcFhja3FPNVhzTkxNYkxP?=
 =?utf-8?B?TGUvSkttVSt6M29HWFRSSWhYR05pVC9URTUrcEc3alBaMVFQR3orYjgvYWdw?=
 =?utf-8?B?Qkw0STNnTzl3VHVTUHRDb3VaS3NrSGxQbVZwemlUVWVLbnpuNnNnVmpZNkJK?=
 =?utf-8?B?NU9ydlhPL3ZiQ2VQaGtVTWxZTEVBZGNGTTlzdDEwdkNBQ25IZU5HS05YRnAx?=
 =?utf-8?B?N215Y2F5Zy9OM1N1SDNDbWZsajBvUXU5V2tuUEd2TEl5eVY3cit2R01sQnZT?=
 =?utf-8?B?R3hEVWpTaVZnd1hnTUJCVnZ6STZXVTNnSFlHcVB1Zmc3aHZMZ1o3WVJZMHZ0?=
 =?utf-8?B?VjZxQzJmcDNIYUlkd0FDcWRmSkxQVWhZTWVKVjY2TmVGbU5YMDY2ZzJkU0lh?=
 =?utf-8?B?T3drVFpHWFAzK3d2ZFFoK1YrMStkdUVOK2lpdXhoSUdlSHBRMkpiYWV4RkNk?=
 =?utf-8?B?dGJDWnZLV3pvbUdsT0IvS1hwTEJ5RElnNW1ZRkRQT1pJenliZC9HeCtuRkF3?=
 =?utf-8?B?aUhLZlhldDhSV1JXUVpqWG43K3FMYzhrbFJxeTg4ckhxTVliRDJhekZVbHhl?=
 =?utf-8?B?SnlWK3pxQkhxZkZMTE9LcW10TjgrZ3l6cmoweWtjN1RWOXFLclZMazJwVkdp?=
 =?utf-8?B?NmpYbU9icU5DQlVyWWdJVE02ZkJRV3VISW9FQk9Idjh5RXRGdnhnclRVU3dH?=
 =?utf-8?B?WllEbmwwMzY5T2llNk52ZVBFbmlxM1RQcmN4ZE1QVEhoTVdhQWRwOTZpWmNY?=
 =?utf-8?B?REFFVVBsa1hGU0cxdUxGZzRUM0ExelV3K0VBaUVKME42b1hzY0IxYi9EWDJT?=
 =?utf-8?B?WlZxOGphKzYxZU9RUDJ1alRZWFYzWXNqQU5tcklzQ0ZHVGlTSjVKTjF5Zlht?=
 =?utf-8?B?dWhhK2dKQytJV2FidmZaNkkrSDN4Nm5KK25EcWRHdjlYYnNsdjVsTFROUndl?=
 =?utf-8?B?SFM5WjA2Y0Z4ZXlQRDVTT1RzdERycmw1Yzk5aHM4eFY4WUY0WjUzSkVXeUwy?=
 =?utf-8?B?czgzbVRPMjFVZWVyY0pHM2VHOWNQM0RPSnhNOFQraXJtQUh6YnpBQkV2L3JX?=
 =?utf-8?B?TUt3OEpEQzRsT2Yrb0R5WG5TV2ZONjlhaCt1VjVNNndPTjFrMHZoL3ZRekZi?=
 =?utf-8?B?ckNxNUdGYnVYQW52L0RKL1J6eWxwck5HR1JBSGxhNTZYV2IzZ3N1d1NuMzJL?=
 =?utf-8?B?T1lURWVxSUpDVEl3SzU5YUs5WnVSak1xSXR1MWo1UTBCaHg3blZ4REhadnNn?=
 =?utf-8?Q?AhgqaL85blfTSDhQ=3D?=
X-Exchange-RoutingPolicyChecked: f3O5EUGjDm/DWBu0ph18T0VftW77N230pKEI7HQeOQlW1x4KhzcCnoay54fYpcZXdRkTRvU08YzMr/LY720ozk4EjMjAMCu+xYQkqKKrEV+n/zFh6l9CrIDqV09YKYF7mppWx1YnqGaOwSlZvOr5RsvR1xPj+7pYd6S2oBokCtxBitRxjhG/c79Der/HeHfkxydXaGqMAW5Oz+eSHN09clXhEbm5XBfp2iKAnMYOvXE4HD4G0OCT1InbbxnkJ3f1QziFOT/GuwKb4y/RblryS/TGuYRC9RSY6F/vNtk6LUZJkY43USIF8NZXV8IaChj6EKGjsAZnACGc3HpBAMeDjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c53add0b-9379-4ffd-1b9a-08dea41ebfb7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:35:10.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgwR0Pp2A9Kl9am6DWEHgsjEgPWlfPAN0H5ypdtWNGv2kM9yQMuqAVbGU3gxz6LENhjIiYVMjfYNjJVak6aQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9532
X-OriginatorOrg: intel.com

On 26/04/2026 09:43, Athira Rajeev wrote:
> perf trace record fails some cases in powerpc
> 
>  # ./perf test "perf trace record and replay"
>  128: perf trace record and replay                                    : FAILED!
> 
>  # ./perf trace record sleep 1
>  # echo $?
>    32
> 
> This is happening because of non-zero err value from
> auxtrace_record__init() function.
> 
>  static int record__auxtrace_init(struct record *rec)
>  {
>         int err;
> 
>         if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
>             && record__threads_enabled(rec)) {
>                 pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
>                 return -EINVAL;
>         }
> 
>         if (!rec->itr) {

Perhaps also add here:

                  err = -EINVAL;
		
>                 rec->itr = auxtrace_record__init(rec->evlist, &err);
>                 if (err)
>                         return err;
>         }
> 
> Here "int err" is not initialised. The code expects "err" to be set
> from auxtrace_record__init() function.
> 
> Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
> err value in the beginning.
> 
> - Clear err value in beginning of function. Any fail later will
> set appropriate return code to err.
> - Even if we haven't found any event for auxtrace, perf record
> should continue for other events. NULL return
> will indicate that there is no auxtrace record initialized.
> - Not having "err" set here will affect monitoring of other events
> also because perf record will fail seeing random value in err.
> 
> With the fix,
> 
>  # ./perf trace record sleep 1
>  [ perf record: Woken up 2 times to write data ]
>  [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/auxtrace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index e39deff6c857..fe1ea4e222f3 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -71,6 +71,19 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	struct evsel *pos;
>  	int found = 0;
>  
> +	/*
> +	 * Assign err value to zero here. Any fail later
> +	 * will set appropriate return code to err.
> +	 * Even if we haven't found any event for auxtrace, perf
> +	 * record should continue for other events. NULL return
> +	 * will indicate that there is no auxtrace record initialized.
> +	 *
> +	 * Not having "err" set here will affect monitoring
> +	 * of other events also because perf record will fail seeing
> +	 * random value in err.
> +	 */

Comment seems like overkill.  Prefer to add kernel-doc to
auxtrace_record__init() in tools/perf/util/auxtrace.c

> +	*err = 0;
> +
>  	evlist__for_each_entry(evlist, pos) {
>  		if (strstarts(pos->name, "vpa_dtl")) {
>  			found = 1;


