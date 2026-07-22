Return-Path: <linuxppc-dev+bounces-24662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02645C4453A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 17:55:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h523v22wXz2xyj;
	Thu, 23 Jul 2026 03:55:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784742955;
	cv=fail; b=IKehO7jy27/YZXZeh2TgiER9Qb/0sB96jdmxER9RtdazjXVrFtmO1WWcFqEtQMX+1cwE3897oU1/RPb1rpN4UHDIP9/wRyAGps8cWrWR1ITC0zmBkskSJvjXJIdhBLmAtIAH7DRZBC+SD6pY0QoIcugMBLJOsUJAHmbismpS0WlnqFQuAaqDIkq1kAPyrHyNfZU6zt+QlEu48GMcGqpMuLEoxe2epjNpmfrxgLTGHjbHEJKzViUIkjb+QMPfpH07fFNTBu2Sf57UTei4ReoUEFDmcXzlXJUPy+hXz32u/VmLp/fbGtbsWqTp5jPe4140ybMFJJ8A2j17wk5LjK2d5g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784742955; c=relaxed/relaxed;
	bh=aPgk8zreWEmRxJf155x+O3b2yKEBb6gGoGNewl4z4dc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QAuG3HMFakxuzqArQaB4nMgBf3jOaeWogX3ipf2p/l+jhBSNNwSABBgQGuIIEL7aN6huZ7gk3P8E/rDsOWNSZT9LVNcx0z3/WT7qYCq2gEMCSTAmleqEQlv6ZH3ZMadx7EY5qZ7x1O3j4awFCPeEy2vLNC8bLg+sk1aQQ3CkuurlI0P44VUyF02yGk3j5W7pgWcOC5254aKgG8icd7stmAfjrZ6cco1e5koyfabbra679gB+EvoaO8pbqTrnj+tslfbgxQfa7iLUudi8sfARDY39POWRBJge9qZPkUoGDh/6Iqjw+s94tT7LQOGGfSCJYWkqMhOHYIqRElLqZF+Gxw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DwTXRtFQ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DwTXRtFQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h523q2TGqz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 03:55:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784742952; x=1816278952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uUTz3fiM5jX0AfNvDIrSrhAYo1pyLNR3KjZwGxngOnU=;
  b=DwTXRtFQxSpxbnm026Xy/EkFnFbeZNsQrZ8233AzFnXuO42PM8LCF4js
   gNHDR3pmjj0kTqYucIhQKEz962r0z93Y9vWZ430lRU9vlaewSD/v8wKR3
   kblJ8jbw2XRIdP++GgkyB67v7MP9QkFkDsLAJqZ8XumqwQMrA/qGER/TI
   wTLzc7XP9j4ullrWr/L04wMU6Lgqh4iiMQaX9hsff1KwygN5r2cksyxp4
   nVl/llqZM+ekDyE7o6woCPD+3WTWbWo3WkfGKP1vUivS2J4UVs0WXIGqn
   QJMifSgvc9+24mo1t737URs6GVe+v5hrPzGOaibHyLNgiQ/GdAsrFboAv
   Q==;
X-CSE-ConnectionGUID: Yss3IKqvSK6Dv7SGw1bIaw==
X-CSE-MsgGUID: /gXx6m/zT2awEZzbtiRjwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96525565"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="96525565"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 10:55:43 -0700
X-CSE-ConnectionGUID: Mcqjx038Q1CpzsErJlQHPw==
X-CSE-MsgGUID: f9ssUWOMQ8SWPNsD+s9Ftw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="254772799"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 10:55:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:55:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 10:55:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHPbJ+QGgZPIBqJ6YiLrtiH3RmiUpu51jJCUUqknYcTw7++qeyeIp0pprXygsfEz4nueVF+8sgdVkVi5oNGZK6Ru/YBItcnNqgLQmzUvZmnmqsMVIHLe7KHWVgqJZT+aO8P+MZr9hnmPlzasYZuhwaSOZAeS1hTcE/J2b93Pb5Zq3vMbDolDBagGQj1QNJmQqIX1/4R9WTwPZS+DX5ZALToJlh61+M+aus3lEDVcTlRy6fzdwVljI6sR85pTpQ6NhfQs4fxJW7IpRoUiCvioH2EICCcWO8Sle35Uu0Ckj8N3v15KBXj2Rgt8ig6XjVMdPMKY27PehyFKJhf0+erYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPgk8zreWEmRxJf155x+O3b2yKEBb6gGoGNewl4z4dc=;
 b=vCAtwS6J7XAxzqC0TzF3/yZ6b6geOrOMe4MPbDrIN4NfRxc+801Sv3qCGlYz/5s0G+YjWsMYl6f5KdCGjrVN6ZoRFY1X7jhSpu1DkQ5/6xYHhqGd8l8oAuFzHBuNwhRucQ1mah1ndvWCsrEKkaaeFEbOm9e531gkHXU97iqpUY19FezzmY5X/KOZTEhyCKL9Rd+R2j3DSHOfjEPDxyBCfJdSJ3eAlM/FQwVmPltalyLdFwrqduK32mALvOAoKOEhsRv8jU+f8SbDAtn41GMetD19BGhPKwO+2QA9pfCTgjtCVUTl3DDGK+iQ8DhJxyQLzL/lQ9seIq3v/yT0fdrpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 17:55:37 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:55:37 +0000
