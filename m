Return-Path: <linuxppc-dev+bounces-25864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C13C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 14:21:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM4Cy4gPJz2yS0;
	Sat, 15 Aug 2026 00:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786717294;
	cv=fail; b=Jxz78LoJMgz0vA5gWlxNNEnUUDuQnvDdPr108pJbt6Up0OZfXF+INg4UNpPj8DibLFR8RvdwOdNc/eR6phtOw9XV3x6aj7U7FoLq/iCnJtxKPzw0/Dh2yiG6ytfE29trfNMmcZLe5y6nxP5gZoRhsp2YEQe0fMPLjvtn5mfNYd0jgMDJqzrgUha5IhCSIolDqCSv+u1etWtXa2lefsJL0Ltnkj+fiko7x9DVE5XP8jf5PVScyqQiR9LCoOm2Bn1khLc8x6+zqVfZa29XcaKt+cjeYWvt/YWiGd7eYRcrBCxDlB2jVL/rR0JJT+xkRhZ40A7xuJxjz9rc5JqEGj9Xug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786717294; c=relaxed/relaxed;
	bh=biRpjTNI6O1A31jEOx6gr3zThcm2GXT5RutUEGseSHI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FVVWhBEMcOe1cAtbUtcfrEw4XmODzGRhRAIuthem/8I9jWxXs1FcsQbabh1PqZ2En95+P5BlzmP7v9CqpFOflMjBDmXYKZwUNcvropTmiWuwcqT/2/uUm9tHiB0dT7lQPvvZ48ZHP4u7hoXWTLKbsHJG1dgFcUTTcAn7AYElRVJKywe6lsfUllSTY2dNGpT4YxFHfF6tUqJqtK5d17OLrS7V6yiRaMinU3P1555kiRp1W0B41+OT3io7x7d7txjxRstxsYBgTdALsVSPAVmURG2dUoPXXlJVL4tyk3ehBIHGt0Kl0Tb+yOpPi/gYBGpjXXPv6vYQhuHxgwXfJxgKvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jnlCNkti; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jnlCNkti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM4Ct0pH4z2y8f
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 00:21:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786717290; x=1818253290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ClhndfeADVBCHNlrEPKHh4ceAFYbL+lyTqoWyxdtmyM=;
  b=jnlCNkti1lS8c87bdnBFnmudJ/6ZqzoqUTf2w28iYQHpFkFqL3xG5FuV
   fQrGuWv1psO97TW4/mRN7n5dnbk3T2PePapT49lduvFL7HFrkul5k98kp
   PbR+lTWmUtMFxNH5NUvMBQUqnTFIrggg7qmhh/MeMhiv1XZEb+tWKrluR
   g2V9zD3UjgD9H8S8GBhJ8A3zo97xt+04n/biJ2Z3ShT1hWiXCo/hnOt1u
   CY2odlBCWDMFP6NVleJ0s1K3nNeLCvTe67hvQF3ihX7J+h7fgAmU3FluH
   UWQZuQIkZQdsHtuTHputgoEvByaIuRGShV/1TQ7q3zZYirQnzRI1gciKY
   w==;
