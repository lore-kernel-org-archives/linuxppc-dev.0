Return-Path: <linuxppc-dev+bounces-29550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D03CC6B33
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:46:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j54WB1LZZz2xNk;
	Thu, 15 Oct 2026 21:46:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792061190;
	cv=fail; b=kmXQ/MgxCPrecvwv4VRhGizF1JUCV/Ai6pBtIk2Kbo0YnShH4NJF50eOPSui0hbcaxDRW4nSMgaxbyeWaOk9I0IiLG4abyXq0+O4Umljjnd67RDOCyG3TA9bCPm9prxNWIrNA85LFhrDsCGQeJVcmrVjnWo8C4BeHq9O87eAWdQbZH0YKzaEvF9/Jt2jKq0amddE+0QEk/1oT5wallOnDgchkfqjJQy7KZ+N4prKsCGKNfdRy3M48ZKWfbdjVlbpf3YTklvw8mtArE6xeRZ2vf4fuhIiDZMf4PfRG0dxHS0xNYlb9DFekJ2f2ki1llxVJhKzCX14VR8n1SsaSisMjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792061190; c=relaxed/relaxed;
	bh=cCpIm2pHjZlYwvUy9etqyj7ejrWUFcws6YqLWLlaZVA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHfpsqe6cv1oDsHKzjUnCImE9ojX/XRVCWTEz/ev9q4gTbuqri1QpAyBaMzdGUGUl0V1z/P1Fq+fIEnnKPB2ZbivtfOkq1Ohp7CW7xmhYaYkqSECPoei731yIrBLlnUt+J5k/6XZdnj7ttMzfaVHAvi7ufBSxEaSfWOwLaIUHn3JvCcdglH84Z6qwa/2nt600xP1XgmYSScKxr8ZOYDoE3thqphYafVI1ExZgMi9iJt4UPXBOuEfUeEELcwpmKmZJm2VCxQMFQ0pLUYtjRX2YaMTjlFekAkCrHuaT4gEHgmuDVoaDnjBLua89hhLGJChJ2H3+vesVrT45uYIYBsgmw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lM6fbBos; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lM6fbBos;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=cezary.rojewski@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Thu, 15 Oct 2026 21:46:27 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j54W734Jlz2xNg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:46:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792061187; x=1823597187;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b8qFkgWPmSq6BccA6v90mpoIWAYbilVF2SCUZDlUaTI=;
  b=lM6fbBosVpLasX1q7yJUiP8ZQ7jw2CbF54SZWK13QSzVdLMTUOQmOsdR
   oqWI71s3FRiv0cF5xmFvDMClkr3OpC4zgvBV9hSXbbQZcupll7Fp24Elu
   BYd6uZ7msOd/li1Y8pC+FMcqSltOqVhJgA3GdWHz4d6lrPYNUJ7Rah+Xq
   PQiXyJEK3Q/lzGb2B5xA+Qpxqu2N96IypKWRYzqOi7F2YoilKMkBfJ7MG
   Rh4fYRcILY5YhkPzw5w0pkDMDwScTaLZn6p/jpXd9qB+V54rORQSl+O+W
   2IpXYZvT6dbng3ZH4XEQnenLWEy6hx/oxpIDGcfx5JmuyMK3/rxDy6I+B
   A==;
