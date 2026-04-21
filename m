Return-Path: <linuxppc-dev+bounces-19899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCD6F8FA94
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 16:00:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Rrv2qG7z3013;
	Wed, 22 Apr 2026 02:00:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776787215;
	cv=pass; b=K2oibhX2BdhLKHOV4QA3FZWSsc27PQ1Iz+3PaK4I//ZbSPRfmGulBAOuw/9/EDRJPt0XTjm/WEHcTXMoDOsPc/YJnHXgRuLjhFniBPciTE4shYOZaSSxOhu9BnLwvnwBVSlCsb4N8BkmOIT9DNJoCNX0cTuh6/X8quRjHtYqkZnEVrnQpVHL+/ftkr1lYZiO9SMpt5mC/D4cZC1B9Q+XKKb1LYrWv3e2DJ4rQXhBzJ6YSOWJ6bUAxldECaF8Ly4SvC+cP7KE9cKKN71JJpLLySN/VBa7IbVBkRNtFg+4nUHF5XftJwzBY6NRi+zVP7WOpJkHAGtACMuSE4guKRKkqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776787215; c=relaxed/relaxed;
	bh=JL/0X+jfU6NKx8e19th/0lVA5aC3pEyJMXQwNinWGt0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YDO4eYbU7jRHueWW12tBiwHCQ1IWhu/qGDrlWU+h/uJITokOPgKYzMLG56ZMqqk72vO2ayZgdFV65GV7dazfAnmfDMVhzu8njNSvk6bSEjJ2mBGDMm4d7LynrP21Mvkblr0MwQfuJRJ88JML1zb4K0OJ6NPOrwYJMPPid8wgmg9KrsZaoTD4ECv6FObhNohvnmPZFuBC2EwD2YnaptpG/+gPefR7IGLxYacW0JrqM6CCLeCwS03dK488ggp0Q9Wmys035ePx/E7H6lwYcGyr6A3aeLVQuMHki90g1lzWKceuOU6hptHPwHzEa90qkm5oEF4uCiCjuVgbf8UYD94uJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=muCK8fsI; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=muCK8fsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Rrt34ZGz300V
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 02:00:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyTmfYZIkwopWRHO7HjR5fntsLCah21Ph6gIqeQM5nCgGL2R5xE1FhyGOLEzZ1Zfzdit8wT4HMOqO5MCZjY/xd9To8r9hH4wgiSljMtoQU5PNIf5FO2XrIA/+KtL/Ai9MjIqmmTaVrXh2eLOEBuN8IcvejimMhAaJWSjV4IduZqlTvosvBqMrIT2sLdttbiX+2ToNj/9PrIURSSOIFaNmMVzgBcpxUxoKJUjCxTscaI56DZhOr2d/M7p+/6ic9EEYr3Jyn70yHfGi45tyO5904O+sIMRYl/EhwmVJXA0vDwJnPLfsSEDsVpu7kHnghD0VlznAb7X89obeKKoMCX3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL/0X+jfU6NKx8e19th/0lVA5aC3pEyJMXQwNinWGt0=;
 b=BMgxYhOTvX4t3vUZtWPDJX+dyDJOoX1CZIEW0e7Sz+sxs3W0t+rqCHNk00sHLhtUCGIJcI9fULvica0b1JQTRUUAhTVw80ClqERYifX99ZmPuG2IEy1klmkPgoydQ30ZTcbU3NP5lbIk6Nx1r7QvLYISunbAXew0PPJCtyAn1H4xVm/Ji9Pb4jHLiWXyKmFhecjle1nZK2NsgGzde373L/ZNdpOcy7VaYASRo3id/67WRmpSPPDtSt1OdyMxfVs/JoUYVE+iORDDIKfNMoctB7XJdLlZDqSFPQexEmDoDjm8Uq7i5B7irmnSdf+XTvtOwCf3RLapBunmmt+iz3DLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL/0X+jfU6NKx8e19th/0lVA5aC3pEyJMXQwNinWGt0=;
 b=muCK8fsIAPEEl3Ny4fPrt1mjHRN05o3mzRmUaVgKISmg7tJy9AS6HaqlhZaA4zbnOkbhgkRt324CqhmbjMWphruZ/EEBth1YfIqeYbZ0asSBDtnCFOLYvDU62elqbVSh9SCrxnzx7L/oVBchQ3lSyJjH+3Xf9BUEjwPWKFWba98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:59:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:59:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:59:49 +0100
