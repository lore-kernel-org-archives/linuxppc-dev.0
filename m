Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FC606A32F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Oftw/CYO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLr4T4SDhz2yWy;
	Sat, 07 Nov 2026 07:14:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793996073;
	cv=pass; b=fVq/wIu7D4wGaDxSJihfZXEDUJ6RlUOtGainWwqfzvpXINmSGUdAUFNmYMr1GokYmhTlrPv+9wzApKSLPL4P777qNFnuqSNSIKb8F78oTI6tEEDeBW2u8Ddo6BTKfYkkZ3gbTbdxHvWzrf1mrDW10iNlFGgFAku1ZxWOCgdnT/x9rpKw+MpWSYC/QparMI37FZRkqTyzDvwM/I8KO8/H0TZJiMxye6Y3deFsoQFznTRgQjfJoiX+uBsNR20PdhMEWI5CZo42qyXAEJhmJhMaruwNIgf+RxUVBcSIQr9tXlaXy5dnGxgaNp1v7cEwaRlAgWFt31W1RHeXOql6VibjxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793996073; c=relaxed/relaxed;
	bh=Eh5uaWNNqeTweq9zt0mqoPcq6u/9fctFpozDGkZ79PY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SRylLEX5nq/mh0urvDNdeA8xiJVBNJ3mQB88aFDfMoVvcf1ajVZmCnIOxLqxah7gQtyxwUn/rYK4I7atNFfJ7ryQDGdOY7SDwrndzblRcYpHpwxFGYf1SSEcXKUAekHacEktC2f96GhUaSePk52nQE/lg9Ifc5oFDMeaILDKhMo2rgrzOn33QRImqHAxEwAMKTzvq4C7leC52GrEkrX8JyYPp4vbHwjdiUmRpflmL95YHqzBiQBkQSyHepklv9TdvpeC4xYi4vLWeLX8YbaUBS+nB4iPGU1UGAPR1FO6r0O8qj7aTZ7mtAzSDCPiQTOYDn10HRsuzvsJlT61DR9xew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Oftw/CYO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Oftw/CYO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLr4S6rclz2yTK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 07:14:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVOSE/oPcCcE80RwtKDENVvRwt/cLiUa40PiEx7ZXF4mvnbL7/bQJd/lC8FX5XSx7koZOW2zpAzuzYE5QDXogOqikHKxZIDMEwb9TVXTAxQGh3eAG1WEluFxpcTgnkXLA6NHj5D6x3YFsTglBcPuMXEn0OUWYj88XxWE9HiA/V4zXdjeMpozO/AqYzcX1JeHPNBKAIZ44vu1ur49jnqjqbIkY7wa3CIn5gCJTfc5V7ApFGJ4oBQekXWUhBdlEYLVOtRAe1awYS0U6+4U8tuIRHenWQ0gno+10keRNTnxX3O7i441lj26hO87sKaSar9GonziFLr6uTKTMfAU87M93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh5uaWNNqeTweq9zt0mqoPcq6u/9fctFpozDGkZ79PY=;
 b=fKbpfPn6s8fnbV/4j/kTQtXxK1iPr4+jtjt1N3tH05TLRHRtzsCb0HJVvZPPJ90YEYP4URRw43Ak3+aIOIFTJ7CCVcI0iZMEVGBOC1lLgKIwCIPxXV4qkQ/T4ffW9eP+3cVDykgkDnWa/cwDBWmUTckcuScolZamj0DutdkSBmIwlFg4WZJTKD+/iQJnVxryVAfF4rwsfQQo70EO9AQKmj9pxxnU+nSt6tus44IYEbBJPGrrvBZHArdrOWa3vK62jM0/1ghZuoT+WvpuioubUG9Z9zNBK2CRT8O2hfk5g+WV/rbSm4CWSFk+bX2F9CRld/wbHIsYFDAeiiBQgUSrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh5uaWNNqeTweq9zt0mqoPcq6u/9fctFpozDGkZ79PY=;
 b=Oftw/CYOh9o4c7fs2pKJH25N4dvqCvEAepWOTTrOk/BwIChhVYJTKrenw17UHCbEqLr0QJ/87G2MHLne8BOHxDv+4Q96P/K27W/OcDFr5WUtE+V8JhyxNPwQhDEXDc602B11rDCp/S/C6cJv0ucC9N+t3Ef6fosCgur8vjJI1emGa3mtkWgIU2X+EP1uMq8O+qAi1aBYQdF6P1h+aFkQzkmwwaIRbz2zO10AkiIwiMKkqTaY/smNbY9N8pW1Hi7O1GSZqNfKGz+JtvBPF3nMSzkSPE8f1paxPZZ+2leGdAT9xeXDrpjW5P5vEWn3YkxI1slsAbj5s5HF6FiLDVFqYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 20:14:17 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:14:17 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 06 Nov 2026 15:13:47 -0500
