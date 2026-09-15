Return-Path: <linuxppc-dev+bounces-27316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4787C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:29:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkdYp0Z7nz2y8m;
	Tue, 15 Sep 2026 20:29:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789468190;
	cv=fail; b=fw389qYBQoc3+tRbTDSqx7WARN72/BRSHAEGWROBoqH2oV2bO6jjx5JuS57iE1eTYeE52Yt0H0i24tXuF3hgNV0WB9aYyAdnk5AKCFXpywYAShKSBwaI/24RhCbR83ko+dUCnZUpCywOQo1NKpbajE0LF9UVSzl4Q2xlQhXnjOb5FP6fw2xlbESxtHxuQSfUqiJe0XT//AlROUyl+BmUP6WLFp9zbJdDezS/OJqsb2+m3YX+Wmrs5nnjEB57yk9X0Ikkqcf004GGkYHKKbIzopKhj+7NsONAPuJqq6sFovKnRe8U9j+DitUYI0tx1vI9mW2eDtvV4i614DrLwaaDXA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789468190; c=relaxed/relaxed;
	bh=BqgxGmkY6sOT5TesV6DcFgEKTt30y3rJmUWvzgQRqYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PwQmd0Q8QoBxtoJIO+lRKTFur7QmxhQ3Wz3xIuQiquJg4e+dsrtk6U6gCXGuOu4V5kePDRmlt5BcoljUoPABUYqhxmoUJ8aKRvF0lQ3NC/BHE7Zw8WiNv/gI+a0pnYeUtHJMGH1aY4ZEPEDRZ8UeU4NPDP8fz0GYfm9QCACGk3ec1DkBTxqkimTEVhw5pkesk//DTYAysiamLOaNpNL0ZZATwCEAERDU+f4ShcLM1e7HKcjG8xGELliZbH1B1bLk5erZ+Z95oPVVU7SLr5ibPSnOYuYR3nIueYTX5MS26HMypAFo3cRJaInXc043QZbL/PWwztg8jzILUlCv9kRsuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KmVcyKSk; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KmVcyKSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkdYk5QFSz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:29:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789468187; x=1821004187;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=64nZ1+HlIXeFFkMbbW+5irJ6FsYRzH6cOZWgwH/aLxc=;
  b=KmVcyKSkgC/fht/wgQfQHwyadiWtbTXbricqbn0ptsJhpCm2+Gb3sxAB
   efC+eNN6aAaKbCZIsh4nSIhhSfaBcG8xgplKjAfOIdjzZmwm7eXr0JfE4
   /1BuTCJUexRaCyUQvz/8CwbxJ1KX19IwFx6zvH1GBj1SFsqwNTtNJQ9BX
   6gLVJl9opnCTOcz4pNirPNHU6y24B8xxe9iBolRUFmKECVZu7SIYF0EiH
   JkpVgt7xBxd3DfjgB9l08jLjIAwqXRYFluR3b50Egwnn6AOHzd1w9d+FK
   4i5CG+aqdcH9JTPdmhc5UmXuVxtjH5Zdxh35maAItuqXwcGzlN1szcNXu
   Q==;
