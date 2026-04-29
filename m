Return-Path: <linuxppc-dev+bounces-20263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A4CFF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5CSD1Q5Dz2ySW;
	Wed, 29 Apr 2026 19:58:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777456732;
	cv=pass; b=PfqlW7Ijw/qxto4pPGEdv0sN46SbVy+MIabJ/xC6j0PSP2MSnKU+NK6KHSR0VWUo86hINTd3Ac+Sk6yL3322vn0XjOidXL0pT2GIXzgmjO3jJtYOYKMbSXGh09cmUu9MZZkGlVt+JllRq7cz7xYMpnHy0WpuDHAmgMLyy3e+lTiyqEAkiv+ATdYEOm8T/q+ZQCiNtZRxTulmyQ+a+Cv2dyM5jFocidbYki2UwwM33IfxpKGU4nDxXrpgILnw2u0U7TkSidnzJkwvqsaz2VbkO8Kqut3xIYC366XhBILpOtabwkmQ0omVOrdGp14Ia5IYobUwDpIwKGgiMLSN/6KnoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777456732; c=relaxed/relaxed;
	bh=tRX3/UDPpCV37UoQdRe0cQoKbAmw62tB4pR7VSu4JNE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WqYm+Kc9bCGD2h2/pLV3dHF6wsGd63fG+IdANGP8MmTi26+nkw5BVosY/sFoNvbGQR4RgV5iwGGM5OOlFyS/D2mqPcEJabZlTtlJ72WZhqb/ebkDm5wuJq0qRv1bfz32sYgdAn4eAiOs6RDF9c6EsE7Gse6seUP48ai/ZX1zj0vyhRZ7T+dGvOeq7kZlkyxLn7XeMMm07evrRSKkAMEC243qs09aNMsAxnm2sKo3xG8h5c+E2KLjnnXlLkcUgYzDBs0nnRV0vZye0QXrsFlTblCF2kRiZPOTL6epvjWLnDp0mbLDRFCGlk3XZe5ZXGU8mRFVK2+4dYOJvahyR1hzfQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GpLTWPoL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GpLTWPoL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5CSB3FyPz2xSB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 19:58:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcmnyBm8sc35pBjlqsv7CFnCunQTv6k/xJH8pryyqFPlRxL7EqNGuqT2n7JjBymefu2nGG5PtmDhEu4M2CeaAKdkoPoRFS1EaJ34k0Y1WD6CIl5nN5C1Air3aB8Fq4iR2aZC33xoo/3gYYeqY2zN67NYFIUx+MGn0dqDl1Bt7kye98ADypR9daccjWAvb2HBpD8SZUGJJtNRKbfNbSxM59w56a+DfZ/GqBKYzg1wtz6oeOKy89Xq4N2cFHLmUD6BTRgOYTKoWiv0t9mxzWg0fnBz1m3/k10au++n8B4sA4sPeO1OtDKtHvJv/kSoLAbIbVxUvXtgaspNZOuwuUt5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRX3/UDPpCV37UoQdRe0cQoKbAmw62tB4pR7VSu4JNE=;
 b=x2nYTHphRQeAq7n6tBC9TWLqcj2avvqIgxIJoGFa+JpOZysaxg1coulHF82JUkcDrMU4uwyTXu0s/+igkqVhbd23IC7U6hoRRMXtglskFWSS+Z0csQMTz0bwh2hGHSPVpnwevu9I6NT26tHEkA1KFf/GTRwPqQ5w2Wf14gWfbhZFDxkoAA/1VUvQFuhYvqfRn7RmZTPjFKtZfZcLSBrEO6E3Mo2lhqfV8FeF0sKaHU270YHCg5uPfIb0t77OfTJWC+uYiznLjZBeMiCQEQ1Pt6/6Ddjn3iH+XbUmO7TlDTN4vzCpQClx3dQk4vKuEXucwLVIG0CuXYjBjgHlPJfu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRX3/UDPpCV37UoQdRe0cQoKbAmw62tB4pR7VSu4JNE=;
 b=GpLTWPoLYelY05j6dDiFtKDSCdPPvE/c4RBINobFHmZyETxa823smDRbUP55hW3c2UgJNWMMtIFdrD0GnnQwEyVM529BNVngr5sqrWlh6J3eD7to+6KIleE1SBJMU14XTNhJmuzM/NW+VRupfaQ4S0J5kc5WkWZZ2vjkJwjjjdK566O1EV3/Le7r7cpTkOyYHV5SmcNvM0lJCza1Kv8h+zZLwm6b+hnW5NxLWRNlHwAaXdGddzZVnEQpXBkiNFwlmymu/5KcjloC4hFbLMa48mHK5wD4WtX16RNfBCVE6RLbSQ6iFT6/41XMnSe+KAPuPtuUDVLlPULefASXt9vZsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:58:26 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:58:26 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] ASoC: fsl-asoc-card: Add some improvements
