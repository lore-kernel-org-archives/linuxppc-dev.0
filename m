Return-Path: <linuxppc-dev+bounces-24565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26AEC44515
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:01:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h40xF4JPqz2xKh;
	Tue, 21 Jul 2026 12:01:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784599297;
	cv=pass; b=lGY0opwsr1S0NhfGMNmggGr9LCYp4F7cNy0XLqGRQUEaK+yKogE9K5gLK0UP8LhZwwkcfGL0m0KZlCQuTRHA0X1781zTOVLYiCFoFyzGwdP9YHQquF1fQYRBxdIdjQjAyx1xuIWArRKXiyfy0M4LdZ1+23fTIhFunVkuy+1FUtPoifQQUy7heNIGBsVIAf6Gez/JrNHnonczGyJTXU1mgpF5a5miX84pkDzESx5OKBsyxspUWVqN42/dnBWKPxX9sYt7cLAbV/D2uNc6e/aWuOPmbbs5/v6CXSfbV2kME5HIjtLKUqkiNgPzySYxSbU+DCXqYX4RwudCvvaHMelAWA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784599297; c=relaxed/relaxed;
	bh=YjH+el5z1xmWRtNVU1C8S1Fciw0M30ZKLTPyXeRG5rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDpxypmpIGRvP/+pKnCaIsd54KZbQaprzZDM2nrzTLhO0D6Q87/9Kg3wakQGrjRXDs7O/xq8QDmGnl4foxNzG/sPoDFZ80oCDqzWKemZWRbu+XGYsMAvrx27/6VIsaq7fcBCu9HRI3EFbr6XUPm9mO2Cgjy8rJTNlq2PDkNBo6AvICQDUcQmiSFdrK4D7rNWNdrZophmgPiTijNn2seFlj3dxrv71AyNgk/53/350O6U1ybICkpTLPuUL4CjcgCJ/Qs7Mx+15g728AoY7FCvNEIfcynb4ZU0HoTr75rZWs4qWVtbAGKfw8lkmupktgf376uKjScK93GMZ8gj6ehilQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V6qLY2H+; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V6qLY2H+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h40xC3HwVz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 12:01:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4ZE8izu5svbdXNgBzcGWHgN/p4Tvc+lA4z5W5WLYkWn0gf/lcS3PjFisalpPVqY5txBwrHmLO3rBrDi+BgIiAieOeXSaqY1hZ5dqh7DQ6XTI3uieoRWQ2hOlYmi3vmp4Vs0CDGHurFNhL7bUmULpOUuq4TS4UTnaUDDfOSWu10pcpsSlBNYv7j8MRcfj6Jt/Kkc6Kbc5+KhSEgwmWKaN/WpLtbXb4GvSVca6X/h0ThzxJwLlrEMxtHuO9I06Cbv/qdx9K6z124IIERflS9e0zv2jdeE1NothKR+Hk2w6HnL+SNLXPg5crFeSOt0bAEt4jPxLCjMQrnBd/dVOV7FXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjH+el5z1xmWRtNVU1C8S1Fciw0M30ZKLTPyXeRG5rE=;
 b=mQH/ZOoDvhmw705bHGPvfImuME3DC5exrYpu7ZBvdCOjw8PQtbaOyEJa8l6u0VwKd6yVJzD+a37jGOjZa95DVjkJRnQKmJuVIldTncRJDXT6SdJPRKDNulwtEsMIWH8bx7GKuNhV2iyvXTmfZsOIFiaq5kvD3eVr5ZtJgKnKjAVxQKBUmueU1LibMfNfqEsPRI48Ot+yGvLB5pcxccA9aluykPEFpMGsEupnTrhYemmfHD6XY8DUqyL7jqLu3caYj85TtkDHQ11C8ikA/6D7daJrVG+P9WjAQo49v6VWcTmGPnIwsvDs5FyvIE7Xjrco2dOmw3uD97EkKeDnGVUtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjH+el5z1xmWRtNVU1C8S1Fciw0M30ZKLTPyXeRG5rE=;
 b=V6qLY2H+KGwfO9AqAxfJC4OjqDQXx6gmxqBvHfD+cV6gGoSgiUlP3NUVPsmJ66dUzG5GexQXIe5nqiYc1EM/NbpunrkYg6i9Sgptxyq3nA/SG45oh+RoV9uWyJ+ayr1XMKUraOUcS4+ANXL2gT4EVSeSU6Bf1vY39227kufC/e8rN+u6y7oWhro1s9EuKpN+TxrB/YAIyiV/SqwuxiCWjVrxUf0YYuY4FiirflNI0qSvWiOjO5ETR2X+OV1QiTCxW40FcqXJBCM1zfmm5D50IwfYvoiRWvlPYck/WI3sCNNUPYW1fRmL1UF72L9/D8+y9z/Zw5HrwCYAVwdxWE4NxQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB8078.eurprd04.prod.outlook.com
 (2603:10a6:102:1c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:01:06 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 02:01:06 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: Joe Damato <joe@dama.to>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RESEND v4 net-next 13/14] net: enetc: use
 alloc_etherdev_mqs() to create netdev for VF driver
