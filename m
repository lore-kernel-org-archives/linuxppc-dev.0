Return-Path: <linuxppc-dev+bounces-24723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30524C531C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 10:28:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5S5T4Bw3z2xyj;
	Thu, 23 Jul 2026 20:28:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784802525;
	cv=fail; b=bQ71pTlk2Xboc4azRpoEWYgSKndepySKBnb56WlxD77SvLIwX39vEHxbYAlH68mPCKDddTCtnm8kCQTCt334qYDwx1gVVT8dy0gkbq9HfL4FcDAOTg3rqN0jkdolOsfsnrwMusbsSasVyFTDwypx4iodeN9sJiuVLP+Lcdw0HnNh9vxoNKfytwlr1UoAQFym1pffEFs3JedGh6YVdHmDCuhD45gJ/DVx/0td45Gq7B4sxrQvIZ5Q+E7NrY7KFWIxUdHxyxmwySfgNbKgy1P8QvmS/thc/2jfUdtkFLQf4YrxesNtdwxruvoZjkZhu4DSs/EZOM+lU0TMrXHoQBRZDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784802525; c=relaxed/relaxed;
	bh=iPF1lJZTdwvRCLoT2JhD3+B6JxK6myHyXBoLI88skv8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zh0AAGe9siF/qhaxAq7Qixx1jg7L39OnXI9NNmZwYC+7tZWLb7Ne8sjCwLhDuruqD4rgRIxDMo27sQXKdmo0HUfO2xRXUt2V534kS7zeeR++/oAIXZIeqS8OZvrd70J1O4rK9CfguM8B56C/6daSBl2eQ5gErHcmNuhQbeU6P997tb/k8I4rkokpglOygwS1LDeUWL1p8rlP4Jbp6h/joVbvAABzR2xenA62kUbVVKU1V5NUuYbEP27aMa6x+BdLA2TyCrYMzJeIbFXh6HHrIc863NymAUZ3eebI1WBeH49ckWu4EIcyXkb31y5yWm1AkJblSWnTIenDmcxR+Gq5Ww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MR7qNHoz; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MR7qNHoz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5S5P4cS2z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 20:28:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784802522; x=1816338522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tH8LqjAjuErMgxxvqAYBdPcTJXC8AV+2SUKc0qK74u0=;
  b=MR7qNHozLeFljDplIvo76UXDH8oiBAufXvdKSGlCDCeJmIhBx/oZ2Tqy
   Sy2iyBrTYkg3VU3AKFjJ8dD4Zs73R2FCcnCUIdFe2zueRM9hhBxEwE594
   lqTuC8eXPHnvdHEgzqOH4nTTevQU/oont4zMfXBej3YyhwqEIPHDlcraw
   gzizwKIPD2zmMDRR9c/PC1F8LzGpgr7UnD5jzINEx0v8xA3HxoZWzJeI7
   FJD+TjyeJJ0p+EpIbOxlHD2TbGmgfFRuviuKJbZu8TeUen+46uEjolzt3
   VTrVxTjFsd8Hk0xYVZjmgMrpt6zpx/5ueAlIYNpL+X72x0bLx+B9MYtq7
   A==;
