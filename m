Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFA606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ihBibWjc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLr4R541Sz2xqr;
	Sat, 07 Nov 2026 07:14:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793996071;
	cv=pass; b=WfGSf0oVX11OjclONPKW5zfqXsmI9XuAI8qSMeVJrsootbUz+pdpZDyUJew8gAyaD6nNeDQQsbXqbDboKPLYaz++dJTtAHtcTpQ/xp10LwiY1msnI2Xf9pjDuuhXLJurjuhkB7NRMLrIY36WKPDlYVRjKVihT3lLudrRBSv8rVBhm7I7jz3ITSMoXuIL2RdmvREhv9z1BXucEgyH5yq/hOKSmeROXG9TZcfzoED2SDHrL+D4c9d9xXFPD7KXbvGlmT4tEuGF2IzpGGRl87D94JJ0TaC94GV10Sq7EfM1OZe5ZqqiXZfQ64kkJXttEwI3Us5gpGBTzDRn55EjtGM1Mg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793996071; c=relaxed/relaxed;
	bh=N7I+FBvixRotr0i5qkin6qnKCxby4uDzkhCKlYNU4Bg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Te2BI7MJ9Ly0NJpaMyEtffYA8aMMOWz2DpZeF3JISymiccpiWFykDf3M4K5SOinACjieRHXsQ3t4mwQCwlq9sLRraTNpO3jxBJNkO81VQuNPrMQSzmuozyg7Deet16pCDna+FXV5N9Ucj95w2AAMluCN3uEFkC7yIWnCVPpdZtbits2DTQfXWaIm34aGf0XK42Pd+0XseFcEIioetR7QZVBY/fmkpggEcFmNLjwKAdM3P1hutb9HcDnwojaTe3PDN/6rq+a7W54ecUGAU66akVIpMNxalUbP6TgRgKaZB1JLOiHvtMzZTOohhoO2SNhtlPtB4WG/x7K8YqSN7kG8Cg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ihBibWjc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ihBibWjc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLr4Q5chdz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 07:14:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqUYMIvHOK3qsdl6Wknc22Pwaot7Z2Q9IcJLwTok39kVL9JaCMYmUvG4FJ6IsQtMu3dd2BiT7/FA9GhzIZRhwO5yKpY8oIqocl7jHXoh2q8rAhNE3XV+F4saEkugtMw4bttyLlhD3mFWQsBm4Onj49vhSYd9Ytgjop6aLNuEaCnuDeP6C0OTvpMLLKwW1ZG7/LYTaLF8FvltnG376sBvqlzcIqd+4Bh+NJgoiKSXFwgNplaQ5djN6j3btpocIm9KJuAE5XaSW4nFNXgrZjeFHodHFuAcQyh3aSLfiAjhEkDAqnsvJGZOXW86k2E0/xOzEm/JCjIz50ai/aNRdshTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7I+FBvixRotr0i5qkin6qnKCxby4uDzkhCKlYNU4Bg=;
 b=LIgu64wCZhmlt+zofOaMwuaLs5rAlh17fETTcruRW7t/KBihFq8KaSP9si78swAULd81MA0Z0JOirX4s4NJPW/8e0v3dNxcrGtNCSBcFUsciMRJ8uAKln5TnXKZIGw3hQrfHWuRCZNXWheqHknRfMm3EziEu55LZCMv4a92FE+wDH6y5WU/P/yR7E/XmPF37WFm49Xj+YoHazjogH11Eniuro2Xk1NQSAlPDfFEmBUPzvfAYPJhl8qzsrzjlnH+e2nJxRtjvzPWwEstDIrtRK8eR3UcwT93aZNG0F3lL9U8xqPIiSI6ws+X1zUArHzuh9BVWMWlfmFNP0+Yu89yuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7I+FBvixRotr0i5qkin6qnKCxby4uDzkhCKlYNU4Bg=;
 b=ihBibWjc76vnEGItLMEUbKblBZHCWjKqv6KabMiKx+kzbBhZY0KB4NVDYDz7PoAH1LL0/N0HGEVEujDNrjXMeXXz/OSypf2TceHCfoCEuCW8m19Y8ssxV7YZY6Mjde2tzonpqIbcSo8o+dH0G95zh669ga1aMsezi0ahmXU4tjxopvRbH1w+c2qfI5NxkMWUn6MP9XxWJooYMDvTzRW+ZlwuoJ8ioTRoe1xiF572Htyx53brMxBEX2IjsN5zJlpsmkZR4HgmFbSwK6w8C74zy1I4xAf7wbocX+M91sSOKUNUfo7RUV02cOXYt7UEOTVwCvxd3QhTgkxpD2wTNAeHQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 20:14:06 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:14:06 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 06 Nov 2026 15:13:45 -0500
