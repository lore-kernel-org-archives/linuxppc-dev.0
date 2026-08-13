Return-Path: <linuxppc-dev+bounces-25792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381CC5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:23:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFgF5qskz2y1Y;
	Thu, 13 Aug 2026 16:23:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786602233;
	cv=fail; b=ku++EdNQptb0Y7uVm/6d7LJEMvEaSFTomyYv+wNLF1QEh5NtlFCalEilzseOpvxz4BtHbltKZ/q+dAMh6q76USDLonnvkxBBmmgKM+Xpoa1OLigY80Xulq7wv8dh8Je5aMR2VqTp7H8ltYpMinZqVsIVFSQgQzW+ASUm5CVi5H8QVbKljXlLbqTQXc8XzR79XP5ebSBQQKWrgL5q7q3XgyHJ+h1LmulitKkuN14DCl8+k6IueRDhi7/HPwaxzJeRMjYKFlcC8EgyshgnxYrVbaedtMBo7jl4VhKEbNn2MpG9vus0EoBI7xKDCOLj46jVk0AIgrlf4EeHSAih+31B/g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786602233; c=relaxed/relaxed;
	bh=wfcjnI9CBbyWZHEI7tud3D8TdoZJwyUIiF7C8TxPF64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPPHIlpMiWRb+AdqswSxtaF52t0lK2NU8kS/zXI5UT4I/RZ2uA1tJwcP/BQZyhO9N22MoPy4LwQsUGkKZ/MtnIVJB0xb4TcM0Spras6MmITJetkk1HUA757VaL29tLtugmqNMAb1tqlwhmlA/QVaAAcG6eZZKvvUXK1h8Kym/a+hUQNagYcH92WVrtBWfAnX00+Fe1x2WEcOMCSEkeSrNhrcaMxuIDGyNtbXCS/8ZiobfZ8G+9JC3Xtlg2c2CxfOkYoUxNYjSmkNDQ87CrZptJuhqPPJidR1J3HAAPZUoLtXPYEMxXWJGE3oh3T4yIjZ90bftKrHcBY8q305CgMqzA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BcyNSUZb; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BcyNSUZb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=adrian.hunter@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLFg93ZJyz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:23:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602230; x=1818138230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wVOzRDg7p0WmwzeKeyGo7tXJv3EEJ3AZHYM9x/w+Bnk=;
  b=BcyNSUZbvNzDKMZJGdMgdSSPz1ZXCDP150RsaYGz7r7YsEfW/QBRzCFR
   bw/7J9lpJbnP3rAZmrAFyFMQ1/ZkRsLvAJVnz4fuGTdhpLykFxSgIpjhg
   w0x0n1AWk7P3RcHvAxoWSxXp3CN6dM9hriMDj8d5MB/Isaji5Y+LogIMF
   tcGrrXvEAM+UHyKqSZojrvztCbhJrbr95k3y6yD4tbv6dOGh5YpFCZhrW
   XSYjGG1HT9yCxERFUUMNpxus5rcpMDqpjPA0Cp9sVSa2prw0rJPi+DMdx
   af+3xp26FjYxx1B0X6CqMepopikMTjDwHj7BbihVXYMbj+o0rmMhRZHAU
   w==;
X-CSE-ConnectionGUID: XmcZGazpSXejg/mRsOGc8w==
X-CSE-MsgGUID: AeBphprwRISU891S5e6tUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97757689"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97757689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:23:41 -0700
X-CSE-ConnectionGUID: D3gvUxRORK2Z2nWUPeckoA==
X-CSE-MsgGUID: UpXRooNUQ9a9Zeo0thEPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260558305"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:23:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 23:23:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 23:23:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 23:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vluAEjFHRlavh71M3oPsrv2G6lF7Jxmo9i2Iw+iIvIzIvFowro/Z5J3/QRvDX4DwQVev8cOT/gpua0SSjzvGcT+i2Zd++wwJWJlw7296ExLTObTvNgbeD9bdhSJHt9Mho5rqZ3901L7QRNcmXB65PqcHoJHoJOVkmNQ8Rp/N+TJp/s1UmCr2n63IUDdVfhc7mAiyXixBaRjqnh7pVAe7jzNOz4Ai9BS6P51iSq3wLBmWEBzWMxREVpo4keaW6VEDt3/gbIykPuMpcMk0G4qD1vfQBrDAAltbUgjfeaPyj+HvhQTACRbs/1wI1gfnGiboLOlrV9Q6jWbzuH3cnSAQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfcjnI9CBbyWZHEI7tud3D8TdoZJwyUIiF7C8TxPF64=;
 b=Y19M7K6qdSiKLCM6uhwQyKtTQpiTuE0XDZYMIMmPWSf/dgsBJx6KWRgp1p+7CY66nGkQ/0E0vr3d0ZFPFi8J4dc4lS/jWx2vbTNAtmYKmNAt/6gCjkADor5bLw/U0zwZb5h8r9f9sh4ve5A30D9rKSDB6ZqkL3Hl2Kz9NV6W+UH0TCU5P25kJzL7cQCR+/ppGIFM7iZDcaASrqLRCGpj7TDphmUPcZAgukwtC8U/nhepmc13R03EgA6Zmd1TgeCw43PR5HAtxfL70yfeWBQy1VjPc63fMJaaYncY8P9zTFx3qh3BuaH4DIioF2Nhoy7E9OijSRpOAPK8Vk5Wz3tbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:22:21 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 06:22:20 +0000