X-CSE-ConnectionGUID: LKjj7x2CRmuYmVJnTcjG7g==
X-CSE-MsgGUID: yRp+1qngSyGZhXn1qOQMag==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89349710"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="89349710"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:28:35 -0700
X-CSE-ConnectionGUID: SJcT1EB3QWebRsVVJOTnIw==
X-CSE-MsgGUID: /tJif6KGTJmztsv6vkhIJQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:28:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:28:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:28:34 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asFrmZbYI+XhrJX8JMqSqv0ebQB7lkHcwuKCVcKVU9V557EJmDMwB0+gNdOwhBoYl0tSkjGoYhVhry/jeuoX5GzuVqa85itAdmkmSeBtN3Na7UiXV7YYAvR0jS82tiPIkCjohIBzxNy30J3+lf/qg2vmzdx2JE9NztWp6LJfbY+3R9lxqeys3l6CIwcGmOmh99zxNrVXE/LspLuasXhH2aXEkaahhf54lRrz0SHmvIrGtN3S7gAAG7ALHkiuY9ByWu6vb6KgBJLBtYsR492+Y8anYRTc+2D9BFcDvrHMTjhSJFLrbNhwwPXwf8TcJYL478HMzQBwJRxEuSszzin30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPF1lJZTdwvRCLoT2JhD3+B6JxK6myHyXBoLI88skv8=;
 b=f1RbFtnTAJoXpW9cfoMiMl/UA6xrt5EiNmgiHy50f1Dc0qQFm3LN542efik9+d1Cp7Rsaw74ysZNAg2hKZWDOSt+EyOKKw2TTSWzduYxqnkluEP5hPi6ahmm7ewd2GqNrmlBmU84GTtYsLvfxF4SDxdNIlqHsRRikXhzDCaLveDnzSqTHhbosHdTkpDwQJSZNcu2PixVQ+XVfxj1ZjYw9cbreTvIjwasZNGMLT5p+mKYBOqvzlULuX5JJyoSeDSy/4JKQ7pEezFE67FLa2IMjgnPBXRezmYOjCTtOZ6VzZreZf6bcE9ZvdL+EYHeKW7j/I4W59jZGA67C0GC/Fo+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by IA1PR11MB7891.namprd11.prod.outlook.com (2603:10b6:208:3fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:28:30 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:28:30 +0000
Message-ID: <37e68669-7587-4781-8ffb-0cbfa8a13d12@intel.com>
Date: Thu, 23 Jul 2026 12:28:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] ASOC: Unify code style for platform_device_id
 arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Srinivas Kandagatla <srini@kernel.org>, Shengjiu Wang
	<shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
	<festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li
	<Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
