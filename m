Return-Path: <linuxppc-dev+bounces-29365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A116CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:26:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3tq716Tnz3brv;
	Tue, 13 Oct 2026 23:26:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791872151;
	cv=pass; b=el1s1W9tTVByF2sYGKzq/BfQj1DOLPywiUhbE92K6cgiTFk+oHCkv0iQIceTUI1vPkb25k0RiCri+M7W6mAevPu7tHHQQ8wsNC/num/RchKgYm9SUuc7GRLqNOdWVaZJbd6pwAiDwFEjB4iLNfLqf6SuqMgTk7UkweYSv+kNX4A8dA5FFsfrQPLJGC6Ke9rqWB5j0cUntSXJscp/dUFwMIpFUI52ozBbKWzZntL6S3j1wzhQ1/65cZoFdRR04pSWeYtuRhgN7a8Fgo2hZyzd2c7ZF7KHY9anJ0SpbLIt7cTixWU62qKB3F3oqvln4jcPs0tbUhEn9+KTF1rsqmt9Lw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791872151; c=relaxed/relaxed;
	bh=MBe7StqWg/YQxm0Wsb8nlDNjmKCbhc1M9C+wYGi6VJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j2x7SlNDHma6cBUE44yJpXJVL/pQh4PKkoDSTKBcJhDjn4A2NfI98aj+dT9Qp3jpVmS1XjUvE7Xusu219OY1/9D6QnFGYKzAjSdgiKNCsEDsGfTXEgXxnVSJyPx67SwItydjRujobEmhBTNy8/M10pbNz2Q+yn0cwajRpEnN7ktQFTFT6lzb8DpC01LHw+julQgTiFQ5GAuJjxoiQOPR3Iew01ywFCsWaPq6li/eVDbG2xA2n48z/w8p2Ilw5tXKb5S6lFwcbHh654K49eCKZ0UQhk7MRbB1evR3TQl2tjxJV+3eFsGzYfUgBaVwd/6eS245zGoc1VL2mPs6UJ/tKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3mBVxgBV; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=vijendar.mukunda@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3mBVxgBV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=vijendar.mukunda@amd.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3kbn4LmZz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 17:15:49 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWpiT/HcjXOxX/Q6K5L+xNQQHyB+mtSw0FynfaXNQOx0UAKSwwJj3zXGsLjhsUhXsygM/Lf6WirMKbLVEEDfnnFR8Ph4/fD2Hvuo7cWrDtTgNQ1Gd1zcF6tDx4QN3zyUk5FtsGBTPAynt0EvG4KQcdlaHAnPes/7miCsLmtyJ3QBlqIlioptM6UN22/zvHY+uud/Wkrazinc9GYTk7Nbr31m/xOtQ/2C3lzrV4n/mmUaI94PGU20Sa4UsQqu+P9Wf4X5J54B4hx5HnJRzDCJfKiu4v9ZwzuMFOELcWjJm+fCfuIFfYgj1E8SDR5TjLfKxb+aqheUIDUNDpMsbkOC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBe7StqWg/YQxm0Wsb8nlDNjmKCbhc1M9C+wYGi6VJU=;
 b=wTWxqerDebAjWhN9/FsRnRn+/CgZ1Embp4CH/XONAP0aiP2+BNK+zb/6xZm7+cSGfblUEVBuE5lQjk8tPhLYG3tpyXgNjTS5wZlc0GoS1GAAWgZUY70zfcTmrXyWo/gFD2ascuLAZMXxUnuDkRP389FPHGw4I7i74tF+D1WUbkwh4u+xu/KfHAF+HhG5LfqiHQAr4Hg+dEFcGPADLoUhrEY7jO9q5LM/RpmfMX/Kr+UO3TUG7iJ/p8z5x4ywbVFGq8dMt88vDORZS+0ODLOjPzAifDSOe9qTWtrO3YUI6txHxvDW0+axj+dVhPGS4vDkR0fhC7mXhCsYCa/2fSn9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBe7StqWg/YQxm0Wsb8nlDNjmKCbhc1M9C+wYGi6VJU=;
 b=3mBVxgBV3sjlNwMrT3S1up4m8NIorvFy9XbcK/uWcaUU2xnx/vggO9oftQAh4u3fDkB0JlbuPivrA/zb5JHp3t/Y4myLzD2qywpQqG26RBEZ9xvSLQOmDX+WA03QcpR3oN+BqKQyTH/mbs10xucr2QJHk9JWCn7yR/alVsZ/lZo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.16; Tue, 13 Oct 2026 06:15:23 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 06:15:23 +0000