Message-Id: <DHYYHQLE0SKH.2LHMNCLK7BITE@garyguo.net>
Cc: "Link Mauve" <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V11 3/4] rust: Add PowerPC support
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-4-mkchauras@gmail.com>
In-Reply-To: <20260417152253.2312961-4-mkchauras@gmail.com>
X-ClientProxiedBy: LO4P302CA0036.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f472706-8794-454c-e593-08de9fbf04f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	BllskEvKXLDr+guS3yNt4shvSafQe5n686SGmEJevIPv7B+Y/Cu6Ed2agN4jOCCMckVve3uD6XJbGjqpgOLyjwFqDmIRn8cP+EbcqRSIVTiDb+XUMcnvdDZ8ieDCP55JkWAR5CaaLBvar+DUI+o2AcgvPJAZk6+CK8g8Y/9J5b6wOVz0qnwIkZRLLwFYud/2aH4POD/cqFC4Yhom7xR/swrheckPwoNB32/PIWlxUHvfHfT+EGYYH3hFNHvUr0phS63OZSc0dN5noIkomFrZouJYBd9OvLng8TlWmgglfBi5VghS8pYHC8IR4HlYyJ9yhyExpBtBXhyHFiK0+wq2M88bbAxmkoeqz2cxktqwpwBhfSXa0NJ5gCLLZXViw0Vq2yfg7XJRA91c4Hs8eJFTIeSbEpg4yWBRszUMrFNU4AV2/I6Ghr2bMhYPpxDQJjuqQ9hyWAq+P7kh6O6fp1skenR0u9eqz3CB2gVeqgX4KTX3B9Pr6bgU3rqfDBQceVorRZptcsiiP43FMrBmf/KD3h2PVrfZofRfU527bCbvOymW3G5osdvz4CvCHsA5QchjnsJDZdDTurdJxki0Rk41vs6FfcJ7l6eH6Zc1UayG2tLTrI8ZapCeb8bv/Tb76McCO9UuCmVlpPsq5HmnyfPW0N50MB4Yd+B9oSnV6zYa0RB91+wjCWZHeVm1gjFb57MALdGSkTAUTRkknV7Uc5+nx4Vs8MpLKb5onV90/eBZEbhoShLc1ODnV5wMXsulYehO3d35YybrYGVNYNgGZtnDFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZHeCt0NGF3L3JCckc4VGpWMjdsa1daeFh1ZlBOdk9yNmljQXZ6ZHVuQVpn?=
 =?utf-8?B?M0hnMUxSaURwOFFjcWNONW0rcUJxeVJKQktxb3FoVHVWTVlONWR6dm1EL0Zi?=
 =?utf-8?B?bjBJQjVNbU9Ka1RxUDUrdjhXdkhzQmtoSnRTNFlzek5yRFRmdDNIMGdLRU5T?=
 =?utf-8?B?TVFIYlJ3ek0vTUhJSVRiRldZMC9MenFnemx1L1FMeStCODhINTF2andQMlRK?=
 =?utf-8?B?MUw5dTE5eXJmWHZ3R09MaVUwTlE1NGdWTFJYZUFRWEdxTThlb2RrQXB1cHE3?=
 =?utf-8?B?aFFqTlpzak1DanhpZmF2RWtYby9NbitMUTQzM290ZXgrYmJ4d3RjMUppRmtq?=
 =?utf-8?B?aG1EZ2I3YkZIQ3NRNTl3UTAzVGdvdnBZZVRTUWtpaHpKYU1tRkxMSWNvYmp4?=
 =?utf-8?B?QndhLzduTEY2WFVMNU1ZMmR5TmQzS1FzUVNISEJoL0RLVyt5YXQ0c3ZZMDdw?=
 =?utf-8?B?Mnl2aGdZZlpmT0d0SVg4MXlIaXR5TE9hTGhnNVZUUnFBV1pZRmNBR1dUNlpQ?=
 =?utf-8?B?eHFuU09BOW15bEhpMTdvc2ZiTXQwdTRjTXo1cjNoQ1ZVdTBSbWpsOHBLejlq?=
 =?utf-8?B?c2pvS0M4V0J2bFZ1ZzZVNjVyVC9YWkFRcHEzSEkzTkVGTnp1NTF2YXZreXlu?=
 =?utf-8?B?WmxaWGt3NGRDdUdLcXVaVnJkQVRkL0ZPMlBVUVFIQlVtMXlET0xKcEIwSjJH?=
 =?utf-8?B?ZXJQc0VUSmFqTWI3S0dZWDhzOWQ3T2RCTXdvRWFnUjduOC9OWk45MW5OVURY?=
 =?utf-8?B?OWlISFlERE1iUjRnUEhYaWVzeTlYSGgzN2lvcFhHNEdnVEJFTUMwZmh1Rm0z?=
 =?utf-8?B?RGVNZjg4aE1obDJaY24xV0FwWUcrMW9oUSsvV3B2OWxGUnE3cDhUV05QY0la?=
 =?utf-8?B?UTlGU1JZM3FiZVhYMWZGWGVhekt0OTRmL01mZFRST0I4UmErU0JCRkJHbDh5?=
 =?utf-8?B?dlYvTlJBQ21UN0hTeEdNN2p2ZWR3ZUtJUklaNFdJRVBlQ0I5N3E4RzZ1TzNI?=
 =?utf-8?B?UDNnejdmK0Q4eVNDU3M2N1YrNi8yMW9BZDliYjIzSlZ6VnFGNUMraUN4SUtW?=
 =?utf-8?B?U0dPWVJNT3ZSK0lHemYvZ2RQM2xYUEU1STVxN3YyejM1eEF0Y2Ixc1BueENU?=
 =?utf-8?B?bGlvalBEZmRWOXMxaFEzMjhHTUh5cSszL2pjZHY1U0N6a2xaREhmMDU5NE9w?=
 =?utf-8?B?bGlQSnl3c2FIUWdsazZqd1o5OU5hRFdYUFNVS1F4UFZrZGRweTJwOTVXMllp?=
 =?utf-8?B?cUxPaGIxbktsMEdzQXBEbXdGbmdSZVVDWllVQjJMakFHcWhZamQ0amNINFVq?=
 =?utf-8?B?VURWc3JacFU2Vnc4NFlhRHVoMFFxRm5YMHArSUFKdnAzS28vbTkzb2pZcERw?=
 =?utf-8?B?STZqREcyOVdYaUo3Mk8wbURGb0xwN2Zmc2hTZ0xlZC9NdXk4MjJHb3JJcXE1?=
 =?utf-8?B?cEtJeXRaWWc5RFh0RWZnWE5YVEJzYVFIRVY4STZxb293bXo3ZEpYaDZiTlZv?=
 =?utf-8?B?MWxYRXJ6T0U4WlQ4MWY4VXlrU1VjUFJUVU1wZWFHL0VoT3AybVVaK1luQ3RS?=
 =?utf-8?B?SmZYaDNwMXJMQ1RialNNZlcybUlCeG9TR3dQK0JsWVJqWXI5SFZPUUNzcUJC?=
 =?utf-8?B?SmVENDJtVDFFQTJuMFJ2VHlKbmc5ZWt0QnFZK3NoU2RSNHBxV2VQVE1PQ1hD?=
 =?utf-8?B?TUkyRnFIRlZnUUFmNTdnRmpQemZRLy9ua05HVlcvS0Z4cUh5K2Y1MXliY2kw?=
 =?utf-8?B?MndvWGIvUVFnK3ZwMDNjdGlBWnREQzlIUFQ5anFpL3ZBRnhiZmJhZlFEL1E2?=
 =?utf-8?B?U2VmdFc5QVRtMWxEWUNZTmw5cEovYU9hckdpbWtVSDJteXExTURxTG1YMDBv?=
 =?utf-8?B?aFJTRXcrQTc1MC9Yam5yQzFqTHkxVkpLYWpiamM1My9aUHlwOEMrVisyVnVi?=
 =?utf-8?B?RWtWejlGU2F2aU1HelRXTXFJdlRuN1UxQkl0N0tIdWd1UmlYb3N2T1ZpSHRM?=
 =?utf-8?B?ZHFJT1hCQzhnd0h6L2VjZlZWNithWGVPVXA5MC92RE1CRTBiMjhDNHBnY3dm?=
 =?utf-8?B?ZU5RdFBMZlhUTzNrM1hLV1laU04rek1QR0t1Z1Z6SmIzejhDclhxODRpQXEz?=
 =?utf-8?B?bW5oRWtnUVg2WUNXclJXYkIwZjJQc1dqTjNmSFAzYTcrVUhnQzdXWTNuSEQw?=
 =?utf-8?B?Z3VBRmVIc29abzhmZDMrMTdVSUhYTTBJREREeWF2Y1JzMXdCWGwzQzU5dDZo?=
 =?utf-8?B?eEdmM0N5ZGJSWlBOTFQ2S2JRRUZDMzgxZGFEQTJDWTI2VS9oQWdDbnIyT3Jt?=
 =?utf-8?B?bXY0cGhEbmFTdHNhY0FxN295WmxnVXFLNmx4NzR1bXQ2NmhUdlE0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f472706-8794-454c-e593-08de9fbf04f3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:59:50.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB0R8+LZ0RyXYcpN3U2ZVhAUWjm2l0mFyFw3H/tanKSfOvrYpsD7sqNnd9FlYIk6BKZ19v/H18kxNWz0mvWiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8484

On Fri Apr 17, 2026 at 4:22 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> From: Link Mauve <linkmauve@linkmauve.fr>
>=20
> For now only Big Endian 32-bit PowerPC is supported, as that is the only
> hardware I have.  This has been tested on the Nintendo Wii so far, but I
> plan on also using it on the GameCube, Wii U and Apple G4.
>=20
> These changes aren=E2=80=99t the only ones required to get the kernel to =
compile
> and link on PowerPC, libcore will also have to be changed to not use
> integer division to format u64, u128 and core::time::Duration, otherwise
> __udivdi3() and __umoddi3() will have to be added.  I have tested this
> change by replacing the three implementations with unimplemented!() and
> it linked just fine.
>=20
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  arch/powerpc/Kconfig  | 1 +
>  arch/powerpc/Makefile | 2 ++
>  rust/Makefile         | 4 +++-
>  3 files changed, 6 insertions(+), 1 deletion(-)


