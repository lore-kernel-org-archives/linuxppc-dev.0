Return-Path: <linuxppc-dev+bounces-20316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C771FF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:49:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dss5W8mz2xtC;
	Thu, 30 Apr 2026 12:49:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517345;
	cv=pass; b=GKDFFrFm6gVXeuqsvg4145V6G8zLfEEej5xHA3IHFmxq6iEhIq6n016hhHt0IzFjNxRCMRjWE6hRMXvjoEi6l4dR7Si/JHkV1oTVN6hOwu+Pki1xFNdrHWXSFqHWm+73lhAM2FW6m9n2ecCEvStGTpx8X35Kzx2ivHo1pBZIXwONqTIc3X0ACnfzHWB4MCAa9iiJ/nJZWPdzI30D4gAxtrMAPmlnKo1+qSN18yofCva0OuSFcAYyC4lHZRdN3FqHkgMyk7AD85J1wY7p5U56eo+CUeMQZTkK4WrDgKQyCE2HSK9b8SJJteik1D7HdmZayx7X3gHZweqvh7qoEv+mcg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517345; c=relaxed/relaxed;
	bh=8q5Rc/9r7bNW7w/2y28HdDjRljbXNKqwL3q1WnDpbXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqynefmOS5vQKMOo675C2LWvQPe8LxO30c8B5cyPejjeeP/EXvpKl9ppQuap/SC0OOvBb1WMRWbyK79nF9IIpE0c6bwVsHrlFph/W67Snj9ovvE44/yL/2sh+3f74P9eNEHtc90VP7gLpsUeG0/1BCag8pfycJ7+rHXnr4ii3HLuOFriH7W4/TbO6bivJQ9F7C5LEId8sq4d/1IkYO4+iAcgNYeaTTgIsJ/t1QCIid8Hgawckapj9MCUR5zk5VU5Z3YVNlFnS18m5UTbjzFoa6K0QPYVExA5hdynJrpZ7EySS2NiJJbzVFTJ5j2Bw+2XICCVsOL5CI41HFrNUlndIA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Rswxa1Cz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Rswxa1Cz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dsr4jPSz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:49:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqVcQMjLgSSVbxMFIejL6D7ZWjJHvSI4jZOfDIEBegkfhrdofUmeGrCLodCRRHTKVWxj/7EbViFGT2lsglNtCsxObuDeEqrdQCuIuC7SJRlbzFOT0jL+iMxY6gYkHNJ4qq6KxhQEVQUdfF4AGvP3GbRn0+PUkhpDlq3PvGnP1w68h3IWxX5HGJtyn92Zrp//P1vVYT5s7Yrxkslwy2+U6l/mf+OsWsc3/7x6pABePSTnxy2QBQlTxKqD+EI3JPzY94spBl+GWA/gChNK9fJQdUH3VIEbff8zUDi1hcCmNqbYBR+eBdior4FN21p/urzGYl14ynlEJ5PfUfjSnZz/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q5Rc/9r7bNW7w/2y28HdDjRljbXNKqwL3q1WnDpbXU=;
 b=R+qJ5kMSHjyopM7juB8wwPVK6Djb0QHR0ruCg5uLY4QtYP0H0zGvoeJFcPLKP0hI4xsrIqE4fVlW2QbJWPp895tve7a4BSdI8ljYbbWVG4xVUejXqZNpKpWCTn560I4y5UfvlFnM9KefV2JoObgWNOR73XyuXITxKhHH7lZUtmVj65UJR1T43iGEKZgypVcjBKkF/kN7ZmZM00Xj71xBsCZdc23wcWzJtOsi8LfCRIg/9veJ1DFmLSECL2Wslgs+qTwsDBm89RtaG3zCLIAltT9ppyQ4jlAfXLaRiDzFgBR0mIcddPmO2pLbrlTZoJ/N26481Icq0SL9XBPp26dwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q5Rc/9r7bNW7w/2y28HdDjRljbXNKqwL3q1WnDpbXU=;
 b=Rswxa1Czjvq+di+HTKI87pIYcrn3htoSa8BbK/UgLDNKiA93fu8FcOEZF2WoFIFvO67oSri2hupp/8JnhlOoQc8r+cHN97K5BHsU3zdotm3l9yxzImCxVKeuiJ1OOpQ6udHpv0wjZx2zdKqM4etxB04MMsH5xDwDV6jMl4VMoqeA4sKGEX8MmQyx8Z+/zmjYl/OLT5FUeVNUd9d/5NKLJSoYsBwY3V4kEP4ap9mHXsEDszE5rrpZdsAMsXBXr5p1Lg2SIWjQri8udE8NfR4r+SGgLDQqXGgYJ0HXAC3jCA5suvgtKB1OFKSzNfNGS+XWxWmniqJsMUQMzX3J8fu9kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:49:01 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:49:01 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 13/15] net: dsa: netc: initialize buffer pool table and implement flow-control
