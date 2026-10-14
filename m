Return-Path: <linuxppc-dev+bounces-29457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE9CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4MC94KyYz2yYd;
	Wed, 14 Oct 2026 17:45:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791960309;
	cv=pass; b=KUcDs8Q9jzdaAHG7sZbjBDjPetshSSr7yQ7iAvAs5baENADOLhggrDArvphA9tVz1BIKQuEmrVmJzQbfPYIKMjn8Up45yaJE4609W0REtEv+eZ5CWVz0c9RzJYRcq4I5Th6lefvqohpWWdbI62nD0KKeHPYaOXwLEaJFWNGXuafGCqusM9FSVjz2TXef2mDrz+ApAi4ZRM9N2Nr3jh5qWTTRDUIosYUh8qvnjTNvkwpUR79GNamY8Cx8/7B1DYZoXtTrscm6gjC+cgiOclss2ewUwCfP0jBJIl/HgWAfxelTGZLlvezVVN92IaLeJmgO+LwKnA1axxjSqsjzTX5u9g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791960309; c=relaxed/relaxed;
	bh=U8FaHXNjE2dvjyI8AcGXEW+a6z7H2X+4z00AMrWeejI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzdYR8cftOUTDLBr2hGjV3spNyIVmAz9JHf2IxWELC0/87uTBtzI5HcUUo6xjtJioqeAWc/Vjv7JIIbtulB1u4R8DuhJpjiBs8fpUgchxRkJ/h+zHO5dTQnKxh4Du58jUyUV7qaKIPkAtuyGdwfPA6lZEf8UDX6HW/g+xo2MYQ9qo+ZK6/9Sr80Hri2wpF548/pUgsqI4SARWhF05Up6wKcOnF7gr77Mr4czqUOH70e5PNkaoEmSmGDgTd3ho3/jpu9qgcKSA+SD0pvXVT9SEGDJb2+nZM7eR/QsDivzwgoqWTLJbtrIlZOMTjio5ZWQpOQgSFCtntuWSyhRfgrneQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=D6aOLDvA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=D6aOLDvA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4MC80Ck9z2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 17:45:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPXB8iOmNJMBMwkL88jDGMJ7tvtEQZtYbwagdTGDcy1ZpdfgZ2JvDF15Spr68OFyBEq/IHWrE+uDHAHZsjaP61Nndqi7AnZFGFqCEMbJXSK21p498pVnKt8V0dTcINMrHQMOHE/3NUMfnXyIT0CKYlX/4BA47s+Rw73/1GtMIhKNWvp0tWzpeBsBfhtaR0boLPTEKVnxJ/APiJHELHzmJT8BejpjFxqVAQxSS7RvTaxOXcWAhxtQrx0QC303ilEpJssTEwQC2uzwIfQi/ZDp5QvbreCmBU86aH9B4vDDfgxpvzSAS100ePQsOudeHeRWjGR2fFg/ipu0YmBzSsZBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8FaHXNjE2dvjyI8AcGXEW+a6z7H2X+4z00AMrWeejI=;
 b=g7VbwqqjYLOC+UJYhCmn2SJdp/yjhv2VZTOhKGKTvfZfNn2kQd9Hsgt1crzVj+ykJ42b0TsgJf2A7nLCMFmGXlEJKnr0jZqzD2K0Y1GhjqRav73h47fH42Zy6ehDuGEiREq5sq7jn0HeNF7ursqWOAzq0HiiaKwST3XUxrhPbIcggJZOmCQ8m3LJvo1ClMmA4rjtTzKpsWkTLnGqLUiJ6NmzCaOS9VOGbJp+FMFWvLXdplWtjdvT5hbAl9jfQWEXp5h8W+4veFYN6V029TqKhrQ45x55dijJbYZJeypbrmQbnPvQMzSQA5coXybDO9FXNo7z0dfuTR91/yqX8nqkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8FaHXNjE2dvjyI8AcGXEW+a6z7H2X+4z00AMrWeejI=;
 b=D6aOLDvAsVsp+Im3aRVWrCV4+1BvAiuTG2/pXMCBRTCWX0wEChJq+Bc+JIEBPfJp4NNjtfjmYS6XCokaZUq7Gr2zbnSP2XPcB/R6c0G1Y7sGkXbpqaXG4f3mrPMfFMq0nmTrRv1fI53h2rqbf3eHNWNGwh4lFCAsmrsafBRdrc98ME9fSZWgyv6op0z9snKtrZrXZmL8zNvqdS8/vPH5gFCD+oMGRhKZSNbDcyrGXtFPaC+f0DO5p7AeumZspA/Bo+ZqHnGupDlQDzhmfx2aYi3xsNYH5gqbKTFSs6LSAvkMBRPqQsxRIAqKUHirxCboXgeKkIEtlWehmYMUFx+4mg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by DB8PR04MB7147.eurprd04.prod.outlook.com (2603:10a6:10:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 06:44:41 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 06:44:41 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>, Wei Fang
	<wei.fang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Topic: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Index: AQHdWi/K+bT0PSxuE0yauhMzx/ZLsbb7TwGAgAFLl/A=
Date: Wed, 14 Oct 2026 06:44:41 +0000
Message-ID:
 <AS4PR04MB93388C7E684F9542DF8CF06A889D2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261012095924.1129312-5-wei.fang@oss.nxp.com>
 <179188907149.434549.9657555602480791517@kernel.org>
In-Reply-To: <179188907149.434549.9657555602480791517@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|DB8PR04MB7147:EE_
x-ms-office365-filtering-correlation-id: 258ce09e-ac1b-451d-092f-08df29bea036
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|10067099003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 QeayFZFB+LXzR+sGpq+XojYymQ2+md1sY3khFOayj813V6BHP+1iwJonr9RFF39xPk2V8C3EnmyiA7XSpEn7pHbuHM7TDQSApqxyEH7//0fY7gTAgEkzqGzZwhEJLegOrVaypYOGzcsZa8fybwFGGzBucIApW+YqzJuxoInySu0/LVW8EhplxnOxLyDr9XmEW0H6jIV2Gxlrr4cc1wackJMbSHw9IFIveriEoElzV1iL/fy4vTikbKPBGu9zOxA52bUNra7LfdG22VJXJ7BX46q8EmJf4ju9NcHnj4uNR/09l0A5GOWmb+KWYru0VJngSDIx85AHb36CJB9gL6iuMH+2cKmp6M111pQZeGEJS6rqxKP7+KWKYnKBjTASEJ2oDVYJzkrsbZUHCES4wYD9fzOWhhIasSRdtj63npcCI1ZDJgbmFzapuNxCA5YIJuUMyKjad4n9sAE8tUg/dGSnIBX/1ZwgCjbobncEV9dDVqZzg4wtJqRpesmDNheM+1lLO5uMHRenc4+u+2C39ZTLlzgnT5hu4iQKh8pWtlLXK6LWy6qRIWt2gF4M0ZMvHkx8axMrnDqoXx3x5VzAehTLZLTpVcz8bzPMYHUcqlQPUWji6m4x2jcqy1hlMtYHbnNN5NK5pZSdGamnVBdvekoPQX2rTaPwX8oCpcZ0aUWzwiD8eqDfTi1i9A39OQOzZ1d9hH3OzZNXImVDm8J6Omj6+wUDR+ablmD5o3k/c52/uJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWxWeWsxenNQaGYvYmQzUW9vTUVLOW9HbHF6MXV1cXhua2hJdWp6QVNXdEtZ?=
 =?utf-8?B?ZXN6VXVhR3N5enN4ajFnZWpKUFdlNlc1My8rUHhkem8wdk4vdWt2OFNnTzJu?=
 =?utf-8?B?VkxoVTI1MFhLNXVLaW5ldnhJTHhxeDlmMlBLL1RIOHZDazlJTkdjajBHNENh?=
 =?utf-8?B?S0FUYzNnb1NRZlcrMXh1a1JNK1ltY2JTanIzNml2emlDSDZQRXp2UllsNUVz?=
 =?utf-8?B?T2Y2c3ZGcFpXOXZEbU4xZS80MU9TVzg3ZnlxRHVWaC8yWlBuTm5RYVdIR3gr?=
 =?utf-8?B?WkF4S1J6WnBLbjRQM0dKVktuaWp0T0NIb01PYWVETnZNcmhueGJUOVh4Zm9X?=
 =?utf-8?B?RHNvNTRQaks3TGdFRHBaRy9SZVhPNkt5UFJwTFVLS2I0bjJrMFJ2dUVQMXV2?=
 =?utf-8?B?Sm5QT2ZRTHdiR2ZvWEJvaitWUGxIZW1xL0ltbFVwN3VBMlZ3ZDE4dlJiNUUy?=
 =?utf-8?B?OHMyclhqVytWTEVvM2Nmamg5TFNXQlM2VzVERjlaZEZiaG1LdjRiTC9YZmla?=
 =?utf-8?B?THdiclZSSkRLdDlvazZ6RFMyVFByWVdEd2l5am1HUG9UeWQ3ODFQNHBKVGxn?=
 =?utf-8?B?Rms3L1hoZzNWM0FqYjhxWUpscFNKeWJNRm5GYjhHNnd1bUxCVUxQNHE3dEtR?=
 =?utf-8?B?ZGpyUzd1Q09UdVFvMnVqSFFzczlhWXJVa0VtMlk0eWlLNXJGcVE3d2k3L2N2?=
 =?utf-8?B?bnEzOU9HTUdEcm1IbFZTVGdHcm1lMUdUT1ZpYVlBaWFrVFoxcHpKL0U5RlNW?=
 =?utf-8?B?Q3ZvM0ozelpWUWxZb295cVZEOVFWY01mVVhScXNrekk0Z2pKbUJ5RDU4bS9T?=
 =?utf-8?B?ZVl6ZURtY2pndFJMeWpNdUhxVTB0RTJ0Ni9HVFVlek8relUwTHFiOUtqYks0?=
 =?utf-8?B?TFVjUTNLTC91dFJ0ZnFwUkxSNXRTb1RnSGJSdjljWkh4WjF4bjVzeE1Wa1Fu?=
 =?utf-8?B?SGxKbG5UUXVvZkh0NXI3eUdwWWRwODhlbGU1MmRKUzNMQllLdTlDUzhrQkli?=
 =?utf-8?B?bDNDWHFab1l2T2ptMVdBd0R0bGdvZllYbDBTQjZMMmhsT0lTM0RDRFlFT2xi?=
 =?utf-8?B?VEw0ajU5WjdmZzlla1dvMUtseTFSZm92MmZHNWFjOThWZjI2TU5vZ05NRG9J?=
 =?utf-8?B?NjZvUVhSMmZRdEFsNkdydU9HMWVwZHZHNG1uQ2h1alBEVmVVRG9iWHVRSytS?=
 =?utf-8?B?OThCc3hiTHJ0bkd1cW1zUWQ2NWRiVVBpcHdscTFBVzEvbGZRdHFCRlkzM1Rm?=
 =?utf-8?B?MzhvQmZkM1cvYXNyWUdWR3djc09JZzJlTHR4MU5McmdUNVR2QWpxQ2lER3VD?=
 =?utf-8?B?NlB2K0NYSCt0WGZpbUJVcnM1MGVPMTVOcVFpRGdnVEVFQzB3aGFHOEVWeEs1?=
 =?utf-8?B?OVQ2a0t4RHlvR2xHVVQ5NmlVS0NCa1NPbnY3YjVCd3dkNk1qcUQ3RmNyWVps?=
 =?utf-8?B?Sk01Z3lWeVlUY3R3aUNBWndrejhFR2NtSXZVcGFkRnM2Q1UvelhuV2VRa3Zk?=
 =?utf-8?B?T2RvTFQyVktMOTFXNnBtc0hjSHJEdE8zSnA1NEsvR1VyRWg4a28zYTZ6MzhB?=
 =?utf-8?B?VTZHbitsZ1RRUjJiaXRXZnZZOFJ4TGtNcTdiTkZDU0dZbGFHUitSUFlVeHdv?=
 =?utf-8?B?MVYvSWJxUm9PeHFUaDNuQ244K3oxSGdkM09TSVVLT2NwdlN2TFoyRmNNeW5r?=
 =?utf-8?B?cHNQd1RoRHVFenQ5NWZTUWVqQS9NTnhaYURYTDF4U1dxZkNHWlkwT3NEY1E2?=
 =?utf-8?B?ZERZS3VGU25FU3hxODNtMEJ4aDVJVEFscjdzVVRwcHdML2wzMmZHakhsSkdL?=
 =?utf-8?B?aUhsUHN1bndFbU11bTRYeSthZHBxeTRWWlBjaGI2REFieU96ZWJMSEliNjVM?=
 =?utf-8?B?OWtkbDlHU0tDZ21DNnExSVVvbTFub2s0MGQxN1JOUzlvZ0NldElNTXUxU1VC?=
 =?utf-8?B?UUhyY3UweEYzbGkxdVhaQnVvb0tKcGJrcmpnTElYcXljajJSM2xLN0tHdVFj?=
 =?utf-8?B?NlRIOHZsM1Z6S0ZjMHhZbTdkUVBKRDB4NFRvVmdva3FPdXBYbkQ2WHhnWDgv?=
 =?utf-8?B?WHQ2eXRtVVhGSGRqQ291M0ErcFA3a01wckRqLzlMd01YVERiSitwUkt5d0xY?=
 =?utf-8?B?bWphZHI2TDlHNmNpcUFmQ1BzWDRGRnE3R0dGU0kwZWdudzJkd2dTV1JmdzFW?=
 =?utf-8?B?N2xpN3FFVDNCM1NUaGdkYWd4VzFZZUZHQ0o0aXN2SXhmblEzdkZKMFBSQTJW?=
 =?utf-8?B?aGhDRkRqKzRvNitCWnIzdFNQQ2czMXdiVjBodWk1cWYvWmEzbWNSUnVkNnF1?=
 =?utf-8?Q?9rOBgvdXIILR0UmJzN?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258ce09e-ac1b-451d-092f-08df29bea036
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 06:44:41.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8XDU82cod/oR1mbrYpQhQdv5I+SCy7G3EnDtQI1SQg1/BW2XUdsUoYMFOGKInA3QRp05E/9fE/osE4nsFypcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7147

DQoNCkJlc3QgUmVnYXJkcywNCldlaSBGYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogbmV0ZGV2LWJvdCtzYXNoaWtvQGtlcm5lbC5vcmcgPG5ldGRldi1ib3Qrc2Fz
aGlrb0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI25bm0MTDmnIgxM+aXpSAxODo1OA0KPiBUbzog
V2VpIEZhbmcgKE9TUykgPHdlaS5mYW5nQG9zcy5ueHAuY29tPg0KPiBDYzogQ2xhcmsgV2FuZyA8
eGlhb25pbmcud2FuZ0BueHAuY29tPjsgYW5kcmV3QGx1bm4uY2g7DQo+IG9sdGVhbnZAZ21haWwu
Y29tOyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1h
emV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGhv
cm1zQGtlcm5lbC5vcmc7IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgbGludXN3QGtlcm5lbC5v
cmc7IFdlaSBGYW5nDQo+IDx3ZWkuZmFuZ0BueHAuY29tPjsgaW14QGxpc3RzLmxpbnV4LmRldjsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IG5ldC1uZXh0IDQvOV0gbmV0
OiBkc2E6IG5ldGM6IHRpZSBzZXR1cCByZXNvdXJjZXMgYW5kDQo+IHJlc2V0IHRvIERTQSBzZXR1
cC90ZWFyZG93bg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlr
byBBSSByZXZpZXcgZm91bmQgMyBwb3RlbnRpYWwNCj4gaXNzdWUocykgdG8gY29uc2lkZXIuDQo+
IA0KPiBDcml0aWNhbDogMCDCtyBIaWdoOiAxIMK3IE1lZGl1bTogMiDCtyBMb3c6IDANCj4gDQo+
IElmIHlvdSBiZWxpZXZlIG5vbmUgb2YgdGhlIGlzc3VlcyBhcmUgbGVnaXRpbWF0ZSwgcGxlYXNl
IHJlcGx5IHRvIGVhY2gNCj4gaXNzdWUgb2YgTWVkaXVtIHNldmVyaXR5IG9yIGhpZ2hlciBhbmQg
ZXhwbGFpbiB3aHkgdGhlIEFJIGlzIHdyb25nLg0KPiBJZiBhbnkgb2YgdGhlbSBhcmUgbGVnaXRp
bWF0ZSBhbmQgeW91IHBsYW4gdG8gcmVzcGluLCBwbGVhc2UgbGV0IHBhdGNod29yaw0KPiBrbm93
IGJ5IGluY2x1ZGluZyAicHctYm90OiBjciIgYXMgYSBzZXBhcmF0ZSBsaW5lIGF0IHRoZSBlbmQg
b2YgeW91ciByZXBseQ0KPiAob25lIHN1Y2ggcmVwbHkgcGVyIHNlcmllcyBpcyBlbm91Z2gpLg0K
PiANCj4gLSBbSGlnaF0gbmV0Y19zZXR1cCgpIG5vdyBjYWxscyBwY2lfcmVzZXRfZnVuY3Rpb24o
QS0+cGRldikgd2hlbmV2ZXINCj4gICBBLT5pbl9wcm9iZSBpcyBmYWxzZS4NCj4gLSBbTWVkaXVt
XSBwcml2LT5pbl9wcm9iZSBpcyBhIHBsYWluIGJvb2wuDQo+IC0gW01lZGl1bV0gTW92aW5nIHRo
ZSBpbml0aWFsIHJlc2V0IGZyb20gYmVmb3JlIHBjaW1fZW5hYmxlX2RldmljZSgpIGludG8NCj4g
ICBuZXRjX3NldHVwKCkgbWVhbnMgcGNpX3NldF9tYXN0ZXIoKSAobmV0Y19zd2l0Y2hfcGNpX2lu
aXQoKSwgbGluZeKApg0KDQpJIGFncmVlIHdpdGggdGhlIGlzc3VlcyByZXBvcnRlZCBieSBzYXNo
aWtvIGFuZCB3aWxsIGZpeCB0aGVtIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCi0tDQpwdy1ib3Q6
IGNyDQoNCg==