X-CSE-ConnectionGUID: x8Iydu0pSD+VLuOcXZjLxQ==
X-CSE-MsgGUID: sM0yldQgTu+E7Eyga0LAEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="821864"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="821864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 03:45:17 -0700
X-CSE-ConnectionGUID: 8aq8oBkyQ5m1Mm5dpEjUvA==
X-CSE-MsgGUID: 0onXiSCLQiKDRm45E2jkHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1722479"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 03:45:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:45:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 03:45:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ej8RWN89W8FxTqkgaU0HuW+Rz1nU9iWXT87IvBAHG1PqpGEiFa2UeSJ60YaA7x4b7yJKOxxAX468uV0W/9ApqIeDPgy9n0I/PA36XJ867mOVRWDqPNwbYeMoHrsR6YeXvpxHrWuiJaR7sVz62wDe+LYYBgEI9QTkIfWr23Fj3n0DP2Lgb1OtWAA8tnNXxLH/FvTUBuE9M5RifuDOFdxF6NrYUlHo3zMvitPyL9VAwW+SoYxL5H0BNUfz0wjefFmbajGNdIg1OJrX8vd9uJhL/DoRmCC7xROuvw/otCZaQCuQHlOvkkuGFY219byEv0zQNywDmiJOWMRaBuZhjP6Lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCpIm2pHjZlYwvUy9etqyj7ejrWUFcws6YqLWLlaZVA=;
 b=TlcrLV3/p8Ap5m9WcnxZ0NVwlKr0qTeTkOQkeHYBjS/8dwjzd6uvKBTw9quXGdQiNm1I0EJ6c/HJ0/Vz07g6EXvZbrsTQUs8FEbsJTErqaqlukl0m/mveqzv3OGy59/ZLzYd5zl8rzlg6Xuqj6w86WrVb+zcWi6smp0cu1qfbNbpetIB5e08rUU4KqhALdpyRz/N7B/LjNl0cxD8CvhHlrPVbRoxMSYGlP2qZjjKUx+i0RZokkRBxaII3LvWzIvKmf+p4rbKTd4gYxc4S0Ik0ZJKduY2GJ3cn5kxQ2ltNv4LWOQjIt8mgsdQuQIcCPQVRfgoOX1fyQbYCWT1LCFUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:45:12 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 10:45:05 +0000
Message-ID: <883e3e1d-feef-4ef4-940a-77ff8b3618b0@intel.com>
Date: Thu, 15 Oct 2026 12:44:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/25] ASoC: intel: atom: Fix .shutdown() being skipped
 on rollback