Date: Thu, 30 Apr 2026 10:49:43 +0800
Message-Id: <20260430024945.3413973-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: e59d4263-c888-488e-895d-08dea66308d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o3y+bw0qLwq/TVFRW8uVRJo0V8He8krYpTnrhOZ5zsv1Yxv/O2E9ZE1Uje2WNPbOPrTJFA3OM9PsuI8p+MSdhByX7fKJJCK9x16l9YmCXXW16VzvUwsSp16G4P071BYzaK0h4VOwN01YKGaJj2VftcopZsUONmZk+rwgJfIQgSASkTpqXdIE3k1HrA1dprruVrVNVxe8zxK36UPw5sqLlX3jHjlyhHZAEv+FjBCSHoZevPJYyGFcGifeti8V3te0XVoXP0gE4Hy/PUmKWOCPdf3Yu9f8gm/c4zAJy4mx5UKKAbwznHhMbmHXPhLsdwd354yrEq/O4A8eSYSgJjraOLJcZUSpFTKn/hN9D77gWIDB2RF7feKKHp+Ttv810Vmx0medAPdNaO3LCNRtMHJcygxs+6UXwfYica59y+CtGUxyV1jdwharkTOnZ2E7+uMsL8hf2GhpEuDR8Aipz3l62LBJqVF1OM/BTAbeAAYUottqRClSpoQQLF/wVbh2RME3mQnUwZtAw3UFtFC8N4Qw3+nj4SOskNGKKmQfUrKZCEXO80jqb7Rez8kLd2iAByVtUt8ql/v2mWyJ3qmdWLNcb3Kf68oUJ0FISsJK3cX3fQkBO10StWiyRRw1CYJXd9Sn3BW0IuvkpKw4BOQ7UjSN84cOuHlmcS6jm4/VSMDdACEvKkSLC7OEwS964EDe9CSApf9yFVMNU/9plx7fVywa68T0UXhHVy0LEzyd8b+MXcFd7/jrql+QaUXSayJ+loRsPnmgoulUcTkcQmuFZ4ot8uhgobKWhCZF1YpLEtscklwk0pVonoWJa5BFJDk2+JnV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME5FWnpkS2xrN3JwL3dBeXR1cFBVaDRoNlEyRE4waFR6anhCUXgvVzlMeXdy?=
 =?utf-8?B?TlhqZGdScGVpUjkwcHcrYmNaYy9kNUdnaGRoNXNBbVVKaGYreUVFYWZ4VmxT?=
 =?utf-8?B?NlhUUm1iOVdYcDVxTitsN0NydmpES1RXWVZSRzRURSt4M0hHM2FRYk1DMENr?=
 =?utf-8?B?SllEZWREZC9xV2tNMm1lUkxzVVJEK2YrSS9aeTFzT0NnR0VsR0NsSVA4by9p?=
 =?utf-8?B?TzcrVStvVk9obEFzTnNpMlJjeTEyeVhoUll2RHRwdGRsNnBUK0Foc3pNbjFS?=
 =?utf-8?B?emVEWVUvMDR0eldXS1ViQjhGMnNaT0M1NndSMzlhTUE5VDZjTzkzMGp6NkJo?=
 =?utf-8?B?d1U5ZUxLeWJPM3pGb1h3YzJkQUNHUmZnZzJzV1ZFK1o3TjhRVmZaSzFBQUdV?=
 =?utf-8?B?bHYwemZEOU9PY1pONGZlUlRBMEkrTTFKWFBGUW56RlFYR3pkZFZFS1JLMkVX?=
 =?utf-8?B?d05vMzg1UXZybzhFcUMxWGZVeGp2VHJDVjFLaVpYQmp0SnBsVy9RQkZHYzNz?=
 =?utf-8?B?SHhxd3JvUWcvd015TENRZTRJMGVWUERPL1hQOHVkd09UbnJTaHh6bmlKbkJw?=
 =?utf-8?B?UGQ2d2tRU0N6eXo1dm9RL2tiYjNEalgyaWwvc3FaUzV1c1gybDVGVnRNWE5B?=
 =?utf-8?B?cXRaWS9vTXRqdjJkYlk3dWNycUtENXVab2dxZXQ0bGJBcU1mNStNSGpZYy9R?=
 =?utf-8?B?QUw4QjZqK3NlM1FJZ3RFRDhYdVY2eTBUY2U0VmYzQ2lnRHg0WVprdFI0VzJT?=
 =?utf-8?B?WHo3ajE5QjBHcXZicGFSSWN0WkN1dUJmNHBPNFRHL1Y1YmJSaFBGbzNCTmdr?=
 =?utf-8?B?T0d5UENLRTFBZTQ1bWhUY1RDNHhMNC9aUXFLYU1FbURUVVIwSjB0ZWprbnZ1?=
 =?utf-8?B?UmJBdEE2dVhvdXZFZDBlcXJlYWljL0xXeFZyQmVGRGRZQlZOTkMxay9JUEpI?=
 =?utf-8?B?dXRKa2orODRDcmdYOUZWRXQzcjAwanNKUHFwU3k5Sm15d1hkSXFlcFoxcG9H?=
 =?utf-8?B?YmVlVktMNU5mRzV3VVNRUWFyN2xCRkFaMmVKZUJPZkhTYjR5Zm9sNzYyYjFC?=
 =?utf-8?B?UFNPemFVQkNHZkplTWtKVVYxYXp3WWVjS2ZUWURkYzROSkExK29sSW9MbWVS?=
 =?utf-8?B?MENkR2x4WHEyc2VxS1BQZkhWaGFzL0JndVBVNFVNTXVFUU5kTklHandKSGVO?=
 =?utf-8?B?M0hIcHRpRGQ0SzBORjBiQ2E0MWEralpyaUt0RjRGdmc4NVB6eDB5U2RXZys0?=
 =?utf-8?B?SyttQ0JaVVcreXRzd2Z6b0IyREd6aExJMHIvZmNmdHRTb0lOOGVzZlB6Y3Qw?=
 =?utf-8?B?WWJiL2tWUklLaHdmSVRHRTFoU2lNL1JmVTJHTytTVUlWdTVoNVZxRUg5bkVR?=
 =?utf-8?B?YUxhdWMwUkxOb0FuZkk3NisxU0x0WUY2K1NFTFlBR2lETlZvdUZNZ0pHMmJZ?=
 =?utf-8?B?aDBQY3A5akY3VkNIS2JNSUZaZTlIWG5jT3grM0t0Y05FMzJCMy9lQVgxZmx2?=
 =?utf-8?B?eWFRTDFVb3FMdFNFcUt2Q1RiMmZTMmNSUzVtUzgxeTRKWGhWNmZKRS84NkpZ?=
 =?utf-8?B?Z0REOTZzZHpYY2hCbnh3dFFJSnV4ZDZ3WWplM0IxbGFRd2VvQThYRys4eEkx?=
 =?utf-8?B?MXZoWEJ2dG5VMXlvRHlpZWV3bzRkMjdwaXVxd2l6a0czdEZHMVFieUs1bm4z?=
 =?utf-8?B?a2xnUE9oZnBZU0daOFZLWUlxMWs1Wm9ieTIwc3hmOVFhVHBwcXBtbmd2QmY3?=
 =?utf-8?B?ZGlpbzlFTHpHWmNxR3dOMVpxVm85M29uZnRlYVpydnFZMlliZDQrVFlkMFZn?=
 =?utf-8?B?ZXhZTzlZYkREbE1CUDI2eGJnRDlFUlVXWHQxZlJETEpvZWVrdEthS0E0NU85?=
 =?utf-8?B?dndkWVpCRHZSSnpFVG1YbjFSVjQ4NUNHMldvb2grUjNEU0FybldJVFduRHVy?=
 =?utf-8?B?S21Sc0tqbkhGNXB1SUFZalJna2R3eS9oVmtrVlFhZE9Ib05JSzkxOTVmL3RH?=
 =?utf-8?B?VXVWQy9aODMyei8wNEpCVUNSVEo3cUNrSldjNmJCdDZQQm9CS1V3WHRUY0Q1?=
 =?utf-8?B?Qk52bG5XanEvVkYxMmVQTXRKV2N5VGVwWDh0UlIzS1BrNEw2b0czSUJKcEpv?=
 =?utf-8?B?TzR0NUhqMHhRQ0FtRVJOZUY2Mkc2VStDUjFmWDU2alRkWDI5NG9ZVnU2VXJz?=
 =?utf-8?B?TjlUaDk0elJxL0lOSHdwSXpvVHE4Q0dEWEhueGwxT25SbkxuNW52YUNMR1dt?=
 =?utf-8?B?T0x3c3FvbHdlaUJRRGI0ejJQMTFZS0FiQnQxcUY4Zm4zYUc3VE1MdGNVTnp5?=
 =?utf-8?Q?e7/JZMx5/ZSCe8jnew?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59d4263-c888-488e-895d-08dea66308d4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:49:01.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaUPgM4BgwZZ6E/UkR5ZzZ0Wpjrgg4FibSbGKIfOx4CSxMCcf+TfUzwODR+ctxNn6a6H8jL7T7K4hOIPLb3x6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

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
 drivers/net/dsa/netc/netc_main.c      | 128 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |   2 +-
 drivers/net/dsa/netc/netc_switch.h    |  19 ++++
 drivers/net/dsa/netc/netc_switch_hw.h |  10 ++
 4 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 7f1ab1fbb6fb..fd02a943824d 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -208,6 +208,9 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 
 	val = netc_base_rd(regs, NETC_FDBHTCAPR);
 	priv->num_fdb_gmac = FIELD_GET(FDBHTCAPR_NUM_GMAC, val);