X-CSE-ConnectionGUID: AVEFzx5jR0uq/lHUiz77nQ==
X-CSE-MsgGUID: kDFbpxFARhilIbmlhJQpBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100981565"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100981565"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:29:41 -0700
X-CSE-ConnectionGUID: Pjy/bVjkTm2LcY6d/OtRbg==
X-CSE-MsgGUID: nLS3XDCSRqaTQ2l9JBVLIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272938851"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:29:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:29:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 03:29:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Guvq9no+un3fuCfZmfgzuPR6KXqkEZNTgWOpY34Okbg69dQyiihwBAv4motoRD1vDsDtgZ4MNeciZCjHKNgxhCVafBrHvIFqu65It7/o4uUZfvr9ckOzxtoGhW05jcnHsLXb7sGanX7YMVgE8HG3U/AOUf1jDtIE/MJVEMOxxNnArw0a+2jTV6k619L5/yIR9Kh20+nMXfvtmXmmOWFDGWhmPQS7POwBIlmMOR7cwKthdFjiI7QuNL6UDDZFP5XCB0gJU247Wl4LUr86dw7yNGdhAJ6oSyNdoK3jmhOTKFB5h/Y2TZQyktvmFxmiaHDQZgeI4oVoFSjQ6Tau43AZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqgxGmkY6sOT5TesV6DcFgEKTt30y3rJmUWvzgQRqYw=;
 b=rBvU+KB4WMNOwtffHpGXMaUfdqO11cj3lo/EW80rfpPHvhVGKDYUt1RadX6QUjccBVPGBqDJzZeTNTrQnob+aR+v/QCpmCpTb9SDKFajX8QSwK+NxTHFsX0bknVfREvjSkd+joNdSD/60n9I7uls2zo66bmYJXhueLcuVGURMq5osM41u49g49Y9HPby3v/EV5ZjbDFVpYA6fS4Mo2WS0Rd3/sz4dbNs0xNcE31UyeMo3zY28MNlfnG1VTv6P1ytaGy4wVCo6MzqTTArvSIxNXAebuODq7MYa3UaKphb0ccqJz7p6t7ES+X6kbANWb6aGuwf8ab4OfcBTkX9/eTmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by CH3PR11MB080898.namprd11.prod.outlook.com (2603:10b6:610:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 10:29:37 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 10:29:37 +0000
Message-ID: <91b1902c-0cb4-4775-9f82-25bceff8301a@intel.com>
Date: Tue, 15 Sep 2026 12:29:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] ASoC: soc-generic-dmaengine-pcm: Replace
 dma_request_slave_channel() by dma_request_chan()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Dave Penkler <dpenkler@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<Frank.Li@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
	<Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen
	<nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack
	<daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "Robert
 Jarzmik" <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>,
	"Orson Zhai" <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>, Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, "bui
 duc phuc" <phucduc.bui@gmail.com>, Tianchu Chen <flynnnchen@tencent.com>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260915100931.3593242-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::14) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
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
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|CH3PR11MB080898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8972ac-3e51-487f-25cb-08df13143dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info: 3pxF0NNZJQE6CrJkTMiHj4QRQM1rJiWrqCL6UU+xcglctZAcHXf3H8HQ/b4lwOU4GS0IOQCxPOh9HD7hH309P6WF7aYjdd0X6kPT75wU96Rd2VrZ4nobgYvO0XC+qZSp+1DSBpJ7duMQIETjV0qHz0sPhy+xPmscfzHAmPJScqQcpJPCN6cy4T2Za5AHs0F2ZsRUDq6E2A5GKKOTuWxvD/7pk8HQf0WnUhjDZa8ffUBG/ag9gC4f9ysH/idxdNYg4YngU8kVax62K+eUCfWvQA6+uVfpioseD5qL2aIWNsmQFM6mGwte4rGmy1UlrwKXxOTJZQKx73z2QWN64Z9XJnvyYsBlhTxyIbsgS5Ak9CANOPu4RNQRBwH31vxEHaNoO80EDZ6RbBlb/FOm9SvUYO+kQ8jXLa7pbAcwj4eZUwDn/DJO7Q8QpNLVflCCHte2wViXCdlnXOgyJWxxrbTng8st/yxkGiYtGnXxmtJUej2GC/bre6Bvjq2nAw4cgrJQFvRtS5g01qtgRxi5vq66Wy8UArAhW5Jt7c+GKvvyn1BFRhyvIBILUrjNXYUah137KK/Br7NUu/o1LhWtJlHaZSfYP2icSq2uRi87M4sCgYedymEYwzwM2YaLA/lQtWKXXmSogV5hYSVZ2SuvugbBzYv9UNZhRen/dCG+aY6KuWSV1JRNJO2EnKaxUahsgM+/b6Tp2j6ykaqBI0XDB2lQ9k7soD1Yt6srUqMc8CKfkbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllJT0dQc3ZqbGsxSDlwQnB2dXk0OVJnRjI5R3FFbDVBcVJ0QlIzWVhLVm5W?=
 =?utf-8?B?WVVMYlZEY0orMEtLVjhVencvZmI4WmNiR1k4UmgzWjRUVU0yYTVLNXJWOW5q?=
 =?utf-8?B?WTVIRndmbmJ5am1KNDNiWWdSNWpXbmxLRWUrVlp3ZFJOd3JGdkhFNHNrTnlG?=
 =?utf-8?B?cFBNMEVhaE1uSVJHQUFRYko1MFNoSXI1QkNzWFpUeVdVZS9XZzlFQ2ROam9B?=
 =?utf-8?B?VzllT2FhREFVbWk1ZUtVeTJNL3c0ZWNxbUhaM1E0NUxBZUNLRTI2KzA2T1V6?=
 =?utf-8?B?UnZiUkVlT2NZWXpCY01LdkhoUWQ2MHcrYng0L2RFQkxlYXdxOUtWYVlSWk5G?=
 =?utf-8?B?ZEhPOTQ1RWV1Y3BEazV1ajMvdjhadjFpQUs0dU4rT2drcm03TEZXZHl4Yk9h?=
 =?utf-8?B?TGhqWTdZbFQ3Y1BHNUtDVWU5Y0FUWGJNcGpBTW1ENFVoUjlBZ04xNDkvaXhq?=
 =?utf-8?B?ay9EeDhWSDAyS0hKQnR5RldkYUl2b2xmSHM4czl4bWk2dVdhWGhLcVN3RmZv?=
 =?utf-8?B?ZE9aRTFqM2NCQ01oaFVRVXNLY1FYaVdTeEhkWjQ1OTJVcVhrd1JGKzZQdjJx?=
 =?utf-8?B?VVExbVVPbTRVRnZCcnhRdnllMVhpa3hIZVovU2pING03WUZWclY4djNnZzRT?=
 =?utf-8?B?Z2x6ZHdFejA3eHJHTEVKdDBxNEdHNzYwSmlvNFpnNld4a0N4cDd0bHZodUlS?=
 =?utf-8?B?bHFIK2hRK0hEdkhWcU0zQTJvM2V2WEViTE1FMFZMSTdkVXVwM1FLWkhhTjVJ?=
 =?utf-8?B?UjJ2dWVaeHZsNzcrR3Nicy9RZzZKeU9MLzlHOWVSdjdrWkZxMXRQaUlGR2ZX?=
 =?utf-8?B?eXYzVGlnMEQrcG5pbnNMUHJTb1ArSko1U1M5bzAvWUZaUFVYQnRKUCt5WHZP?=
 =?utf-8?B?Zk9nbzZXcHY3TXI0N0p6bmxqZWp0V3RwK2VhVVBOTGdvZVVSNG5RbjF1TE5V?=
 =?utf-8?B?VURreEVDc0kyOGdyVXZkMFRjRmc2RmVOall1NnZOd3c0ZWVDd0xpclk3elBw?=
 =?utf-8?B?ZU9BMkxRZ3B1a0VhVDg1d0VuQmtaRkE5RUkwY3NCS1RxQWphcVFZOXpIUHZU?=
 =?utf-8?B?bjdaekJxajExVGJPVVphSVIzK1NGelowSGl4THJBKzVDcnE1eUNzd0tiWk5Q?=
 =?utf-8?B?cEtXSXU3SlpzMllrdUhWUmV2eG5LUUlXMjFLZ012R1R6dTlKR2JHVXoyaVcy?=
 =?utf-8?B?OVUrQUNEUElCUFY1Q3VFQmdzaFNkWHZyRHpvUEp5dEp2Y0haaldWNGhFcjh6?=
 =?utf-8?B?blhkc3l2akVrbHBIalFQUWMydElicTdjcEpCZ0VqaERHOEFMTkY0by9hN1Jz?=
 =?utf-8?B?cFlUd252bWJsY21iL1BCTFZybG82Zm1jaFMvU1hYUG4rNjZqMzZQTVRRSm5F?=
 =?utf-8?B?dDJONVhmOXZsYU1JTnVpU1N5TEVSMjFla2FOVUZJTWNPTVRJUTlhMWV0V1Bu?=
 =?utf-8?B?ZW5xSDZYMFZDN1BIUWxUVHFBN3V1c3h0aU9tNTVJdmhlYjRpTy9jRkZTNVZ2?=
 =?utf-8?B?R0N2ZUFJemp5RHR1N04xWmdqNzZPL3FFN1puZS9ESVd1T0VEWmFDVEZmYTlo?=
 =?utf-8?B?U0djVXlJWXc2UU0rUmlETVR2K2tHRTNJUjkrdFRMZzZzbWw1SzNkU3BZWFBI?=
 =?utf-8?B?TmlZTEVlL2JObTV5OXZmbEJlTzhqRVpkREdLRnB6TUxpWUUyRi9GQVM3eXBs?=
 =?utf-8?B?WlRkQ0JuQnNubmJQemtPd05QVUg3NjloazI3RnRtWkxhUnhCc2h1L3pMNzhS?=
 =?utf-8?B?enIyVVFMbzI0NzRrb0hsdUt6a0diZHV2S281UDlGV3R1UGNKbVhpMUV6ZGJu?=
 =?utf-8?B?SjFDcmt4L3dsWjRnVDRuR1VDM0NTQnpoMFplVit1Y0gwcGN3a0RaTjRTbm5J?=
 =?utf-8?B?VVh2cnFNN1FieSs1R3ZaTm1MT0R4cEFGTXRWZE80dWR0QzBFb1J6c3RadFRy?=
 =?utf-8?B?d1NiSW5tRTZlQk9rUVVMU2xwOWlHOWE1WWVrNmY3cGhKTUJ1WDNYa1N1bjRk?=
 =?utf-8?B?VFF2NTh2a1ZlNCs0QUtDRUpoa0NvSE8rYXIzWXZqRU81Z2lKcGN3SUZMTUxR?=
 =?utf-8?B?VDk3TmgxYWluUXJieUNqNXNIU2wvcDZoamhzTUdrd1phMDFjM2haWHowZkho?=
 =?utf-8?B?ems0b1dHb0hwQkZBZlNHUzR1NEFPYWFBWEZ3QmpSQllyT0JuVnFLamE2d1Vo?=
 =?utf-8?B?OG0rd25Zc0NXZ1daL2dsTTZhN3ArQzZLVXFoNlhwYWRRQ2MvQlpRbGdPK1FS?=
 =?utf-8?B?VHRBcUhtd2JpM2Z4OXo1QjFzcUwvMlRTb2U2b2ZLSytqV2U4TE1Bek9hcnRG?=
 =?utf-8?B?SHF0MkZLTGtHWXQ2OC9CamF0NEJMZXZXT0NwQ0Y3REpKNkdOY2lKbnl2Y2Y4?=
 =?utf-8?Q?NuLsCOFTmr/hmQAs=3D?=