To: <phucduc.bui@gmail.com>
CC: Kees Cook <kees@kernel.org>, Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, Linus Walleij <linusw@kernel.org>, "Charles
 Keepax" <ckeepax@opensource.cirrus.com>, Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	<u.kleine-koenig@baylibre.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>, Hemanth Selam
	<hemanth.selam@gmail.com>, Md Shofiqul Islam <shofiqtest@gmail.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>, Bo Shen <voice.shen@atmel.com>,
	"Vinod Koul" <vkoul@kernel.org>, <linux-sound@vger.kernel.org>,
	<asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<patches@opensource.cirrus.com>, <linuxppc-dev@lists.ozlabs.org>,
	<imx@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Vijendar Mukunda" <Vijendar.Mukunda@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <povik+lin@cutebit.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>, Shengjiu Wang
	<shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
	<festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li
	<Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Heiko Stuebner <heiko@sntech.de>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
 <20261015014324.5569-20-phucduc.bui@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20261015014324.5569-20-phucduc.bui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:803:64::29) To PH7PR11MB6006.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed6da97-0440-4a21-ad06-08df2aa95fcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 615DnE+SlnkHK/jTQGxeCQBTMj4SFK8/8fTdY5bX/ZdUObKzZDm+fM2FTgawNiYTRc9RJitTkfjgTEA4IiO5RXISpaaYcmXCiVMRA+n5kNSYy8wzO07RgpfwBP6470vQL6OhziH6fSg+MrFUIucY/L1W2xBRvGgAVon5wKxfTQ3AaiKgxwUvPil71GzymdcztIVYJI6OmDSKX1r2yxGjEAZt5dl4qKETZb2MN2Za/e7Au/AWmuhKqfoBNAlEniPxQhelWXEr29fYGkj2LhWeVLAnDwQ2alzdAELhRu9Fy7DVqjZguWgtLloezHm0a4dJqHOahVzQo2KEv8bxagEh3WTpbWicFYeWVchFlJSIvdX/sYHusmWXIPqC1aV+fPFcPJ4fRXHj8TCii7uXS5E2F5cLAoGu/C5YDIKOZew0Yzb9Yafwm1QBZNyClYBR58h4xj9Zs/kfzELN/QEwK8nW2OofBid6CMA8RH0BO3pT4VSZcsUAiv8EcZbE1D45upHnb3bZIw2mIyx+qIZuGTY1SPCLakiFyqavx1EWtSACNjlNL20RJ3m1oc/Xpq97y6iitUiba297NSx2L58N4KZAd4aZQ4raD0cGAgisDylzGNx+YzW7u4ytcnXSe+WwcY6RiM6LCGV/absdwEExuT3D67NY/VBkjWJis3y0F5sSBTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21vdm5sYi9La2tKWG8zajFreVlUZ3JzU2ZDL0xMNUFmNWptTktqSy9SVzh0?=
 =?utf-8?B?SEVYSDY5OTFtWGNjWlRqdkQ0VTAybWk1Q3FxVUI3WlNJMDRpK004M2lOcjlE?=
 =?utf-8?B?L1FtN3ltdUE0Mi8yTjFPY3NkQk9IeTllWEpuMzE3Wk1WNHcyWHljN0ludkh2?=
 =?utf-8?B?SXJaelRQZUFFSFBFbXZON0hhUHZUaXE2SVdzSHFGQ2VRVEVubnFFU3p0a2J4?=
 =?utf-8?B?NjlRU3lKSGlsSE8zY091djRkSm5Ka1o5aUlFSGZteG5KUloxZW9ySWx3aTNs?=
 =?utf-8?B?VlVSUjZyK1BvYTNITXQrYUN2RGEzNDBRelRGYTI3dTBPeHdpNzdSVHYwUlJr?=
 =?utf-8?B?RHZHMDlKQldKUzlQUWxrUnk5V2JPd2pIaEw5TndDUzV1VloraFpzQXE3b2VT?=
 =?utf-8?B?K3loZWZNc240UVV1SVNLcnVjK3o4MDc0T1ZYYmw1MGFoUHEvd1huWGUrSUd0?=
 =?utf-8?B?L0xWOXg2ZUdyT3JESjNETmQyOENtMkMwM0NpRmlXcDBmNXZJVWk5TW5vWmxI?=
 =?utf-8?B?SjF1Vlp3TTVVZHFSak5YQlo2OUZwYU9CMHd2YytaWjFXKzhPbVhhaUs1L2h0?=
 =?utf-8?B?THd6OVVIdElHQWpSQzBmVmdYVDJJNU9yeU1yYXVYMVJYVW9OTmNzOUxMQzI1?=
 =?utf-8?B?L2lxWmFrdmh0bUlFck56bjJBbjNDK1o0VHZEM2s3S0NGekJvM1VmRk5WcUlq?=
 =?utf-8?B?dnEvK3BFODZqTW5qZnJhY3p4V1FrNGRNemZqZmhnZFBzOFh1K3hwNVM1OVVx?=
 =?utf-8?B?M0xuV3g2L1V5Rlp0NUU1UnZvVjdGWjhMd3paUmlaUFlIUVQrM0cvSnZGTmtq?=
 =?utf-8?B?QVNMVmY2Q2NiWVZGR2pVOUM4K3Y5NUh1Slk1OFpHdUJJRVVpUVN0cjY5TE1z?=
 =?utf-8?B?dFFldWdqaDg2L3g3OVVibVZjdFg3c0pCZ1ZOMjBlZVRFMlFwK1BqTDI1a2ln?=
 =?utf-8?B?bXYvZGd6K3BPdElzTXNaeDR5cjJZOUtFM1FQTndsdkllZWErRkQyOXFHanNj?=
 =?utf-8?B?SGh3d2FnaUFGVWUwUFJiMHpVOW8zeHNRa3RvaFZoS3ZjMDBsb0RyZEVjWlZl?=
 =?utf-8?B?Mzl0NWRaa3AwMitLM25jMVFJWmxhQVE2NHhFMFgyNmhwYmk3VEwxL2FtTzJZ?=
 =?utf-8?B?NXhadGozeEhnREd3b3RmTDVGd1krTzZsWS9QdjlzZjNZQ2RpaUFvSHBCNVZu?=
 =?utf-8?B?MFFFWThpd3ZxdzcySWZMc25WOFgyYXowK1ppQ0VaUFhYWFpYVHpScDY3YWpK?=
 =?utf-8?B?OVpjMmZlNUJpVHczcEdVdWJvbk8rUUVIekl3QzBHdWF5K3pheG5scFUwVFh6?=
 =?utf-8?B?dG1tcmtUNlFPQUo2Z0R2N25JK21sOFQ2VXY1Y1RrelpRMHpQSEZ0ckhXSjcx?=
 =?utf-8?B?VzJPKzQ3YVNzOGdxUXhNZllOdkdYTnViL3BlT05VS09YelZ1WGQ2TGVPRklI?=
 =?utf-8?B?ZjJwRFJ5S0tITEJseFpzZHNVbFpnM3JaM2pxb1c2bm5WTitFV0htVGFtdEc5?=
 =?utf-8?B?Y1kvMlhUT3FBcnVnd2tOVXVUZDFOY1NhTVY3UHovakJJYVE5NnAwMHNINDM0?=
 =?utf-8?B?dHllM1JUY0ZqUmV3L25kdzlkYUFPb0d6MkRERWdSYlJjblVnNFh6SmY4QnVB?=
 =?utf-8?B?MWZ2K3cyMFdLaGViczlhSkkraVFIanp6V1pmQnduNmN1VDRGZ1ZZMmRjNzJP?=
 =?utf-8?B?TFdQUmpjeDQ4TzcrczFYTmFDRkFhdzZjeVlHQ3FYcjVONVVCeEp6cHZ1bzZM?=
 =?utf-8?B?dDVid2RxRnE4cUR4S2JIKzJUaTZyeVpYWkVjWW0rTk82V3o5SHBkbGFNc2dD?=
 =?utf-8?B?S1AyQmxTaEE1MWRSUzhiZVhzN2N6M0N4ekgvbngzWWtqKy9pM2lxZHk3MmZQ?=
 =?utf-8?B?a0ZjeDNvdFMweWdkM01mSDhWbVhib0svMHlad2s4SnBWWnE5cHdqWnpGWTFj?=
 =?utf-8?B?d0FkZlpTOUxtUlgzV3YySnhPS213aEkydS84MDBrYjUvZkwrLzhsMXJCVDBQ?=
 =?utf-8?B?Z2cyUG5UbG8wOTBoZ2ltbXJvenNidHZ2U2dyZWx0ZEllckFsN1F0NUpiYktW?=
 =?utf-8?B?QmlvenhZZFZ1RGluQUJOVTF5Wko4UXdvbnladURVMzJHRHUyMjgxUUdVaFFB?=
 =?utf-8?B?QnZuWUR4aGI2VmNtNyt2NU5NTTlGWWlkQ0RsTUJhemNJK0FyOHp6SFNrUmE0?=
 =?utf-8?B?UVNyTVZ1ZWlZZmRWNFV2QkN4M3h5SzVTNHYxclBKbjdDS2hYYUNtYkQrTmov?=
 =?utf-8?B?SHF5dDZZWlB4dnRaSG11c2QzNHVNc1dsQnJBKzRjSDY0c2w3MGt4RjFSTG4x?=
 =?utf-8?B?OHlxbXlUZUUydUtaTkY4djlFL3gzNVRjam5lVUFtUmdsTm5oMEFjQT09?=