+
+	val = netc_base_rd(regs, NETC_BPCAPR);
+	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
 static int netc_init_all_ports(struct netc_switch *priv)
@@ -398,6 +401,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_THRESH(0), NETC_PAUSE_THRESH);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -617,6 +629,77 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
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
+	int q = NETC_IPV_NUM / bp_per_port;
+	int r = NETC_IPV_NUM % bp_per_port;
+	int num = q + r;
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
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * bp_per_port;
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
+	if (priv->num_bp < priv->info->num_ports)
+		return -EINVAL;
+
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
@@ -646,6 +729,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1201,6 +1288,45 @@ static void netc_port_set_rmii_mii_mac(struct netc_port *np,
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
+		if (ntmp_bpt_update_entry(&priv->ntmp, j, cfge)) {
+			*cfge = old_cfge;
+			dev_warn(priv->dev,
+				 "Failed to %s TX pause of buffer pool %d (swp%d)\n",
+				 tx_pause ? "enable" : "disable", j, port);
+		}
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
 	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
@@ -1302,6 +1428,8 @@ static void netc_mac_link_up(struct phylink_config *config,
 	    interface == PHY_INTERFACE_MODE_MII)
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
 }
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index bb4f92d238cb..34aeb6fceb3c 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -14,7 +14,7 @@ struct netc_switch_platform {
 static void imx94_switch_phylink_get_caps(int port,
 					  struct phylink_config *config)
 {
-	config->mac_capabilities = MAC_1000FD;
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_1000FD;
 
 	switch (port) {
 	case 0 ... 1:
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 3efe37fca390..9fea3d4287a3 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -27,11 +27,27 @@
 
 #define NETC_TC_NUM			8
 #define NETC_CBDR_NUM			2
+#define NETC_IPV_NUM			8
 
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
 
+/* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
+ * Unit: Memory words (average of 20 bytes each)
+ * NETC_BP_THRESH = 0x334, MANT = 0x33, EXP = 4. Threshold: 816 words
+ * NETC_FC_THRESH_ON = 0x533, MANT = 0x53, EXP = 3. Threshold: 664 words
+ * NETC_FC_THRESH_OFF = 0x3c3, MANT = 0x3c, EXP = 3. Threshold: 480 words
+ */
+#define NETC_BP_THRESH			0x334
+#define NETC_FC_THRESH_ON		0x533
+#define NETC_FC_THRESH_OFF		0x3c3
+
+/* PAUSE quanta: 0xFFFF = 65535 quanta (each quanta = 512 bit times) */
+#define NETC_PAUSE_QUANTA		0xFFFF
+/* PAUSE refresh threshold: send refresh when timer reaches this value */
+#define NETC_PAUSE_THRESH		0xFF00
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -93,6 +109,9 @@ struct netc_switch {
 
 	/* Switch hardware capabilities */
 	u32 num_fdb_gmac;
+	u32 num_bp;
+
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index b04e9866d72a..caf5977c5100 100644
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
@@ -141,6 +147,7 @@ enum netc_stg_stage {
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
 #define  PM_CMD_CFG_TX_EN		BIT(0)
 #define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
 
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
@@ -149,6 +156,9 @@ enum netc_stg_stage {
 #define  PM_IEVENT_TX_EMPTY		BIT(5)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define NETC_PM_PAUSE_THRESH(a)		(0x1064 + (a) * 0x400)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1


