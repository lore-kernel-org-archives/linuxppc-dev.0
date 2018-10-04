Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A1C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:43:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C836213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KFGs94RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C836213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qnxn0sv7zF3JT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 19:43:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KFGs94RJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=40.107.7.78; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=grant.likely@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com
 header.b="KFGs94RJ"; dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qnt01DCYzDqkL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 19:39:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szDhh6nOqnkJbgduW4XKOjlZH4n18Fl3gh7dYiDtXAE=;
 b=KFGs94RJwlL778gkZFHxMZaAtjwdMY9fLYGl2usjQUj0xDt7w9iH6AFDBO0zamDNBQHIeiQ9LNXrTOz/EZnJxCTq1T35yKc93PcO/h3IMMhieJ8vtMsncYC7tH6bH+iq//9cInzYBb9XieqxZUBKnIl5dwOp+xQ0IS2KaiS3DCg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from C02T10KAHF1T-1622.local (217.140.96.140) by
 VI1PR0801MB1757.eurprd08.prod.outlook.com (2603:10a6:800:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.18; Thu, 4 Oct
 2018 09:39:36 +0000
Subject: Re: drivers binding to device node with multiple compatible strings
To: Grant Likely <grant.likely@secretlab.ca>, leoyang.li@nxp.com
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
 <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
 <CACxGe6u2FQ8r1Ya6-mWoGcs7g2OLMccu68uskZvDLS6ows-hXQ@mail.gmail.com>
From: Grant Likely <grant.likely@arm.com>
Message-ID: <aa3341d6-8fef-40bc-783b-fbbd55b88420@arm.com>
Date: Thu, 4 Oct 2018 10:39:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACxGe6u2FQ8r1Ya6-mWoGcs7g2OLMccu68uskZvDLS6ows-hXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWLP265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::18) To VI1PR0801MB1757.eurprd08.prod.outlook.com
 (2603:10a6:800:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9041118f-fee6-4654-e8ec-08d629dd4d23
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0801MB1757; 
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0801MB1757;
 3:0HwhinBHVehKBi18fNky3x29ql4LjsJgVoKPojKiwEqF7x6E2cI40juVZIaWJbHAQWE4JckcxRmTTIYkrV+ULhIHi04IcenWfGcVs73+RAcXo1cnwEVKRmcLsZTHMj1wOMM+GpCvMXs3lRftgb4uRRiiPF77gVmHbXnr2ZuFKls9mJ7GqVdMaPgqM7GGHZmSudG7EvOfQNFaXnC2/hUAcqucemWIorDzRXGSmQPpgd0tAOn1h70jiolpbN3TtCJ9;
 25:PLZnoWbzAuRvpFYEQBFCqpS9L8wstKGqcZsby3f4XwXlZBEdVerACJmijxv+GO8qpMQMXmetK5HFIjpJSJFW23+2pxNFHFC926K+XU2pV4pJ4nWppfxP+8JV2gt6lHn8IPB8MzdX/hUau9jeZIPEcEQdGqfoWte77d2vHsmJ44YcsZgeYApOmQMwv7Xy9C7XelfXZQ27QctJCAnfiyouKbeZsGfCm1pmndAT5ljoV03DA1nCR9nwKo1PPUHlQMHW9fvHcMbtG9YENVqwH6Kq43pa7CD7VS7XjVXKcVGZvy0yNoCJYgMumU/GZbQ8zwsR7ZTDpGvtbm8+gD+UnraIwQ==;
 31:IzJhr0CpWPfhmTJV+4fzidE0FhsC2pxolqOmvTzBbTdkafVART3/vQMvcqDv8qZkVans3IrSpXHyRMZhlCNrdxPZkCKweFi04bgpuMooedcKyWmK+uYbpQrCvwZPoAECiP6SBY/2JUpwDNuBBX2P2l2ZMZRoc/Vy5gN7KpJjXi39q7vjijhiDvNHPNJBpOCqADo7+daqwva2gxjLTWKl/M0JXXvpCELdJhaT40hcpDU=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1757:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0801MB1757;
 20:7eIDhP97BNWr2AH6IGPHAAXfApaBTkDhK4tDBFFXczptgvtxJYMxvui1S8ndh2AXa+xMY6jxpSzI6HQlQ81Hedhukbj+BeZHiLKHKjh8bvy59Gt6+2mWTPiEfiDx0uUy8HMZ/T1Ky5ZZ9jxX8FSA0LNX8Y3lbvH7S+qblcOmIkueDxXX6c/47IRhLlCbLRSvvvn08Yt4+GFfRemzUl2WRk1is7dUJlhe2qLDoBUboEwRiyVvQRzhrLwJMXGX0yOZ4TTco2JKTDDq+cITSWxotird3v/pL+7t471xXlRVkr3aLmqHlmcuSDgJTR9uc7qT+YKfS4ZCap5UNWHB93V+ODkSaLL9GajPyur1HzrT8k7ihOKxe5FOGEfRUbp2GLZR6PjCdZVacEzSDYP32kQBqKFcJxWYh73yxA1Irycif10=;
 4:WTgXM+Wc4XrKJVHwj8LrCOtX298ERU/gX6w7D/5jyDPx+sCQRqnozsOesmzd/sSlZRwOVBNDeYYEzWq9PcGtTME9h4PwF3WJ2I5t+Wx/NxZTNgGIb2Xfrn3Z8vX1yAHb0VoT4Tdx7t2cQlptkjQbpHIZLFQ5A7sX9gy3HguTXdNrHhQ8FqWTu7iHF4+L0X7mb0n0joS7JrMgjBVhMGGvqppZ8EyNo7EvrCvETouAAWB5Vc8y5lt0L/tp1c8V41fRxr/zmEedNIp/izzIvnr8NfZxEz4MtOcJMCtaWEb1sMi0YaN4I/0Yso5EqljbMsOZ
X-Microsoft-Antispam-PRVS: <VI1PR0801MB17577C427AA9616D5BEDF90F95EA0@VI1PR0801MB1757.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);
 SRVR:VI1PR0801MB1757; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0801MB1757; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(31014005)(4326008)(25786009)(3846002)(76176011)(65826007)(6116002)(6666003)(81156014)(8936002)(5660300001)(14444005)(6486002)(68736007)(36756003)(52116002)(2486003)(52146003)(23676004)(229853002)(67846002)(316002)(31686004)(54906003)(58126008)(478600001)(6512007)(47776003)(72206003)(65806001)(65956001)(66066001)(106356001)(50466002)(105586002)(93886005)(81166006)(97736004)(305945005)(230700001)(476003)(7736002)(186003)(53936002)(64126003)(31696002)(26005)(6246003)(86362001)(956004)(2616005)(2906002)(486006)(11346002)(39060400002)(16526019)(53546011)(446003)(386003)(6506007)(8676002)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0801MB1757; H:C02T10KAHF1T-1622.local;
 FPR:; SPF:None; LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjE3NTc7MjM6T2kwL2I1eDVYZTVBRTFYSU1LdEVwb1Bi?=
 =?utf-8?B?Rk51bjNtNlZsaGw3dkg1Z3ZSV1dGbXEyb0dCYTZHeVRmK2JVeW9nSkdSSzJJ?=
 =?utf-8?B?dlR0cXZTYmZJdU9CdDJzSTBzQlVUZVVPTldGdGh2ZnV3WGJwZDkyRlIyYmg5?=
 =?utf-8?B?SUoyM1l1ZzRQMzZ6bTNBSVo1MmtSdkNNOFk4TlhZWk5kdHJObTJyVm5YNVpE?=
 =?utf-8?B?QXBJRUtJZ0pVSmVKL2xIK0FDei9aWXA2YkZCTnFjeUY0TGJ2MjFhU0c2NUFu?=
 =?utf-8?B?cXRSZVVIaitHT3ZwMmQwYmhSeEVlMFREZ1ZvbTl2dEpkWHF2SHl6U3ZZVFRu?=
 =?utf-8?B?RCtKSnNYZFFycGs4R29lbWl3bDBtSjN3aStBTVc4dEdxZi91QUh4RVc1QTh6?=
 =?utf-8?B?TWhETG1xMllVMWlORUdDNjBja2RnYUhNRENyV2NlakNsaFNlNWtmcE1EUzlR?=
 =?utf-8?B?S1RTVUFEUEluSm1NaktlM0V4ZG9IQ3QwdGdwODZZN2svU3QySU5WM3Q5TWRI?=
 =?utf-8?B?Zk5NdzJQU0JTOVdNSWprV1lBZU1sTjB5c2NYK250YXYxdjRGalhhZ3p0YmhH?=
 =?utf-8?B?NU5KTW5LSHlCOFdVT01BVFhOVnpBQW45Ymc0YUo1UVlzR2dYZ2lTKzNjQk9q?=
 =?utf-8?B?YVViT2JJNnJKY2V0Lys2eU52RzVIWUJIQ3paeUQvd1FHNGJXVlY1bzVJbTl4?=
 =?utf-8?B?T0xKdng1QS9LNWhxV2xVdkJQNTRvOHN6TnZTcm56YXhPU1JRUENxVzdRSTdF?=
 =?utf-8?B?RFBsOS80NDNKZkFrNWtHQ2FCMktpU1pYUFA3ZytUYjZBV1FQWW9ZU1FxWnRS?=
 =?utf-8?B?Z0pCY3phcitrNUk4MURZd25HZjJXVjdaV0VVZzJCZDdrdG95L2FpSWl5Qmhy?=
 =?utf-8?B?NzlvanlkTVdiUHYvcjF6dnlvWFNiV0ZkWTh5WVRtWGQyRGNldURFVWdvQWFH?=
 =?utf-8?B?a0ZGVk9yek1wV2ZkM005UmxZeXNJL1ZiYis3V1N1bFpxRFFzaitrTE1iRGZB?=
 =?utf-8?B?V2s0TFEzazVGUXZCTU5nR1FuTXhvekFmTnR4Z0Jqb1NTYXhBanBtcDdKMW96?=
 =?utf-8?B?Y29yZGEvbHpidG5FM1JPQi9SZXYrd1hCRFdrYzNvaW95QVpIcyswWXpkMTBU?=
 =?utf-8?B?VGNIZ2NSc0s4MnNEQnZaZFBVT0ZINTNZclZ1MWxIeTYrdHRrd0N1Vzg2a3hx?=
 =?utf-8?B?UEh1Zm9hOEpTR1BHbGgvQU14bHBCbm1EMStKNVlDbmVtemZOT04yMHhYbGRO?=
 =?utf-8?B?Ykw5VWtSRWZSOXMwbFAzRE5DbFFqMnJ1R0dSTWQ1cjUrbEVwQ3Iva20zWGll?=
 =?utf-8?B?Y0FJVGQ2Z296VmNxK1lKUWFMVmgwR25IRkRKYktLYlpHaG9hYi9kV0JaSkFJ?=
 =?utf-8?B?dVNKVUxucTMxNUd2ZmZhWFd0YXJJNWFKRVlIY1BkOGE5ektRSnpzYUFFK21C?=
 =?utf-8?B?NGM2cWd3SC9uMUNCK2JEYVhUdmtCRTBzeUVXVnFCNlQxOFN0Q1h4TTBoYmxz?=
 =?utf-8?B?L1NZTTNwN21qVkppRlhyMEhoOC9yK2lwLytsN2tDM2dnWjZLeGQrWFRCWml1?=
 =?utf-8?B?UFNVbXc1QUxYRzJ4LzFXSGh4b3ZRWTlpcUJ1UVUxQUhhd2kyWDg2M0JFMVVp?=
 =?utf-8?B?UjdFMWg0MG10bWlvM3B4ZWhEb0g1NUNVclRoTDh4RmhqRFcvWitJbHFHekJT?=
 =?utf-8?B?VDdYYURRWk9La3JmWXZsNmN6ZEtsSysvbUcyN3BSNjh6YjJZZnlBNytlcitI?=
 =?utf-8?B?MWxNZ2JXaFJ6ZWtXSEVLa2w5ZjVtaGdQdzV2SUtpM0pIOXlIdTRJNXRydVdi?=
 =?utf-8?B?T0xHdEUrUnJRbVZBZFVKNnREZDFKK3B6d21IeDAvald6bmR3TXNuU3Ezelpi?=
 =?utf-8?B?L1RYMjArN0NLN1FMb3kvNzRvSnYwR0hvSXdGdGJSNUgzVmlvd0UwVzJKKzJG?=
 =?utf-8?B?V1gwNTJWbTltSVY3VG5scGEyUEJxbWE0ZjZhQ1hBUytWUEpHQzBTaHNLWHor?=
 =?utf-8?B?enduRDlHaGE5Nm5qaUZ1ZTlKK0Q3WW5rcXpRZWhSbXNaV3dXRUxWeXlmWVh6?=
 =?utf-8?Q?yPcvmcuOR09EdiEeKa1rm+3pBby?=