Thread-Topic: [PATCH RESEND v4 net-next 13/14] net: enetc: use
 alloc_etherdev_mqs() to create netdev for VF driver
Thread-Index: AQHdF+1U0b1XT98MNEmlt9MrKMcSSLZ2rJwAgACNGPA=
Date: Tue, 21 Jul 2026 02:01:06 +0000
Message-ID:
 <GV2PR04MB117390E882DC4BB22CC3E808288C22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-14-wei.fang@oss.nxp.com>
 <al5cgs6CqVKsy/gh@devvm20253.cco0.facebook.com>
In-Reply-To: <al5cgs6CqVKsy/gh@devvm20253.cco0.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB8078:EE_
x-ms-office365-filtering-correlation-id: 8f3dde7e-f181-42c0-311f-08dee6cbed24
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|4143699003|22082099003|18002099003|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 /goJ4NjGL2TqFP8JqC9DUXpsa69ekjkydAelhh5H3cehST7jnVEDxIaRDHOBH/ZTST45ONRrM8m562KVZfFEoNli4+W1ve/XeKDnLe7P7MMfetLY6i85pnvy0op3x4DWqZ2vzse12MfWvvnPC1eoBSvfAkQgYVIMi6sr1yfMwV3YAU8eMsxLrZEyYW36jSAMawmQ2rsILPV09HwHQ1xa1MyiFUschyLTx+JPm72liQrvVgTn09kuXjqonBH/eMssh0fM481HHuCDxk6+a4EYV2SPNAay68P0s/OD/nb7Jjw2LKGiOmGXANlot3I5uSm9T+QM7VKa78hcsNusy4MVgpjI5ZNmxBWYsKIsAO88xJ7EmpkMbwmtx9GrfUm1cYcnkkX0WYSL7pAq135SNZmMeP5SkJ0OeMP6eGCwjeKDTjYDww3LwlCUNTzHEcP6v6ht0GzYF+ZrRhUPpDZNQ1TBrpOxWbawjjPl9rPLf5MptwxpHd3jIUitEYmZAOzlQp4mb7o1g95vsyC3TWZauWm7Ar7kyGtqcypA2ulHzqV+ekXbcLJMcgXhoQHLfW74RTOCNtoOoYWm0kile6YBAZZjzlKgk7+Y5/VP7vxaYo/4ltxPdKI/BXs/ZiHBPEJpsclMy+w+eB20nw8K2v+8nBlVd5nyl9F9rzjkVJu2orRvY/CRaHRIQWLFcI/vx6WWevWDqDnJf7F0DXpMs6rCi8bNfJZaomKUNNfIXNQqYE2FJT4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(4143699003)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWs2MmthMUNmeVpFdk8zV3UzNG1NUkpXNm1ScDF3SytoaUJNVnA1ckJEb2FL?=
 =?utf-8?B?UlNTOWtJc1dETjhtTEpJaEVnTGNXSXJ2anJtTG9OVU5vVGtDU3BTRnpYMWls?=
 =?utf-8?B?R1B3UTJITnlqTTZtYklLNTNlaEwrQ0xuaktBR1pBVmkraTN2Z1R2aDduanhi?=
 =?utf-8?B?cGwwQSt0RDVrTjBMM0laM3RNb0lnT0gralY3SFhwOHRJcVRBcWoxc3pwVnRm?=
 =?utf-8?B?aFVjd0k1Y3NkM21mY0I4ZEQwMUloQlovQXFodHhJSkdydWlpS1VUSmVEZ2ZB?=
 =?utf-8?B?aUU1OCtqQUNEMHI5VEVKeXo5M0pHbjVBb2grc3B4aS9GQzN6WGxGaWRRZTV4?=
 =?utf-8?B?SXlCaDZXR0M5SExFWHhMa050RHRYcEpXZEFjVWN5YUp2NnJtTFBHUlN6VjhG?=
 =?utf-8?B?S2tGUlRHME54Wm5BcXEyYlUyVDNhTFZTdFhENEh5bHFKemp2N1dlVXF1QTY4?=
 =?utf-8?B?T0FNT0E1Q3p5Y3JjU1RxOUNtNmE2a2tmL2NQcXpzem44SmpZQlV1UFRPVFc2?=
 =?utf-8?B?YkFLRUdCZzVuK1NWRXpXTTJqZkw1NGpmVW5OK0VmRDlxRFFSMWRBMGlrYzJa?=
 =?utf-8?B?M3djZ3J3blYzSDhRVTRRY3RHS1FJemFpSDY3T0wvMi9JRXpEQjAwTDBDaWVW?=
 =?utf-8?B?RTdmYUoxNHkrK0psTnB2TVJ5ZjVEbTZia1d4aHBGNDVrbUt0dFk3SEw1ZnlM?=
 =?utf-8?B?b255aE1pMjZVOWF3eE8vei9EdCt1RWw3RTk0S3pVYkljVXRSeFdnL1RyN3hq?=
 =?utf-8?B?V2hCVFd6L3I3TkdUaTI3K3RTWVdVZFFNRXI3ZkRZOTd6RENmOFVMWHNrVGNP?=
 =?utf-8?B?U1BXc21lc3lJTGVXc2w0TnJMYXFKRWlDQld6cStzR2xZeVNtN2RLdXNpejVO?=
 =?utf-8?B?YzR4a0FhQUFDK291Y1EyNWZHK3R4R0drNXlWU3hub0RDbjMzeUhBZjQ4dWFQ?=
 =?utf-8?B?Y210QnkyR08yd2tDdVhaelM1UHlUTlEyTVdtNGpETFJYT2k4U05oTzFMN2Fv?=
 =?utf-8?B?UWg5M09CTXVjSEdOOG5ocnpjZjh3K2FIRzBCRTJFT25DNnF6V0tabDZjZ1kx?=
 =?utf-8?B?MENTTlRqRDUzWGpRMktseHFyMkNEQzVyQ3NZUHVJL3dXWVZYM3l1emVrNDhl?=
 =?utf-8?B?em5Edy9xNCtEczgxdSs2WDNMZEF0aEdadExrWE9qQVpiYXdXM2dDZ3hnTmpO?=
 =?utf-8?B?eDBsWEZUTWxtK01kcjRueC9pSFJaMjUwVDYvTzgwam1jdXYyV1dZZlBmRlpN?=
 =?utf-8?B?UTl2QysyMFdOTHQ0REVhSG1pUjhldVdsYTJwU1RTZ2NwV1YrWXE5VUNSb3Yz?=
 =?utf-8?B?SUtmOVExY0orSzhDOWlaT0JBUm5VTlQ5RDBWOWRjQklSeDZlclFzNVBJZmV5?=
 =?utf-8?B?ZzlqRXh6TzZ5OFBDSG9wZ2lXWCtVYWsvRGJvRVlMTDBWWWl4c0RyeGpBdzgw?=
 =?utf-8?B?RFVGMHQxcFEwdDdwU0dnTEJPNVdDOUhCTG1zVy9Ibk90MFU2UTBFSE1MOGw5?=
 =?utf-8?B?TEsvOFhaOEMzcWx2cjl6a3F1L2ZFeWtZL01tbkNUeldORmZCODZkUXNDSWxk?=
 =?utf-8?B?akhxUlZPc1YwWVNMNTNkcmNZRXQrV24ycnYzZjhsQU0wcHpOZVpuaGxSMHNF?=
 =?utf-8?B?UlN0NFRpejhTRFhuYVVEYXFuSHMyKzJEdkFKNkdva2pibzc2bnhiOS9pcUxu?=
 =?utf-8?B?LzhtWVNJWlBQOFlWOGxyb1pJVkIyNjE4Mzd5cVdtdjI2NkIvbHdBcTQyaXBY?=
 =?utf-8?B?K3pGMEZkMkpaR3R6d2tkbWtUQ05WeTJ3NlgrYXRTckQ4QklGaHdNMEtvNm5a?=
 =?utf-8?B?UUNTaWJmR0J1WnpmWkd0RWtML3ZxcVZQcUwrUmE5QzFMV0hwdGRHU2FVR1dI?=
 =?utf-8?B?SlV6SDc3OVA1Mkx6Qm9SUkplbE1kbi9vUnRQdm9ldmNyWHVDVngycFdZTW4w?=
 =?utf-8?B?RHRYbXVJaHU0V3J1NVEwMDd2Q2N3UjlCdzNkMTJ2amVCU0NKZmNCV1AzRk9o?=
 =?utf-8?B?NjhuWG5kMDRVaG5RZFVhQ21MYUoxRkZySU5HaVRybGdjTk5JTERKYStWMXBL?=
 =?utf-8?B?cGRmZ1poWm10TVJHK3pxbkpueDZDcUNpR3c4UkxNMHBXN3dmWU1JalVJM09B?=
 =?utf-8?B?RlpaVWl2M0FBUFVpVzBwdW5oNzZGb1JyQTlCTkFWWnVvTFd0akNKMXcwRndG?=
 =?utf-8?B?VWlHUitOSFpNd3RRVUZhYUcrUE1kRysvNWl4WENtcjhDckdPaHdjSTNqbXlS?=
 =?utf-8?B?bTc5VjNJSjJGZ2Iza2ZhZmpnNjllSEh1aytKRnh1SEpKRllBN0tkcTF4ampB?=
 =?utf-8?Q?rVVuJmk3muXFmV+2Do?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3dde7e-f181-42c0-311f-08dee6cbed24
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 02:01:06.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtX31DqEMWg+pjJkoZaQE5bncUpmF9t2fddo0CW/FeoMNQUwftNDmzjFnY1f3KtvfgUC1xaZ6F8vVvoIEIvOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8078