X-CSE-ConnectionGUID: u6ebeJPiTPW9lgGHIU7wPQ==
X-CSE-MsgGUID: eDoEnKIfTgyLEwEJhaMIyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87318307"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87318307"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:21:21 -0700
X-CSE-ConnectionGUID: 3yghuQ1KTYK6IqNQnT8l4w==
X-CSE-MsgGUID: 42xPPjANQuSP9c2nLFTIYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="289037531"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:21:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 07:21:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 07:21:21 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 07:21:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm3yKEosXMp3m1BFfER/Gj+1JN4dr+pN+qxHYHlM4x6KRhWg3krBDRTmXT9EtYatS+KKmnP9pE35CR44jGSw8WJChSOumZTiY5dsz0ZQfXpsyKucUeaK/uwug/So5B2T1aGYq5jcfxfoXeajO2MerZt8pwQz3CzrsT+gy0c+JQlB571aamFOY5vJdIavLynNj5DIbJK079LMV8r+16QByhXBo7fkbaqvr7AnhyuWGfNtE4Gg2VLRvajWS8F5m5ZVr+HCrfQJlZ2jAhe9ZZSfLzuzvrnAocltY9aVudDO4NkZSm0ErwmHfToPZh7jX/jNce412WWA6C3vKcCOzrTjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biRpjTNI6O1A31jEOx6gr3zThcm2GXT5RutUEGseSHI=;
 b=BQoxPck3YCaRNONJ7ABIyp7uR9nkoaAcjILcqOYU3kuWE07hkRECsYeh3o72+APT0j+/GP8gPXrNna8OhW3jOj+ZFcJ+H77Ivg4sM7wV46GDgx19lhE3XfbYnlbwnwCjQeOtfFBmtHlGlspvMqIMq4okS73Oovj1qkhmx5EgsOXVEF1gjbqG6eaT6uo+k2+AytfdgvS0g867oXMQZgfTkG4vOYrnxHJTj0rgpieRjjWaCasba2CtnMZAad9ERdVgf6Dm4cbDX8OgOGq+uQ+hMFrnt5amJ/RInIFI6gEVJXQvTRrMR3M+4MYAUjp6LbAelj2sIHGBmd46f+OP0jixTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 14:21:17 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:21:16 +0000
