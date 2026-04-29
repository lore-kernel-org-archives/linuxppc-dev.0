Return-Path: <linuxppc-dev+bounces-20293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3017FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:55:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5L2z4T72z2ySf;
	Thu, 30 Apr 2026 00:55:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777474555;
	cv=fail; b=jH633hBMaFa7CUkhyJ+JQWDH0UQvMCnTfcT05WjrI1Cu1cZVoOK83D3Oeo1QYYDAICcr47D/qB+2zMi9lvncYMnzHcAd/B9kyJu27cwhoBzXIKfARceXh8foRFNN4r1y6GDvns65j5mvrlH5lAWC5V1IP5hTudxUGWbez8p+2a+axMRSetJf15f9IIECr/8aCCIowKPtPPg577Z6EKytQLgGdbBVSamHWVMgPtvM5uDTsZjynCLktpN0/tZswMklYqaCKdqN8rh0J8QV8hcnXWGXmbL9pGjhVHFjmooheh6gGYjle4nhnh/ZoS+S+y+jz223KNwXvw/wYv9Z8CFMTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777474555; c=relaxed/relaxed;
	bh=gdTkY1W4FrZoZvwApBN/ePMJeoJ3YzANhfBFm8CFETU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OUbKbBL7v6WuFhNBIz8V5IkROwXRe8wh1Cc2eYZTKsPmud9dbbX6ewC7gpgZnv4XA7TJSEo+Sg7sY42zngoVAjNkKVgkW7NCfkQlavqWSVgGIt31G7PkE4l9MXDm2rtHOELslLbJ39B8gQTEj3CDz0LjXtYvll+v/cruACaNumokaHQcSK55t+i3UNDENPWlag3Vws3YMNxwYuYPlNdl+8AOc4YrRRs9no+i7joAAZl+DE5mb9gztWfxqmkgSbbM0UEQD9iWov8BVj1/fAOnvB/STojn0DiBEQ/TCBCuOszQOB+o7yC0JXv8JCpIRn3cLrRWES4A9aj6qm7zBrdy3g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=xnWmrDaY; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org) smtp.mailfrom=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=xnWmrDaY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs-soprasteria.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5L2x1nC2z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 00:55:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMkEKuvFihS1uVP91qxQCFIe1/Z7wnYYwPyeiGZPiR0qcTFpthaGi71nWWidRa69STdL6EE+njSahVNB3uL+GHWQeH23DQt3pA+6rv1AZ/0E+FsMaXWh8BUaFYgD8LvzRIzbyYEHP5eWy0lzW+tC9zS5r1akhwF6sRl6H9h1jU5Ly8xXClbWE47b1O/n+J5MnboCl2QcN0L+LBl/4d9bQnlgBN4UapB2SLcPYaH9758/7dV1Dul9EBKAOwcVtZ5iuzb1zNXUAIsyZJyTdRpz/KOfkH0ssx5L7TECEdzVAgwSA4wSohU5eY80bAdZCzXc8Xt1ngzqBGg015wANkugfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdTkY1W4FrZoZvwApBN/ePMJeoJ3YzANhfBFm8CFETU=;
 b=YSG5XwIiznpVZDLIsytgYgiXsg9n8hprFYX63OnzgV4aHQDCaRXNQagRnP4LCC4cBZK1DbRATesLxNvFGir6g3cNONObdFV1v3S9gSRjzVVaU9kcUQLYkP+PA2jDNvYvx6+GUUPZOqxutCuS4drSTm9dGbGFCM99CuDGKEDIajoeRwHBaCVuBHMse65m5RSqvGUaKZvObOz/VjbwapzMEM2LIEfSW6fgre16BgkZqrXcxGCIgf7Wk86DVGnlRi4mlw8mveuu1iIejw9tzBrPpC6TcwDK6vrcca4Jl7BsvLqQSvrw7XB26FSuPrLqr3jTRScd0c3RdAvJyVX94lgU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdTkY1W4FrZoZvwApBN/ePMJeoJ3YzANhfBFm8CFETU=;
 b=xnWmrDaYONNO0zDNVeSAvbij/2RlKgvsHh8DBulV/7X8+cJfNnNHff/9BmjNW3huo03oCnpkd0xpW3rS0f8y1vVgOi1QJ3AjWoCWmbGoBm3U/XEjp9bvjW993HqW2appNm1Z8fJLyaNTE7XVsyaanvCcnWx9RqgnQvofvE7Vom438i5E+uYRVOhceCAm3xTmdWrQsTE1XCf3tQFpd59EjlX437BZq+K2cTzeKNcXY+awUlGbU0LZi/767vgk8P9c5EjIC3++05HhrPnI9iyjlkZqRXYtS+o6weEsnrGydx8qn0/EVadzJuESkoLKrxSe+9pPoECvO3j6vg6yzZS3DQ==