Subject: [PATCH 1/4] ASoC: apple: mca: Use dmaengine_get_dma_device()
 instead of chan->device->dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-dma_sound_cleanup-v1-1-5eb8a7b81e87@nxp.com>
References: <20261106-dma_sound_cleanup-v1-0-5eb8a7b81e87@nxp.com>
In-Reply-To: <20261106-dma_sound_cleanup-v1-0-5eb8a7b81e87@nxp.com>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Sen Wang <sen@ti.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-renesas-soc@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793996035; l=1157;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Aa4+hHu/Fxm9AjSOelQ6aXezU5ChpCT9C6rcCXvOSzk=;
 b=wtWksXEiBu7LXXQVFQYhHyu/h/nfACnvPG2Djdva8JU2sgskLDfz7E9gAN/XFEEBJiQhxBlNN
 ftYlR8YPYgJBeSzjVIvyJVmST4V7bKi4SNlSEC1CykNFVbCUG8eNvN+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ae6d74-768d-4753-2625-08df3c42823f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|23010399003|22082099003|18002099003|10067099003|921020|11063799006|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ifxcQKc0g0ildvaNVu35GGChSbHghmZHRg4M25D/sRuu0ujZM/7iwqCFFjf8IJ3dhh3whb/tOmVp6/sih0IQBOrogUrLMsU68lRHHFSONQsEi8K8C8+7VCA8i7wNbn0ec9F7DBlT/ed+KI6HoHEw/tttQwASBYVrjt190yTVpVAo+LYbnbwbVTgfFUt5YevT6Wzgssh4EQaDA9OR1iXmSVZ93ihAg5832d3oRtchuvvzfHB+hlBxZf7oUdfWP6334qny8fSvminMQYEAgDn0ZVLHLmS6mU89xE6dgEGTR9VZibI4sMFoOyNFciW9Fq9KtxRGASv+VopqV18rrt9m0NiES/Ctk+dEsnTVeTNGIiCUedmvyNYse0iRMGzc1jBbtGM4LtqBYb5MQp8o7jUfgu1qi5tmKJxOt7nR+veYr+HzOwf31ldxgucSRGoepABp27b/ELKs3cs4z33oS1VxXlYimUhwlkQM0lmZ7FVcgnXxjb3fXzplOXbP+qQiyiVV+fxMVxqy9bZI3/1Gi2uFeUxHRFUBeKHMDuwzBGzstlxeFAoCuCx6ArOwhz5zXCjBY8mWlPpZnH89c5Wy5pq0DwxxPGiNln7w173sUsH00ntvTEOMR7TIYtwtEcC4Muz3lJIISB0eX+Ub2FNAbEJoOiprg5OVzlgu3Y8m56NItFS9xm0X3kPuidgbMqcqKOQ8jbmJCbRjYqVXoWcuyW+2Iw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdGallhN3hPcUFvZDhKSnFmcmlKTG1hKzdDb3JkeEpIQzVpRG0rR0xhM3pS?=
 =?utf-8?B?ZjJZWDR6cHZudE1GUjhjZjNCUFNpTk9JVUNwQjJ1VTI2QVozRzY4UnR2Sngw?=
 =?utf-8?B?OTdRYk42SU5jMU1qanRYbkFTK3VPc1ZtRWVGdUpPWTBHbGxuZ1hZNU9DNy9t?=
 =?utf-8?B?ZVNFa1dCNGwybDdSWk9pa0lxUXp6OE9CcmFuaWwyckpBUUlqZXROVlVaMTV2?=
 =?utf-8?B?OGNKZmNWRktTQnVhaFZ2ZlF6cXpUNFNnSjFmaUZJNHVxN01kNWlMMDVKZlRU?=
 =?utf-8?B?c25XTjUzQ2hQUTc4WU81VDFVb2NIakMrdHQ4V1huYnArVFNyY1ZpZXcvYWpZ?=
 =?utf-8?B?b0NCcy92Q2dQNXJoWkJoeURoSUoyR1lKQlNMZmx4M2FDWlJwdXRMLzFna2kv?=
 =?utf-8?B?ZEg3Q3NpWGtlanpJK2ZmbnVtRjFodEw4TlUxSlF5SWJWNFBQWDRDUlhWOVA3?=
 =?utf-8?B?WWp6RmxsK0FMNG5Ha0NjSHdIc2Vpa3dZV1dOR0xlTHhCblQrUStQeldjRlFk?=
 =?utf-8?B?MXoyY1pPNVFsaDhvYnRheHM4TGdqczI4UnZhYnRTVGdyWGpmZnJ6VXdSVE5n?=
 =?utf-8?B?LzUxTDBhcXhUQ2xwbmZEenhCOVRYYXFzMjlxRUhDcHREYmtCMHhVVlMxQzVj?=
 =?utf-8?B?R2dreXdUdUJuV0tnSnI5aEF2bFM0RUUydHUrN1J2VnlsdjhUQ0oxcjBQbnhD?=
 =?utf-8?B?bnNIWWtCVjh5QjQzbjVmTUxDMkduYmthaXRTaFpVZ1NxK2xmR2JuVFlQaW8x?=
 =?utf-8?B?TFhSam1ZM1cwWk5zdGtvNDVUVDJUS0dvaUVjZFYwTmFIUS9jZGlJRlk3SGdy?=
 =?utf-8?B?d3p6RlZkNjIrTG9rQzZrR2hNTzQwRVAzN3k3c0hXakphTlhLSmZDTVF1OHBz?=
 =?utf-8?B?WVlMUFl6bzNKVm95TGdobC83SjZmQ1ZTVFI0bStXSlE0Sk1INEJ1NTkyMkR6?=
 =?utf-8?B?bHBFTWVjWkFFMllPUjRzSkhsNEsxK2JaNVVKWUJidUdVZnkydXpLb0pZUnZS?=
 =?utf-8?B?anUwc0o0R29vdDhVNm1vaitmZDV1bGNmVzBTRUJmejgzcTB6UDRQUDlDRHhY?=
 =?utf-8?B?Y2ZzV29halB6NnN6WEdRWUVWZUkzZnl4cWYySXVleEVTL0pSclJuQktQYjhv?=
 =?utf-8?B?OVl1QkFqQjdNUEkyaFdJdCttNDExZlp0ZWxvU2JmeWpkeTdtWmtHN28zQkxj?=
 =?utf-8?B?TzBwOE94WklkMjJFWnBJK3BDUlZTbXNzaHhsZ0JFL3FvNm13bVZuQXRIT01i?=
 =?utf-8?B?SzJGOGZ4eDcxTmVvSVRHNnJybDYzdUUybStheWljeEQ0Q1Z0dnpXSzNya2Y0?=
 =?utf-8?B?QUFkMUVVN2l3Zk5VeTNXMlJBUDFhangxSDBIOEREaG1OT3p5d2wwbTAyRUdB?=
 =?utf-8?B?VWJOejdSamZQbTJPTlJhYmdJTUZESmpRL0VuV20yR0E4WFpDd3NLNHR0d2xN?=
 =?utf-8?B?Um05NFZUQ2g5RTlvSU4wQ3JRTFhNTVVjNTRtcWFXVHNZVTdSZ1RCZ1V2SFU1?=
 =?utf-8?B?anpISE9oeGs0cjJCTTU4OHpyVVV1NDFYUVk1Mk9kWGRtQ1AxUk1jd2syWEI1?=
 =?utf-8?B?Snh6Q01YWldId2VGSmxTTXo1M0ZadHJxem12ZVJYazZ3UGJ3VXIySi9zdWZt?=
 =?utf-8?B?TklrM05mUHl3M1p6Q1NkOTBLVjM4SlFsOU8zTGN0WkgvUE9WNnVlbkpvTldm?=
 =?utf-8?B?cVI0MmFZbkVBODVweVVheFlZcGVZekdVWFp1TnM1eGtPT1BXdzhkdytrYXg2?=
 =?utf-8?B?ZWdzSGdGM3hBZUk5SHhIWnBSR2Q0VkRWN0dONWhFbDlhb0xYRXUva05qL1hz?=
 =?utf-8?B?bGZkNU5SR1pFSTlRN3JpRVZ3bFoyNkUzUU9oamRSL3RVNUpDaWg1dCswT05D?=
 =?utf-8?B?MHJ4VTJTUlI1aDVQOHdTV1FHVlNRb2RGKzUxc05SL08xTFRvZG1DOW5rdDA0?=
 =?utf-8?B?SnRiNUh4N1RXNE42WGN5Z1FRN2lTdkVXWkUzcERFamhOakJuL3diU1lYUk9X?=
 =?utf-8?B?aEFrZ3l1Vi8weE00RGsvUnc4MVJId2ZQMStHZEFueFhuV09TSHRZdlpPOWhr?=
 =?utf-8?B?Ty9GUEU3NWZhV1RNbVFJL1FWYkN5R0NIQkQ2aFZSZXRLS3h5ajUyVzNQRDJ2?=
 =?utf-8?B?NkV3L0o3UTBucnlvUlhndEswZmhFaEs4VytETHoxekg4QVQ5NTI5SDY5c1Bq?=
 =?utf-8?B?aE9ERStXamRZbVVGRzVXODdBQXdSTkE3VzY3OHdWSFNZY0lOQ0pkU1drVnlW?=
 =?utf-8?B?L3RKU2p0WFNEaUJnRmwzSmhsQ1dlYklDdGlWNytMdnpvUWxIcHRoWEFjZzds?=
 =?utf-8?B?cyt1WUVVaE45c0lBOHFVcTAwck5sTDAyWUpETGw4NHYzUmNuVlZGdEtTOEhp?=
 =?utf-8?Q?1ZACXQab1Z1+A0wSh7qcNZba52lwyt7KIZP5X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae6d74-768d-4753-2625-08df3c42823f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:14:06.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb7Z9+ZBY8RED8zjZZ59nQJwCB8rAtW3EZWz5mCfVEoSesiSEBoDdGfsSKcn11O/RZqgMn8bzfR7XlnIiUUsZ83RnMhWYplnnfSkFOXgw717fTRkxhmgk8T7g0STroi/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded chan->device->dev with the accessor
dmaengine_get_dma_device() to avoid direct access to DMA engine
internals.

Prepare to make struct dma_device private.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 sound/soc/apple/mca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 26022a42a95ec..b4ca8ec78488f 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -940,7 +940,7 @@ static int mca_set_runtime_hwparams(struct snd_soc_component *component,
 				    struct snd_pcm_substream *substream,
 				    struct dma_chan *chan)
 {
-	struct device *dma_dev = chan->device->dev;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
 	struct snd_dmaengine_dai_dma_data dma_data = {};
 	int ret;
 
@@ -1123,7 +1123,7 @@ static int mca_pcm_new(struct snd_soc_component *component,
 
 		cl->dma_chans[i] = chan;
 		snd_pcm_set_managed_buffer(substream, SNDRV_DMA_TYPE_DEV_IRAM,
-					   chan->device->dev, 512 * 1024 * 6,
+					   dmaengine_get_dma_device(chan), 512 * 1024 * 6,
 					   SIZE_MAX);
 	}
 

-- 
2.43.0