Message-ID: <0baf654e-be23-45f0-b213-c7beaf73e70b@intel.com>
Date: Fri, 14 Aug 2026 17:21:10 +0300
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
 <ecbfbe14-5202-4efe-b829-1eb2590cceaf@intel.com>
 <04E662EC-0CC0-47C1-91B9-A96BA93496A7@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <04E662EC-0CC0-47C1-91B9-A96BA93496A7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2f5616-42e7-4822-f730-08defa0f4d6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|3023799007|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GRQ9cZe62i6CR5Rgoonm9Z9BcfV824bg49G0JoeQe6tF5uGJz7uf5WL9YEKTOBObSZ5zFJ2wxQo1J3vkQP/HPPQcQKFDDnBl5+pvHLBWx6A2Dr6ZTj0gunK1tlaGdHYHS3hWelXhXUbkz2h40M3XdVKWLD39Kus15awuRlUCTNcr3FZ0gp5hdXyJN7saheQFQ9Blq/weyYlzaRJkax+2cjjeF1TM342z+UwhO2j2pe7lXmohJ3XEqjyltQCyn486ZoqwHIz7YfvIyb8X3xDv9pJLVE4ls1qdAYgShVPAAFxMvXmyU4XYXjNt475phgT/LIgmTFbrWUF850po00mIjQd8HDlZVuXg6A5Ag4YzrRlSemknZ8gmOT4R0yRN0xBpRiv/xYXwDwkpAn0Lc0lx8SUpV1Wsm7LhLAOlvGJkSd+7KEIk19DVks0+2qSUrI1BzlTb5AQtdGwel1jf0+Y9dYR9uYS6hzOPyed7yUpV6xZKKS1JxuwgRkdLepPZOCIbTuR+cFTb0NCVn0tVNlZEBNfM3vmHNwMcFeVZk0E8YJxegU01EJSAgtzimrl+i0IQGZj0eckS4HBBHrhP9nvwEENn9U5ZCQPkHaWENsZYb0/KvX++GfkvfYDgrvZ3JKA5QjUZRyJygwH9rLfhLyvepqvlG90p8R5gpCkQnpOCwxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUorTC94UHdVRk9DUVM3QVBwZTFzUDJHNVJKQldHTzZ4VS9WbnNwRWpPaVZo?=
 =?utf-8?B?ZDVwdk03WmprVytJeWpsTmJqYTJJbDN2YjZlZER1SGhYMlB0R3UwazhVRU1F?=
 =?utf-8?B?bko2aDQ0cDZFWGp2QUdoNFovblk5SENKSUxkbWlPdWVleVdzMi9kRXB3T1BM?=
 =?utf-8?B?YmVUM29pb1YwdFJ2WkNsd2FWM2hnZUNMTnFDMjFWNm5DL25ZbXVuWkNMdjUz?=
 =?utf-8?B?K2NxNmk3MzRCUHdQR29HU2RkWHB5Y052Nk5NenBrZkNsM3pKeTdKdG91Ymds?=
 =?utf-8?B?NHFwWkZtbjJ0UVl3OVpWMGluNUlCUlJTK3RTaUh5Q3U3WHl6VFFCMjY3anJu?=
 =?utf-8?B?aFFDbjUyYVNWKzBmSFdXRjFOZUU4U04yNG5kTzh6U3JZbVEySENZTjhwck1J?=
 =?utf-8?B?cXFGYThTUU1VenVoU1dqQWpjaWkxY1FxMWhUS3BZUDF5SCswV3JmcEVDNlpL?=
 =?utf-8?B?SFlISnM0M3FaN1h5K2poSTlvRUovMkVhWjArK1YzWkkxVi9nVjkrRFFoL2l4?=
 =?utf-8?B?cXluWmdJVEhyejBZUzNrcGEwTnVPeDVxL1JXRUx2b3UvbWx1RzdTVERSNVAr?=
 =?utf-8?B?OHRqV3ZTanVablFUaFhmOE5ROC9ldFlGczc1ZHVEWUw0RVI3QVJWc3p6dXpV?=
 =?utf-8?B?N1lsS09wanZRUGplYWtnalRjYi9aMVkxRXVHR0pFaGFWSnI3c2tHWkJwWFRC?=
 =?utf-8?B?NU5OdlFQSUJZNzBOS1BwUFU4TGw4K29VLytjRWFFMmdBd1JCZmJQNkZrRm1Q?=
 =?utf-8?B?ZDE4MzBBcUJEVXg0amZpVWZkTzNBUUVPRi9Mbi8yYmllL2JwemJCQkN0YlJz?=
 =?utf-8?B?UWpoUkhUZXNDQzIxSGsvQkdHOVVxTExCSGd3YW45MXBkUVJiUzFvMkNTcG5w?=
 =?utf-8?B?cjRNeVI1dVdJUXVmdXhXTmJreWpacmhhNkUrbFVLVDJSQWV4bmVHR1I4R3Vt?=
 =?utf-8?B?SG8rTk5uYTB2VXNraTA0djlrb1h4dzhVS0tCbW5SUWhjbGIrdk15eE1mVXlO?=
 =?utf-8?B?Sy83N0FGR21wZ1VyZTBxU2FibEZhSXBCQ3lUaEFkTmJLTUxZeVVEZ3RuVWZG?=
 =?utf-8?B?bTl0bHYwZWxYNE9sVEo0MUtZeEhlS29nMllMWEFUWE9hQUM2Y2Rka21VL1Z1?=
 =?utf-8?B?VmtZQTUxR1pEM20vWmlkU0ZESFQzcXFUNGp5WW1wZ3dnajVPVVJ0YjZHMUNt?=
 =?utf-8?B?ZWpSSm5kZmRMUVpzWUk3amNFRHp4YU1BNjB5K3VpaFRrdVRQRGR5TjV1Q0wv?=
 =?utf-8?B?dlJha0pXM1lmT1QwR0g5cXc0c3BZdkhlTWxwcWtmSDZodXlqckVBRGlkbERK?=
 =?utf-8?B?YWN6NUkxZGplQy91dC9jU1J4ZkVINWlTZllNL3VkM1VSbDNsZS9OVXNkRllF?=
 =?utf-8?B?RXZXSERyQ0xhMEdWV2VqNlRTM0FCeDRwdlVsRkNiZG1sYnUxdlA1YzZ2N2Jz?=
 =?utf-8?B?VDR0MFpETEcxaXVVWTVJTmFKU1Z6c2hmN1dHSyttRjJRU3pWNnBOMWJUYytl?=
 =?utf-8?B?NkRIamlQN1NNQ0tvMGNrbHpWNGtESnh0VjYzSmlJR3E1cFJ3QXd4VXlUR2o3?=
 =?utf-8?B?VzZkVU5RdlBCcVJTdklIc05kSnpIRS9iTDc4WkI2NitXdkFkbkpQWjdCK3Ru?=
 =?utf-8?B?T1pXRklxYUo3VlVpUlFZQnVYVjdrckVReEcwSG14RVZDNGxCVk43ZDVsanp4?=
 =?utf-8?B?TEhCbEw3NWV3alFDTTZhMTQrUnM5SmtHMGROcG50Y3JBdllHOTUzWUVwcDZm?=
 =?utf-8?B?M0xCaHFJUklQZUtaTjRDbzU3a29pVVNrWEIzbFZOYU9lSko4Tzk1NVcwVEVR?=
 =?utf-8?B?MTRocEZtZXVhMzBnVXJOd1B1RDFvd095YytDUFN0ZFNSK3EyNG1kbFF0aE1z?=
 =?utf-8?B?R1RtRmgzRzhyRDdwQ2lvN1MxSW1wUFc1WEVUU2RlcmZzbi9QQlBNYmU1dldl?=
 =?utf-8?B?aHRJeUJZUGtYdm9KRzJjMjVQS0I3S01TbmJYZVhGV2JTQjZDY3hJdFU0OU8w?=
 =?utf-8?B?RENhOWRUSVNYNmMvaGx6ZVhiQ05pRi9mZnluMGgrRERQR2dhSnZObDZENmNR?=
 =?utf-8?B?OUh0U05CRUJFN0JCelVXMzl4eHIvOHR1eDNRSXdaQzBvVERsOWVBNUlITVpt?=
 =?utf-8?B?M0hJQkVCVHRWZWZGL3EyR1R5MEpJbTNPc3RIcU52UUxaK0IvZkdibDJXVUZE?=
 =?utf-8?B?M0FBWjJzRFQwYnRUUllaeWJyd29TRUthSjNLQURqZ2NvajdaWUZiVzMrNnpO?=
 =?utf-8?B?T2lvNE5DS0Z4S0Nia3JJOFVXU2ZIQXpLR2lJQTA3WnJtenRSc01Nd0x1Q09O?=
 =?utf-8?B?bXVnVExPbnBFaGl3aWcvQXRON0xXZDVRc1hVSHl4dElTMlNPdlQ2RjFQemt2?=
 =?utf-8?Q?y0RfnmdDJ7AlUjVQ=3D?=