References: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
 <093867d47c079d2aaab06bccaae734c54c342a7d.1784528081.git.u.kleine-koenig@baylibre.com>
 <0f625961-8e2d-4ed9-ab5a-fd95bcb4c87a@intel.com> <amGhHDDlwMdool_q@monoceros>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <amGhHDDlwMdool_q@monoceros>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0003.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::8) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
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
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|IA1PR11MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0034ea-9fb5-461d-5298-08dee8a52389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|5023799004|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /yr1Nen9UbMBJfEFeAOPt2SyxW1CUq42ueyeYSxdLWL4wKh1AZRAfhf7NEFwin6jbHP4NXwPEmvR+6k6OfRQ8XvdRJuO+XQqdcgd1TRRx7t4r8DU/FA2JnCD4g3S1C1f3OShwq2GwqCI3lOe2e1MgaO57UqUb2Ds8GUa1Bv8q/kuDEujM2ARsdpISVLdl5xWDfTqiMJ1FzOOJuz+IE2vWXDaBNUBQsTPlMA1/0+z+sksYznOFiQlq6h5g6aNCIbECqH8F9asJGdcYftoxVAFZAeafh2giUDcQL26hzvs6fbaHVbaWDOaWTrqtUGePu+9bjqYKrYtpy7GOnuemP25VdSyoVdbY7GaLlkzk1IABr/k/JcRbtRp9CpqHwsBThrIEW9JfvzEetZ6STDjWNLzOsENu8Tn4bzw7Wb5ad9ZrIN81lDmkI3X5RiZy4vBLjWCejVr40uAzZmrMmqvpTifsoP6Tz7mq/hCmgAXOXAf/g9zdlz/WW7GtYwuT21vDpEFmk86/T/B7STwX4P+hFNVxukD9jzPm2Sh+f/0ggDsh9eBFQGoTvrlNUdpAwjgchOxRdqbBAEzXExbEW3XzECjRn6pOJCjl+Sl8/P00nCEwCVJL2bnq0UgtqrrHlUdASMb7rT4SBBX8rXW0HrAExkYD1bfMXZS0K6Zejfmv/IsLVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFxOGpMd2t6Szh0cDl6ejkzMTBrRkdXdlYxWEl4aTAwZHJJSkY3UDQzZllj?=
 =?utf-8?B?T3Y2ZXc2TzFoVm93RXAvSjYxSzNpWFJhMUpjUWtucjFjanZhcUNOZUl1Z0NQ?=
 =?utf-8?B?Qm1ISWswR3FWUTNXL3pnY1FhaWhUd0lZTjdyN1hEbEhUYVRiNkpBR0tUWVhC?=
 =?utf-8?B?SGUzNzNTZTJKZ1J2YUM4N2plY2JscDBaKzBtQXVDdXhFQmswdW9TVFc0emll?=
 =?utf-8?B?WVVabXdJNjRlTmJlMWJycS9TNjJZTW9xT0dqbXNMS3ZoTlpGdjFxU2dqSmZO?=
 =?utf-8?B?VG5sKzFQa1dtVzcrNUloS3FMWVh3M3FxbnpjS2dCNGExeGFYeHR2d0lQVXgx?=
 =?utf-8?B?S3NzUWJsUEdndmFKaG82UXcvVmMwZEpqTWphVzZNRnArNnVhL1BRVWRIMU01?=
 =?utf-8?B?T0N6dHRnMWp6TEYvVGxIejFJOVZianhOTk9SOHcvZnVFbFZKS1JRbjFqMEto?=
 =?utf-8?B?ZGFuSzArWG1rbDB2WkUwOEgrWDNPZDJYc2lqWEFDcWZqV1pyUkt4eG4zNnF6?=
 =?utf-8?B?THRCbklMZ3IrK21ndWxsc3hQNGxPLzYzWmgxbDRNYjNYZzhpOVhSRnkzVUYr?=
 =?utf-8?B?WU8rc3pVa1U4RDNMcDFxUkFaNHQzOEV6aEc2eXNPTzBtb1ZMak94Y3M4OHF3?=
 =?utf-8?B?TGdyU1YrZFVaanprUHZJQ25qM1lCVFozZ3NFbmRUL3JMeFVEaytaMHJja0Qx?=
 =?utf-8?B?UmkyRVcyV0FsaWkyc0x0eGV2VGdGR2FEVjVmSGYwaG5YWjQ5cWRERjhLRDFU?=
 =?utf-8?B?NzJWOXc1NFNSdnczZXAzT200R28wZm5KUTVTSHFNaXVqcjduNFljcTZSaS96?=
 =?utf-8?B?MUloWlV0eGZLTVplZHpkYitqTXlJNEJ4Wk55QU4rQ0hYWFJSdDJkbk03MWVz?=
 =?utf-8?B?SklqZmRjek1KZy9LM250YW9iZ3dLcU9kK3ZjRHNQRkdlRm0wa3dENHRXdTEr?=
 =?utf-8?B?Q2VMSnduQURCZ2hGTGlQL3VPUjIrdXVvc3ZMNXVodUhFclpGUUNBajF2cE1E?=
 =?utf-8?B?Vmdzbk01d0ZxL21qL20rY0lsaGNjZkhKeDh1Z2lPeDB6Z05sOEZ3UnBHUXo4?=
 =?utf-8?B?WUpxWVdCZW4zV2hUTGNFdnJ5UzBCdm5ndVNjaHZ4MnBEZFRYQ3BRTjVhQ2xG?=
 =?utf-8?B?RmFxeVRqbUNaU1F2cThLY3lPdEVVRHZpSjNVZlZ5UkdMYzNnMThBdHl3azRN?=
 =?utf-8?B?em8xVTBSMFlDTS9tYUtROWdCdzVJNm9EZEVTR0RvMDZubjkzTm5YZ3ZsZXIx?=
 =?utf-8?B?Z3JJRXoxcVVGVzZiaURibUJ2WjJMSitDRk4yUzYycG10Z2N5VDRGQnh2RE9K?=
 =?utf-8?B?Q1RlMEZqcm01Wlk4UlNVUFNkVFM1WjlEeDIvTEx4ekZKTndLQ3VPcVFJUm91?=
 =?utf-8?B?UDNHcDJjWkRobHJzNGkrTEVVdnhIY2ZtYXlCSHdCb2ozcXNQL1MrcDRJa0o0?=
 =?utf-8?B?OVNudkx0THVtMForMm5XcUptV0NrWVYxYUZqc01hdUMzQ2VUK3J4RUZidXlN?=
 =?utf-8?B?S2RFYVNzdHZpemtYWXl0ck1McVBBMUVhejhuU2FQc1dnUkZJUW9VQ2pVbVVC?=
 =?utf-8?B?QnZMSzlXQWhLOU0rSVlzRGsxRk0zRWRhRUlDbzIvSUVmRWlMeHRpVTg5UWMz?=
 =?utf-8?B?ZGlaWXZqcnNkK2Y3eGhrRFNWc2N6b1Q1Y1VINHJ3bk5odmJ3d2I4UXZlKzE1?=
 =?utf-8?B?RlVWMjl3M3dqdi92VDFSc0RHN1hxV1NIT0Y0YXVLWlRvTk9kNDJNRFNzQ25X?=
 =?utf-8?B?anF0bDMvZUFCVG1mUUUzajIyeHU5bFdTdkhVRnQ4dW4yMGprM0RZb0t3OWlQ?=
 =?utf-8?B?OGx0azhsRXZDbDk5VEpwR01NNUx5UURKZEZPaHpHRzB4ZTlLdUdzWVJKZjZh?=
 =?utf-8?B?cnRabkw4Q3BPWUZoZGxNK21TamxzMFpxZDBQNTZjakJYY2I2WGtxcVNQdHpK?=
 =?utf-8?B?SHI4a2wra3dwQXNmdjlhZVIwMlRVdVUwWkxEQUVqaWE2eHR6MExxZ3lsbjkv?=
 =?utf-8?B?VGkyemczd2VDTmtjelhVcjRNN3JlY1hqTGdqS2hPd0NIZXo0cVdQN1pXeHVD?=
 =?utf-8?B?UmI5azhWTnM5dmVmTHF1Y0ZpSGFPbVYvZHlFMnMwL0U3S0wrcTQvckJiajFi?=
 =?utf-8?B?NU9sU3k4R21yd1R4YVhPMFlHd3Mydi9udlJnaUpuVmJPKzdiSm1WRXIrK0xS?=
 =?utf-8?B?cCs1aWkySVhNdkdRR01BVEUxUHg3cC9UR3lYWnMya29VNjh4OGcxelpxS21X?=
 =?utf-8?B?ZGRnam5xN0g0QkJTODVtWnBqbVdYYmxaRU9HeENDVGZmR2V0TkNQVmVaSFNL?=
 =?utf-8?B?OG0reWJZZTNhcmdqU2tlY3lEdXRPLzY3REtCcFFKdWRxRktVdDBCKzJQTEZR?=
 =?utf-8?Q?HJj5hWapApuC+bi0=3D?=
