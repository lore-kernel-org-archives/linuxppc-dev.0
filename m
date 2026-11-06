Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD90606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s34qy8Q0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLr4V4nN9z2yhP;
	Sat, 07 Nov 2026 07:14:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793996074;
	cv=pass; b=DwiqAVEe9cY4kpRi7p/lZ9DvI8CkhyPvUWdgOivXsBZAxgYYjH7Gktxeq+KHMB7hosq151aveePZKtOncZBvYAWO4FhxktWrEe0DxLVgXrucrbW47M1bbajvckcuq8MhFDCADxEh6vcFU7WIRlYJjb2jys/vcgFsVwwG6HgdW+q24+BO8DHRSLnRJEhVQcaqv8JZBV57DRanjPxCTwo+VFkz1Y5duzcLTrgqjbl8RHl8V0PMmNDEtC4sgZHDE4F1/3vnJy46WfeZp4gNwrszSOlKord21PMzJiW61JS6pxC73/ujg9gzpoUvxRAQmAU4oT4G/7pPTixLpFC2A2aXrg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793996074; c=relaxed/relaxed;
	bh=/dvpqTBdTg8jwAIJdZk4vV6CbCCoV5swPBcoydrPufs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=euIwn2XDPpPT6A2LUx4qRETpCRAjwqrOz/dGQ6c/sfS1B78t4fFb8sbXgUFgnERIWJRIQ/bZoiWthB1zYVnfO1TBiPbrMJEl7Bw1J4JcvXoh+k0+r9VSCMVfHzB6bgDT5NpQRnEUAZckB/EFJ7bTj+NMvPEn801ihFMlMySh8Tu0+ieVd90P6vq5whX2i/b+6uulG1jp626EfjUhFKNKWJottcSbDYB325cWxQvwpFWYE4eII3k0Hm9x9eUtuN3tsgLHLqz1Pw/z4qx3E+Xiux4bZpccTDrVNCy00LjhyR9KSQH6wD54uNesTWVlm3rXrmqu+E1pJtINxJjmHtmIuw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s34qy8Q0; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s34qy8Q0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLr4T6MhCz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 07:14:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOvcwdRLe7nqw2FiGw+7G2R3bjC0G4z40BdscIZTTN4pJrXupjCgLAT0YGuw8d5klP3vR7j9Dc+oMWLSim6kOE+gKM9DXyCCTVg1sxE5Kl97wZf1mC43rOgUjuqIJalvVfpinQWKEMUz4bbE+AqWjFuH9IH2uwqOk/A86SsO3+dKlnSt4uRGxvLE+gE/q+iQB3wH08+tchbzrNYfCtTqJVPpt+OCu7mDogcbuU3IxMbtHvLiLqXPR1lgefm6dU8FD06Fbj/r9hdSbXVn8PKCAdvznsQyk2Oqb3F0v8nVKw+xF+m752Us8lIMoMgWO816b89tkSJkeckgpQZUYukQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dvpqTBdTg8jwAIJdZk4vV6CbCCoV5swPBcoydrPufs=;
 b=xygQSTN3MEyzbOmTXUITj8y+Gds97tCCK6WADRzCNlV3DRvempX2Eh3/qukJ0zpSU7gXW0AvjZzIbuvCFqLFDBQTiQ3FmKiVPKElIlIkanXPw3FBA+k51WxABTwxEQ7SyyNWlyqwFAMasOazq+JBWOUOmDFijDFXAP39wJKAwNST81TYop2NaOquYEin6BJcPkiHTnQNnqJWe9w3a9ZzVM/XE7h3auQbHZV9Zs5ZIm6Ww1EfPwcLXm+ll8Lsg2b0CkWms0KpmCu+JNdYMdZL4vEqEzDkZmzm9ExLE00zMV8G5zFf0OMxCZValIeC1/7JZRl07R08eyh6JjGs1tmROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dvpqTBdTg8jwAIJdZk4vV6CbCCoV5swPBcoydrPufs=;
 b=s34qy8Q0SIuoclOVezzE7lCRr+Qc+IALK5KY4HFpMbR38fT7duNasUqz/CtmUqH5XX6BCsJdekLyVGG3cLE9OLWqaJMKyUEjZgrQOLAGJAfN3oZFegrSw4tNgXVnS1Q/UA2AviDuXEsgNkCHFfzyuskadoMBjMnF4rZfGo+QiItZ6oRJFkICm0XGYzhZhBM2u986O1KRR6+M2tHBQ8YcysxBbcRQdKeLZ/zY1JPumawIOtkeRk9DUzNDMBNqIwKjcwmQi8rE6e9OUhU384ndjyIPTTSIccR8ArkGvtsEBVBmiUA547RfbJQ03+ZWygrn6RkJDj9F5Q+S71o+lc5DDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 20:14:24 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:14:24 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 06 Nov 2026 15:13:48 -0500