X-Exchange-RoutingPolicyChecked: b5TMuiR//rtisFlhbqizUB7jJW3ya7BYITMezHXlEK+I6AiCntdhLU9eFDGKONYhisueP2sFB1DNi+wGmF1MTxq3XkH68yl5ONKJ9HuWuml7Q3ZF+PszLPojFiwnYePOlNy43RRJYu98UaUbZ0JhtsOfqLp5VpgbRU4g3k1+3t0Sb10HYmt7fUIccR9/wc868kBcU1hgTAcIwa6+m6l+zwFqy+26IVHxD8ihn0Voy4bH/SL6WjgYtK8w+UrUQQ2GJWxcoyyBXBvVRJa/xvCp8rX7Qa21OBCn3kMrrhhybvskxzCEy9RMqybTKXi7XBQAI6RCCrsdKBV1/MC+HqKx/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2f5616-42e7-4822-f730-08defa0f4d6f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:21:16.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ5YKeZFD/sqZmuCGt8JQlTPN2XKopmtRwMgaM2maMDZEsFdJfn0qZlSgSIJ3/MhYDTqfT9cn2UG+9wksLMv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com

On 13/08/2026 21:40, Athira Rajeev wrote:
> 
> 
>> On 13 Aug 2026, at 1:17 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 13/08/2026 10:36, Athira Rajeev wrote:
>>>
>>>
>>>> On 13 Aug 2026, at 11:52 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 07/08/2026 17:41, Athira Rajeev wrote:
>>>>> Implement the arch_perf_record__need_read() architecture-specific hook
>>>>> for powerpc in arch/powerpc/util/evsel.c.
>>>>>
>>>>> The HTM kernel driver sets event->count to the number of records still
>>>>> staged in its internal buffers (total_size / record_size), and to 0
>>>>> once the stream is exhausted.  This hook reads that count for every open
>>>>> htm evsel via perf_evsel__read() and accumulates the values into
>>>>> total_pending_records.  A non-zero total means at least one HTM target
>>>>> still has records pending; the recording loop added in the previous
>>>>> patch will perform another mmap-read pass.
>>>>>
>>>>> The drain uses a two-layer safety check: event->count detects records
>>>>> staged by the driver, and record__bytes_written() in the drain loop
>>>>> confirms data was actually moved into perf.data.  This combination
>>>>> handles the case where the driver count is briefly stale while hardware
>>>>> is still flushing.
>>>>>
>>>>> The implementation scans the evlist using evsel__pmu_name() to identify
>>>>> HTM events by their kernel-assigned PMU name rather than the
>>>>> user-visible event name, preventing false matches.  It iterates the fd/
>>>>> sample-id xyarray, and skips any evsel whose fd and sample-id arrays are
>>>>> mismatched to avoid reading stale state.  When the accumulated record
>>>>> count reaches zero the hook returns 0 and the recording loop proceeds to
>>>>> disable and close the events.
>>>>
>>>> This looks like the proposed driver:
>>>>
>>>> https://lore.kernel.org/all/20260701083806.79358-1-atrajeev@linux.ibm.com/
>>>
>>> Hi Adrian,
>>> Thank you for the review.
>>>
>>> Could you please help clarify which specific aspect of the driver breaks the perf ABI? Is it the sysfs format ABI where encoding raw hardware topology identifiers (nodeindex, nodalchipindex, coreindexonchip) are used as perf_event_attr.config bit fields?
>>> I am trying to confirm so that I get your feedback correctly for reworking on changes.
>>
>> This "draining" and "read" usage looked unusual, so I asked AI:
>>
>>  I have just applied the patches for powerpc htm kernel driver - they are now the last 5 patches committed. Examine the design in
>>  comparison to how other PMU drivers are implemented. Does it violate the kernel API for PMUs? 
>>
>> It said yes.
> 
> Hi Adrian,
> Thanks for taking the time to check this.
> 
> I agree with the assessment. The core problems I understand are:
> - pmu->read() issues hcalls that stop the hardware trace and dump the data, so any read() call ends up
> silently draining and stopping the trace — which isn't what read() is for.
> - event->count is being used to signal "more data pending" which breaks the expected semantics.
> 
> I'm going to rework this rather than continue posting on top of it.
> Here is my rework plan for your review:
> 
> Kernel side: workqueue-based approach:
> -  pmu->read() becomes a no-op. No hcalls, no side effects.
> -  pmu->stop() issues hypervisor call to freeze the hardware buffer, then schedules a
>      work_struct (htm_drain_work_fn()) that runs in process context and drains the frozen buffer
>      chunk by chunk into the AUX ring via perf_aux_output_end(), backing off on -ENOSPC to let
>      userspace consume between chunks. event->count is no longer used as a flow-control signal.

