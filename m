Return-Path: <linuxppc-dev+bounces-20071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA6FE5205
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:37:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wz0VLRz304r;
	Fri, 24 Apr 2026 20:36:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026991;
	cv=pass; b=B+PCRBgMQxn3J5MmXZurms6OGoYv+nR+bzA//My00FX3Vu/nMnwgs7DnfMuPvjqR/ATGMkWndzvio/T4N8O5B3BSwBfwtb6aR6izb+VwE6l2oMbonUoYFiBxXpDOomYDDPKjjkhAOBNnhXK3Y2nhMONI86DZgSrrqQ3VaEekfejh+x3/5AzlkC/H2LL5WVXsa0nbPrr5rpxA/IzUSeR3y+XJglrwT/YDGdaHfazh+OfB+rDLgOenTIuP/V3cBwAvYLTzEY7d45ouG0zVY7R1Doq1PzUt3ePSEVzXeQnaF58TPlQMVpxD32wvFhIh5XgMVfs2iJJOgQrSusF7SwAjLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026991; c=relaxed/relaxed;
	bh=K9dLxSF8vWSwDKZjOpV6UUS3KQuTRkuRsAXWgr0KuTA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8iTiqXUcFvjGUcX1F6e0xuVpCA7CCDMgvmyNcAGEpj97rJKq3wzQTWYfHA1hyDHBds8tSpNMZuyqQcUqec5edndfn+Dqxx5gQ/ascrJ7JBbp9vJqDFJHzSIL/Q6nNm4byA32Wg1rAL2mCw77mMR6Wk4rJiKOs9j3+LBdbXApgRNZC7py9ScBrxF8ATTinEloiJCXlhgVPaDXCeQ1THP3e3dCdWLlqeJk4POp+hAZq5a1YrsDG0hvreFH2DtPuxNji0cQpP1EcWyCfpAoQ2wpe61IbO4xVijxCoNZGiz7DpP1tAI5QYxALqZmFm9fDucXYUphs+dznM0R+rGcmt0Zg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SMS8MhD0; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SMS8MhD0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wy2kmsz2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKmKyStqMBdUqWHsTEX+YsBMfl7lM3Re+CSZ9fNNj6Szcp8Omuo5B7T37FxQTq6WIIDu5L2b9zklwZM/2o5bfn0KAwi5BroqQhsO78a+rlh5/SG/qoiYeHJW19+WRZhm5lfIjB2ZF8ouVEmuTNCf9etxKwKrE6EeKZTg0uU2dy4vrhfU0todUoT5qswRR8FNGZbNSGHRMBnBLhNdfDpvVdpTTWnleK0Y1nIoU6arEgtKw5A1NRnG1XIU3fwt5sSjS/EpDQMXvArAiU8mOFj05NpeCNnKGG2VoXrPdS726T+yJfGxRpLixKD788khVaWuo3c/DqJnlXfhWMdULGXdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9dLxSF8vWSwDKZjOpV6UUS3KQuTRkuRsAXWgr0KuTA=;
 b=AhJDXezMsZb7oh/yJHljTW4oPaJPhgCHOcD9jDxBS2ZUCz9Sfaj+kx2qVDkovrEoO3eUNa7Uw2wuGGoDZtkO9usBQdT6lfMdmofYMf/zQKrihBCqzL1P/Gpt648EPxQFsNG4xDH+bT47ogiKvkVbpnOqDtgYIFI8z+ZmSTfAj97QzEnDzt6GPES4AVMYEzhkX2W8FuiesEyUk+ahfsni0PfRStzt7W7fUBDC0sgwIkznAWnOnqdhjS8z3102puiXpLDR1/9CUK1fpBi7AY/fhkdQ6w/EyzDw+/fn6Y9shsFHN3l7vzKQvXO62hjXLZMl58XCWHqxchtVPuvxg++eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9dLxSF8vWSwDKZjOpV6UUS3KQuTRkuRsAXWgr0KuTA=;
 b=SMS8MhD0ZMIlEfmrFpuT9OdZc+QLjFW14VtZLpajacVHD3cjAlTssx9ZmCRatHPJG3N+9ci79lrk7xkFX2xKWY/eD2s+7GKWMPFACbF20ftoZzFaXWfdvY+G/PD8thIrH3wmF3YrpuW7z3CciXdysDUK/g1aqjj1Xw5FfRypQcRN5w1G6c3cQXwQzUtL8uDowwF9aCn3Ds6mId4iXyVEpATKj895DwAPNyFrh2nIBuMme0QwXyuxWnZCAirE66tTJbnfIgd59YaklI12Xblcg44cArvyQpO8ujnu6u0EX3CdvreO5OM4SpoMv4t+Pl8gXrgztPKErmYEV+ezHZXWWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 10:36:07 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:36:07 +0000
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
Subject: [PATCH 2/5] ASoC: fsl-asoc-card: enable ignore_pmdown_time for ASRC case
Date: Fri, 24 Apr 2026 18:38:03 +0800
Message-Id: <20260424103806.2276780-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
References: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: cb50a91d-46d4-4ff6-45c3-08dea1ed4b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IFYwNot4RP4G47tYlm5XlsQ8sTnjfrAhygJQNgQOkaKaX1zeaNZKXubsnMTAK7wKjyl8z7yNAqN0f4cal2P7ybtWmImwGjUIpt+hZJvYfEQWSsRN1rJK577v4Ky0e05bYU998cNjL/SPvmKRh0Buk3VAvTIBgpOS7BFqqa7kWiIwiSkWA2ca6RDFugy/Vy2R715RznxndcVpyw7WqTxpT0zWtYSHKZSIp/BYmmfw2Um0e8ZzbpFQqAI+rP9EiFLUwXlfm5wmJCN9QgJOOoPlCPDP7Y1LD6dHoLRVADg/OrgurgdEaGggF74Lr3cE2s/9IyQpQ60g0e6h9nhScz1Lrd6rXiBVRLaRYcOwDdoYS8lH0lVkueASW1KXeiNjdXk8iU1wPqVdhX/Kg3LJjbVs5VCRLsVoAGCNReePBFF/nZxvfomgX0NGOW+PDUGLfMt6tqev9CeSPdgVVT5/ap+EPL0dOig6iN7mbPakO0ta8vKpXcNorhz/YmaK1jdmWqF11fg5C4QJaYPU3nI7pQS2w3t5dV4BlGpqYykUpZCE4UUpGcNb57c9xLQGrZYYVabI9edr06XYsVA+RCAegS1MlrUwmNtfNiRnv7Bearg35JsIZD+xoa0Mj4UXivjVTYL9cAheda+AiFpTiiPD4O+htun/ryC/wgeivesw5z7cJbIgsUfmLMREt4BpwqHjI6IPiSkaFc6M4Ae9XIlZhfYNWFsFiyPOD/NH76f73p1qcwvPpPYOQYW4/J/5ho56Bi2PEbyrqV23WXhrq1ZYMzU16yFGn3azuVdFLjiIl0J41fS4AEStIKWlzeiFNQ8yLVLy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDBnZGY2cUU4MGp2dEdLWXNzcmMvbUpRaFBmYkdCeFFZcmtyUE1qUGM5cjJZ?=
 =?utf-8?B?ZklPTERGMEJBWWNOKzB1azhBQ2pRbDBaeVdGT0lFS0ErcFY5MWFGaFNoUExW?=
 =?utf-8?B?S240Z21yNmNjNmcvYmsyUXZ4WldGNk9NWENVc3RIUm4xQWxjRnZJbUZITXVs?=
 =?utf-8?B?dE4rbW1weVFvM0ZIUVNPWXk4Ukh3OCtSRDJjZ0x6VTAzNVZzQWw3OUxmUzZT?=
 =?utf-8?B?akpZMUx4eUNyanNsb2kzekkxVTRUUEx0Nm54cHJoaHVKaldiTmtVUDNZMDZP?=
 =?utf-8?B?QmJsY08zNGZVTmJtaW1STCtNT2s2cERzVzRVeFdweWp0QlFLN0FMTXlOUlB2?=
 =?utf-8?B?YkZuNWh3ZEZNWEZ2eUVYQVNNUTl2c3NnVk5jdmswQlEwSWZ3QWtsdUpWNWxm?=
 =?utf-8?B?ejkwUjM0cVNiRzlDSFI4TGUyWTVJUjlERVpQZUt5TkI2ZTkrTTRlcDlRR0Uz?=
 =?utf-8?B?NGZDWGg4dXFKaXdJVkk3Snh5Q1ZjT05ZZHdKa3pPUjBMcFI3T2VBWUYrS3FF?=
 =?utf-8?B?M3hhMjB6RDdaSmFGYUh6R2x2Yk40RFYrYWpTV3hBeExCVjNKN2c4ZGNmQ0pY?=
 =?utf-8?B?UDNTOFo3QVZLQTh1MFBIYWVpcmcreHN0MkN5SHkvNlVtd3AwNjE4UmJ1RkZU?=
 =?utf-8?B?V1F3TkdoQ1FKUFY0L3RPRkhBQjY5RnUvaUxUS3lvdERPSWE3alFWUFNJaDFG?=
 =?utf-8?B?aG8wb0lhSHVtajA5TGRyQWhWMmZYOG5lS21wTGFkNDl2bVltV1NNSlF3QTl1?=
 =?utf-8?B?d3VOWkl5d2tCK2FCRlVGREZPR2lSRVVBdk5hKzFLVElDNkZMdUYvQnhjM21X?=
 =?utf-8?B?RS9wYVg0eUo0RmVkSFdsK3ZjN284VHE1eVBoZlMxTlVVNzh5Y2ZFUy8xM29U?=
 =?utf-8?B?dWR3V3IvNTQycHJGR3hkU2F2WGsvTldIU2xabFk0NkNkUGxVZnBCaFFoeUgr?=
 =?utf-8?B?RWFxY3ViZG8rRmtETzk2cnlCeisrTGZyMU9YT2lVdVY3SWE5TUsvanBUUUhT?=
 =?utf-8?B?UzJvTGFYeWQ0Y3hqdHBQVUo1ckplc1B5U0t6aDZRMjJFbEFzc1V5dy9ETTIv?=
 =?utf-8?B?VWV3ZVhQU29NK1NZcGlJdjd0OGo4cmtBUFZ0b1hYWnVMcTJNRzVyYldLWmhH?=
 =?utf-8?B?NVkrRjlnbHQrcERVbEhmT00xSE1CZGY1bzlqMWd4N054TWZ5eW03ZStrWnMr?=
 =?utf-8?B?MFpFeTZnY2dXOHhuMmZKWVFQN0IrcGFubUpCUFFWWjZ2RjZ4ZFFlWDZzeVJt?=
 =?utf-8?B?OVZsU2tJVDdXb0VpTHBXaHYvM2hxUlhsbm5XUE9ZelJDT0NoWC9OeVlMWjhw?=
 =?utf-8?B?Q1Y4YWJEc3lUV1ExMnFDS2xVZjVNMlZHaHMxZWlRUTZ6cFIrVVFzRWo4ZGVJ?=
 =?utf-8?B?TzFMS0c2amZOSlN0V1dVWDlTblQrajRBWEhFdDhOMGdWRHRhM3U0NzlwTitJ?=
 =?utf-8?B?M2hMbnRRTDVkekJXdE94QUJUbFJIMVRRWkZCaHR2MzV0cndKM1lvT3pRWUR4?=
 =?utf-8?B?VnZna09GNGFCeEpVR1BFYmZvYW1yU2lIUmJIcHNEdlB2YWtCSlArQkZzZWNL?=
 =?utf-8?B?WEo1MlYrZmVpb2s2U1F6UUV1eWdNQ2pPaUl4QitkR0ZwYXZwZDJiNTNScXFi?=
 =?utf-8?B?alNhQmtSaGFGMjczWDk2SmQ5M0M1Y1lLdjJVbXNJR3ZWMVR5M28yS0xYdkdY?=
 =?utf-8?B?Q2JxZTBDQVFDSW94NzBjOHJXNVQzaWxTMzF5aXBBYm5IS2lzNkkrTUdKWVhT?=
 =?utf-8?B?cUlQendUUlh2OGs5M25seUp1ZHV2ZG5UKytkM25TWW9MOXBRNmVMMXRKZVhh?=
 =?utf-8?B?RlRrUm1nQkl4eWNSbStnR2I4K1ZETng1Y09HbFNkR2V6cHQyZlkrUGNnREs1?=
 =?utf-8?B?Qi9NalJMWW9USENxTFc4NkNaTTI1WkpmNU1KNWxoQStrakNKL2Qvb3RqTHRL?=
 =?utf-8?B?L2I0cVBudDhSSXo0M3NibkE1WmNKQTE2Yi9iblE0T05zUVR6SlRNTkl6QXk1?=
 =?utf-8?B?NmU1dW11WStFZWRvTlZaTFg3SUxJZ3BSTE1jRWxLUDJHOWN6b1pWZGI2Nmcv?=
 =?utf-8?B?MHdnUUxpV1BYemVad1k2Y2ZsOGE2SThqSXgrRFpFSVVUNHlJWVdHdFRLUGVz?=
 =?utf-8?B?a3ZndkNGVzgzV2w5MmNQYmhzZ0Uyc3Q5bHlaK2l6K1NtL05aSnNlYUNkdkEv?=
 =?utf-8?B?eDhVc2tpMUIrZHpDeG5id0tqWmo5MFVRbW5qNmNSWC9Bbmx0WnhTa1RaWkFy?=
 =?utf-8?B?RVhYN1RZRk5mV2hHYjc5Sm9yNTl6d3RTY2FmUGU3bnREZUlFQTVrS0VEeG9D?=
 =?utf-8?B?MGRGdXVtclh6ZjFLRThiY25FdzFmbW1IbUc2RlUxZXR6VWtSODBqdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb50a91d-46d4-4ff6-45c3-08dea1ed4b11
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:36:07.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4isY/aYaopU8Dzk3AvhnoNC7Fm2n2+GZlTIePFU6NyzWPs3xfPTUVnRXeFzjV8moHocRHU4TF0LQP+IKgjmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