X-Exchange-RoutingPolicyChecked: Mb0Dnj1OZkOk1zhyTzZ+SJsNugkH88lBWI4d7kM0lM9khahPEMi2jzCeT2zSz536nvidOjLb96CC5Uo437ZXSxwIOuEVZXuzz1fFFyIBxFELt0/QzopH1s7ONSOy9Jkn8l74oNih2jOeaYWecj69dOTw2Kap9Vqbuq6PFMgWvcoZSTwqHP60JawfesdbIm5ztGoVJD1hiMDXW2OI61eLmkb+KGpPdnDxFhxv3jYvexSwWXRlLCjueRzFCduiQTI+jGffvgAre+tr0+N2nrtgspD0BRdI97RVtpznGzIEVB3MzVQhRfojkTsh4EkjvRwrqpzDcRP1QOl8MmRTis7JCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8972ac-3e51-487f-25cb-08df13143dd4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 10:29:36.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPJg5ncelvAhC+8JPbUDhGjCACYGijPclgJlD9PDDx5lPX9YnUbzGbm4DsRmMYDrAbmxO4RzIcsHrbKRXTyQ3aTDeCrlrdAbROSGnRUMgHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB080898
X-OriginatorOrg: intel.com

On 9/15/2026 12:04 PM, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 65b7ec52a054..6d1dbee8f6c1 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -242,9 +242,11 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
>  		if (!substream)
>  			continue;
>  
> -		if (!pcm->chan[i] && config->chan_names[i])
> -			pcm->chan[i] = dma_request_slave_channel(dev,
> -				config->chan_names[i]);
> +		if (!pcm->chan[i] && config->chan_names[i]) {
> +			pcm->chan[i] = dma_request_chan(dev, config->chan_names[i]);
> +			if (IS_ERR(pcm->chan[i]))
> +				pcm->chan[i] = NULL;
> +		}
>  
>  		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
>  			pcm->chan[i] = dmaengine_pcm_compat_request_channel(

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