Message-ID: <0f625961-8e2d-4ed9-ab5a-fd95bcb4c87a@intel.com>
Date: Wed, 22 Jul 2026 19:55:26 +0200
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
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <093867d47c079d2aaab06bccaae734c54c342a7d.1784528081.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0172.eurprd09.prod.outlook.com
 (2603:10a6:800:120::26) To SA1PR11MB6967.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb36f3c-a120-4e42-0bc9-08dee81a6f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|4143699003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 1AwikF2assXGfQCTWIJ6Ivp/eSdxLLIjCiAsU2YVFH8JWvPepC344Ejl+ZK64Vg034TELUw0TFmTfbmajhSCOskupQHLyjmsYk0qA6VHfGQF8nQE9RdC5mxZdXL6+jNFEaIcSX8c6NRssG3W7KcP5DbD/PZxEEyE7DMQbgqLWrJM7caTS45c1saiCYfAzm02c0yztyk6vCepgQDFPYX5MZxefcHRJ5DbJpCMlou7+YiQPylYcWcpuUmCMM7D0+2C94nh05BjLtXbSpW3qffLTMrq/xOBObLxcQDgBnADaveg8gDY7pTUPFnp92COPN/a93kI6YpXfY3xTe7dlW21D+0nsrMk8XB2pRE9TDj+45g3guWXVXKvFsz0pr4VGNMao2lLbAB7lHNpfG/ARaGlDaK7Sio2HCGRqNeaHUGhvjcvH7chU/6Zyk4d9zbZzVD1jo1WKJVR2cDj2GIpdQNgmI8BGbDmHiD8LzqbdRtLux0izlLds+5AO+1xQc0rO+iw9FvmCCVyQSH0lQbQUaKYVjQW2pHEJ6hHiXzGB8uubua6igRxTpjySWu5QBfEXy5pmoQARdkJgJ7SV16+QrKNZaWWfAbybEINaRX7Ofk4v028yRGMorPE1THpSSp5Y6fPjVz3rNsYtk0VjD69QZFOVgtwbj+1Pwbg3E/JVdAgAzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xQQWpwRWwyMnFYUHZRemhWR2djY052TmgwNEdzaVoyU3o5Rkh2OFhxQ0J0?=
 =?utf-8?B?aTdzR1oyUTMxV0tOR0xVM0lHTWl3ZEs1ZkcxT0ZaMUtpMHRFclFCYnUxeCtQ?=
 =?utf-8?B?aXNKeXdOK09sYXZEbUtMNWR0M3kvT0N2N1ZpNFphQU1ROVBUT1JoeXlUY3py?=
 =?utf-8?B?Rk56Q2xoSGlBTFltRzRVUGNuQlA0OEpRbVJWVFZzalBYZTBTT05hcS9ZUGh3?=
 =?utf-8?B?Ym1kdGVpTndBNlRhWE1RRUZaUTJ5SHBIRngxUmpSRUpTVjA4UkhXeC9xNTls?=
 =?utf-8?B?OFJmck1VYWdxY2kramRJelZiZm02ZU9GV0JUOU5rRFBUWEt2S3FwOGhZbHly?=
 =?utf-8?B?UCtMZEpzaXQ1NktXRFZmQW9NQ0VqVEFoenFHZFM3N1dGUTMwc0gxM0xHSzZU?=
 =?utf-8?B?c01FTkVaN2tUN0NPMXlQNFpnaEEwTU5PMXlJdWxhN2YwS0pKR1RSTTNHQ3kw?=
 =?utf-8?B?NS9lNnBDSlF0TkZMWXBwSWo2MWZGQUQ0WmRwUE0vL1Frb1M5R3ZySk5CMURV?=
 =?utf-8?B?MThPYmx4RmNTNHlpTFdaU2tGNk8yQzRGRklyYk80RDNsUFg5RzJzTXhteGlY?=
 =?utf-8?B?RXlpQzhsOTZXYnd1REIvb3lsMDhLTUpheUVtWmcyaXk1Ymo3U1pwTytjYWhC?=
 =?utf-8?B?enhhTmp1MERXQ01jcjgyeklVOFVxWDZTenFqbkRtN3AvTGp3dTFIcDBMNC9G?=
 =?utf-8?B?Uy9OQTJuZUswM1ZPVVZpZDIzVTc4cTk5VDBhN0VYT0tJbi9ma2h6bFRaZ01n?=
 =?utf-8?B?eTV1MWJWVE1rWFJpVHZoVEtSckRnTGwzdkwrZ3RSZ2syYy9TSWw4V1BMZ1Q3?=
 =?utf-8?B?NWRvSytvcWp0cFpzaUgvdkZFa0pZVXlKZk1jbEhRek8rVnAwWFZwRnRtLzRR?=
 =?utf-8?B?c0VDTTRJM0Z1UHZ4aFR0bW1nMkRoV2VHOTB3TlVDWkI0Z2Zud1k1eUVLdURL?=
 =?utf-8?B?SnlrZHZkRGlWbXRVRGtOdm9aNGVIK1J5NnlPK3Z6bSt4Vk1JT0g2dWh1Qi8y?=
 =?utf-8?B?T29YT0lubDdqb1F0MWYrRVM0VDQ4aHkxQ3g5SDVzQVBYa2g0VzVkS1IzS0VP?=
 =?utf-8?B?WloxalVkNUQxeUlzeCtFUWNYaktPNDEzK0c5YzJGYk9LRUo3TmxkYkZ4V3ZW?=
 =?utf-8?B?UkR4RGgzektlVUJGV011dURrN216Y2xxZmRDajE1TTZjV20xM2dybVN6NUk5?=
 =?utf-8?B?Z0FKWmF2Q3E3VWtMVjd3a3F1RTVmZ2lZL1lkTFlHY20wKzNSVHorR0owMC9L?=
 =?utf-8?B?SmFsM0hyTWJNOGR6LzJZbVNqdUpJdHBJdU1Hd3pGcXJJS2Q0bGh1Y2VNZnhL?=
 =?utf-8?B?SXVXeDdtYjdUTXBrUWowdmR1b1hEL2RUUzFJTUhqTWNwU1pQTG9SeUM0UE9K?=
 =?utf-8?B?ajkyajlra2JrTENCVzhTZjFyb0pHOWJwaERaNDBJdFZsUWh2Y2kvalVRcnk3?=
 =?utf-8?B?ZUJ5WUNmYUlUdkdEZWxHUjV4MVM0UEJyM0sreFVFRUR0Zk9VbUFGN3YveHNV?=
 =?utf-8?B?OTFtVk84NGRsY0FTUVh0MjNYN1VLNmNiWU5EWjlpNWQxOEFFajZkc0FHUlU3?=
 =?utf-8?B?QVF2MTV2d2p0blc3eGpCTERvTlA2dWp2azd2UDZpM0RqblFFdHlFOXBJWGlV?=
 =?utf-8?B?blNvQTFEclc5UGlUWElyaDY1T2ZZMmZLWHBTRzhESDlHRENlaGZPN3N5d2p6?=
 =?utf-8?B?VW9NenpZaWtoS2NWM2FrRWxvZ1JLL3F1cXR0NmNwSnBFVGRwVEFNa0JndXJw?=
 =?utf-8?B?MEdCOTFHOU54eDdyQ3lDZENKWTVmNXdjbVFxYno1cGxoUGNuenNBamg1MERI?=
 =?utf-8?B?MFc4UmlUSEVxc3lNelRGNzh0RXNiM3owMmlid3lCSWRvOEluVFQzRUY3NHlz?=
 =?utf-8?B?aVZ1Ty9YT1hraWJLSnlsZmRsdW1LOHd1R0JOWURyYjZBSWViclZSb2dEcFQ1?=
 =?utf-8?B?UlZlMk11SGtmcHBFTGl1R0FZeXhDbStDbkYyTkN3WVhwN2ZjeXI5dDJGRTV3?=
 =?utf-8?B?YkJsYldRRDl6b01hU1dVS1M2TXFhTUY4QUxGVWpPekdyalRkWHNJNHVheW1j?=
 =?utf-8?B?VzYxbHVtcC9WNXYwdmFtVmJ1V2c4MFEvbmQrcVUvL2tjaHVoSFdSNTcyZ2VX?=
 =?utf-8?B?bzNQMEVmSytrS2xHWlNUdU9pU04vL2RpdmdFNU1BVURGNkNneEZNQlpFeHJ1?=
 =?utf-8?B?RUozMHNxWHZCZ3BNMGpMN2YxRHYxVmpLeHFTejZ1NnZ6elZWUnNsOVk3UU5D?=
 =?utf-8?B?dWlkcS8xMVYwdkVGYUhkdDk1TUVIZTFnVXlzT0diNUdYbkF0VE5sUHdFWUhu?=
 =?utf-8?B?dGpKOEx6NTZPbjhkQ1dKU205a0w5SldWWTNweFppNHFKb0xMWWwxclRsRWFx?=
 =?utf-8?Q?Khl1ZRFbPPUZ+KCc=3D?=
