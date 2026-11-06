Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C281606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DN6RCXKi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLr4Q3pZWz2xDD;
	Sat, 07 Nov 2026 07:14:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793996070;
	cv=pass; b=UYN7XaT/qmf7I3YXD1LugfxDvOzSEcw3l7yZBeQYh3qnadO0T/FKCdSuoca1yuqEh7L5RXbub00WzwTSLaQoBIGNXbimI4O7WiaydzG+Ot2TfXiQveffos2ynURIm+lRWqiz89D5IhswTwUAVFimc2hVCmAcGWmPpAhpKXdslNetbDxVgZnOk24Fncm/EQ4921M4QHNVDaCyTQH7RecQL2Ex1EydFp+ZsOntSkgWwwKs1fa8zeuCxrEyHAxq9iuKNmOPSSCQesoJL5F5wbwGhgafDctsqWF78SiWmmcdfXuixagVTHOW32g7HZK1wJrecYZhdCe1ppzHGhxjcdMh5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793996070; c=relaxed/relaxed;
	bh=IcKitxzFbdZtipPQYe9PvSfBL/XFMlmnVpB2vCn25vk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=W29KTzGNLMncgPIQsyhcvK9lvq0J9vaGE4JjI5b1+MFDGO8oU+KsLyc+3Bf4k0Da8EHUas2o0Vxv+pshwd7C+sX5hqSo8G1d/tMWG7/9y+pZYpqB88QN0PNzPvGmc9qZ0ikjt8acwU/Zko3P6KlXjwQSHi8/iZfNtV8u+qJri7d6sa+NEO2ZR5S4vmi6qtTFDXNE2sCL0/CSyqIMdl3pKe1a9rk/RTP8lwsZEEd9jmYIpozoMSD85R49VPcZJOk51mif7u8jt7iwyf9L/B4GOJuYLuVhf8KPQtwYWGxi/qu001z+MPxsbW0t+33w2hmiRbLTcfEkKYHNCBfLKv+/PA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DN6RCXKi; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DN6RCXKi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLr4N24q2z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 07:14:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUfJKYkm5sw1oxRChWHEU+31l5D7bhjoSLEff3cjWoQI2cwRYzRwqY8MrSv/VlBaNCBqONrtA0myr58DTt+ggV11yT1MeE31/CCdnZ4e+SIBs1exqlbpY+qudqnaBGVvakOmBT89J4J6dyUDw7eSsYNEdsoKcGxBkS2YRJ0e4iLTPzy+5kLMNaA+eiIQEP545Em2lNnU4h+8CJTGAGsWsYRnEs4c8trnewMyAXU5tTcLzTKaAhlagCkaJCJwFwPv5MCcrqqbtRrI2ZlYjGGJq6xDX4H5D12cM7ljnoynVqk+hE+N+bZBTcFOOjJ7aG2tF3ZuHUvdfGw0SYSBzoIU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcKitxzFbdZtipPQYe9PvSfBL/XFMlmnVpB2vCn25vk=;
 b=taxcvUpu1TH49ZlxBE8wbDKnEl+/At8zJZRuH3SwGTBnrjvOfvVFNENH0cGJd/IaZYTIQTU+z8wZb+CvBuvbH/StB/LaImz9+EsvCj0gYIgXyA0giRINuieoiJFbACmHnz2JMM3j2SOCaUGraU+Gfo9rOATtStKi8fkkiNJ/rzWnBwFEKyuicPbSF/eamluyYgd5kmKJmZshUuSGaEN0UjAGRFwlyqyvoHTsw5kvDTvcGKIx/to9SNMf1gz6Hdp119xI2CFnHl3sbLFRK79E6lgyCzupkb3zEmcVViNjw90HLeZWH2b32PtHpZ8r6IavBg4CPmVLMDj4v9rFm2jeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcKitxzFbdZtipPQYe9PvSfBL/XFMlmnVpB2vCn25vk=;
 b=DN6RCXKiLINUnIUvRbj0zufByDIFgAdEKBI5KaIwW4h8dIR99pGGMf4qZdd7clWGjp1RyPzjAfSFPhM/o201XAqLqWQy1fK7wNI7oKQAG+oWkVDISLVeusDenQ3k29wtM5erYv0yzHbMMxcB8ls4Yj2aonl8nlLxrWDgc7UlhVHOWPc3jxggJs+PV1hr2tKcym+oidP7wB4tKwnmJTMepMFwunQrSRWgewI52CiaB25LU4PMx5OorbFmnvo4iuYbOQUVt001RN3BWEwOJS8Xb157Oi/9bxJuwaVhNCaMqhrWbwepHyZ7Ah01XrQmnC2Ep1A9ugrwFqhUvo7KzEoivA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 20:14:01 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:14:00 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH 0/4] ASoC: Use dmaengine API instead of chan->device->dev