Message-ID: <a6424439-d42e-4f62-92ee-525c7f2d4277@intel.com>
Date: Thu, 13 Aug 2026 09:22:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
To: Athira Rajeev <atrajeev@linux.ibm.com>, <acme@kernel.org>,
	<jolsa@kernel.org>, <maddy@linux.ibm.com>, <irogers@google.com>,
	<namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<hbathini@linux.vnet.ibm.com>, <tejas05@linux.ibm.com>,
	<tshah@linux.ibm.com>, <venkat88@linux.ibm.com>, <usha.r2@ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-5-atrajeev@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260807144135.2607-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::20) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faf1401-9601-4d2d-2693-08def9033afc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: QhmuY/JJ0RnnzWMhjeVH8bN5cHF5EsAaNmX+04W5sddS6DTpSh3ma4pPeVRRQp0pXBAL+aXo97TSbPV9L4op+MoxA97qqq3hT/740QjZdM5pcAZRFHBEQTgcCE2yyl4T189X24y/g5YHu4Cb+s6452CxiSE5pkUs0+sQNq6tziZXgetPos7jeATboZ6yEsIeucKWXc1Rav3wLjIHq0URcOQOv9Ib3ongargqAF1kgPV5WvR70r8SZx716jb0MYx/3mYrGYqgi1Ou6sjKot9qyXcSb4DAJWCMHhJuA2Dw4XYtMdwKpyADI3zZoOKVlyd3fsw1Hcur6simIyoSvDs/aSM2mAxwGravF+k0Yha4CHxjWhTddhQzXR8nuaIj4KQPw3SBhKvDiRMit6RHAmYXn1iffwWDAte4CUtg0ymPq3UcjdagPzj0hZ20SHNbM0ZkEcm6MYQsKo+Pf3fnJkjXflO5hQLQlValO4mY1Qf2rZWtgZJc1GWCAQoUc5X5nE03LwpiKg10p0ze1J+uBgYRaPCf4po04mWHxzgnXviA4shGhvFOufWE1LcdU2fshmXspLEfbCagTOZtimXsbRT2GBCsKk94a0hZgmuBHuySnYbtkI0/Ow/Xs80mvIvnf9PyA56CX3gf/yaAATyiWl3X+DTArEdL0COJgCSDhFUw5cQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJwS2ZzV29BTm1FVHBpZ0dLOXJGc2ZKQlpXeUsvTWw2bU5VK1RVZGhqYVMv?=
 =?utf-8?B?MEo3cGFKUSs1dXRqNEJJNmV5RW11cm1OMkJsUVBFYzZSeVkwT3RtRzdTTmlE?=
 =?utf-8?B?cjA2bElrRlJSNURBTzUvL0tjejhUZEhrSWxBcTY2VldTZng2RjZJc0tzWVVI?=
 =?utf-8?B?cU0zeE93UmRIYVVVMmtPR3JySDBTS3ZUUWM4WFhGWGprcGpQKzNiWFVGWFBr?=
 =?utf-8?B?YVpxNVpmbnpobzVSQlF0aDdvdVp2N1pOS0VTdFNNdkkyajlhWThJSjNmanpI?=
 =?utf-8?B?YlY3ajVJMkNhdjBoejdrdDdqMm5HVWErWUFjVFllRHBlR2ZERlRyWE1KUGJS?=
 =?utf-8?B?SzlWZGl3aXM2Mmk2KzB3c2sxUXVKL0NMMDE1YmVLdFJ1cnFtTDNBOERwdGdh?=
 =?utf-8?B?VFg0MTEwOENRamtkc3BGT0RtaThBUVJTMlFVYThWYXJNRHhjTVJOMDFWclFs?=
 =?utf-8?B?Q0EvUDBmbzlhK2ZTaUVYSnhoajJPUFprMGczb3dJc0dPZzlTb24ybDdOUkFF?=
 =?utf-8?B?bnloVXdNQm9NZys3bTZoRi9KVGJaYnhmV0M1NEFNZllOM0F5eVRtS0FMM3Vk?=
 =?utf-8?B?eWNNRGN1UHJLYjhmdWFvWlIxQlhCOVFQU0NINUROK1htN3FrS20zQm1aeFVU?=
 =?utf-8?B?K0M0YklkaXIyUDFaTjMyMUlDTk0rVERWZXNQK2kwcHMzNWhyRW9KMDJxRERX?=
 =?utf-8?B?R2tNTlRHUjJ5a1Z2MTZLVENFYXVVa0FyQTRwTm82SGd0Nk5vdWpFK1paZ28x?=
 =?utf-8?B?T3pXa21jZFZNamE1MXFObUdoSTBoT05qMzN6Y2VDanB3OWZVK2VEMTJaY0tU?=
 =?utf-8?B?NXp6MEVyRFh3U1FUczkwQVVST0p1U00rYTROcnQ5VWdkVFBldkZSUXlENzRS?=
 =?utf-8?B?eUVVc0hTNGY5SUJ5Sno1RUNMbFhnTmpPd1QzeVdXR0x2dFNqTFBkbUM4RitZ?=
 =?utf-8?B?aDdLVHkycStnMnhQbVNBWGlWaTRCL0I2blFSTmQ5V09EUWVTaDBuYzE4b3o4?=
 =?utf-8?B?M0F4QUZZMDM2ZEFzYTFGV2JXSFF6MVdFaG9Xc0gwZFF1Sjh2ZS9WQ0ROOHpU?=
 =?utf-8?B?Mk1tenBqb2NhaU11eW5iSkhWdlZmTG01V1BYeTVTZmtnWlFnNmtkYWZhZnM3?=
 =?utf-8?B?UHpSQWhvOENKNWRoYlBhMDVDVGZKNytLcUxyM0gzVSs5Tk1VaWdHWlFRTEpO?=
 =?utf-8?B?Qk0wK1hOMkg5Wk9ESlJLWSsyTTRtMkR1RjVqeEJLQnZrekZJL0JYZHFmOG53?=
 =?utf-8?B?SW9QdHBJRjg2MC9xYkR1TnlEOXRyMW5qdzlYMUpBR25rMlFIVk92RW1sZHBM?=
 =?utf-8?B?d3NnSU9hR3p1MERMRXVRMUVlTjRJcjh2aWFEOStyejF1MStKWlNNaFdybEpC?=
 =?utf-8?B?dHhRajJPY1FRWmhFK1ZmaFhyd3JvaUYzaU5DeVN2STlkcElBT05rWmd3clQz?=
 =?utf-8?B?MTN4UERIa0llbUpMUXB1THpKcjZ2SDZvZUQ2TlZuZXBNWCt6cGMxMUZuMUY2?=
 =?utf-8?B?bzdBUHB0N0lyQnMyV0wxUkZwNmRMdVFJWmxQZTdBZGN4OXNJdFlSc0ZDMHF1?=
 =?utf-8?B?VzRIeXIwd1dZcUE1bUJQRzVmS0Y5STZVM1VRUWg3ek9KaTJaeWQ3bUZCZmMw?=
 =?utf-8?B?YW82RnJhTzkrRVp2eXN4bW9JYkRoTlBJOExTbTVLV21lT2FrOVdwMlZsWVJ3?=
 =?utf-8?B?RUJDUlNoaXB5OUhSWTYzU3pNM2VHQ3IxemxUVTM1ZTB5c2dTZVJMWlBmN1lE?=
 =?utf-8?B?RllHenZqdG1JU3A3NnlwQkoxL09kb2gxSkxQaFVGdzBEc01tR2hUVTlPeDBn?=
 =?utf-8?B?QzZONTVpMHBKWjVJWlVISTJhaXpZTUZBRk1KVlhxNkZHcnVodWlsQVhCTFVU?=
 =?utf-8?B?Z3FQZ2ZEVk5rNzdiazh5UmtjQ1JSWmdDNzdsWHJJemd1dnJPRGhxN004R0Zo?=
 =?utf-8?B?eHJPOTlhaGwxTzJiQ091bllKWCt6MEtzU3RkejVRL3J3eEMvRUxKZGtrYmhr?=
 =?utf-8?B?TkpTZzc1b0haaDBLNi9HNUY0MGRob3hZYWhud25lcXVuaWVsdWFESUx4M0lu?=
 =?utf-8?B?LzdTWWxMZ1FESVNnTjN5Tjc0a2dNZXlETFYrWXZSRVB4NUkzYTVITEJYdXpk?=
 =?utf-8?B?QXV6cDhhbFRxRVZ1Q09WeWJrcW94R3F3NVg5Qk9Lb2U4LzdVU2UvQkdsYi8z?=
 =?utf-8?B?QkRMQTJwVVZkQUYyY0hqRHhzWGxuZDNpYXA3L2w2SXJsVFNzTU9jWjBUWXZy?=
 =?utf-8?B?ZTdXTEFsQjhwMDZwRTY4dlA5emFOWkpzOVJjWVBGSWFGWHpjYUFhNnpmenpE?=
 =?utf-8?B?WXpWUkZEdVNESVlCS0lySzFycEsrTXJJeEphOVJVdk9RYmIyKzBwZFZUQ2wx?=
 =?utf-8?Q?Tr4+Ul5TbNT23xKg=3D?=