Subject: [PATCH 3/4] ASoC: renesas: rcar: Use dmaengine_get_dma_device()
 instead of chan->device->dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-dma_sound_cleanup-v1-3-5eb8a7b81e87@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793996035; l=771;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0E8OHKC9n0uZSdDOTlG85IBM8sVB6inlVx/L7ru86Cs=;
 b=7B1AeuOoBXPkZS39upZcVpxXUqpwJ4g+z+k5c1bDOTZI6+HHrIA4vQBT5GCzr4hvJr9Upo45N
 odOMnUgbfpuDGaHdFwPYU4q+cMlkyeFzGEad6VAS4GkhCw9wggk/ea/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d273b2b9-3bc3-4f1a-0d89-08df3c4288fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|23010399003|22082099003|18002099003|10067099003|921020|11063799006|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	t37nvQWfWG6ui5ul5tmOEuqYts/9ZdNgBKJW6CRZvHLKpnixd3q6WIOLYKWkMK6JCUlIkdNllFYx7nzqIv1UDj/qznYBSXkMfESprs6AMY1uOU+FeQ3YgFYjXoNW0S0966nJz2KvQ0EC57Fh9gE7BHqz6hihv9P5+TfsPI/1Z4lLFggbO190vRBAgAGMp1anyHm1Er+RlLTFMVDcRkFQdg6wg6yCuzRXuOcChmK+jt6GB5Efpw9hr+DSOLshuQ2TQOIq0ENs+Fd0TOSgUwYZkWXC7kYOrlB7NTPn0oS6wu3ngNoZjrNjQf53ldNZGtkKWH5dP2bVHOykIMDSNqoE7I5eIRNnDrB90mSePEo9I7WcB/Cx7JFt0ZBLLs4RNcyaFRheDSWBqLoB51vdJjZiDUlg8vH/UfnQaDcFJP4oBHScq0sRXvF83zXWBxIXLqZCsr0xAUWPX2y5VmR36vN6DgG1KyGSHADSMpmA4crnU36f6dWoAhgLiLpd3kfbozV+PeLeUg0H09xz1UgIBPWSHwiLDkJsUpRUJSwrqoKpd8WS/jGsoglR65xzYU5j/2gWNlwDqbDNdZe4INJxjonX5UDZc6DMmf3BrZwM0VDfajLb7b81j8PgLE5HF+eMD7uKBgSpUsYGqA3vn35s5Blhgc5hueACUgoTxmZfW03IE9eSQvGiFlHG9vH0cnhl2+RO6JqBi5CBfMpF2AG0UrFuPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTl5VWlYVTFrdm01cExRS09aMUNJMW1PV0JKaVNHM0NVVmttdU51MnNSSFYr?=
 =?utf-8?B?Q1RaRFJiV1RIQlUzekFnYy9KREFCRkczbmo5bjVLSlROVXNPWmpyM3RNZkhq?=
 =?utf-8?B?N2pGR1hhaEJPQTNWMWlaTUV4Q3F2bzBwaGxvWTg2MFpnQXdmdWxqS1NzOThw?=
 =?utf-8?B?YSs5eUl1RTFQUit0SW9YQnNnM1RueFpVaDBxU1Qya3hsM2Z0bERqZ3hiMjlw?=
 =?utf-8?B?ZHpIdUt5UittR3grNjVaVk5JenZPVU1lVnQvMHBkcllRTVVMdUV2allkcER2?=
 =?utf-8?B?K0J1UXBzSjdCT1lPRlBjMzVmSmp0SmNmSUJiVkE4SFV2empEY3JFUTZzV3lk?=
 =?utf-8?B?RHlxUzFJRzFxODRrNUJuaTFIc2NxSy9QU04za0JDR0tKUXVnT1l1VHE3dHkr?=
 =?utf-8?B?dFVvK2M2SERlU1RGZmJkQThHTTJ6OEg4UDVDWE9hbE1HY1RKS0I2L0tqTFdC?=
 =?utf-8?B?MVljbUNqcFU2c2pnc3VIcDYyMWkrV1V6bEZxbndzM3RNVlJSV3U1RnZCSFlu?=
 =?utf-8?B?Kzd3RVJjS3Q3Mk5UemtDMGhrZHlWZkdNdUN5RTdCd09qeE10ZEJ1TFVtWllG?=
 =?utf-8?B?L2huSlV1ODU5emdIVVlCSDBNWFBZRzlOdC9JOXRXL1NJVWlSSzV6L3MzTkdG?=
 =?utf-8?B?ZUVic2VIRzJMSkRXTGkzNHdZR1plRjNVTjhTdnN1dStwOUMzWjRYM0RlWHY1?=
 =?utf-8?B?c0JNK2dHcU11R0ZSLzJsK1g5R3d3b1RHK3RReGpXdTQ5c3JoeDFzYlYvc3JO?=
 =?utf-8?B?dG5PSzFiUFhESE96dlRhbnFKZWNDN2MvaTVkTXY5aTM0TVQyelpwbmhIZklz?=
 =?utf-8?B?R1FDckZlYjVMU2RxKzRjbU1RZHRqWStFelFhT0o3VmsveHVoYmlHb3ZYN1lP?=
 =?utf-8?B?QWJaWWpGOFFVMWIxQTh6bit4YkE4dzdwSWVhcDJTMy9Eek83WnZuSEpsWmdE?=
 =?utf-8?B?VUQ5aGVPbTdFb3dvWjNKYlAzRHpsTisvNXFjem5kWDVDSVl1QXdtTzhvRUo5?=
 =?utf-8?B?OWx2Mk4ydVBHMWREYzhCOHR1WnU2THJWYXF0cUIwenk4bER2MTljK2k5d1hi?=
 =?utf-8?B?ZDVhWTZRaDNYbmxZMThCMmVzSWhHNEpINmVTNU1KSEVURFhSZGNKcG8vVzgv?=
 =?utf-8?B?anRhSU9RSXh0a2ZZZHRReFFUVkw5c2hkcHY4S1pLbjVxNlRmMlFDeVIzSzNp?=
 =?utf-8?B?eUNUODk0cjFzbDZXSWZLTmhDWEhQZ2Z4aHkwS3ZDa1JlQ1hYbjY3bHNsa2Qr?=
 =?utf-8?B?UmVyOS9KS3pCb2Y0RTBubGFIMlVXcGM0SXNjczYvYUpTSGNGVmtsRUxqcnZK?=
 =?utf-8?B?ajRZdlk2T05YWSs3cHhxUWRCS3p1RitmSHVtQlFoekM5SlpZeUxycnNSdGlv?=
 =?utf-8?B?MnhjcW10UlY4cWFJSjVNWDQvWXcrbklvc1RkOEJnc004cXg0NzVPZkJHYjFy?=
 =?utf-8?B?eFArODdsTU1pZHdhUVA2RU9sWGZlVkxySDBQRzdwa0QycFFnQUtCekhOM0hP?=
 =?utf-8?B?YzBIY29TZzJOVEtsYk5rMitRWEtuTElnd0l3b0I1SUZsRDNKUHRIU094MlBC?=
 =?utf-8?B?citRRlZCc0kyc21GcHVGNlJVMUttN1dHdmpQZ3VMajBLOVdoTHgxZ292VStM?=
 =?utf-8?B?QWNDRUVNeUNMNytDMTVMSi95QnFSNmhxdk1yTzJXbmZXbFZERXM3N0pqQk1X?=
 =?utf-8?B?ZTVzdTYzZlMyQk5UcXYvY2F0TFcyTWVqQkNTSHJ3SVVMM1ExWTNVbFNSV1NH?=
 =?utf-8?B?WFJSVnhCeWRQT2pGWGp5V3pFbEZGcllHQ2w3VjBOcjFMbEE2VkdnSi9Ydnl5?=
 =?utf-8?B?ekpxdUIyU2pSMGdBblJTbnluejJDbksvTTFySXVab25xR241OHRjdU1tYzVK?=
 =?utf-8?B?c3N4cnBHTkpqdGV1cjVwRUFZd2kwQWsvaDVFY3pjaW9RU0dVUnVxYnFjYmNl?=
 =?utf-8?B?RFV2WDJGYjNYc0tQR3lBelRNVGpxRWRkVU11emVub05NMXhkSnlPYkZhZmNQ?=
 =?utf-8?B?MXRaL0txSXZaZmxGS215eC9UVzhUbUlZZnNVamgzNWF3VkFhSytOenh5YzUz?=
 =?utf-8?B?N0Q0UXY2RmxrejRYN1lsdHNQT3R1MjNsek14OFBoSXRFY0R2MDdEM29ldUlx?=
 =?utf-8?B?cG8va29CNUZlRUNyWjVBWFh0REI2bitlbW4wd21acU5laEYzMGU2RUlETTY1?=
 =?utf-8?B?Y0VISWNEcGs1aXpwTnJRTCtJNWRKUDhJTkpYWERLdnA5eU5XN1RIYUQzdHJt?=
 =?utf-8?B?ZURHall3ZlVHOWRpRDh2eW8xWWFFcXd1V2hRUnc3YWlwektjZDB1RGNvQzJK?=
 =?utf-8?B?WDFmUjhBelZjZUlHeVNURXh3K0dqNWErVzBQaGtxemVDdys1VXp4Nm5NbU5X?=
 =?utf-8?Q?7tWHST5YWSwdJILv0W5R1SiFjrwImto+CuisS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d273b2b9-3bc3-4f1a-0d89-08df3c4288fb
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:14:17.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmf3yKjy6wMiSSxxbbxn8DAOVESojU8A36HWgVHGiyjilic3JuECN0+IH8nl15GIWPWt5TXmzkdLtTGlhFBm5zvnGHlYKcSwXrBKz8ku+3Ei4UiA2aDkoQas+8fl8tGn
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
 sound/soc/renesas/rcar/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rcar/dma.c b/sound/soc/renesas/rcar/dma.c
index 793dd4adbe5c6..d70cc71676df6 100644
--- a/sound/soc/renesas/rcar/dma.c
+++ b/sound/soc/renesas/rcar/dma.c
@@ -246,7 +246,7 @@ static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
 	 * see
 	 *	rsnd_preallocate_pages()
 	 */
-	io->dmac_dev = chan->device->dev;
+	io->dmac_dev = dmaengine_get_dma_device(chan);
 
 	dma_release_channel(chan);
 

-- 
2.43.0