That sounds a bit like pmu->stop() wouldn't actually stop.
I can imagine there could be issues with that.  I suspect
only someone like Peter Zijlstra can advise you.

> 
> Tools side:
> -  arch_perf_record__need_read() hook and record__final_aux_data() are dropped entirely — no changes to builtin-record.c.
> -  “read_finish" callback is implemented in the HTM auxtrace_record:
>       During normal recording (evsel->disabled == false) it returns immediately. 
>       At session teardown, evlist__disable() sets evsel->disabled = true before the 
>       final record__mmap_read_all() call. 
>       The read_finish callback detects this and polls aux_head (via perf_mmap__read_head())
>       in a loop, yielding delay between polls, until the AUX head stops advancing — signalling the
>       workqueue drain is complete. 
>      This gives the kernel workqueue time to finish copying chunks before evlist__close() frees the mmaps.
>      The wait has a bounded maximum, so a stalled drain can't hang perf record indefinitely.
> - snapshot_finish returns -EINVAL since HTM does not support snapshot mode.
> 
> HTM has no interrupt and trace data is consumed after pmu stop .  Hence making this read_finish callback for
> auxtrace_record to consume data.
> 
> With this, data collection is moved of from .read() entirely and uses work queue based approach.
> Can you please review , Does this approach look acceptable before I send the updated series?
> 
> Thanks,
> Athira
> 
> 
>>
>>>
>>> Thanks,
>>> Athira
>>>
>>>>
>>>> breaks the perf ABI.
>>>>
>>>> I am not going to review any more tools patches for now.
>>>>
>>>>>
>>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>>> ---
>>>>> Changes in V5:
>>>>> - When an HTM evsel is a group sibling (evsel->core.leader !=
>>>>> &evsel->core), read through its group leader's struct perf_evsel
>>>>> instead of the sibling directly.  perf_evsel__read_size() uses
>>>>> evsel->nr_members to compute the read buffer size; nr_members is 0
>>>>> for siblings, so size=0 is passed to readn(), which returns <=0 and
>>>>> leaves count.val=0, causing the drain loop to terminate prematurely.
>>>>> Reading through the leader avoids the zero-size buffer and correctly
>>>>> accumulates the leader's pending count.  HTM events are always
>>>>> standalone or per-target leaders in practice; the leader redirect
>>>>> handles any grouped configuration without losing counts.
>>>>>
>>>>> Changes in V4:
>>>>> - No changes from V3.
>>>>>
>>>>> Changes in V3:
>>>>> - Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, "htm")
>>>>> to identify HTM events, matching by kernel-assigned PMU name rather
>>>>> than user-visible event name.
>>>>> - Remove the redundant two-pass loop (first pass to set found_htm,
>>>>> second to accumulate counts); a single pass with evsel__pmu_name()
>>>>> is sufficient. if no HTM event exists total_pending_records stays 0
>>>>> and the function returns 0.
>>>>> - Remove the dead !strcmp(evsel->name, "dummy:u") check;
>>>>> - evsel__pmu_name() will never return "htm" for a dummy:u software
>>>>> event.
>>>>> - Rename total_pending_bytes -> total_pending_records to match what
>>>>> the driver actually reports (event->count = total_size / record_size,
>>>>> a record count, not a byte count).
>>>>> - Add #include <string.h> for musl compatibility (strcmp() without
>>>>> it warns on some toolchains).
>>>>>
>>>>> Changes in V2:
>>>>> - Implements the renamed arch_perf_record__need_read() hook (V1
>>>>> implemented arch_record__collect_final_data()).
>>>>> - Skips evsels whose fd and sample-id xyarrays are mismatched, avoiding
>>>>> stale-state reads.  V1 had no such guard.
>>>>> - evlist__enable cycling is removed; that responsibility now belongs to
>>>>> the drain loop in builtin-record.c added in patch 3.
>>>>> - File location changed to arch/powerpc/util/evsel.c (V1 used
>>>>> arch/powerpc/util/powerpc-htm.c).
>>>>> - Patch is now 4/6 instead of 4/9.
>>>>>
>>>>> tools/perf/arch/powerpc/util/evsel.c | 77 ++++++++++++++++++++++++++++
>>>>> 1 file changed, 77 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
>>>>> index 2f733cdc8dbb..2b7851c70677 100644
>>>>> --- a/tools/perf/arch/powerpc/util/evsel.c
>>>>> +++ b/tools/perf/arch/powerpc/util/evsel.c
>>>>> @@ -1,8 +1,85 @@
>>>>> // SPDX-License-Identifier: GPL-2.0
>>>>> #include <stdio.h>
>>>>> +#include <string.h>
>>>>> +#include <unistd.h>
>>>>> +#include <linux/string.h>
>>>>> #include "util/evsel.h"
>>>>> +#include "util/record.h"
>>>>> +#include "util/evlist.h"
>>>>> +#include "util/debug.h"
>>>>> +#include <internal/xyarray.h>
>>>>> +#include <internal/lib.h>
>>>>>
>>>>> void arch_evsel__set_sample_weight(struct evsel *evsel)
>>>>> {
>>>>> evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>>>>> }
>>>>> +
>>>>> +/*
>>>>> + * powerpc implementation of arch_perf_record__need_read().
>>>>> + *
>>>>> + * Reads event->count for every open HTM evsel by issuing a direct
>>>>> + * read() on the event fd with a plain u64 buffer, bypassing the
>>>>> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM evsel is
>>>>> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on its attr;
>>>>> + * perf_evsel__read() would then call perf_evsel__read_group() which
>>>>> + * sizes the buffer by evsel->nr_members (0 for siblings), causing the
>>>>> + * kernel to return -ENOSPC.  Reading the fd directly with sizeof(u64)
>>>>> + * retrieves the HTM driver's plain pending-record count regardless of
>>>>> + * group membership.
>>>>> + *
>>>>> + * Returns: 1 if more data exists, 0 if collection is complete
>>>>> + */
>>>>> +int arch_perf_record__need_read(struct evlist *evlist)
>>>>> +{
>>>>> + struct evsel *evsel;
>>>>> + u64 total_pending_records = 0;
>>>>> + int x, y;
>>>>> +
>>>>> + /* there was an error during record__open */
>>>>> + if (!evlist)
>>>>> + return 0;
>>>>> +
>>>>> + /* Read HTM event counts to check if more data is available */
>>>>> + evlist__for_each_entry(evlist, evsel) {
>>>>> + struct perf_evsel *rd_evsel;
>>>>> + struct xyarray *xy;
>>>>> +
>>>>> + if (strcmp(evsel__pmu_name(evsel), "htm"))
>>>>> + continue;
>>>>> +
>>>>> + /*
>>>>> + * For group siblings nr_members == 0, which makes
>>>>> + * perf_evsel__read_size() return 0 and readn() fail.
>>>>> + * Read through the leader instead; perf_evsel__read_group()
>>>>> + * extracts the leader's own count from the group buffer.
>>>>> + */
>>>>> + if (evsel->core.leader != &evsel->core)
>>>>> + rd_evsel = evsel->core.leader;
>>>>> + else
>>>>> + rd_evsel = &evsel->core;
>>>>> +
>>>>> + xy = rd_evsel->sample_id;
>>>>> +
>>>>> + if (xy == NULL || rd_evsel->fd == NULL)
>>>>> + continue;
>>>>> +
>>>>> + if (xyarray__max_x(rd_evsel->fd) != xyarray__max_x(xy) ||
>>>>> +    xyarray__max_y(rd_evsel->fd) != xyarray__max_y(xy)) {
>>>>> + pr_debug("Unmatched FD vs sample ID array for HTM event\n");
>>>>> + continue;
>>>>> + }
>>>>> +
>>>>> + for (x = 0; x < xyarray__max_x(xy); x++) {
>>>>> + for (y = 0; y < xyarray__max_y(xy); y++) {
>>>>> + struct perf_counts_values count = { .val = 0 };
>>>>> +
>>>>> + if (perf_evsel__read(rd_evsel, x, y, &count) == 0)
>>>>> + total_pending_records += count.val;
>>>>> + }
>>>>> + }
>>>>> + }
>>>>> +
>>>>> + /* Collection is complete only when ALL hardware queues have no pending records */
>>>>> + return (total_pending_records > 0) ? 1 : 0;
>>>>> +}
> 
> 