Problem:
When switching from ASRC path (hw:0,1) to direct path (hw:0,0),
audio stops after 5 seconds due to DAPM powering down shared widgets.

Scenario:
1. Play on hw:0,1 (ASRC): ASRC-Playback → CPU-Playback → Codec
2. Stop playback
3. Play on hw:0,0 (Direct): CPU-Playback → Codec
4. After 5s: No sound (DAPM powered down CPU-Playback)

Root Cause:
DAPM sees ASRC-Playback disconnected and powers down the entire
path including CPU-Playback, even though CPU-Playback is still
needed for the direct path.

Solution:
Enable ignore_pmdown_time for DPCM links to prevent premature
widget power-down when switching between paths.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 41cd2fc2ea56..e08e135886f7 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -990,6 +990,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (asrc_pdev) {
 		/* DPCM DAI Links only if ASRC exists */
 		priv->dai_link[1].dpcm_merged_chan = 1;
+		priv->dai_link[1].ignore_pmdown_time = 1;
 		priv->dai_link[1].cpus->of_node = asrc_np;
 		priv->dai_link[1].platforms->of_node = asrc_np;
 		for_each_link_codecs((&(priv->dai_link[2])), codec_idx, codec_comp) {
@@ -999,6 +1000,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		}
 		priv->dai_link[2].cpus->of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
+		priv->dai_link[2].ignore_pmdown_time = 1;
 		priv->card.num_links = 3;
 
 		ret = of_property_read_u32(asrc_np, "fsl,asrc-rate",
-- 
2.34.1