Message-ID: <fc30ea4e-3c2f-4ba4-9ae2-054db9b49fd5@amd.com>
Date: Tue, 13 Oct 2026 11:43:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] ASoC: Fix constraint return value handling
To: phucduc.bui@gmail.com,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrei Simion <andrei.simion@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>, Syed Saba Kareem <syed.sabakareem@amd.com>,
 wangdicheng <wangdicheng@kylinos.cn>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Neo Chang <YLCHANG2@nuvoton.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 u.kleine-koenig@baylibre.com, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Hemanth Selam <hemanth.selam@gmail.com>,
 Md Shofiqul Islam <shofiqtest@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Zain Aboobacker <zainaboobacker33@gmail.com>,
 Sang-Heon Jeon <ekffu200098@gmail.com>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Bo Shen <voice.shen@atmel.com>, Vinod Koul <vkoul@kernel.org>,
 linux-sound@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com,
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
 linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261008103831.542533-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0095.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::8) To CH1PR12MB9576.namprd12.prod.outlook.com
 (2603:10b6:610:2ad::14)
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
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: a32061d8-35c3-431d-09f2-08df28f15d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|22082099003|18002099003|921020|11063799006|10067099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	08rnzLHITOy9yHoFyXcCJY2OY2sh3a+4Bfa4H49Dmv6PLMgLKcZWYpeHcPB8O2DhZApo5tF2N35a51EB5N2ix0lSwWdX0UEQvemGccRaBGkQrBrE/wGtysqkaeY2m6QMASUVRSs9F8kjl0vwep/lQ5XLVePmjPOo8bGUdrdEL/fxBuEJLgtEkMqWa2JkbqF9iDUdAq8FzPFJhm39OHxv7G0fjxSO2LkkgDp6K7mQyurb1QCHurRmOiu3sA9nejKx60+kWecLpqgopggVrqL9x8UrNwmMwNUmERO7BlwvYXs8xpw+wFIQ2PByljYzBUtHVxo6EbXFifHCC0MiNb6OQcX1Z3cI5E4VeukG77vletcePlOSASXVePSAFaGkjKd5dHobqEcDrJX2kOUJ5J2Sd/r5oVBansk6x/5OUujS+CovbFTr4s/jyOMSNF7UmmGUHmKFH9NBko1BS/maiTRhh5ous+YyKJE0Onhpj9N5D5ghJ1it1Tosm9a8JG+/PYYtDej4NGGi0xhWCkF1Tm3EiJVp8/LTkzuDWOYzDMWfvQsKXCdzkC7n1/yvNJnb8ES6A7D6cwieoeLOjoxuWMqnMBcQQ/GHIh0E0bSzbX/rVV7Zbq3vES9i8MHPIQ0EgtragQI6T0fnDYuC/Qnsp14aklpTtg/YIPoqgEnJkHPUFZ3qNvMZLUi2k2phyuEB7dBxAB2jj9kPOO3KyfIiutMWKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(10067099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJoVXFKS21ZWW1sL0hMSk1HeG9UMDdWbG5OejdkQnVFUzJGckdWcG5JdVYr?=
 =?utf-8?B?cDRZcG5iNnVEQWhWMG9Qbm5wVE5vd08vVnZaOE02bTdGclo4bTF1L0s5YjJX?=
 =?utf-8?B?MzhoL0s1MGVsekhsTXZIay9lZmlQVG1hblRtSUdMQmdIUm1VSVN1djcrbFRI?=
 =?utf-8?B?R0VsWG1xUkRCQmZGWFFQb21qMUtVN1ZLTFN3cC82dEdYUG1ZUnQzcm9qREla?=
 =?utf-8?B?eFcxNVBldnRHaXRHY1ptWUwwSmtBb3lRMi95NENyM290aU0vbm5pQWl5NGt0?=
 =?utf-8?B?L1FXWSt0ZlpXV2h1ZEsrRTJBMEh1SjNpVUxFcXU5VHZHLzVuaVJ4Tk5mNWZO?=
 =?utf-8?B?NlkyamJFa1RaVFNkbWVvTll4cHA1L0NyTTQ2a3g2RkUwSUhDRGtnd28zTXVH?=
 =?utf-8?B?UXo5SWRHcXA5NjlFcE1TTVFTTkk0eHpTTDVXbjRacVhlR2hRVFh1dzFvMTVr?=
 =?utf-8?B?WmRPakpjSmFqb2xQeGJCYUVVQzYrL0l1cTM4b3IzbWVCSVBGcEtHRnRnN3Vy?=
 =?utf-8?B?cFJJVHl3ekhxMFpEaGlNSi9DckRyUFc5VEd3Zk56TEhodlJmMjFlc1BSZjZH?=
 =?utf-8?B?YVl1UC9WUzFaOHZiQmYyc3NPZjEwSDNVZ1Z4Z3l1SStqQlpmUkhVcGFqUHVZ?=
 =?utf-8?B?eDF3clptQ1E5OUh3dHJTdUNqdzZQanZRRVVocWRRcG5Wc1JoQjhUN0NBY2VG?=
 =?utf-8?B?QkMrSmZSdXdYdEZ2dzN5VUdtdFdkelJDWldRWEZQNDNJTEJEdFc1U2tpclRh?=
 =?utf-8?B?OFdXNHJPa2d0UTJTNHR0cDBBaHcwSUJPRGovOEt5SkhkTFZhejgybHdyZlBE?=
 =?utf-8?B?VnRaNEtVaXpMVFZaMFRqTkIxVXVsNG4zdTJlLzRMcy8wTkc5L3l1dTMxNkZS?=
 =?utf-8?B?VkxhbExMNkhVTlRvRWozRGVrLzRyeHgrUnNtaHVRVHorQ3BnMGxuVHI3WmZV?=
 =?utf-8?B?ZWlLc1pqL2Rja2h3Vkk0UmpSMkFCWFNGTXJkdy83Z3V6eG5MWitzaFZQTjVZ?=
 =?utf-8?B?NmtxRllWTlFpK3MzeWt0Y1pDS1VyRThQdkI3Q2c3RGRzQm11WFEyRnduQjhu?=
 =?utf-8?B?UjZOUllaWHRvcUhlR21IMmg1WGcxYXlzY1VqTUtjOSthZzJheHhTTlBPVUZo?=
 =?utf-8?B?UWFZRjQ4cW15SGRFOTVwdVRvOVFsSjNnWitqRnZzZ2JVNldXRUFaMUJzeWY0?=
 =?utf-8?B?d09LdFE4VmJQQnZLOWFvZ3plalRreVd4UU1IODVoR2FUNFZNSlFvQXpLVjJa?=
 =?utf-8?B?bmNud0c2SG5JbU5neHJyWXZja0EzM3lRU3JGR0xYNy9ydkYxUnlmTDlybUVs?=
 =?utf-8?B?Nm1ITm9NK2NpdUZhaVczY1MyYTh5TXYwZmFwWlAyV0MyOWdwSS9Mb0JHSUY2?=
 =?utf-8?B?NE9HYWYvdVFnSDNkczhCRjZteXZ4dEhHeFNaaVU4dFVpNllxWVVWeGNuOS9w?=
 =?utf-8?B?d3JJc2FpSEY2N1pSc1RiSVZOSDR3ek1ybnFaVGwvMzAvZG8wd2QvUHljOUll?=
 =?utf-8?B?QUNLY09SekxQYVFoSDNncmJPcTFidy9EVis3NzRJcTV6ejd5MmQzN0pDQnEr?=
 =?utf-8?B?MFd5WEU2QktxRGluNk1acllZcFpDNmFRQXNDMzZDWVJmdFVKTENocjBWcW9V?=
 =?utf-8?B?c0NJYW9zSldMMkp0Z1I2NjhkYUJ4Zk5ITjZwK0I3RytvT3FoMzZZdkdSbmZz?=
 =?utf-8?B?Nm1MOFM0NWRqRUxlMGtPVXgyZ2hsVmsrZnpRbXphZHljcGJ0Myt1YnYxYkxU?=
 =?utf-8?B?ME9UeThiaER1aEgwT3hCNW5nZTIyUjR4NllKbDZIQVpBeUIwK2NpQ1ducE02?=
 =?utf-8?B?TXhSUGltOGk3MjhmemlOa0g1T1Rxa2UvN3VWaCtVS1NSbjk0c1g3eXNYQUlh?=
 =?utf-8?B?N1ZiaVJ6KzUvRmxrSmRaZ1dEKzdSNU8rcjNUWC9NMDFOM29HMHJTOVY4ZHJI?=
 =?utf-8?B?c2lneCswWlRjLzdjV0gwcWdhalZnbXY5THA4NWwrVlByd08zU21Wb2dYcG1W?=
 =?utf-8?B?RlFNVlhZemN2Y2pHenpTR3E1SlI1Wmw4SDBsOVl1L1dqcEZER05EbGNaVnp4?=
 =?utf-8?B?b0hhUXBhS2d4THZuOW9wM0VmZk0xSzR4UDNaKzVFczhROVJnMWNZaFVpb0Zl?=
 =?utf-8?B?ZENuZ0R6QjFGbER1dlYvT05JSThWdDdJREVFM250NWl4NWlqMUwrUC9jUXlS?=
 =?utf-8?B?SW9tMm5QQ1g5YVFxOVVrU3NJYzdZL1dhbmNUK2hnVmx3aU5pak45czF2dmxQ?=
 =?utf-8?B?dG8yYnRzYmFPUGd2NXJ0TWhMVGdMQ2ViU3RyS0hmanU3WGJoQkMwTTVoalNK?=
 =?utf-8?B?U2lDMVd4K2xIUkdXZUhHejJYNGc5MThlWFFPeFVuRGJJMS9XTi9FZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32061d8-35c3-431d-09f2-08df28f15d3c
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:15:23.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX75sSD/MU5v0dDkdSUFpp+UUs/LHYM7COUlfF4v40Wptu1EBOw6DjOmuuOm4mFfrnyo6rgmGnjIAJIBYbSFOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361



On 10/8/26 16:08, phucduc.bui@gmail.com wrote:
> [You don't often get email from phucduc.bui@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Hi all,
>
> snd_pcm_hw_constraint_minmax() and snd_pcm_hw_constraint_integer()
> may return positive values on success. However, ASoC only marks the
> DAI, link, or component as started or opened when the corresponding
> callback returns 0.
>
> This series fixes affected ASoC drivers to return 0 on success and
> properly handle rollback paths.
>
> Found by manual code inspection.
For AMD patches:

Reviewed-By: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>
> Compile-tested only.
>
> Best regards,
> Phuc
>
> bui duc phuc (24):
>    ASoC: amd: acp: Fix .close() being skipped on rollback
>    ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
>    ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
>    ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
>    ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
>    ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
>    ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
>    ASoC: apple: mca: Ensure the DAI is marked as started on success
>    ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on
>      rollback
>    ASoC: codecs: cs42l42: Ensure the DAI is marked as started on success
>    ASoC: codecs: nau8325: Ensure the DAI is marked as started on success
>    ASoC: codecs: nau8540: Ensure the DAI is marked as started on success
>    ASoC: codecs: nau8821: Ensure the DAI is marked as started on success
>    ASoC: codecs: nau8824: Ensure the DAI is marked as started on success
>    ASoC: codecs: nau8825: Ensure the DAI is marked as started on success
>    ASoC: codecs: wm8580: Ensure the DAI is marked as started on success
>    ASoC: codecs: wm8782: Ensure the DAI is marked as started on success
>    ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on
>      rollback
>    ASoC: intel: atom: Fix .shutdown() being skipped on rollback
>    ASoC: renesas: fsi: Ensure the component is marked as opened on
>      success
>    ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
>    ASoC: renesas: rz-ssi: Ensure the component is marked as opened on
>      success
>    ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
>    ASoC: rockchip: rockchip_max98090: Mark the link as started on success
>
>   sound/soc/amd/acp/acp-platform.c             |  2 +-
>   sound/soc/amd/ps/ps-pdm-dma.c                |  2 +-
>   sound/soc/amd/ps/ps-sdw-dma.c                |  2 +-
>   sound/soc/amd/raven/acp3x-pcm-dma.c          |  2 +-
>   sound/soc/amd/renoir/acp3x-pdm-dma.c         |  2 +-
>   sound/soc/amd/vangogh/acp5x-pcm-dma.c        |  2 +-
>   sound/soc/amd/yc/acp6x-pdm-dma.c             |  2 +-
>   sound/soc/apple/mca.c                        | 11 ++++++++---
>   sound/soc/atmel/atmel-pcm-pdc.c              |  2 ++
>   sound/soc/codecs/cs42l42.c                   | 11 ++++++++---
>   sound/soc/codecs/nau8325.c                   | 11 ++++++++---
>   sound/soc/codecs/nau8540.c                   | 11 ++++++++---
>   sound/soc/codecs/nau8821.c                   | 11 ++++++++---
>   sound/soc/codecs/nau8824.c                   | 11 ++++++++---
>   sound/soc/codecs/nau8825.c                   | 11 ++++++++---
>   sound/soc/codecs/wm8580.c                    | 10 ++++++++--
>   sound/soc/codecs/wm8782.c                    |  7 ++++++-
>   sound/soc/fsl/imx-pcm-rpmsg.c                |  2 +-
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c |  2 +-
>   sound/soc/renesas/fsi.c                      |  6 ++++--
>   sound/soc/renesas/rcar/msiof.c               |  6 ++++--
>   sound/soc/renesas/rz-ssi.c                   | 18 +++++++++++++++---
>   sound/soc/rockchip/rk3399_gru_sound.c        |  9 +++++++--
>   sound/soc/rockchip/rockchip_max98090.c       | 10 ++++++++--
>   24 files changed, 119 insertions(+), 44 deletions(-)
>
> --
> 2.43.0