Received: from AS8PR07MB7960.eurprd07.prod.outlook.com (2603:10a6:20b:396::20)
 by DU0PR07MB10599.eurprd07.prod.outlook.com (2603:10a6:10:5a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 14:55:28 +0000
Received: from AS8PR07MB7960.eurprd07.prod.outlook.com
 ([fe80::2c24:b25f:5c9b:6db6]) by AS8PR07MB7960.eurprd07.prod.outlook.com
 ([fe80::2c24:b25f:5c9b:6db6%4]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 14:55:28 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Erhard Furtner <erhard_f@mailbox.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Kees Cook <kees@kernel.org>, David Howells
	<dhowells@redhat.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
Thread-Topic: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
Thread-Index: AQHc183FD/n2tRSHf0iHVltRCWSTpbX2INMA
Date: Wed, 29 Apr 2026 14:55:28 +0000
Message-ID: <d8cbbe3b-7eb0-43c4-ada7-0730f7c05f69@cs-soprasteria.com>
References: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
In-Reply-To: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7960:EE_|DU0PR07MB10599:EE_
x-ms-office365-filtering-correlation-id: f098a49e-ca05-4bd8-16be-08dea5ff5a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 xE0WOA1MM7ebVjLCpiZy3A78Cx7EJ3JybLKB0r4d//IUmy0JDIkNb6G1pXo6lgxYC+9F3MuyWI9AlDeIBjUZYouk2QPgHle9FxmHtmanTUKbzOTqLiyQk1fduZF0358/z+pPJ7Y/hYJrytKelAZSK5TCITwt41fyiyeeLOfdjsnfg9qfkMKjYZYf4lD4DpqvvEcK/wNsJX8yG1ytwLNnrBenqC8Oi0d3mAZhAdym9UkvH7vDo6yJD4eOgY3WpzVYFGqrxO2/C8JbG9G/OS/rfHy0uRbtq/L/12gpfWCjtMQ3yIrzqPsQwKmjCtr8NOfeThcFBCxlemdz9lwjxWlZlrqSDmzQTcAJd01Ukzkb/XZ9w91QgKW0YWfSANjxSDAaplKawCgSy6rveCNcjfiz9TYfQufammMMnKszaYsDGf1lu96LjrTPM0QXxV3lSMh4N1keE7T+ddP71lsl9CEQNE84s+oXPfkUjTED6CS4vOg735emJBIk0uTTu1uFORCDCnTdktagz9q6nuMrP5Pne/Qwl3k7QaenemxYGjRynmUoriFnlmaumrjjge1XD0DjHkP9VyElQ7/MRyyZhm7n70FgSJ3wAH3eJtb59TgoiixEWBTv0YVh0R42WshoP9ZabRwCg7vpSbGdtA9MxVf3fHXAIwMC2om1mA04BArL8SvLY9RHo6UsEF2CTGx+HeYSxaOTex1E4tX5/vp8PoobLx8I63alPnfAyIBZw9+wPR2VyfOyM4sLW6epqK+jP3RlsaWW4+dptLRxFYayZKVQWmbvWjDGnqlwxbWh4Nklhis=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7960.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnJlanp4VW40S3NuLzRVbHlGQzMvNTJlVzFjWGRnMmpXZHZ6dVpxV3JPN1Z6?=
 =?utf-8?B?cVFzMXZmQ3FRN2VqY1UyL0puWGt4cFpzMml2YUpHYkVIMUZmUXFNdGdGT3Jt?=
 =?utf-8?B?YjJQOGlCNlBsSFpqZWgwOHFDNjk2d3puS2NqQUp0ZTFiZC9aSVJzNkF4ditC?=
 =?utf-8?B?WUVKMC9QRFg1MXl3MkJFMUJTOUxFNklrZm5kSTBuVDMxSEM2cEkxRklhNnE2?=
 =?utf-8?B?Q2VEUUFYWUpzUXVIVzVNM1RqR2JoNG1Hb29qVWE3SytqZFNNaTdTY0Y4Z2RW?=
 =?utf-8?B?bzdLTUxyK2xUYXNvcTU5SUhDaWl4OFVUTStQazBNaDdwY2NCdFFsZVFUb1B2?=
 =?utf-8?B?TkRuMVdMT21TOG5sWnkzUUordXVKQ0c5dTBVcUpKRng0TWl4MW0wd3ZLZXVw?=
 =?utf-8?B?MlFFT1BVUHhLZk9GMXFVbDB5SnlIZDFDRG1hS0FpNXBPMDNCc0lpR2wzeGFU?=
 =?utf-8?B?NzU5eUdCZHJ5ajJXb1hnZVRaTHlZWnl4Y0o1K216L2NRajVqNExra0JmY1Jh?=
 =?utf-8?B?Zkx2a21oaTJNdmdiLzhKNjg3VGdwTDIrTTBsOVRobHFlWTdjMlN2TzZVSzJv?=
 =?utf-8?B?R004bjh0YTdMUlZQUmVUS3Z6SnJDcGNlc1pid3U5dC9xS3Y2dTVjZHJaUnVo?=
 =?utf-8?B?VUFJdnFEdDhkbmJxNEJjeHJ1ZUdZeHZ3THJPRkVCYWFCcS9SNnBmb0VvMW9F?=
 =?utf-8?B?L0N5UkIxYU1lRityMFYrNTBqV3JFSGdXdEpNQWNocmhhVFFNODdZelc2Mmpz?=
 =?utf-8?B?ZGQxZ01ndnV5STRiOVhDb05DN2ErTldBanlrOXpyMEtOT2JTY2hzRkllMklD?=
 =?utf-8?B?N1BRNG9va1BuNzEwRkpMNkJPWk1nZnlOSnFrZTlkZnN0bEJFRnk0UHgzMU4r?=
 =?utf-8?B?bkZYdW1HaDJ2RFNzQ0Fodm5td3ZPMzBCeDZ6NG9BVmJCZ0tabXFZeStkMVhu?=
 =?utf-8?B?ZDVyZXExdFd5WGJ0eWcrU1l4WFMxR2N2YS9oZUZyMG1JbEQ4TElPSFhzN3Nr?=
 =?utf-8?B?Z2Q0VExWR2xpYUU5a2VoWkxaUDJHbUR5aVhYdzkzYlN4aVdmWFJpNlNRYlRY?=
 =?utf-8?B?M2l1a2dySDJQQURoQy9PQ0V6cUIwd2NQMlY0SUtQVFVITk9vMDVSRFlhUnB0?=
 =?utf-8?B?emtOR2tIQTY2Vy8wS0VvVCtCcEt4SWlUSlk5VndVeGduU1c2azhBaXMyd0dt?=
 =?utf-8?B?RUN2LzVnQjRhWkdzN2hGTlJCNXFXci9kSk9iUFNsUENkUEtGa3poY05teEd4?=
 =?utf-8?B?Z0prYkQrL1lUTFd3ODhhVkRsZzBuZ2NkaER3bmZ6NkVrcmJBdDNtNHlia3lZ?=
 =?utf-8?B?VC8zWWFOTmQ0Uy92cS9FbVhmK004dlFTWk5HZHdoNi9SZ2lCM0xPY0daUFhs?=
 =?utf-8?B?NUFLbkFhSnNLWW9hRE1LRFhVb1dsekZ5bzIwQ3FTYjJ6eUZlMVB4YVJPdWFh?=
 =?utf-8?B?d2lCZEIwRWcwU0NGN0V3ZXorS1NHa1dSdnF1ZW14b0U0Qm9OOWlJTDNWKzU3?=
 =?utf-8?B?R1JJakYrTk5WOFpYcXF1c2EyS00wczd0bTlTRlJUTVN0bmhselJPbGYvdGtx?=
 =?utf-8?B?d3V6RWVrSXJ4a2ZFK0lOVE9oeHovYlZhYkZ4M3lnM1dqZElSYkQ0SUcwMUpa?=
 =?utf-8?B?UitjeGdNRWFrK0VHVERzKzB1VzRuOUpHMDNwbjhOZ1ZqdDhiU25kZjIyQlh4?=
 =?utf-8?B?eXpTNEZ5QnlLZHViWUdKZ0RBcUQ5MG13TFFpWTlDRENjdFBSVFJNRlRuYzlH?=
 =?utf-8?B?OWhVbDkwMk1rZzVBTk9ZYkFGVzI4QkcrSFpxUGFoQUFWbnQ2M0cvZ0l2Szhx?=
 =?utf-8?B?NGpwRGlMVk1CUTNqMTRxenBhZGw3cGIwTXpTellYMWw3TUJIZ3ZNWVRwYmpq?=
 =?utf-8?B?dUZaQkhIQncxeVN2ZEFjVnd5TzFGR29NZUJUbkZRcmlsWmhLc1R4YkplcU5H?=
 =?utf-8?B?OVpGYjVBK3BjcTJ5cUJCbzBLaTB1UlhmYmxTalpsUzFHSG5UQ0o4MzN0MUU4?=
 =?utf-8?B?czRsY1RnNEZMdjg4YnFmL2pnUHd4cDg0T21DTXhBUm9hdWZDb091QkVwR1Rh?=
 =?utf-8?B?RmRMeWFkQjB5YU9nNHQ5WjJGRHBLc2pha3dUSG45NzVudm1UNm8xdW1SdkhO?=
 =?utf-8?B?UWs5c1R5bk16U3FiUkk3Rkp5Y3VlRVVBSDl0czNlaUxhS2c1dFpqdXBPY3oz?=
 =?utf-8?B?VGJseUNrOE1LT0hYVEw5VE90ZHF3OEpVcVpMTUhxZVRpcnRnajdxczFxZVUr?=
 =?utf-8?B?dkZXalY0QUFnbXJYRWcwOGJkVjBPQ1loTGlGUWc2QkZieUR5d2ZYc2NpNDZF?=
 =?utf-8?B?UjFtM24zQWwyTnpId2grbTZITHBwbGRqMFZjQ1lYSDlRSUVnVklXZXRDYmla?=
 =?utf-8?Q?8MoWNt/kv8IDyyvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5681923ACB137A4C8EEB66DC39CC8D21@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
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
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7960.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f098a49e-ca05-4bd8-16be-08dea5ff5a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 14:55:28.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3hZ4Kq3D3sZ6nmZMuaChWY8OGhIm+O6pTJnyrXEOStpAt++Aam/EAj4ZwF20szxo9TbSyhBohO9y1OnokNdJx1ZnJwatbxBe/YbsTsrkZPV1ZTn+TywSFnZqp1ftZUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10599
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AS8PR07MB7960.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DU0PR07MB10599.eurprd07.prod.outlook.com

DQoNCkxlIDI5LzA0LzIwMjYgw6AgMTM6NDUsIEVyaGFyZCBGdXJ0bmVyIGEgw6ljcml0wqA6DQo+
IEdyZWV0aW5ncyENCj4gDQo+IEdldHRpbmcgdGhpcyBvbiBteSBHNCBEUCBvbiBrZXJuZWwgdjcu
MC4yIGFuZCB2Ny4xLXJjMSB2aWEgJ21vZHByb2JlIC12IA0KPiBrdW5pdF9pb3ZfaXRlcic6DQo+
IA0KPiBbLi4uXQ0KPiBLVEFQIHZlcnNpb24gMQ0KPiAgwqAxLi4xDQo+ICDCoMKgwqDCoCBLVEFQ
IHZlcnNpb24gMQ0KPiAgwqDCoMKgwqAgIyBTdWJ0ZXN0OiBpb3ZfaXRlcg0KPiAgwqDCoMKgwqAg
IyBtb2R1bGU6IGt1bml0X2lvdl9pdGVyDQo+ICDCoMKgwqDCoCAxLi4xMg0KPiAgwqDCoMKgwqAg
IyBpb3Zfa3VuaXRfY29weV90b19rdmVjOiBBU1NFUlRJT04gRkFJTEVEIGF0IGxpYi90ZXN0cy8g
DQo+IGt1bml0X2lvdl9pdGVyLmM6NjMNCj4gIMKgwqDCoMKgIEV4cGVjdGVkIGdvdCA9PSBucGFn
ZXMsIGJ1dA0KPiAgwqDCoMKgwqDCoMKgwqDCoCBnb3QgPT0gMSAoMHgxKQ0KPiAgwqDCoMKgwqDC
oMKgwqDCoCBucGFnZXMgPT0gMjU2ICgweDEwMCkNCj4gIMKgwqDCoMKgIG5vdCBvayAxIGlvdl9r
dW5pdF9jb3B5X3RvX2t2ZWMNCg0KVGhpcyBoYXBwZW5zIGluIGFsbG9jX3BhZ2VzX2J1bGtfbm9w
cm9mKCksIGR1ZSB0bw0KDQoJcGNwID0gcGNwX3NwaW5fdHJ5bG9jayh6b25lLT5wZXJfY3B1X3Bh
Z2VzZXQpOw0KCWlmICghcGNwKQ0KCQlnb3RvIGZhaWxlZDsNCg0KQmVjYXVzZToNCg0KI2lmZGVm
IENPTkZJR19TTVANClsuLi5dDQovKg0KICAqIE9uIENPTkZJR19TTVA9biB0aGUgVVAgaW1wbGVt
ZW50YXRpb24gb2Ygc3Bpbl90cnlsb2NrKCkgbmV2ZXIgZmFpbHMgDQphbmQgdGh1cw0KICAqIGlz
IG5vdCBjb21wYXRpYmxlIHdpdGggb3VyIGxvY2tpbmcgc2NoZW1lLiBIb3dldmVyIHdlIGRvIG5v
dCBuZWVkIA0KcGNwIGZvcg0KICAqIHNjYWxhYmlsaXR5IGluIHRoZSBmaXJzdCBwbGFjZSwgc28g
anVzdCBtYWtlIGFsbCB0aGUgdHJ5bG9ja3MgZmFpbCANCmFuZCB0YWtlDQogICogdGhlIHNsb3cg
cGF0aCB1bmNvbmRpdGlvbmFsbHkuDQogICovDQojZWxzZQ0KI2RlZmluZSBwY3Bfc3Bpbl90cnls
b2NrKHB0cikJCVwNCgkJTlVMTA0KDQoNClNvIGFwcGFyZW50bHkgaXQgaXMgZXhwZWN0ZWQgdGhh
dCBhbGxvY19wYWdlc19idWxrKCkgcmV0dXJucyAxIG9uIG5vbi1TTVAuDQoNCkNocmlzdG9waGUN
Cg0KPiAgwqDCoMKgwqAgIyBpb3Zfa3VuaXRfY29weV9mcm9tX2t2ZWM6IEFTU0VSVElPTiBGQUlM
RUQgYXQgbGliL3Rlc3RzLyANCj4ga3VuaXRfaW92X2l0ZXIuYzo2Mw0KPiAgwqDCoMKgwqAgRXhw
ZWN0ZWQgZ290ID09IG5wYWdlcywgYnV0DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGdvdCA9PSAxICgw
eDEpDQo+ICDCoMKgwqDCoMKgwqDCoMKgIG5wYWdlcyA9PSAyNTYgKDB4MTAwKQ0KPiAgwqDCoMKg
wqAgbm90IG9rIDIgaW92X2t1bml0X2NvcHlfZnJvbV9rdmVjDQo+ICDCoMKgwqDCoCAjIGlvdl9r
dW5pdF9jb3B5X3RvX2J2ZWM6IEFTU0VSVElPTiBGQUlMRUQgYXQgbGliL3Rlc3RzLyANCj4ga3Vu
aXRfaW92X2l0ZXIuYzo2Mw0KPiAgwqDCoMKgwqAgRXhwZWN0ZWQgZ290ID09IG5wYWdlcywgYnV0
DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGdvdCA9PSAxICgweDEpDQo+ICDCoMKgwqDCoMKgwqDCoMKg
IG5wYWdlcyA9PSAyNTYgKDB4MTAwKQ0KPiAgwqDCoMKgwqAgbm90IG9rIDMgaW92X2t1bml0X2Nv
cHlfdG9fYnZlYw0KPiAgwqDCoMKgwqAgIyBpb3Zfa3VuaXRfY29weV9mcm9tX2J2ZWM6IEFTU0VS
VElPTiBGQUlMRUQgYXQgbGliL3Rlc3RzLyANCj4ga3VuaXRfaW92X2l0ZXIuYzo2Mw0KPiAgwqDC
oMKgwqAgRXhwZWN0ZWQgZ290ID09IG5wYWdlcywgYnV0DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGdv
dCA9PSAxICgweDEpDQo+ICDCoMKgwqDCoMKgwqDCoMKgIG5wYWdlcyA9PSAyNTYgKDB4MTAwKQ0K
PiAgwqDCoMKgwqAgbm90IG9rIDQgaW92X2t1bml0X2NvcHlfZnJvbV9idmVjDQo+ICDCoMKgwqDC
oCAjIGlvdl9rdW5pdF9jb3B5X3RvX2ZvbGlvcTogQVNTRVJUSU9OIEZBSUxFRCBhdCBsaWIvdGVz
dHMvIA0KPiBrdW5pdF9pb3ZfaXRlci5jOjYzDQo+ICDCoMKgwqDCoCBFeHBlY3RlZCBnb3QgPT0g
bnBhZ2VzLCBidXQNCj4gIMKgwqDCoMKgwqDCoMKgwqAgZ290ID09IDEgKDB4MSkNCj4gIMKgwqDC
oMKgwqDCoMKgwqAgbnBhZ2VzID09IDI1NiAoMHgxMDApDQo+ICDCoMKgwqDCoCBub3Qgb2sgNSBp
b3Zfa3VuaXRfY29weV90b19mb2xpb3ENCj4gIMKgwqDCoMKgICMgaW92X2t1bml0X2NvcHlfZnJv
bV9mb2xpb3E6IEFTU0VSVElPTiBGQUlMRUQgYXQgbGliL3Rlc3RzLyANCj4ga3VuaXRfaW92X2l0
ZXIuYzo2Mw0KPiAgwqDCoMKgwqAgRXhwZWN0ZWQgZ290ID09IG5wYWdlcywgYnV0DQo+ICDCoMKg
wqDCoMKgwqDCoMKgIGdvdCA9PSAxICgweDEpDQo+ICDCoMKgwqDCoMKgwqDCoMKgIG5wYWdlcyA9
PSAyNTYgKDB4MTAwKQ0KPiAgwqDCoMKgwqAgbm90IG9rIDYgaW92X2t1bml0X2NvcHlfZnJvbV9m
b2xpb3ENCj4gIMKgwqDCoMKgICMgaW92X2t1bml0X2NvcHlfdG9feGFycmF5OiBBU1NFUlRJT04g
RkFJTEVEIGF0IGxpYi90ZXN0cy8gDQo+IGt1bml0X2lvdl9pdGVyLmM6NjMNCj4gIMKgwqDCoMKg
IEV4cGVjdGVkIGdvdCA9PSBucGFnZXMsIGJ1dA0KPiAgwqDCoMKgwqDCoMKgwqDCoCBnb3QgPT0g
MSAoMHgxKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoCBucGFnZXMgPT0gMjU2ICgweDEwMCkNCj4gIMKg
wqDCoMKgIG5vdCBvayA3IGlvdl9rdW5pdF9jb3B5X3RvX3hhcnJheQ0KPiAgwqDCoMKgwqAgIyBp
b3Zfa3VuaXRfY29weV9mcm9tX3hhcnJheTogQVNTRVJUSU9OIEZBSUxFRCBhdCBsaWIvdGVzdHMv
IA0KPiBrdW5pdF9pb3ZfaXRlci5jOjYzDQo+ICDCoMKgwqDCoCBFeHBlY3RlZCBnb3QgPT0gbnBh
Z2VzLCBidXQNCj4gIMKgwqDCoMKgwqDCoMKgwqAgZ290ID09IDEgKDB4MSkNCj4gIMKgwqDCoMKg
wqDCoMKgwqAgbnBhZ2VzID09IDI1NiAoMHgxMDApDQo+ICDCoMKgwqDCoCBub3Qgb2sgOCBpb3Zf
a3VuaXRfY29weV9mcm9tX3hhcnJheQ0KPiAgwqDCoMKgwqAgIyBpb3Zfa3VuaXRfZXh0cmFjdF9w
YWdlc19rdmVjOiBBU1NFUlRJT04gRkFJTEVEIGF0IGxpYi90ZXN0cy8gDQo+IGt1bml0X2lvdl9p
dGVyLmM6NjMNCj4gIMKgwqDCoMKgIEV4cGVjdGVkIGdvdCA9PSBucGFnZXMsIGJ1dA0KPiAgwqDC
oMKgwqDCoMKgwqDCoCBnb3QgPT0gMSAoMHgxKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoCBucGFnZXMg
PT0gMjU2ICgweDEwMCkNCj4gIMKgwqDCoMKgIG5vdCBvayA5IGlvdl9rdW5pdF9leHRyYWN0X3Bh
Z2VzX2t2ZWMNCj4gIMKgwqDCoMKgICMgaW92X2t1bml0X2V4dHJhY3RfcGFnZXNfYnZlYzogQVNT
RVJUSU9OIEZBSUxFRCBhdCBsaWIvdGVzdHMvIA0KPiBrdW5pdF9pb3ZfaXRlci5jOjYzDQo+ICDC
oMKgwqDCoCBFeHBlY3RlZCBnb3QgPT0gbnBhZ2VzLCBidXQNCj4gIMKgwqDCoMKgwqDCoMKgwqAg
Z290ID09IDEgKDB4MSkNCj4gIMKgwqDCoMKgwqDCoMKgwqAgbnBhZ2VzID09IDI1NiAoMHgxMDAp
DQo+ICDCoMKgwqDCoCBub3Qgb2sgMTAgaW92X2t1bml0X2V4dHJhY3RfcGFnZXNfYnZlYw0KPiAg
wqDCoMKgwqAgIyBpb3Zfa3VuaXRfZXh0cmFjdF9wYWdlc19mb2xpb3E6IEFTU0VSVElPTiBGQUlM
RUQgYXQgbGliL3Rlc3RzLyANCj4ga3VuaXRfaW92X2l0ZXIuYzo2Mw0KPiAgwqDCoMKgwqAgRXhw
ZWN0ZWQgZ290ID09IG5wYWdlcywgYnV0DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGdvdCA9PSAxICgw
eDEpDQo+ICDCoMKgwqDCoMKgwqDCoMKgIG5wYWdlcyA9PSAyNTYgKDB4MTAwKQ0KPiAgwqDCoMKg
wqAgbm90IG9rIDExIGlvdl9rdW5pdF9leHRyYWN0X3BhZ2VzX2ZvbGlvcQ0KPiAgwqDCoMKgwqAg
IyBpb3Zfa3VuaXRfZXh0cmFjdF9wYWdlc194YXJyYXk6IEFTU0VSVElPTiBGQUlMRUQgYXQgbGli
L3Rlc3RzLyANCj4ga3VuaXRfaW92X2l0ZXIuYzo2Mw0KPiAgwqDCoMKgwqAgRXhwZWN0ZWQgZ290
ID09IG5wYWdlcywgYnV0DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGdvdCA9PSAxICgweDEpDQo+ICDC
oMKgwqDCoMKgwqDCoMKgIG5wYWdlcyA9PSAyNTYgKDB4MTAwKQ0KPiAgwqDCoMKgwqAgbm90IG9r
IDEyIGlvdl9rdW5pdF9leHRyYWN0X3BhZ2VzX3hhcnJheQ0KPiAgwqAjIGlvdl9pdGVyOiBwYXNz
OjAgZmFpbDoxMiBza2lwOjAgdG90YWw6MTINCj4gIMKgIyBUb3RhbHM6IHBhc3M6MCBmYWlsOjEy
IHNraXA6MCB0b3RhbDoxMg0KPiAgwqBub3Qgb2sgMSBpb3ZfaXRlcg0KPiANCj4gDQo+IFN1cHBv
c2UgdGhpcyBtYXkgYmUgYSBwcGMvQkUgc3BlY2lmaWMgdGVzdCBmYWlsdXJlIGFzIEkgZG9uJ3Qg
Z2V0IGl0IG9uIA0KPiBteSBUaGlua3BhZCBUNjAgKHg4NikuDQo+IA0KPiBGdWxsIGRtZXNnIGFu
ZCBrZXJuZWwgLmNvbmZpZyBhdmFpbGFibGUgb24gcmVxdWVzdC4NCj4gDQo+IEdyZWV0aW5ncywN
Cj4gRXJoYXJkDQo+IA0KDQo=

