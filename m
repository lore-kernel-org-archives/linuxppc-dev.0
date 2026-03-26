Return-Path: <linuxppc-dev+bounces-18808-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25C4109E557
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:29:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDQ15vNQz2yVB;
	Thu, 26 Mar 2026 17:29:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506553;
	cv=pass; b=EkMMSKNEsuWjZMadhGGTRIxg72S1RW5kPjXHGTQSRsOe8unH/tc5Rn0ZDKYb/FlJ06VO7vjTZU0rtZAhianZxEfVdV6ItBoNB28cn2J63Nf7XpaPLgIx+zHQmx5gG9nI4iStwD47KiKH0C+7HxK5HaO/0fi1I4ic7ZgTz8EK8MTVqYKPOMjtnlUIrB718PcB2qkT09Gn6bFoLhzK5kvsZG3EzArXFUAp340ptuIsfmAlLNa74vf4BrlDylZguCK9I5JxXfko2TdwrxTvWFg/klIXvtgRy8U1lcfO2HbgwXDWuQN1nqr0qPc0doaMOaK2dM76b4M2YmgTOO3nLpZ/JA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506553; c=relaxed/relaxed;
	bh=/6nlRTpHMgt5mvwWW8S4US6vJELigzdXRG9K0G4dKzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPX417IP63Rtxy+1yvijNw0amBocTtVv9nsi6JWKyHxd8JHz9e+zuwSOkHQ4ayoqt7FLifNvqRmFX8d1Zr69u7Awb4i9aTgBG9q+VYlouzMozCmmrtyTl22x6fs8JpCcUVPVX4JglHrZG9yKsVSp+AWrVmlPcc7vJvM8P3EtNtWrIt0xvSeRAZclQJvD/oZHzNWXfTWVIV7yI/kC8YzCZ+ieVfy/mNFtCQ/npLmo0Oyo54WFR689wbDgFpj5v24DZCRt/IqM5eP5RgYMUN2YQHKMIO8k5S+ZhCjEyeK8jxCjC2PtRrBwa/paVBZuEr3fThR18c02jWRcVvvpxbXTvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=T0krAky6; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=T0krAky6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDQ04Y05z2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:29:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn0s+QEvK1xXfTRuvyncT2xxKinPsw9smeDTh+h3nvsQYYATfynzy3lcEDSiIta2zhYkkpkAKaEl0BzWtR1x312U5ay6i9P41MyRESlmkj6hEwFGCCCuTa4oMbW6ZDMywqsjmCUUf55eZyz6dJhA7390GFZ3VXcpm0fU79oIKRQVWx+KgXzb5oz2GuQNNeBQsu09J496OnsIl/ohLicclqUbnb3Bq7GtCOXySZgOhyvwJBuO8bEF33lxNJrAAEsQJS1hO0BkeEJVfqxKNx3NlLrpg5PlQK6IwZP7gByup3j5Zy45RchqNI5Ggji62QIObyZG46ywkndxoTtZ3J/zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6nlRTpHMgt5mvwWW8S4US6vJELigzdXRG9K0G4dKzU=;
 b=cx9kpPibgKhvTWWTnRUoYHL43foRH9zx5KPfM2R20fanERcgU03DeL8jLnk5Ynxd2981319czqNAIw25PsBRvyplNkAYgAvzkOn2NJXhaD2YG7YAPQPauOTaIk8JcOlFURnLZufjRmJGUKrgHXbl8qkRvry/0NjjQrOlz3olFU18rU/g/lbuQrlapPlRpWi978wgDjrqrC5Ftz19N6/D18chkBRx/2OzAYwDDj10KnHCzodSlO2YrqI6EEuQY+sn8wcirkhU/VTqGDQGNJnWup96lX2VhLCduVRM49AwZXoqBglSAqSaT/OgC/WQ8aqsWb76j4uOQuJi5Bfmf8pPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6nlRTpHMgt5mvwWW8S4US6vJELigzdXRG9K0G4dKzU=;
 b=T0krAky6ziEMNI1g30Mo/GQRiOp61z5bNjzOmoemt2aHndIBo0202++LyBcRJB71+ek7H0rFWfeg823bTqwyhlpLikkvU1x9YVmPzW49BFm5Jid06gBgPOgfz2Al6GzM6/gks8O/NWT33pjlIySCLpuELqMWFI285bIga/oT3XtR9g0gVZUCALlO+MOd2kTOFQL9ENFGZyId+YWyT+cbBn3hOYTvofANLPfW/0HXRY8KYOUUh/oY1RQsO/ljkPtFlKp4WiemxGn82A1r5aqgcqnw52LCpUs5nkeEAG3szfzBvm0B48xUmYjdPxHaOMHdd5P/AuMikP0VHxZxpKq78Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:28:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Thu, 26 Mar 2026 14:29:16 +0800
Message-Id: <20260326062917.3552334-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: daf62e8d-94fb-4b93-492a-08de8b00f3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kNsKICgHe1DjM/Vt9grHwwo/DlCYWAFONhX2OWdUOtal6vCX4RYy3OaxMYZ7J9Tqh1Oh+aJ4u6coNeSwvkOfgghIQzSYpqa6B3k31sPR1HUSATtJ91JVgGJFdYRKY094PWfsj79xoqeXfx8PCxSB4/OFlj3P0EZbvtYchdn9RsTsPs7zF4jCZRb5a+2LQk4wsetzibWbXqRbhbCXd1aSQLLrqx7lw7uL7wct4U13Uz78e4i410qhdQQH5gYyxaK6Awz+XCwbhy1VXqE8Ui8UYBUUSPNXc4+bom8wszV/EfYbvW7Tdv8FcOlcx3cEfV50vqNyJ/jBgJBn2hvITPfwvh957bOQ5tzmlirbR/Se55jpQdLC9hJfZknRZdCYie/K5vibhp7sIWot0fYu8jkaTWida3XG3ZABd5D8Hj4xAHtbt3InPuRKtwKTHT+kiJODZ99zkFHIsegM+jgG3OWUJOJ8yXFZaOK3KgX140yrRXuQLXH7+/2yAhLiFSMPrgCu7EnCAhHc30DVnT5RiPN7Lw+7XYn6Z95Sb/U6x9sBYGePnwqW2X2DBvOabVLBUIHk4hb7Ow1O3Q9l2ddJQ5BhbnKFKZo0P5Wo1HWM7zEAoN43sbLJRpz/TZJyX9+YSc3oO+jBuONL8F9kBwGdvQSOtOQ+K91t2bly9uFOe7GQ5fjG135xImFWLa9kDKgBpgtCVNcpQIlY5qN7woxeiFsv9O+HKzJ4Q7TFBmYPT7g2ag5izVEh8bYGaBDPixlUErWFfsEidJLrNA2yh1A65zOEBf63W3P2xzEtxhLbvzmciX/h0Is80ArsU6A2Wzo5ITPF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGl0SG15dXp4b1BobjExR3NXc1NXam9oVTZHMkNZYmUzZ2VNMnl2WWVXcmlW?=
 =?utf-8?B?cG1IdmM0ekFtYi8vaVh1V3kyTGUrZ3hyMWVSUERXQWdZT1J5SEw3ZmlLbGNy?=
 =?utf-8?B?WnBYWFc0TE14SENML2FaOVAzR1dWYjRhRWpGUzU1ZUIzQkxiYkZnM0YvZGNH?=
 =?utf-8?B?QjIvTDE1NkNhR2F1SGpnSmUwakhVNlh3MGVsOWlxMkE5MWRWalduMnpiRmRu?=
 =?utf-8?B?YVo1aEMyWndPVVhrN3RrelR5RTJoUFJwOWpvdVZPN2ttMWp0QWtJYWhKaUxp?=
 =?utf-8?B?MmVIWVhTaWJBRVFGcmUrNmp6SnFOd1MzU3hYTWE2Y1l1c3dDaFNTdU93b0lv?=
 =?utf-8?B?b3pYNjh1WDBhSXN5YVNYL1JPenVWSCtSNkJFTVRoOFU3ZWdMejBOZXVpSEVX?=
 =?utf-8?B?d2RkQ3hDQVN4K092a1k0SGluM3I5ajZtWDVQVERDNFU0bXFObkVzN1hVclRn?=
 =?utf-8?B?ZUtWTHIza1NsYXZRODYxNHk1UnpNTVJJcFI3dVk2R0xnV1J4RWJndGVLQzR6?=
 =?utf-8?B?UnNrLysySjRMcEgrZlNBYXE4aElLVVY5TVM5aWV6dTVYN2hjT2dCcElRVUd6?=
 =?utf-8?B?Y1BGR3p1R3VCeXJqeTJYRVRScm1iQkFaNUV6VmdjY2tiT3A5UmdtZ3dlRXZF?=
 =?utf-8?B?bDByNkw1VHhOTTlRc2UvNS9mSGNVY0pSbGJqbnJOQnFHakN5dTQwRDdzbUFy?=
 =?utf-8?B?RDRGUXROa1l3bVlvOXcrYVBNK1k4RmI5VjZCMFJabEpsZ3JkVll0TExTUjBl?=
 =?utf-8?B?UHdOeW5qc1FsdXJLK3piaXZMK3dHdU5ieHFWUWpja3dJbTJJaU9wMTg1UXFw?=
 =?utf-8?B?dFZ3ZFdXWlhidE9oZXBUUmhkV3ArRDMvYmlIbk1sbFdXUkNWc01adkxHMTM1?=
 =?utf-8?B?bG9VVUVhTlJiV09rZzFxRldsVlBKT3BSWnFua1U5SU1Qc1pqWFBQMGFlTlE4?=
 =?utf-8?B?Qms3SGJscnhjamFtang2OU1uNlRjMFNVenRGRDV3OVlJbmRBeTVZVlpONGwv?=
 =?utf-8?B?ZE5sRnVlcVpjaHUvY0RVZHcxbWhNRlZ0MEZ3SE1lMjFjTFdwOTJWczJIY21B?=
 =?utf-8?B?K1dRY3VSb2xPeHZ3NFJDUTVSYXlPVHAwZEdIN3ZhdGdHbTRQZVZwRHVoWUFH?=
 =?utf-8?B?S1dIM0c4OGxmL2xrMEpYQ2pjUStFYjJTSGhvY3M0UkgzTlBSYnk4OFdBQ3NH?=
 =?utf-8?B?RHl3S2pTR3doYkkrMVdVQThDeWtGS3lOLzB2bW82NmtLZVdLQkxjOENldWQv?=
 =?utf-8?B?WjVsUzhkeVV4NkwvNFFuWVZWVURYMG9GRHZLS1grcUtJcnByeWhNR29qTkhD?=
 =?utf-8?B?ckpwRzV6dlBwK0hUREhhVmtuUXhxV1d4Z0lWeDZGdTdRUmxIZjVaWU9xWnI5?=
 =?utf-8?B?T1FoT0UwUUhUbG93SDcvVHZNVVhVbXpQL1dyUjZrZDZYOVdxWEU2OVByMGYy?=
 =?utf-8?B?R3NlalB6bS84TnJtalhHR1FGQkkwdjBmZXJtNHpWL08rNUc0M0E1NEZJMXFJ?=
 =?utf-8?B?NnNSdURvSnJldVRvUDd6RlVwZGJOV200WU8wWWxiVWppM05wbDlsdEhNemxy?=
 =?utf-8?B?eUJiUUNDb1poUGg4a09PdjBCWi80cmc2MGxvVGN4OXQwaU5WY3VrZDQ3YjFi?=
 =?utf-8?B?MFNNQy9YVGM1dGdQMG5VNEw4ak15aVNpR3pYSVRQbDlZWFd4R0V4SXhGMG9Y?=
 =?utf-8?B?dVpTTUFBdTBscjRDeCs1a2VIVjJnTFEwK1RodFEzQ3E1OUtXZThMVHZmbE5N?=
 =?utf-8?B?VG9oRXY1V3dkcDhYSTYySzdOTkJwaXFLbW1XODVTa3o0UDJyYzFKbFowMGtN?=
 =?utf-8?B?TkRNelo1SStkK2JYZmp5S0NIMFgvRm5BWkptL1R5VUdSQjhnb2tYU0FaY3Vx?=
 =?utf-8?B?RlkxZXR6YkduRE9JNDZVOHYrc2FBSEU3RnpBWFNabnlzQ2JZMnpJTUtGbjhU?=
 =?utf-8?B?QzBXWHhWMlBXTXdZZnZjRVFJZnJOVnVJWUtpbG00a3QrTnk3T1plRzlteEd6?=
 =?utf-8?B?a3NHaUhwdHkzN1pic1pGN3BkYlAwTVFSZERoSGEraGhldTEvS2RDNUdzMStS?=
 =?utf-8?B?V2xHMUZISURyVjF0VUtWdTlOTlFPaXNVRFpIRTA1aElZMk1tMVJZYmwvQXlS?=
 =?utf-8?B?SXBCdno2NkRmY1lFdG1qVTBIUU1aMk9kelNkMS9qd0hjVFROY082OTdGVCt1?=
 =?utf-8?B?QmR1bGhtbEU3TFdHOFNEVzU4SVpKSkF4QnUvaFViWTJMNWtGdWo0VDdWVEpt?=
 =?utf-8?B?TlJZTFNDbVBORHhGSmFQeHNvTHFOWVFodnFQYUgrc3B6V1VZNlNpWnB5WUtO?=
 =?utf-8?B?NWlOUjAzUitEMFh6eDREUzd4WG1uZm0xSkdWa21XbGRPMWs1OW1rQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf62e8d-94fb-4b93-492a-08de8b00f3b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:53.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3rBjqCXV1jlQyNSGYSbJ4+SPBpcOWHcDH2O9kv87E8QKuEU80cOuwjTM20SKLuMU+ayMDIX1x/eBJ2X3WAS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 163 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |   9 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  13 ++
 3 files changed, 185 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 3609d83ac363..62611263a93f 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -379,6 +379,8 @@ static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
 
 static void netc_port_fixed_config(struct netc_port *np)
 {
+	u32 pqnt = 0xffff, qth = 0xff00;
+
 	/* Default IPV and DR setting */
 	netc_port_rmw(np, NETC_PQOSMR, PQOSMR_VS | PQOSMR_VE,
 		      PQOSMR_VS | PQOSMR_VE);
@@ -386,6 +388,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), pqnt);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_TRHESH(0), qth);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -617,6 +628,117 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
+static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
+{
+	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
+}
+
+static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
+{
+	u32 pbpmcr0 = lower_32_bits(mapping);
+	u32 pbpmcr1 = upper_32_bits(mapping);
+
+	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
+	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
+}
+
+static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
+{
+	int bp_per_port = priv->num_bp / priv->info->num_ports;
+	int q, r, num, i, ipv;
+	u32 bp_id;
+
+	if (!bp_per_port) {
+		q = priv->info->num_ports / priv->num_bp;
+		r = priv->info->num_ports % priv->num_bp;
+		num = (q + 1) * r;
+
+		/* Multiple ports share a buffer pool, the mapping relationship
+		 * between ports and buffer pools is as follows:
+		 *
+		 * - For the first 'r' buffer pools, each buffer pool is shared
+		 * by 'q + 1' ports.
+		 * - After that, each buffer pool is share by 'q' ports.
+		 * - All IPVs of a port are mapped to the same buffer pool.
+		 */
+		for (i = 0; i < priv->info->num_ports; i++) {
+			u64 mapping = 0;
+
+			if (i < num)
+				bp_id = i / (q + 1);
+			else
+				bp_id = r + (i - num) / q;
+
+			for (ipv = 0; ipv < NETC_IPV_NUM; ipv++)
+				mapping |= (u64)bp_id << (ipv * 8);
+
+			netc_port_set_pbpmcr(priv->ports[i], mapping);
+		}
+
+		return;
+	}
+
+	q = NETC_IPV_NUM / bp_per_port;
+	r = NETC_IPV_NUM % bp_per_port;
+	num = q + r;
+
+	/* IPV-to–buffer-pool mapping per port:
+	 * Each port is allocated 'bp_per_port' buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first 'num' IPVs share the port's first buffer pool (index
+	 * 'base_id').
+	 * - After that, every 'q' IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * bp_per_port;
+		u64 mapping = 0;
+
+		bp_id = base_id;
+
+		for (ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
+			/* Update the buffer pool index */
+			if (ipv >= num)
+				bp_id = base_id + ((ipv - num) / q) + 1;
+
+			mapping |= (u64)bp_id << (ipv * 8);
+		}
+
+		netc_port_set_pbpmcr(priv->ports[i], mapping);
+	}
+}
+
+static int netc_switch_bpt_default_config(struct netc_switch *priv)
+{
+	/* priv->num_bp is read from register, its value is hardcoded as
+	 * a non-zero value.
+	 */
+	priv->num_bp = netc_get_buffer_pool_num(priv);
+	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
+				      sizeof(struct bpt_cfge_data),
+				      GFP_KERNEL);
+	if (!priv->bpt_list)
+		return -ENOMEM;
+
+	/* Initialize the maximum threshold of each buffer pool entry */
+	for (int i = 0; i < priv->num_bp; i++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
+		int err;
+
+		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
+		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
+		if (err)
+			return err;
+	}
+
+	netc_ipv_to_buffer_pool_mapping(priv);
+
+	return 0;
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -644,6 +766,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1195,6 +1321,41 @@ static void netc_port_set_rmii_mii_mac(struct netc_port *np,
 	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[j];
+		struct bpt_cfge_data old_cfge = *cfge;
+
+		if (tx_pause) {
+			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
+			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
+			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
+						       BPT_FC_CFG_EN_BPFC);
+			cfge->fc_ports = cpu_to_le32(BIT(port));
+		} else {
+			cfge->fc_on_thresh = cpu_to_le16(0);
+			cfge->fc_off_thresh = cpu_to_le16(0);
+			cfge->fccfg_sbpen = 0;
+			cfge->fc_ports = cpu_to_le32(0);
+		}
+
+		if (ntmp_bpt_update_entry(&priv->ntmp, j, cfge))
+			*cfge = old_cfge;
+	}
+}
+
+static void netc_port_set_rx_pause(struct netc_port *np, bool rx_pause)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_PAUSE_IGN,
+			  rx_pause ? 0 : PM_CMD_CFG_PAUSE_IGN);
+}
+
 static void netc_port_mac_rx_enable(struct netc_port *np)
 {
 	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
@@ -1256,6 +1417,8 @@ static void netc_mac_link_up(struct phylink_config *config,
 	    interface == PHY_INTERFACE_MODE_MII)
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_rx_enable(np);
 }
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4b229a71578e..7ebffb136b2f 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -32,6 +32,12 @@
 
 #define NETC_STANDALONE_PVID		0
 
+#define NETC_IPV_NUM			8
+/* MANT = bits 11:4, EXP = bits 3:0, threshold = MANT * 2 ^ EXP */
+#define NETC_BP_THRESH			0x334
+#define NETC_FC_THRESH_ON		0x533
+#define NETC_FC_THRESH_OFF		0x3c3
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -90,6 +96,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+
+	u32 num_bp;
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index c6a0c0a8ff8a..1e1c0d279a21 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -12,6 +12,12 @@
 #define NETC_SWITCH_DEVICE_ID		0xeef2
 
 /* Definition of Switch base registers */
+#define NETC_BPCAPR			0x0008
+#define  BPCAPR_NUM_BP			GENMASK(7, 0)
+
+#define NETC_PBPMCR0			0x0400
+#define NETC_PBPMCR1			0x0404
+
 #define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
 #define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
 #define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
@@ -138,6 +144,7 @@ enum netc_stg_stage {
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
 #define  PM_CMD_CFG_TX_EN		BIT(0)
 #define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
 
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
@@ -145,6 +152,12 @@ enum netc_stg_stage {
 #define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define  PAUSE_QUANTA_PQNT		GENMASK(15, 0)
+
+#define NETC_PM_PAUSE_TRHESH(a)		(0x1064 + (a) * 0x400)
+#define  PAUSE_TRHESH_QTH		GENMASK(15, 0)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1