X-Exchange-RoutingPolicyChecked: PeS0osAx3aPHtSjNiKN6eGWkL+grjA2z3NgGBlMGx2AOTjqItDxJNcCC9wdKcoFodwLa50V5G60KlzC/3szSxuD85EGRRhbwzVfkKoUJ1Cun/7pwcGaX1iRSaucn3Fo9/jtBiwPM5bUhVAQRc1Jo8v6fBWVEAI1d+nylQFvaYjaaCRTKp4ALUySKKng+ExYHxFZmU4MD8evnSpgdZFHepL4018wKn8jT3dNZBHmgP/U7Fz3w4dtxU8wdodoRUr1+XZbTLiJ7uG0KwAxhgFpdgrEhDgWObVE1UydVvk6e4iwyLahQVMb7sl/UMVhN7CeUx06tcwUkYD2bf65km15ETA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faf1401-9601-4d2d-2693-08def9033afc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:22:20.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4k2bbqDm7+7cMNuxKoF2ZInDkaQTTs6+4p9MkasZAnyPwDkS2o/QkQ6VSR16CuqEbUtINhiVBneVtoawpJ7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com

On 07/08/2026 17:41, Athira Rajeev wrote:
> Implement the arch_perf_record__need_read() architecture-specific hook
> for powerpc in arch/powerpc/util/evsel.c.
> 
> The HTM kernel driver sets event->count to the number of records still
> staged in its internal buffers (total_size / record_size), and to 0
> once the stream is exhausted.  This hook reads that count for every open
> htm evsel via perf_evsel__read() and accumulates the values into
> total_pending_records.  A non-zero total means at least one HTM target
> still has records pending; the recording loop added in the previous
> patch will perform another mmap-read pass.
> 
> The drain uses a two-layer safety check: event->count detects records
> staged by the driver, and record__bytes_written() in the drain loop
> confirms data was actually moved into perf.data.  This combination
> handles the case where the driver count is briefly stale while hardware
> is still flushing.
> 
> The implementation scans the evlist using evsel__pmu_name() to identify
> HTM events by their kernel-assigned PMU name rather than the
> user-visible event name, preventing false matches.  It iterates the fd/
> sample-id xyarray, and skips any evsel whose fd and sample-id arrays are
> mismatched to avoid reading stale state.  When the accumulated record
> count reaches zero the hook returns 0 and the recording loop proceeds to
> disable and close the events.

