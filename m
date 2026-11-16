Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CA606A887
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iLTfGg1v;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=e+jTddLi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSv966P6hz2xdR;
	Tue, 17 Nov 2026 03:54:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=192.198.163.13 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794838030;
	cv=pass; b=b9MQpdhvxQrGNtTT0DTbtvtkBG4+I9gSWEcgAgJFZ04JJPxvp0+WePqalsMXmZQMVoQ5Yj3wbbCPRnNshLQktz5mnoIXEqmACvcyFfFAsdoJFmlmeKVReEPQaxT3YWKTLHkEdVCaDXydhKRsnk5AGETUV37PFnLLxZLCd/Ch7EPF8vJmO2Llw5JaI53G5Yn3RdfyUzgN7UGGaTOI3FckuLlHdLebLAy1m6g16H+9FcLsgWi6S4QVQLZD0iZZE9G1cqrk62/QUgFwq638PvsMzquHhgi2Kj7uHM1FZu5PAisXc8JieVd7s3PTx+R3/csJWlQeJLQ7U23dl1YG4mgVnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794838030; c=relaxed/relaxed;
	bh=nRtfF/b5nLyv6XGdJa9wRhF3bJA8ZrwPfG2Mbt8H7Ms=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzU/Tj1+BV2RAj4yxCOIMOfJpCg8BqYce8BOuHry99tAGjNrS4tor1GHqu7pKxrfGvJM/KGgIn1AMwZsgWTGUhgWq5myN90VX+e/EEuQe0ZJHP63zizE6xLkaEuu4G3umtVe55DG80bLnYesYDj3b4S2k5Rw9Dnudp8T0fWDVC2fJT7JtSybJxJUv5f0Sxw/7u3GCnkHufmniNmq2aVk0wdcZcZt1lWA1tLAPZe5dZ54IZE3aTG3s1adEjRzTvltPE9OdI9y/f6GNoQSL/gFfpOMGEsmijpZErClENLL8dOgBA49NNQlcRWhFEOuIMiDLMCCTZBuE+HxAZEA//m93A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iLTfGg1v; dkim=pass (1024-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=e+jTddLi; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=riana.tauro@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iLTfGg1v;
	dkim=pass (1024-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=e+jTddLi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=riana.tauro@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSqRv5NPJz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 01:07:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794838029; x=1826374029;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cWA/hqTfhft3ZSgPwPwZ4cM7D8H3s81i6U3LeR1TOzg=;
  b=iLTfGg1v8jKLdI/Yc+IiOagBw9+LadVylgbU/D6/Y2m396RG2zEuMBbF
   LJKqeMHo2EBwUhIcag4/i97cZfsDIxpMCNbHo4MDUhCgkBML1NqrxHOIP
   G8p+LPZEaHvKcGm/qi0Nwjm3KNGNWLTz6ZLaTQqLvruvWmKP28tprvlOL
   WIbkGZvYQw1/4jIKjXwiEHR3jsvQcHfKnT8otetEO3Nh7EXSTyTmnJPdQ
   b0MvoXwWzwRpf2wBAroOu5HwYCwZUaYlGtOuZhDFi0hYs6NERHIMrryen
   ncYNLve76Aj/1/gAcEFSc5ppIYmPnTdRebnvimq7t+KoqxlcwcJhOsuUv
   Q==;
X-CSE-ConnectionGUID: EfIHa3y0T4SbSKAQHZWe+g==
X-CSE-MsgGUID: X3slLNjKSLKynXjH814olw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3565492"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3565492"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:07:04 -0800
X-CSE-ConnectionGUID: FIBUTk92SBCosVHO8oERAg==
X-CSE-MsgGUID: NWargxENSw+01O7A28hNKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9962500"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:06:43 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 06:06:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 06:06:42 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 06:06:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsIljGri7MSHoP9muuP+KE39fjyMd3ImUo8dJ3ZQa383DrOIJ9eWgM1dUiJMhe9FxbGACtQsXxFO4be8wVilo5LD1hJzVpRF/E06HHSpTxUMTOpe5t6wmDNSzCZ3gcUzI0UHx4c8jfzNaAIRzwyfPQ+CHVete2ARJ+Yo5p4ncoq+oA67oyhQoZ9pj0qloAM2+EfHRm3QymGXuYMUCobW4e7anDpy/zJ9j0aIrc4oS5Ma2rtg5GD7KeDoHmCzE47h7fnNEZoFiJ8avVJPYfsXeUXbXOQCnhs4gJrw0FUiHfmV6KM12+L0P9n57MtlRmyka4jwEClX9dNgmH8IXQVKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRtfF/b5nLyv6XGdJa9wRhF3bJA8ZrwPfG2Mbt8H7Ms=;
 b=gEh+mRf5flPgNqq9iRXjAnWVhTpnf7BqpZCxxImLXcTMq7d1L4leQ7EN2vEbL/ptcmjgden1u+4TgqhUaAanszrVXt+R4BzMBbdBOhHC1rcUDYeOknJN4N/AkEfQjfXGKVS6fYIsztDzVm8r85JQ7vXISF9wvj8d8oANNJNVSRNe3a5fB5mZenztwY56dwLsx5dA4BzjaCBZET3dNz/PglOrevl5NoB01DuozBST0k742SCSTxglrHukBs0XhxMSPFc6Y5fqLMaBhXyIQ5Ep/IuERoQJHgiDRCIQExG74CWzN76S8CSie0htkt5Flq3IwD0fWPH52COpJkuFccO30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRtfF/b5nLyv6XGdJa9wRhF3bJA8ZrwPfG2Mbt8H7Ms=;
 b=e+jTddLiFlq5nEVM6OtWyL/pj6NdUIzg1853chidaF0kiIzw+kLSZRM0S4kxUx2F/9SdPfFUSi/m6t2LGSs0XJE/wNeCyGDnjR+Rb7RhG8CkXsdcC7Un9p2sqXEVQZ0S5i1WnU4QeE2t3okKZ9aQZWhXgJmtXjPXTPwWuR1PcZI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.13; Mon, 16 Nov 2026 14:06:31 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:06:31 +0000
Message-ID: <f6f6c126-cfbe-4e67-8002-c11cf6f84189@intel.com>
Date: Mon, 16 Nov 2026 19:36:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
To: "Bowman, Terry" <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, "Yury
 Murashka" <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>,
	<linux-pci@vger.kernel.org>
CC: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran
	<oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>, Aravind Iddamsetty
	<aravind.iddamsetty@intel.com>, Srinivasa Adatrao
	<srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
 <2604b3c2-4c6e-453c-b7be-d7ff6be1dbb0@amd.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <2604b3c2-4c6e-453c-b7be-d7ff6be1dbb0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::18) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CO1PR11MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1037af-2c53-4958-fe8d-08df43ead09a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|5023799004|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261102130727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: vUOjBXLEM4jYKI8b5+ybseAYy1KHt6NXPuLobSwkCP/vk+nzWyXREYAvvMtnS45BJGeaRKqRkh2+Exma1xxXlhxPjP06jZxvuNPeyrGqVxKxdEvkgJeHXga8x0tznDY0BdTHzd97H028YevAPh9uj3+jtsNXyJk+a4usXUsqEQDGUUKku/fXYnTn0njg5BLXSlOa5KIMAuhobZlPJrNNjWXsFQNLTJBiGxgCja0+jowpzc3sqdF+uRsRcvBB/d7GdxeXOupIhafoB9zLBYFM/XAR7lTH/1dBzztnRjB7sZ6aDvVIpsY8nhOiO/S8qzPZFZUEUysoS6QMbndie31dMFqjE6noLMDkvriwsGTET0/IPpoyZkXtFDPUNdylXD0BS1Ecg+tizAWZ1fEpg9Y5WN/bHMUkhi6GgMpUsvc+Flc7XJ19Aewsa90HyzlQ5uOkLBelrUNVtKQg8okcY50yChqSjrKfoFwHuUtOjK9TrY1Q4rpJbNmMRMM8zm4JPXyczr8M6TIukfecsqVuF/i0/On4isM7djlDrlCSbDrFj1Aqkf6YkSSBYg+95bRuz0OdECFTHbu/S2GZZitUhuropLMo+cNjkdcao24CqzmHbUE01YORubeQc+o6YQh7xQRPIWnkwN+gJ8OE91EFQQqUgRtrZ10jYi5YiAMcs7+ZyxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZYdVpwRzRrOUhFcHUra0w3L3JxcFU3NkpZN05rT1BLSFdGUitGNmNHM1BK?=
 =?utf-8?B?MTJQZ0Y3VG9odndmT1hTYzNZRlp0ZDlrY1pENlY3a1pkMjAxSHQrcXhXVUdx?=
 =?utf-8?B?UzlCR282REcrQmZPNy9YSCswYWQ1dHNwbkw0Si9Tdmh3bU53M2ZxY2JJcjNV?=
 =?utf-8?B?bEViMDVnVUZWR0tKTEdMQUJaaTJMT0k0RTB2Y0J5RWtmdjNCd3UrNnl1ZmJL?=
 =?utf-8?B?NDkrZnZ3eGtYVUp1ajhhdmdUTDJ1cUtCS0N0SDkxUGxaeVUyQ2JQZmUvNzk0?=
 =?utf-8?B?R1dhUWN1QW9FYzNJSFJtVzNJT0p6eEhpSmJQRGNyNlgwTFNjUWxERnY4SlB6?=
 =?utf-8?B?cy9ndVB6RlhwcS9sSnFOMUJTUFBzMUQwZXhDbTY4WjlWc0tpSWlnemh0SDhX?=
 =?utf-8?B?bFlvems0dEx4ODJUdEpnT3E4djFjcDhvWVlndm9vTFM2cGtZRStyQjEvRTA4?=
 =?utf-8?B?Q2lGWng5cHJsUEFqL2JxR3BXUXR0Q3JMS3JFQ05kMnBac3J1VDZSeHdHRlQ5?=
 =?utf-8?B?ZGpxYWdrWXpoRG02bjg5K0ZkZDFlWmRCUVV6TGkxVjhGWUtMaFRoN1RiaW5T?=
 =?utf-8?B?RDNOVUlRd1VkZmtQQy9EK3h3ankxNUV2TVpyaVBQQ2dtRXNadXF5aE9pd3Bl?=
 =?utf-8?B?bHNEaXNPdVkxSUtmVElyMi9Mb1FFRUVLa1hwa1JTOEZtZlFxZXhhOE4ydGI4?=
 =?utf-8?B?T0pKYmNJTjIzdkJidk1ySnFFWGdVSTVMOFlKMWgvcjdFWjhqUnZzTjVDei93?=
 =?utf-8?B?TzBQSnRMU0VkQmxUb0p6QURDZDNNZU1ldW1hQ1EzVGVZemZIelkzQjEwZ1VI?=
 =?utf-8?B?Wmc4dWJLTVd1MTlESVlJenVsTUM0dnVkeGxSOXRQK2c5SzV2NmNWK290RVNt?=
 =?utf-8?B?QzJsTWF6Y2ZtQ3craElyMWlSdnpvcnk5SGMzVjlkVkJUWTMxRWFyV3JLZUxD?=
 =?utf-8?B?UG0wei9Eb2xuNUtlRnRNNXAwTlhSWmJXVUxENkNtVE5kMHJkNVZvYUEzMU0r?=
 =?utf-8?B?dTY0emxUNWdHZ2RzcGhSbDFDUzhERTRnTGtQdWhNaFo1ZXRFOTJtUWZrWEtw?=
 =?utf-8?B?SnlJZm1kSkVhakRsbm8xVHpHNm9oWHRQNk5lRXBBbWtlQkNYdXM1RjR5cjBr?=
 =?utf-8?B?aDdkVzVET1UrRGdSekNwZEo4NktIQnRCcnJUczIzMGpTL2xBUThMVkxzcGdm?=
 =?utf-8?B?Q2UrTTdGVU5GNG8zVzliVmN4RXpMejNBeWN2Y1BYVCtHdjNhOW5QeUcrc1F1?=
 =?utf-8?B?M2xRc2FTY3FkTFptdGR4dUE5SklXQmlENytSQ1ZhSVhaQk5KL3lwdWRMM3Rm?=
 =?utf-8?B?bEhaVXRBMTRnSHFRdUVycU5nVjBBdGt4TGY5TnpGMk9HdTN4YXpLT1VHRFdT?=
 =?utf-8?B?QktHUlg4WHNpSVg4ckJPUkM4NGZVaUltR0xzVEdRY2kyTGVtemd2R0RZbVY1?=
 =?utf-8?B?MDZxb1JKcmphQUNZR0pQSG1FT0VxemFVczM2RU1DQXFvcDZaRU8yd0d0Mjhq?=
 =?utf-8?B?UmRISDJpSWQwaWpZRU55Q0d5NTlQWi9rcnIvVXBvSFFBcjdTcWlSTjVWY3Vi?=
 =?utf-8?B?cXNYMEFtb1A0dWtNR09wMzYvS0JXWXM2czRIeU9BUHRwWEZJa3FRYnlmeHBy?=
 =?utf-8?B?azFTVjhMZnlaVjdlR1JHYzl3VzNvSWZFUk51d2o5MWk0ZzBieWxLR2hweTJG?=
 =?utf-8?B?K05EOG1qeG5wUU1aaTNOL1dvVWpuN2ZYYW1KdTA1ZTRJOWFWaWVwL24xVEFi?=
 =?utf-8?B?RmEwSUlMdjl3T2NqcGw0TXdHRnhqb0hrdWtWam9GemtCblZKTmk2clRCNWxx?=
 =?utf-8?B?MmR4T3dQYzRIdGoyMTU3dmtyWjdLQ3VoaDVrRUR2SDVUVGt4Si9vV1RZa2hs?=
 =?utf-8?B?SWVNdnh0TmFNZ2huMHNPZlhGaUVFQzNXclBSSW85UTFYdWM3eGVJQXlNZnJJ?=
 =?utf-8?B?c05xU2ZiYVlaalNXTkF5dDkxdzBwYnUwODJQZWM1YllqQUdaT2FoZG5KQ0No?=
 =?utf-8?B?V3FIKzJta0xSOWFrcGh0QTd6Q0JpYmI4b1NsRmJHZCsrZER1QjZ1OWwwZ004?=
 =?utf-8?B?b0pLdi9VbVlPRGxWYk1RZG1oK3pNbUNvY3EyNUZNMlNhSkdhWHp2QjNMdmZm?=
 =?utf-8?B?NmZxZ3g3VGRWakNxbzk2eTExVG1YSkg0cUx2UG1iTjRQeGsvc2RLdlpwSTFz?=
 =?utf-8?B?aDlnVXdrT3hYUnRiOGZNWDdQWkxrOFcrY2VWWlROeUUvYVk5WklWeXJ4VHVY?=
 =?utf-8?B?WDN4S0RQNEZZcjFnVSt0aUxod0haM01ka2NSNzNXMVJQR3ptaUVhR2hlL0Qy?=
 =?utf-8?B?aFpCUmlVUm11NTBzVWN4SmcrdGk0RmtDbVhGdDZTZ1ZteDEvTHdoZz09?=