X-Exchange-RoutingPolicyChecked: SiykrbRDIFLdrOdb9SJIid8BINheKQZYboj4I2aVDS8soM9L/e6LDqk6QJgfpeLs9ZR2dmnTenqMUSFzqp+h8utr/1qXEbeUamuvhpDjMpbMAEbXxw/emU4QYbV9Ol5oO0tbuagtMx8uPpIGTjhguTFSWSZ/bm+O0EgPOLtSVR0+nd6VBDZ9vvnK92LedjqLlJqmGFtZ4U0791Em6ijT4BwwkTelw9coocwJtuXT3Itbazaybbw8t1hkPyKOhJQqr94yEQVGNLPlSzeMDpiEO9uXj/EWYez/kYq9waurMJZ8C/XOVk7jLXW+tWQMspwXonHDlCoKRNSQUqsC4+iZyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed6da97-0440-4a21-ad06-08df2aa95fcf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:45:05.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJQqo8eeU/Jf4h4QeJwKoSSgZxtkZZ9FCh7JBgh2EHg2ETYVH5gR9X3X18sOq5G5OdEnTUghQTOmivkambrpeoBforW4ZH8lCY9Zz+ZtSgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com

On 10/15/2026 3:43 AM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> snd_pcm_hw_constraint_integer() may return 1, which is then returned
> from sst_media_open(). ASoC only marks the DAI as started when
> .startup() returns 0, so .shutdown() can be skipped on rollback.
> 
> Return 0 explicitly on success.
> 
> Fixes: 4889a8a73f65 ("ASoC: intel: atom: Use __free(kfree) for stream pointer")
> Fixes: 6cc0f4e63994 ("ASoC: Intel: mfld_pcm: move stream handling to dai_ops")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