PiBPbiBNb24sIEp1bCAyMCwgMjAyNiBhdCAwOTo0MzoxNUFNICswODAwLCB3ZWkuZmFuZ0Bvc3Mu
bnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4g
Pg0KPiA+IFRoZSBWRiBkcml2ZXIgdXNlcyBhbGxvY19ldGhlcmRldl9tcSgpIHdpdGggRU5FVENf
TUFYX05VTV9UWFFTIGFzIHRoZQ0KPiA+IHF1ZXVlIGNvdW50LCB3aGljaCBmb3JjZXMgdGhlIFRY
IGFuZCBSWCBxdWV1ZSBjb3VudHMgdG8gYmUgZXF1YWwgYW5kDQo+ID4gdXNlcyBhIGNvbXBpbGUt
dGltZSBjb25zdGFudCByYXRoZXIgdGhhbiB0aGUgYWN0dWFsIGhhcmR3YXJlIGNhcGFiaWxpdHku
DQo+ID4NCj4gPiBBZnRlciBlbmV0Y19nZXRfc2lfY2FwcygpIGlzIGNhbGxlZCwgc2ktPm51bV90
eF9yaW5ncyBhbmQNCj4gPiBzaS0+bnVtX3J4X3JpbmdzIHJlZmxlY3QgdGhlIGFjdHVhbCBudW1i
ZXIgb2YgcmluZ3MgYXNzaWduZWQgdG8gdGhlIFZGDQo+ID4gYnkgdGhlIFBGLiBGb3IgdGhlIEVO
RVRDIFZGIG9uIExTMTAyOEEgYW5kIHRoZSB1cGNvbWluZyBpLk1YOTUvOTQsIHRoZWlyDQo+ID4g
U29DcyBoYXZlIG5vIG1vcmUgdGhhbiA2IENQVXMsIGFuZCB0aGUgbnVtYmVyIG9mIFRYL1JYIHJp
bmdzIGFsbG9jYXRlZA0KPiA+IHRvIHRoZSBWRiBpcyBsZXNzIHRoYW4gOC4NCj4gPg0KPiA+IFRo
ZXJlZm9yZSwgc3dpdGNoIHRvIGFsbG9jX2V0aGVyZGV2X21xcygpIHNvIHRoYXQgdGhlIFRYIGFu
ZCBSWCBxdWV1ZQ0KPiA+IGNvdW50cyBhcmUgc2V0IGluZGVwZW5kZW50bHksIGVhY2ggY2FwcGVk
IGF0IEVORVRDX01BWF9OVU1fVFhRUywgYmFzZWQNCj4gPiBvbiB0aGUgYWN0dWFsIG51bWJlciBv
ZiByaW5ncyBhc3NpZ25lZCB0byB0aGUgVkYgYnkgdGhlIFBGLg0KPiA+DQo+ID4gTm90ZSB0aGF0
IGlmIGZ1dHVyZSBTb0NzIGhhdmUgbW9yZSB0aGFuIDYgQ1BVcyBhbmQgbW9yZSB0aGFuIDYgUlgg
cmluZ3MNCj4gPiBhbGxvY2F0ZWQgdG8gVkZzLCB0aGUgc2l6ZSBvZiB0aGUgaW50X3ZlY3RvciBh
cnJheSBpbiBzdHJ1Y3QNCj4gPiBlbmV0Y19uZGV2X3ByaXYgd2lsbCBuZWVkIHRvIGJlIG1vZGlm
aWVkLiBTaW1pbGFybHksIGlmIG1vcmUgdGhhbiA4IFRYDQo+ID4gcmluZ3MgYXJlIGFsbG9jYXRl
ZCB0byBlYWNoIGludF92ZWN0b3IsIEVORVRDX01BWF9OVU1fVFhRUyB3aWxsIGFsc28NCj4gPiBu
ZWVkIHRvIGJlIG1vZGlmaWVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9lbmV0Yy9lbmV0Y192Zi5jIHwgOSArKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y192Zi5jDQo+IGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3ZmLmMNCj4gPiBpbmRleCA5Y2Ri
MGE0ZDZiYWYuLjdkY2I0YTAyNDZmNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNfdmYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y192Zi5jDQo+ID4gQEAgLTMxNyw3ICszMTcsMTQg
QEAgc3RhdGljIGludCBlbmV0Y192Zl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPg0K
PiA+ICAgICAgIGVuZXRjX2dldF9zaV9jYXBzKHNpKTsNCj4gPg0KPiA+IC0gICAgIG5kZXYgPSBh
bGxvY19ldGhlcmRldl9tcShzaXplb2YoKnByaXYpLCBFTkVUQ19NQVhfTlVNX1RYUVMpOw0KPiA+
ICsgICAgIC8qIEN1cnJlbnRseSwgdGhlIHN1cHBvcnRlZCBTb0NzIGhhdmUgYSBtYXggb2YgNiBD
UFVzIGFuZCB0aGUgVkZzDQo+ID4gKyAgICAgICogaGF2ZSBsZXNzIHRoYW4gNiBSWC9UWCByaW5n
cy4gU28gbm8gaXNzdWVzIGZvciB0aGVzZSBzdXBwb3J0ZWQNCj4gPiArICAgICAgKiBTb0NzLCBi
dXQgZm9yIGZ1dHVyZSBTb0NzIHdoaWNoIGhhdmUgbW9yZSBDUFVzIG9yIG1vcmUgVFgvUlgNCj4g
PiArICAgICAgKiByaW5ncywgYWxsIHRoZSByZWxhdGVkIGxvZ2ljIG5lZWRzIHRvIGJlIGltcHJv
dmVkLg0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAgIG5kZXYgPSBhbGxvY19ldGhlcmRldl9tcXMo
c2l6ZW9mKCpwcml2KSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pbihz
aS0+bnVtX3R4X3JpbmdzLA0KPiBFTkVUQ19NQVhfTlVNX1RYUVMpLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWluKHNpLT5udW1fcnhfcmluZ3MsDQo+IEVORVRDX01BWF9O
VU1fVFhRUykpOw0KPiANCj4gQ29kZSBsb29rcyByaWdodCwgYnV0IGxvb2tzIGFsbW9zdCBsaWtl
IGEgdHlwby4gSSBndWVzcyBpdCB3b3VsZCByZWFkIG5pY2VyIGlmDQo+IEVORVRDX01BWF9OVU1f
UlhRUyBleGlzdGVkPw0KDQpZZXMsIEVORVRDX01BWF9OVU1fUlhRUyBpcyBjbGVhcmVyLiBIb3dl
dmVyLCBFTkVUQ19NQVhfTlVNX1JYUVMNCmRvZXMgbm90IGV4aXN0OyBpbiBmYWN0LCB0aGVpciB2
YWx1ZXMg4oCL4oCLYXJlIGVxdWFsLCBhbmQgd2UgcGxhbiB0byByZW1vdmUNCkVORVRDX01BWF9O
VU1fVFhRUyBsYXRlciwgc28gYSBuZXcgbWFjcm8gRU5FVENfTUFYX05VTV9SWFFTDQp3YXMgbm90
IGFkZGVkIGluIHRoaXMgcGF0Y2guDQoNCj4gDQo+IFRoYXQgc2FpZDoNCj4gDQo+IFJldmlld2Vk
LWJ5OiBKb2UgRGFtYXRvIDxqb2VAZGFtYS50bz4NCg==