Date: Wed, 29 Apr 2026 18:00:22 +0800
Message-Id: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de8a985-ef2b-4fd0-890d-08dea5d5db91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	BLpAPS3O4Eb8+5Ta6PX7/m/TGCQ3nGG+gejot4cnrrr7InYIJQWVe1/aNCp94XvTn8H4lKpijz6DquEkOqd153acL4Vmq2DQ1zEA7MtK8wIw6uZbAb3wzxtPxl4T58g+b4wXq5HBpNZ8gUeOMYVFOOg4KYhC0GZY/5GreVFCNz+kpkdxcubW13g3jQkm9v7Uy/d+5fMIj+0sL73iylZm6yO7kwFwulvKr58pKZCE5cgMsRh5KHu2diOZllNEbwMtC9xm4BMWNcPBu03/skeLxLK3bHFkt+ZHvKLf2EQ1stpWyHoHaN7Uikfl0a3uhNhS2nGnL9QZ7O3VygKDyyfd5T2r1c1PPUpQWL98N3uI2GrwJ72GjqgNq6MMvLtqChlLANzXwTdBd8buqRcS2E5sM7usioEyVtW8XFfx8UI3RjV4qSo+0Dzeg6E5fTvSocn4bmUhyHlPwgISDLMNEKvTILf5sHVt2X1e+LbqPsUPJqeV4DsKB/i3TmSMd1nfL555sTCUE1/RPZwX5TTeM7SbuXzD80kAyh3igNQ76H5OMsGuHTR9+dHjZmjmxj7sbqGrw6VHYn9dpanGlZ41DT0e9qmZgLve4pR8275FOVhntNRDN3kpPFm4BC/F0bXs9jIvGJYhyz/DxBujvT9Niu2f1mi+4LW02n7QqlaU27K6BGaEKq+on4erZ15ZEWxRjM808yRpK8pVpShX9DWxtBGjCKZGw+qLD52k3gB/NruQAlunauUP8ECtM8+bPDvmTbs1nHwVQGZjCrGgSL7vLmuhvS2/so7PyZe/oEg4i3IQt+ty6J85kgeCg5OqbfE7WdDH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(56012099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFEVS9mWU1GMHlVZVpKbFFvc1VyOTA3UVpORkRNcUZmeUFLYUxHYVFLdktZ?=
 =?utf-8?B?a3hJS01RZWRJMXI4MXFJTENCSG9JWlQ2YURWWE5mMTJCTk5OKzZ0eFZyclZZ?=
 =?utf-8?B?dlNVYXMrb01qbVZQNVVzanpNMWdjMzN3dWxmcEhZcnpyY2Q3VEROUWlUZkRS?=
 =?utf-8?B?Nk96UEtPOHIwODZXeHNpUTRTaVN6bk5wM0ZuQzhDVUJGMUxEalFma3FhUU8y?=
 =?utf-8?B?enBIbENnOERrYkd3b2QwQUhSNXRjK2tEM0o3RnZESTZ5Ym5wSzFHZkJVbUhZ?=
 =?utf-8?B?Y29LYzBvLzJjUkN0Y0lLSGlVRXcwajg0NGpOVFhqQk14em9ZNGRCTnFENHln?=
 =?utf-8?B?cU9MMEJoaVJlZmk2dWxuUzZCQ1RiamthRnNWMTRaU1YyTWNBMkNFazZMYTFU?=
 =?utf-8?B?VmNkOVVFa1dVRjQxQlRJZWZUNGJ1Q3IxQVBNanp2ZlNkZ1VCSUlHVUc1MFRm?=
 =?utf-8?B?ejUvak55djY4MTR2cElHUmtld1hva0VFV3lBa2JFdmhOMG0raHBQMjQ3N0Ev?=
 =?utf-8?B?TWEyZzZCQkk0WFNwVTNodHMyc1QvVm40YUdJRFJVWTBQRGtzUGx4N2xJNjRQ?=
 =?utf-8?B?OTZ1RjIxMUpQSDYxdFJPclUxd3RHSHQvRGYvYUszWlZsM2NDUXllUjZWMVgx?=
 =?utf-8?B?QWtSU29aN01oSzRpZlAvQkF2LzlSMkoveWFOOFpxajZpKzNSTzUxTkcvUjZY?=
 =?utf-8?B?UjU0SkM4RW1DY1A0cml2NFdxdE1hQzVPWW1FemxFd0RFRnBTUzFaUmpKanNo?=
 =?utf-8?B?eDNBRTVXcnlZZWJmaXpSdW1mOWErRy8rMEwrWGxsdVFaeWdGVGRMUjJBRUpu?=
 =?utf-8?B?cjNBNlZ2SWNMRWRnY09PbVpPeGRiREF4TzVWMmR3SzNQVS84ZWpESWRwWnZC?=
 =?utf-8?B?QktRbU1GMFlTRmQwUmFuNWpLTzEydFNCaDdZakdUSmdVSWYwUTNLVzFaSVdU?=
 =?utf-8?B?akNSQ1dnNGJKWlpNRWJYN2V5dWN4ZVYvaWVveVlCaGl1Y01mWWVTSExlQlJF?=
 =?utf-8?B?VkxXbEdnUkhmRzNjeHZaZFMvMkloRE1RRFJ3NWR3YUszNHZzVzNMa04wL3R4?=
 =?utf-8?B?MXJxaERzYmd5a3dxV0VIT0dzVm1rdEpIK1RtOXl4WW5ydk82Z1FMRDZTeERI?=
 =?utf-8?B?RTBWbDFxcnZvdlhvZUpqOHU3bXdIVFQzUi9XSUFSeVFYd0wyUmZNTlhkTm53?=
 =?utf-8?B?K0c5RDMrKzFyZHZUY2RNMmVXbjJ5bDdaVDlUZThRZ2QxNHhxYU9DTGZUOE1O?=
 =?utf-8?B?bENLSG9UM0VzOEtYZXlKS05zNmVIUDMyVWdoNkNUZCtlajVXZEJGTWZYbGVT?=
 =?utf-8?B?UE1WQ0VodDBWallQUHhHN1ZlaFN6MjlvN0ZlTDZLUFhsZ0R1aXpmU2R2bDQ4?=
 =?utf-8?B?TFpNYUdMOFFQTjlBTmNkNkREVWExRld5ZThmN0dTV2FLMEtOVE1KMFdnak1X?=
 =?utf-8?B?cUxhcGp2UFVkUlRxNEFEUENTZS9RaUxHcTY3S3oxN1FQUjRWSVh0V3ZWYVBl?=
 =?utf-8?B?c242NW13ZWRSZ3Bpd1NIeE5LR1dMQ0dsMWU0UzNaK0JIcVZMc3hoeFZRK2ZB?=
 =?utf-8?B?QmxGTGNudkx1TEtCYTU1M3EzY25QYmNhaG9FZTcrOGJvVnNFcVVUSkw0cEIz?=
 =?utf-8?B?N2YyODZqUUFOL1dXaEJORkpFQnVSano2N1UxdGlCRk5EZm9JNkhteGpOQ291?=
 =?utf-8?B?T1phcUFNT0QrZEc4bUFsTHZ2c0tPbjB2bksrZ2lacVRtbFlDbUNEUmJqRlp3?=
 =?utf-8?B?MDFhblliRWo2QnpNekFsTTV4VTd5Y3UrSVh6SktOZFhjTHNXVVozVFhTclMx?=
 =?utf-8?B?b2xjejM1Y3N1N1RZQzVIRGp3bUd0SkdvV3NNUlR6YkFsS05Wa1lBdW5HWkVT?=
 =?utf-8?B?RjJzaHpLbDlTVnpFUDBzNDMxbWwzc3VWSFp3bjl1TVFGV0FNYlFZWFM0VGVM?=
 =?utf-8?B?aVZ0YlZpYWFFVmRheVR3a213dWlSdTJDSXZSVkVTM29tVDlIbHRtWVVJR3hW?=
 =?utf-8?B?YUJLUC9jNk9VMWJFc2Y5bXFnWjBYY0thOWgwdHBucXdPK0ZETS9LeDk2ckZQ?=
 =?utf-8?B?TGJVWW50Z3R6akdlZU9hMGtFYUU3ZzdRbnhzNk1kQWhnYjRlUWEyZFRSbjJn?=
 =?utf-8?B?aSt4L2J4MElVU0UxSEVZNzJKVzN0R2NEYldhMjAzOWxhOXpRM1ZoRkU5UXV6?=
 =?utf-8?B?M1pIVlhYU3dvZzN0VURuMTd0bGF4NmxDTkFIWG5xbXQ4djRhRWNmMW1vM1Ux?=
 =?utf-8?B?d0FkMExxajZYWFNjTzUyRUZ3VVQ0VFQ2VU5QdFhtcWYzTHBEQk5GQ1J2ZWNu?=
 =?utf-8?B?U00xNkQ2QlZzb2dyQ21LVHhqSDY2cGZ5bmhzb1FRaGw0YmJBdUR0Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de8a985-ef2b-4fd0-890d-08dea5d5db91
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:58:26.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWyczq+OEuHgWEMBf6SpsIoJOseu0JZ2udVZgNUnGhL7GhCNipiVtojlOgTIXFugL8R5D2BAEftYkiAuj2TUcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

This patch series addresses several issues in the Freescale Generic ASoC
Sound Card driver related to hardware limitations, DPCM path switching,
and codec-specific constraints.

The fsl-asoc-card driver provides a generic machine driver for i.MX SoCs,
supporting various codecs and optional ASRC (Asynchronous Sample Rate
Converter) for sample rate conversion. During testing several issues were
identified:

1. Missing channel constraint propagation in DPCM mode
2. DPCM path switching causing audio dropouts
3. Hardware channel alignment requirements
4. Clock generation limitations preventing certain audio formats
5. Codec-specific PLL frequency violations

changes in v2:
- Patch 3/5: remove the static constraint_rates and constraint_channels
  variable in fsl_asoc_card_startup(), move them to
  struct fsl_asoc_card_priv, to avoid conflict with other instance
- Patch 4/5: make exclude S20_3LE format specific to WM8960/WM8962 + SAI
  case, to avoid impact to other users.

Shengjiu Wang (5):
  ASoC: fsl-asoc-card: enable dpcm_merged_chan flag for ASRC frontend
  ASoC: fsl-asoc-card: enable ignore_pmdown_time for ASRC case
  ASoC: fsl-asoc-card: add channel and rate constraints for CS42888
  ASoC: fsl-asoc-card: exclude S20_3LE format for WM8960/WM8962 + SAI
  ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit

 sound/soc/fsl/fsl-asoc-card.c | 111 +++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

-- 
2.34.1