X-Exchange-RoutingPolicyChecked: IvIALKb+7eelKapkNWVZIA+V2JRCTbJUe8CIzaPlxmnPeAy6JM/LcGjEe+YTGFwFIDBQ91k7U2voUgZhE824aP9rzWmvP1Z5Ljzta2b0MMoOrkUynDs/opbiFDGb3ctbABpJokad8z6KdsOi/G52Juzc2gNoXIQn2jEVz79qLEvlzbE5AEn5VkYda9uCJkDyzy/EnC8S0QPn6rem5KWdOLBvd2vfQqP7RfXkf7UAQw7tKiK5Y/8tXXuxg5vXEJe1mmLr83TmWe8Nae+0yxjHp0A2pQgaczPTmyZ47F3ai9oajg1XPCdyDjySX35TO+GP3WPvH23nvy3vk0hF2dBbgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb36f3c-a120-4e42-0bc9-08dee81a6f53
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:55:37.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqMyaspXr5WqFE/Vg5jVtp2/CUJkFXEHQCDRqtx8EkX0I4DfQ7Ff+ZcMk262osWnRGJjIsQ3xpGOJGYGvEWvfF3X4glqOAkvv1pvSk6G5CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com

On 7/20/2026 8:23 AM, Uwe Kleine-König (The Capable Hub) wrote:

>   sound/soc/au1x/db1200.c                |  2 +-
>   sound/soc/codecs/adau7118-hw.c         |  2 +-
>   sound/soc/codecs/bt-sco.c              | 10 +++-------
>   sound/soc/codecs/wcd934x.c             |  6 ++----
>   sound/soc/fsl/imx-pcm-rpmsg.c          |  6 +++---
>   sound/soc/intel/avs/boards/da7219.c    |  6 ++----
>   sound/soc/intel/avs/boards/dmic.c      |  6 ++----
>   sound/soc/intel/avs/boards/es8336.c    |  6 ++----
>   sound/soc/intel/avs/boards/hdaudio.c   |  6 ++----
>   sound/soc/intel/avs/boards/i2s_test.c  |  6 ++----
>   sound/soc/intel/avs/boards/max98357a.c |  6 ++----
>   sound/soc/intel/avs/boards/max98373.c  |  6 ++----
>   sound/soc/intel/avs/boards/max98927.c  |  6 ++----
>   sound/soc/intel/avs/boards/nau8825.c   |  6 ++----
>   sound/soc/intel/avs/boards/pcm3168a.c  |  6 ++----
>   sound/soc/intel/avs/boards/probe.c     |  2 +-
>   sound/soc/intel/avs/boards/rt274.c     |  2 +-
>   sound/soc/intel/avs/boards/rt286.c     |  2 +-
>   sound/soc/intel/avs/boards/rt298.c     |  2 +-
>   sound/soc/intel/avs/boards/rt5514.c    |  2 +-
>   sound/soc/intel/avs/boards/rt5640.c    |  2 +-
>   sound/soc/intel/avs/boards/rt5663.c    |  2 +-
>   sound/soc/intel/avs/boards/rt5682.c    |  2 +-
>   sound/soc/intel/avs/boards/ssm4567.c   |  2 +-
>   sound/soc/samsung/i2s.c                |  2 +-

This change is outstanding when compared to patches 1-4 which follow the 
  per-driver approach.  I'd expect one driver per scope e.g.: Intel's 
avs split away from the rest.

Nitpick: s/ASOC/ASoC/

If it comes to v3, I'd appreciate having a separate patch for the 
avs-driver components with the following title applied:

ASoC: Intel: avs:

