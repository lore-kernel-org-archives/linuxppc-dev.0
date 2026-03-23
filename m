Return-Path: <linuxppc-dev+bounces-18582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E59D58CDF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:08:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN581h9wz2ygf;
	Mon, 23 Mar 2026 17:08:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246092;
	cv=pass; b=nB50cwGmRWWIwDEufKn5SmONYkiti5Fuz/Bg/3t5rmjMAP1YYBbpeN2Hy56zm/rvrhFQ8G+MJ2aTYPD6H1ZXv0mu0Oop/j07ImUfanp+AJKFU5x1pukJqKYMJEfi8Ri5yptYiDAVeHSqrEMvZ1yRIEczXVp34sDKejVv1cMYvyNQjbAcmFIVM07h4k3EGFy0CKZt05wqlYgFZQ69oIEPJnqTPNS1h4m2VT2QJuptVUtLVooGKmJsxWEbkLtQb/PcDQo1L4JmyrJ78d1Kc/7HLzMmzjddOntEJFUE9IV+Dt7r1y8PdzAJmQpunWK2JAIPSaA3l2w+KZOuENYxFsL9lQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246092; c=relaxed/relaxed;
	bh=t3Ek1VsMMGh9CjE7y2Cypa8CcAkZeUzs8ImmHJ1TCQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1Lkei06hsPTbwWT8IfTNwsQntItLDyI4vygM41/aNQNduNVQas1MbrvHwUgqes4tZ+Y0gsykDDMnQKfAXY1x35zll7vZtlKqFxwaH12fApCUK8w8Y31L4F6rotEA8XZUK4D2T4GzeYec1DPeY77Y3nL//4GYgrQcT8ViZ5k7cja53nh5rT2k0h0fl5Oa/SXqYu+A7Z+Y+J66Pn4OfGLWYIo0M3ZGY2hcKkKxgcHzzl6bdJm2fdBCxRSCnuI+5Tigo7PmqfLWPXMw2s3OKMIGVM12LwkkwOeNvm0fT29GoQ3ktwcFS7RI/3usUp8NsFhh9YB0tvYCQ0kUN+C+FsbMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=clEtvKQJ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=clEtvKQJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN573HVcz30Cd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:08:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgirzUlrs6LBioIMKi8eo6jETiNyLgU6unTuCs7LW5JsuYyvzKTQJMUfGvgoC55tzXFRJOxAYfL+zOoMHv67TLmIzOUFG0GA4wy29aYpNBRTVujA0SIR+6XVsz4VIbxsmnBWI2yZZ5OE7jNDLqYHHumHEW5/BKIHH4bW9iI/7QFnpcAfl1hZIQwi+n6WczIXeXvdJWfvaLDYXA2itu75zkis+ZRBMyckkOPUxNh1GTmW1pCVYekOlXlHDnyZ+QZGIzYnG6HJ3AbT4tIwHcsdl3UGwqe/CrWAfO6XpMF9amstWEScrVowxC0ff7jno7FeleMw9sCOhtr7lu+Vfr+/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3Ek1VsMMGh9CjE7y2Cypa8CcAkZeUzs8ImmHJ1TCQw=;
 b=hvxRb2JKZRvYm8lY9fTONWwNfTUvAM3QN1NJoM0cAYuDZeJBDJeqo6jE6SMQ6I1XKdGkeHEcgim4qjjFHTwSYsPCWpKNSdiAWijGsr9ZXdAafmyB8ul8nuqoRdM2qazD1cYDkUaQ5kyp9xNsSnbxWWj7uItdJN7VWAFj43i8FOVRuVYzjRzC2v/3Ks6N+Xkk13SA4d+dNohKiB1YoF8AVTpSZQhApjTtCJ62nI6pCZnGShMdL4J55CKDiBaITJ58r0hIdtLKmeO1Ps7VfrgwF2E5b9L3Tcwm/JjXRg/pC3T1cPQtiCNX6vF69RbnnqaHPUi6Qb6b2Ne09tX5gAl2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3Ek1VsMMGh9CjE7y2Cypa8CcAkZeUzs8ImmHJ1TCQw=;
 b=clEtvKQJnnE13v1UfArWlwm9FQTdJyKEDo8/eEXDOkfGD4mN/BVxM1LpGwu8BNNHThBOzykbWZWHUTwv1tNz5jEXcbPaHiSzl/GxiRQblRVz6Xj6DYDGj0rTyP1VMs6sAKhcAy4uRNIRyATr8XdTIkfFmBa2F5a5lbzkQ4FbbF+PmR8VWJCNsMgNfFp/mlhba2WtZSAJf+mTWNtKsyzkvjTkikJ8vkD8e3prSKsc/NdbIDtve755EfxfEvNO3V9FqQBBeLG9Eh7U/RbV6pVv1acfYKt1VChZxmefxjzhq0crhQzm3F3aSTZMHiGQk+VBrRScXCS/OKD/hmOaGHnl8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by VI1PR04MB9882.eurprd04.prod.outlook.com (2603:10a6:800:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:07:44 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:07:45 +0000
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
Subject: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Mon, 23 Mar 2026 14:07:51 +0800
Message-Id: <20260323060752.1157031-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|VI1PR04MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: a18ddba0-bd48-4397-485b-08de88a28070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2zTcZsHNSr2GgmpxB2KAQ566kkiGxunCzuyBOfUBXPSS+odVzNgVwCaRmOqWBOWx1aRNFEaoEc6U5w/oE+gFzGKOja++t2tP22Wn4svgPykSztZYB+9hSm6Yu0SqJVIJRlzd+Vfmsrfo65NWe5tPWnElbxiD0Iib1PSIcgj3tqJgPMfjHe+2IYu8rVPl2Fsf913MjIyVZC0MEK60BRhBm+qMCpmSWz7JXhK96o3W3KOxiOuLRQk+UtGg+JzIDTJYL+YagZAnckS2LCu1dWN4YHld5/6ErLm7vd4fKXok0e4/ucCEbhU/g6H05FdtC1rPhl1bK7Ga7qCfjZGJNIr83EKo0K+kMaW7gbfHSlxq9mpnRG7RlIITLT6Pp0uKOn7zA976CSwruso9W3bk2nZU2Ppe68yicq1vXijFw+g3ARuzYeClQcJ68BMiX10CHAGmHiXOvHnLk2zwvC0J5eXg6EwP3uJBOQm1oEFYjxa8Ab8elCXTHHGiXJ7CPGfiq2C2mgI9Ua4H6LidlcRhpJXy9042EeMgap5WbIc9wp/CnzrneKdNlv7vuVMg1W2cmAWCfMHSJKNmsKrejhVB7F4EkEJ4sMgCvw5yDVweRfPdw6gEeuXznhsUqYz6Pzt79kIqzGBsDFVdjaYBWJ4RpA8A6Cs6rASnWahqtcqM/YxyqFmJPFtFpXxZ1gvftm1oMHIHnHhKC7TvCGuA+EcytQxF5W+sUAHP6KRggmDEVUsVp/LSzCDSyl53hdYNMLQkLInzDlp5eivfC2K5hgTaT4iu/r6jf2zAAMD+VCa2JOZ9N8U8s6LO00K79ffdltOQrhvH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZEemhXOVRlWUVzRnpGYmVxZGMxSFFzUXYvSk51TWdROGdId0V1eVJBa09D?=
 =?utf-8?B?WmRzcEF0WWRKd0pxbjRLZzE3UDA3NUdMNVNnN2k0TUZpUXcwb2ZoOUJFRGVF?=
 =?utf-8?B?UEd0YnRITnI5UFRzK2N2SU9GM2xwOXNnWFFuY214bzVrT0p3MXJvazlNaDB2?=
 =?utf-8?B?VE5ReWg2cWhTT1hnSS9uUFNaNVdrRTZRbXArMG1iT2RTSzZNMUovVzFrelVM?=
 =?utf-8?B?a29ySWxJT3hZUHJQRkRJc2NsUWV6d1JHamhFL3owMUYxZCtHeDJ2OFd0U2ps?=
 =?utf-8?B?WmFaSGRQV2RRcGJMRGRqVm1BWDhtT3FwSE12cGZsSlU3aEJiZHgvaFpCNE1n?=
 =?utf-8?B?TXpSZVRqanpzcko3VWFKNFJEeU1YY3RpS242bTlXUHBTSkE5R0ZTemVGZDE5?=
 =?utf-8?B?S0JJUHVUSWV1VFRiYTJoZWsvblV4TS9OaFZrSGtvKzg3YWhlOEhZdzkvL21r?=
 =?utf-8?B?c0xWQmU5SStQeXlBTTFoQTcyc2JCZjVXbzZjNmEwd1QzaFVFajg1dVZEdjU2?=
 =?utf-8?B?TjhveXJnNzdNNU5aUmZ0eVd2bjVwMnE0REtQRVBxVDJ4VmoxVURrK1FBRDdt?=
 =?utf-8?B?aDJIdTRTOVptMy9VaXN4TjJkaGVmMTFqUzVtMndiSCs5STg5dU1ZUEM3NTFB?=
 =?utf-8?B?Q1hiZFhVZ1NoQWdIek0xNlBId1lxeE4wUEFtMGRLdGJUdWpSSlI4aFBqUnNw?=
 =?utf-8?B?M2ZUNmlrbEJVSzRyaEphdjdzNjRtTllXSUkyWml4aGxRUVYrejEzQXYyUGt2?=
 =?utf-8?B?NG15akp6WnFYaWV3ZjlKb1d2RDI2VXdRRk9MalV0aVRXQS92Rnh0YTRJVncz?=
 =?utf-8?B?MGowSWZmQ0FKTFpOSDFXZ0ZUZDFwQVBVQmhSNit2cHhNaTJ1OXdwd1NBdldn?=
 =?utf-8?B?RXlmWTl4N21wNXZKSDc5Z2NrQWtqYWhiVzBDTzRpdlJYUisrdHdKYVFXcHdt?=
 =?utf-8?B?bXVjaE0yN3VIM0tlUUk1U3VuTzdGekRMSElzZ1g3TmpYT1RUNnRwbE96NTdv?=
 =?utf-8?B?VmhEVkhjZ05NMzdTQUlhVmZOMmFpdHgyWFRuV3EvaHlrUi9MZWdMYSt6LzRN?=
 =?utf-8?B?Z3o5VzVMUGVxYWgrMFFmSEJJbWFWS0pETGlqVXo3N1hkZi9MNGpGcmVIMHNv?=
 =?utf-8?B?K2NacFdIcEEwVmVwTFVIMTVqbW5ROGpsVStOd0ZmSFpCMERjNHhQY3R2T0VF?=
 =?utf-8?B?cmVJUU9lQWpwYXRhTnZBSzBjcmtZK3hGeGR4R0ZIMlZoY1FFZUZZdDMwbFBQ?=
 =?utf-8?B?L1RhTFBZSEhKaVdEUnZaVHFsZ29Ccy8zR0FUR3hVMXpNaENzcWJSRmtYRHhM?=
 =?utf-8?B?b3JWZTY4bnFyWEtCRWo0OWY5VjFnOUlXTDlnRWNKV09icDlQYnJIbjdheXA0?=
 =?utf-8?B?bmdqRU9iU0x0T3p2c2cxbFRWL2ZvaWU1ZkRDUk5VQTVRUlIrYThIbldTRUpM?=
 =?utf-8?B?WDhVdU10RDBHbnR0ZkRadmdZQk9FTFhHT1lCZklJTGVkOFRJTWVwUVR3dy9Y?=
 =?utf-8?B?Wm5vcUdMR3hCaFJmSmVSYUlTc20zMEtoeUMrakZaTUNVZnpIMWlLWWQ4RlBl?=
 =?utf-8?B?clVobG9DZ3RTam1UeUZud0JaQ1pYT2JGb1paK1RYVldLN0JJNWpJZVA2bkNJ?=
 =?utf-8?B?RUUrbFdKTm9kQjluZEhibTIwTFZXc0QvL2dtRS9ieFVRYllXb1pjTm5VcUJ3?=
 =?utf-8?B?VStRMFdRUjdqZ1ZhU0Z3OWJxSkJUOTBML1hXcXhpbUFBWTVER1lDWDJLdnVN?=
 =?utf-8?B?Z0RaSHFzNTdsZy9raTZxQ2tMZFlzVlU2bVV0R253eFBQRXdBRkZ1bVZkL3FD?=
 =?utf-8?B?UlVVcW1kSGI2MDR6VXQ0YUtabzFDUXJSYnc1bHdOaUhwUHJMS01mcWVQcXZQ?=
 =?utf-8?B?ZE1iREJGcTRyRWk2UmFuNkgxNDFRMWpIVi9RNWROZHBEenVOZDhwY284YzVa?=
 =?utf-8?B?Y2RGWW5MQmhKdmtnc3lWYmlmMUN6M3NGY0Y1VDdhWDkvM2g4Y25wamtjMy9Y?=
 =?utf-8?B?bzluYXcyT21VRGJpTDdzbk1qc0pYMU1YOGVKRWZuRDNJM1JYTHpDRDFqSUph?=
 =?utf-8?B?NExUejhpMGZGcjg2RkMvZjNYNDVBaHZ1My9ZQW1LNEhkVm9ZZlNUU0JQWkY5?=
 =?utf-8?B?dm1oeGNFWEMzUi9adHZFNnExUGpmOUJDR1lNQ3hCemJGUmpSVW1DUDRBL2Nw?=
 =?utf-8?B?YzlVYThTWUFLbXc5Nlp2SzZaTmVxRStpS1dCaklMYXozY1o5R3ZPaHdocUp6?=
 =?utf-8?B?STZpbG1wZDJqS21teEtNYnRDZVB2UjZCallvSW4xOGhxTEhHaWVEQklOcVYz?=
 =?utf-8?B?UHp4Z210RDNWNVN2bHdFTkhkam9vTlJhTDZycDJwdnZHdDFPSVFYUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18ddba0-bd48-4397-485b-08de88a28070
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:07:45.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtXbs5mfADazf18eAz+ETOdifKAw5c+4k5LtdCVlWY6t9A0EPY4Cs6mqJatcOK/upZV20/gSgMN7hsKrO5TP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9882

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
 drivers/net/dsa/netc/netc_main.c      | 133 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |   9 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  12 +++
 3 files changed, 154 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 4b331971dd8c..2a7ad39f8bed 100644
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
@@ -617,6 +628,80 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
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
+	int num_port_bp = priv->num_bp / priv->info->num_ports;
+	int q = NETC_IPV_NUM / num_port_bp;
+	int r = NETC_IPV_NUM % num_port_bp;
+	int num = q + r;
+
+	/* IPV-to–buffer-pool mapping per port:
+	 * Each port is allocated 'num_port_bp' buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first 'num' IPVs share the port's first buffer pool (index
+	 * 'base_id').
+	 * - After that, every 'q' IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * num_port_bp;
+		u32 bp_id = base_id;
+		u64 mapping = 0;
+
+		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
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
@@ -644,6 +729,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1224,6 +1313,40 @@ static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
 			  en ? PM_CMD_CFG_HD_FCEN : 0);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge;
+
+		cfge = &priv->bpt_list[j];
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
+		ntmp_bpt_update_entry(&priv->ntmp, j, cfge);
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
@@ -1288,7 +1411,17 @@ static void netc_mac_link_up(struct phylink_config *config,
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 	}
 
+	if (duplex == DUPLEX_HALF) {
+		/* As per 802.3 annex 31B, PAUSE frames are only supported
+		 * when the link is configured for full duplex operation.
+		 */
+		tx_pause = false;
+		rx_pause = false;
+	}
+
 	netc_port_set_hd_flow_control(np, duplex == DUPLEX_HALF);
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
index a2b0c1a712f8..7ef870fbba4d 100644
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
@@ -163,6 +169,12 @@ enum netc_stg_stage {
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