Date: Fri, 06 Nov 2026 15:13:44 -0500
Message-Id: <20261106-dma_sound_cleanup-v1-0-5eb8a7b81e87@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPk07moC/yXMQQqDMBBA0avIrA04KYTiVYpITCZ1RKNkmlIQ7
 26qy7f4fwehxCTQVjsk+rLwGguwrsCNNr5JsS8G3WiD2BjlF9vLmqPv3Uw25k15M2gM4WnCA6F
 0W6LAv+v56m5LHiZyn/8IjuMECGJSpXUAAAA=
X-Change-ID: 20261106-dma_sound_cleanup-d6b21ff86f31
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793996035; l=1662;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zChPA7w9TULBn2E1cBohmy8ghhrAYYbSV6Z445wfl/8=;
 b=pCU+SPc2QGiqzG362oi9zIYtU81vC6ntteLyOyqRfWHwQlKcZ6Y3I8MEpMXgiSsP//EQsGqgl
 RUFr/EvKbwXD8MD8AHcsQDjaWJ4f/K0Un44bra/ns7I5WbSrRmHz8aF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:510:339::33) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f2d5deea-3ccc-4311-585e-08df3c427ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|23010399003|6133799003|18002099003|4133799003|10067099003|921020|11063799006|261022075727099003|261026121527099003|261009223027099003|261026140227099003|261026130827099003|261028144727099003|261021135927099003|261021121427099003|261022113327099003|261021130227099003|261021123027099003|261022115727099003|261102123227099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0gXQWFPcaNYoTieYnfFC5j1H447u+exCWbW5hjW+hklr98piEY+jBET8ojEk9Ta8KmJIVNI8Zi94JfALj51rwjCWLMpIypH2lUTdSNmwCdtUzCDFqwbqX2G7lV0kUv2buWTlS5FwpCiR6wxn/iPG3K7oPB+k7j8bnGmETnG4R8g/6oQ7B8a7C/B2ZIuCmw3XKKsOVZuLJgNp1csYBe9biYnPWQdWPdvEnglHKmnIQAvdAuMfeOUM3vUxs+8LinNoc3F2gZx2CvK92Jzg2NPqN+r0i6RNddqFKxBKRYvlSptoNdiE3ZDQMdcefbLy7yXAqZws0411OfWY5C5Ojw9Po5KUfGCC494hP+8vyNW3O15UVHsBXSQlpLHO/bZJb0nSrO5lmJyHNKCxRZ62FdUXNRCbKJMuCxBW/PKyiVp0FfpdEsps4n2lwtr+e6aarIe5nvSjq5N+MzYkx2RCRRno7Py0A5I34vMEx6s3JEmoKlNMV1m9QuD3X4zEKwVPGUDyYGp+JT4uhLhtxl4o1opI5S3p4gY02z9mAP1PsBpHBX4A+DR8u0mn/O7RZDPNvzaBoVUcOcfiZz+UYeYaK4vg26kyagonemExiablTzBNWuIlUQYHUNE6uiovVGGnIbB7foAQSS7w4A7PNCOxNiXQX+wf0E1Lzmfvd/BMAxk9SDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(4133799003)(10067099003)(921020)(11063799006)(261022075727099003)(261026121527099003)(261009223027099003)(261026140227099003)(261026130827099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022113327099003)(261021130227099003)(261021123027099003)(261022115727099003)(261102123227099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ait1dHdBNWlOL3hwZjNXMDFwMG9ZYS95KzlHRnFDR3o0TGRsVlIvSDZkekZS?=
 =?utf-8?B?MHRUN2JoVDBsN2FHT0krMzN5VFRJTjNtN1l3S24rNEMyNkorSlFYWHMwQm5S?=
 =?utf-8?B?aFhpR2VxOXlVbDcxOU1aR0E0TTdtblhsTU1yZ1E3MVpNQmN1ZHhKS3FmeVBu?=
 =?utf-8?B?Z0grVHRwMHVhWTczM2FwZlczcXQ4bUMzOTkzdFJIZHJQak9NV2ZjdVQwNm5W?=
 =?utf-8?B?akxiTE8xWUgzeE1YTjI5alFIcGZrdUtiQ2hadHRLYmZTZ0xqQ1d3MVpXUUVV?=
 =?utf-8?B?Y3JZbldBRDBaSkhCVDlsRnd2SERLMmphSjhvQmNGN1ZpVDlUM0tORjlQYlp4?=
 =?utf-8?B?T1JTR2NFVUxNUzBoZFBwblY4M2RxSU5aYmVsaEIyUFg0NTZHTjV1NzN4V1Ns?=
 =?utf-8?B?ZjhoMWVLd0RtK09iQ2o0RzFXS1A3dXBlL0pxMjJhem9rNGpOVkNoelhrK2hw?=
 =?utf-8?B?TEhadHJ0UkJyMDUxRkc3L24rTG9OWUtLTjk2cmZreGkzYVJjWVZDZVpnVzVj?=
 =?utf-8?B?T3pnVHkxeVdLR1pqTnpxd2g4MmdKc2xFUG53QzlmbWF0bUlJWG5vNHVxZXlX?=
 =?utf-8?B?QjZsRnVOTklRL3R5QTQ2eDR3RHlEdVNESXpmY1l1TWIvZ0tyeElGdzJ5VEtz?=
 =?utf-8?B?UHB0aDRUT1M1U2lieDJrTmFsQjlKaTFDNlo3aE9XbUdxdVZJVnptZXJsVTds?=
 =?utf-8?B?MmJZUXNVTyt0SGZ2d3RWTEJSWXoyTDZQMHdOTXp1SWRTYS95eTB5VVBRaFV3?=
 =?utf-8?B?K01hUmU3ajcrRFFtVGMwNWdoYzNGdVBXaVkzZXFKcGdpQUZiYjZLTmg5VkNW?=
 =?utf-8?B?UCtkVmoyVytQcms1cWcvRjRjMDJPWXIyMGRpUmtVeUVwb3k4bHhFNWtjbTgy?=
 =?utf-8?B?QmNSNnhPU3BNdkdGODk5cVpnMUZGb0tNREdxY2dYMlVDNVk4NE1TRWczKy9J?=
 =?utf-8?B?N2xoWDJUNEc5bXJ6L3ZSTjRRcG14QUYrQ1NiVmFkWU5kek1Eck15cnBhMjFZ?=
 =?utf-8?B?MHVHVThPaTJqZkRNaE1sTForR0FJWG9BalFHMnIvUUs3T2pIU3VndytSVHg1?=
 =?utf-8?B?bnFuQnJuUWFMcnRRMXhkSnpuUzB1OFJkUC9FNDI0TDRPM0o5OG8wUWVRU3Ur?=
 =?utf-8?B?TUJxYTI3eXJ4R0JwYks5TmJ1Zk1RYzB0aWlzRVRlWkxDazY4L05QZFBuRXNG?=
 =?utf-8?B?bWo1SHVqcE1GTTc3anZCS2xJM082VVNtQnh4RTY1a05KM1FqNVhDMzZKR094?=
 =?utf-8?B?Y2lPay9wYWYyZ1FZMDVzc0RSZStoYXhXTXZicTFyNmJqUDA4SXFpOTgyVCtR?=
 =?utf-8?B?dG5ZWTNzR3d0K1FnNG1KVzhjSWM1Rmx4cHlOenZFL0xXV3VmNzU1bEFJYUE5?=
 =?utf-8?B?emdoSkJFM2xMVUZEVUxaeFMzSmpibDhyWjB1VXRwUHNQQVE4b25ITW4yTWxN?=
 =?utf-8?B?MWZhOWxtcUxzUEtaUTE0RXFNNXlWblEyRjVEWnhpU2kyb0lDVjlhb3FXdVNp?=
 =?utf-8?B?V1VPbVFJUVd3L1M2RmlSMkRQa0xLQm94czlWdktuNHBjRUhiVHdmem9qUjdK?=
 =?utf-8?B?cUU3d2lTc0Q4RjBPK01Pc1F4UWxoR3dzblhzaDcrd0JpMEZHZFZnRnRqdjg3?=
 =?utf-8?B?eVN0S1NYRElIRkNhcWRCak5yWHM0cXJJVXNQQXptL3BZNGRBcDF0Nmd0OHNp?=
 =?utf-8?B?UmJCZHZWcFFxVlVHNmpNQ3pTV3lTemRmQm5IdUZOUnZjUjlzZ3BpMC8zOGdY?=
 =?utf-8?B?Tkx4SldaaWx0S1VzUlhzZ2hXTm84SmhFMTNHUG9JZ1owR3FTT0tnektyNFl6?=
 =?utf-8?B?VkNlaVdaYjJrRDFkTE5nYWhNRllCd0JSYzlJMHUram5DWEVVS2NyMkt5aU9R?=
 =?utf-8?B?dnkwelMzNGRUc3JhQ2NaZEltUjUzSUFEd0ZUdHRyOE03Rm9uWS9XMTViQkwz?=
 =?utf-8?B?aWxUUDNWOEdnTCtidWlweU9qYmVkdE40OEFmeU1HenFXMk40UWJjaUs4NjI3?=
 =?utf-8?B?aCtjeHNXdzdOMHpBdEdtMGxrK0QzVWkwL1ljWmpPNkJSVGtqcEh1cFk0VU90?=
 =?utf-8?B?a2s3Q2gxRWxZS0cydmdiZGc4SUIrRXNUZVl4YjFoTld6cUhzOHVoTmFBN1hE?=
 =?utf-8?B?dDRyREUxZ0d5MVBDb3Q4Z29DUDJSZ0paUEtGaGR6Q3hIVkJoR2VDejNDbzVw?=
 =?utf-8?B?T1U0bmxzak5nYWZjZUpqQlBwMmlzWkcyN1pvdUp4ekNxNXFibzZVRzJQMWt2?=
 =?utf-8?B?N2kyY0IxOWs5ZCtJUmc4Q2RBdnZtdy9ZeXNKTFM5R1RvWWVWdkkvMzh2MUxo?=
 =?utf-8?B?TlpIUEJqb0x0YTFpelJXWkRVSTN3NlZZWmQyUUtBbkdRaU11VG1mc29wYTdG?=
 =?utf-8?Q?otvdEGiY0I7gavhqGLzu/n/PEJjB9cAOv4M0G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d5deea-3ccc-4311-585e-08df3c427ee5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:14:00.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkt1Ixb6X386w3AzS2VVtY2TAZtFx/VWi0/RCaVzHi8P3OkSW+sUR3wAHAN/1NyWvSKJ5ETeankphKrzfPDo3R3+FZz/wrTGNVQRK3/1aHrBhOaZPFpBFrF1M7cVKu+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace open-coded chan->device->dev accesses in ASoC drivers with
the proper dmaengine accessor APIs:

  - dmaengine_get_dma_device(): returns the device used for DMA
    mappings; may return a per-channel device if the dmaengine
    supports per-channel IOMMU mapping.
  - dmaengine_get_provider_device(): returns the dmaengine provider
    device that carries the of_node, used for device-tree based
    channel filtering.

This avoids direct access to DMA engine internals and prepares
for making struct dma_device private.

After previous post patch
1: applied https://lore.kernel.org/imx/179396622411.3073895.524075215689851221.b4-ty@b4/
2: under review https://lore.kernel.org/imx/CAA+D8ANwEqFJYQ39h+1A3zXhcUfpFGzSvVjEzx2htoYxB4sLGg@mail.gmail.com/

sound directory can pass build with allyesconfig after really move
struct dma_device to drivers/dmaengine/dmaengine.h

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      ASoC: apple: mca: Use dmaengine_get_dma_device() instead of chan->device->dev
      ASoC: fsl: asrc: Use dmaengine API instead of chan->device->dev
      ASoC: renesas: rcar: Use dmaengine_get_dma_device() instead of chan->device->dev
      ASoC: ti: davinci-mcasp: Use dmaengine_get_provider_device() API

 sound/soc/apple/mca.c        |  4 ++--
 sound/soc/fsl/fsl_asrc_dma.c |  4 ++--
 sound/soc/renesas/rcar/dma.c |  2 +-
 sound/soc/ti/davinci-mcasp.c | 10 ++++------
 4 files changed, 9 insertions(+), 11 deletions(-)
---
base-commit: 13716421a63a932e09c1f56d78f6055c2fa069c1
change-id: 20261106-dma_sound_cleanup-d6b21ff86f31

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