X-Microsoft-Antispam-Message-Info: twPJLYg1uHgNo62J3PkXU/af5hrH+OuVbWzc+vVF29vFiw+ffdfb9ShJU7tbYrwJZj1H3aIn/lUeCvioVtCbtK/mDcG+vVyQ0e0hKjt2hYqR5mssR8ApJevIQUOQEOmrcnsUT6cUPYgx4Bz7oB88DewZaoB+biffgpt1zu1N3QfPRmsFZ5WdV4XpgyesWICOM3PFE2Jsf2x5lshzhQlRtg0LGOWk9NIC7vACi/Q1L4VSKFx83TJsIwiVy7gDzS2+0rJRN0LdA16zkhsr79wK59bqVRTuHEaHEJJ35bLc3KSvOmuV4SJ8V6B98Gx8TzAXzY+i29NHIq7M47gHaFlDu58zGpZyfR+Gez9swFwXl1A=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0801MB1757;
 6:OocMXxWZk62pdssahtrrUwLxaGRREjPjaw5lQVMOyzp5PvIooqyAjHPici9hdD+QHHl2qeMSB+DXxHnZ7GjT8M4JUo1j9HYnxxehjcam6nXw+MOgHfvU935xReyEWrLLiTyJfcb+alwbWYTXh4Livlpaa0NB8++/+OzJFJ9EqxgoMnyILrr49g2FUgf06iy7Kv4hUYKlj0zzujsSTdNzdvTL4MeSrzA9+kJ0uWOBS03nP3Op6FiJh3MYF94on4fay0Av66KKjaQu5ZOsWsSyN81UbWyCE85jdd2oKnBkNBmrblnQCMF14uJCIMrsW7xYah+2jzDh1/o5GIcMLpuDKt2WJv4IEsyS4YJAC8DI+oFAdvNNuB83+JRU6ejOc397yTh22xgxqYpvWozc9Deu+QCNDY+ACcb72cI+0BacdXpNKBrcSDlu5zVvEZd6ahQQgb80VoFCwghxGQ8iMvXQXw==;
 5:KoQDgoadnduF0WOEdF5DuI2sOkwEsoP+iVQJJ2N4k66NlcLsvU7L8iRth5SUs0RY2J0OqNoRlK5U9Tv2Yha900+Fi0xFFbr9Zq8a5B6djqoZk7zwsIeRun7yLkU7T5/X41DmUSpEI74SYSWkTy5/zjOhLuoqwTmAOgmHRMZ7Fao=;
 7:RxG5pEgAsRduzg/Gnrc1vwBRo+r6zE4qyGoy8SF53j77Wdrfk7AE4tZnnqRSzVntKwaqNW1aGU18PYX0hTuXt0XPv01OyiBdIEvLkqzeKuDCZWgTOfMOJLHxHmUa5NqDurS9Ze/FVyaH1To3b2IAxz/M6OKr8ZGQr4C/aTFoFeFraDmcnWxuO42rH7+PPQyVQVuBMkQwuavI8M1mKiKL37O0RLodMQ9NiuKGDR+xO0Moz0qmLYDjaHiHldJJ8Jye
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 09:39:36.8295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9041118f-fee6-4654-e8ec-08d629dd4d23
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1757
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, nd@arm.com, linuxppc-dev@lists.ozlabs.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04/10/2018 10:32, Grant Likely wrote:
> On Fri, Sep 28, 2018 at 10:01 PM Li Yang <leoyang.li@nxp.com> wrote:
>>
>> On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
>>>
>>> On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
>>>>
>>>> Hi Rob and Grant,
>>>>
>>>> Various device tree specs are recommending to include all the
>>>> potential compatible strings in the device node, with the order from
>>>> most specific to most general.  But it looks like Linux kernel doesn't
>>>> provide a way to bind the device to the most specific driver, however,
>>>> the first registered compatible driver will be bound.
>>>>
>>>> As more and more generic drivers are added to the Linux kernel, they
>>>> are competing with the more specific vendor drivers and causes problem
>>>> when both are built into the kernel.  I'm wondering if there is a
>>>> generic solution (or in plan) to make the most specific driver bound
>>>> to the device.   Or we have to disable the more general driver or
>>>> remove the more general compatible string from the device tree?
>>>
>>> It's been a known limitation for a long time. However, in practice it
>>> doesn't seem to be a common problem. Perhaps folks just remove the
>>> less specific compatible from their DT (though that's not ideal). For
>>> most modern bindings, there's so many other resources beyond
>>> compatible (clocks, resets, pinctrl, etc.) that there are few generic
>>> drivers that can work.
>>>
>>> I guess if we want to fix this, we'd need to have weighted matching in
>>> the driver core and unbind drivers when we get a better match. Though
>>> it could get messy if the better driver probe fails. Then we've got to
>>> rebind to the original driver.
>>
>> Probably we can populate the platform devices from device tree after
>> the device_init phase?  So that all built-in drivers are already
>> registered when the devices are created and we can try find the best
>> match in one go?  For more specific loadable modules we probably need
>> to unbind from the old driver and bind to the new one.  But I agree
>> with you that it could be messy.
> 
> It's a tradeoff.

Oops! Accidentally hit send too early.

It's a tradeoff. If the platform device population is deferred until 
after all drivers are loaded, then there isn't any mechanism to ensure 
some devices get probed early in the init sequence.

As Rob said, while it is a problem in theory, there haven't been a lot 
of actual cases where it is a problem. The solution has been to either 
remove the generic match from the device, or we can blacklist particular 
devices from the generic driver.

g.


>>
>>>
>>> Do you have a specific case where you hit this?
>>
>> Maybe not a new issue but "snps,dw-pcie" is competing with various
>> "fsl,<chip>-pcie" compatibles.  Also a specific PHY
>> "ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".
>>
>> Regards,
>> Leo