This looks like the proposed driver:

	https://lore.kernel.org/all/20260701083806.79358-1-atrajeev@linux.ibm.com/

breaks the perf ABI.

I am not going to review any more tools patches for now.

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changes in V5:
> - When an HTM evsel is a group sibling (evsel->core.leader !=
>   &evsel->core), read through its group leader's struct perf_evsel
>   instead of the sibling directly.  perf_evsel__read_size() uses
>   evsel->nr_members to compute the read buffer size; nr_members is 0
>   for siblings, so size=0 is passed to readn(), which returns <=0 and
>   leaves count.val=0, causing the drain loop to terminate prematurely.
>   Reading through the leader avoids the zero-size buffer and correctly
>   accumulates the leader's pending count.  HTM events are always
>   standalone or per-target leaders in practice; the leader redirect
>   handles any grouped configuration without losing counts.
> 
> Changes in V4:
> - No changes from V3.
> 
> Changes in V3:
> - Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, "htm")
> to identify HTM events, matching by kernel-assigned PMU name rather
> than user-visible event name.
> - Remove the redundant two-pass loop (first pass to set found_htm,
> second to accumulate counts); a single pass with evsel__pmu_name()
> is sufficient. if no HTM event exists total_pending_records stays 0
> and the function returns 0.
> - Remove the dead !strcmp(evsel->name, "dummy:u") check;
> - evsel__pmu_name() will never return "htm" for a dummy:u software
> event.
> - Rename total_pending_bytes -> total_pending_records to match what
> the driver actually reports (event->count = total_size / record_size,
> a record count, not a byte count).
> - Add #include <string.h> for musl compatibility (strcmp() without
> it warns on some toolchains).
> 
> Changes in V2:
> - Implements the renamed arch_perf_record__need_read() hook (V1
>   implemented arch_record__collect_final_data()).
> - Skips evsels whose fd and sample-id xyarrays are mismatched, avoiding
>   stale-state reads.  V1 had no such guard.
> - evlist__enable cycling is removed; that responsibility now belongs to
>   the drain loop in builtin-record.c added in patch 3.
> - File location changed to arch/powerpc/util/evsel.c (V1 used
>   arch/powerpc/util/powerpc-htm.c).
> - Patch is now 4/6 instead of 4/9.
> 
>  tools/perf/arch/powerpc/util/evsel.c | 77 ++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
> index 2f733cdc8dbb..2b7851c70677 100644
> --- a/tools/perf/arch/powerpc/util/evsel.c
> +++ b/tools/perf/arch/powerpc/util/evsel.c
> @@ -1,8 +1,85 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/string.h>
>  #include "util/evsel.h"
> +#include "util/record.h"
> +#include "util/evlist.h"
> +#include "util/debug.h"
> +#include <internal/xyarray.h>
> +#include <internal/lib.h>
>  
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
>  	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
>  }
> +
> +/*
> + * powerpc implementation of arch_perf_record__need_read().
> + *
> + * Reads event->count for every open HTM evsel by issuing a direct
> + * read() on the event fd with a plain u64 buffer, bypassing the
> + * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM evsel is
> + * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on its attr;
> + * perf_evsel__read() would then call perf_evsel__read_group() which
> + * sizes the buffer by evsel->nr_members (0 for siblings), causing the
> + * kernel to return -ENOSPC.  Reading the fd directly with sizeof(u64)
> + * retrieves the HTM driver's plain pending-record count regardless of
> + * group membership.
> + *
> + * Returns: 1 if more data exists, 0 if collection is complete
> + */
> +int arch_perf_record__need_read(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +	u64 total_pending_records = 0;
> +	int x, y;
> +
> +	/* there was an error during record__open */
> +	if (!evlist)
> +		return 0;
> +
> +	/* Read HTM event counts to check if more data is available */
> +	evlist__for_each_entry(evlist, evsel) {
> +		struct perf_evsel *rd_evsel;
> +		struct xyarray *xy;
> +
> +		if (strcmp(evsel__pmu_name(evsel), "htm"))
> +			continue;
> +
> +		/*
> +		 * For group siblings nr_members == 0, which makes
> +		 * perf_evsel__read_size() return 0 and readn() fail.
> +		 * Read through the leader instead; perf_evsel__read_group()
> +		 * extracts the leader's own count from the group buffer.
> +		 */
> +		if (evsel->core.leader != &evsel->core)
> +			rd_evsel = evsel->core.leader;
> +		else
> +			rd_evsel = &evsel->core;
> +
> +		xy = rd_evsel->sample_id;
> +
> +		if (xy == NULL || rd_evsel->fd == NULL)
> +			continue;
> +
> +		if (xyarray__max_x(rd_evsel->fd) != xyarray__max_x(xy) ||
> +		    xyarray__max_y(rd_evsel->fd) != xyarray__max_y(xy)) {
> +			pr_debug("Unmatched FD vs sample ID array for HTM event\n");
> +			continue;
> +		}
> +
> +		for (x = 0; x < xyarray__max_x(xy); x++) {
> +			for (y = 0; y < xyarray__max_y(xy); y++) {
> +				struct perf_counts_values count = { .val = 0 };
> +
> +				if (perf_evsel__read(rd_evsel, x, y, &count) == 0)
> +					total_pending_records += count.val;
> +			}
> +		}
> +	}
> +
> +	/* Collection is complete only when ALL hardware queues have no pending records */
> +	return (total_pending_records > 0) ? 1 : 0;
> +}