Subject: [PATCH 4/4] ASoC: ti: davinci-mcasp: Use
 dmaengine_get_provider_device() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-dma_sound_cleanup-v1-4-5eb8a7b81e87@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793996035; l=1601;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tTdEtmGF/eZ9MbgcEArCNHLYLbLOQYCkQp0npfYxRSU=;
 b=aKbDKrRpKHf00jQA2ib+eAJlTNJOTqk0/xCX4MgwBuEjrT3c58khKDSzsqiu+wk0ERb3J9QJe
 1cmRLKOEPwaBDBkEcdElO1R/WilOkQCTgNs4OzQW37Wod+ad/AWrLjA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:510:23d::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8191fbb3-dff6-4921-70ee-08df3c428cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|23010399003|6133799003|22082099003|18002099003|10067099003|921020|11063799006|261022075727099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8chwAjnaG0h5rb2OmD9EJhPDY5ziiy1xuLpewb+fcB0aB1XIVc9cZl9jg1DkgL0jKJbeEDnYpt0dqcmOa64r0y4FzA9HzrxBAGjq6UXWPYMkVDDXTW3g2W2mD7iCwB006BQ6OkhLh7LPlUz/MDzsZQAWQHBJ1M0XnoQ97GRdLA58+Jy6kAsiHD6GX8RGXIrSXS8/Yk3UgwAjjD7CnTI/I+QvR0LsrE9/0LLAJ/3cBXyqBQImwjDOtvLPXRC3OiWeQpKeWYaUBrCJv3c6SIjRUonodOtbpoY6vTqS9njgW2rAWi7wGxNsuVKq9/KX+opBaqFWplEr5a4aQx52+zVtnz1+mEGSCPr/+SHK6lcjL7ishsh07iEUO2r0RUJ9NFiEfaRpI2fkBQfsXmX09fUBLkS+vbtlYO2TlzSPUCE6LUuqhqpug9kk9EovdNu67u1mek66NYJMrSs3sXfpFaLF2XR1MMGPFUetgJ0P9Bp59hYYWHbZfeTlNlfzj2r70hZ6wznoESfiYtCb5lGqBhagcdwdk/pwY76sSI2LAitxd7T6PPdxfFvgbITeAEWCFL+pOB2HSRLZMs2uOFoEVctmkjnPKmfZIhkIqb+goFRSREEqin+cxt6OR9/MPRqwioardEO+CbhONZ5MxmDQbpy3phNPH52/wy0BCMWT84tMoXQU+cwzCfxxet07Y2XG0G2DygK1AVMOFsYG63HH+58wXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261022075727099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJBR05oUnI1dGNsMGNBOG1heURMTHlHQVhVZ0ErTElUS1AraUVScWpjUHdj?=
 =?utf-8?B?djVLU3NZSDBHRnhZTGlhVjhjL1VNbzU3SFN5R2RwREJzcy9nWGE4Z0E2Undh?=
 =?utf-8?B?aHdsRTZIYUd1WXdNdzhRTlpYbnZFRnZGSVlUUWE4VFNWaHJJdVBDMTBJcWNC?=
 =?utf-8?B?eG92b3RTMDBtZVRTZDhlcnFOdWdIbnUwWWs4UHZBdmg4YzF0SGlNN1EyMnhK?=
 =?utf-8?B?VXEvQUJ5MFpsam5Sd05ndDFKU21TL1NOdVdlaUxLbFZENEZqVHplREEvaEoy?=
 =?utf-8?B?UHdJN0hmcmlMSDl0aGxxUi9Gc0ZmWjVVeUFYR2lBaGJiQzAxNXNJcVdaRVJP?=
 =?utf-8?B?c3pDR1FWTGQwQ215L1M5WkcwdWU1cURtLytLNVhpZGlFYWxkSnNYN2ZVV1ZX?=
 =?utf-8?B?b1YybEFURGN3SmExS1lPcE05M0wzYUxpNFYxZ1hhTktlMzhESU9YRXpmQVNi?=
 =?utf-8?B?R0VPMUpQSDFCWCtwZ3puUUFPNjhGc3NTRmZPd2xrWWJqb3lIQU1Ba2h6M1Bu?=
 =?utf-8?B?ZFlDKzcxVFAzUU03THcwQW5uZW83UHVaOXhPZzdtTnk1RzZ1OUVFUW5KZTJB?=
 =?utf-8?B?aFdJTzdPSWN3dFVIa3BxTzg3cTJoUkJpcCtaQVcxMFY0dUNDYWVRbmdEZVZL?=
 =?utf-8?B?UjVpWndTL3MyNWl1Nks1R1J3L01CQXBuMmlJUytyQStlVG1uWkhuUUliRkdR?=
 =?utf-8?B?bHpVaS90QUxrc1NsMjROOEIwUXg2WWFUKzIrZFJQMEVGRHZRd1RVby81S1Fz?=
 =?utf-8?B?WndJZFRyYmo4YmY5UU5rV1hCNXFnd0N2QzlRU1pjNjQrQTV0aExBeHRyRGIv?=
 =?utf-8?B?WjdvdUV5QVNBbitBMFFvd3dUZENFYmI1eFVFYjMybHpKdmNRdGl3RzVIclJk?=
 =?utf-8?B?bGlNSkFnakg4cmRUNWd1eSs2QmFTK2M3TnZnd3lxQW1ROEh0ME9xSnBaV2l1?=
 =?utf-8?B?SXNwTjdBU1QzYThjVFRrdVJlK3YwOCt1cTFSSUZob1ZwbVBBOEJlcDRPR1gv?=
 =?utf-8?B?NTVhUWlhUitkckhFbXFnZnZJemFDalF5ZU04Rk9iaUppcUV1SysvTTdLWmNw?=
 =?utf-8?B?NGVEOFM0eTB0Q0d3dW8zbXVtVWpFVnBoOFByOXlQTVZxM0xxM01NeU5LMU9K?=
 =?utf-8?B?MzRGNU1lVjBVTGRoSXBjczgwVHNld1c3SXl2bnlJSUZQK01TcXRlYnlnVHpj?=
 =?utf-8?B?anhMNEZVTEZaREFPb3NndDZsUENKMlZ5L3RsYkdhSGFrdE9zbTk3REUzNEt5?=
 =?utf-8?B?ZTJSTzRHbitGN2ZJZmsxeUE1V2NFNGFRRWNhZ29qSld3RlBpODFWbW5IM1o2?=
 =?utf-8?B?YW1NUE9BTE40ZFhRZlIwVEF4bUdMblVibmsrMnc2YkE2eFIxTCtEYWE3WWhi?=
 =?utf-8?B?Ymh1L2xxRE5meEZob0U3QkNxbExwYWJsYjJwQXFscFhiRjkyZmlXeWpPZStl?=
 =?utf-8?B?dTRhL0lZMW1xQUpjMnlFQVNkUUk5V3NCNWcvVG4wcTUvODN5NlFEVmpkSE9P?=
 =?utf-8?B?WENJQnp4U0FOck84Smd3N1E3eHg4K3ZSdllKd3BJbWRweHlFb2lnTDlMaFFJ?=
 =?utf-8?B?SzZaUDZjZkhzN25rWG1JZmpnQVZsUzBGdGVxdGVIZ3Q3YUo2Y0tka0lQUFFx?=
 =?utf-8?B?THpkRFcrVldHaVF3N3BTNXRBS3doQy82OUgyaGszS2dZeFBLcm5PaklpZm5a?=
 =?utf-8?B?ai9OTUhFNTk5VElNcHRWeUlPVmhzT2MyNnhVakNQM1FYUDg4VUxYY0QzWlFQ?=
 =?utf-8?B?d0JvRWtpSS9STktQc2d5M1doTUR6MHZaV0oyRGI5WmJnMVRpUHpidWFGU3VW?=
 =?utf-8?B?WWxkMU96L2djY1FvUHRsZ2p5QmNSSG5rYUU2UHJtQmMyYVpCQXdCQ2pKL3BL?=
 =?utf-8?B?elVjRk9NWlR2Ulh2bnduQUdSU3hHQUZYV2d2d3VIMXEyZDV3MW1VTkdhR3NO?=
 =?utf-8?B?VDNhSkU3VjNCaW1MWGxQUkxvNzBMOENIMXg4LytVUkN1ZXdMcEV1bTJxZ05k?=
 =?utf-8?B?US8yWGF3ajhBa25PbFhEZ0M5SFQ5Z0h3Vmw3UlNyYnZneVpQWTFjWUVQaDZa?=
 =?utf-8?B?dE1pV1Zrc0lWbU1JaG9SVE9jNmVTSkw0OEZHaDlDSmZzcjh3YkRmMk51OC81?=
 =?utf-8?B?eXJZLzdZRUtCL0E5K09ieTBKcFE4eVA2Z21kQU1tMkVIUFlMTXFqY0FtU01J?=
 =?utf-8?B?WjRndml3UEVBS3JNcFRiUzVOVkFqQWN1aUVxMlpGb1FubWhINXgvcE0xOWZ2?=
 =?utf-8?B?dGhFakhRZ3pUMG5HMTJqam82UHlmMzdqRG1FbnlkSVdzRGtUNVFsSERCYWxt?=
 =?utf-8?B?cVNMenhjejJkb0JZNTJwQVdTRm5BcTg0dlcwN0hwSG9qVmVibStQRFdDa1g0?=
 =?utf-8?Q?JTv6SNbEdsM/dwmBVcIckrhtLM1vRPQPrv6hc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8191fbb3-dff6-4921-70ee-08df3c428cdb
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:14:24.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCXZyBVHSIJ/FPm2Gh91sM7Gae2lmRS+BmHB4QA0AhmuDzpGUwmTiw082cql0bkLdXhCT/2Chi8pM2XWGk13KgGhAVaVDevs8LD4p+lHcfEjvB96AdUyGx4VVhn5bq0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded chan->device->dev with dmaengine_get_provider_device()
to avoid direct access to DMA engine internals. The WARN_ON check for
chan->device is no longer needed since already checked return value of
dma_request_chan(). It is impossible dma_chan is not NULL and DMA engine
device is NULL.

Prepare to make struct dma_device private.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 sound/soc/ti/davinci-mcasp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 481d1042ddb6d..e871925517dca 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2477,6 +2477,7 @@ static const char *sdma_prefix = "ti,omap";
 static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 {
 	struct dma_chan *chan;
+	struct device *dma_dev;
 	const char *tmp;
 	int ret = PCM_EDMA;
 
@@ -2488,13 +2489,10 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 	if (IS_ERR(chan))
 		return dev_err_probe(mcasp->dev, PTR_ERR(chan),
 				     "Can't verify DMA configuration\n");
-	if (WARN_ON(!chan->device || !chan->device->dev)) {
-		dma_release_channel(chan);
-		return -EINVAL;
-	}
 
-	if (chan->device->dev->of_node)
-		ret = of_property_read_string(chan->device->dev->of_node,
+	dma_dev = dmaengine_get_provider_device(chan);
+	if (dma_dev->of_node)
+		ret = of_property_read_string(dma_dev->of_node,
 					      "compatible", &tmp);
 	else
 		dev_dbg(mcasp->dev, "DMA controller has no of-node\n");

-- 
2.43.0