X-Exchange-RoutingPolicyChecked: t7kjLawI3ts21V+nWPeIUXcuf5fAeFtnIwhA1znErfPC43A6bcHIYq3gqHn8ivVwU9359b5dPLasXkPC+hyl4i5KeIXmMm98A8Cu+tGI3xNS8PDc6ouNii8qI/s7ekbT3Q8HB0C7N6/nRVa31/Kq3/TujgrJMKJLsJLZJ8RWozhac/ypzoSDxRbho3WecD36KKbq4+ywYFa3ZCm918T0xelARNieHcMO27Jej4qX+DFG03Wj2opGHpJJCUNbSFu0t2yw3Pu2DBYdyl3fkCrCdgesqB58Husbt5QK5Moq0Gtbvp5sEP0uN2rvLvK21VZlz8Wix1chJ1gsx9QhgY03pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1037af-2c53-4958-fe8d-08df43ead09a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:06:31.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8PjiuaK8u9n6/9SQckSKOR7hcp50odOPDVXd8XlgVaydCcfMYzYdrCR6nnS2IuNBGrcakuKUjbxJZ83ivZvUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29-09-2026 02:28, Bowman, Terry wrote:

> On 9/27/2026 1:02 PM, Lukas Wunner wrote:
>> Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().
>>
>> The call is superfluous because the function is only called from:
>>
>>    aer_probe()
>>      cxl_rch_enable_rcec()
>>        handles_cxl_errors()
>>
>> ...and aer_probe() is only invoked if an AER port service was instantiated
>> in get_port_device_capability(), which is conditional on:
>>
>>    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>>     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>>    pci_aer_available() &&
>>    dev->aer_cap && (pcie_ports_native || host->native_aer))
>>
>> ...and the last line of those conditions is equivalent to
>> pcie_aer_is_native().

Since pcie_aer_is_native() is a generic PCIe helper that could be reused 
by other consumers,
could we also remove the CXL namespace from its export?

Riana

>>
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   drivers/pci/pcie/aer_cxl_rch.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> index e471eefec9c4..9cc2d5749b9d 100644
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>> @@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>>   {
>>   	bool handles_cxl = false;
>>   
>> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>> -	    pcie_aer_is_native(rcec))
>> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
>>   		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>>   
>>   	return handles_cxl;
>
> Nice cleanup. The pcie_aer_is_native() check isn't necessary. You can add my RB.
>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
>
> -Terry