X-Exchange-RoutingPolicyChecked: gWbV9+diSEx7b7NZq+hnG3hFTT+svm1iA8IkvzxKC9E1jjDCDzwTKGtUbiOhWOuUkhvZ/COY9urwWP4/NvHrwlKaIQCde+N+PRv5YFkh6TXQZDRmodIWBpdwK3/9HLBeHGRBVbw9PWHdPZbHTwGrWnmThEKp6lG2Y79SSonDqiYW/p+xNnKrK3ZZ4a117LHa1ufv+tfAjef0YU/l9vY03+rZCxMhVxETUNWvwUpt7fW7Cd7b0VS+2eOHUml8Q4WFnjjJ8BPjFZd786t8OUq2Wjc0GuqeQLjmJJ1YBcuZRF5Vurps5KHL8BLPCdTAgfpmDRzGT8DEW4qyDUmhLFdESQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0034ea-9fb5-461d-5298-08dee8a52389
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:28:29.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUHjwnThIidYst1ycJC7VlguCZEYBKAn6FTEhbLGBBrEpLX/I2Hg3/q0L9Gb9izVBD51bpcp8cOwTb/b3gnEEkEY1vsqB8rsvZfwJEq2oeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891
X-OriginatorOrg: intel.com

On 7/23/2026 7:30 AM, Uwe Kleine-König (The Capable Hub) wrote:
> Hello Cezary,
> 
> On Wed, Jul 22, 2026 at 07:55:26PM +0200, Cezary Rojewski wrote:
>> On 7/20/2026 8:23 AM, Uwe Kleine-König (The Capable Hub) wrote:
>>
>>>    sound/soc/au1x/db1200.c                |  2 +-
>>>    sound/soc/codecs/adau7118-hw.c         |  2 +-
>>>    sound/soc/codecs/bt-sco.c              | 10 +++-------
>>>    sound/soc/codecs/wcd934x.c             |  6 ++----
>>>    sound/soc/fsl/imx-pcm-rpmsg.c          |  6 +++---
>>>    sound/soc/intel/avs/boards/da7219.c    |  6 ++----
>>>    sound/soc/intel/avs/boards/dmic.c      |  6 ++----
>>>    sound/soc/intel/avs/boards/es8336.c    |  6 ++----
>>>    sound/soc/intel/avs/boards/hdaudio.c   |  6 ++----
>>>    sound/soc/intel/avs/boards/i2s_test.c  |  6 ++----
>>>    sound/soc/intel/avs/boards/max98357a.c |  6 ++----
>>>    sound/soc/intel/avs/boards/max98373.c  |  6 ++----
>>>    sound/soc/intel/avs/boards/max98927.c  |  6 ++----
>>>    sound/soc/intel/avs/boards/nau8825.c   |  6 ++----
>>>    sound/soc/intel/avs/boards/pcm3168a.c  |  6 ++----
>>>    sound/soc/intel/avs/boards/probe.c     |  2 +-
>>>    sound/soc/intel/avs/boards/rt274.c     |  2 +-
>>>    sound/soc/intel/avs/boards/rt286.c     |  2 +-
>>>    sound/soc/intel/avs/boards/rt298.c     |  2 +-
>>>    sound/soc/intel/avs/boards/rt5514.c    |  2 +-
>>>    sound/soc/intel/avs/boards/rt5640.c    |  2 +-
>>>    sound/soc/intel/avs/boards/rt5663.c    |  2 +-
>>>    sound/soc/intel/avs/boards/rt5682.c    |  2 +-
>>>    sound/soc/intel/avs/boards/ssm4567.c   |  2 +-
>>>    sound/soc/samsung/i2s.c                |  2 +-
>>
>> This change is outstanding when compared to patches 1-4 which follow the
>> per-driver approach.  I'd expect one driver per scope e.g.: Intel's avs
>> split away from the rest.
> 
> Well, patches 1 and 2 primarily follow the one patch per type of change
> approach that happen to only affect one driver each. In the v1 thread I
> was asked to split out split out the amd/acp bits which resulted in
> patches 3 and 4. (And just now I notice you also replied and asked to
> split out intel/avs, too, which I missed. Sorry!)
> 
> Conceptually I think one commit per driver is the right approach[1] but
> most maintainers/reviewers seem to favour one commit adapting one thing
> for all drivers in a subsystem. And in my experience no matter how you
> make it, you get a reply to change.

Couldn't agree more with the last one.  Happens to us all :)

> Will split out intel/avs for v3 and maybe hit the sweet spot then.
Thank you.

